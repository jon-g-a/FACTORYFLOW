-- ================================================
-- FACTORYFLOW — Schema para Supabase
-- Ejecuta esto en: Supabase > SQL Editor > New Query
-- ================================================

-- 1. DEPARTAMENTOS
create table if not exists departments (
  id uuid primary key default gen_random_uuid(),
  name text not null unique,
  color text not null default '#6B7280',
  created_at timestamptz default now()
);

-- 2. PERSONAS
create table if not exists people (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  dept text not null,
  created_at timestamptz default now()
);

-- 3. TAREAS
create table if not exists tasks (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text default '',
  departments text[] default '{}',   -- array de nombres de depto
  responsible text[] default '{}',   -- array de nombres de persona
  priority text not null default 'media' check (priority in ('alta','media','baja')),
  due_date date not null,
  column_key text not null default 'hoy' check (column_key in ('hoy','manana','semana','atrasadas')),
  completed boolean default false,
  completed_at timestamptz,
  attachments jsonb default '[]',
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- 4. COMENTARIOS
create table if not exists comments (
  id uuid primary key default gen_random_uuid(),
  task_id uuid references tasks(id) on delete cascade,
  author text not null default 'Administrador',
  text text not null,
  created_at timestamptz default now()
);

-- 5. HISTORIAL
create table if not exists history (
  id uuid primary key default gen_random_uuid(),
  action text not null,
  detail text not null,
  created_at timestamptz default now()
);

-- ── TRIGGER: actualiza updated_at en tareas ──
create or replace function update_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

drop trigger if exists tasks_updated_at on tasks;
create trigger tasks_updated_at
  before update on tasks
  for each row execute function update_updated_at();

-- ── DATOS DE EJEMPLO ──
insert into departments (name, color) values
  ('Producción',    '#E07A2F'),
  ('Calidad',       '#7C3AED'),
  ('Mantenimiento', '#0891B2'),
  ('Logística',     '#059669'),
  ('Compras',       '#D97706'),
  ('Ingeniería',    '#4F46E5'),
  ('Almacén',       '#DB2777'),
  ('Seguridad',     '#DC2626'),
  ('Administración','#6B7280')
on conflict (name) do nothing;

insert into people (name, dept) values
  ('Carlos Méndez',    'Producción'),
  ('Ana Rodríguez',    'Calidad'),
  ('Miguel Torres',    'Mantenimiento'),
  ('Laura Sánchez',    'Logística'),
  ('Pedro Jiménez',    'Compras'),
  ('Sofía Vargas',     'Ingeniería'),
  ('Diego Ramírez',    'Almacén'),
  ('María López',      'Seguridad'),
  ('Roberto Díaz',     'Administración'),
  ('Elena Castillo',   'Producción'),
  ('Javier Ruiz',      'Mantenimiento'),
  ('Patricia Morales', 'Calidad');

-- ── ACCESO PÚBLICO (Row Level Security desactivado para uso interno) ──
-- Si quieres que la app funcione sin autenticación:
alter table departments enable row level security;
alter table people       enable row level security;
alter table tasks        enable row level security;
alter table comments     enable row level security;
alter table history      enable row level security;

create policy "public_all" on departments for all using (true) with check (true);
create policy "public_all" on people       for all using (true) with check (true);
create policy "public_all" on tasks        for all using (true) with check (true);
create policy "public_all" on comments     for all using (true) with check (true);
create policy "public_all" on history      for all using (true) with check (true);
