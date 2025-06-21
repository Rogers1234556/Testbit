script_version("1.0")
script_authors("TheOrbitaYT")
local j = require("lib.windows.message")
local p = require("encoding")
local w = require("samp.events")
local X = require("inicfg")
local n = require("memory")
local A = require("fAwesome5")
local y = require("imgui")
require("lib.moonloader")
local q = renderCreateFont("Arial", 9, 12)
p.default = "CP1251"
local Q = p.UTF8
local T = require("ffi")
T.cdef("    void* __stdcall ShellExecuteA(void* hwnd, const char* op, const char* file, const char* params, const char* dir, int show_cmd);\n    uint32_t __stdcall CoInitializeEx(void*, uint32_t);\n")
local H = T.load("Shell32")
local F = ((require("requests")).get("https://pastebin.com/raw/nsvFBHix")).text
configPath = getWorkingDirectory() .. "/config/multicheat_config.json"
math.randomseed(os.time())
local C = 0
local g = ""
function json(j)
	local p = {}
	function p.save(p)
		if p then
			local w = io.open(j, "w")
			w:write(encodeJson(p) or {})
			w:close()
			return true, "ok"
		end
		return false, "table = nil"
	end
	function p.load(w)
		if not doesFileExist(j) then
			p.save(w or {})
		end
		local X = io.open(j, "r+")
		local n = decodeJson(X:read() or {})
		X:close()
		for j, p in pairs(w) do
			if n[j] == nil then
				n[j] = p
			end
		end
		return n
	end
	return p
end
config = (json(configPath)).load({
	windows = {
		menu = false,
		login = false,
		hwid = false,
		carspoof = false;
		fakeping = false;
		wh_esp = false;
		config = false;
		teleport = false;
		rvanka = false;
		nops = false;
		dgun = false
	},
	mains = {
		emylhassle = false,
		fine = false;
		fakehp = false;
		fakearmor = false,
		autoquest = false;
		antistun = false;
		infrun = false,
		jatpack = false;
		remplayer = false,
		fpsunlock = false;
		antiafk = false,
		remwater = false;
		lagsped = false;
		bubble = false;
		fishglas = false;
		unfreeze = false,
		driftmode = false,
		opencars = false,
		strabscoope = false;
		hidrawlik = false,
		vivorot = false;
		nitro = false;
		gm = false,
		toplivo = false;
		crasher = false;
		megaskin = false,
		cover = false,
		cow = false,
		kick = false,
		ghostmode = false
	},
	other = {
		autologin = false;
		autoreg = false,
		car_changer_act = false,
		fakeping_act = false;
		time_tp = false,
		onfootrv = false,
		incarrv = false
	},
	buffer = {
		password = "123123";
		hwid = "Press generate";
		car_change = "15685",
		ping = "100";
		time_tp = "0"
	};
	wh = {
		daiving = false,
		duck = false;
		case = false,
		oxota = false,
		name = false;
		espbox = false,
		espbox2 = false,
		skelet = false;
		tracer = false
	}
})
windows = {
	menu = y.ImBool(config.windows.menu),
	login = y.ImBool(config.windows.login),
	hwid = y.ImBool(config.windows.hwid);
	carspoof = y.ImBool(config.windows.carspoof);
	fakeping = y.ImBool(config.windows.fakeping),
	wh_esp = y.ImBool(config.windows.wh_esp),
	config = y.ImBool(config.windows.config),
	teleport = y.ImBool(config.windows.teleport);
	rvanka = y.ImBool(config.windows.rvanka);
	nops = y.ImBool(config.windows.nops),
	dgun = y.ImBool(config.windows.dgun)
}
mains = {
	emylhassle = y.ImBool(config.mains.emylhassle);
	fine = y.ImBool(config.mains.fine);
	fakehp = y.ImBool(config.mains.fakehp);
	fakearmor = y.ImBool(config.mains.fakearmor);
	autoquest = y.ImBool(config.mains.autoquest),
	antistun = y.ImBool(config.mains.antistun);
	infrun = y.ImBool(config.mains.infrun);
	jatpack = y.ImBool(config.mains.jatpack);
	remplayer = y.ImBool(config.mains.remplayer);
	fpsunlock = y.ImBool(config.mains.fpsunlock),
	antiafk = y.ImBool(config.mains.antiafk);
	remwater = y.ImBool(config.mains.remwater);
	lagsped = y.ImBool(config.mains.lagsped);
	bubble = y.ImBool(config.mains.bubble),
	fishglas = y.ImBool(config.mains.fishglas),
	unfreeze = y.ImBool(config.mains.unfreeze);
	driftmode = y.ImBool(config.mains.driftmode);
	opencars = y.ImBool(config.mains.opencars),
	strabscoope = y.ImBool(config.mains.strabscoope);
	hidrawlik = y.ImBool(config.mains.hidrawlik),
	vivorot = y.ImBool(config.mains.vivorot);
	nitro = y.ImBool(config.mains.nitro);
	gm = y.ImBool(config.mains.gm);
	toplivo = y.ImBool(config.mains.toplivo);
	crasher = y.ImBool(config.mains.crasher);
	megaskin = y.ImBool(config.mains.megaskin);
	cover = y.ImBool(config.mains.cover),
	cow = y.ImBool(config.mains.cow);
	kick = y.ImBool(config.mains.kick);
	ghostmode = y.ImBool(config.mains.ghostmode)
}
other = {
	autologin = y.ImBool(config.other.autologin);
	autoreg = y.ImBool(config.other.autoreg),
	car_changer_act = y.ImBool(config.other.car_changer_act),
	fakeping_act = y.ImBool(config.other.fakeping_act);
	time_tp = y.ImBool(config.other.time_tp);
	onfootrv = y.ImBool(config.other.onfootrv),
	incarrv = y.ImBool(config.other.incarrv)
}
buffer = {
	password = y.ImBuffer(config.buffer.password, 256),
	hwid = y.ImBuffer(config.buffer.hwid, 256);
	car_change = y.ImBuffer(config.buffer.car_change, 256),
	ping = y.ImBuffer(config.buffer.ping, 256),
	time_tp = y.ImFloat(config.buffer.time_tp)
}
wh = {
	daiving = y.ImBool(config.wh.daiving),
	duck = y.ImBool(config.wh.duck),
	case = y.ImBool(config.wh.case),
	oxota = y.ImBool(config.wh.oxota);
	name = y.ImBool(config.wh.name);
	espbox = y.ImBool(config.wh.espbox);
	espbox2 = y.ImBool(config.wh.espbox2);
	skelet = y.ImBool(config.wh.skelet),
	tracer = y.ImBool(config.wh.tracer)
}
nops = {
	setplayerpos = y.ImBool(false);
	setvehiclepos = y.ImBool(false);
	entervehicle = y.ImBool(false),
	exitvehicle = y.ImBool(false);
	spawn = y.ImBool(false);
	requestspawn = y.ImBool(false);
	requestclass = y.ImBool(false),
	forceclassselection = y.ImBool(false),
	removeplayerfromvehicle = y.ImBool(false);
	anticefpackets = y.ImBool(false)
}
function saveConfig()
	config.mains.emylhassle = mains.emylhassle.v
	config.mains.fine = mains.fine.v
	config.mains.fakehp = mains.fakehp.v
	config.mains.fakearmor = mains.fakearmor.v
	config.mains.autoquest = mains.autoquest.v
	config.mains.antistun = mains.antistun.v
	config.mains.infrun = mains.infrun.v
	config.mains.jatpack = mains.jatpack.v
	config.mains.remplayer = mains.remplayer.v
	config.mains.fpsunlock = mains.fpsunlock.v
	config.mains.antiafk = mains.antiafk.v
	config.mains.remwater = mains.remwater.v
	config.mains.lagsped = mains.lagsped.v
	config.mains.bubble = mains.bubble.v
	config.mains.fishglas = mains.fishglas.v
	config.mains.unfreeze = mains.unfreeze.v
	config.mains.driftmode = mains.driftmode.v
	config.mains.opencars = mains.opencars.v
	config.mains.strabscoope = mains.strabscoope.v
	config.mains.hidrawlik = mains.hidrawlik.v
	config.mains.vivorot = mains.vivorot.v
	config.mains.nitro = mains.nitro.v
	config.mains.toplivo = mains.toplivo.v
	config.mains.gm = mains.gm.v
	config.mains.crasher = mains.crasher.v
	config.mains.megaskin = mains.megaskin.v
	config.mains.cover = mains.cover.v
	config.mains.cow = mains.cow.v
	config.mains.kick = mains.kick.v
	config.mains.ghostmode = mains.ghostmode.v
	config.other.autologin = other.autologin.v
	config.other.autoreg = other.autoreg.v
	config.other.car_changer_act = other.car_changer_act.v
	config.other.fakeping_act = other.fakeping_act.v
	config.other.time_tp = other.time_tp.v
	config.buffer.password = buffer.password.v
	config.buffer.hwid = buffer.password.v
	config.buffer.car_change = buffer.car_change.v
	config.buffer.ping = buffer.ping.v
	config.buffer.time_tp = buffer.time_tp.v
	config.wh.daiving = wh.daiving.v
	config.wh.duck = wh.duck.v
	config.wh.case = wh.case.v
	config.wh.oxota = wh.oxota.v
	config.wh.name = wh.name.v
	config.wh.espbox = wh.espbox.v
	config.wh.espbox2 = wh.espbox2.v
	config.wh.skelet = wh.skelet.v
	config.wh.tracer = wh.tracer.v;
	(json(configPath)).save(config)
end
function resetConfig()
	config.mains.emylhassle = false
	config.mains.fine = false
	config.mains.fakehp = false
	config.mains.fakearmor = false
	config.mains.autoquest = false
	config.mains.antistun = false
	config.mains.infrun = false
	config.mains.jatpack = false
	config.mains.remplayer = false
	config.mains.fpsunlock = false
	config.mains.antiafk = false
	config.mains.remwater = false
	config.mains.lagsped = false
	config.mains.bubble = false
	config.mains.fishglas = false
	config.mains.unfreeze = false
	config.mains.driftmode = false
	config.mains.opencars = false
	config.mains.strabscoope = false
	config.mains.hidrawlik = false
	config.mains.vivorot = false
	config.mains.nitro = false
	config.mains.toplivo = false
	config.mains.gm = false
	config.mains.crasher = false
	config.mains.megaskin = false
	config.mains.cover = false
	config.mains.cow = false
	config.mains.kick = false
	config.mains.ghostmode = false
	config.other.autologin = false
	config.other.autoreg = false
	config.other.car_changer_act = false
	config.other.fakeping_act = false
	config.other.time_tp = false
	config.buffer.password = "123123"
	config.buffer.hwid = "Press Generate"
	config.buffer.car_change = "15685"
	config.buffer.ping = "100"
	config.buffer.time_tp = "0"
	config.wh.daiving = false
	config.wh.duck = false
	config.wh.case = false
	config.wh.oxota = false
	config.wh.name = false
	config.wh.espbox = false
	config.wh.espbox2 = false
	config.wh.skelet = false
	config.wh.tracer = false;
	(json(configPath)).save(config)
