-- Football Black Sheep: minimal Supabase setup
-- Run in Supabase Dashboard -> SQL Editor.
create table if not exists public.game_rooms (
  id text primary key check (id ~ '^[A-Z0-9]{5}$'),
  data jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.game_rooms enable row level security;

drop policy if exists "authenticated can read game rooms" on public.game_rooms;
drop policy if exists "authenticated can create game rooms" on public.game_rooms;
drop policy if exists "authenticated can update game rooms" on public.game_rooms;
drop policy if exists "authenticated can delete game rooms" on public.game_rooms;
create policy "authenticated can read game rooms" on public.game_rooms for select to authenticated using (true);
create policy "authenticated can create game rooms" on public.game_rooms for insert to authenticated with check (true);
create policy "authenticated can update game rooms" on public.game_rooms for update to authenticated using (true) with check (true);
create policy "authenticated can delete game rooms" on public.game_rooms for delete to authenticated using (true);

-- Enable Realtime notifications for room changes.
do $$
begin
  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = 'game_rooms'
  ) then
    alter publication supabase_realtime add table public.game_rooms;
  end if;
end $$;
