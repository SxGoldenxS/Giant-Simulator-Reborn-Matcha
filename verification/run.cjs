const fs = require('fs');
const path = require('path');
const { lua, lauxlib, lualib, to_luastring, to_jsstring } = require('fengari');
const state = lauxlib.luaL_newstate();
lualib.luaL_openlibs(state);
const root = path.join(__dirname, '..');
for (const file of ['matcha.lua', 'giant-reborn-rem-ui.lua']) {
  const code = fs.readFileSync(path.join(root, file), 'utf8');
  const status = lauxlib.luaL_loadbuffer(state, to_luastring(code), null, to_luastring('@' + file));
  if (status !== lua.LUA_OK) throw new Error(to_jsstring(lua.lua_tostring(state, -1)));
  lua.lua_pop(state, 1);
}
lua.lua_pushstring(state, to_luastring(fs.readFileSync(path.join(root, 'matcha.lua'), 'utf8')));
lua.lua_setglobal(state, to_luastring('PORT_SOURCE'));
const harness = fs.readFileSync(path.join(__dirname, 'contract.lua'), 'utf8');
let status = lauxlib.luaL_loadbuffer(state, to_luastring(harness), null, to_luastring('@contract.lua'));
if (status === lua.LUA_OK) status = lua.lua_pcall(state, 0, 0, 0);
if (status !== lua.LUA_OK) throw new Error(to_jsstring(lua.lua_tostring(state, -1)));