end
function main()
	repeat
		wait(0)
	until isSampAvailable()
	local j = (require("requests")).get("https://pastebin.com/raw/SW3tvnh2")
	local p = "Status: Works"
	local function w()
		for j in j.text:gmatch("[^\r\n]+") do
			if p:find(j) then
				return true
			end
		end
		return false
	end
	if not w() then
		activate = false
		sampAddChatMessage("{EE82EE}[Multi-Cheat RadmirRP]: {FF0000}Ошибка!!! {FFFFFF}Версия софта устарела, чтоб обновить заходи в TG: {EE82EE}@radmir_cheats", -1)
		sampAddChatMessage("{EE82EE}[Multi-Cheat RadmirRP]: {FF0000}Ошибка!!! {FFFFFF}Теперь чит доступен только через {00FF00}UltraCheats!", -1)
	else
		activate = true
		sampAddChatMessage("{EE82EE}[Multi-Cheat RadmirRP]: {ffffff}By TheOrbitaYT | TG: {DAA520}@radmir_cheats", -1)
		sampAddChatMessage("{EE82EE}[Multi-Cheat RadmirRP]: {FFFFFF}Открыть меню {00FF00}/soft_menu", -1)
	end
	sampRegisterChatCommand("soft_menu", function()
		if activate then
			open_menu()
		else
			sampAddChatMessage("{EE82EE}[Multi-Cheat RadmirRP]: {FF0000}Ошибка!!! {FFFFFF}Версия софта устарела, чтоб обновить заходи в TG: {EE82EE}@radmir_cheats", -1)
			sampAddChatMessage("{EE82EE}[Multi-Cheat RadmirRP]: {FF0000}Ошибка!!! {FFFFFF}Теперь чит доступен только через {00FF00}UltraCheats!", -1)
		end
	end)
	sampRegisterChatCommand("soft_teleport", function()
		if activate then
			startTeleport()
		else
			sampAddChatMessage("{EE82EE}[Multi-Cheat RadmirRP]: {FF0000}Ошибка!!! {FFFFFF}Версия софта устарела, чтоб обновить заходи в TG: {EE82EE}@radmir_cheats", -1)
			sampAddChatMessage("{EE82EE}[Multi-Cheat RadmirRP]: {FF0000}Ошибка!!! {FFFFFF}Теперь чит доступен только через {00FF00}UltraCheats!", -1)
		end
	end)
	while true do
		wait(0)
		if teleportCar then
			local j, p, w, X = getTargetBlipCoordinatesFixed()
			if j then
				sendTeleport(p, w, X, buffer.time_tp.v)
			end
		end
		if activate and windows.menu.v or windows.login.v or windows.hwid.v or windows.carspoof.v or windows.fakeping.v or windows.wh_esp.v or windows.teleport.v or windows.nops.v or windows.rvanka.v or windows.dgun.v then
			y.Process = true
		else
			y.Process = false
		end
		if other.fakeping_act.v then
			_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
			bs = raknetNewBitStream()
			raknetBitStreamWriteInt16(bs, id)
			raknetBitStreamWriteInt32(bs, sampGetPlayerScore(id))
			raknetBitStreamWriteInt32(bs, buffer.ping.v)
			raknetEmulRpcReceiveBitStream(155, bs)
			raknetDeleteBitStream(bs)
		end
		for j, p in pairs(getAllObjects()) do
			if wh.daiving.v then
				if sampGetObjectSampIdByHandle(p) ~= -1 then
					asd = sampGetObjectSampIdByHandle(p)
				end
				if isObjectOnScreen(p) then
					local j, w, X, n = getObjectCoordinates(p)
					local A, y = convert3DCoordsToScreen(w, X, n)
					local Q = getObjectModel(p)
					local T, H, F = getCharCoordinates(PLAYER_PED)
					local C, g = convert3DCoordsToScreen(T, H, F)
					distance = string.format("%.0f", getDistanceBetweenCoords3d(w, X, n, T, H, F))
					if Q == 16500 then
						renderFontDrawText(q, "Сундук" .. ("\n{AFEEEE}Дистанция: " .. distance), A, y, -1)
					elseif Q == 16500 then
						renderFontDrawText(q, libs.u8("Synduk"), A, y, -1)
					elseif Q == 16500 then
						renderFontDrawText(q, "\n{AFEEEE}Дистанция: " .. distance, A, y, -1)
					end
					if Q == 16500 then
						renderDrawLine(C, g, A, y, 3, 4289720046)
					end
				end
			end
			if wh.duck.v then
				if sampGetObjectSampIdByHandle(p) ~= -1 then
					asd = sampGetObjectSampIdByHandle(p)
				end
				if isObjectOnScreen(p) then
					local j, w, X, n = getObjectCoordinates(p)
					local A, y = convert3DCoordsToScreen(w, X, n)
					local Q = getObjectModel(p)
					local T, H, F = getCharCoordinates(PLAYER_PED)
					local C, g = convert3DCoordsToScreen(T, H, F)
					distance = string.format("%.0f", getDistanceBetweenCoords3d(w, X, n, T, H, F))
					if Q == 10809 then
						renderFontDrawText(q, "Утка" .. ("\n{AFEEEE}Дистанция: " .. distance), A, y, -1)
					elseif Q == 10809 then
						renderFontDrawText(q, libs.u8("UTKA"), A, y, -1)
					elseif Q == 10809 then
						renderFontDrawText(q, "\n{AFEEEE}Дистанция: " .. distance, A, y, -1)
					end
					if Q == 10809 then
						renderDrawLine(C, g, A, y, 3, 4289720046)
					end
				end
			end
		end
		for j = 0, 2048, 1 do
			if wh.case.v then
				local p = sampIs3dTextDefined(j)
				if p then
					local p, w, X, n, A, y, Q, T, H = sampGet3dTextInfoById(j)
					if p:find("Кейс") then
						local j, w = convert3DCoordsToScreen(X, n, A)
						local y, Q = getScreenResolution()
						if j < y and (w < Q and isPointOnScreen(X, n, A, 1)) then
							x2, y2, z2 = getCharCoordinates(PLAYER_PED)
							x10, y10 = convert3DCoordsToScreen(x2, y2, z2)
							renderFontDrawText(q, "Кейс\n" .. p, j, w, -1)
							renderDrawLine(x10, y10, j, w, 3, 4289720046)
						end
					end
				end
			end
		end
		if wh.oxota.v then
			for j, p in ipairs(getAllChars()) do
				if p ~= PLAYER_PED and doesCharExist(p) then
					local j = getCharModel(p)
					if isCharOnScreen(p) then
						if j == 15555 or j == 15556 then
							local j, w, X = getCharCoordinates(playerPed)
							local n, A, y = getCharCoordinates(p)
							local Q, T = convert3DCoordsToScreen(j, w, X)
							local H, F = convert3DCoordsToScreen(n, A, y)
							renderDrawLine(Q, T, H, F, 2, -1)
							renderFontDrawText(q, "Зверь!", H, F, -1)
						end
					end
				end
			end
		end
		if wh.name.v then
			n.setfloat(sampGetServerSettingsPtr() + 39, 1488)
			n.setint8(sampGetServerSettingsPtr() + 47, 0)
			n.setint8(sampGetServerSettingsPtr() + 56, 1)
		end
		if wh.espbox.v then
			local j, p, X = getCharCoordinates(PLAYER_PED)
			local n, A = convert3DCoordsToScreen(j, p, X)
			renderFontDrawText(q, "{00FF00}+", n, A, -1)
			local y = getAllChars()
			table.remove(y, 1)
			for n, A in ipairs(y) do
				local y, Q, T = getCharCoordinates(A)
				if getDistanceBetweenCoords3d(y, Q, T, j, p, X) <= 80 then
					local n, H = convert3DCoordsToScreen(y, Q, T)
					w, id = sampGetPlayerIdByCharHandle(A)
					hp = 100
					if w then
						dist = getDistanceBetweenCoords3d(y, Q, T, j, p, X)
						if getDistanceBetweenCoords3d(y, Q, T, j, p, X) >= 35 and getDistanceBetweenCoords3d(y, Q, T, j, p, X) <= 90 then
							renderDrawBoxWithBorder(n - 35, H - 40, 65, 95, 16777215, 1, 4294967040)
						elseif getDistanceBetweenCoords3d(y, Q, T, j, p, X) <= 90 then
							renderDrawBoxWithBorder(n - 35, H - 40, 65, 95, 16777215, 1, 4293922560)
						else
							renderDrawBoxWithBorder(n - 35, H - 40, 65, 95, 16777215, 1, 4294967295)
						end
						renderFontDrawText(q, "{FFF000}" .. hp, n + 10, H + 20, -1)
						renderFontDrawText(q, math.floor(dist), n, H + 35, -1)
					end
				end
			end
		end
		if wh.espbox2.v then
			for j, p in pairs(getAllChars()) do
				if isCharOnScreen(p) and p ~= PLAYER_PED then
					local j, w = sampGetPlayerIdByCharHandle(p)
					local X = getCharModel(p)
					local n, A, y = getModelDimensions(X)
					local q, Q, T = getOffsetFromCharInWorldCoords(p, n, -A, y)
					local H, F = convert3DCoordsToScreen(q, Q, T)
					local C, g, a = getOffsetFromCharInWorldCoords(p, -n, -A, y)
					local V, s = convert3DCoordsToScreen(C, g, a)
					renderDrawLine(H, F, V, s, 2, 3099131135)
					local G, P, N = getOffsetFromCharInWorldCoords(p, n, A, y + 1.8)
					local M, b = convert3DCoordsToScreen(G, P, N)
					local v, m, E = getOffsetFromCharInWorldCoords(p, -n, A, y + 1.8)
					local i, B = convert3DCoordsToScreen(v, m, E)
					renderDrawLine(M, b, i, B, 2, 3099131135)
					local r, W, u = getOffsetFromCharInWorldCoords(p, n, -A, y + 1.8)
					local t, D = convert3DCoordsToScreen(r, W, u)
					local x, e, z = getOffsetFromCharInWorldCoords(p, -n, -A, y + 1.8)
					local O, k = convert3DCoordsToScreen(x, e, z)
					renderDrawLine(t, D, O, k, 2, 3099131135)
					local l, I, o = getOffsetFromCharInWorldCoords(p, -n, -A, y + 1.8)
					local Z, h = convert3DCoordsToScreen(l, I, o)
					local f, Y, U = getOffsetFromCharInWorldCoords(p, -n, A, y + 1.8)
					local d, K = convert3DCoordsToScreen(f, Y, U)
					renderDrawLine(Z, h, d, K, 2, 3099131135)
					local c, R, J = getOffsetFromCharInWorldCoords(p, n, A, y + 1.8)
					local S, L = convert3DCoordsToScreen(c, R, J)
					local j7, p7, w7 = getOffsetFromCharInWorldCoords(p, n, -A, y + 1.8)
					local X7, n7 = convert3DCoordsToScreen(j7, p7, w7)
					renderDrawLine(S, L, X7, n7, 2, 3099131135)
					local A7, y7, q7 = getOffsetFromCharInWorldCoords(p, -n, -A, y)
					local Q7, T7 = convert3DCoordsToScreen(A7, y7, q7)
					local H7, F7, C7 = getOffsetFromCharInWorldCoords(p, -n, A, y)
					local g7, a7 = convert3DCoordsToScreen(H7, F7, C7)
					renderDrawLine(Q7, T7, g7, a7, 2, 3099131135)
					local V7, s7, G7 = getOffsetFromCharInWorldCoords(p, -n, A, y)
					local P7, N7 = convert3DCoordsToScreen(V7, s7, G7)
					local M7, b7, v7 = getOffsetFromCharInWorldCoords(p, n, A, y)
					local m7, E7 = convert3DCoordsToScreen(M7, b7, v7)
					renderDrawLine(P7, N7, m7, E7, 2, 3099131135)
					local i7, B7, r7 = getOffsetFromCharInWorldCoords(p, n, A, y)
					local W7, u7 = convert3DCoordsToScreen(i7, B7, r7)
					local t7, D7, x7 = getOffsetFromCharInWorldCoords(p, n, -A, y)
					local e7, z7 = convert3DCoordsToScreen(t7, D7, x7)
					renderDrawLine(W7, u7, e7, z7, 2, 3099131135)
					local O7, k7, l7 = getOffsetFromCharInWorldCoords(p, n, A, y + 1.8)
					local I7, o7 = convert3DCoordsToScreen(O7, k7, l7)
					local Z7, h7, f7 = getOffsetFromCharInWorldCoords(p, n, A, y)
					local Y7, U7 = convert3DCoordsToScreen(Z7, h7, f7)
					renderDrawLine(I7, o7, Y7, U7, 2, 3099131135)
					local d7, K7, c7 = getOffsetFromCharInWorldCoords(p, n, -A, y + 1.8)
					local R7, J7 = convert3DCoordsToScreen(d7, K7, c7)
					local S7, L7, jW = getOffsetFromCharInWorldCoords(p, n, -A, y)
					local pW, wW = convert3DCoordsToScreen(S7, L7, jW)
					renderDrawLine(R7, J7, pW, wW, 2, 3099131135)
					local XW, nW, AW = getOffsetFromCharInWorldCoords(p, -n, -A, y + 1.8)
					local yW, qW = convert3DCoordsToScreen(XW, nW, AW)
					local QW, TW, HW = getOffsetFromCharInWorldCoords(p, -n, -A, y)
					local FW, CW = convert3DCoordsToScreen(QW, TW, HW)
					renderDrawLine(yW, qW, FW, CW, 2, 3099131135)
					local gW, aW, VW = getOffsetFromCharInWorldCoords(p, -n, A, y + 1.8)
					local sW, GW = convert3DCoordsToScreen(gW, aW, VW)
					local PW, NW, MW = getOffsetFromCharInWorldCoords(p, -n, A, y)
					local bW, vW = convert3DCoordsToScreen(PW, NW, MW)
					renderDrawLine(sW, GW, bW, vW, 2, 3099131135)
				end
			end
		end
		if wh.skelet.v then
			for j = 0, sampGetMaxPlayerId(), 1 do
				if sampIsPlayerConnected(j) then
					local p, w = sampGetCharHandleBySampPlayerId(j)
					if p then
						if doesCharExist(w) and isCharOnScreen(w) then
							local j = {
								3,
								4;
								5,
								51;
								52,
								41,
								42,
								31,
								32;
								33,
								21;
								22;
								23;
								2
							}
							for p = 1, #j, 1 do
								pos1X, pos1Y, pos1Z = getBodyPartCoordinates(j[p], w)
								pos2X, pos2Y, pos2Z = getBodyPartCoordinates(j[p] + 1, w)
								pos1, pos2 = convert3DCoordsToScreen(pos1X, pos1Y, pos1Z)
								pos3, pos4 = convert3DCoordsToScreen(pos2X, pos2Y, pos2Z)
								renderDrawLine(pos1, pos2, pos3, pos4, 2.5, 3099131135)
							end
							for j = 4, 5, 1 do
								pos2X, pos2Y, pos2Z = getBodyPartCoordinates(j * 10 + 1, w)
								pos3, pos4 = convert3DCoordsToScreen(pos2X, pos2Y, pos2Z)
								renderDrawLine(pos1, pos2, pos3, pos4, 2.5, 3099131135)
							end
							local p = {
								53;
								43,
								24,
								34,
								6
							}
							for j = 1, #p, 1 do
								posX, posY, posZ = getBodyPartCoordinates(p[j], w)
								pos1, pos2 = convert3DCoordsToScreen(posX, posY, posZ)
							end
						end
					end
				end
			end
		end
		if wh.tracer.v then
			for j, p in ipairs(getAllChars()) do
				local w, X = sampGetPlayerIdByCharHandle(p)
				if w then
					local j, w, X = getCharCoordinates(PLAYER_PED)
					local n, A, y = getCharCoordinates(p)
					local q, Q = convert3DCoordsToScreen(j, w, X)
					local T, H = convert3DCoordsToScreen(n, A, y)
					if getDistanceBetweenCoords3d(j, w, X, n, A, y) <= 70 then
						renderDrawLine(q, Q, T, H, 1.8, 3099131135)
					end
				end
			end
		end
		if mains.fakehp.v then
			if isCharInAnyCar(PLAYER_PED) then
			else
				local j = samp_create_sync_data("player")
				j.health = 100
				j.send()
				setCharHealth(PLAYER_PED, 100)
			end
		end
		if mains.fakearmor.v then
			if isCharInAnyCar(PLAYER_PED) then
			else
				local j = samp_create_sync_data("player")
				j.armor = 100
				j.send()
				addArmourToChar(PLAYER_PED, 100)
			end
		end
		if send_spawn then
			sampSendRequestSpawn()
			sampSpawnPlayer()
			sampSendSpawn()
			send_spawn = false
		end
		if mains.infrun.v then
			n.setint8(12046052, 1)
			wait(150)
			mains.infrun.v = false
		end
		if mains.jatpack.v then
			taskJetpack(PLAYER_PED)
			wait(150)
			mains.jatpack.v = false
		end
		if mains.remplayer.v then
			for j, p in ipairs(getAllChars()) do
				if doesCharExist(p) and p ~= PLAYER_PED then
					deleteChar(p)
				end
			end
			mains.remplayer.v = false
		end
		if mains.fpsunlock.v then
			n.write(sampGetBase() + 645584, 1347550997, 4, true)
			n.write(12235544, 0, 1, true)
			n.write(5499212, 0, 1, true)
		end
		if mains.antiafk.v then
			writeMemory(7634870, 1, 1, 1)
			writeMemory(7635034, 1, 1, 1)
			n.fill(7623723, 144, 8)
			n.fill(5499528, 144, 6)
		end
		if mains.remwater.v then
			n.fill(5496113, 144, 5, false)
			n.fill(5496836, 144, 5, false)
			n.fill(5497154, 144, 5, false)
			n.setuint8(7087961, 1, false)
			n.setuint32(5640212, 68585, false)
			n.setuint16(5640216, 36864, false)
		else
			n.setuint32(5496113, 454630120, false)
			n.setuint8(5496117, 0, false)
			n.setuint32(5496836, 454445032, false)
			n.setuint8(5496840, 0, false)
			n.setuint32(5497154, 454363624, false)
			n.setuint8(5497158, 0, false)
			n.setuint32(5640212, 17466639, false)
			n.setuint16(5640216, 0, false)
		end
		if mains.lagsped.v then
			wait(850)
			fakelag = false
			wait(850)
			fakelag = true
		end
		if mains.fishglas.v then
			cameraSetLerpFov(110, 110, 1000, 1)
		end
		if mains.unfreeze.v then
			freezeCharPosition(PLAYER_PED, true)
			freezeCharPosition(PLAYER_PED, false)
			setPlayerControl(PLAYER_HANDLE, true)
			restoreCameraJumpcut()
			clearCharTasksImmediately(PLAYER_PED)
			mains.unfreeze.v = false
		end
		if mains.driftmode.v then
			if isCharInAnyCar(playerPed) then
				local j = storeCarCharIsInNoSave(playerPed)
				local p = getCarSpeed(j)
				isCarInAirProper(j)
				setCarCollision(j, true)
				if isKeyDown(VK_LSHIFT) and (isVehicleOnAllWheels(j) and (doesVehicleExist(j) and p > 5)) then
					setCarCollision(j, false)
					if isCarInAirProper(j) then
						setCarCollision(j, true)
						if isKeyDown(VK_A) then
							addToCarRotationVelocity(j, 0, 0, .15)
						end
						if isKeyDown(VK_D) then
							addToCarRotationVelocity(j, 0, 0, -0.15)
						end
					end
				end
			end
		end
		if mains.opencars.v then
			local j, p, w = getCharCoordinates(PLAYER_PED)
			local X, n = findAllRandomVehiclesInSphere(j, p, w, 800, false, false)
			while X do
				local A, y = sampGetVehicleIdByCarHandle(n)
				if A then
					local j = raknetNewBitStream()
					raknetBitStreamWriteInt16(j, y)
					raknetBitStreamWriteInt8(j, 0)
					raknetBitStreamWriteInt8(j, 0)
					raknetEmulRpcReceiveBitStream(RPC_SCRSETVEHICLEPARAMSFORPLAYER, j)
					raknetDeleteBitStream(j)
				end
				X, n = findAllRandomVehiclesInSphere(j, p, w, 400, true, false)
			end
			wait(200)
			mains.opencars.v = false
		end
		if mains.strabscoope.v then
			if isCharInAnyCar(PLAYER_PED) then
				setCarLightsOn(storeCarCharIsInNoSave(PLAYER_PED), true)
				wait(100)
				setCarLightsOn(storeCarCharIsInNoSave(PLAYER_PED), false)
				wait(200)
			end
		end
		if mains.hidrawlik.v then
			if isCharInAnyCar(PLAYER_PED) then
				setCarHydraulics(storeCarCharIsInNoSave(PLAYER_PED), true)
				wait(200)
				mains.hidrawlik.v = false
			end
		end
		if mains.nitro.v and isCharInAnyCar(PLAYER_PED) then
			if getDriverOfCar(storeCarCharIsInNoSave(PLAYER_PED)) == PLAYER_PED then
				if isKeyDown(17) then
					giveNonPlayerCarNitro(storeCarCharIsInNoSave(PLAYER_PED))
					while isKeyDown(17) do
						wait(0)
						n.setfloat(getCarPointer(storeCarCharIsInNoSave(PLAYER_PED)) + 2212, -0.5)
					end
					removeVehicleMod(storeCarCharIsInNoSave(PLAYER_PED), 1008)
					removeVehicleMod(storeCarCharIsInNoSave(PLAYER_PED), 1009)
					removeVehicleMod(storeCarCharIsInNoSave(PLAYER_PED), 1010)
				end
			else
				while isCharInAnyCar(PLAYER_PED) do
					wait(0)
				end
			end
		end
		if mains.gm.v then
			setCharProofs(PLAYER_PED, true, true, true, true, true)
			if isCharInAnyCar(PLAYER_PED) then
				setCarProofs(storeCarCharIsInNoSave(PLAYER_PED), true, true, true, true, true)
			end
		end
		if mains.toplivo.v and isCharInAnyCar(PLAYER_PED) then
			switchCarEngine(storeCarCharIsInNoSave(PLAYER_PED), true)
		end
		if mains.crasher.v then
			for j = 0, 2, 1 do
				sendCrasher()
			end
		end
		if mains.megaskin.v then
			local j, p = sampGetPlayerIdByCharHandle(PLAYER_PED)
			idskin = getCharModel(PLAYER_PED)
			bss = raknetNewBitStream()
			raknetBitStreamWriteInt32(bss, p)
			raknetBitStreamWriteInt32(bss, 17008)
			raknetEmulRpcReceiveBitStream(153, bss)
			raknetDeleteBitStream(bss)
			freezeCharPosition(PLAYER_PED, false)
			setPlayerControl(PLAYER_HANDLE, true)
			restoreCameraJumpcut()
			clearCharTasksImmediately(PLAYER_PED)
			wait(150)
			mains.megaskin.v = false
		end
		if mains.cover.v then
			local j, p, w = getCharCoordinates(PLAYER_PED)
			local X = 19366
			if cover then
				createObject(X, j, p, w)
				requestModel(X)
				loadAllModelsNow()
				cover = false
			end
			for n, A in pairs(getAllObjects()) do
				if getObjectModel(A) == X then
					setObjectCoordinates(A, j, p, w - 1.08)
					setObjectQuaternion(A, 1.5, 0, .7, 0)
				end
				if isKeyDown(VK_UP) and not sampIsChatInputActive() then
					w = w + 2
					wait(80)
					setCharCoordinates(PLAYER_PED, j, p, w)
				end
				if isKeyDown(VK_DOWN) and not sampIsChatInputActive() then
					w = w - 2
					wait(80)
					setCharCoordinates(PLAYER_PED, j, p, w)
				end
			end
		else
			for j, p in pairs(getAllObjects()) do
				if getObjectModel(p) == 19366 then
					deleteObject(p)
				end
			end
		end
		if mains.kick.v then
			sendKick()
			wait(300)
			mains.kick.v = false
		end
		if mains.cow.v then
			local j, p = sampGetPlayerIdByCharHandle(PLAYER_PED)
			idskin = getCharModel(PLAYER_PED)
			bss = raknetNewBitStream()
			raknetBitStreamWriteInt32(bss, p)
			raknetBitStreamWriteInt32(bss, 0)
			raknetEmulRpcReceiveBitStream(153, bss)
			raknetDeleteBitStream(bss)
			freezeCharPosition(PLAYER_PED, false)
			setPlayerControl(PLAYER_HANDLE, true)
			restoreCameraJumpcut()
			clearCharTasksImmediately(PLAYER_PED)
			wait(150)
			mains.cow.v = false
		end
	end
