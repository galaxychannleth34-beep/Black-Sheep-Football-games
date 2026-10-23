FOOTBALL BLACK SHEEP — SUPABASE MIGRATION (v18)

What changed
- Replaced Firebase SDK setup with Supabase JS v2.
- Kept the existing game UI, four modes, room codes and game logic.
- Added a compatibility adapter so existing room operations use Supabase table public.game_rooms (JSONB).
- Added supabase_setup.sql for the database and Realtime setup.

Required setup before the site can connect
1. Create a Supabase project at https://supabase.com/.
2. In Project Settings / API, copy the Project URL and the publishable key (or legacy anon key). NEVER use the service_role/secret key in browser code.
3. In Authentication -> Sign In / Providers, enable Anonymous sign-ins.
4. In SQL Editor, run supabase_setup.sql.
5. Open index.html and replace:
   SUPABASE_URL = "https://yflamkngzsdxwqqbataw.supabase.co"
   SUPABASE_ANON_KEY = "ใส่ Publishable Key ที่ได้รับแล้ว"
6. Deploy the folder Football_Black_Sheep_NextGen_UI to Netlify; index.html must be at the publish root.

Security note
The included policies allow any authenticated anonymous player to read/update/delete room rows. This is a permissive starter setup for getting multiplayer working and is NOT hardened against cheating or malicious users. Do not store secrets in this table. A production version should move critical game actions to server-side functions/RPCs and validate host/player permissions server-side.

Important technical note
The adapter emulates the subset of Firebase Realtime Database operations used by the current game. Its read-modify-write operations are not fully atomic under simultaneous writes, unlike Firebase transactions. After confirming connection and basic room flow, the next hardening step should move multi-player mutations to PostgreSQL RPC functions to avoid race conditions.


Version 20 update: accent-insensitive player-name matching (e.g. nazario matches Nazario/Nazario with diacritics) and player-name autocomplete suggestions after 3 characters in player answer fields. Existing Supabase setup is preserved.