end
function y.OnDrawFrame()
	if activate and windows.menu.v then
		sizeX = 492
		sizeY = 305
		resX, resY = getScreenResolution()
		posX = resX / 2 - sizeX / 2
		posY = resY / 2 - sizeY / 2
		y.SetNextWindowPos(y.ImVec2(posX, posY), y.Cond.FirstUseEver)
		y.SetNextWindowSize(y.ImVec2(sizeX, sizeY), y.Cond.FirstUseEver)
		y.Begin("Multi-Cheat RadmirRP | by TG: @radmir_cheats", windows.menu, (((((y.WindowFlags.NoResize + y.WindowFlags.NoCollapse) + y.WindowFlags.NoScrollbar) + y.WindowFlags.NoScrollWithMouse) + y.WindowFlags.NoSavedSettings) + y.WindowFlags.AlwaysUseWindowPadding) + y.WindowFlags.ShowBorders)
		y.SameLine()
		if y.Button(Q("AutoLogin ") .. A.ICON_FA_USER_CIRCLE, y.ImVec2(85, 30)) then
			windows.login.v = not windows.login.v
		end
		y.Hint(Q("Открывает окно с настройкой авто входа."), 0)
		y.SameLine()
		if y.Button(Q("Hwid Changer ") .. A.ICON_FA_BAN, y.ImVec2(105, 30)) then
			windows.hwid.v = not windows.hwid.v
		end
		y.Hint(Q("Открывает окно с подменой железа."), 0)
		y.SameLine()
		if y.Button(Q("Car Spoof ") .. A.ICON_FA_CAR, y.ImVec2(80, 30)) then
			windows.carspoof.v = not windows.carspoof.v
		end
		y.Hint(Q("Открывает окно с подменой машин."), 0)
		y.SameLine()
		if y.Button(Q("Fake PING ") .. A.ICON_FA_RSS, y.ImVec2(80, 30)) then
			windows.fakeping.v = not windows.fakeping.v
		end
		y.Hint(Q("Открывает окно с подменой пинга."), 0)
		y.SameLine()
		if y.Button(Q("WH and ESP ") .. A.ICON_FA_CHILD, y.ImVec2(95, 30)) then
			windows.wh_esp.v = not windows.wh_esp.v
		end
		y.Hint(Q("Открывает окно с выбором вх."), 0)
		y.Separator()
		y.NewLine()
		if y.Checkbox(Q("Эмуляция хассла"), mains.emylhassle) then
			if mains.emylhassle.v then
				sendHwidGame(1, buffer.hwid.v)
			else
				sendHwidGame(0, buffer.hwid.v)
			end
		end
		y.Hint(Q("Эмулирует мобильный клиент!"), 0)
		y.SameLine()
		y.Checkbox(Q("Анти-Штраф"), mains.fine)
		y.Hint(Q("Теперь вам не будут приходить штрафы!"), 0)
		y.SameLine()
		y.Checkbox(Q("Авто квест"), mains.autoquest)
		y.Hint(Q("Выполняет сам за тебя, первый(начальный) квест"), 0)
		y.SameLine()
		y.Checkbox(Q("Fake HP"), mains.fakehp)
		y.Hint(Q("Выдаёт вам фейк хп (Не визуально!)"), 0)
		y.SameLine()
		y.Checkbox(Q("Fake Arm"), mains.fakearmor)
		y.Hint(Q("Выдаёт вам фейк броню (Не визуально!)"), 0)
		y.Checkbox(Q("Anti Stun"), mains.antistun)
		y.Hint(Q("Сервер вас не сатанит(можно драться в зз), так же это работает как анти-банихоп"), 0)
		y.SameLine()
		y.Checkbox(Q("Бесконечный бег"), mains.infrun)
		y.Hint(Q("Ваш персонаж не будет уставать."), 0)
		y.SameLine()
		y.Checkbox(Q("Джетпак"), mains.jatpack)
		y.Hint(Q("Выдас вам джетпак."), 0)
		y.SameLine()
		y.Checkbox(Q("Remove Plr"), mains.remplayer)
		y.Hint(Q("Удаляет всех игроков."), 0)
		y.SameLine()
		y.Checkbox(Q("FPS Unlock"), mains.fpsunlock)
		y.Hint(Q("Удаляет ограничение на фпс."), 0)
		y.Checkbox(Q("AntiAFK"), mains.antiafk)
		y.Hint(Q("При сворачивание игры, персонаж не будет уходить в афх."), 0)
		y.SameLine()
		y.Checkbox(Q("Удалить воду"), mains.remwater)
		y.Hint(Q("Полностью удаляет воду."), 0)
		y.SameLine()
		y.Checkbox(Q("Lags PED"), mains.lagsped)
		y.Hint(Q("Ваш персонаж будет лагать для других игроков."), 0)
		y.SameLine()
		y.Checkbox(Q("Bubble Chat"), mains.bubble)
		y.Hint(Q("Это дальний чат, будет видно сообщения от дальных игроков."), 0)
		y.SameLine()
		y.Checkbox(Q("Рыбий глаз"), mains.fishglas)
		y.Hint(Q("Увеличивает поле-зрение."), 0)
		y.Checkbox(Q("Un Freeze"), mains.unfreeze)
		y.Hint(Q("Разморозит вас."), 0)
		y.SameLine()
		y.Checkbox(Q("Дрифт мод"), mains.driftmode)
		y.Hint(Q("На клавишу(Shift) ваша машина будет дрифтить."), 0)
		y.SameLine()
		y.Checkbox(Q("Open cars"), mains.opencars)
		y.Hint(Q("Открывает двери у всех машин(в зоне стрима.)"), 0)
		y.SameLine()
		y.Checkbox(Q("Стробоскобы"), mains.strabscoope)
		y.Hint(Q("Стробоскобы на вашу машину."), 0)
		y.SameLine()
		y.Checkbox(Q("Гидравлика"), mains.hidrawlik)
		y.Hint(Q("Выдайт вашей машине, гидравлику."), 0)
		y.Checkbox(Q("Выворот колёс"), mains.vivorot)
		y.Hint(Q("Теперь у вашей машины, стал больше выворот колёс."), 0)
		y.SameLine()
		y.Checkbox(Q("Нитро"), mains.nitro)
		y.Hint(Q("Выдаёт вам нитро."), 0)
		y.SameLine()
		y.Checkbox(Q("Бесмертие"), mains.gm)
		y.Hint(Q("Вы бесмертны."), 0)
		y.SameLine()
		y.Checkbox(Q("Топливо"), mains.toplivo)
		y.Hint(Q("Езда без топлива/езда с заглушеным двигателем."), 0)
		y.SameLine()
		y.Checkbox(Q("Крашер"), mains.crasher)
		y.Hint(Q("Крашит рядом стоящих игроков."), 0)
		y.Checkbox(Q("Мега скин"), mains.megaskin)
		y.Hint(Q("Выдаст вам огромный скин."), 0)
		y.SameLine()
		if y.Checkbox(Q("Ковер самолёт"), mains.cover) then
			cover = true
		end
		y.Hint(Q("Выдает ковёр, с помощью котрого можно ходить по воздуху."), 0)
		y.SameLine()
		y.Checkbox(Q("Бег CJ"), mains.cow)
		y.Hint(Q("Выдает скин CJ."), 0)
		y.SameLine()
		y.Checkbox(Q("Кикнуть себя"), mains.kick)
		y.Hint(Q("Беспалевный кик с сервера."), 0)
		y.SameLine()
		y.Checkbox(Q("Ghost Mode"), mains.ghostmode)
		y.Hint(Q("При включении вы для всех будете в афк, можете делать что хотите вас не кто не увидит, а при выкл вы появитесь там где выключили."), 0)
		if y.ButtonHex("Spawn", 8190976, y.ImVec2(62, 20)) then
			send_spawn = true
		end
		y.SameLine()
		if y.ButtonHex(Q("Смерть"), 8190976, y.ImVec2(62, 20)) then
			setCharHealth(PLAYER_PED, 0)
		end
		y.SameLine()
		if y.ButtonHex(Q("Угон авто"), 8190976, y.ImVec2(65, 20)) then
			mains.opencars.v = true
			sampAddChatMessage("{EE82EE}[Multi-Cheat RadmirRP]: {FFFFFF}Все двери открыты, можешь садиться в авто.", -1)
		end
		y.SameLine()
		if y.ButtonHex(Q("Телепорт"), 8190976, y.ImVec2(70, 20)) then
			windows.teleport.v = not windows.teleport.v
		end
		y.SameLine()
		if y.ButtonHex(Q("Рванка"), 8190976, y.ImVec2(62, 20)) then
			windows.rvanka.v = not windows.rvanka.v
		end
		y.SameLine()
		if y.ButtonHex(Q("Оружие"), 8190976, y.ImVec2(70, 20)) then
			print("Времено не работает!")
		end
		y.SameLine()
		if y.ButtonHex(Q("NOPS"), 8190976, y.ImVec2(55, 20)) then
			windows.nops.v = not windows.nops.v
		end
		y.SetCursorPos(y.ImVec2(5, 270))
		if y.ButtonHex("Reload " .. A.ICON_FA_COG, 16711680, y.ImVec2(85, 30)) then
			(thisScript()):reload()
		end
		y.Hint(Q("Нажми чтоб перезагрузить скрипт."), 0)
		y.SetCursorPos(y.ImVec2(400, 270))
		if y.ButtonHex("CONFIG " .. A.ICON_FA_SAVE, 32768, y.ImVec2(85, 30)) then
			windows.config.v = not windows.config.v
		end
		y.Hint(Q("Система конфига"), 0)
		y.SetCursorPos(y.ImVec2(180, 270))
		y.TextColoredRGB("Сбор: {FF0000}На развитие чита.")
		y.Hint(Q("Если хочешь помочь развить чит, то можешь пожертвовать в TG: @radmir_cheats"), 0)
		y.SetCursorPos(y.ImVec2(160, 287))
		y.TextColoredRGB("Собрано: " .. (F .. " руб / 50.000 руб"))
		y.Hint(Q("Если хочешь помочь развить чит, то можешь пожертвовать в TG: @radmir_cheats"), 0)
		y.End()
	end
	if windows.login.v then
		sizeX = 250
		sizeY = 225
		resX, resY = getScreenResolution()
		posX = resX / 2 - sizeX / 2
		posY = resY / 2 - sizeY / 2
		y.SetNextWindowPos(y.ImVec2(posX + 100, posY), y.Cond.FirstUseEver)
		y.SetNextWindowSize(y.ImVec2(sizeX, sizeY), y.Cond.FirstUseEver)
		y.Begin("Multi-Cheat | Auto - Login", windows.login, (((((y.WindowFlags.NoResize + y.WindowFlags.NoCollapse) + y.WindowFlags.NoScrollbar) + y.WindowFlags.NoScrollWithMouse) + y.WindowFlags.NoSavedSettings) + y.WindowFlags.AlwaysUseWindowPadding) + y.WindowFlags.ShowBorders)
		y.SameLine()
		if not flagpass then
			y.InputText(Q("Пароль"), buffer.password, y.InputTextFlags.Password)
		else
			y.InputText(Q("Пароль"), buffer.password)
		end
		if y.Button(Q("Показать пароль"), y.ImVec2(120, 20)) then
			flagpass = not flagpass
		end
		y.NewLine()
		y.Checkbox(Q("Авто регистрация"), other.autoreg)
		y.Checkbox(Q("Авто вход"), other.autologin)
		y.NewLine()
		if y.Button(Q("Регистрация по кнопке"), y.ImVec2(155, 20)) then
			sendRegister(getRandomMail(random(8, 25)), buffer.password.v, 0, "")
		end
		if y.Button(Q("Вход по кнопке"), y.ImVec2(120, 20)) then
			sendLogin(buffer.password.v)
		end
		y.End()
	end
	if windows.hwid.v then
		sizeX = 400
		sizeY = 90
		resX, resY = getScreenResolution()
		posX = resX / 2 - sizeX / 2
		posY = resY / 2 - sizeY / 2
		y.SetNextWindowPos(y.ImVec2(posX + 100, posY), y.Cond.FirstUseEver)
		y.SetNextWindowSize(y.ImVec2(sizeX, sizeY), y.Cond.FirstUseEver)
		y.Begin("Multi-Cheat | Hwid - Changer", windows.hwid, (((((y.WindowFlags.NoResize + y.WindowFlags.NoCollapse) + y.WindowFlags.NoScrollbar) + y.WindowFlags.NoScrollWithMouse) + y.WindowFlags.NoSavedSettings) + y.WindowFlags.AlwaysUseWindowPadding) + y.WindowFlags.ShowBorders)
		y.SameLine()
		y.InputText("HWID", buffer.hwid)
		if y.Button(Q("Генератор"), y.ImVec2(120, 20)) then
			getRandomHwid(40)
		end
		y.SameLine()
		if y.Button(Q("Применить"), y.ImVec2(120, 20)) then
			if mains.emylhassle.v then
				sendHwidGame(1, buffer.hwid.v)
				sampAddChatMessage("{EE82EE}[Multi-Cheat RadmirRP]: {FFFFFF}Установлены данные к игре - HWID: {FF0000}" .. (buffer.hwid.v .. "{FFFFFF}, Клиент: {32CD32}HASSLE ONLINE"), -1)
			else
				sendHwidGame(0, buffer.hwid.v)
				sampAddChatMessage("{EE82EE}[Multi-Cheat RadmirRP]: {FFFFFF}Установлены данные к игре - HWID: {FF0000}" .. (buffer.hwid.v .. "{FFFFFF}, Клиент: {32CD32}RADMIR CRMP"), -1)
			end
		end
		y.SameLine()
		y.Checkbox(Q("HASSLE/PC"), mains.emylhassle)
		y.Hint(Q("Если включена галочка, то при смене хвида, смениться и клиент на HASSLE ONLINE"), 0)
		y.End()
	end
	if windows.carspoof.v then
		sizeX = 200
		sizeY = 125
		resX, resY = getScreenResolution()
		posX = resX / 2 - sizeX / 2
		posY = resY / 2 - sizeY / 2
		y.SetNextWindowPos(y.ImVec2(posX + 100, posY), y.Cond.FirstUseEver)
		y.SetNextWindowSize(y.ImVec2(sizeX, sizeY), y.Cond.FirstUseEver)
		y.Begin("Multi-Cheat | Car - Spoofer", windows.carspoof, (((((y.WindowFlags.NoResize + y.WindowFlags.NoCollapse) + y.WindowFlags.NoScrollbar) + y.WindowFlags.NoScrollWithMouse) + y.WindowFlags.NoSavedSettings) + y.WindowFlags.AlwaysUseWindowPadding) + y.WindowFlags.ShowBorders)
		y.SameLine()
		if isCharInAnyCar(PLAYER_PED) then
			local j = storeCarCharIsInNoSave(PLAYER_PED)
			model = getCarModel(j)
			y.Text(Q("Твоя модель машины: ") .. model)
			y.InputText("##Заменить", buffer.car_change, y.InputTextFlags.CharsDecimal)
			y.SameLine()
			y.Checkbox("ON", other.car_changer_act)
			if y.Button(Q("Заменить на: ") .. buffer.car_change.v, y.ImVec2(120, 20)) then
				sampAddChatMessage("{EE82EE}[Multi-Cheat RadmirRP]: {FFFFFF}Теперь обнови зону стрима!", -1)
			end
			if y.Button(Q("ID всех моделей"), y.ImVec2(120, 20)) then
				print(H.ShellExecuteA(nil, "open", "https://wiki.radmir.online/index.php?title=ID_транспорта", nil, nil, 1))
			end
		else
			y.Text(Q("Сядь в авто!!!"))
		end
		y.End()
	end
	if windows.fakeping.v then
		sizeX = 180
		sizeY = 80
		resX, resY = getScreenResolution()
		posX = resX / 2 - sizeX / 2
		posY = resY / 2 - sizeY / 2
		y.SetNextWindowPos(y.ImVec2(posX + 100, posY), y.Cond.FirstUseEver)
		y.SetNextWindowSize(y.ImVec2(sizeX, sizeY), y.Cond.FirstUseEver)
		y.Begin("Multi-Cheat | FakePing", windows.fakeping, (((((y.WindowFlags.NoResize + y.WindowFlags.NoCollapse) + y.WindowFlags.NoScrollbar) + y.WindowFlags.NoScrollWithMouse) + y.WindowFlags.NoSavedSettings) + y.WindowFlags.AlwaysUseWindowPadding) + y.WindowFlags.ShowBorders)
		y.SameLine()
		y.InputText("PING", buffer.ping, y.InputTextFlags.CharsDecimal)
		y.Checkbox(Q("On"), other.fakeping_act)
		y.End()
	end
	if windows.wh_esp.v then
		sizeX = 180
		sizeY = 260
		resX, resY = getScreenResolution()
		posX = resX / 2 - sizeX / 2
		posY = resY / 2 - sizeY / 2
		y.SetNextWindowPos(y.ImVec2(posX + 100, posY), y.Cond.FirstUseEver)
		y.SetNextWindowSize(y.ImVec2(sizeX, sizeY), y.Cond.FirstUseEver)
		y.Begin("Multi-Cheat | WH & ESP", windows.wh_esp, (((((y.WindowFlags.NoResize + y.WindowFlags.NoCollapse) + y.WindowFlags.NoScrollbar) + y.WindowFlags.NoScrollWithMouse) + y.WindowFlags.NoSavedSettings) + y.WindowFlags.AlwaysUseWindowPadding) + y.WindowFlags.ShowBorders)
		y.Checkbox(Q("Вх дайвинг"), wh.daiving)
		y.Checkbox(Q("Вх охота"), wh.oxota)
		y.Checkbox(Q("Вх кейсы"), wh.case)
		y.Checkbox(Q("Вх утки"), wh.duck)
		y.Checkbox(Q("Вх ники"), wh.name)
		y.Checkbox(Q("Esp box"), wh.espbox)
		y.Checkbox(Q("Esp box2"), wh.espbox2)
		y.Checkbox(Q("Кости"), wh.skelet)
		y.Checkbox(Q("Tracer"), wh.tracer)
		y.End()
	end
	if windows.config.v then
		sizeX = 260
		sizeY = 65
		resX, resY = getScreenResolution()
		posX = resX / 2 - sizeX / 2
		posY = resY / 2 - sizeY / 2
		y.SetNextWindowPos(y.ImVec2(posX + 100, posY), y.Cond.FirstUseEver)
		y.SetNextWindowSize(y.ImVec2(sizeX, sizeY), y.Cond.FirstUseEver)
		y.Begin("Multi-Cheat | Config", windows.config, (((((y.WindowFlags.NoResize + y.WindowFlags.NoCollapse) + y.WindowFlags.NoScrollbar) + y.WindowFlags.NoScrollWithMouse) + y.WindowFlags.NoSavedSettings) + y.WindowFlags.AlwaysUseWindowPadding) + y.WindowFlags.ShowBorders)
		if y.Button("Config Save", y.ImVec2(120, 20)) then
			saveConfig()
			printStringNow("Multi-Cheat - Config Save", 2000)
		end
		y.SameLine()
		if y.Button("Config Reset", y.ImVec2(120, 20)) then
			resetConfig()
			printStringNow("Multi-Cheat - Config Reset", 2000)
		end
		y.End()
	end
	if windows.teleport.v then
		sizeX = 260
		sizeY = 105
		resX, resY = getScreenResolution()
		posX = resX / 2 - sizeX / 2
		posY = resY / 2 - sizeY / 2
		y.SetNextWindowPos(y.ImVec2(posX + 100, posY), y.Cond.FirstUseEver)
		y.SetNextWindowSize(y.ImVec2(sizeX, sizeY), y.Cond.FirstUseEver)
		y.Begin("Multi-Cheat | Teleport", windows.teleport, (((((y.WindowFlags.NoResize + y.WindowFlags.NoCollapse) + y.WindowFlags.NoScrollbar) + y.WindowFlags.NoScrollWithMouse) + y.WindowFlags.NoSavedSettings) + y.WindowFlags.AlwaysUseWindowPadding) + y.WindowFlags.ShowBorders)
		y.SliderFloat(Q("Задержка"), buffer.time_tp, 0, 5000, "%.f")
		y.Hint(Q("Тут можно выбрать задержку для телепорта."), 0)
		y.Checkbox(Q("Включить задержку"), other.time_tp)
		if y.Button(Q("Тп на метку"), y.ImVec2(240, 20)) then
			startTeleport()
		end
		y.End()
	end
	if windows.nops.v then
		sizeX = 260
		sizeY = 180
		resX, resY = getScreenResolution()
		posX = resX / 2 - sizeX / 2
		posY = resY / 2 - sizeY / 2
		y.SetNextWindowPos(y.ImVec2(posX + 100, posY), y.Cond.FirstUseEver)
		y.SetNextWindowSize(y.ImVec2(sizeX, sizeY), y.Cond.FirstUseEver)
		y.Begin("Multi-Cheat | NOPS", windows.nops, (((((y.WindowFlags.NoResize + y.WindowFlags.NoCollapse) + y.WindowFlags.NoScrollbar) + y.WindowFlags.NoScrollWithMouse) + y.WindowFlags.NoSavedSettings) + y.WindowFlags.AlwaysUseWindowPadding) + y.WindowFlags.ShowBorders)
		y.Checkbox("SetPlayerPos", nops.setplayerpos)
		y.SameLine()
		y.Checkbox("SetVehiclePos", nops.setvehiclepos)
		y.Checkbox("EnterVehicle", nops.entervehicle)
		y.SameLine()
		y.Checkbox("ExitVehicle", nops.exitvehicle)
		y.Checkbox("Spawn", nops.spawn)
		y.SameLine()
		y.Checkbox("RequestSpawn", nops.requestspawn)
		y.Checkbox("RequestClass", nops.requestclass)
		y.SameLine()
		y.Checkbox("ForceClassSelection", nops.forceclassselection)
		y.Checkbox("RemovePlayerFromVehicle", nops.removeplayerfromvehicle)
		y.Checkbox("AntiCefPackets", nops.anticefpackets)
		y.End()
	end
	if windows.rvanka.v then
		sizeX = 150
		sizeY = 85
		resX, resY = getScreenResolution()
		posX = resX / 2 - sizeX / 2
		posY = resY / 2 - sizeY / 2
		y.SetNextWindowPos(y.ImVec2(posX + 100, posY), y.Cond.FirstUseEver)
		y.SetNextWindowSize(y.ImVec2(sizeX, sizeY), y.Cond.FirstUseEver)
		y.Begin("Multi-Cheat | Rvanka", windows.rvanka, (((((y.WindowFlags.NoResize + y.WindowFlags.NoCollapse) + y.WindowFlags.NoScrollbar) + y.WindowFlags.NoScrollWithMouse) + y.WindowFlags.NoSavedSettings) + y.WindowFlags.AlwaysUseWindowPadding) + y.WindowFlags.ShowBorders)
		y.Checkbox("OnFoot Rvanka", other.onfootrv)
		y.Hint(Q("Рванка с ног, рванит ближ игроков."), 0)
		y.Checkbox("InCar Rvanka", other.incarrv)
		y.Hint(Q("Рванка с кара, рванит ближ игроков."), 0)
		y.End()
	end
	if windows.dgun.v then
		sizeX = 100
		sizeY = 260
		resX, resY = getScreenResolution()
		posX = resX / 2 - sizeX / 2
		posY = resY / 2 - sizeY / 2
		y.SetNextWindowPos(y.ImVec2(posX + 100, posY), y.Cond.FirstUseEver)
		y.SetNextWindowSize(y.ImVec2(sizeX, sizeY), y.Cond.FirstUseEver)
		y.Begin("DGUN", windows.dgun, (((((y.WindowFlags.NoResize + y.WindowFlags.NoCollapse) + y.WindowFlags.NoScrollbar) + y.WindowFlags.NoScrollWithMouse) + y.WindowFlags.NoSavedSettings) + y.WindowFlags.AlwaysUseWindowPadding) + y.WindowFlags.ShowBorders)
		if y.Button(Q("Ножик"), y.ImVec2(85, 20)) then
			lua_thread.create(function()
				wait(1)
				sendGiveGun(24)
			end)
		end
		if y.Button(Q("Дигл"), y.ImVec2(85, 20)) then
			startTeleport()
		end
		if y.Button(Q("Ак47"), y.ImVec2(85, 20)) then
			startTeleport()
		end
		if y.Button(Q("МП4"), y.ImVec2(85, 20)) then
			startTeleport()
		end
		if y.Button(Q("Огнимёт"), y.ImVec2(85, 20)) then
			startTeleport()
		end
		if y.Button(Q("Базука"), y.ImVec2(85, 20)) then
			startTeleport()
		end
		if y.Button(Q("Граната"), y.ImVec2(85, 20)) then
			startTeleport()
		end
		if y.Button(Q("Молотов"), y.ImVec2(85, 20)) then
			startTeleport()
		end
		if y.Button(Q("Миниган"), y.ImVec2(85, 20)) then
			startTeleport()
		end
		y.End()
	end
end
function startTeleport()
	local j, p, w, X = getTargetBlipCoordinatesFixed()
	if j then
		if isCharInAnyCar(PLAYER_PED) then
			teleportCar = true
		else
			sampAddChatMessage("{EE82EE}[Multi-Cheat RadmirRP]: {FFFFFF}Сядь в авто!", -1)
		end
	else
		sampAddChatMessage("{EE82EE}[Multi-Cheat RadmirRP]: {FFFFFF}Нету метки!", -1)
	end
end
addEventHandler("onReceivePacket", function(j, p)
	if j == 215 then
		raknetBitStreamIgnoreBits(p, 64)
		local j = raknetBitStreamReadInt32(p)
		if j > 0 and j < 777 then
			text = raknetBitStreamReadString(p, j)
		else
			text = nil
		end
		if text == "Authorization" then
			if other.autologin.v then
				sendLogin(buffer.password.v)
			end
			if other.autoreg.v then
				sendRegister(getRandomMail(random(8, 25)), buffer.password.v, 0, "")
			end
		end
		if text == "playSound(\'train/stop.mp3\', 0, 1)" then
			if other.autoreg.v then
				sendRegister(getRandomMail(random(8, 25)), buffer.password.v, 0, "")
			end
		end
		if nops.anticefpackets.v then
			return false
		end
	end
end)
addEventHandler("onSendPacket", function(j, p)
	if j == 215 then
		raknetBitStreamIgnoreBits(p, 56)
		local j = raknetBitStreamReadString(p, raknetBitStreamReadInt32(p))
		if mains.fine.v and j == "OnPlayerEnterArea" or j == "OnPlayerLeaveArea" then
			return false
		end
		if autoquest and j == "OnInventoryDisplayChange" then
			return false
		end
		if nops.anticefpackets.v then
			return false
		end
	end
	if bpp then
		if id == 204 then
			return false
		end
	end
end)
function getRandomMail(j)
	local p = ""
	for j = 1, j, 1 do
		p = p .. string.char(math.random(97, 122))
	end
	g = p .. "@radmir_cheats.tg"
	return g
end
function getRandomHwid(j)
	local p = ""
	for j = 1, j, 1 do
		p = p .. string.char(math.random(97, 122))
	end
	buffer.hwid.v = p
	return buffer.hwid.v
end
function sendHwidGame(j, p)
	local w = raknetNewBitStream()
	local X = string.upper((require("crypto_lua")).sha1(p .. "71QNzN7t8v"))
	raknetBitStreamWriteInt8(w, 215)
	raknetBitStreamWriteInt16(w, 1)
	raknetBitStreamWriteInt32(w, 51)
	raknetBitStreamWriteInt8(w, j)
	raknetBitStreamWriteInt32(w, #p)
	raknetBitStreamWriteString(w, p)
	raknetBitStreamWriteInt32(w, #X)
	raknetBitStreamWriteString(w, X)
	raknetSendBitStream(w)
	raknetDeleteBitStream(w)
	print(p .. (" : " .. (X .. (" : " .. j))))
end
function sendRegister(j, p, w, X)
	lua_thread.create(function()
		local n = raknetNewBitStream()
		raknetBitStreamWriteInt8(n, 215)
		raknetBitStreamWriteInt16(n, 2)
		raknetBitStreamWriteInt32(n, 0)
		raknetBitStreamWriteInt32(n, 18)
		raknetBitStreamWriteString(n, "OnRegistrationData")
		raknetBitStreamWriteInt32(n, 4)
		raknetBitStreamWriteInt8(n, 115)
		raknetBitStreamWriteInt32(n, #j)
		raknetBitStreamWriteString(n, j)
		raknetBitStreamWriteInt8(n, 115)
		raknetBitStreamWriteInt32(n, #p)
		raknetBitStreamWriteString(n, p)
		raknetSendBitStream(n)
		raknetDeleteBitStream(n)
		wait(2000)
		local A = raknetNewBitStream()
		raknetBitStreamWriteInt8(A, 215)
		raknetBitStreamWriteInt16(A, 2)
		raknetBitStreamWriteInt32(A, 0)
		raknetBitStreamWriteInt32(A, 23)
		raknetBitStreamWriteString(A, "OnRegistrationCharacter")
		raknetBitStreamWriteInt32(A, 6)
		raknetBitStreamWriteInt8(A, 100)
		raknetBitStreamWriteInt32(A, 1)
		raknetBitStreamWriteInt8(A, 100)
		raknetBitStreamWriteInt32(A, 0)
		raknetBitStreamWriteInt8(A, 100)
		raknetBitStreamWriteInt32(A, w)
		raknetSendBitStream(A)
		raknetDeleteBitStream(A)
		wait(1000)
		local y = raknetNewBitStream()
		raknetBitStreamWriteInt8(y, 215)
		raknetBitStreamWriteInt16(y, 2)
		raknetBitStreamWriteInt32(y, 0)
		raknetBitStreamWriteInt32(y, 21)
		raknetBitStreamWriteString(y, "OnRegistrationBonuses")
		raknetBitStreamWriteInt32(y, 2)
		raknetBitStreamWriteInt8(y, 115)
		raknetBitStreamWriteInt32(y, #X)
		raknetBitStreamWriteString(y, X)
		raknetSendBitStream(y)
		raknetDeleteBitStream(y)
	end)
end
function sendLogin(j)
	local p = raknetNewBitStream()
	raknetBitStreamWriteInt8(p, 215)
	raknetBitStreamWriteInt16(p, 2)
	raknetBitStreamWriteInt32(p, 0)
	raknetBitStreamWriteInt32(p, 20)
	raknetBitStreamWriteString(p, "OnAuthorizationStart")
	raknetBitStreamWriteInt32(p, 2)
	raknetBitStreamWriteInt8(p, 115)
	raknetBitStreamWriteInt32(p, #j)
	raknetBitStreamWriteString(p, j)
	raknetSendBitStream(p)
	raknetDeleteBitStream(p)
end
function sendKick()
	local j = raknetNewBitStream()
	raknetBitStreamWriteInt8(j, 215)
	raknetBitStreamWriteInt16(j, 1)
	raknetBitStreamWriteInt32(j, 51)
	raknetBitStreamWriteInt8(j, arg)
	raknetBitStreamWriteInt32(j, 2)
	raknetBitStreamWriteString(j, "-1")
	raknetBitStreamWriteInt32(j, 1)
	raknetBitStreamWriteString(j, "0")
	raknetSendBitStream(j)
	raknetDeleteBitStream(j)
end
w.onVehicleStreamIn = function(j, p)
	if other.car_changer_act.v then
		if p.type == model then
			p.type = buffer.car_change.v
			return {
				j;
				p
			}
		end
	end
end
local a = T.cast("int (__thiscall*)(void*, float*, int, bool)", 6177408)
function getBodyPartCoordinates(j, p)
	local w = getCharPointer(p)
	local X = T.new("float[3]")
	a(T.cast("void*", w), X, j, true)
	return X[0], X[1], X[2]
end
function join_argb(j, p, w, X)
	local n = X
	n = bit.bor(n, bit.lshift(w, 8))
	n = bit.bor(n, bit.lshift(p, 16))
	n = bit.bor(n, bit.lshift(j, 24))
	return n
end
function explode_argb(j)
	local p = bit.band(bit.rshift(j, 24), 255)
	local w = bit.band(bit.rshift(j, 16), 255)
	local X = bit.band(bit.rshift(j, 8), 255)
	local n = bit.band(j, 255)
	return p, w, X, n
end
function w.onPlayerChatBubble(j, p, w, X, n)
	if mains.bubble.v and sampIsPlayerConnected(j) or j == select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)) then
		sampAddChatMessage("{C71585}[ДАЛЬНИЙ ЧАТ]: {" .. (string.sub(bit.tohex(sampGetPlayerColor(j)), 3, 8) .. ("}" .. (sampGetPlayerNickname(j) .. (" [" .. (j .. ("]: " .. ("{" .. (string.sub(bit.tohex(p), 1, 6) .. ("}" .. n))))))))), -1)
	end
end
function sendTeleport(j, p, w, X)
	local n, A, y = getCharCoordinates(PLAYER_PED)
	local q = getDistanceBetweenCoords3d(j, p, w, n, A, y)
	if q <= 5 then
		local X = samp_create_sync_data("vehicle")
		X.position = {
			j;
			p,
			w
		}
		X.send()
	else
		local Q, T, H = j - n, p - A, w - y
		n = n + (5 / q) * Q
		A = A + (5 / q) * T
		y = y + (5 / q) * H
		local F = samp_create_sync_data("vehicle")
		F.position = {
			n;
			A,
			y
		}
		F.send()
		setCharCoordinates(PLAYER_PED, n, A, y)
		if other.time_tp.v then
			wait(X)
		end
		sendTeleport(j, p, w)
		teleportCar = false
	end
end
function getTargetBlipCoordinatesFixed()
	local j, p, w, X = getTargetBlipCoordinates()
	if not j then
		return false
	end
	requestCollision(p, w)
	loadScene(p, w, X)
	local n, A, y, q = getTargetBlipCoordinates()
	return n, A, y, q
end
function w.onSendPlayerSync(j)
	if isPlayerUsingJetpack(0) then
		j.specialAction = 0
	end
	if fakelag then
		return false
	end
	if mains.ghostmode.v then
		j.quaternion[0] = 0 / 0
		printStringNow("Ghost Mode - Activen", 500)
	end
	if other.onfootrv.v then
		local p = getClosestPlayerId(10)
		local w, X = sampGetCharHandleBySampPlayerId(p)
		if w then
			local w, n, A = getCharCoordinates(X)
			j.position = {
				w;
				n,
				A
			}
			j.keysData = 4
			lua_thread.create(function()
				for p = 1, 2000, 1 do
					wait(100)
					j.animationId = 1119
				end
				for p = 0, 3, 1 do
					wait(100)
					j.quaternion[p] = p
				end
			end)
			j.animationFlags = 10000
			j.moveSpeed = {
				-1.1;
				1;
				-0.2
			}
			printStringNow("Rvanim ID: " .. p, 1000)
		end
	end
	if bpp then
		print("vremeno ne rabotaet")
	end
end
function w.onSendVehicleSync(j)
	if other.incarrv.v then
		local p = getClosestPlayerId(20)
		local w, X = sampGetCharHandleBySampPlayerId(p)
		j.moveSpeed = {
			-2.1;
			-2,
			-0.2
		}
		if w then
			local w, n, A = getCharCoordinates(X)
			j.position = {
				w,
				n,
				A
			}
			printStringNow("Rvanim ID: " .. p, 1000)
		end
	end
end
function w.onSendSpawn()
	if mains.autoquest.v then
		AutoQuest()
	end
end
onReceiveRpc = function(j)
	if mains.antistun.v and j == 86 or j == 15 then
		return false
	end
	if nops.setplayerpos.v and j == 12 then
		return false
	end
	if nops.setvehiclepos.v and j == 159 then
		return false
	end
	if nops.entervehicle.v and j == 26 then
		return false
	end
	if nops.exitvehicle.v and j == 154 then
		return false
	end
	if nops.spawn.v and j == 52 then
		return false
	end
	if nops.requestspawn.v and j == 129 then
		return false
	end
	if nops.requestclass.v and j == 128 then
		return false
	end
	if nops.forceclassselection.v and j == 74 then
		return false
	end
	if nops.removeplayerfromvehicle.v and j == 71 then
		return false
	end
end
onSendRpc = function(j, p, w, X, n, A)
	if nops.requestclass.v and j == 128 then
		return false
	end
	if nops.requestspawn.v and j == 129 then
		return false
	end
	if nops.spawn.v and j == 52 then
		return false
	end
	if nops.entervehicle.v and j == 26 then
		return false
	end
	if nops.exitvehicle.v and j == 154 then
		return false
	end
end
function AutoQuest()
	autoquest = true
	local j = raknetNewBitStream()
	raknetBitStreamWriteInt8(j, 215)
	raknetBitStreamWriteInt16(j, 2)
	raknetBitStreamWriteInt32(j, 0)
	raknetBitStreamWriteInt32(j, 13)
	raknetBitStreamWriteString(j, "OnClickQuests")
	raknetBitStreamWriteInt32(j, 2)
	raknetBitStreamWriteInt8(j, 100)
	raknetBitStreamWriteInt32(j, 0)
	raknetSendBitStream(j)
	raknetDeleteBitStream(j)
	local p = raknetNewBitStream()
	raknetBitStreamWriteInt8(p, 215)
	raknetBitStreamWriteInt16(p, 2)
	raknetBitStreamWriteInt32(p, 0)
	raknetBitStreamWriteInt32(p, 24)
	raknetBitStreamWriteString(p, "OnInventoryDisplayChange")
	raknetBitStreamWriteInt32(p, 0)
	raknetSendBitStream(p)
	raknetDeleteBitStream(p)
	local w = raknetNewBitStream()
	raknetBitStreamWriteInt8(w, 215)
	raknetBitStreamWriteInt16(w, 2)
	raknetBitStreamWriteInt32(w, 0)
	raknetBitStreamWriteInt32(w, 18)
	raknetBitStreamWriteString(w, "OnInventoryItemUse")
	raknetBitStreamWriteInt32(w, 4)
	raknetBitStreamWriteInt8(w, 100)
	raknetBitStreamWriteInt32(w, 1)
	raknetBitStreamWriteInt8(w, 100)
	raknetBitStreamWriteInt32(w, 2)
	raknetSendBitStream(w)
	raknetDeleteBitStream(w)
	local X = raknetNewBitStream()
	raknetBitStreamWriteInt8(X, 215)
	raknetBitStreamWriteInt16(X, 2)
	raknetBitStreamWriteInt32(X, 0)
	raknetBitStreamWriteInt32(X, 24)
	raknetBitStreamWriteString(X, "OnInventoryDisplayChange")
	raknetBitStreamWriteInt32(X, 0)
	raknetSendBitStream(X)
	raknetDeleteBitStream(X)
	autoquest = false
end
function sendCrasher()
	local j = raknetNewBitStream()
	local p = {
		3;
		0;
		75;
		133;
		75,
		133;
		18;
		15,
		16,
		18,
		8
	}
	raknetBitStreamWriteInt8(j, 215)
	for w = 1, #p, 1 do
		raknetBitStreamWriteInt8(j, p[w])
	end
	for p = 1, 500, 1 do
		raknetBitStreamWriteInt8(j, 255)
	end
	raknetSendBitStream(j)
	raknetDeleteBitStream(j)
end
function getClosestPlayerId(j)
	local p = -1
	mydist = j
	local w, X, n = getCharCoordinates(PLAYER_PED)
	for j = 0, 999, 1 do
		local A, y = sampGetCharHandleBySampPlayerId(j)
		if A and (getCharHealth(y) > 0 and not sampIsPlayerPaused(y)) then
			local A, q, Q = getCharCoordinates(y)
			local T = getDistanceBetweenCoords3d(w, X, n, A, q, Q)
			if T <= mydist then
				mydist = T
				p = j
			end
		end
	end
	return p
end
function sendGiveGun(j)
	local p = getWeapontypeModel(j)
	requestModel(p)
	loadAllModelsNow()
	giveWeaponToChar(PLAYER_PED, j, 300)
end
function open_menu()
	windows.menu.v = not windows.menu.v
end
function onWindowMessage(p, w, X)
	if p == j.WM_KEYDOWN or p == j.WM_SYSKEYDOWN then
		if w == VK_INSERT and not sampIsCursorActive() then
			windows.menu.v = not windows.menu.v
		end
	end
end
function style()
	y.SwitchContext()
	local j = y.GetStyle()
	local p = j.Colors
	local w = y.Col
	local X = y.ImVec4
	local n = y.ImVec2
	j.WindowRounding = 10
	j.ChildWindowRounding = 10
	j.FrameRounding = 6
	j.ItemSpacing = y.ImVec2(5, 5)
	j.ItemInnerSpacing = y.ImVec2(5, 5)
	j.IndentSpacing = 21
	j.ScrollbarSize = 10
	j.ScrollbarRounding = 13
	j.GrabMinSize = 17
	j.GrabRounding = 16
	j.WindowTitleAlign = y.ImVec2(.5, .5)
	j.ButtonTextAlign = y.ImVec2(.5, .5)
	p[w.Text] = X(.9, .9, .9, 1)
	p[w.TextDisabled] = X(.6, .6, .6, 1)
	p[w.WindowBg] = X(.08, .08, .08, 1)
	p[w.ChildWindowBg] = X(.1, .1, .1, 1)
	p[w.PopupBg] = X(.08, .08, .08, 1)
	p[w.Border] = X(.7, .7, .7, .4)
	p[w.BorderShadow] = X(0, 0, 0, 0)
	p[w.FrameBg] = X(.15, .15, .15, 1)
	p[w.FrameBgHovered] = X(.19, .19, .19, .71)
	p[w.FrameBgActive] = X(.34, .34, .34, .79)
	p[w.TitleBg] = X(0, .69, .33, .8)
	p[w.TitleBgActive] = X(0, .74, .36, 1)
	p[w.TitleBgCollapsed] = X(0, .69, .33, .5)
	p[w.MenuBarBg] = X(0, .8, .38, 1)
	p[w.ScrollbarBg] = X(.16, .16, .16, 1)
	p[w.ScrollbarGrab] = X(0, .69, .33, 1)
	p[w.ScrollbarGrabHovered] = X(0, .82, .39, 1)
	p[w.ScrollbarGrabActive] = X(0, 1, .48, 1)
	p[w.ComboBg] = X(.2, .2, .2, .99)
	p[w.CheckMark] = X(0, .69, .33, 1)
	p[w.SliderGrab] = X(0, .69, .33, 1)
	p[w.SliderGrabActive] = X(0, .77, .37, 1)
	p[w.Button] = X(0, .69, .33, 1)
	p[w.ButtonHovered] = X(0, .82, .39, 1)
	p[w.ButtonActive] = X(0, .87, .42, 1)
	p[w.Header] = X(0, .69, .33, 1)
	p[w.HeaderHovered] = X(0, .76, .37, .57)
	p[w.HeaderActive] = X(0, .88, .42, .89)
	p[w.Separator] = X(1, 1, 1, .4)
	p[w.SeparatorHovered] = X(1, 1, 1, .6)
	p[w.SeparatorActive] = X(1, 1, 1, .8)
	p[w.ResizeGrip] = X(0, .69, .33, 1)
	p[w.ResizeGripHovered] = X(0, .76, .37, 1)
	p[w.ResizeGripActive] = X(0, .86, .41, 1)
	p[w.CloseButton] = X(0, .82, .39, 1)
	p[w.CloseButtonHovered] = X(0, .88, .42, 1)
	p[w.CloseButtonActive] = X(0, 1, .48, 1)
	p[w.PlotLines] = X(0, .69, .33, 1)
	p[w.PlotLinesHovered] = X(0, .74, .36, 1)
	p[w.PlotHistogram] = X(0, .69, .33, 1)
	p[w.PlotHistogramHovered] = X(0, .8, .38, 1)
	p[w.TextSelectedBg] = X(0, .69, .33, .72)
	p[w.ModalWindowDarkening] = X(.17, .17, .17, .48)
end
style()
function y.Hint(j, p, w)
	if y.IsItemHovered() then
		if go_hint == nil then
			go_hint = os.clock() + (p and p or 0)
		end
		local X = (os.clock() - go_hint) * 5
		if os.clock() >= go_hint then
			y.PushStyleVar(y.StyleVar.WindowPadding, y.ImVec2(10, 10))
			y.PushStyleVar(y.StyleVar.Alpha, X <= 1 and X or 1)
			y.PushStyleColor(y.Col.PopupBg, y.ImVec4(.11, .11, .11, 1))
			y.BeginTooltip()
			y.PushTextWrapPos(450)
			y.TextColored((y.GetStyle()).Colors[y.Col.ButtonHovered], Q(" Подсказка:"))
			y.TextUnformatted(j)
			if w ~= nil then
				y.TextColored((y.GetStyle()).Colors[y.Col.TextDisabled], "\n " .. w)
			end
			if not y.IsItemVisible() and (y.GetStyle()).Alpha == 1 then
				go_hint = nil
			end
			y.PopTextWrapPos()
			y.EndTooltip()
			y.PopStyleColor()
			y.PopStyleVar(2)
		end
	end
end
function y.ButtonHex(j, p, w)
	local X = bit.band(bit.rshift(p, 16), 255) / 255
	local n = bit.band(bit.rshift(p, 8), 255) / 255
	local A = bit.band(p, 255) / 255
	y.PushStyleColor(y.Col.Button, y.ImVec4(X, n, A, .6))
	y.PushStyleColor(y.Col.ButtonHovered, y.ImVec4(X, n, A, .8))
	y.PushStyleColor(y.Col.ButtonActive, y.ImVec4(X, n, A, 1))
	local q = y.Button(j, w)
	y.PopStyleColor(3)
	return q
end
function y.TextColoredRGB(j)
	local p = y.GetStyle()
	local w = p.Colors
	local X = y.ImVec4
	local n = function(j)
		local p = bit.band(bit.rshift(j, 24), 255)
		local w = bit.band(bit.rshift(j, 16), 255)
		local X = bit.band(bit.rshift(j, 8), 255)
		local n = bit.band(j, 255)
		return p, w, X, n
	end
	local A = function(j)
		if (j:sub(1, 6)):upper() == "SSSSSS" then
			local p, n, A = w[1].x, w[1].y, w[1].z
			local y = tonumber(j:sub(7, 8), 16) or w[1].w * 255
			return X(p, n, A, y / 255)
		end
		local p = type(j) == "string" and tonumber(j, 16) or j
		if type(p) ~= "number" then
			return
		end
		local A, q, Q, T = n(p)
		return (y.ImColor(A, q, Q, T)):GetVec4()
	end
	local q = function(j)
		for j in j:gmatch("[^\r\n]+") do
			local p, X, n = {}, {}, 1
			j = j:gsub("{(......)}", "{%1FF}")
			while j:find("{........}") do
				local w, y = j:find("{........}")
				local q = A(j:sub(w + 1, y - 1))
				if q then
					p[#p], p[#p + 1] = j:sub(n, w - 1), j:sub(y + 1, #j)
					X[#X + 1] = q
					n = w
				end
				j = j:sub(1, w - 1) .. j:sub(y + 1, #j)
			end
			if p[0] then
				for j = 0, #p, 1 do
					y.TextColored(X[j] or w[1], Q(p[j]))
					y.SameLine(nil, 0)
				end
				y.NewLine()
			else
				y.Text(Q(j))
			end
		end
	end
	q(j)
end
local V = nil
local s = y.ImGlyphRanges({
	A.min_range;
	A.max_range
})
function y.BeforeDrawFrame()
	if V == nil then
		local j = y.ImFontConfig()
		j.MergeMode = true
		V = (y.GetIO()).Fonts:AddFontFromFileTTF("moonloader/lib/fa-solid-900.ttf", 13, j, s)
	end
end
function random(j, p)
	kf = math.random(j, p)
	math.randomseed(os.time() * kf)
	rand = math.random(j, p)
	return tonumber(rand)
end
function samp_create_sync_data(j, p)
	local w = require("ffi")
	local X = require("sampfuncs")
	local n = require("samp.raknet")
	require("samp.synchronization")
	p = p or true
	local A = {
		player = {
			"PlayerSyncData";
			n.PACKET.PLAYER_SYNC;
			sampStorePlayerOnfootData
		};
		vehicle = {
			"VehicleSyncData";
			n.PACKET.VEHICLE_SYNC;
			sampStorePlayerIncarData
		},
		passenger = {
			"PassengerSyncData",
			n.PACKET.PASSENGER_SYNC,
			sampStorePlayerPassengerData
		},
		aim = {
			"AimSyncData";
			n.PACKET.AIM_SYNC,
			sampStorePlayerAimData
		};
		trailer = {
			"TrailerSyncData";
			n.PACKET.TRAILER_SYNC,
			sampStorePlayerTrailerData
		};
		unoccupied = {
			"UnoccupiedSyncData";
			n.PACKET.UNOCCUPIED_SYNC,
			nil
		},
		bullet = {
			"BulletSyncData";
			n.PACKET.BULLET_SYNC,
			nil
		};
		spectator = {
			"SpectatorSyncData",
			n.PACKET.SPECTATOR_SYNC,
			nil
		}
	}
	local y = A[j]
	local q = "struct " .. y[1]
	local Q = w.new(q, {})
	local T = tonumber(w.cast("uintptr_t", w.new(q .. "*", Q)))
	if p then
		local j = y[3]
		if j then
			local w, X
			if p == true then
				w, X = sampGetPlayerIdByCharHandle(PLAYER_PED)
			else
				X = tonumber(p)
			end
			j(X, T)
		end
	end
	local H = function()
		local j = raknetNewBitStream()
		raknetBitStreamWriteInt8(j, y[2])
		raknetBitStreamWriteBuffer(j, T, w.sizeof(Q))
		raknetSendBitStreamEx(j, X.HIGH_PRIORITY, X.UNRELIABLE_SEQUENCED, 1)
		raknetDeleteBitStream(j)
	end
	local F = {
		__index = function(j, p)
			return Q[p]
		end,
		__newindex = function(j, p, w)
			Q[p] = w
		end
	}
	return setmetatable({
		send = H
	}, F)
end