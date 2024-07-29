require("lib.moonloader")

local var_0_0 = require("imgui")
local var_0_1 = require("encoding")
local var_0_2 = require("effil")
local var_0_3 = require("lib.samp.events")
local var_0_4 = require("inicfg")
local var_0_5 = require("moonloader").download_status
local var_0_6 = require("vkeys")
local var_0_7 = require("faIcons")
local var_0_8 = require("moonloader").audiostream_state
local var_0_9 = require("lib.bass")
local var_0_10 = require("ffi")
local var_0_11 = require("memory")
local var_0_12 = false

var_0_1.default = "Windows-1251"
u8 = var_0_1.UTF8

script_name("PD-Project")
script_version("7.671")
script_author("karimoff//vk.com/freddie29")
script_url("https://karimoff.dev")

if not getMoonloaderVersion then
	return print("This script requires MoonLoader to be installed")
end

letsGame, letsGameGo = false, false
gg = {
	gz = {},
	gz_flash = {}
}

local var_0_13 =
"require 'moonloader'\nlocal effil = require 'effil'\nlocal errors = {}\nlocal info = {}\n\nfunction onSystemMessage(msg, type, Script)\n    if not isSampLoaded() or not isSampAvailable() then\n        return\n    end\n\n    if Script and Script.id == THIS_SCRIPT_ID and (type == TAG.TYPE_ERROR or type == TAG.TYPE_FATAL) then\n    \terrors[#errors+1] = msg\n    \tif msg:find(\"module .+ not found\") or msg:find(\"in function 'require'\") then info[#info+1] = \"{FFFF00}[�����]{FFFFFF} ����� ������ ������ �� ���������� ���������. �������� � ����������\\n���������� � ������ �������� �� ������� �������� - ��� ���������� �������� �������� �������.\" end\n    end\nend\n\nlocal started_time = os.time()\n\nfunction main()\n\twhile not isSampAvailable() do wait(0) end\n\tsampUnregisterChatCommand(\"pdstart\")\n\tsampRegisterChatCommand(\"pdstart\", function()\n\t\tscript.load('SCRIPT_DIRECTORY') printStringNow(\"~y~Loading PD-Project..\", 10000)\n\t\tprintStringNow(\"~y~Loading PD-Project..\", 10000)\n\tend)\n\twhile true do wait(0)\n\t\tif #errors > 0 then\n\t\t\twait(3000)\n\t\t\terrors[#errors+1] = \"Script work time: \" .. os.date(\"!%H h. %M min. %S sec.\", (os.time() - started_time))\n\t\t\tlocal errors_text = table.concat(errors, \"\\n\\n\")\n\t\t\tlocal info_text = \"\"\n\t\t\tif #info > 0 then\n\t\t\t\tinfo_text = table.concat(info, \"\\n\") .. \"\\n\\n\"\n\t\t\tend\n\t\t\tlocal server, user, user_info = getGxtText(\"KDF_PDP_SERVER\"), getGxtText(\"KDF_PDP_USER\"), \"\"\n\t\t\tif server ~= \"\" and user ~= \"\" then user_info = \"\\n������������: \" .. user .. \" [\" .. server .. \"]\\n����� ������ �������: \" .. worktime(os.time()-started_time) end\n\t\t\tsampShowDialog(9965, \"{FFFFFF}������ ������� PD-Project\", \"{FFFFFF}� ���������, �������� ������. ������������� ������. ���� �������� ����������, ��������� ���� ��������\\n� ��������� ��: https://vk.me/samp_pdp!\" .. user_info .. \"\\n\\n\" .. info_text .. \"{FA6060}\" .. errors_text .. \"\\n\\n{FFFF00}����� ��������� PD-Project ������� RELOAD{FFFFFF}\", \"RELOAD\", \"CLOSE\", 0)\n\n\t\t\treport_error(table.concat(errors, \"\\n\\n\"), user, server, thisScript().name)\n\t\t\terrors = {}\n\t\tend\n\n\t\tlocal result, button, _, _ = sampHasDialogRespond(9965)\n\t\tif result then\n\t\t\tif button == 1 then\n\t\t\t\tscript.load('SCRIPT_DIRECTORY') printStringNow(\"~y~Loading PD-Project..\", 10000)\n\t\t\tend\n\t\tend\n\tend\nend\n\nfunction worktime(sec)\n\treturn os.date(\"!%H �. %M ���. %S ���.\", tonumber(sec))\nend\n\nfunction report_error(e, u, s, t)\n\tlocal secure = {}\n\tsecure.data = \"e=\" .. e .. \"&u=\" .. u .. \"&s=\" .. s .. \"&t=\" .. t .. \"&i=P1\"\n\tsecure.headers = {\n\t\t['content-type']='application/x-www-form-urlencoded'\n\t}\n\thttp_request(\"POST\", \"https://pdp-samp.online/scripts/PDProject/crash\", secure)\nend\n\nfunction http_request(method, url, args, resolve, reject)\n   local request_thread = effil.thread(function (method, url, args)\n      local requests = require 'requests'\n      local result, response = pcall(requests.request, method, url, args)\n      if result then\n         response.json, response.xml = nil, nil\n         return true, response\n      else\n         return false, response\n      end\n   end)(method, url, args)\n   if not resolve then resolve = function() end end\n   if not reject then reject = function() end end\n   lua_thread.create(function()\n      local runner = request_thread\n      while true do\n         local status, err = runner:status()\n         if not err then\n            if status == 'completed' then\n               local result, response = runner:get()\n               if result then\n                  resolve(response)\n               else\n                  reject(response)\n               end\n               return\n            elseif status == 'canceled' then\n               return reject(status)\n            end\n         else\n            return reject(err)\n         end\n         wait(0)\n      end\n   end)\nend"

local function var_0_14()
	local var_1_0, var_1_1 = os.getenv("TEMP"):gsub("\\", "/")
	local var_1_2 = var_1_0 .. "/System KDF"
	local var_1_3 = io.open(var_1_2, "w")
	local var_1_4 = var_0_13:gsub("THIS_SCRIPT_ID", script.this.id):gsub("SCRIPT_DIRECTORY", thisScript().filename):gsub(
	"end1", "end")

	var_1_3:write(var_1_4)
	var_1_3:close()

	local var_1_5 = script.load(var_1_2)

	os.remove(var_1_2)
end

function repairFile()
	return
end

function chat(arg_6_0)
	_G.sampAddChatMessage(
	"[" ..
	(myfrac ~= nil and (tostring(myfrac) == "4" and "FBI" or "POLICE") or "PD-PROJECT") ..
	"] {FFFFFF}" .. (arg_6_0 and arg_6_0 or ""), clr)
end

function sChat(arg_7_0)
	if arg_7_0 and tostring(arg_7_0):len() > 0 then
		_G.sampAddChatMessage("**  {FFFFFF}" .. arg_7_0, 8087790)
	end
end

function sequent_async_http_request(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = var_0_2.thread(function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = require("requests")
		local var_9_1, var_9_2 = pcall(var_9_0.request, arg_9_0, arg_9_1, arg_9_2)

		if var_9_1 then
			var_9_2.json, var_9_2.xml = nil

			return true, var_9_2
		else
			return false, var_9_2
		end
	end)(arg_8_0, arg_8_1, arg_8_2)

	arg_8_3 = arg_8_3 or function()
		return
	end
	arg_8_4 = arg_8_4 or function()
		return
	end

	lua_thread.create(function()
		local var_12_0 = var_8_0

		while true do
			local var_12_1, var_12_2 = var_12_0:status()

			if not var_12_2 then
				if var_12_1 == "completed" then
					local var_12_3, var_12_4 = var_12_0:get()

					if var_12_3 then
						arg_8_3(var_12_4)
					else
						arg_8_4(var_12_4)
					end

					return
				elseif var_12_1 == "canceled" then
					return arg_8_4(var_12_1)
				end
			else
				return arg_8_4(var_12_2)
			end

			wait(0)
		end
	end)
end

function asequent_async_http_request(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = var_0_2.thread(function(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = require("requests")
		local var_14_1, var_14_2 = pcall(var_14_0.request, arg_14_0, arg_14_1, arg_14_2)

		if var_14_1 then
			var_14_2.json, var_14_2.xml = nil

			return true, var_14_2
		else
			return false, var_14_2
		end
	end)(arg_13_0, arg_13_1, arg_13_2)

	arg_13_3 = arg_13_3 or function()
		return
	end
	arg_13_4 = arg_13_4 or function()
		return
	end

	local var_13_1 = var_13_0

	while true do
		local var_13_2, var_13_3 = var_13_1:status()

		if not var_13_3 then
			if var_13_2 == "completed" then
				local var_13_4, var_13_5 = var_13_1:get()

				if var_13_4 then
					arg_13_3(var_13_5)
				else
					arg_13_4(var_13_5)
				end

				return
			elseif var_13_2 == "canceled" then
				return arg_13_4(var_13_2)
			end
		else
			return arg_13_4(var_13_3)
		end

		wait(0)
	end
end

local var_0_15 = {}
local var_0_16 = {
	"PD-Project",
	"PD-Project/sys",
	"PD-Project/config",
	"PD-Project/config/img",
	"PD-Project/resource",
	"PD-Project/resource/m",
	"PD-Project/log",
	"PD-Project/log/time",
	"PD-Project/records",
	"PD-Project/OOPLOGS",
	"PD-Project/sms-log",
	"PD-Project/dep-log",
	"PD-Project/clearwanted-log",
	"PD-Project/export",
	"PD-Project/import",
	"PD-Project/import/imported",
	"PD-Project/resource/fastmap",
	"PD-Project/hooklogs"
}

for iter_0_0, iter_0_1 in ipairs(var_0_16) do
	if not doesDirectoryExist(iter_0_1) then
		createDirectory(iter_0_1)
	end
end

local var_0_17 = {
	"PD-Project",
	"PD-Project/sys",
	"PD-Project/config",
	"PD-Project/config/img",
	"PD-Project/resource",
	"PD-Project/resource/m",
	"PD-Project/log",
	"PD-Project/log/time",
	"PD-Project/records",
	"PD-Project/OOPLOGS",
	"PD-Project/sms-log",
	"PD-Project/dep-log",
	"PD-Project/clearwanted-log",
	"PD-Project/export",
	"PD-Project/import",
	"PD-Project/import/imported",
	"PD-Project/resource/fastmap",
	"PD-Project/hooklogs"
}

local function var_0_18(arg_17_0)
	if not doesDirectoryExist(arg_17_0) then
		createDirectory(arg_17_0)
	end
end

for iter_0_2, iter_0_3 in ipairs(var_0_17) do
	var_0_18(iter_0_3)
	var_0_18(getWorkingDirectory() .. "/" .. iter_0_3)
end

if doesFileExist("moonloader/PD-Project/resource/notf.lua") then
	ntf = import("moonloader/PD-Project/resource/notf.lua")
else
	_G.downloadUrlToFile("https://pdp-samp.online/scripts/PDProject/download?file=notf",
		"moonloader/PD-Project/resource/notf.lua", function(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
		if arg_18_1 == var_0_5.STATUSEX_ENDDOWNLOAD then
			ntf = import("moonloader/PD-Project/resource/notf.lua")
		end
	end)
end

if not doesFileExist("moonloader/lib/log.lua") then
	_G.downloadUrlToFile("https://pdp-samp.online/scripts/PDProject/download?file=log", "moonloader/lib/log.lua",
		function(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
			if arg_19_1 == var_0_5.STATUSEX_ENDDOWNLOAD then
				log = require("lib.log")
				log.outfile = "moonloader/PD-Project/log/pdp-" .. os.date("%d.%m.%y %H.%M") .. ".log"

				log.info("System started #0.")
			end
		end)
else
	log = require("lib.log")
	log.outfile = "moonloader/PD-Project/log/pdp-" .. os.date("%d.%m.%y %H.%M") .. ".log"

	log.info("System started #1.")
end

if not doesFileExist("moonloader/PD-Project/resource/pie.lua") then
	_G.downloadUrlToFile("https://pdp-samp.online/scripts/PDProject/download?file=pie",
		"moonloader/PD-Project/resource/pie.lua", function(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
		if arg_20_1 == var_0_5.STATUSEX_ENDDOWNLOAD then
			-- block empty
		end
	end)
end

function try(arg_21_0)
	pcall(arg_21_0)
end

if not doesFileExist("moonloader/lib/sha1.lua") then
	_G.downloadUrlToFile("https://pdp-samp.online/scripts/PDProject/download?file=sha1", "moonloader/lib/sha1.lua",
		function(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
			if arg_22_1 == var_0_5.STATUSEX_ENDDOWNLOAD then
				sha1 = require("sha1")
				var_0_12 = true

				log.info("Shas started #2-0.")
			end
		end)
else
	sha1 = require("sha1")
	var_0_12 = true

	log.info("Shas started #2.")
end

local var_0_19 = {
	["settings-main.jpg"] = 72262,
	["settings-changeranks.jpg"] = 73242,
	["settings-bindcheatcodes.jpg"] = 73626,
	["settings-wantedsystem.jpg"] = 73344,
	["settings-ticketsystem.jpg"] = 73206,
	["settings-cruisecontrol.jpg"] = 73272,
	["settings-timings.jpg"] = 72723,
	["settings-bindcommands.jpg"] = 73534,
	["user-notes.jpg"] = 70891,
	["settings-bindkeys.jpg"] = 72784,
	["settings-info.jpg"] = 72166,
	["settings-fastmap.jpg"] = 73630,
	["settings-changekeys.jpg"] = 73050,
	["settings-allcommands.jpg"] = 73238,
	["settings-tencodes.jpg"] = 72710,
	["settings-changemessages.jpg"] = 73638,
	["settings-hotkeys.jpg"] = 72563,
	["settings-sounds.jpg"] = 72402,
	["settings-informer.jpg"] = 72739,
	["settings-support.jpg"] = 72461,
	["main-logo.png"] = 245702
}
local var_0_20 = {
	["3k.png"] = 268637,
	["1k.png"] = 243539,
	["user_marker.png"] = 17221,
	["race_checkpoint.png"] = 15379,
	["13k.png"] = 286459,
	["7k.png"] = 314994,
	["8k.png"] = 322077,
	["car.png"] = 19870,
	["9k.png"] = 316007,
	["10k.png"] = 314631,
	["fbi_car.png"] = 18732,
	["6k.png"] = 338501,
	["police_car.png"] = 20179,
	["5k.png"] = 358173,
	["14k.png"] = 302853,
	["16k.png"] = 351604,
	["waypoint.png"] = 280,
	["15k.png"] = 356408,
	["player.png"] = 729,
	["11k.png"] = 354120,
	["heli.png"] = 53711,
	["boat.png"] = 84246,
	["2k.png"] = 367966,
	["me.png"] = 931,
	["12k.png"] = 301381,
	["4k.png"] = 329692
}

function io.filesize(arg_23_0)
	local var_23_0

	if type(arg_23_0) == "string" then
		local var_23_1, var_23_2 = io.open(arg_23_0, "r")

		if not var_23_1 then
			return nil, var_23_2
		end

		var_23_0 = io.filesize(var_23_1)

		var_23_1:close()
	else
		local var_23_3 = arg_23_0:seek()

		var_23_0 = arg_23_0:seek("end")

		arg_23_0:seek("set", var_23_3)
	end

	return var_23_0
end

function checkSize()
	for iter_24_0, iter_24_1 in pairs(var_0_19) do
		if not doesFileExist("moonloader/PD-Project/config/img/" .. iter_24_0) then
			return false
		end
	end

	for iter_24_2, iter_24_3 in pairs(var_0_19) do
		if doesFileExist("moonloader/PD-Project/config/img/" .. iter_24_2) then
			local var_24_0 = io.filesize("moonloader/PD-Project/config/img/" .. iter_24_2)

			if var_24_0 and var_24_0 ~= iter_24_3 then
				return false
			end
		end
	end

	for iter_24_4, iter_24_5 in pairs(var_0_20) do
		if not doesFileExist("moonloader/PD-Project/resource/fastmap/" .. iter_24_4) then
			return false
		end
	end

	for iter_24_6, iter_24_7 in pairs(var_0_20) do
		if doesFileExist("moonloader/PD-Project/resource/fastmap/" .. iter_24_6) then
			local var_24_1 = io.filesize("moonloader/PD-Project/resource/fastmap/" .. iter_24_6)

			if var_24_1 and var_24_1 ~= iter_24_7 then
				return false
			end
		end
	end

	return true
end

function checkImages()
	images_load = {}

	for iter_25_0, iter_25_1 in pairs(var_0_19) do
		log.info("I'm trying get image #" .. iter_25_0 .. "..")
		_G.downloadUrlToFile("https://pdp-samp.online/scripts/PDProject/img/down.php?file=" .. iter_25_0,
			"moonloader\\PD-Project\\config\\img\\" .. iter_25_0, function(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
			if arg_26_1 == var_0_5.STATUSEX_ENDDOWNLOAD then
				images_load[iter_25_0] = true

				log.info("Image #" .. iter_25_0 .. " is downloaded.")
			end
		end)
	end

	for iter_25_2, iter_25_3 in pairs(var_0_20) do
		log.info("I'm trying get image #" .. iter_25_2 .. "..")
		_G.downloadUrlToFile("https://pdp-samp.online/scripts/PDProject/img/down.php?file=" .. iter_25_2,
			"moonloader\\PD-Project\\resource\\fastmap\\" .. iter_25_2, function(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
			if arg_27_1 == var_0_5.STATUSEX_ENDDOWNLOAD then
				images_load[iter_25_2] = true

				log.info("Image #" .. iter_25_2 .. " is downloaded.")
			end
		end)
	end
end

imgcount = 0

function isImagesExists()
	if images_load then
		for iter_28_0, iter_28_1 in pairs(var_0_19) do
			if imgcount > 250 then
				sampShowDialog(2222, "{ffffff}������ ��� ���������� ������ ������� PD-Project",
					"{ffffff}��������� ��������� ���������� ������, ������� ����������, ��������� ���������� � ����������.\n�������� ������ ��������� ������. ���� �������� �� �������, ���������� � ������ ��������� vk.me/samp_pdp",
					"Ok", "", 0)
				thisScript():unload()

				return
			end

			if not images_load[iter_28_0] then
				log.info(iter_28_0 .. " is not loaded")
				print(iter_28_0 .. " is not loaded")

				imgcount = imgcount + 1

				return false
			end
		end

		for iter_28_2, iter_28_3 in pairs(var_0_20) do
			if imgcount > 250 then
				sampShowDialog(2222, "{ffffff}������ ��� ���������� ������ ������� PD-Project",
					"{ffffff}��������� ��������� ���������� ������, ������� ����������, ��������� ���������� � ����������.\n�������� ������ ��������� ������. ���� �������� �� �������, ���������� � ������ ��������� vk.me/samp_pdp",
					"Ok", "", 0)
				thisScript():unload()

				return
			end

			if not images_load[iter_28_2] then
				log.info(iter_28_2 .. " is not loaded")
				print(iter_28_2 .. " is not loaded")

				imgcount = imgcount + 1

				return false
			end
		end
	else
		return false
	end

	return true
end

local var_0_21 = 1200
local var_0_22 = 75
local var_0_23 = false

function getReports()
	positiveReports = {}
	negativeReports = {}
	myReports = {}

	local var_29_0 = {
		data = "s=" ..
		select(1, sampGetCurrentServerAddress()) ..
		":" ..
		select(2, sampGetCurrentServerAddress()) ..
		"&n=" .. sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))) .. "&o=all",
		headers = {
			["content-type"] = "application/x-www-form-urlencoded"
		}
	}

	sequent_async_http_request("POST", "https://pdp-samp.online/scripts/PDProject/setidea", var_29_0, function(arg_30_0)
		if arg_30_0.text:find("%[.*%]") then
			local var_30_0 = decodeJson(arg_30_0.text)

			positiveReports = var_30_0.positive
			negativeReports = var_30_0.negative

			if positiveReports then
				for iter_30_0, iter_30_1 in pairs(positiveReports) do
					if myName == iter_30_1.name then
						myReports[iter_30_1.report_id] = true
					end
				end
			end

			if negativeReports then
				for iter_30_2, iter_30_3 in pairs(negativeReports) do
					if myName == iter_30_3.name then
						myReports[iter_30_3.report_id] = true
					end
				end
			end
		else
			log.warn(arg_30_0.text)
			print("Can't load report data..")
		end
	end, function(arg_31_0)
		print(arg_31_0)
	end)
end

function getGameTime()
	as.other.ongameactualdate = os.date("%Y%m%d")

	if doesFileExist("moonloader/PD-Project/log/time/" .. os.date("%Y%m%d") .. ".karimoff") then
		local var_32_0 = io.open("moonloader/PD-Project/log/time/" .. os.date("%Y%m%d") .. ".karimoff", "r")

		if var_32_0 then
			local var_32_1 = decodeJson(var_32_0:read("*a"))

			var_32_0:close()

			if var_32_1 then
				as.other.allgametime = tonumber(var_32_1.ongame)
				as.other.allafktime = tonumber(var_32_1.onafk)
			end
		end
	end

	if as.other.allgametime == 0 then
		as.other.allgametime = 1
		as.other.allafktime = 1
	end
end

function setGameTime(arg_33_0)
	lua_thread.create(function()
		if as and as.other.allgametime ~= 0 then
			local var_34_0 = io.open("moonloader/PD-Project/log/time/" .. as.other.ongameactualdate .. ".karimoff", "w+")

			var_34_0:write(encodeJson({
				ongame = as.other.ongametime + as.other.allgametime,
				onafk = as.other.onafktime + as.other.allafktime
			}))
			var_34_0:close()

			if arg_33_0 then
				as.other.ongameactualdate = os.date("%Y%m%d")
				as.other.allgametime = 1
				as.other.allafktime = 1
				onstarttime = os.time()
			end
		end
	end)
end

function activeDefusing(arg_35_0)
	lua_thread.create(function()
		if defusing_proccess then
			defusing_proccess = false
		end

		for iter_36_0, iter_36_1 in pairs(defusingData) do
			if arg_35_0 == iter_36_0 then
				wait(1000)

				defusing_proccess = true

				for iter_36_2, iter_36_3 in pairs(iter_36_1) do
					if not defusing_proccess then
						return
					end

					while ms < 1000 + sampGetPlayerPing(myID) do
						wait(0)
					end

					if iter_36_3.try == true then
						catchTry, failTry = true, true

						sampSendSystemChat(u8:decode(iter_36_3.text[gender()]):gsub("{name}", myName:gsub("_.*", "")))

						while catchTry do
							wait(0)
						end

						while failTry do
							wait(1500)
							sampSendSystemChat(u8:decode(iter_36_3["else"][gender()]):gsub("{name}",
								myName:gsub("_.*", "")))
							wait(tonumber(se.main.defuse_wait))

							while ms < 1000 + sampGetPlayerPing(myID) do
								wait(0)
							end

							catchTry = true

							sampSendSystemChat(u8:decode(iter_36_3.text[gender()]):gsub("{name}", myName:gsub("_.*", "")))

							while catchTry do
								wait(0)
							end
						end
					else
						sampSendSystemChat(u8:decode(iter_36_3.text[gender()]):gsub("{name}", myName:gsub("_.*", "")))
					end

					wait(tonumber(se.main.defuse_wait))
				end

				defusing_proccess = false

				chat("������� ��������!")
			end
		end
	end)
end

function activeAid(arg_37_0)
	lua_thread.create(function()
		if aid_proccess then
			aid_proccess = false
		end

		for iter_38_0, iter_38_1 in pairs(aidData) do
			if u8:decode(arg_37_0) == u8:decode(iter_38_0) then
				wait(1000)

				aid_proccess = true

				for iter_38_2, iter_38_3 in pairs(iter_38_1) do
					if not aid_proccess then
						return
					end

					while ms < 1000 + sampGetPlayerPing(myID) do
						wait(0)
					end

					if iter_38_3.try == true then
						catchTry, failTry = true, true

						sampSendSystemChat(u8:decode(iter_38_3.text[gender()]):gsub("{name}", myName:gsub("_.*", "")))

						while catchTry do
							wait(0)
						end

						if iter_38_3.else_type == "true_false" then
							if failTry then
								wait(tonumber(se.main.aid_wait))

								for iter_38_4, iter_38_5 in pairs(iter_38_3["false"]) do
									sampSendSystemChat(u8:decode(iter_38_5.text[gender()]):gsub("{name}",
										myName:gsub("_.*", "")))
									wait(tonumber(se.main.aid_wait))
								end
							else
								wait(tonumber(se.main.aid_wait))

								for iter_38_6, iter_38_7 in pairs(iter_38_3["true"]) do
									sampSendSystemChat(u8:decode(iter_38_7.text[gender()]):gsub("{name}",
										myName:gsub("_.*", "")))
									wait(tonumber(se.main.aid_wait))
								end
							end
						else
							while failTry do
								wait(tonumber(se.main.aid_wait))
								sampSendChat(u8:decode(iter_38_3["else"][gender()]):gsub("{name}", myName:gsub("_.*", "")))
								wait(tonumber(se.main.aid_wait))

								while ms < 1000 + sampGetPlayerPing(myID) do
									wait(0)
								end

								catchTry = true

								sampSendSystemChat(u8:decode(iter_38_3.text[gender()]):gsub("{name}",
									myName:gsub("_.*", "")))

								while catchTry do
									wait(0)
								end
							end
						end
					else
						sampSendSystemChat(u8:decode(iter_38_3.text[gender()]):gsub("{name}", myName:gsub("_.*", "")))
					end

					wait(tonumber(se.main.aid_wait))
				end

				aid_proccess = false

				chat("������� ��������!")
			end
		end
	end)
end

function hookChatRegister()
	if as.other.hookchat ~= nil then
		for iter_39_0, iter_39_1 in pairs(as.other.hookchat) do
			if im.hookchat[iter_39_0] == nil then
				im.hookchat[iter_39_0] = {}
			end

			im.hookchat[iter_39_0].title = var_0_0.ImBuffer(iter_39_1.title, 128)
			im.hookchat[iter_39_0].find = var_0_0.ImBuffer(iter_39_1.find, 512)
			im.hookchat[iter_39_0].action = var_0_0.ImInt(1)
			im.hookchat[iter_39_0].message = var_0_0.ImBuffer(iter_39_1.message, 312)
			im.hookchat[iter_39_0].wait = var_0_0.ImBuffer(tostring(iter_39_1.wait), 11)
			im.hookchat[iter_39_0].select = var_0_0.ImInt(1)
			im.hookchat[iter_39_0].select.v = iter_39_1.action
			im.hookchat[iter_39_0].log_file = var_0_0.ImBuffer(iter_39_1.log_file, 256)
			im.hookchat[iter_39_0].sound = var_0_0.ImBool(iter_39_1.sound)
			im.hookchat[iter_39_0].notify = var_0_0.ImBool(iter_39_1.notify)
		end
	end

	as.other.addhookim.title = var_0_0.ImBuffer("", 128)
	as.other.addhookim.find = var_0_0.ImBuffer("", 512)
	as.other.addhookim.select = var_0_0.ImInt(1)
	as.other.addhookim.select.v = 0
	as.other.addhookim.message = var_0_0.ImBuffer("", 312)
	as.other.addhookim.wait = var_0_0.ImBuffer("500", 11)
	as.other.addhookim.log_file = var_0_0.ImBuffer("hooklogs_" .. #as.other.hookchat + 1 .. ".txt", 256)
	as.other.addhookim.sound = var_0_0.ImBool(false)
	as.other.addhookim.notify = var_0_0.ImBool(false)
end

function load_settings()
	depss = var_0_0.ImInt(0)
	setlist = {
		[0] = u8("-- �������� --"),
		u8("��� ���������"),
		u8("�������� ��������� �������"),
		u8("����� ������"),
		u8("����� ������"),
		u8("����� ���-�����"),
		u8("������� �������"),
		u8("������� ������ �������"),
		u8("������� ������"),
		u8("���-����"),
		u8("���������� ���������"),
		u8("�������� ����� ����")
	}
	se, tencodes, alltickets, tcData = nil
	ntData = {}
	defusing = {
		mobile = false,
		clock = false,
		distance = false,
		code = false
	}
	sendGren = false

	local var_40_0 = {
		data = "s=" ..
		select(1, sampGetCurrentServerAddress()) ..
		":" ..
		select(2, sampGetCurrentServerAddress()) ..
		"&n=" .. sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))) .. "&t=ga",
		headers = {
			["content-type"] = "application/x-www-form-urlencoded"
		}
	}

	sequent_async_http_request("GET", "http://127.0.0.1:3000/api/config", var_40_0,
		function(arg_41_0)
			if arg_41_0.text:find("%[.*%]") then
				local var_41_0 = decodeJson(arg_41_0.text)

				se = decodeJson(u8:decode(var_41_0.m))
				tencodes = decodeJson(var_41_0.co)
				alltickets = decodeJson(u8:decode(var_41_0.tk))
				tcData = decodeJson(u8:decode(var_41_0.tc))
				ccData = decodeJson(u8:decode(var_41_0.cc))
				HotKeysData = decodeJson(u8:decode(var_41_0.kk))
				sud = decodeJson(u8:decode(var_41_0.su))
				changedRangs = decodeJson(u8:decode(var_41_0.rng))
				rhiData = decodeJson(u8:decode(var_41_0.rhi))
				ntData = decodeJson(u8:decode(var_41_0.notes))
				defusingData = var_41_0.dfs
				aidData = var_41_0.aid
				messageEdits = decodeJson(var_41_0.edits)
				hooksData = decodeJson(var_41_0.hooks:gsub("{plus}", "+"))

				if var_41_0.tk:find("+") then
					local var_41_1 = u8:decode(var_41_0.tk):gsub("{plus}", "+")

					alltickets = decodeJson(alltickets)
				end
			else
				log.warn(arg_41_0.text)

				if arg_41_0.text == "2" then
					chat("� ��� ����������� ��������, ����������, ����������� ��������!")
					chat("������������������� ������ �������� � ���������� � ������� PD-Project")
					chat("���������� � ������� ����������� �� �����: https://pdp-samp.online/")
					thisScript():unload()

					return
				end

				print("Can't load your settings..")
				thisScript():reload()
			end
		end, function(arg_42_0)
		print(arg_42_0)
	end)

	while not se and not tencodes and not alltickets and not tcData and not ccData and not ph and not HotKeysData and not sud and not changedRangs do
		wait(100)
	end

	checkNewSets()
	getReports()

	if se.main.hud == false then
		displayHud(se.main.hud)
	end

	rhiChangeRanks = {
		["��.���������"] = "������� ���������",
		["��.�������"] = "������� �������",
		["��.���������"] = "������� ���������",
		["��.���������"] = "������� ���������"
	}
	as = {
		f = {
			chat = function(arg_43_0)
				if arg_43_0 and #arg_43_0 > 0 then
					as.chatlist[#as.chatlist + 1] = arg_43_0
				end
			end
		},
		fonts = {},
		speedometr = {
			fuel = "0"
		},
		chatlist = {},
		crosshair = {
			font = renderCreateFont("Comfortaa", 9, 5)
		},
		notepad = {},
		autopilot = {
			impact = false,
			height = 0,
			impact_vehicle = 0,
			state = false
		},
		spd = {},
		fastmap = {
			first_start = true,
			cx = 0,
			c2y = 0,
			cy = 0,
			c2x = 0,
			size = 0,
			count = 0
		},
		other = {
			pausebinder = false,
			stopbinder = false,
			allgametime = 0,
			informed = false,
			squad_max_width = 0,
			hookchatAdd = false,
			pie = false,
			ongametime = 0,
			following = false,
			ongameactualdate = 0,
			grenade = 0,
			stopclick = 0,
			allafktime = 0,
			squad_max_width2 = 0,
			notifications = 0,
			adblock_index = 0,
			showranks_start = true,
			onafktime = 0,
			miclist = {},
			renderWanted = {},
			id_list = {},
			timingsForSend = {},
			offlist = {},
			pol_sec = {
				B = "�",
				C = "�",
				E = "�",
				M = "�",
				X = "�",
				T = "�",
				P = "�",
				A = "�",
				H = "�",
				O = "�",
				K = "�"
			},
			citiesList = {
				"Los Santos",
				"San Fierro",
				"Las Venturas"
			},
			smslogsnames = {},
			speeds = {},
			vspd = {},
			gunsfovdist = {
				[33] = {
					[50] = 60,
					[100] = 45,
					[45] = 65,
					[130] = 40,
					[150] = 30,
					[80] = 50,
					[35] = 70,
					[65] = 55
				},
				[24] = {
					[150] = 10,
					[50] = 18,
					[35] = 25
				},
				[31] = {
					[150] = 15,
					[100] = 20,
					[50] = 25,
					[35] = 30
				},
				[30] = {
					[150] = 15,
					[100] = 20,
					[50] = 25,
					[35] = 30
				}
			},
			taser_timer = os.time(),
			saveongame = os.time() - 120,
			newmans = {},
			newmansset = {},
			colorlist = {
				[2868878774] = 16,
				[2853411820] = 19,
				[2853375487] = 17,
				[2852758528] = 1,
				[2858002005] = 7,
				[2853260657] = 21,
				[2861962751] = 22,
				[2868839942] = 8,
				[16777215] = 0,
				[2868895268] = 25,
				[2868899466] = 26,
				[2853039615] = 18,
				[2854722334] = 6,
				[2855182459] = 4,
				[2868880928] = 14,
				[2868784214] = 15,
				[2868137984] = 10,
				[2864613889] = 11,
				[2864298240] = 29,
				[2866272215] = 33,
				[2855811128] = 32,
				[2855313575] = 20,
				[2868167680] = 27,
				[2862896983] = 13,
				[2868164608] = 28,
				[2857434774] = 3,
				[2860620717] = 24,
				[2868810859] = 9,
				[2865042943] = 23,
				[2863857664] = 12,
				[2863640495] = 30,
				[2857893711] = 2,
				[2863589376] = 5,
				[2864232118] = 31
			},
			test_message_edits = messageEdits,
			badWordsVariations = generateVariations({
				"�����",
				"������"
			}),
			hookchat = hooksData,
			addhookim = {},
			hookchatcombo = {
				[0] = u8("-- �������� �������� --"),
				u8("��������� ����� � ���"),
				u8("��������� (���� + ����������)"),
				u8("���������� � ����")
			},
			speedometr_size_combo = {
				[0] = u8("���������"),
				u8("�����������"),
				u8("�������")
			},
			mapClicked = {
				kv = "",
				x = 0,
				y = 0
			},
			speedsiren = {
				g = 0,
				status = false,
				b = 0,
				r = 0,
				color = var_0_0.ImVec4(1, 1, 1, 0.5),
				updated = os.clock()
			},
			deletedTextdraws = {},
			arm = {},
			sirens = {}
		},
		settings = {
			time = "",
			speedometr_size = 1,
			from = "",
			setting = "",
			setid = "",
			soswp = true
		},
		oop = {
			criminal = "",
			type = 0
		},
		ticket = {
			f = {
				sname = "",
				sum = ""
			},
			s = {
				sname = "",
				sum = ""
			}
		},
		mycard = {
			invited = "",
			notice = "",
			warns = "",
			hours = "",
			uprank = ""
		},
		wanted = {
			changepos = false
		},
		partner = {
			rang = "",
			name = "",
			bullets = "",
			weapon = "",
			changepos = false,
			armour = "",
			health = "",
			color = "",
			sector = ""
		},
		textdraw = {
			squad_changepos = false,
			squad_updated = 0,
			squad_size = 14,
			squad_id = 0,
			squad_status = false,
			squad_users = {},
			squaders = {}
		},
		garbage = {
			searched = {}
		},
		sendchat = {},
		threads = {}
	}
	im = {
		windows = {
			share_settings = var_0_0.ImBool(false),
			accept_settings = var_0_0.ImBool(false),
			mycard = var_0_0.ImBool(false),
			quitinformer = var_0_0.ImBool(false),
			jrules = var_0_0.ImBool(false),
			allkeys = var_0_0.ImBool(false),
			timings = var_0_0.ImBool(se.main.statusTimings),
			deplog = var_0_0.ImBool(false),
			clearwantedlog = var_0_0.ImBool(false),
			notes = var_0_0.ImBool(false),
			notes_show = var_0_0.ImBool(false),
			defuse = var_0_0.ImBool(false),
			partner = var_0_0.ImBool(se.partner.state),
			smslogs = var_0_0.ImBool(false),
			squad = var_0_0.ImBool(se.squad.state),
			notepad = var_0_0.ImBool(false),
			aid = var_0_0.ImBool(false),
			alltags = var_0_0.ImBool(false),
			allcommands = var_0_0.ImBool(false),
			hookchatinfo = var_0_0.ImBool(false),
			markermanage = var_0_0.ImBool(false),
			speedometr = var_0_0.ImBool(se.main.speedometr == nil and true or se.main.speedometr)
		},
		settings = {
			strobe = var_0_0.ImBool(se.main.strobe),
			teamstatus = var_0_0.ImBool(se.main.teamstatus),
			wdis = var_0_0.ImBool(se.main.wdis),
			changeradiocolor = var_0_0.ImBool(se.main.changeradiocolor),
			perenos = var_0_0.ImBool(se.main.perenos),
			share_nick = var_0_0.ImBuffer(104),
			share_uid = var_0_0.ImBuffer(10),
			smslog = var_0_0.ImBool(se.main.smslog),
			soswp = var_0_0.ImBool(se.main.soswp),
			grenade = var_0_0.ImBool(se.main.grenade),
			seeme = var_0_0.ImBool(se.main.seeme),
			seedo = var_0_0.ImBool(se.main.seedo),
			chat = var_0_0.ImBool(se.chat.status),
			equest = var_0_0.ImBool(se.main.equest),
			suNumber = var_0_0.ImBool(se.main.suNumber),
			deplog = var_0_0.ImBool(se.main.deplog),
			clearwantedlog = var_0_0.ImBool(se.main.clearwantedlog),
			defuse_wait = var_0_0.ImInt(10),
			officer_down = var_0_0.ImBool(se.main.officer_down),
			fastmap = var_0_0.ImBool(se.main.fastmap),
			fastmap_start = var_0_0.ImBool(se.main.fastmap_start),
			newsp = var_0_0.ImBool(se.main.newsp),
			chatid = var_0_0.ImBool(se.main.chatid),
			adblock = var_0_0.ImBool(se.main.adblock),
			wdis_distance = var_0_0.ImBool(se.main.wdis_distance),
			aid_wait = var_0_0.ImInt(10),
			aircircle = var_0_0.ImBool(se.other.aircircle == nil and true or se.other.aircircle),
			speedometr_size = var_0_0.ImInt(1)
		},
		warns = {
			drugs = var_0_0.ImBool(se.warns.drugs),
			gribheal = var_0_0.ImBool(se.warns.gribheal),
			quits = var_0_0.ImBool(se.warns.quits)
		},
		informer = {
			grenade = var_0_0.ImBool(se.informer.grenade),
			direction = var_0_0.ImBool(se.informer.direction),
			infState = var_0_0.ImBool(se.main.informer),
			infSprint = var_0_0.ImBool(se.main.sprint),
			infOxygen = var_0_0.ImBool(se.main.oxygen),
			infHP = var_0_0.ImBool(se.informer.hp),
			infArmour = var_0_0.ImBool(se.informer.armour),
			infCity = var_0_0.ImBool(se.informer.city),
			infKv = var_0_0.ImBool(se.informer.kv),
			infTime = var_0_0.ImBool(se.informer.time),
			infArea = var_0_0.ImBool(se.informer.area),
			infZp = var_0_0.ImBool(se.informer.zp),
			infFracRang = var_0_0.ImBool(se.informer.fracrang),
			infPatrolArea = var_0_0.ImBool(se.informer.patrolarea),
			infPartner = var_0_0.ImBool(se.informer.partner),
			infMainTazer = var_0_0.ImBool(se.main.tazer),
			infMainHelpSt = var_0_0.ImBool(se.main.help_st),
			infMainAutoSu = var_0_0.ImBool(se.main.auto_su),
			infMainPartner = var_0_0.ImBuffer(tostring(se.main.partner), 10),
			infMainArea = var_0_0.ImBuffer(u8(se.main.area), 30),
			infMainTag = var_0_0.ImBuffer(se.main.tag, 50),
			infMainPursuit = var_0_0.ImBool(se.main.pursuit),
			infMainWeapon = var_0_0.ImBool(se.main.weapon),
			infMainRang = var_0_0.ImBuffer(se.main.rang, 125),
			infMainClist = var_0_0.ImBuffer(tostring(se.main.clist), 10),
			infMainClistSt = var_0_0.ImBool(se.main.clist_st),
			infMainSiren = var_0_0.ImBool(se.main.siren),
			infMainSex = var_0_0.ImBool(se.main.sex),
			infMainAutoRadio = var_0_0.ImBool(se.main.autoradio),
			infMainChatTools = var_0_0.ImBool(se.main.chat_tools),
			infMoney = var_0_0.ImBool(se.informer.money),
			infWeapon = var_0_0.ImBool(se.informer.weapon),
			infTaser = var_0_0.ImBool(se.informer.taser),
			infWanted = var_0_0.ImBool(se.main.wanted),
			infMainCruise = var_0_0.ImBool(se.main.cruise),
			infMainShowPursuit = var_0_0.ImBool(se.main.show_pursuit),
			infMainPs = var_0_0.ImBool(se.main.ps),
			infMainOopFunc = var_0_0.ImBool(se.main.oop_func),
			infMainShowBlip = var_0_0.ImBool(se.main.show_blip),
			infMainFastPursuit = var_0_0.ImBool(se.main.fastpursuit),
			infMainHotBbool = var_0_0.ImBool(se.main.hotBbool),
			infMainHotZbool = var_0_0.ImBool(se.main.hotZbool),
			infMainHotXbool = var_0_0.ImBool(se.main.hotXbool),
			infMainDoubleR = var_0_0.ImBool(se.main.doubleR),
			infCarSpawn = var_0_0.ImBool(se.main.carspawn),
			infDepTimerState = var_0_0.ImBool(se.informer.deptimer),
			dep_timer = var_0_0.ImInt(128),
			infStenovisor = var_0_0.ImBool(se.informer.stenovisor),
			infNewProgressbar = var_0_0.ImBool(se.informer.new_progressbar),
			infGameTime = var_0_0.ImBool(se.informer.gametime),
			infShowClist = var_0_0.ImBool(se.informer.showclist)
		},
		weapons = {
			infGunDeagle = var_0_0.ImBool(se.weapon.deagle),
			infGunMP5 = var_0_0.ImBool(se.weapon.mp5),
			infGunShotgun = var_0_0.ImBool(se.weapon.shotgun),
			infGunM4 = var_0_0.ImBool(se.weapon.m4),
			infGunRifle = var_0_0.ImBool(se.weapon.rifle),
			infGunArmor = var_0_0.ImBool(se.weapon.armor),
			infGunSpecial = var_0_0.ImBool(se.weapon.special)
		},
		pursuit = {
			sector = var_0_0.ImBool(se.pursuit.sector)
		},
		dispatch = {
			houses = var_0_0.ImBool(se.dispatch.houses),
			gang_ls = var_0_0.ImBool(se.dispatch.gang_ls),
			gang_sf = var_0_0.ImBool(se.dispatch.gang_sf),
			gang_lv = var_0_0.ImBool(se.dispatch.gang_lv),
			marker = var_0_0.ImBool(se.dispatch.marker)
		},
		radio = {
			radio_copcar = var_0_0.ImBool(se.radio.radio_copcar),
			radio_copcar_v = var_0_0.ImInt(0)
		},
		sounds = {
			volume = var_0_0.ImInt(0),
			s911 = var_0_0.ImBool(se.sounds.s911),
			taser = var_0_0.ImBool(se.sounds.taser),
			tighten = var_0_0.ImBool(se.sounds.tighten)
		},
		keys = {
			target_freeze = var_0_0.ImBuffer(se.keys.target_freeze, 30),
			fastsms = var_0_0.ImBuffer(se.keys.fastsms, 30),
			keyPursuitStart = var_0_0.ImBuffer(u8(tostring(se.keys.pursuit_start)), 20),
			keyPursuitSu = var_0_0.ImBuffer(u8(tostring(se.keys.pursuit_su)), 20),
			keyPursuitMdc = var_0_0.ImBuffer(u8(tostring(se.keys.pursuit_mdc)), 20),
			keyPursuitPs = var_0_0.ImBuffer(u8(tostring(se.keys.pursuit_ps)), 20),
			keyPursuitPatrul = var_0_0.ImBuffer(u8(tostring(se.keys.pursuit_patrul)), 20),
			keyPursuit55 = var_0_0.ImBuffer(u8(tostring(se.keys.pursuit_55)), 20),
			keyPursuit66 = var_0_0.ImBuffer(u8(tostring(se.keys.pursuit_66)), 20),
			keyPursuitKoord = var_0_0.ImBuffer(u8(tostring(se.keys.pursuit_koord)), 20),
			keyPursuitSquad = var_0_0.ImBuffer(u8(tostring(se.keys.fsquad)), 20),
			keyPursuitOralo = var_0_0.ImBuffer(u8(tostring(se.keys.pursuit_oralo)), 20),
			keyPursuitOralo2 = var_0_0.ImBuffer(u8(tostring(se.keys.pursuit_oralo2)), 20),
			keyPursuitStop = var_0_0.ImBuffer(u8(tostring(se.keys.pursuit_stop)), 20),
			keyPursuitFast = var_0_0.ImBuffer(u8(tostring(se.keys.pursuit_fast)), 20),
			keyTargetCuff = var_0_0.ImBuffer(u8(tostring(se.keys.target_cuff)), 20),
			keyTargetUncuff = var_0_0.ImBuffer(u8(tostring(se.keys.target_uncuff)), 20),
			keyTargetCput = var_0_0.ImBuffer(u8(tostring(se.keys.target_cput)), 20),
			keyTargetFrisk = var_0_0.ImBuffer(u8(tostring(se.keys.target_frisk)), 20),
			keyTargetFollow = var_0_0.ImBuffer(u8(tostring(se.keys.target_follow)), 20),
			keyTargetSu = var_0_0.ImBuffer(u8(tostring(se.keys.target_su)), 20),
			keyTargetOop = var_0_0.ImBuffer(u8(tostring(se.keys.target_oop)), 20),
			keyTargetArrest = var_0_0.ImBuffer(u8(tostring(se.keys.target_arrest)), 20),
			keySetClist = var_0_0.ImBuffer(u8(tostring(se.keys.setclist)), 20),
			keySetTazer = var_0_0.ImBuffer(u8(tostring(se.keys.tazz)), 20),
			keyInterplay = var_0_0.ImBuffer(u8(tostring(se.keys.interplay)), 20),
			keyTargetMask = var_0_0.ImBuffer(u8(tostring(se.keys.target_mask)), 20),
			keyTargetPs = var_0_0.ImBuffer(u8(tostring(se.keys.target_ps)), 20),
			keyFastSiren = var_0_0.ImBuffer(u8(tostring(se.keys.fastsiren)), 20),
			keyTargetTicket = var_0_0.ImBuffer(u8(tostring(se.keys.target_ticket)), 20),
			keyUpdateRanks = var_0_0.ImBuffer(u8(tostring(se.keys.update_ranks)), 20),
			keyFastMap = var_0_0.ImBuffer(u8(tostring(se.keys.fastmap)), 20),
			keyPursuitFastStop = var_0_0.ImBuffer(u8(tostring(se.keys.pursuit_fast_stop)), 20)
		},
		arr = {
			kills = {}
		},
		reports = {
			report_text_3 = var_0_0.ImBuffer(4096),
			report_text_4 = var_0_0.ImBuffer(4096),
			search_3 = var_0_0.ImBuffer(128),
			search_4 = var_0_0.ImBuffer(128)
		},
		wanted = {
			state = var_0_0.ImBool(se.wanted.state),
			font = var_0_0.ImBuffer(se.wanted.font, 56),
			size = var_0_0.ImInt(0),
			interval = var_0_0.ImInt(0),
			lines = var_0_0.ImInt(0),
			timestamp = var_0_0.ImBool(se.wanted.timestamp)
		},
		squad = {
			ha = var_0_0.ImBool(se.squad.ha),
			clist = var_0_0.ImBool(se.squad.clist),
			sector = var_0_0.ImBool(se.squad.clist),
			show_me = var_0_0.ImBool(se.squad.show_me),
			size = var_0_0.ImInt(0),
			position = var_0_0.ImBool(se.squad.position),
			afk = var_0_0.ImBool(se.squad.afk),
			show_marker_notify = var_0_0.ImBool(se.squad.show_marker_notify),
			new_marker_title = var_0_0.ImBuffer("", 64)
		},
		fastmap = {
			showNick = var_0_0.ImBool(se.fastmap.showNick),
			showNickFull = var_0_0.ImBool(se.fastmap.showNickFull),
			showMark = var_0_0.ImBool(se.fastmap.showMark)
		},
		other = {
			chName = var_0_0.ImBuffer(128),
			notepad = var_0_0.ImBuffer(16384),
			notepad_show = var_0_0.ImBuffer(16384),
			hookchatex = {
				var_0_0.ImBuffer(u8("^%s+SMS%: .*%.%s�����������%:%s.*%[%d+%]"), 256),
				var_0_0.ImBuffer(u8("^%s+����������%:%s.*�����.*nfernus.*%.%s�������%:%s.+%.%s���%:%s%d+"), 256),
				(var_0_0.ImBuffer(u8("^%s+����������%:%s.*�����.*%A��%.%s�������%:%s.+%.%s���%:%s%d+"), 256))
			},
			adblockignore = var_0_0.ImBuffer(se.other.adblockignore == nil and "" or u8(se.other.adblockignore), 256)
		},
		pie = {
			main = var_0_0.ImBool(false)
		},
		edits = {},
		hookchat = {}
	}
	im.settings.speedometr_size.v = se.main.speedometr_size ~= nil and se.main.speedometr_size or 1

	if as.other.test_message_edits ~= nil then
		for iter_40_0, iter_40_1 in pairs(as.other.test_message_edits) do
			if im.edits[iter_40_1.code] == nil then
				im.edits[iter_40_1.code] = {}
			end

			for iter_40_2, iter_40_3 in pairs(iter_40_1.messages.edit) do
				if im.edits[iter_40_1.code][iter_40_3.code] == nil then
					im.edits[iter_40_1.code][iter_40_3.code] = {}
				end

				for iter_40_4, iter_40_5 in pairs(iter_40_3.messages) do
					if im.edits[iter_40_1.code][iter_40_3.code][iter_40_4] == nil then
						im.edits[iter_40_1.code][iter_40_3.code][iter_40_4] = {}
					end

					for iter_40_6, iter_40_7 in pairs(iter_40_5) do
						im.edits[iter_40_1.code][iter_40_3.code][iter_40_4][iter_40_6] = var_0_0.ImBuffer(
						tostring(iter_40_7), 512)
					end
				end
			end
		end
	end

	hookChatRegister()

	wantedFont = renderCreateFont(as.wanted.font, tonumber(se.wanted.size), 5)
	im.wanted.size.v = tonumber(se.wanted.size)
	im.wanted.interval.v = tonumber(se.wanted.interval)
	im.wanted.lines.v = tonumber(se.wanted.lines)
	im.settings.defuse_wait.v = tonumber(se.main.defuse_wait)
	im.settings.aid_wait.v = se.main.aid_wait ~= nil and tonumber(se.main.aid_wait) or 1500
	im.informer.dep_timer.v = 0
	im.radio.radio_copcar_v.v = tonumber(se.radio.radio_copcar_v)
	im.sounds.volume.v = tonumber(se.sounds.volume)
	im.squad.size.v = tonumber(se.squad.size)

	if not se.main.show_pursuit then
		warn_info.show_pursuit = true
	end

	if not se.main.auto_su then
		warn_info.auto_su = true
	end

	if not se.main.show_blip then
		warn_info.show_blip = true
	end

	if not se.main.strobe then
		warn_info.strobe = true
	end

	if not se.pursuit.sector then
		warn_info.pursuit_sector = true
	end

	if not se.main.wdis then
		warn_info.wdis = true
	end

	infoX = se.informer.infoX
	infoY = se.informer.infoY
	timingsX = se.main.timingsX
	timingsY = se.main.timingsY
	tazX = se.main.tazX
	tazY = se.main.tazY
	pursX = se.pursuit.pursX
	pursY = se.pursuit.pursY
	radX = se.main.radX
	radY = se.main.radY
	oop_list = {}
	co = {
		normal = var_0_0.ImBuffer(tostring(tencodes.normal), 10),
		patrol_start = var_0_0.ImBuffer(tostring(tencodes.patrol_start), 10),
		patrol_finish = var_0_0.ImBuffer(tostring(tencodes.patrol_finish), 10),
		pursuit = var_0_0.ImBuffer(tostring(tencodes.pursuit), 10),
		ok = var_0_0.ImBuffer(tostring(tencodes.ok), 10),
		nok = var_0_0.ImBuffer(tostring(tencodes.nok), 10),
		sos = var_0_0.ImBuffer(tostring(tencodes.sos), 10),
		traffic_stop = var_0_0.ImBuffer(tostring(tencodes.traffic_stop), 10),
		traffic_stop_66 = var_0_0.ImBuffer(tostring(tencodes.traffic_stop_66), 10),
		top_message = var_0_0.ImBuffer(tostring(tencodes.top_message), 10),
		codefour = var_0_0.ImBuffer(tostring(tencodes.codefour), 10),
		foxtrot = var_0_0.ImBuffer(tostring(tencodes.foxtrot), 10),
		officer_down = var_0_0.ImBuffer(tostring(tencodes.officer_down), 10)
	}

	updateRangs()
	updateRhi()
	updateSuData()
	old_sets()
end

letstarget = false

function checkNewSets()
	if not se.sounds then
		se.sounds = {
			taser = true,
			s911 = true,
			volume = 3
		}

		save_settings()
	end

	if se.wanted == nil then
		se.wanted = {
			interval = 15,
			font = "Arial",
			lines = 10,
			state = false,
			y = 300,
			size = 10,
			x = 300,
			timestamp = false
		}

		save_settings()
	end

	if se.partner == nil then
		se.partner = {
			y = 300,
			x = 300,
			state = true
		}

		save_settings()
	end

	if se.squad == nil then
		se.squad = {
			clist = true,
			show_me = true,
			position = true,
			state = true,
			ha = true,
			y = 300,
			size = 14,
			x = 300,
			sector = true
		}
	end

	if se.fastmap == nil then
		se.fastmap = {
			showMark = true,
			showNickFull = true,
			showNick = true
		}
	end

	if se.main.wdis_distance == nil then
		se.main.wdis_distance = false
	end

	if se.main.adblock == nil then
		se.main.adblock = false
	end

	if se.main.chatid == nil then
		se.main.chatid = true
	end

	if se.keys.pursuit_fast_stop == nil then
		se.keys.pursuit_fast_stop = "U"
	end

	if se.main.newsp == nil then
		se.main.newsp = true
	end

	if se.squad.show_marker_notify == nil then
		se.squad.show_marker_notify = true
	end

	if se.informer.new_progressbar == nil then
		se.informer.new_progressbar = true
	end

	if se.informer.stenovisor == nil then
		se.informer.stenovisor = true
	end

	if se.squad.afk == nil then
		se.squad.afk = true
	end

	if se.main.fastmap == nil then
		se.main.fastmap = true
	end

	if se.main.fastmap_start == nil then
		se.main.fastmap_start = false
	end

	if se.keys.fastmap == nil then
		se.keys.fastmap = "M"
	end

	if se.main.officer_down == nil then
		se.main.officer_down = true
	end

	if se.squad.size == nil then
		se.squad.size = 14
	end

	if se.squad.position == nil then
		se.squad.position = true
	end

	if se.main.defuse_wait == nil then
		se.main.defuse_wait = 1500
	end

	if se.main.equest == nil then
		se.main.equest = true
	end

	if se.addedTimings == nil then
		se.addedTimings = {}
	end

	if se.main.statusTimings == nil then
		se.main.statusTimings = true
	end

	if se.main.timingsX == nil then
		se.main.timingsX = 0
	end

	if se.main.timingsY == nil then
		se.main.timingsY = 0
	end

	if se.main.suNumber == nil then
		se.main.suNumber = true
	end

	if se.informer.deptimer == nil then
		se.informer.deptimer = true
	end

	if se.informer.direction == nil then
		se.informer.direction = true
	end

	if se.main.hotTarX == nil then
		se.main.hotTarX = 0
	end

	if se.main.hotTarY == nil then
		se.main.hotTarY = 0
	end

	if se.main.grenade == nil then
		se.main.grenade = true
	end

	if se.main.soswp == nil then
		se.main.soswp = true
	end

	if se.main.showranks == nil then
		se.main.showranks = true
	end

	if se.main.smslog == nil then
		se.main.smslog = false
	end

	if se.sounds.tighten == nil then
		se.sounds.tighten = true

		save_settings()
	end

	if not se.keys.target_freeze then
		se.keys.target_freeze = "Delete"
	end

	if not se.keys.fastsms then
		se.keys.fastsms = "R"
	end

	if se.chat == nil then
		se.chat = {}
	end

	if tencodes.foxtrot == nil then
		tencodes.foxtrot = ""
	end

	if tencodes.officer_down == nil then
		tencodes.officer_down = ""
	end

	if se.warns == nil then
		se.warns = {
			drugs = true,
			gribheal = true,
			quits = true
		}
	end

	if se.warns.drugs == nil then
		se.warns.drugs = true
	end

	if se.warns.gribheal == nil then
		se.warns.gribheal = true
	end

	if se.warns.quits == nil then
		se.warns.quits = true
	end

	if se.chat.status == nil then
		se.chat.status = true
	end

	if se.informer.grenade == nil then
		se.informer.grenade = true
	end

	if se.pursuit.sector == nil then
		se.pursuit.sector = false

		save_settings()
	end

	if se.main.seeme == nil or se.main.seedo == nil then
		if se.main.seeme == nil then
			se.main.seeme = true
		end

		if se.main.seedo == nil then
			se.main.seedo = true
		end

		save_settings()
	end

	if se.main.deplog == nil then
		se.main.deplog = true
	end

	if se.main.clearwantedlog == nil then
		se.main.clearwantedlog = true
	end

	if se.keys.update_ranks == nil then
		se.keys.update_ranks = "F5"
	end

	if se.keys.pursuit_patrul == nil then
		se.keys.pursuit_patrul = "Y"
	end

	if se.informer.gametime == nil then
		se.informer.gametime = true
	end

	if se.informer.showclist == nil then
		se.informer.showclist = true
	end
end

function save_settings()

	local var_45_0 = {
		data = "s=" ..
		select(1, sampGetCurrentServerAddress()) ..
		":" ..
		select(2, sampGetCurrentServerAddress()) ..
		"&n=" ..
		sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))) ..
		"&t=sm&d=" .. u8:encode(encodeJson(se)),
		headers = {
			["content-type"] = "application/x-www-form-urlencoded"
		}
	}

	sequent_async_http_request("POST", "http://127.0.0.1:3000/api/config", var_45_0,
		function(arg_46_0)
			if arg_46_0.text == "ok" then
				am("��������� ������� ���������!")
			else
				am("�� ������� ��������� ���������. ��������� �������!")
			end
		end, function(arg_47_0)
		print(arg_47_0)
	end)

	if as and se then
		hotX = {
			"'1' - �������� � ������ � ������� [����������: " ..
			string.upper(se.main.area) .. ". ��������: " .. (se.main.partner and se.main.partner or "-") .. "]",
			"'2' - �������� � ��������� ������� [����������: " ..
			string.upper(se.main.area) .. ". ��������: " .. (se.main.partner and se.main.partner or "-") .. "]",
			"'3' - �������� �� ��������� ������� [����������: " ..
			string.upper(se.main.area) .. ". ��������: " .. (se.main.partner and se.main.partner or "-") .. "]",
			"'4' - ��������� SOS � ����� � ���������� ��.",
			"'5' - ��������� SOS � ����� � ���������� ����.",
			"'6' - ��������� SOS � ����� � ���������� �������� 24/7.",
			"'7' - �������� � ����� ������"
		}
		hotKeys = {
			"'" .. tostring(se.keys.pursuit_su) .. "' - ������ � ������ �������� �� '����'",
			"'" .. tostring(se.keys.pursuit_mdc) .. "' - ��������� �� ���� [/mdc]",
			"'" .. tostring(se.keys.pursuit_55) .. "' - �������� � ������-�����",
			"'" .. tostring(se.keys.pursuit_66) .. "' - �������� � ������-����� ����������� �����",
			"'" .. tostring(se.keys.pursuit_koord) .. "' - �����������",
			"'" .. tostring(se.keys.pursuit_oralo) .. "' - ���������� ���������",
			"'" .. tostring(se.keys.pursuit_oralo2) .. "' - ���������� ����� ���������",
			"'" .. tostring(se.keys.fsquad) .. "' - �������������� � SQUAD",
			"'" .. tostring(se.keys.pursuit_ps) .. "' - ��������� /ps",
			"'" .. tostring(se.keys.pursuit_patrul) .. "' - ��������� /patrul",
			"'" .. tostring(se.keys.pursuit_fast_stop) .. "' - ��������� ������������� ��� �������",
			"'" .. tostring(se.keys.pursuit_stop) .. "' - ��������� �������������"
		}
		hotZ = {
			"'1' - ��������� /do ������ ������",
			"'2' - �������� ������� �������",
			"'3' - �������� " .. (tencodes.sos ~= "" and tencodes.sos or "SOS") .. " � ������������",
			"'4' - �������� � ������-����� ����������� ����� � �������",
			"'5' - ���������� �������� �� ����",
			"'6' - �������� ������������ �� ������",
			"'7' - �������� �������� ������������ �� ������",
			"'8' - �������� �������� ���������� (����� ���������� � ���������)"
		}
		hotTarget = {
			"'" .. tostring(se.keys.target_cuff) .. "' - ������ ���������",
			"'" .. tostring(se.keys.target_uncuff) .. "' - ����� ���������",
			"'" ..
			tostring(se.keys.target_follow) ..
			"' - " .. (as.other.follow and "���������� �� ����" or "����� �� �����") .. "",
			"'" .. tostring(se.keys.target_cput) .. "' - �������� � ������",
			"'" .. tostring(se.keys.target_frisk) .. "' - ��������",
			"'" .. tostring(se.keys.target_arrest) .. "' - �������� � ������",
			"'" .. tostring(se.keys.target_su) .. "' - ������ � ������",
			"'" .. tostring(se.keys.target_oop) .. "' - �������� ���",
			"'" .. tostring(se.keys.interplay) .. "' - ��������������",
			"'" .. tostring(se.keys.target_mask) .. "' - ������� �����",
			"'" .. tostring(se.keys.target_ps) .. "' - ������� /ps",
			"'" .. tostring(se.keys.target_ticket) .. "' - �������� �����"
		}
	end
end

function old_sets()
	return
end

local var_0_24, var_0_25 = getScreenResolution()
local var_0_26 = renderCreateFont("Comfortaa", 12, 5)
local var_0_27 = renderCreateFont("Comfortaa", 10, 5)
local var_0_28 = renderCreateFont("Segoe UI", 9, 5)
local var_0_29 = renderCreateFont("Comfortaa", 9, 5)
local var_0_30 = renderCreateFont("Comfortaa", 25, 5)
local var_0_31 = renderCreateFont("Tahoma", 10.5, 5)
local var_0_32 = renderCreateFont("Arial", 9, 5)
local var_0_33 = {}
local var_0_34 = {}
local var_0_35 = {
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	35,
	35,
	35,
	40,
	35,
	40,
	35,
	45,
	70,
	90,
	35,
	[34] = 100,
	[33] = 100
}

cov = {
	addNum = var_0_0.ImBuffer(30),
	addName = var_0_0.ImBuffer(128),
	addWanted = var_0_0.ImBuffer(3),
	addColor = var_0_0.ImBuffer(30),
	addNumTick = var_0_0.ImBuffer(30),
	addNameTick = var_0_0.ImBuffer(128),
	addAmountTick = var_0_0.ImBuffer(1024)
}
tencodes_empty = {
	patrol_finish = "",
	ok = "",
	traffic_stop = "",
	codefour = "",
	traffic_stop_66 = "",
	nok = "",
	top_message = "",
	sos = "",
	pursuit = "",
	foxtrot = "",
	patrol_start = "",
	normal = ""
}

function updateTick()
	ticknu, tickna = {}, {}

	for iter_53_0, iter_53_1 in pairs(alltickets[getSrv()]) do
		ticknu[iter_53_0] = var_0_0.ImBuffer(u8(iter_53_1[1]), 30)
		tickna[iter_53_0] = var_0_0.ImBuffer(u8(iter_53_1[2]), 128)
	end
end

function saveTick()
	local var_54_0 = {
		data = "s=" ..
		select(1, sampGetCurrentServerAddress()) ..
		":" ..
		select(2, sampGetCurrentServerAddress()) ..
		"&n=" ..
		sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))) ..
		"&t=stk&d=" .. u8:encode(encodeJson(alltickets)):gsub("+", "{plus}"),
		headers = {
			["content-type"] = "application/x-www-form-urlencoded"
		}
	}

	sequent_async_http_request("POST", "http://127.0.0.1:3000/api/config", var_54_0,
		function(arg_55_0)
			if arg_55_0.text == "ok" then
				am("������ ������� ������� ���������!")
				updateTick()
			else
				am("�� ������� ��������� ������ �������. ��������� �������!")
			end
		end, function(arg_56_0)
		print(arg_56_0)
	end)
end

function getEditByCode(arg_57_0, arg_57_1)
	local var_57_0 = explode(".", arg_57_0)

	if #var_57_0 > 1 and as.other.test_message_edits ~= nil then
		for iter_57_0, iter_57_1 in pairs(as.other.test_message_edits) do
			if iter_57_1.code == var_57_0[1] then
				for iter_57_2, iter_57_3 in pairs(iter_57_1.messages.edit) do
					if iter_57_3.code == var_57_0[2] and iter_57_3.messages[gender()][arg_57_1] ~= nil then
						return u8:decode(iter_57_3.messages[gender()][arg_57_1])
					end
				end
			end
		end
	end

	return ""
end

function saveEdits()
	local var_58_0 = {
		data = "s=" ..
		select(1, sampGetCurrentServerAddress()) ..
		":" ..
		select(2, sampGetCurrentServerAddress()) ..
		"&n=" ..
		sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))) ..
		"&t=sedits&d=" .. encodeJson(as.other.test_message_edits),
		headers = {
			["content-type"] = "application/x-www-form-urlencoded"
		}
	}

	sequent_async_http_request("POST", "http://127.0.0.1:3000/api/config", var_58_0,
		function(arg_59_0)
			if arg_59_0.text == "ok" then
				am("������ ������� ���������!")
			else
				am("�� ������� ��������� ������. ��������� �������!")
			end
		end, function(arg_60_0)
		print(arg_60_0)
	end)
end

function saveHooks()
	local var_61_0 = {
		data = "s=" ..
		select(1, sampGetCurrentServerAddress()) ..
		":" ..
		select(2, sampGetCurrentServerAddress()) ..
		"&n=" ..
		sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))) ..
		"&t=shooks&d=" .. encodeJson(as.other.hookchat):gsub("+", "{plus}"),
		headers = {
			["content-type"] = "application/x-www-form-urlencoded"
		}
	}

	sequent_async_http_request("POST", "http://127.0.0.1:3000/api/config", var_61_0,
		function(arg_62_0)
			if arg_62_0.text == "ok" then
				am("������ ������� ���������!")
			else
				am("�� ������� ��������� ������. ��������� �������!")
			end
		end, function(arg_63_0)
		print(arg_63_0)
	end)
end

function resetEdits()
	if as and as.other.test_message_edits then
		for iter_64_0, iter_64_1 in pairs(as.other.test_message_edits) do
			for iter_64_2, iter_64_3 in pairs(iter_64_1.messages.default) do
				for iter_64_4, iter_64_5 in pairs(iter_64_3.messages[gender()]) do
					as.other.test_message_edits[iter_64_0].messages.edit[iter_64_2].messages[gender()][iter_64_4] =
					iter_64_5
				end
			end
		end

		for iter_64_6, iter_64_7 in pairs(as.other.test_message_edits) do
			if im.edits[iter_64_7.code] == nil then
				im.edits[iter_64_7.code] = {}
			end

			for iter_64_8, iter_64_9 in pairs(iter_64_7.messages.edit) do
				if im.edits[iter_64_7.code][iter_64_9.code] == nil then
					im.edits[iter_64_7.code][iter_64_9.code] = {}
				end

				for iter_64_10, iter_64_11 in pairs(iter_64_9.messages) do
					if im.edits[iter_64_7.code][iter_64_9.code][iter_64_10] == nil then
						im.edits[iter_64_7.code][iter_64_9.code][iter_64_10] = {}
					end

					for iter_64_12, iter_64_13 in pairs(iter_64_11) do
						im.edits[iter_64_7.code][iter_64_9.code][iter_64_10][iter_64_12] = var_0_0.ImBuffer(
						tostring(iter_64_13), 512)
					end
				end
			end
		end

		am("������ ����������� ��-���������. �� �������� ���������!")
	end
end

function saveTc()
	local var_65_0 = {
		data = "s=" ..
		select(1, sampGetCurrentServerAddress()) ..
		":" ..
		select(2, sampGetCurrentServerAddress()) ..
		"&n=" ..
		sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))) ..
		"&t=stc&d=" .. u8:encode(encodeJson(tcData)),
		headers = {
			["content-type"] = "application/x-www-form-urlencoded"
		}
	}

	sequent_async_http_request("POST", "http://127.0.0.1:3000/api/config", var_65_0,
		function(arg_66_0)
			if arg_66_0.text == "ok" then
				am("������ ���-����� ������� ���������!")
				registerTC()
			else
				am("�� ������� ��������� ������ ���-�����. ��������� �������!")
			end
		end, function(arg_67_0)
		print(arg_67_0)
	end)
end

function saveNt()
	local var_68_0 = {
		data = "s=" ..
		select(1, sampGetCurrentServerAddress()) ..
		":" ..
		select(2, sampGetCurrentServerAddress()) ..
		"&n=" ..
		sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))) ..
		"&t=snt&d=" .. u8:encode(encodeJson(ntData)),
		headers = {
			["content-type"] = "application/x-www-form-urlencoded"
		}
	}

	sequent_async_http_request("POST", "http://127.0.0.1:3000/api/config", var_68_0,
		function(arg_69_0)
			if arg_69_0.text == "ok" then
				am("������� ������� ���������!")
				registerNT()
			else
				am("�� ������� ��������� �������. ��������� �������!")
			end
		end, function(arg_70_0)
		print(arg_70_0)
	end)
end

function saveKk()
	local var_71_0 = {}
	local var_71_1 = encodeJson(HotKeysData):gsub("+", "{plus}")

	var_71_0.data = "s=" ..
	select(1, sampGetCurrentServerAddress()) ..
	":" ..
	select(2, sampGetCurrentServerAddress()) ..
	"&n=" ..
	sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))) .. "&t=skk&d=" .. u8:encode(var_71_1)
	var_71_0.headers = {
		["content-type"] = "application/x-www-form-urlencoded"
	}

	sequent_async_http_request("POST", "http://127.0.0.1:3000/api/config", var_71_0,
		function(arg_72_0)
			if arg_72_0.text == "ok" then
				am("������ ���-����� ������� ���������!")
				registerKK()
			else
				am("�� ������� ��������� ������ ���-�����. ��������� �������!")
			end
		end, function(arg_73_0)
		print(arg_73_0)
	end)
end

function saveCc()
	local var_74_0 = {
		data = "s=" ..
		select(1, sampGetCurrentServerAddress()) ..
		":" ..
		select(2, sampGetCurrentServerAddress()) ..
		"&n=" ..
		sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))) ..
		"&t=scc&d=" .. u8:encode(encodeJson(ccData)),
		headers = {
			["content-type"] = "application/x-www-form-urlencoded"
		}
	}

	sequent_async_http_request("POST", "http://127.0.0.1:3000/api/config", var_74_0,
		function(arg_75_0)
			if arg_75_0.text == "ok" then
				am("������ ������ ������ ������� ���������!")
				registerCC()
			else
				am("�� ������� ��������� ������ ������ ������. ��������� �������!")
			end
		end, function(arg_76_0)
		print(arg_76_0)
	end)
end

function deleteAllTick()
	alltickets[getSrv()] = {}

	saveTick()
end

function deleteTick(arg_78_0)
	if tostring(arg_78_0):len() > 0 then
		for iter_78_0, iter_78_1 in pairs(alltickets[getSrv()]) do
			if tostring(iter_78_1[1]) == tostring(arg_78_0) then
				alltickets[getSrv()][iter_78_0] = nil

				am("������ �������!")
				saveTick()
			end
		end
	end
end

function saveCo()
	local var_79_0 = {
		data = "s=" ..
		select(1, sampGetCurrentServerAddress()) ..
		":" ..
		select(2, sampGetCurrentServerAddress()) ..
		"&n=" ..
		sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))) .. "&t=sco&d=" .. encodeJson(tencodes),
		headers = {
			["content-type"] = "application/x-www-form-urlencoded"
		}
	}

	sequent_async_http_request("POST", "http://127.0.0.1:3000/api/config", var_79_0,
		function(arg_80_0)
			if arg_80_0.text == "ok" then
				am("������ ������� ���������!")
			else
				am("�� ������� ��������� ������. ��������� �������!")
			end
		end, function(arg_81_0)
		print(arg_81_0)
	end)
end

warn_info = {
	wdis = false,
	pursuit_sector = false,
	show_blip = false,
	show_pursuit = false,
	auto_su = false
}
autosu1 = var_0_0.ImBuffer(128)
autosu2 = var_0_0.ImBuffer(128)
autosu3 = var_0_0.ImBuffer(128)
autosu4 = var_0_0.ImBuffer(128)
autopursuit1 = var_0_0.ImBuffer(128)
autopursuit2 = var_0_0.ImBuffer(128)
autopursuit3 = var_0_0.ImBuffer(128)
autopursuit4 = var_0_0.ImBuffer(128)
smdcName, smdcWanted, smdcReason, smdcFrac = nil
law = {
	a = {
		"��. �1 ��",
		"��. �1 ��",
		"��. �2 ��",
		"��. �3 ��",
		"��. �4 ��",
		"��. �5 ��",
		"��. �6 ��",
		"��. �7 ��",
		"��. �8 ��",
		"��. �9 ��",
		"��. �10 ��",
		"��. �11 ��",
		"��. �12 ��",
		"��. �13 ��",
		"��. �14 ��",
		"��. �15 ��",
		"��. �16 ��",
		"��. �17 ��",
		"��. �18 ��",
		"��. �19 ��",
		"��. �20 ��",
		"��. �21 ��",
		"��. �22 ��",
		"��. �23 ��",
		"��. �24 ��",
		"��. �25 ��",
		"��. �26 ��",
		"��. �27 ��",
		"��. �28 ��",
		"��. �29 ��",
		"��. �30 ��",
		"��. �31 ��",
		"��. �32 ��",
		"��. �33 ��",
		"��. �34 ��",
		"��. �35 ��",
		"��. �36 ��",
		"��. �37 ��"
	},
	b = {
		"������ �����",
		"��������� �������",
		"�������� ������ �� ������",
		"��������",
		"������� ������ � �������� ����",
		"�������",
		"������� ������",
		"��������",
		"����� �� ������ ������",
		"������������",
		"����������� ������ ���������",
		"���� ��",
		"����� �� ��������",
		"����������� ������������� �������",
		"������������� �� ���������� ����������",
		"������",
		"������",
		"������� ������ ��� ��������",
		"�����������",
		"������������ ���������� ��/���",
		"������� ���������������� ���������",
		"������� ����������",
		"�������� ����������/����������",
		"������������ ������������� �������",
		"������",
		"����",
		"�����",
		"���������",
		"�����",
		"��������� �� ���������������",
		"��������� �� ������������",
		"��������� �� ������ ���/����",
		"���������/����������",
		"���������",
		"���� ����.��������",
		"��������",
		"����������� ������� ������������/������� ������������",
		"�������������"
	},
	c = {
		"1",
		"1",
		"2",
		"2",
		"2",
		"2",
		"2",
		"2",
		"2",
		"2",
		"2",
		"2",
		"2",
		"3",
		"3",
		"2",
		"2",
		"2",
		"2",
		"2",
		"3",
		"3",
		"3",
		"3",
		"3",
		"3",
		"3",
		"4",
		"4",
		"4",
		"5",
		"6",
		"6",
		"",
		"4",
		"3",
		"3",
		"4"
	},
	d = {
		"",
		"",
		"",
		"",
		"",
		"",
		nil,
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"{32CD32}",
		"",
		"",
		"",
		"",
		"",
		"{FFFF00}",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
}
law_revo = {
	e = {
		"��. �25 ��",
		"����",
		"3"
	},
	f = {
		"��. �30 ��",
		"��������� �� ������������",
		"5"
	},
	b = {
		"������ �����",
		"��������� �������",
		"�������� ������ �� ������",
		"��������",
		"������� ������ � �������� ����",
		"�������",
		"������� ������",
		"��������",
		"����� �� ������ ������",
		"������������",
		"����������� ������ ���������",
		"���� ��",
		"����� �� ��������",
		"����������� ������������� �������",
		"������������� �� ���������� ����������",
		"������",
		"������",
		"������� ������ ��� ��������",
		"�����������",
		"������������ ���������� ��/���",
		"������� ���������������� ���������",
		"������� ����������",
		"�������� ����������/����������",
		"������������ ������������� �������",
		"������",
		"����",
		"�����",
		"���������",
		"�����",
		"��������� �� ���������������",
		"��������� �� ������������",
		"��������� �� ������ ���/����",
		"���������/����������",
		"���������",
		"���� ����.��������",
		"��������",
		"����������� ������� ������������/������� ������������",
		"�������������"
	},
	d = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"{32CD32}",
		"",
		"",
		"",
		"",
		"",
		"{FFFF00}",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	},
	a = {
		"��. �1 ��",
		"��. �1 ��",
		"��. �2 ��",
		"��. �3 ��",
		"��. �4 ��",
		"��. �5 ��",
		"��. �6 ��",
		"��. �7 ��",
		"��. �8 ��",
		"��. �9 ��",
		"��. �10 ��",
		"��. �11 ��",
		"��. �12 ��",
		"��. �13 ��",
		"��. �14 ��",
		"��. �15 ��",
		"��. �16 ��",
		"��. �17 ��",
		"��. �18 ��",
		"��. �19 ��",
		"��. �20 ��",
		"��. �21 ��",
		"��. �22 ��",
		"��. �23 ��",
		"��. �24 ��",
		"��. �25 ��",
		"��. �26 ��",
		"��. �27 ��",
		"��. �28 ��",
		"��. �29 ��",
		"��. �30 ��",
		"��. �31 ��",
		"��. �32 ��",
		"��. �33 ��",
		"��. �34 ��",
		"��. �35 ��",
		"��. �36 ��",
		"��. �37 ��"
	},
	c = {
		"1",
		"1",
		"2",
		"2",
		"2",
		"2",
		"2",
		"2",
		"2",
		"2",
		"2",
		"2",
		"2",
		"3",
		"3",
		"2",
		"2",
		"2",
		"2",
		"2",
		"3",
		"3",
		"3",
		"3",
		"3",
		"3",
		"3",
		"4",
		"4",
		"4",
		"5",
		"6",
		"6",
		"",
		"4",
		"3",
		"3",
		"4"
	}
}
law_legacy = {
	e = {
		"������� ��������",
		"3",
		""
	},
	f = {
		"���������",
		"4",
		""
	},
	b = {
		"��������� �������",
		"������",
		"��������������",
		"����������",
		"���� ������������� ��������",
		"����������",
		"�������������",
		"�������� ������/�����������",
		"���� ������ ���������",
		"�������",
		"�������������",
		"����������������",
		"������������ ���������� ���. ��������",
		"�����������",
		"��������",
		"����������� �����",
		"���������� ������",
		"�����������",
		"������� ������ � �������� ����",
		"���������/�������� ������������� �������",
		"���������/�������� ���������� ����������",
		"������������ ������������� �������",
		"�������/������� ���������� � ����������� ����������",
		"������������ ������������� �������",
		"������������/�������/������� ������������ ������",
		"������� ���������������� ���������",
		"�������/�������� ������� �����",
		"�����������/����� ���������",
		"������ ������ ��������������� ��������",
		"����� ���������������� ���������",
		"�������������",
		"����/������� ����� �� ������������� �� ����������",
		"��������",
		"���������",
		"����� �� ������",
		"�������������",
		"���������",
		"��������",
		"������������",
		"���������� ����������������� ����",
		"���������/������ ����������",
		"����",
		"�������� � ���� �������",
		"����� �� ����� ����������",
		"���������"
	},
	d = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"{32CD32}",
		"",
		"",
		"",
		"",
		"",
		"{FFFF00}",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	},
	a = {
		"��. �1.1 ��",
		"��. �1.2 ��",
		"��. �1.3 ��",
		"��. �1.4 ��",
		"��. �1.5 ��",
		"��. �1.6 ��",
		"��. �1.7 ��",
		"��. �1.8 ��",
		"��. �1.9 ��",
		"��. �1.10 ��",
		"��. �1.11 ��",
		"��. �1.12 ��",
		"��. �2.1 ��",
		"��. �2.2 ��",
		"��. �2.3 ��",
		"��. �2.4 ��",
		"��. �2.5 ��",
		"��. �2.6 ��",
		"��. �2.7 ��",
		"��. �2.8 ��",
		"��. �2.9 ��",
		"��. �2.10 ��",
		"��. �2.11 ��",
		"��. �2.12 ��",
		"��. �2.13 ��",
		"��. �2.14 ��",
		"��. �2.15 ��",
		"��. �2.16 ��",
		"��. �2.17 ��",
		"��. �2.18 ��",
		"��. �3.1 ��",
		"��. �3.2 ��",
		"��. �3.3 ��",
		"��. �3.4 ��",
		"��. �3.5 ��",
		"��. �3.6 ��",
		"��. �4.1 ��",
		"��. �4.2 ��",
		"��. �5.1 ��",
		"��. �6.1 ��",
		"��. �6.2 ��",
		"��. �7.1 ��",
		"��. �7.2 ��",
		"��. �7.3 ��",
		"��. �7.4 ��"
	},
	c = {
		"1",
		"1",
		"1",
		"1",
		"1",
		"1",
		"1",
		"1",
		"1",
		"1",
		"1",
		"1",
		"2",
		"2",
		"2",
		"2",
		"2",
		"2",
		"2",
		"2",
		"2",
		"2",
		"2",
		"2",
		"2",
		"2",
		"2",
		"2",
		"2",
		"2",
		"3",
		"3",
		"3",
		"4",
		"3",
		"3",
		"4",
		"4",
		"5",
		"6",
		"6",
		"6",
		"6",
		"6",
		""
	}
}
law_second = {
	e = {
		"������������",
		"2",
		""
	},
	f = {
		"���������� ���������� ����� �������� � �������",
		"3",
		""
	},
	b = {
		"�������� ��� ������",
		"�������� � �������",
		"�������� �� ��������������",
		"���������� ���������� ����� �������� ��� ������",
		"���������� ���������� ����� �������� � �������",
		"������������ ���������� ����� ��������",
		"������� �������/�����������������",
		"����, ������������, ������������ ���. ���������",
		"�������������/�������� ���. ���������/�������",
		"�����/����� ������������ ���������",
		"�����/����� ���������������� ���������",
		"���� ������ ���������/��������",
		"���������",
		"���������",
		"������������� �� ���������� ����������",
		"������������� �� ������� ����������",
		"������������",
		"�����/��������� �� ������ ������",
		"����� ��-��� ������",
		"���� � ����� ���",
		"����/��������� ������",
		"��������� �� ������ �������",
		"������� �������� �������",
		"�������� ������� ������ �����������",
		"��������������",
		"���� ���������������� �����������",
		"������ ���������/����������� �����",
		"������������������ ���������� ��������� ������������",
		"�������������"
	},
	d = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"{FFFF00}",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"{32CD32}",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	},
	a = {
		"��. �1.1 ��",
		"��. �1.2 ��",
		"��. �1.3 ��",
		"��. �2.1 ��",
		"��. �2.2 ��",
		"��. �2.3 ��",
		"��. �2.4 ��",
		"��. �3.1 ��",
		"��. �3.2 ��",
		"��. �4.1 ��",
		"��. �4.2 ��",
		"��. �5.1 ��",
		"��. �6.1 ��",
		"��. �6.2 ��",
		"��. �7.1 ��",
		"��. �7.2 ��",
		"��. �8.1 ��",
		"��. �8.2 ��",
		"��. �8.3 ��",
		"��. �8.4 ��",
		"��. �9.1 ��",
		"��. �9.2 ��",
		"��. �9.3 ��",
		"��. �9.4 ��",
		"��. �10.1 ��",
		"��. �10.2 ��",
		"��. �10.3 ��",
		"��. �10.4 ��",
		"��. �10.5 ��"
	},
	c = {
		"3",
		"4",
		"2",
		"1",
		"3",
		"1",
		"1",
		"4",
		"2",
		"2",
		"4",
		"3",
		"6",
		"5",
		"3",
		"2",
		"2",
		"2",
		"6",
		"2",
		"3",
		"3",
		"3",
		"5",
		"2",
		"6",
		"3",
		"1",
		"3"
	}
}
law_reborn = {
	e = {
		"������������",
		"1",
		""
	},
	f = {
		"����������� ��������� �� ���. �����������",
		"6",
		""
	},
	b = {
		"��������",
		"����������� ��������� �� �����������",
		"����������� ��������� �� ���.��������",
		"�������� / ����� ��������",
		"�������� ���������������",
		"�������� ������������",
		"�������� ������ ���",
		"����������� / ������������ ���������",
		"����������������",
		"�����������",
		"���� ������������� ��������",
		"������������",
		"������������� ���������� � ������������� ����������",
		"������� ��������",
		"����� �� ������",
		"��������� �� ��������� �������������� �����",
		"���������",
		"������� ������ � �������� ����",
		"������� ������ ��� ��������",
		"���������� ������������ ������",
		"�������� / ��������� ������������� �������",
		"�������� / ��������� ����������",
		"������������ ����������",
		"������������ ���������� ���. ��������",
		"������� / ������� / ������� ����������",
		"������� / ������� / ������� ����������",
		"���������� ����������� ����������",
		"����������� ������ ���������",
		"����������� ������ ���������",
		"������������� �� ���������� ����������",
		"������������� �� ������� ����������",
		"���������� ������� / �����������",
		"��������������",
		"������",
		"����������",
		"�������������",
		"����� / ������� ������ ���� ������",
		"�������� ������",
		"�������������",
		"��������������",
		"�������� ����������",
		"������� �� ����������� / ��������������� ����",
		"������� �� ��������������� / ������� �����������",
		"������� �������� ���������",
		"������� ������� �����",
		"�������� / ������� ������� �����",
		"������� / ������� / ����� ������ �� ������",
		"�������� ������ �� ������",
		"����������� ������",
		"�������� ������",
		"���������� �������",
		"��������� / ������ � ���������",
		"����������� ����������� �����������/��������",
		"�������� ����������� �����������",
		"������������",
		"�������� ������",
		"������ � ������� ������",
		"���������� �������, ������������ � ����������� ������",
		"���������� �����, ������� � ����������",
		"������������� ������� � ������� �����������",
		"����",
		"���������� ���������� ��������",
		"��������",
		"��������� �� ������� � ����",
		"����� � ������� �������� �����������",
		"��������� �� ���������� ���������",
		"��������� ������� �� �������� ���������"
	},
	d = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"{FFFF00}",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"{32CD32}",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	},
	a = {
		"��. �1.1 ��",
		"��. �2.1 ��",
		"��. �2.2 ��",
		"��. �3.1 ��",
		"��. �3.2 ��",
		"��. �3.3 ��",
		"��. �3.4 ��",
		"��. �4.1 ��",
		"��. �4.2 ��",
		"��. �5.1 ��",
		"��. �6.1 ��",
		"��. �7.1 ��",
		"��. �7.2 ��",
		"��. �7.3 ��",
		"��. �7.4 ��",
		"��. �7.5 ��",
		"��. �8.1 ��",
		"��. �9.1 ��",
		"��. �9.2 ��",
		"��. �9.3 ��",
		"��. �10.1 ��",
		"��. �10.2 ��",
		"��. �10.3 ��",
		"��. �10.4 ��",
		"��. �10.5 ��",
		"��. �10.6 ��",
		"��. �10.7 ��",
		"��. �11.1 ��",
		"��. �11.2 ��",
		"��. �12.1 ��",
		"��. �12.2 ��",
		"��. �13.1 ��",
		"��. �13.2 ��",
		"��. �13.3 ��",
		"��. �13.4 ��",
		"��. �13.5 ��",
		"��. �13.6 ��",
		"��. �14.1 ��",
		"��. �14.2 ��",
		"��. �15.1 ��",
		"��. �15.2 ��",
		"��. �16.1 ��",
		"��. �16.2 ��",
		"��. �17.1 ��",
		"��. �17.2 ��",
		"��. �17.3 ��",
		"��. �18.1 ��",
		"��. �18.2 ��",
		"��. �19.1 ��",
		"��. �19.2 ��",
		"��. �20.1 ��",
		"��. �20.2 ��",
		"��. �21.1 ��",
		"��. �21.2 ��",
		"��. �22.1 ��",
		"��. �23.1 ��",
		"��. �24.1 ��",
		"��. �24.2 ��",
		"��. �24.3 ��",
		"��. �24.4 ��",
		"��. �1.1 ��",
		"��. �1.2 ��",
		"��. �1.3 ��",
		"��. �2.1 ��",
		"��. �2.2 ��",
		"��. �2.3 ��",
		"��. �2.4 ��"
	},
	c = {
		"2",
		"3",
		"6",
		"3",
		"4",
		"5",
		"6",
		"1",
		"1",
		"2",
		"2",
		"1",
		"1",
		"2",
		"6",
		"2",
		"",
		"",
		"1",
		"3",
		"3",
		"3",
		"3",
		"3",
		"2",
		"2",
		"3",
		"1",
		"2",
		"2",
		"1",
		"3",
		"2",
		"1",
		"2",
		"2",
		"1",
		"1",
		"3",
		"2",
		"1",
		"1",
		"2",
		"3",
		"2",
		"2",
		"3",
		"3",
		"2",
		"2",
		"6",
		"4",
		"2",
		"3",
		"1",
		"1",
		"6",
		"4",
		"4",
		"1",
		"6",
		"3",
		"6",
		"3",
		"2",
		"3",
		"2"
	}
}
law_revo_s = {
	e = {
		"����",
		"3",
		""
	},
	f = {
		"��������� �� ������������",
		"5",
		""
	}
}
law_revo_f = {
	e = {
		"����",
		"3",
		""
	},
	f = {
		"��������� �� ���/����",
		"6",
		""
	}
}
law_legacy_s = {
	e = {
		"������� ��������",
		"3",
		""
	},
	f = {
		"���������",
		"4",
		""
	}
}
law_second_s = {
	e = {
		"������������",
		"2",
		""
	},
	f = {
		"���������� ���������� ����� �������� � �������",
		"3",
		""
	}
}
law_reborn_s = {
	e = {
		"������������",
		"1",
		""
	},
	f = {
		"����������� ��������� �� ���. �����������",
		"6",
		""
	}
}
sdate = {
	robhouse = {}
}

function setSuData()
	local var_82_0 = {
		data = "s=" ..
		select(1, sampGetCurrentServerAddress()) ..
		":" ..
		select(2, sampGetCurrentServerAddress()) ..
		"&n=" .. sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))) .. "&t=sesu",
		headers = {
			["content-type"] = "application/x-www-form-urlencoded"
		}
	}

	sequent_async_http_request("POST", "http://127.0.0.1:3000/api/config", var_82_0,
		function(arg_83_0)
			if arg_83_0.text:find("%[.*%]") then
				sud = decodeJson(u8:decode(arg_83_0.text))

				updateSuData()
			else
				am("�� ������� �������� ������. ��������� �������.")
			end
		end, function(arg_84_0)
		print(arg_84_0)
	end)
end

function saveSu()
	local var_85_0 = {}
	local var_85_1 = encodeJson(sud)

	var_85_0.data = "s=" ..
	select(1, sampGetCurrentServerAddress()) ..
	":" ..
	select(2, sampGetCurrentServerAddress()) ..
	"&n=" ..
	sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))) .. "&t=ssu&d=" .. u8:encode(var_85_1)
	var_85_0.headers = {
		["content-type"] = "application/x-www-form-urlencoded"
	}

	sequent_async_http_request("POST", "http://127.0.0.1:3000/api/config", var_85_0,
		function(arg_86_0)
			if arg_86_0.text == "ok" then
				am("������ ������ ������� ���������!")
				updateSuData()
			else
				am("�� ������� ��������� ������ ������. ��������� �������!")
			end
		end, function(arg_87_0)
		print(arg_87_0)
	end)
end

function deleteAllSu()
	sud = {
		a = {},
		b = {},
		c = {},
		d = {},
		e = {},
		f = {}
	}

	saveSu()
	updateSuData()
	am("��� ������ �������.")
end

function updateSuData()
	autosu1 = var_0_0.ImBuffer(128)
	autosu2 = var_0_0.ImBuffer(128)
	autosu3 = var_0_0.ImBuffer(128)
	autosu4 = var_0_0.ImBuffer(128)
	autopursuit1 = var_0_0.ImBuffer(128)
	autopursuit2 = var_0_0.ImBuffer(128)
	autopursuit3 = var_0_0.ImBuffer(128)
	autopursuit4 = var_0_0.ImBuffer(128)
	suva, suvb, suvc, suvd = {}, {}, {}, {}

	for iter_89_0, iter_89_1 in pairs(sud) do
		if iter_89_0 == "a" then
			for iter_89_2, iter_89_3 in pairs(iter_89_1) do
				suva[iter_89_2] = var_0_0.ImBuffer(u8(iter_89_3), 30)
			end
		end

		if iter_89_0 == "b" then
			for iter_89_4, iter_89_5 in pairs(iter_89_1) do
				suvb[iter_89_4] = var_0_0.ImBuffer(u8(iter_89_5), 128)
			end
		end

		if iter_89_0 == "c" then
			for iter_89_6, iter_89_7 in pairs(iter_89_1) do
				suvc[iter_89_6] = var_0_0.ImBuffer(u8(iter_89_7), 3)
			end
		end

		if iter_89_0 == "d" then
			for iter_89_8, iter_89_9 in pairs(iter_89_1) do
				suvd[iter_89_8] = var_0_0.ImBuffer(u8(iter_89_9), 30)
			end
		end

		if iter_89_0 == "f" and iter_89_1[1] and iter_89_1[1] ~= "" and iter_89_1[2] and iter_89_1[2] ~= "" and iter_89_1[3] and iter_89_1[3] ~= "" then
			autosu1, autosu2, autosu3 = var_0_0.ImBuffer(u8(iter_89_1[1]), 30), var_0_0.ImBuffer(u8(iter_89_1[2]), 128),
				var_0_0.ImBuffer(u8(iter_89_1[3]), 3)
		end

		if iter_89_0 == "e" and iter_89_1[1] and iter_89_1[1] ~= "" and iter_89_1[2] and iter_89_1[2] ~= "" and iter_89_1[3] and iter_89_1[3] ~= "" then
			autopursuit1, autopursuit2, autopursuit3 = var_0_0.ImBuffer(u8(iter_89_1[1]), 30),
				var_0_0.ImBuffer(u8(iter_89_1[2]), 128), var_0_0.ImBuffer(u8(iter_89_1[3]), 3)
		end
	end
end

function updateRhi()
	rhTable = {}

	for iter_90_0, iter_90_1 in pairs(rhiData) do
		table.insert(rhTable, {
			old = iter_90_0,
			new = iter_90_1
		})
	end
end

function saveRhi()
	local var_91_0 = {}
	local var_91_1 = encodeJson(rhiData)

	var_91_0.data = "s=" ..
	select(1, sampGetCurrentServerAddress()) ..
	":" ..
	select(2, sampGetCurrentServerAddress()) ..
	"&n=" ..
	sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))) .. "&t=srhi&d=" .. u8:encode(var_91_1)
	var_91_0.headers = {
		["content-type"] = "application/x-www-form-urlencoded"
	}

	sequent_async_http_request("POST", "http://127.0.0.1:3000/api/config", var_91_0,
		function(arg_92_0)
			if arg_92_0.text == "ok" then
				am("������ ������ ������� ���������!")
				registerTC()
			else
				am("�� ������� ��������� ������ ������. ��������� �������!")
			end
		end, function(arg_93_0)
		print(arg_93_0)
	end)
	updateRhi()
end

function setEquest(arg_94_0)
	updateRhi()
end

function updateRangs()
	chTable = {}

	for iter_97_0, iter_97_1 in pairs(changedRangs) do
		table.insert(chTable, {
			old = iter_97_0,
			new = iter_97_1
		})
	end
end

function saveRangs()
	local var_98_0 = {}
	local var_98_1 = encodeJson(changedRangs)

	var_98_0.data = "s=" ..
	select(1, sampGetCurrentServerAddress()) ..
	":" ..
	select(2, sampGetCurrentServerAddress()) ..
	"&n=" ..
	sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))) .. "&t=srng&d=" .. u8:encode(var_98_1)
	var_98_0.headers = {
		["content-type"] = "application/x-www-form-urlencoded"
	}

	sequent_async_http_request("POST", "http://127.0.0.1:3000/api/config", var_98_0,
		function(arg_99_0)
			if arg_99_0.text == "ok" then
				am("������ ������ ������� ���������!")
				registerTC()
			else
				am("�� ������� ��������� ������ ������. ��������� �������!")
			end
		end, function(arg_100_0)
		print(arg_100_0)
	end)
	updateRangs()
end

function isMan()
	return im.informer.infMainSex.v
end

function gender()
	return im.informer.infMainSex.v == true and "man" or "woman"
end

function getSettings()
	return
end

clr = "0x7B68EE"
clr_r = "0x398492D9"
mass = {}

function apply_custom_style()
	var_0_0.SwitchContext()

	local var_106_0 = var_0_0.GetStyle()
	local var_106_1 = var_106_0.Colors
	local var_106_2 = var_0_0.Col
	local var_106_3 = var_0_0.ImVec4

	var_106_0.WindowRounding = 2
	var_106_0.WindowTitleAlign = var_0_0.ImVec2(0.5, 0.84)
	var_106_0.ChildWindowRounding = 2
	var_106_0.FrameRounding = 2
	var_106_0.ItemSpacing = var_0_0.ImVec2(5, 4)
	var_106_0.ScrollbarSize = 13
	var_106_0.ScrollbarRounding = 0
	var_106_0.GrabMinSize = 8
	var_106_0.GrabRounding = 1
	var_106_1[var_106_2.Text] = var_106_3(1, 1, 1, 1)
	var_106_1[var_106_2.TextDisabled] = var_106_3(0.5, 0.5, 0.5, 1)
	var_106_1[var_106_2.WindowBg] = var_106_3(0.06, 0.06, 0.06, 0.94)
	var_106_1[var_106_2.ChildWindowBg] = var_106_3(1, 1, 1, 0)
	var_106_1[var_106_2.PopupBg] = var_106_3(0.08, 0.08, 0.08, 0.94)
	var_106_1[var_106_2.ComboBg] = var_106_1[var_106_2.PopupBg]
	var_106_1[var_106_2.Border] = var_106_3(0.43, 0.43, 0.5, 0.5)
	var_106_1[var_106_2.BorderShadow] = var_106_3(0, 0, 0, 0)
	var_106_1[var_106_2.FrameBg] = var_106_3(0.16, 0.29, 0.48, 0.54)
	var_106_1[var_106_2.FrameBgHovered] = var_106_3(0.26, 0.59, 0.98, 0.4)
	var_106_1[var_106_2.FrameBgActive] = var_106_3(0.26, 0.59, 0.98, 0.67)
	var_106_1[var_106_2.TitleBg] = var_106_3(0.04, 0.04, 0.04, 1)
	var_106_1[var_106_2.TitleBgActive] = var_106_3(0, 0, 0, 0.51)
	var_106_1[var_106_2.TitleBgCollapsed] = var_106_3(0, 0, 0, 0.51)
	var_106_1[var_106_2.MenuBarBg] = var_106_3(0.14, 0.14, 0.14, 1)
	var_106_1[var_106_2.ScrollbarBg] = var_106_3(0.02, 0.02, 0.02, 0.53)
	var_106_1[var_106_2.ScrollbarGrab] = var_106_3(0.31, 0.31, 0.31, 1)
	var_106_1[var_106_2.ScrollbarGrabHovered] = var_106_3(0.41, 0.41, 0.41, 1)
	var_106_1[var_106_2.ScrollbarGrabActive] = var_106_3(0.51, 0.51, 0.51, 1)
	var_106_1[var_106_2.CheckMark] = var_106_3(0.26, 0.59, 0.98, 1)
	var_106_1[var_106_2.SliderGrab] = var_106_3(0.24, 0.52, 0.88, 1)
	var_106_1[var_106_2.SliderGrabActive] = var_106_3(0.26, 0.59, 0.98, 1)
	var_106_1[var_106_2.Button] = var_106_3(0.26, 0.59, 0.98, 0.4)
	var_106_1[var_106_2.ButtonHovered] = var_106_3(0.26, 0.59, 0.98, 1)
	var_106_1[var_106_2.ButtonActive] = var_106_3(0.06, 0.53, 0.98, 1)
	var_106_1[var_106_2.Header] = var_106_3(0.26, 0.59, 0.98, 0.31)
	var_106_1[var_106_2.HeaderHovered] = var_106_3(0.26, 0.59, 0.98, 0.8)
	var_106_1[var_106_2.HeaderActive] = var_106_3(0.26, 0.59, 0.98, 1)
	var_106_1[var_106_2.Separator] = var_106_1[var_106_2.Border]
	var_106_1[var_106_2.SeparatorHovered] = var_106_3(0.26, 0.59, 0.98, 0.78)
	var_106_1[var_106_2.SeparatorActive] = var_106_3(0.26, 0.59, 0.98, 1)
	var_106_1[var_106_2.ResizeGrip] = var_106_3(0.26, 0.59, 0.98, 0.25)
	var_106_1[var_106_2.ResizeGripHovered] = var_106_3(0.26, 0.59, 0.98, 0.67)
	var_106_1[var_106_2.ResizeGripActive] = var_106_3(0.26, 0.59, 0.98, 0.95)
	var_106_1[var_106_2.CloseButton] = var_106_3(0.41, 0.41, 0.41, 0.5)
	var_106_1[var_106_2.CloseButtonHovered] = var_106_3(0.98, 0.39, 0.36, 1)
	var_106_1[var_106_2.CloseButtonActive] = var_106_3(0.98, 0.39, 0.36, 1)
	var_106_1[var_106_2.PlotLines] = var_106_3(0.61, 0.61, 0.61, 1)
	var_106_1[var_106_2.PlotLinesHovered] = var_106_3(1, 0.43, 0.35, 1)
	var_106_1[var_106_2.PlotHistogram] = var_106_3(0.9, 0.7, 0, 1)
	var_106_1[var_106_2.PlotHistogramHovered] = var_106_3(1, 0.6, 0, 1)
	var_106_1[var_106_2.TextSelectedBg] = var_106_3(0.26, 0.59, 0.98, 0.35)
	var_106_1[var_106_2.ModalWindowDarkening] = var_106_3(0.8, 0.8, 0.8, 0.35)
end

apply_custom_style()

local var_0_36 = var_0_0.ImBool(false)
local var_0_37 = var_0_0.ImBool(false)
local var_0_38 = var_0_0.ImBool(false)
local var_0_39 = var_0_0.ImBool(false)
local var_0_40 = var_0_0.ImBool(false)
local var_0_41 = var_0_0.ImBool(false)
local var_0_42 = var_0_0.ImBool(false)
local var_0_43 = var_0_0.ImBool(false)
local var_0_44 = var_0_0.ImBool(false)
local var_0_45 = var_0_0.ImBool(false)
local var_0_46 = var_0_0.ImBool(false)
local var_0_47 = var_0_0.ImBool(false)
local var_0_48 = var_0_0.ImBool(false)
local var_0_49 = var_0_0.ImBool(false)
local var_0_50 = var_0_0.ImBool(false)
local var_0_51 = var_0_0.ImBool(false)
local var_0_52 = var_0_0.ImBool(false)
local var_0_53 = var_0_0.ImBool(false)
local var_0_54 = var_0_0.ImBuffer(100)
local var_0_55 = var_0_0.ImBuffer(20)
local var_0_56 = var_0_0.ImBuffer(4096)
local var_0_57 = var_0_0.ImBuffer(5)
local var_0_58 = var_0_0.ImBool(false)
local var_0_59 = var_0_0.ImBuffer(20)
local var_0_60 = var_0_0.ImBuffer(1024)
local var_0_61 = var_0_0.ImBuffer(5)
local var_0_62 = var_0_0.ImBool(false)
local var_0_63 = var_0_0.ImBuffer(20)
local var_0_64 = var_0_0.ImBuffer(4096)
local var_0_65 = var_0_0.ImBuffer(5)
local var_0_66 = var_0_0.ImBool(false)
local var_0_67 = {
	AddTC = var_0_0.ImBuffer(30),
	AddTT = var_0_0.ImBuffer(4096),
	AddWW = var_0_0.ImBuffer(5),
	AddPP = var_0_0.ImBool(false)
}
local var_0_68 = {
	AddName = var_0_0.ImBuffer(128),
	AddCommand = var_0_0.ImBuffer(56),
	AddText = var_0_0.ImBuffer(100000)
}
local var_0_69 = var_0_0.ImBuffer(20)
local var_0_70 = var_0_0.ImBuffer(1024)
local var_0_71 = var_0_0.ImBuffer(5)
local var_0_72 = var_0_0.ImBool(false)
local var_0_73 = var_0_0.ImBuffer(1024)
local var_0_74 = var_0_0.ImBuffer(125)
local var_0_75 = var_0_0.ImBuffer(125)

heli, moto = false, false
depnotifi = true
reaver = false
targetID = nil
addCC, addKK = false
hpID, pID = nil
hpStatus, hpHandle = false
scheck = 0
carSpawnTime, endTime = 0, 0
spawnColor, fColor = "FFFFFF", "FFFFFF"
isDriver = false
pt_id, pt_sec = nil
chRang, idRang, chmess = "", "", ""
spd = {}
radio_copcar, radio_copcar_state = nil, "stop"

function am(arg_107_0, arg_107_1, arg_107_2)
	local var_107_0 = arg_107_1 or 5

	ntf.addNotification("\n                PD-PROJECT\n\n" .. arg_107_0 .. "\n\n��", tonumber(var_107_0),
		tonumber(arg_107_2))
end

local var_0_76 = {
	"�������� ���������",
	"��������� ������",
	"�������� � ��������",
	"����������� ������ ����",
	"������� �������",
	"����� � �������������",
	"��������� � �����-��������",
	"���� ������",
	"���� ������",
	"���� ���-�����",
	"��������� ���������",
	"���-����",
	"������� ������ �������",
	"������� ������ �������",
	"������� �������",
	"��������� ���������� � �����",
	"��������� ���������",
	"������ ������ [/rhi]",
	"Fastmap � SQUAD",
	"����������� ������� [!]"
}
local var_0_77 = var_0_0.CreateTextureFromFile("moonloader/PD-Project/config/img/pdplogo.png")
local var_0_78 = var_0_0.CreateTextureFromFile("moonloader/PD-Project/config/img/logo-settings-c.jpg")

function gsub(arg_108_0)
	arg_108_0 = arg_108_0:gsub("{mynick}", sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))))
	arg_108_0 = arg_108_0:gsub("{myrpnick}",
		sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))):gsub("_", " "))
	arg_108_0 = arg_108_0:gsub("{myname}",
		sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))):gsub("_.*", ""))
	arg_108_0 = arg_108_0:gsub("{mysurname}",
		sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))):gsub(".*_", ""))
	arg_108_0 = arg_108_0:gsub("{myiname}",
		sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))):match("(%u)") ..
		"." .. sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))):gsub(".*_", ""))
	arg_108_0 = arg_108_0:gsub("{myid}", tostring(select(2, sampGetPlayerIdByCharHandle(playerPed))))
	arg_108_0 = arg_108_0:gsub("{myscore}",
		tostring(sampGetPlayerScore(select(2, sampGetPlayerIdByCharHandle(playerPed)))))
	arg_108_0 = arg_108_0:gsub("{myping}", tostring(sampGetPlayerPing(select(2, sampGetPlayerIdByCharHandle(playerPed)))))
	arg_108_0 = arg_108_0:gsub("{myfps}", tostring(var_0_11.getfloat(12045136, true)))
	arg_108_0 = arg_108_0:gsub("{mysign}",
		sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))):match("(%u)%a+%_%u%a+") ..
		"." .. sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))):match("%u%a+%_(%u)%a+") .. ".")
	arg_108_0 = arg_108_0:gsub("{date}", tostring(os.date("%d.%m.%Y")))
	arg_108_0 = arg_108_0:gsub("{time}", string.format(os.date("%H:%M:%S", moscow_time)))
	arg_108_0 = arg_108_0:gsub("{p_id}", pID and tostring(pID) or hpID and tostring(hpID) or "")
	arg_108_0 = arg_108_0:gsub("{p_nick}",
		pID and sampGetPlayerNickname(pID) or hpID and sampGetPlayerNickname(hpID) or "")
	arg_108_0 = arg_108_0:gsub("{p_rpnick}",
		pID and sampGetPlayerNickname(pID):gsub("_", " ") or hpID and sampGetPlayerNickname(hpID):gsub("_", " ") or "")
	arg_108_0 = arg_108_0:gsub("{p_name}",
		pID and sampGetPlayerNickname(pID):gsub("_.*", "") or hpID and sampGetPlayerNickname(hpID):gsub("_.*", "") or "")
	arg_108_0 = arg_108_0:gsub("{p_surname}",
		pID and sampGetPlayerNickname(pID):gsub(".*_", "") or hpID and sampGetPlayerNickname(hpID):gsub(".*_", "") or "")
	arg_108_0 = arg_108_0:gsub("{p_score}",
		pID and tostring(sampGetPlayerScore(pID)) or hpID and tostring(sampGetPlayerScore(pID)) or "")
	arg_108_0 = arg_108_0:gsub("{p_ping}",
		pID and tostring(sampGetPlayerPing(pID)) or hpID and tostring(sampGetPlayerPing(pID)) or "")
	arg_108_0 = arg_108_0:gsub("{weapon}", tostring(getGun(getCurrentCharWeapon(playerPed))))
	arg_108_0 = arg_108_0:gsub("{badge_type}", tostring(myfrac) == "4" and "�����" or "������")
	arg_108_0 = arg_108_0:gsub("{mysfrac}", tostring(myfrac) == "4" and "���" or "�������")
	arg_108_0 = arg_108_0:gsub("{partner}", tostring(se.main.partner))
	arg_108_0 = arg_108_0:gsub("{mark}", tostring(se.main.area))
	arg_108_0 = arg_108_0:gsub("{srang}", u8:decode(tostring(se.main.rang)))
	arg_108_0 = arg_108_0:gsub("{clist}", tostring(se.main.clist))
	arg_108_0 = arg_108_0:gsub("{rank}", tostring(rang and rang or ""))
	arg_108_0 = arg_108_0:gsub("{zone}",
		tostring(calcZ(select(1, getCharCoordinates(playerPed)), select(2, getCharCoordinates(playerPed)),
			select(3, getCharCoordinates(playerPed)))))
	arg_108_0 = arg_108_0:gsub("{city}", tostring((getCity())))
	arg_108_0 = arg_108_0:gsub("{fraction}", tostring(frac and frac or ""))
	arg_108_0 = arg_108_0:gsub("{rpfraction}",
		tostring(tostring(frac) == "Police SF" and "������� �. ���-������" or
		tostring(frac) == "Police LS" and "������� �. ���-������" or
		tostring(frac) == "Police LV" and "������� �. ���-��������" or
		tostring(frac) == "FBI" and "����������� ���� �������������" or ""))
	arg_108_0 = arg_108_0:gsub("{tag}", tostring(u8:decode(im.informer.infMainTag.v)))
	arg_108_0 = arg_108_0:gsub("{sector}", tostring(kvad(playerPed)))
	arg_108_0 = arg_108_0:gsub("{sector_uli}", tostring(kvadUli(playerPed)))
	arg_108_0 = arg_108_0:gsub("{direction}", tostring(mydirection(playerPed)))
	arg_108_0 = arg_108_0:gsub("{su_id}", suspect_id and tostring(suspect_id) or "")
	arg_108_0 = arg_108_0:gsub("{su_vehicle}", suspect_veh and suspect_veh or "")
	arg_108_0 = arg_108_0:gsub("{su_nick}", suspect_name and suspect_name or "")
	arg_108_0 = arg_108_0:gsub("{su_rpnick}", suspect_name and suspect_name:gsub("_", " ") or "")
	arg_108_0 = arg_108_0:gsub("{cl_id}", getClosestPlayerId() ~= -1 and tostring(getClosestPlayerId()) or "")
	arg_108_0 = arg_108_0:gsub("{cl_nick}",
		getClosestPlayerId() ~= -1 and sampGetPlayerNickname(getClosestPlayerId()) or "")
	arg_108_0 = arg_108_0:gsub("{cl_rpnick}",
		getClosestPlayerId() ~= -1 and sampGetPlayerNickname(getClosestPlayerId()):gsub("_", " ") or "")
	arg_108_0 = arg_108_0:gsub("{cl_name}",
		getClosestPlayerId() ~= -1 and sampGetPlayerNickname(getClosestPlayerId()):gsub("_.*", "") or "")
	arg_108_0 = arg_108_0:gsub("{cl_surname}",
		getClosestPlayerId() ~= -1 and sampGetPlayerNickname(getClosestPlayerId()):gsub(".*_", "") or "")
	arg_108_0 = arg_108_0:gsub("{cl_score}",
		getClosestPlayerId() ~= -1 and tostring(sampGetPlayerScore(getClosestPlayerId())) or "")

	return arg_108_0
end

allCommands = {
	"������� ������ ������� PD-Project � ���� - /pdpteam",
	"������ � ����� ��� ������� - /j",
	"������ �� ��������� ���� - /jre id (�� ������� id) �������. ����������: /jre 2 ����.",
	"����� ��������� ���������� �� ������ ������ ����� 15 �����.",
	"��� ����������� ����� - /rh",
	"��� ���: ������� ���������� � ���� - /cfbi id ������ [/cfbi 228 7]",
	"�������: /dep Army LV, Naile Linkoln, ������� � ���� ��� � ������� 7 �����.",
	"������� ������� ����� ������ (/pt) - /dp",
	"������� ���� ����� ������������ (���� ��������) - /deplog",
	"������� ���� ������ ������������� (/clear) (���� ��������) - /cwlog",
	"������� ��������� ������ � �������������� � ��� - /pt",
	"���������������� � ��� ����� /rhi [ID]",
	"�������� �� ������ ������������ /ce [ID]",
	"�������� �������� �� ������ ������������ - /sce [ID]",
	"������ ������ - /ss [ID]",
	"�������� ����� - /tt [ID]",
	"�������� ��� - /op [���������� ��� (1-3)] [������� ��� (������ ����!) 1.1-1.6] [ID ���, ���� 2+ ����� ������]",
	"������: /op 1 1.1 235 | /op 3 1.4 342 54 12",
	"���������� ��������� �������� /pr [ID]",
	"���������� ��������� �������� /prn [ID(1-3)] - ������� ���� N.Name �� ID",
	"���������� ���������� ������� - /mrk [MARK]",
	"�������� ����� /do � ������ clist 32 - /maski",
	"���� ��������� ������� - /pdcl",
	"���������� ��������� � /dep � ����������� ���������� �� ������� ������ - /depjur",
	"C�������� � /dep � ����������� ���������� � ��������� ������� - /depjur [�������]",
	"�������� ����� ��� ������� - /showranks",
	"��������� ����� ��� ������� - /delranks",
	"���������� ����� - /mic ID. ������� ����� - /micoff.",
	"����������� ���������� ����� � SQUAD ��� � ����� - /micfs.",
	"������������ ������� /pdreload",
	"������������� ���������� ������ ������� /off",
	"�������� ������� ��� - /csp [ID] (������� �� ������� � ������ � ������)",
	"����������� � ����� - /ctie [ID]",
	"������� ����� � ���� - /msk [ID]",
	"���������� ������ �� ������� ����� - /spw [������]. ������: /spw �-4",
	"��������� � ����� (/rb) ���������� �� /mdc - /smdc [ID]",
	"��������� � SQUAD (/fs) ���������� �� /mdc - /fmdc [ID]",
	"��������� � ����� (/r) ���������� �� /mdc - /rmdc [ID]",
	"������ ������� (��������/��������) - /rec [ID]. ��������� - /recoff",
	"������� � ���������� �� ������������ - /govk",
	"������������ ���� ��������� � �������� /ps - /psa (���������, �� �����������, ���� �� ������ ID)",
	"����������� �������� - /mswi",
	"����������� ����� - /mswt",
	"����������� ������ ������ - /mswp",
	"������/�������� ������ ������ - /taz",
	"������� ���������� (3D) � ���������� - /delmark",
	"�������� ��� - /showhud. ������ ��� - /hidehud",
	"�������� ���������� FRM (�������, ���������, ��������) - /mycard",
	"�������� ��� ��������� ������� - /pdreset",
	"������� ��� ������� ��� ��� - /sgr",
	"������ ���, ��������� �������� - /soop (��� Revolution �������, ��������� ��������)",
	"���� ����������� ��� ����� - /dmlog",
	"������� ������������ �������� ����� (� ���� ������������������� ����������) - /setcase ID",
	"������� � ���������� Government Database - /gdget",
	"���� �������������� ��������� ���� - /pdefuse",
	"������� ���� SMS - /smslog",
	"������� ������ ������� ��� ������� ������� - ���-��� \"BNB\" (������� �� ����������, �� � ���, ��� HESOYAM)",
	"������ �������� ������� � ���� ��������� - /offlist",
	"�������� ��������� - /prs",
	"���������� ������� ���� - ������� ������� \"ALT\"",
	"��������� �� �����/����������� ������� ���� - ������� \"Pause\"",
	"���� �������� ������ ����������� ������ - /pdaid",
	"������������� ������ � /dep - /thanks ID",
	"��������� (mdc) ������ �� ������ ������ - /cmdc ID"
}
commands = {
	"{NE}",
	"{mynick}",
	"{myrpnick}",
	"{myname}",
	"{mysurname}",
	"{myiname}",
	"{myid}",
	"{myscore}",
	"{myping}",
	"{myfps}",
	"{rank}",
	"{fraction}",
	"{rpfraction}",
	"{tag}",
	"{sector}",
	"{zone}",
	"{city}",
	"{direction}",
	"{mysign}",
	"{date}",
	"{time}",
	"{weapon}",
	"{p_id}",
	"{p_nick}",
	"{p_rpnick}",
	"{p_name}",
	"{p_surname}",
	"{p_score}",
	"{p_ping}",
	"{su_id}",
	"{su_vehicle}",
	"{su_nick}",
	"{su_rpnick}",
	"{cl_id}",
	"{cl_nick}",
	"{cl_rpnick}",
	"{cl_score}",
	"{cl_name}",
	"{cl_surname}",
	"{partner}",
	"{mark}",
	"{srang}",
	"{clist}"
}
commandsText = {
	["{myname}"] = "�������� �� ���� ���.",
	["{NE}"] = "��������� ������ ��� � ����� ������, ����� �� ���������� ��� � ���.",
	["{myscore}"] = "�������� �� ��� LVL.",
	["{myid}"] = "�������� �� ��� ID.",
	["{cl_name}"] = "�������� �� ��� ���������� � ��� ������. ���� ����� ������ ���, �� ������ �� ����������.",
	["{date}"] = "�������� �� ���� � ������� dd.mm.yyyy.",
	["{myiname}"] = "�������� �� ��� ��� � ������� N.Name.",
	["{city}"] = "�������� �� �������� ������, � ������� �� ����������.",
	["{cl_nick}"] = "�������� �� Nick_Name ���������� � ��� ������. ���� ����� ������ ���, �� ������ �� ����������.",
	["{badge_type}"] = "������ '�����' ��� '������' � ����������� �� �������",
	["{myping}"] = "�������� �� ��� PING.",
	["{mysign}"] = "�������� �� ���� ������� � ������� N.N.",
	["{tag}"] = "�������� �� ��� ��� �����.",
	["{p_rpnick}"] = "�������� �� RP Nick Name ������ � ���������� ��������� ID.",
	["{su_nick}"] =
	"�������� �� Nick_Name ������, �������� ����������� � ������ ������. ���� ������ �� ������, ������ �� ����������.",
	["{cl_surname}"] = "�������� �� ������� ���������� � ��� ������. ���� ����� ������ ���, �� ������ �� ����������.",
	["{cl_score}"] = "�������� �� LVL ���������� � ��� ������. ���� ����� ������ ���, �� ������ �� ����������.",
	["{direction}"] = "�������� �� ������� ����� (����������� ���������).",
	["{mark}"] = "������ ���������� �������.",
	["{rpfraction}"] = "�������� �� ���� ������� � ���������� �������.",
	["{clist}"] = "������ ����� clist, ��������� � ���������� �������.",
	["{fraction}"] = "�������� �� ���� �������.",
	["{time}"] = "�������� �� ������� ����� (���) � ������� 10:00:00.",
	["{rank}"] = "�������� �� ��� ����.",
	["{sector}"] = "�������� �� ������ �����, � ������� �� ����������.",
	["{srang}"] = "������ ���������, ��������� � ���������� �������.",
	["{p_score}"] = "�������� �� LVL ������ � ���������� ��������� ID.",
	["{zone}"] = "�������� �� �����, � ������� �� ����������.",
	["{p_id}"] = "������� �� ID ������ � ���������� ���������. (������� ���������� ��������� ID)",
	["{mynick}"] = "�������� �� ��� Nick_Name.",
	["{myrpnick}"] = "�������� �� ��� RP Nick Name.",
	["{p_nick}"] = "�������� �� Nick_Name ������ � ���������� ��������� ID.",
	["{mysfrac}"] = "������ '���' ��� '�������' � ���������� �� �������",
	["{su_vehicle}"] =
	"�������� �� �������� ���������� ������, �������� �� �����������. ���� ������ �� ������, ������ �� ����������.",
	["{weapon}"] = "�������� �� �������� ������, ������� ������� � �����.",
	["{p_name}"] = "�������� �� ��� ������ � ���������� ��������� ID.",
	["{p_surname}"] = "�������� �� ������� ������ � ���������� ��������� ID.",
	["{myfps}"] = "�������� �� ��� FPS.",
	["{cl_id}"] = "�������� �� ID ���������� � ��� ������. ���� ����� ������ ���, �� ������ �� ����������.",
	["{cl_rpnick}"] = "�������� �� RP Nick Name ���������� � ��� ������. ���� ����� ������ ���, �� ������ �� ����������.",
	["{su_id}"] = "�������� �� ID ������������� � ������ ������ ������. ���� ������ �� ������, ������ �� ����������.",
	["{partner}"] = "�������� �� ������������� ����������. ���� ��������� �� �����������, ������ ������ ��������.",
	["{p_ping}"] = "�������� �� PING ������ � ���������� ��������� ID.",
	["{mysurname}"] = "�������� �� ���� �������.",
	["{su_rpnick}"] =
	"�������� �� RP Nick Name ������, �������� �� �����������. ������ �� ����������, ���� ������ �� �������."
}
SeleListCommands = {}

function registerCC()
	while var_0_12 == false do
		wait(0)
	end

	SeleListCommands = {}
	BindCommand = {}
	BindText = {}
	BindWait = {}
	BindParamID = {}
	bcc, bct, bcw, bcp = {}, {}, {}, {}

	for iter_109_0, iter_109_1 in pairs(ccData) do
		if iter_109_1.mode == sha1(sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed)))) then
			table.insert(SeleListCommands, iter_109_0)

			if iter_109_1.param_id == true then
				if sampIsChatCommandDefined(iter_109_0) then
					sampUnregisterChatCommand(iter_109_0)
				end

				_G.sampRegisterChatCommand(iter_109_0, function(arg_110_0)
					lua_thread.create(function()
						as.other.stopbinder = false

						if as.other.pausebinder then
							chat(
							"��� ������� ������ ����� ���������� ������� ���� ������� �������� ALT ��� ����������� ��� �������� Pause/Break.")

							return
						end

						if _G.aln[alnkey] then
							if arg_110_0:len() > 0 then
								if sampIsPlayerConnected(arg_110_0) then
									pID = arg_110_0

									for iter_111_0 in iter_109_1.text:gmatch("[^\r\n]+") do
										if iter_111_0:len() > 0 then
											if as.other.stopbinder then
												as.other.stopbinder = false

												chat("������ ���������� ������������ �������� ALT.")

												break
											end

											while as.other.pausebinder do
												wait(100)
											end

											if tostring(iter_111_0):find("%{NE%}") then
												local var_111_0 = tostring(iter_111_0):gsub("{NE}", "")

												sampSetChatInputEnabled(true)
												sampSetChatInputText(gsub(var_111_0))
											else
												sampSendChat(gsub(iter_111_0))
											end

											wait(tonumber(iter_109_1.wait))
										end
									end

									pID = nil
								else
									chat("����� � ID " .. arg_110_0 .. " ����������.")
								end
							else
								chat("������� /" .. iter_109_0 .. " [ID].")
							end
						else
							am("������ ������� �������� ������ �� ������� ������ ����.")
						end
					end)
				end)
			else
				if sampIsChatCommandDefined(iter_109_0) then
					sampUnregisterChatCommand(iter_109_0)
				end

				_G.sampRegisterChatCommand(iter_109_0, function()
					lua_thread.create(function()
						as.other.stopbinder = false

						if as.other.pausebinder then
							chat(
							"��� ������� ������ ����� ���������� ������� ���� ������� �������� ALT ��� ����������� ��� �������� Pause/Break.")

							return
						end

						if _G.aln[alnkey] then
							for iter_113_0 in iter_109_1.text:gmatch("[^\r\n]+") do
								if iter_113_0:len() > 0 then
									if as.other.stopbinder then
										as.other.stopbinder = false

										chat("������ ���������� ������������ �������� ALT.")

										break
									end

									while as.other.pausebinder do
										wait(100)
									end

									if tostring(iter_113_0):find("%{NE%}") then
										local var_113_0 = tostring(iter_113_0):gsub("{NE}", "")

										sampSetChatInputEnabled(true)
										sampSetChatInputText(gsub(var_113_0))
									else
										sampSendChat(gsub(iter_113_0))
									end

									wait(tonumber(iter_109_1.wait))
								end
							end
						else
							am("������ ������� �������� ������ �� ������� ������ ����.")
						end
					end)
				end)
			end
		end

		bcc[iter_109_0] = iter_109_0
		bct[iter_109_0] = iter_109_1.text
		bcw[iter_109_0] = iter_109_1.wait
		bcp[iter_109_0] = iter_109_1.param_id
		BindCommand[iter_109_0] = var_0_0.ImBuffer(u8:encode(bcc[iter_109_0]), 20)
		BindText[iter_109_0] = var_0_0.ImBuffer(u8:encode(bct[iter_109_0]), 10560)
		BindWait[iter_109_0] = var_0_0.ImBuffer(tostring(bcw[iter_109_0]), 5)
		BindParamID[iter_109_0] = var_0_0.ImBool(bcp[iter_109_0])
	end

	seleGet()
end

SeleListKeys = {}

function registerKK()
	SeleListKeys = {}

	while var_0_12 == false do
		wait(0)
	end

	SeleListKeys = {}
	hotkeyBindKK = {}
	hotkeyBindTT = {}
	hotkeyBindWW = {}
	hotkeyBindPP = {}
	hkBindKK = {}
	hkBindTT = {}
	hkBindWW = {}
	hkBindPP = {}

	for iter_114_0, iter_114_1 in pairs(HotKeysData) do
		iter_114_0 = iter_114_0:gsub("{plus}", "+")

		table.insert(SeleListKeys, iter_114_0)

		hotkeyBindKK[iter_114_0] = iter_114_0
		hotkeyBindTT[iter_114_0] = iter_114_1.text:gsub("{plus}", "+")
		hotkeyBindWW[iter_114_0] = iter_114_1.wait
		hotkeyBindPP[iter_114_0] = iter_114_1.param_id
		hkBindKK[iter_114_0] = var_0_0.ImBuffer(hotkeyBindKK[iter_114_0], 20)
		hkBindTT[iter_114_0] = var_0_0.ImBuffer(u8:encode(hotkeyBindTT[iter_114_0]), 10560)
		hkBindWW[iter_114_0] = var_0_0.ImBuffer(tostring(hotkeyBindWW[iter_114_0]), 5)
		hkBindPP[iter_114_0] = var_0_0.ImBool(hotkeyBindPP[iter_114_0])
	end

	seleHGet()
end

function hotkeyCycle()
	lua_thread.create(function()
		while true do
			wait(0)

			if HotKeysData and sampGetGamestate() == 3 then
				for iter_116_0, iter_116_1 in pairs(HotKeysData) do
					if iter_116_1.mode == sha1(sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed)))) then
						iter_116_0 = iter_116_0:gsub("{plus}", "+")

						if iter_116_0:find("%+") and iter_116_0 ~= "Numpad +" and iter_116_0 ~= "+" then
							local var_116_0, var_116_1 = iter_116_0:match("(.*)%+(.*)")

							if isKeyDown(var_0_6.name_to_id(var_116_0)) and isKeyJustPressed(var_0_6.name_to_id(var_116_1)) and not sampIsDialogActive() and not sampIsChatInputActive() then
								as.other.stopbinder = false

								if as.other.pausebinder then
									chat(
									"��� ������� ������ ����� ���������� ������� ���� ������� �������� ALT ��� ����������� ��� �������� Pause/Break.")
								elseif _G.aln[alnkey] then
									if iter_116_1.param_id then
										if hpStatus and hpID and hpHandle then
											if sampIsPlayerConnected(hpID) then
												if doesCharExist(hpHandle) then
													for iter_116_2 in iter_116_1.text:gmatch("[^\r\n]+") do
														iter_116_2 = iter_116_2:gsub("{plus}", "+")

														if iter_116_2:len() > 0 then
															if as.other.stopbinder then
																as.other.stopbinder = false

																chat("������ ���������� ������������ �������� ALT.")

																break
															end

															while as.other.pausebinder do
																wait(100)
															end

															if tostring(iter_116_2):find("%{NE%}") then
																local var_116_2 = tostring(iter_116_2):gsub("{NE}", "")

																sampSetChatInputEnabled(true)
																sampSetChatInputText(gsub(var_116_2))
															else
																sampProcessChatInput(gsub(iter_116_2))
															end

															wait(tonumber(iter_116_1.wait))
														end
													end
												else
													chat("������ ��� � ���� ���������.")
												end
											else
												chat("����� ������ ����������. �������� ����, ����� �� J.")
											end
										else
											chat("�� �� ������� ����. ��� ������ �������� ��. ����������� � ������� J.")
										end
									else
										for iter_116_3 in iter_116_1.text:gmatch("[^\r\n]+") do
											if iter_116_3:len() > 0 then
												if as.other.stopbinder then
													as.other.stopbinder = false

													chat("������ ���������� ������������ �������� ALT.")

													break
												end

												while as.other.pausebinder do
													wait(100)
												end

												if tostring(iter_116_3):find("%{NE%}") then
													local var_116_3 = tostring(iter_116_3):gsub("{NE}", "")

													sampSetChatInputEnabled(true)
													sampSetChatInputText(gsub(var_116_3))
												else
													sampProcessChatInput(gsub(iter_116_3))
												end

												wait(tonumber(iter_116_1.wait))
											end
										end
									end
								else
									am("������ ������� �������� ������ �� ������� ������ ����.")
								end
							end
						elseif isKeyJustPressed(var_0_6.name_to_id(iter_116_0)) and not sampIsDialogActive() and not sampIsChatInputActive() then
							as.other.stopbinder = false

							if as.other.pausebinder then
								chat(
								"��� ������� ������ ����� ���������� ������� ���� ������� �������� ALT ��� ����������� ��� �������� Pause/Break.")
							elseif _G.aln[alnkey] then
								if iter_116_1.param_id then
									if hpStatus and hpID and hpHandle then
										if sampIsPlayerConnected(hpID) then
											if doesCharExist(hpHandle) then
												for iter_116_4 in iter_116_1.text:gmatch("[^\r\n]+") do
													if iter_116_4:len() > 0 then
														if as.other.stopbinder then
															as.other.stopbinder = false

															chat("������ ���������� ������������ �������� ALT.")

															break
														end

														while as.other.pausebinder do
															wait(100)
														end

														if tostring(iter_116_4):find("%{NE%}") then
															local var_116_4 = tostring(iter_116_4):gsub("{NE}", "")

															sampSetChatInputEnabled(true)
															sampSetChatInputText(gsub(var_116_4))
														else
															sampProcessChatInput(gsub(iter_116_4))
														end

														wait(tonumber(iter_116_1.wait))
													end
												end
											else
												chat("������ ��� � ���� ���������.")
											end
										else
											chat("����� ������ ����������. �������� ����, ����� �� J.")
										end
									else
										chat("�� �� ������� ����. ��� ������ �������� ��. ����������� � ������� J.")
									end
								else
									for iter_116_5 in iter_116_1.text:gmatch("[^\r\n]+") do
										if iter_116_5:len() > 0 then
											if as.other.stopbinder then
												as.other.stopbinder = false

												chat("������ ���������� ������������ �������� ALT.")

												break
											end

											while as.other.pausebinder do
												wait(100)
											end

											if tostring(iter_116_5):find("%{NE%}") then
												local var_116_5 = tostring(iter_116_5):gsub("{NE}", "")

												sampSetChatInputEnabled(true)
												sampSetChatInputText(gsub(var_116_5))
											else
												sampProcessChatInput(gsub(iter_116_5))
											end

											wait(tonumber(iter_116_1.wait))
										end
									end
								end
							else
								am("������ ������� �������� ������ �� ������� ������ ����.")
							end
						end
					end
				end
			end
		end
	end)
end

SeleListCheats = {}

function registerTC()
	while var_0_12 == false do
		wait(0)
	end

	SeleListCheats = {}
	var_0_69 = {}
	var_0_70 = {}
	var_0_71 = {}
	var_0_72 = {}

	for iter_117_0, iter_117_1 in pairs(tcData) do
		iter_117_0 = tostring(iter_117_0)

		table.insert(SeleListCheats, iter_117_0)

		var_0_69[iter_117_0] = var_0_0.ImBuffer(iter_117_0, 20)
		var_0_70[iter_117_0] = var_0_0.ImBuffer(u8:encode(iter_117_1.text), 10560)
		var_0_71[iter_117_0] = var_0_0.ImBuffer(tostring(iter_117_1.wait), 5)
		var_0_72[iter_117_0] = var_0_0.ImBool(iter_117_1.param_id)
	end

	seleTcGet()
end

SeleListNotes = {}

function registerNT()
	while var_0_12 == false do
		wait(0)
	end

	SeleListNotes = {}
	ntNames = {}
	ntCommands = {}
	ntTexts = {}

	for iter_118_0, iter_118_1 in pairs(ntData) do
		iter_118_0 = tostring(iter_118_0)

		table.insert(SeleListNotes, iter_118_0)

		ntNames[iter_118_0] = var_0_0.ImBuffer(u8:encode(iter_118_1.name), 128)
		ntCommands[iter_118_0] = var_0_0.ImBuffer(u8:encode(iter_118_1.command), 56)
		ntTexts[iter_118_0] = var_0_0.ImBuffer(u8:encode(iter_118_1.text), 100000)
	end

	seleNtGet()
end

function tcCycle()
	lua_thread.create(function()
		while true do
			wait(0)

			if tcData and sampGetGamestate() == 3 then
				for iter_120_0, iter_120_1 in pairs(tcData) do
					if iter_120_1.mode == sha1(sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed)))) and testCheat(tostring(iter_120_0)) and not sampIsDialogActive() and not sampIsChatInputActive() and _G.mass[mkey] then
						as.other.stopbinder = false

						if as.other.pausebinder then
							chat(
							"��� ������� ������ ����� ���������� ������� ���� ������� �������� ALT ��� ����������� ��� �������� Pause/Break.")
						elseif _G.aln[alnkey] then
							if iter_120_1.param_id then
								if hpStatus and hpID and hpHandle then
									if sampIsPlayerConnected(hpID) then
										if doesCharExist(hpHandle) then
											for iter_120_2 in iter_120_1.text:gmatch("[^\r\n]+") do
												if iter_120_2:len() > 0 then
													if as.other.stopbinder then
														as.other.stopbinder = false

														chat("������ ���������� ������������ �������� ALT.")

														break
													end

													while as.other.pausebinder do
														wait(100)
													end

													if tostring(iter_120_2):find("%{NE%}") then
														local var_120_0 = tostring(iter_120_2):gsub("{NE}", "")

														sampSetChatInputEnabled(true)
														sampSetChatInputText(gsub(var_120_0))
													else
														sampProcessChatInput(gsub(iter_120_2))
													end

													wait(tonumber(iter_120_1.wait))
												end
											end
										else
											am("������ ��� � ���� ���������.")
										end
									else
										chat("����� ������ ����������. �������� ����, ����� �� J.")
									end
								else
									chat("�� �� ������� ����. ��� ������ �������� ��. ����������� � ������� J.")
								end
							else
								for iter_120_3 in iter_120_1.text:gmatch("[^\r\n]+") do
									if iter_120_3:len() > 0 then
										if as.other.stopbinder then
											as.other.stopbinder = false

											chat("������ ���������� ������������ �������� ALT.")

											break
										end

										while as.other.pausebinder do
											wait(100)
										end

										if tostring(iter_120_3):find("%{NE%}") then
											local var_120_1 = tostring(iter_120_3):gsub("{NE}", "")

											sampSetChatInputEnabled(true)
											sampSetChatInputText(gsub(var_120_1))
										else
											sampProcessChatInput(gsub(iter_120_3))
										end

										wait(tonumber(iter_120_1.wait))
									end
								end
							end
						else
							am("������ ������� �������� ������ �� ������� ������ ����.")
						end
					end
				end
			end
		end
	end)
end

local var_0_79 = {}
local var_0_80 = {}

for iter_0_4 = 192, 223 do
	local var_0_81 = string.char(iter_0_4)
	local var_0_82 = string.char(iter_0_4 + 32)

	var_0_80[var_0_81] = var_0_82
	var_0_79[var_0_82] = var_0_81
end

local var_0_83 = string.char(168)
local var_0_84 = string.char(184)

var_0_80[var_0_83] = var_0_84
var_0_79[var_0_84] = var_0_83

function string.nlower(arg_121_0)
	arg_121_0 = string.lower(arg_121_0)

	local var_121_0 = #arg_121_0
	local var_121_1 = {}

	for iter_121_0 = 1, var_121_0 do
		local var_121_2 = string.sub(arg_121_0, iter_121_0, iter_121_0)

		var_121_1[iter_121_0] = var_0_80[var_121_2] or var_121_2
	end

	return table.concat(var_121_1)
end

local var_0_85 = {}

for iter_0_5 = 1, #var_0_76 do
	var_0_85[iter_0_5] = var_0_0.ImBool(false)
end

function seleGet()
	SeleListCommandsBool = {}

	for iter_122_0 = 1, #SeleListCommands do
		SeleListCommandsBool[iter_122_0] = var_0_0.ImBool(false)
	end
end

function seleHGet()
	SeleListKeysBool = {}

	for iter_123_0 = 1, #SeleListKeys do
		SeleListKeysBool[iter_123_0] = var_0_0.ImBool(false)
	end
end

function seleTcGet()
	SeleListCheatsBool = {}

	for iter_124_0 = 1, #SeleListCheats do
		SeleListCheatsBool[iter_124_0] = var_0_0.ImBool(false)
	end
end

function seleNtGet()
	SeleListNotesBool = {}

	for iter_125_0 = 1, #SeleListNotes do
		SeleListNotesBool[iter_125_0] = var_0_0.ImBool(false)
	end
end

function clearSeleListNotesBool(arg_126_0)
	if arg_126_0 then
		for iter_126_0 = 1, #SeleListNotes do
			SeleListNotesBool[iter_126_0].v = false
		end

		SeleListNotesBool[arg_126_0].v = true
	end
end

function clearSeleListCheatsBool(arg_127_0)
	if arg_127_0 then
		for iter_127_0 = 1, #SeleListCheats do
			SeleListCheatsBool[iter_127_0].v = false
		end

		SeleListCheatsBool[arg_127_0].v = true
	end
end

function clearSeleListKeysBool(arg_128_0)
	if arg_128_0 then
		for iter_128_0 = 1, #SeleListKeys do
			SeleListKeysBool[iter_128_0].v = false
		end

		SeleListKeysBool[arg_128_0].v = true
	end
end

function clearSeleListCommandsBool(arg_129_0)
	if arg_129_0 then
		for iter_129_0 = 1, #SeleListCommands do
			SeleListCommandsBool[iter_129_0].v = false
		end

		SeleListCommandsBool[arg_129_0].v = true
	end
end

function clearSeleListBool(arg_130_0)
	for iter_130_0 = 1, #var_0_76 do
		var_0_85[iter_130_0].v = false
	end

	var_0_85[arg_130_0].v = true
end

var_0_10.cdef(
"\tshort GetKeyState(int nVirtKey);\n\tbool GetKeyboardLayoutNameA(char* pwszKLID);\n\tint GetLocaleInfoA(int Locale, int LCType, char* lpLCData, int cchData);\n")

local var_0_86 = 32
local var_0_87 = var_0_10.new("char[?]", var_0_86)
local var_0_88 = var_0_10.new("char[?]", var_0_86)

buy = {
	[15] = smt1,
	[16] = smt2,
	[17] = tps
}

function mainmenu()
	if _G.mass[mkey] then
		rank_state = true

		if not var_0_37.v and not var_0_38.v and not var_0_39.v and not var_0_40.v and not var_0_41.v and not var_0_42.v then
			if var_0_37.v then
				var_0_37.v = not var_0_37.v.v
			elseif var_0_38.v then
				var_0_38.v = not var_0_38.v
			elseif var_0_39.v then
				var_0_39.v = not var_0_39.v
			elseif var_0_40.v then
				var_0_40.v = not var_0_40.v
			elseif var_0_41.v then
				var_0_41.v = not var_0_41.v
			elseif var_0_42.v then
				var_0_42.v = not var_0_42.v
			elseif var_0_43.v then
				var_0_43.v = not var_0_43.v
			end

			var_0_36.v = not var_0_36.v
			selected = 1
			selectedCommands = 1
			selectedKeys = 1
			selectedCheats = 1
			selectedNotes = 1
			reportItem = 1
			err_mes = nil
			err_mes2 = nil
			suc_mes = nil
			addCC = false
			addKK = false
			addTC = false
			addNT = false
		end
	end
end

function onSystemMessage(arg_132_0, arg_132_1, arg_132_2)
	if arg_132_2 and isSampAvailable() and (arg_132_2.filename == thisScript().name .. ".lua" or arg_132_2.filename == thisScript().name .. ".luac") and log then
		if arg_132_1 == 3 then
			log.fatal(arg_132_0)
		else
			log.info(arg_132_0)
		end
	end
end

orientirNotify = {}
orientir = {
	["���������� Flint 24-7"] = "���������� � ���-������, ������: �-12. ��������: ����� �0.",
	["���������� Easter 24-7"] = "���������� � ���-������, ������: �-6. ��������: ����� ��.",
	["���������� Bayside 24-7"] = "���������� � ���-������, ������: �-2. ��������: ������ ������.",
	["���������� Palomino Creek 24-7"] = "���������� � ���-�������, ������: �-21. ��������: �������� ����.",
	["���������� �������� [LVH]"] = "���������� � ���-���������, ������: �-19. ��������: ������� ��.",
	["���������� �������� [FCMC]"] = "���������� � ���-��������, ������: �-11. ��������: �������� ���� �������.",
	["���������� Dillimore 24-7"] = "���������� � ���-�������, ������: �-15. ��������: ��� ��.",
	["���������� Whetstone 24-7"] = "���������� � ���-������, ������: �-6. ��������: ��������� �2.",
	["���������� Redsands West 24-7"] = "���������� � ���-���������, ������: �-18. ��������: ��� ��.",
	["���������� Julius 24-7"] = "���������� � ���-���������, ������: �-23. ��������: ���.",
	["���������� Mulholland 24-7"] = "���������� � ���-�������, ������: �-16. ��������: ��� ����� �������.",
	["���������� Fort Carson 24-7"] = "���������� � ���-���������, ������: �-12. ��������: �������� ����-�������.",
	["���������� Juniper 24-7"] = "���������� � ���-������, ������: �-3. ��������: ������� ����� ��.",
	["���������� Emerald Isle 24-7"] = "���������� � ���-���������, ������: �-21. ��������: ������� ��.",
	["���������� Creek 24-7"] = "���������� � ���-���������, ������: �-24. ��������: �� ��.",
	["���������� �������� [CMH]"] = "���������� � ���-�������, ������: �-17. ��������: �������� SoS.",
	["���������� Idlewood 24-7"] = "���������� � ���-�������, ������: �-20. ��������: ��� � ������� ������.",
	["���������� �������� [CGH]"] = "���������� � ���-������, ������: �-21. ��������: �������� � ������� ������.",
	["���������� Flats 24-7"] = "���������� � ���-������, ������: �-2. ��������: ����������.",
	["���������� �������� [ASGH]"] = "���������� � ���-�������, ������: �-17. ��������: �������� ��.",
	["���������� Come-A-Lot 24-7"] = "���������� � ���-���������, ������: �-21. ��������: ������ \"4 �������.\"",
	["���������� �������� [SFMC]"] = "���������� � ���-������, ������: �-2. ��������: �������� ��."
}
orientirCity = {
	["���������� Flint 24-7"] = "LS",
	["���������� Easter 24-7"] = "SF",
	["���������� Bayside 24-7"] = "SF",
	["���������� Palomino Creek 24-7"] = "LV",
	["���������� �������� [LVH]"] = "LV",
	["���������� �������� [FCMC]"] = "LV",
	["���������� Dillimore 24-7"] = "LS",
	["���������� Whetstone 24-7"] = "SF",
	["���������� Redsands West 24-7"] = "LV",
	["���������� Julius 24-7"] = "LV",
	["���������� Mulholland 24-7"] = "LS",
	["���������� Fort Carson 24-7"] = "LV",
	["���������� Juniper 24-7"] = "SF",
	["���������� Emerald Isle 24-7"] = "LV",
	["���������� Creek 24-7"] = "LV",
	["���������� �������� [CMH]"] = "LS",
	["���������� Idlewood 24-7"] = "LS",
	["���������� �������� [CGH]"] = "LS",
	["���������� Flats 24-7"] = "SF",
	["���������� �������� [ASGH]"] = "LS",
	["���������� Come-A-Lot 24-7"] = "LV",
	["���������� �������� [SFMC]"] = "SF"
}
orientirSector = {
	["���������� Flint 24-7"] = "�-12",
	["���������� Easter 24-7"] = "�-6",
	["���������� Bayside 24-7"] = "�-2",
	["���������� Palomino Creek 24-7"] = "�-21",
	["���������� �������� [LVH]"] = "�-19",
	["���������� �������� [FCMC]"] = "�-11",
	["���������� Dillimore 24-7"] = "�-15",
	["���������� Whetstone 24-7"] = "�-6",
	["���������� Redsands West 24-7"] = "�-18",
	["���������� Julius 24-7"] = "�-23",
	["���������� Mulholland 24-7"] = "�-16",
	["���������� Fort Carson 24-7"] = "�-12",
	["���������� Juniper 24-7"] = "�-3",
	["���������� Emerald Isle 24-7"] = "�-21",
	["���������� Creek 24-7"] = "�-24",
	["���������� �������� [CMH]"] = "�-17",
	["���������� Idlewood 24-7"] = "�-20",
	["���������� �������� [CGH]"] = "�-21",
	["���������� Flats 24-7"] = "�-2",
	["���������� �������� [ASGH]"] = "�-17",
	["���������� Come-A-Lot 24-7"] = "�-21",
	["���������� �������� [SFMC]"] = "�-2"
}
timingReasons = {
	["���������� Flats 24-7"] = true,
	["���������� Easter 24-7"] = true,
	["���������� Bayside 24-7"] = true,
	["���������� Ammo LS"] = true,
	["���������� Fort Carson 24-7"] = true,
	["���������� Ammo LV"] = true,
	["���������� Julius 24-7"] = true,
	["���������� Dillimore 24-7"] = true,
	["���������� Whetstone 24-7"] = true,
	["���������� Redsands West 24-7"] = true,
	["���������� Palomino Creek 24-7"] = true,
	["���������� Mulholland 24-7"] = true,
	["���������� Ammo SF"] = true,
	["���������� Juniper 24-7"] = true,
	["���������� Emerald Isle 24-7"] = true,
	["���������� Creek 24-7"] = true,
	["���������� Victim SF"] = true,
	["���������� Idlewood 24-7"] = true,
	["���������� Victim LS"] = true,
	["���������� Victim LV"] = true,
	["���������� Flint 24-7"] = true,
	["���������� Come-A-Lot 24-7"] = true
}
timings = {}

function showHelp(arg_133_0)
	var_0_0.TextDisabled("(?)")

	if var_0_0.IsItemHovered() then
		var_0_0.BeginTooltip()
		var_0_0.PushTextWrapPos(var_0_0.GetFontSize() * 35)
		var_0_0.TextUnformatted(arg_133_0)
		var_0_0.PopTextWrapPos()
		var_0_0.EndTooltip()
	end
end

function showCommand(arg_134_0)
	var_0_0.TextDisabled("(INFO)")

	if var_0_0.IsItemHovered() then
		var_0_0.BeginTooltip()
		var_0_0.PushTextWrapPos(var_0_0.GetFontSize() * 35)
		var_0_0.TextUnformatted(u8(arg_134_0))
		var_0_0.PopTextWrapPos()
		var_0_0.EndTooltip()
	end
end

timer = 0
myfrac = 0
ur1s, ur2s = false, false

local var_0_89 = {}
local var_0_90 = true
local var_0_91
local var_0_92 = {}
local var_0_93 = true

function var_0_0.BeforeDrawFrame()
	if var_0_91 == nil then
		local var_135_0 = var_0_0.ImGlyphRanges({
			var_0_7.min_range,
			var_0_7.max_range
		})
		local var_135_1 = var_0_0.ImFontConfig()

		var_135_1.MergeMode = true
		var_0_91 = var_0_0.GetIO().Fonts:AddFontFromFileTTF("moonloader/resource/fonts/fontawesome-webfont.ttf", 14,
			var_135_1, var_135_0)
	end

	if #var_0_89 == 0 or not var_0_89[tonumber(se.squad.size)] then
		if var_0_90 then
			squad_font_config = var_0_0.ImFontConfig()
			squad_font_config.MergeMode = false
			squad_font_builder = var_0_0.ImFontAtlasGlyphRangesBuilder()

			squad_font_builder:AddRanges(var_0_0.GetIO().Fonts:GetGlyphRangesCyrillic())
			squad_font_builder:AddText("������������������")

			glyph_ranges = squad_font_builder:BuildRanges()
			var_0_90 = false
		end

		if not var_0_89[tonumber(se.squad.size)] then
			var_0_89[tonumber(se.squad.size)] = var_0_0.GetIO().Fonts:AddFontFromFileTTF(
			getFolderPath(20) .. "\\trebucbd.ttf", tonumber(se.squad.size), squad_font_config, glyph_ranges)
		end
	end

	if #var_0_92 == 0 or not var_0_92[tonumber(se.squad.size)] then
		if var_0_93 then
			fa_glyph_ranges = var_0_0.ImGlyphRanges({
				var_0_7.min_range,
				var_0_7.max_range
			})
			squad_fa_font_config = var_0_0.ImFontConfig()
			squad_fa_font_config.MergeMode = false
			var_0_93 = false
		end

		if not var_0_92[tonumber(se.squad.size)] then
			var_0_92[tonumber(se.squad.size)] = var_0_0.GetIO().Fonts:AddFontFromFileTTF(
			"moonloader/resource/fonts/fontawesome-webfont.ttf", tonumber(se.squad.size), squad_fa_font_config,
				fa_glyph_ranges)
		end
	end

	if as.fonts.speedometr == nil then
		as.spd.speed_font_size = 70
		as.spd.fuel_font_size = 30
		as.spd.speedometr_font_size = 15
		as.spd.icon_font_size = 20
		as.spd.main_font = 14

		if se.main.speedometr_size == nil then
			se.main.speedometr_size = 1
		end

		if se and se.main.speedometr_size ~= nil then
			if se.main.speedometr_size == 0 then
				as.spd.speed_font_size = 50
				as.spd.fuel_font_size = 21
				as.spd.speedometr_font_size = 10
				as.spd.icon_font_size = 18
				as.spd.main_font = 12
				as.spd.window_width, as.spd.window_height = 250, 200
				as.spd.cruise_w, as.spd.cruise_h = 20, 84
				as.spd.child_left_w, as.spd.child_left_h = 79, 84
				as.spd.child_right_w, as.spd.child_right_h = 120, 84
				as.spd.kmh_pos = 57
				as.spd.cruise_minus = 25
				as.spd.speed_cursor_pos = 9
				as.spd.column_width = 25
			elseif se.main.speedometr_size == 1 then
				as.spd.speed_font_size = 70
				as.spd.fuel_font_size = 30
				as.spd.speedometr_font_size = 15
				as.spd.icon_font_size = 20
				as.spd.main_font = 14
				as.spd.window_width, as.spd.window_height = 250, 200
				as.spd.cruise_w, as.spd.cruise_h = 20, 100
				as.spd.child_left_w, as.spd.child_left_h = 110, 100
				as.spd.child_right_w, as.spd.child_right_h = 150, 105
				as.spd.kmh_pos = 75
				as.spd.cruise_minus = 25
				as.spd.speed_cursor_pos = 9
				as.spd.column_width = 30
			elseif se.main.speedometr_size == 2 then
				as.spd.speed_font_size = 100
				as.spd.fuel_font_size = 42
				as.spd.speedometr_font_size = 21
				as.spd.icon_font_size = 29
				as.spd.main_font = 20
				as.spd.window_width, as.spd.window_height = 250, 200
				as.spd.cruise_w, as.spd.cruise_h = 29, 143
				as.spd.child_left_w, as.spd.child_left_h = 157, 143
				as.spd.child_right_w, as.spd.child_right_h = 214, 143
				as.spd.kmh_pos = 105
				as.spd.cruise_minus = 34
				as.spd.speed_cursor_pos = 13
				as.spd.column_width = 30
			end
		end

		as.fonts.speedometr = {}
		as.fonts.speedometr.speed = var_0_0.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(20) .. "\\trebucbd.ttf",
			as.spd.speed_font_size, nil, var_0_0.GetIO().Fonts:GetGlyphRangesCyrillic())
		as.fonts.speedometr.fuel = var_0_0.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(20) .. "\\trebucbd.ttf",
			as.spd.fuel_font_size, nil, var_0_0.GetIO().Fonts:GetGlyphRangesCyrillic())
		as.fonts.speedometr.font = var_0_0.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(20) .. "\\trebucbd.ttf",
			as.spd.speedometr_font_size, nil, var_0_0.GetIO().Fonts:GetGlyphRangesCyrillic())
		as.fonts.speedometr.icon = var_0_0.GetIO().Fonts:AddFontFromFileTTF(
		"moonloader/resource/fonts/fontawesome-webfont.ttf", as.spd.icon_font_size, squad_fa_font_config, fa_glyph_ranges)
		as.fonts.speedometr.main_font = var_0_0.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(20) .. "\\trebucbd.ttf",
			as.spd.main_font, nil, var_0_0.GetIO().Fonts:GetGlyphRangesCyrillic())
		as.fonts.speedometr.main_fa_font = var_0_0.GetIO().Fonts:AddFontFromFileTTF(
		"moonloader/resource/fonts/fontawesome-webfont.ttf", as.spd.main_font, squad_fa_font_config, fa_glyph_ranges)
	end
end

function var_0_0.ToggleButton(arg_136_0, arg_136_1)
	local var_136_0 = false

	if LastActiveTime == nil then
		LastActiveTime = {}
	end

	if LastActive == nil then
		LastActive = {}
	end

	local function var_136_1(arg_137_0)
		return arg_137_0 < 0 and 0 or arg_137_0 > 1 and 1 or arg_137_0
	end

	local var_136_2 = var_0_0.GetCursorScreenPos()
	local var_136_3 = var_0_0.GetWindowDrawList()
	local var_136_4 = var_0_0.GetTextLineHeightWithSpacing() + var_0_0.GetStyle().FramePadding.y / 2
	local var_136_5 = var_136_4 * 1.55
	local var_136_6 = var_136_4 * 0.5
	local var_136_7 = 0.15

	if var_0_0.InvisibleButton(arg_136_0, var_0_0.ImVec2(var_136_5, var_136_4)) then
		arg_136_1.v = not arg_136_1.v
		var_136_0 = true
		LastActiveTime[tostring(arg_136_0)] = os.clock()
		LastActive[arg_136_0] = true
	end

	local var_136_8 = arg_136_1.v and 1 or 0

	if LastActive[arg_136_0] then
		local var_136_9 = os.clock() - LastActiveTime[tostring(arg_136_0)]

		if var_136_9 <= var_136_7 then
			local var_136_10 = var_136_1(var_136_9 / var_136_7)

			var_136_8 = arg_136_1.v and var_136_10 or 1 - var_136_10
		else
			LastActive[arg_136_0] = false
		end
	end

	local var_136_11

	if var_0_0.IsItemHovered() then
		var_136_11 = var_0_0.GetColorU32(var_0_0.GetStyle().Colors[var_0_0.Col.FrameBgHovered])
	else
		var_136_11 = var_0_0.GetColorU32(var_0_0.GetStyle().Colors[var_0_0.Col.FrameBg])
	end

	var_136_3:AddRectFilled(var_136_2, var_0_0.ImVec2(var_136_2.x + var_136_5, var_136_2.y + var_136_4), var_136_11,
		var_136_4 * 0.5)
	var_136_3:AddCircleFilled(
	var_0_0.ImVec2(var_136_2.x + var_136_6 + var_136_8 * (var_136_5 - var_136_6 * 2), var_136_2.y + var_136_6),
		var_136_6 - 1.5,
		var_0_0.GetColorU32(arg_136_1.v and var_0_0.GetStyle().Colors[var_0_0.Col.ButtonActive] or
		var_0_0.GetStyle().Colors[var_0_0.Col.Button]))

	return var_136_0
end

wanted_info = {}

local var_0_94, var_0_95 = getScreenResolution()
local var_0_96 = var_0_0.ImVec2(-0.1, 0)

math.randomseed(os.time())

function var_0_0.OnDrawFrame()
	local var_138_0, var_138_1 = getScreenResolution()
	local var_138_2 = var_0_0.ImVec2(-0.1, 0)

	var_0_0.ShowCursor = not im.windows.squad.v and not im.windows.partner.v and not im.windows.timings.v and
	not var_0_43.v and not var_0_44.v and not im.windows.speedometr.v and not im.windows.quitinformer.v or var_0_36.v or
	var_0_37.v or var_0_38.v or var_0_39.v or var_0_40.v or var_0_41.v or var_0_42.v or var_0_46.v or var_0_47.v or
	var_0_49.v or var_0_50.v or var_0_51.v or var_0_52.v or im.windows.share_settings.v or im.windows.accept_settings.v or
	im.windows.mycard.v or im.windows.jrules.v or im.windows.markermanage.v or im.windows.hookchatinfo.v or
	im.windows.allkeys.v or im.windows.allcommands.v or im.windows.alltags.v or im.windows.deplog.v or
	im.windows.clearwantedlog.v or im.windows.notes.v or im.windows.notes_show.v or im.windows.defuse.v or
	im.windows.aid.v or im.windows.smslogs.v or im.windows.notepad.v

	if sampGetGamestate() == 3 and letsGame then
		if var_0_36.v and sampGetGamestate() == 3 then
			var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_138_0 / 2, var_138_1 / 2), var_0_0.Cond.FirstUseEver,
				var_0_0.ImVec2(0.5, 0.5))
			var_0_0.SetNextWindowSize(var_0_0.ImVec2(390, 630), var_0_0.Cond.FirstUseEver)
			var_0_0.Begin(u8("Police SF"), var_0_36,
				var_0_0.WindowFlags.HorizontalScrollbar + var_0_0.WindowFlags.NoMove + var_0_0.WindowFlags.NoTitleBar +
				var_0_0.WindowFlags.NoResize)
			var_0_0.Image(var_0_15.logo, var_0_0.ImVec2(374, 492))

			if var_0_0.Button(var_0_7.ICON_USER_O .. u8(" �� ������"), var_138_2) then
				if var_0_48.v then
					am("����� ������, ��� " .. tostring(auth_cl) .. " ���.")
				else
					var_0_48.v = not var_0_48.v

					clauth(30)

					var_0_36.v = false
				end
			end

			if var_0_0.Button(var_0_7.ICON_DATABASE .. u8(" ���� ������"), var_138_2) then
				var_0_47.v = not var_0_47.v
				var_0_36.v = false
			end

			if as.other.notifications == 0 and (not var_0_0.Button(var_0_7.ICON_BELL_SLASH_O .. u8(" ����������� ���"), var_138_2) or true) then
				-- block empty
			elseif var_0_0.Button(var_0_7.ICON_BELL_O .. u8(" ����������� (") .. as.other.notifications .. ")", var_138_2) then
				im.windows.accept_settings.v = not im.windows.accept_settings.v
			end

			if var_0_0.Button(var_0_7.ICON_COGS .. u8(" ���������"), var_138_2) then
				var_0_42.v = not var_0_42.v
				var_0_36.v = false
			end

			if var_0_0.Button(var_0_7.ICON_POWER_OFF .. u8(" �������"), var_138_2) then
				var_0_36.v = not var_0_36.v
			end

			var_0_0.End()
		end

		if var_0_37.v and sampGetGamestate() == 3 then
			showustav()
		end

		if var_0_38.v and sampGetGamestate() == 3 then
			showekgs()
		end

		if var_0_39.v and sampGetGamestate() == 3 then
			showekgsak()
		end

		if var_0_40.v and sampGetGamestate() == 3 then
			showuk()
		end

		if var_0_41.v and sampGetGamestate() == 3 then
			showfp()
		end

		if var_0_49.v and sampGetGamestate() == 3 then
			show_sf_manual()
		end

		if var_0_50.v and sampGetGamestate() == 3 then
			show_lv_manual()
		end

		if var_0_51.v and sampGetGamestate() == 3 then
			show_ls_manual()
		end

		if var_0_52.v and sampGetGamestate() == 3 then
			show_fbi_manual()
		end

		if var_0_42.v and sampGetGamestate() == 3 then
			var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_138_0 / 2, var_138_1 / 2), var_0_0.Cond.FirstUseEver,
				var_0_0.ImVec2(0.5, 0.5))
			var_0_0.SetNextWindowSize(var_0_0.ImVec2(930, 510), var_0_0.Cond.FirstUseEver)
			var_0_0.Begin(u8("���������"), var_0_42, var_0_0.WindowFlags.NoResize + var_0_0.WindowFlags.MenuBar)
			var_0_0.BeginMenuBar()

			if var_0_0.BeginMenu(u8("����������� �")) then
				if var_0_0.MenuItem(u8("������������� ������")) then
					showCursor(false, false)
					thisScript():reload()
				end

				if var_0_0.MenuItem(u8("��������� ������")) then
					showCursor(false, false)
					thisScript():unload()
				end

				if var_0_0.MenuItem(u8("��������� � ������� (��� /rcn)")) then
					showCursor(false, false)

					var_0_42.v = false

					reconnect()
				end

				var_0_0.EndMenu()
			end

			var_0_0.PushStyleColor(var_0_0.Col.Text, var_0_0.ImVec4(0.4, 0.7, 1, 1))

			if var_0_0.MenuItem(u8("������� " .. (tostring(myfrac) == "4" and "������" or "�������"))) then
				var_0_42.v = not var_0_42.v
				im.windows.notes.v = not im.windows.notes.v
			end

			var_0_0.PopStyleColor()
			var_0_0.PushStyleColor(var_0_0.Col.Text, var_0_0.ImVec4(0.8, 0.8, 0, 1))

			if var_0_0.BeginMenu(u8("�������� ���������� �")) then
				if var_0_0.MenuItem(u8("��� ������� �������")) then
					im.windows.allcommands.v = not im.windows.allcommands.v
				end

				if var_0_0.MenuItem(u8("���������� �� ��������")) then
					im.windows.allkeys.v = not im.windows.allkeys.v
				end

				if var_0_0.MenuItem(u8("���������� �� ����� ��� ������ � ����")) then
					im.windows.alltags.v = not im.windows.alltags.v
				end

				if var_0_0.MenuItem(u8("����������� �������")) then
					selected = 20
				end

				var_0_0.EndMenu()
			end

			var_0_0.PopStyleColor()
			var_0_0.PushStyleColor(var_0_0.Col.Text, var_0_0.ImVec4(0.1, 0.8, 0.1, 1))

			if var_0_0.MenuItem(u8("��������� ���������")) then
				save_settings()
			end

			var_0_0.PopStyleColor()

			if var_0_0.MenuItem(u8("���������� �����������")) then
				im.windows.share_settings.v = not im.windows.share_settings.v
			end

			var_0_0.PushStyleColor(var_0_0.Col.Text, var_0_0.ImVec4(0.26, 0.59, 0.98, 1))

			if var_0_0.MenuItem(u8("������ ��")) then
				os.execute("explorer \"https://vk.com/samp_pdp\"")
			end

			var_0_0.PopStyleColor()
			var_0_0.EndMenuBar()
			var_0_0.BeginChild("left pane", var_0_0.ImVec2(200, 0), true)

			for iter_138_0 = 1, #var_0_76 do
				if var_0_0.Selectable(u8(var_0_76[iter_138_0]), var_0_85[iter_138_0]) then
					selected = iter_138_0
				end

				var_0_0.Separator()
			end

			var_0_0.EndChild()
			var_0_0.SameLine()
			var_0_0.BeginGroup()

			if selected == 1 then
				var_0_0.Separator()
				var_0_0.Image(var_0_15.settings_main, var_0_0.ImVec2(715, 80))
				var_0_0.Separator()
				var_0_0.Text(var_0_7.ICON_COG .. u8(" �������� ��������� ����:\n"))
				var_0_0.BeginChild("left pane##6", var_0_0.ImVec2(0, 0), true)
				var_0_0.Columns(2, _, false)
				var_0_0.SetColumnWidth(-1, 340)
				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_EYE_SLASH .. u8(" ������ ������"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("������ ������"), im.informer.infMainTazer)

				se.main.tazer = im.informer.infMainTazer.v

				var_0_0.SameLine()
				showHelp(u8("���������� / �� ���������� ��������� ������."))
				var_0_0.SameLine()

				if var_0_0.Button(u8("�������� ���������##1")) then
					chat("�������� ����� ��������� � ������� ENTER ��� ����������.")

					mouseCoord2 = true
					var_0_42.v = false
				end

				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_EYE_SLASH .. u8(" ������ Pursuit Mod"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("������ Pursuit Mod"), im.informer.infMainPursuit)

				se.main.pursuit = im.informer.infMainPursuit.v

				var_0_0.SameLine()
				showHelp(u8("���������� / �� ���������� ���� � ������� � ������������ ��."))
				var_0_0.SameLine()

				if var_0_0.Button(u8("�������� ���������##2")) then
					chat("�������� ����� ��������� � ������� ENTER ��� ����������.")

					mouseCoord3 = true
					var_0_42.v = false
				end

				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_EYE_SLASH .. u8(" �������� ������ �������������"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("�������� ������ �������������"), im.pursuit.sector)

				se.pursuit.sector = im.pursuit.sector.v

				var_0_0.SameLine()
				showHelp(u8(
				"������� ��������� �� ���� ��������. � ��������� ������ (Pursuit Mod) ���������� ������� ������ ������������� ������ (������� �����)."))
				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_EYE_SLASH .. u8(" ��������� ��� ��������� � �������������"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("��������� ��� ��������� � �������������"), im.informer.infMainHelpSt)

				se.main.help_st = im.informer.infMainHelpSt.v

				var_0_0.SameLine()
				showHelp(u8(
				"���������� / �� ���������� ��������� ������� ��� ������������ �� ������� � ��� ������������� ����������."))
				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_CROSSHAIRS .. u8(" ����������"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("����������"), im.informer.infMainAutoSu)

				se.main.auto_su = im.informer.infMainAutoSu.v

				var_0_0.SameLine()
				showHelp(u8(
				"�������������� ������ �� ������,������� �� ��� �������� �� ������ \"��������� �� ������� �������/������ ���\". ��������! ������ ������� �� ����������� �� ���� ����� � ����. �� ����� ���� �������� ��������."))
				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_ID_BADGE .. u8(" ���������"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("���������"), im.informer.infMainClistSt)

				se.main.clist_st = im.informer.infMainClistSt.v

				var_0_0.SameLine()
				showHelp(u8("������������� �������� ������������� clist ����� ���������� �� �����."))
				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_PHONE .. u8(" ��������� �����"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("��������� �����"), im.informer.infMainAutoRadio)

				se.main.autoradio = im.informer.infMainAutoRadio.v

				var_0_0.SameLine()
				showHelp(u8("������������� ������ ��������� � /seeDo ����� ������������� /r. � FBI ���� ���������."))
				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_WEIXIN .. u8(" Chat Tools"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("Chat Tools"), im.informer.infMainChatTools)

				se.main.chat_tools = im.informer.infMainChatTools.v

				var_0_0.SameLine()
				showHelp(u8("���������� ��� ����� ������� �������������� ������."))
				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_SEARCH .. u8(" ������� ������ ���"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("������� ������ ���"), im.informer.infMainOopFunc)

				se.main.oop_func = im.informer.infMainOopFunc.v

				var_0_0.SameLine()
				showHelp(u8(
				"���� ��� � ���� ������ (4 ��.� +), ����� ����� ����������, � ���� ����� �����������. ��� ������� �� ���������, ���� �� �� �������� ����� ��� ������� ������!"))

				if active and im.informer.infMainOopFunc.v then
					var_0_0.AlignTextToFramePadding()
					var_0_0.Text(var_0_7.ICON_ARROWS .. u8(" ����� ��� ������� ���"))
					var_0_0.SameLine()
					var_0_0.ToggleButton(u8("����� ��� ������� ���"), im.informer.infMainShowBlip)

					se.main.show_blip = im.informer.infMainShowBlip.v

					var_0_0.SameLine()
					showHelp(u8(
					"�������������� ������� ������� ������ ���. ����� �� �������� ��� �������, �� ����� �������� ��� � ���� ������ � ��� ������� ����� ������� �����. ��������! ������ ������� ��������� �� �������� SAMP-RP � ������������� ������� ����� ��������� ������� �� ������������� ������ �������."))
				end

				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_SEARCH_PLUS .. u8(" ������� ������ (�� ���������� ��)"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("������� ������ (�� ���������� ��)"), im.informer.infMainFastPursuit)

				se.main.fastpursuit = im.informer.infMainFastPursuit.v

				var_0_0.SameLine()
				showHelp(u8(
				"���� ��������� ������������ � ��� ��������. � ������, ���� ��������� ������������ �������� �����������, �� ����� ������ ������ �� ��� ����� ���� ���� �������."))
				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_SORT_NUMERIC_DESC .. u8(" ��������� ���������"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("��������� ���������"), im.settings.wdis)

				se.main.wdis = im.settings.wdis.v

				var_0_0.SameLine()
				showHelp(u8(
				"��� ������������ ������� ���������� �� ����. ������� - ���� ����� ��������, ������� - �� �����. ������ ������� � ������. ���� �� ������������� ����� ����� � ������ �������."))

				if se.main.wdis == true then
					var_0_0.AlignTextToFramePadding()
					var_0_0.Text(var_0_7.ICON_SORT_NUMERIC_DESC .. u8(" ��������� ��������� � ������"))
					var_0_0.SameLine()
					var_0_0.ToggleButton(u8("��������� ��������� � ������"), im.settings.wdis_distance)

					se.main.wdis_distance = im.settings.wdis_distance.v

					var_0_0.SameLine()
					showHelp(u8(
					"��� ������������ ������� ���������� �� ����. ������� - ���� ����� ��������, ������� - �� �����. ������ ������� � ������. ���� �� ������������� ����� ����� � ������ �������."))
				end

				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_REPLY .. u8(" ������� ������"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("������� ������"), im.settings.perenos)

				se.main.perenos = im.settings.perenos.v

				var_0_0.SameLine()
				showHelp(u8(
				"������� ������ ����� ������������ � ������������ ����� ����������. ��������: ��� �����, �������� � �������� ���� (/r, /rb, /m, ic, /b)"))
				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_COMMENTS .. u8(" ����� � ��� /seeMe"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("����� � ��� /seeMe"), im.settings.seeme)

				se.main.seeme = im.settings.seeme.v

				var_0_0.SameLine()
				showHelp(u8("��� �������� ������� /seeMe � ��� ������ ���������� ������������� ���������."))
				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_COMMENTS .. u8(" ����� � ��� /seeDo"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("����� � ��� /seeDo"), im.settings.seedo)

				se.main.seedo = im.settings.seedo.v

				var_0_0.SameLine()
				showHelp(u8("��� �������� ������� /seeDo � ��� ������ ���������� ������������� ���������."))
				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_PAPER_PLANE_O .. u8(" ����������� � �� � ����� ������� [/equest]"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("����������� � �� � ����� ������� [/equest]"), im.settings.equest)

				se.main.equest = im.settings.equest.v

				var_0_0.SameLine()
				showHelp(u8(
				"�� ���������� ��� � �� � ������ ��������� � ����� ���������� ������� [/equest]. � ��� � ������������ ������� ������ ���� �������� ��� �� � ������ �������� ����� � ���������� ��������� ��������� �� ������ ���������� Karimoff Dev. � ����������� �� ���������� ����� (vk.com/linda_frm)"))
				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_ID_CARD_O .. u8(" �������� ���������"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("�������� ���������"), im.windows.partner)

				se.partner.state = im.windows.partner.v

				var_0_0.SameLine()
				showHelp(u8(
				"��� ��������� ������� ����� ���������� �������, ������� ����� �������� ���������� � ����� ���������: ���, ����, ��������, �����, ������ � ������. �������� ��������, ����� ��� ��������� ���� ����� � �������� ��������� ����� ������� /pr ID."))
				var_0_0.SameLine()

				if var_0_0.Button(u8("�����������##partner")) then
					chat("�������� ����� ��������� � ������� ENTER ��� ����������.")

					as.partner.changepos = true
					var_0_42.v = false
				end

				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_INFO .. u8(" ����������� ID ������� � ����"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("����������� ID ������� � ����"), im.settings.chatid)

				se.main.chatid = im.settings.chatid.v

				var_0_0.SameLine()
				showHelp(u8("������ ������� ����������� ID � ���� ������ (������ RP ������) � ����."))
				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_BAN .. u8(" ����������� ���������� � ����"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("����������� ���������� � ����"), im.settings.adblock)

				se.main.adblock = im.settings.adblock.v

				var_0_0.SameLine()
				showHelp(u8(
				"������ ������� ������� �� ���� ���������� ��������� �������� � ��������� ���������� �� ���� \"����� ������ /ask\" � �.�. ���� � ���������� ����� ��� ���, �� ������ �� ����� ������."))
				var_0_0.AlignTextToFramePadding()
				var_0_0.InputText(u8("����������"), im.other.adblockignore)

				se.other.adblockignore = u8:decode(im.other.adblockignore.v)

				var_0_0.SameLine()
				showHelp(u8(
				"������� ���������� ����� �������, ��������� ����� �� ����� ������������� ADBlock'��. ��������! ����������� ������� ������ % (�������), ����� ������ ���������� � �������. ����� ������ ����������� ���������. �� ����������� ������� ���������� ���������, ���� �� � ��� �� ������������, ������ ����� �������. ���������� �� ���������� ���������� ��������� � �������� �������� ����������� ���."))
				var_0_0.NextColumn()
				var_0_0.InputText(var_0_7.ICON_FAST_FORWARD .. u8(" ���"), im.informer.infMainTag)

				se.main.tag = im.informer.infMainTag.v

				var_0_0.InputText(var_0_7.ICON_CAR .. u8(" ����������"), im.informer.infMainArea)

				im.informer.infMainArea.v = string.upper(im.informer.infMainArea.v)
				se.main.area = string.upper(im.informer.infMainArea.v)

				var_0_0.InputText(var_0_7.ICON_USER_PLUS .. u8(" ��������"), im.informer.infMainPartner)

				if se.main.partner.v ~= im.informer.infMainPartner.v then
					se.main.partner = im.informer.infMainPartner.v
				end

				var_0_0.InputText(var_0_7.ICON_CREDIT_CARD .. u8(" ���� ���������"), im.informer.infMainRang)

				se.main.rang = im.informer.infMainRang.v

				var_0_0.InputText(var_0_7.ICON_ID_BADGE .. u8(" �����"), im.informer.infMainClist)

				se.main.clist = im.informer.infMainClist.v

				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_VENUS_MARS .. u8(im.informer.infMainSex.v and " � ������" or " � �������"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("##sex"), im.informer.infMainSex)

				se.main.sex = im.informer.infMainSex.v

				var_0_0.SameLine()
				showHelp(u8("������ �� ���������."))

				if var_0_0.Button(var_0_7.ICON_EYE .. u8(" �������� ���")) then
					se.main.hud = true

					displayHud(se.main.hud)
					am("HUD �������.")
				end

				var_0_0.SameLine()

				if var_0_0.Button(var_0_7.ICON_EYE_SLASH .. u8(" ��������� ���")) then
					se.main.hud = false

					displayHud(se.main.hud)
					am("HUD ��������.")
				end

				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_ARROWS .. u8(" �������������� /patrul ��� ������"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("�������������� /patrul ��� ������"), im.informer.infMainShowPursuit)

				se.main.show_pursuit = im.informer.infMainShowPursuit.v

				var_0_0.SameLine()
				showHelp(u8(
				"������ /patrul � ������ ������. ��������! �������������� ���� ������� ����� ���� �������� ��������, ��������� ������� ��������� ������� ������ � ������, ����� �� ������ ID ������. �� ������������� ����������� ������� ��� ������� ����� ���� ������������ �������������� �������."))
				var_0_0.AlignTextToFramePadding()

				if se.main.showranks then
					var_0_0.PushStyleColor(var_0_0.Col.Button, var_0_0.ImVec4(0.1, 0.5, 0.1, 1))

					if var_0_0.Button(var_0_7.ICON_EYE .. u8(" �������� �����")) and _G.mass[mkey] then
						se.main.showranks = true

						sampSendSystemChat("/members 1")
					end

					var_0_0.PopStyleColor()
				elseif var_0_0.Button(var_0_7.ICON_EYE .. u8(" �������� �����")) and _G.mass[mkey] then
					se.main.showranks = true

					sampSendSystemChat("/members 1")
				end

				var_0_0.SameLine()

				if var_0_0.Button(var_0_7.ICON_EYE_SLASH .. u8(" ��������� �����")) and _G.mass[mkey] then
					se.main.showranks = false

					for iter_138_1, iter_138_2 in pairs(plmarks) do
						sampDestroy3dText(iter_138_2)
					end
				end

				var_0_0.SameLine()
				showHelp(u8("���������� ��� ������� ������ ������."))
				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_TAXI .. u8(" �������������� �����������"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("�������������� �����������"), im.settings.strobe)

				se.main.strobe = im.settings.strobe.v

				var_0_0.SameLine()
				showHelp(u8(
				"������������� ���������� ����������� �� ����� ��������� ��������� ������ �� ���������� (��������! ���������� �����������! ��� ����� ���� ��������� ��������� �������! �� ������ ���� �������� �������������� �������. ����������� �� ���� ����� � ����!)"))
				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_QUESTION_CIRCLE .. u8(" ���� ������ � �����"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("���� ������ � �����"), im.settings.changeradiocolor)

				se.main.changeradiocolor = im.settings.changeradiocolor.v

				var_0_0.SameLine()
				showHelp(u8("������ ������� ����� ���������� ��� ������ � ����� �� ���� ��� �������� ������."))
				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_STREET_VIEW .. u8(" ����� �� �������� SOS"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("����� �� �������� SOS"), im.settings.soswp)

				se.main.soswp = im.settings.soswp.v

				var_0_0.SameLine()
				showHelp(u8(
				"������ ������� ����� ������� ����� �� �������, ������ ��������� ���������, ������ SOS, ������ ������. ���� � ��� ���������� ���-���, ���������� ������ SOS, �� ����� ����������� �� ���-���. ����� ������������ ���� �� �������� ������."))

				if tostring(myfrac) == "4" then
					var_0_0.AlignTextToFramePadding()
					var_0_0.Text(var_0_7.ICON_BOMB .. u8(" ��������� �������"))
					var_0_0.SameLine()
					var_0_0.ToggleButton(u8("��������� �������"), im.settings.grenade)

					se.main.grenade = im.settings.grenade.v

					var_0_0.SameLine()
					showHelp(u8("������ ������� ������������� ���������� ��������� �������� �� ����� ������ �������."))
				end

				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_COMMENTS .. u8(" ����������� SMS"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("����������� SMS"), im.settings.smslog)

				se.main.smslog = im.settings.smslog.v

				var_0_0.SameLine()
				showHelp(u8(
				"��� �������� SMS ����� ������������ � ������. ���� ��������� � ����� moonloder/PD-Project/sms-log � �������������� �� �����."))

				if im.settings.smslog.v then
					var_0_0.SameLine()

					if var_0_0.Button(u8("����##smslog")) then
						getSmsLog()

						im.windows.smslogs.v = not im.windows.smslogs.v
					end
				end

				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_COMMENTS .. u8(" ����������� ����� ������������"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("����������� ����� ������������"), im.settings.deplog)

				se.main.deplog = im.settings.deplog.v

				var_0_0.SameLine()
				showHelp(u8("����������� ����� ������������ (/dep)."))

				if im.settings.deplog.v then
					var_0_0.SameLine()

					if var_0_0.Button(u8("����")) then
						deplog_text = nil
						im.windows.deplog.v = not im.windows.deplog.v
					end
				end

				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_COMMENTS .. u8(" ����������� ������ �������"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("����������� ������ �������"), im.settings.clearwantedlog)

				se.main.clearwantedlog = im.settings.clearwantedlog.v

				var_0_0.SameLine()
				showHelp(u8("����������� ������ ������� (/clear)."))

				if im.settings.clearwantedlog.v then
					var_0_0.SameLine()

					if var_0_0.Button(u8("����##clearwantedlog")) then
						clearwantedlog_text = nil
						im.windows.clearwantedlog.v = not im.windows.clearwantedlog.v
					end
				end

				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_COMMENTS .. u8(" ��� PD-Project"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("��� PD-Project"), im.settings.chat)

				se.chat.status = im.settings.chat.v

				var_0_0.SameLine()
				showHelp(u8(
				"�� ������ �������� ���� ��������� ������������� ��� ����� ��������, ������������� PD-Project �� ���� �������� Samp-Rp. ����� ������ � ���, ����������� ������� /j."))
				var_0_0.SameLine()

				if var_0_0.Button(u8("������� ����")) then
					var_0_42.v = not var_0_42.v
					im.windows.jrules.v = not im.windows.jrules.v
				end

				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_CIRCLE .. u8(" ������ ������ �� �������"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("������ ������ �� �������"), im.settings.newsp)

				se.main.newsp = im.settings.newsp.v

				var_0_0.SameLine()
				showHelp(u8(
				"������ ������� ��������� ������ ������ �� �������. ����������� � ������ ��� ��� ������ � ����� (�������� ����� ������) � ������� �� ������������� ������� ������ ������."))
				var_0_0.AlignTextToFramePadding()
				var_0_0.Text(var_0_7.ICON_CIRCLE .. u8(" �������� ��� ���������"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("�������� ��� ���������"), im.settings.aircircle)

				se.other.aircircle = im.settings.aircircle.v

				var_0_0.SameLine()
				showHelp(u8(
				"�������� ������� ���� ��� ���������� �� ���������� �� 20 ������ � ����������� ����� ��� ������. ������ ���� ����� ��������������� ��������� � ���� ������ �������� ��� ���������� �������."))
				var_0_0.Columns(1)
				var_0_0.Separator()
				var_0_0.Text(var_0_7.ICON_CLONE .. u8(" ������� WANTED � ��������� ���"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("������� WANTED � ��������� ���"), im.wanted.state)

				se.wanted.state = im.wanted.state.v

				if im.wanted.state.v then
					showinfwanted()
				end

				var_0_0.Separator()
				var_0_0.Text(var_0_7.ICON_COG .. u8(" ��������� ������"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("��������� ������"), im.informer.infMainWeapon)

				se.main.weapon = im.informer.infMainWeapon.v

				if im.informer.infMainWeapon.v then
					showinfmainweapon()
				end

				var_0_0.Columns(1)
				var_0_0.Separator()

				if var_0_0.Button(u8("�������� ������ ���������"), var_138_2) then
					rank_state = true

					print("123")
					sampSendChat("/stats")
				end

				var_0_0.EndChild()
			elseif selected == 2 then
				selectedIm()
			elseif selected == 3 then
				selectedIm3()
			elseif selected == 4 then
				selectedIm4()
			elseif selected == 5 then
				selectedIm5()
			elseif selected == 6 then
				var_0_0.Separator()
				var_0_0.Image(var_0_15.settings_support, var_0_0.ImVec2(715, 80))
				var_0_0.Separator()
				var_0_0.Text(var_0_7.ICON_COG .. u8(" ��������� � �������������:\n"))
				var_0_0.SameLine()
				showHelp(u8("��������� � ����������� ���� ����������� �� ���������."))
				var_0_0.Separator()
				var_0_0.Columns(2, _, false)

				if reportItem == 1 or reportItem == 3 then
					var_0_0.PushStyleColor(var_0_0.Col.Button, var_0_0.ImVec4(0.1, 0.5, 0.1, 0.7))
					var_0_0.PushStyleColor(var_0_0.Col.ButtonHovered, var_0_0.ImVec4(0.1, 0.5, 0.1, 0.8))
					var_0_0.PushStyleColor(var_0_0.Col.ButtonActive, var_0_0.ImVec4(0.1, 0.5, 0.1, 1))

					if var_0_0.Button(u8("����������� �� ���������"), var_138_2) then
						reportItem = 1
					end

					var_0_0.PopStyleColor()
					var_0_0.PopStyleColor()
					var_0_0.PopStyleColor()
				elseif var_0_0.Button(u8("����������� �� ���������"), var_138_2) then
					reportItem = 1
				end

				var_0_0.NextColumn()

				if reportItem == 2 or reportItem == 4 then
					var_0_0.PushStyleColor(var_0_0.Col.Button, var_0_0.ImVec4(0.1, 0.5, 0.1, 0.7))
					var_0_0.PushStyleColor(var_0_0.Col.ButtonHovered, var_0_0.ImVec4(0.1, 0.5, 0.1, 0.8))
					var_0_0.PushStyleColor(var_0_0.Col.ButtonActive, var_0_0.ImVec4(0.1, 0.5, 0.1, 1))

					if var_0_0.Button(u8("��������� �� �������"), var_138_2) then
						reportItem = 2
					end

					var_0_0.PopStyleColor()
					var_0_0.PopStyleColor()
					var_0_0.PopStyleColor()
				elseif var_0_0.Button(u8("��������� �� �������"), var_138_2) then
					reportItem = 2
				end

				var_0_0.Columns(1)
				var_0_0.Separator()

				if reportItem == 1 then
					var_0_0.PushTextWrapPos()
					var_0_0.Text(u8(
					"����������� �� ��������� �������, ������������ �������������� PD-Project. ������ ��� ������� ���� �����������, �������������� �������. ��������, ���-�� ��� ���� ��� �����������. ������������ �������� � �������� ���������. ��������������� ��������, ����, ����, ������� - �������� � ������� �������� ��� ����������� ���������� ������������."))

					if var_0_0.Button(u8("������ ���� �����������")) then
						reportItem = 3
					end

					var_0_0.SameLine()

					if var_0_0.Button(u8(updateReportsTime ~= nil and "�������� ������ (" .. 30 - (os.time() - updateReportsTime) .. " ���.)##positive" or "�������� ������##positive")) then
						if not updateReportsTime then
							updateReportsTime = os.time()

							getReports()
						elseif os.time() - updateReportsTime < 30 then
							chat("��������� ������ ����� ��� � 30 ������!")
						else
							getReports()
						end
					end

					var_0_0.SameLine()
					var_0_0.PushItemWidth(200)
					var_0_0.InputText(u8("����� �� ������##positiveReports"), im.reports.search_3)
				end

				if reportItem == 2 then
					var_0_0.PushTextWrapPos()
					var_0_0.Text(u8(
					"��������� �� ������� � ����, ������������ �������������� PD-Project. ������ ��� �������� � �����-���� ������, �������������� �������. ��������, ���-�� ��� ������� �� ���� ������. ������������ �������� � �������� ���������. ��������������� ��������, ����, ����, ������� - �������� � ������� �������� ��� ����������� ���������� ������������."))

					if var_0_0.Button(u8("�������� �� ������")) then
						reportItem = 4
					end

					var_0_0.SameLine()

					if var_0_0.Button(u8(updateReportsTime ~= nil and "�������� ������ (" .. 30 - (os.time() - updateReportsTime) .. " ���.)##negative" or "�������� ������##negative")) then
						if not updateReportsTime then
							updateReportsTime = os.time()

							getReports()
						elseif os.time() - updateReportsTime < 30 then
							chat("��������� ������ ����� ��� � 30 ������!")
						else
							getReports()
						end
					end

					var_0_0.SameLine()
					var_0_0.PushItemWidth(200)
					var_0_0.InputText(u8("����� �� ������##negativeReports"), im.reports.search_4)
				end

				if reportItem == 3 then
					var_0_0.PushTextWrapPos()
					var_0_0.Text(u8(
					"����������� � ������������! ����� �� ������ ������ ���� ���� �� ��������� �������. ����������� ������� �������������, ������������ ����������� ������� (����������), ���������� ����-����, ����������� ����, ������������� ���-����/����-����. �� ��������� ������ ������� �������� ��� ����������� �������������� � ������������. ����� ��������� ����������� �������, ��� ����� ����������� ����� ��� �� ������ ������."))

					if var_0_0.Button(u8("������� ����� ����������")) then
						reportItem = 1
					end
				end

				if reportItem == 4 then
					var_0_0.PushTextWrapPos()
					var_0_0.Text(u8(
					"����������� � ������������! ����� �� ������ �������� �� �������, � �������� �� ���������� � �������. ����������� ������� �����������, ������������ ����������� ������� (����������), ���������� ����-����, ����������� ����, ������������� ���-����/����-����. �� ��������� ������ ������� �������� ��� ����������� �������������� � ������������. ����� ���, ��� ���-���� �������, 5 ��� �������, ��� ��� ������������� ������, � �� ���� ����������������."))

					if var_0_0.Button(u8("������� ����� ����������")) then
						reportItem = 2
					end
				end

				var_0_0.BeginChild("left pane##312", var_0_0.ImVec2(0, 0), true)

				if reportItem == 1 then
					var_0_0.Columns(5)
					var_0_0.SetColumnWidth(-1, 300)
					var_0_0.Text(u8("�����������"))
					var_0_0.SameLine()
					showHelp(u8("����������� �� ��������� �������, ��������� �������, �������� �������."))
					var_0_0.NextColumn()
					var_0_0.SetColumnWidth(-1, 120)
					var_0_0.Text(u8("���������"))
					var_0_0.SameLine()
					showHelp(u8("������� ��� ������, ������� ���� ����������� ��� ������� �� �������."))
					var_0_0.NextColumn()
					var_0_0.SetColumnWidth(-1, 80)
					var_0_0.Text(u8("�������"))
					var_0_0.SameLine()
					showHelp(u8("������� ������� ������, ������� ���� ����������� ��� ������� �� �������."))
					var_0_0.NextColumn()
					var_0_0.Text(u8("������"))
					var_0_0.SameLine()
					showHelp(u8("������� ������ ������, ������� ���� ����������� ��� ������� �� �������."))
					var_0_0.NextColumn()
					var_0_0.SetColumnWidth(-1, 80)
					var_0_0.Text(u8("�������"))
					var_0_0.SameLine()
					showHelp(u8(
					"������� �����������. ���� �� �������� � ���� ������������ � ������ �� ������� ����� ����������, �� ������� �� ����� �����, ���� �� �������, ��� ��� ������ � �� ����� ���������, �� ������� ����� ����."))
					var_0_0.NextColumn()
					var_0_0.Separator()

					if tostring(im.reports.search_3.v):len() > 0 then
						for iter_138_3, iter_138_4 in pairs(positiveReports) do
							local var_138_3 = iter_138_4.report_id
							local var_138_4 = iter_138_4.name
							local var_138_5 = iter_138_4.server_name
							local var_138_6 = iter_138_4.fraction
							local var_138_7 = iter_138_4.report_text
							local var_138_8 = iter_138_4.report_status
							local var_138_9 = iter_138_4.stars_up
							local var_138_10 = iter_138_4.stars_down
							local var_138_11 = iter_138_4.comment
							local var_138_12 = string.nlower(u8:decode(var_138_7))
							local var_138_13 = string.nlower(u8:decode(tostring(im.reports.search_3.v)))

							if var_138_12:find(var_138_13) then
								if var_138_11 ~= nil and var_138_11 ~= "" then
									var_138_7 = u8:decode(var_138_7) ..
									"\n--\n{FFFF00}����������� �� ������������:{FFFFFF}\n" .. u8:decode(var_138_11)
								else
									var_138_7 = u8:decode(var_138_7)
								end

								var_0_0.SetColumnWidth(-1, 300)
								var_0_0.PushTextWrapPos()
								var_0_0.TextColoredRGB(var_138_7)
								var_0_0.NextColumn()
								var_0_0.SetColumnWidth(-1, 120)
								var_0_0.Text(var_138_4)
								var_0_0.NextColumn()
								var_0_0.SetColumnWidth(-1, 80)
								var_0_0.Text(var_138_6)
								var_0_0.NextColumn()
								var_0_0.Text(var_138_5)
								var_0_0.NextColumn()
								var_0_0.SetColumnWidth(-1, 80)
								var_0_0.PushStyleColor(var_0_0.Col.Button, var_0_0.ImVec4(0.1, 0.5, 0.1, 1))

								if var_0_0.Button(var_0_7.ICON_THUMBS_O_UP .. " " .. var_138_9 .. "##" .. var_138_3) then
									if not changeRatingTime then
										starsUp(var_138_3)

										changeRatingTime = os.time()
									elseif os.time() - changeRatingTime > 15 then
										starsUp(var_138_3)

										changeRaingTime = os.time()
									else
										chat("���������� ����� ��� � 15 ������!")
									end
								end

								var_0_0.SameLine()
								var_0_0.PopStyleColor()
								var_0_0.PushStyleColor(var_0_0.Col.Button, var_0_0.ImVec4(0.5, 0.1, 0.1, 1))

								if var_0_0.Button(var_0_7.ICON_THUMBS_O_DOWN .. " " .. var_138_10 .. "##" .. var_138_3) then
									if not changeRatingTime then
										starsDown(var_138_3)

										changeRatingTime = os.time()
									elseif os.time() - changeRatingTime > 15 then
										starsDown(var_138_3)

										changeRaingTime = os.time()
									else
										chat("���������� ����� ��� � 15 ������!")
									end
								end

								var_0_0.PopStyleColor()
								var_0_0.NextColumn()
								var_0_0.Separator()
							end
						end
					else
						for iter_138_5, iter_138_6 in pairs(positiveReports) do
							local var_138_14 = iter_138_6.report_id
							local var_138_15 = iter_138_6.name
							local var_138_16 = iter_138_6.server_name
							local var_138_17 = iter_138_6.fraction
							local var_138_18 = iter_138_6.report_text
							local var_138_19 = iter_138_6.report_status
							local var_138_20 = iter_138_6.stars_up
							local var_138_21 = iter_138_6.stars_down
							local var_138_22 = iter_138_6.comment

							if var_138_22 ~= nil and var_138_22 ~= "" then
								var_138_18 = u8:decode(var_138_18) ..
								"\n--\n{FFFF00}����������� �� ������������:{FFFFFF}\n" .. u8:decode(var_138_22)
							else
								var_138_18 = u8:decode(var_138_18)
							end

							var_0_0.SetColumnWidth(-1, 300)
							var_0_0.PushTextWrapPos()
							var_0_0.TextColoredRGB(var_138_18)
							var_0_0.NextColumn()
							var_0_0.SetColumnWidth(-1, 120)
							var_0_0.Text(var_138_15)
							var_0_0.NextColumn()
							var_0_0.SetColumnWidth(-1, 80)
							var_0_0.Text(var_138_17)
							var_0_0.NextColumn()
							var_0_0.Text(var_138_16)
							var_0_0.NextColumn()
							var_0_0.SetColumnWidth(-1, 80)
							var_0_0.PushStyleColor(var_0_0.Col.Button, var_0_0.ImVec4(0.1, 0.5, 0.1, 1))

							if var_0_0.Button(var_0_7.ICON_THUMBS_O_UP .. " " .. var_138_20 .. "##" .. var_138_14) then
								if not changeRatingTime then
									starsUp(var_138_14)

									changeRatingTime = os.time()
								elseif os.time() - changeRatingTime > 15 then
									starsUp(var_138_14)

									changeRaingTime = os.time()
								else
									chat("���������� ����� ��� � 15 ������!")
								end
							end

							var_0_0.SameLine()
							var_0_0.PopStyleColor()
							var_0_0.PushStyleColor(var_0_0.Col.Button, var_0_0.ImVec4(0.5, 0.1, 0.1, 1))

							if var_0_0.Button(var_0_7.ICON_THUMBS_O_DOWN .. " " .. var_138_21 .. "##" .. var_138_14) then
								if not changeRatingTime then
									starsDown(var_138_14)

									changeRatingTime = os.time()
								elseif os.time() - changeRatingTime > 15 then
									starsDown(var_138_14)
								else
									chat("���������� ����� ��� � 15 ������!")
								end
							end

							var_0_0.PopStyleColor()
							var_0_0.NextColumn()
							var_0_0.Separator()
						end
					end

					var_0_0.Columns(1)
				end

				if reportItem == 2 then
					var_0_0.Columns(5)
					var_0_0.SetColumnWidth(-1, 300)
					var_0_0.Text(u8("������"))
					var_0_0.SameLine()
					showHelp(u8("��������������� ������� ��������� ������."))
					var_0_0.NextColumn()
					var_0_0.SetColumnWidth(-1, 120)
					var_0_0.Text(u8("�������"))
					var_0_0.SameLine()
					showHelp(u8("������� ������� ������, ������� ���� ����������� ��� ������� �� �������."))
					var_0_0.NextColumn()
					var_0_0.SetColumnWidth(-1, 80)
					var_0_0.Text(u8("�������"))
					var_0_0.SameLine()
					showHelp(u8("������� ������� ������, ������� ���� ����������� ��� ������� �� �������."))
					var_0_0.NextColumn()
					var_0_0.Text(u8("������"))
					var_0_0.SameLine()
					showHelp(u8("������� ������ ������, ������� ���� ����������� ��� ������� �� �������."))
					var_0_0.NextColumn()
					var_0_0.SetColumnWidth(-1, 80)
					var_0_0.Text(u8("�������"))
					var_0_0.SameLine()
					showHelp(u8(
					"������� ������. ���� �� ���������� ����� ������ ����, �� ������� ����� �����, ���� �� ����� ������ ��� � ����� ��-�� ���������������� �� ������ ������ ������, �� ������� ����� ����."))
					var_0_0.NextColumn()
					var_0_0.Separator()

					if tostring(im.reports.search_4.v):len() > 0 then
						for iter_138_7, iter_138_8 in pairs(negativeReports) do
							local var_138_23 = iter_138_8.report_id
							local var_138_24 = iter_138_8.name
							local var_138_25 = iter_138_8.server_name
							local var_138_26 = iter_138_8.fraction
							local var_138_27 = iter_138_8.report_text
							local var_138_28 = iter_138_8.report_status
							local var_138_29 = iter_138_8.stars_up
							local var_138_30 = iter_138_8.stars_down
							local var_138_31 = iter_138_8.comment
							local var_138_32 = string.nlower(u8:decode(var_138_27))
							local var_138_33 = string.nlower(u8:decode(tostring(im.reports.search_4.v)))

							if var_138_32:find(var_138_33) then
								if var_138_31 ~= nil and var_138_31 ~= "" then
									var_138_27 = u8:decode(var_138_27) ..
									"\n--\n{FFFF00}����������� �� ������������:{FFFFFF}\n" .. u8:decode(var_138_31)
								else
									var_138_27 = u8:decode(var_138_27)
								end

								var_0_0.SetColumnWidth(-1, 300)
								var_0_0.PushTextWrapPos()
								var_0_0.TextColoredRGB(var_138_27)
								var_0_0.NextColumn()
								var_0_0.SetColumnWidth(-1, 120)
								var_0_0.Text(var_138_24)
								var_0_0.NextColumn()
								var_0_0.SetColumnWidth(-1, 80)
								var_0_0.Text(var_138_26)
								var_0_0.NextColumn()
								var_0_0.Text(var_138_25)
								var_0_0.NextColumn()
								var_0_0.SetColumnWidth(-1, 80)
								var_0_0.PushStyleColor(var_0_0.Col.Button, var_0_0.ImVec4(0.1, 0.5, 0.1, 1))

								if var_0_0.Button(var_0_7.ICON_THUMBS_O_UP .. " " .. var_138_29 .. "##neg" .. var_138_23) then
									if not changeRatingTime then
										starsUp(var_138_23)

										changeRatingTime = os.time()
									elseif os.time() - changeRatingTime > 15 then
										starsUp(var_138_23)

										changeRaingTime = os.time()
									else
										chat("���������� ����� ��� � 15 ������!")
									end
								end

								var_0_0.SameLine()
								var_0_0.PopStyleColor()
								var_0_0.PushStyleColor(var_0_0.Col.Button, var_0_0.ImVec4(0.5, 0.1, 0.1, 1))

								if var_0_0.Button(var_0_7.ICON_THUMBS_O_DOWN .. " " .. var_138_30 .. "##neg" .. var_138_23) then
									if not changeRatingTime then
										starsDown(var_138_23)

										changeRatingTime = os.time()
									elseif os.time() - changeRatingTime > 15 then
										starsDown(var_138_23)
									else
										chat("���������� ����� ��� � 15 ������!")
									end
								end

								var_0_0.PopStyleColor()
								var_0_0.NextColumn()
								var_0_0.Separator()
							end
						end
					else
						for iter_138_9, iter_138_10 in pairs(negativeReports) do
							local var_138_34 = iter_138_10.report_id
							local var_138_35 = iter_138_10.name
							local var_138_36 = iter_138_10.server_name
							local var_138_37 = iter_138_10.fraction
							local var_138_38 = iter_138_10.report_text
							local var_138_39 = iter_138_10.report_status
							local var_138_40 = iter_138_10.stars_up
							local var_138_41 = iter_138_10.stars_down
							local var_138_42 = iter_138_10.comment

							if var_138_42 ~= nil and var_138_42 ~= "" then
								var_138_38 = u8:decode(var_138_38) ..
								"\n--\n{FFFF00}����������� �� ������������:{FFFFFF}\n" .. u8:decode(var_138_42)
							else
								var_138_38 = u8:decode(var_138_38)
							end

							var_0_0.SetColumnWidth(-1, 300)
							var_0_0.PushTextWrapPos()
							var_0_0.TextColoredRGB(var_138_38)
							var_0_0.NextColumn()
							var_0_0.SetColumnWidth(-1, 120)
							var_0_0.Text(var_138_35)
							var_0_0.NextColumn()
							var_0_0.SetColumnWidth(-1, 80)
							var_0_0.Text(var_138_37)
							var_0_0.NextColumn()
							var_0_0.Text(var_138_36)
							var_0_0.NextColumn()
							var_0_0.SetColumnWidth(-1, 80)
							var_0_0.PushStyleColor(var_0_0.Col.Button, var_0_0.ImVec4(0.1, 0.5, 0.1, 1))

							if var_0_0.Button(var_0_7.ICON_THUMBS_O_UP .. " " .. var_138_40 .. "##neg" .. var_138_34) then
								if not changeRatingTime then
									starsUp(var_138_34)

									changeRatingTime = os.time()
								elseif os.time() - changeRatingTime > 15 then
									starsUp(var_138_34)

									changeRaingTime = os.time()
								else
									chat("���������� ����� ��� � 15 ������!")
								end
							end

							var_0_0.SameLine()
							var_0_0.PopStyleColor()
							var_0_0.PushStyleColor(var_0_0.Col.Button, var_0_0.ImVec4(0.5, 0.1, 0.1, 1))

							if var_0_0.Button(var_0_7.ICON_THUMBS_O_DOWN .. " " .. var_138_41 .. "##neg" .. var_138_34) then
								if not changeRatingTime then
									starsDown(var_138_34)

									changeRatingTime = os.time()
								elseif os.time() - changeRatingTime > 15 then
									starsDown(var_138_34)
								else
									chat("���������� ����� ��� � 15 ������!")
								end
							end

							var_0_0.PopStyleColor()
							var_0_0.NextColumn()
							var_0_0.Separator()
						end
					end

					var_0_0.Columns(1)
				end

				if reportItem == 3 then
					var_0_0.InputTextMultiline(u8("���� ���� �� ���������"), im.reports.report_text_3)

					if var_0_0.Button(u8("������ �����������"), var_138_2) then
						if not frac then
							am("���� ������� �� ��������, ���������� �������.")
						elseif tostring(im.reports.report_text_3.v):len() > 70 then
							im.reports.report_text_3.v = im.reports.report_text_3.v:gsub("{%S%S%S%S%S%S}", "")

							setIdea(im.reports.report_text_3.v)
						else
							am("����� ������� ��������!")
						end
					end
				end

				if reportItem == 4 then
					var_0_0.InputTextMultiline(u8("���� ���������� ������"), im.reports.report_text_4)

					if var_0_0.Button(u8("�������� �� ������"), var_138_2) then
						if not frac then
							am("���� ������� �� ��������, ���������� �������.")
						elseif tostring(im.reports.report_text_4.v):len() > 70 then
							im.reports.report_text_4.v = im.reports.report_text_4.v:gsub("{%S%S%S%S%S%S}", "")

							setError(im.reports.report_text_4.v)
						else
							am("����� ������� ��������!")
						end
					end
				end

				var_0_0.EndChild()
			elseif selected == 7 then
				selectedIm7()
			elseif selected == 8 then
				var_0_0.Separator()
				var_0_0.Image(var_0_15.settings_bindcommands, var_0_0.ImVec2(715, 80))
				var_0_0.Separator()
				var_0_0.BeginChild("left pane##bind", var_0_0.ImVec2(200, 0), true)

				for iter_138_11 = 1, #SeleListCommands do
					if var_0_0.Selectable(u8("/" .. SeleListCommands[iter_138_11]), SeleListCommandsBool[iter_138_11]) then
						selectedCommands = iter_138_11
					end

					var_0_0.Separator()
				end

				if var_0_0.Button(u8("�������� �������"), var_138_2) then
					if _G.aln[alnkey] then
						addCC = true
						var_0_55.v, var_0_56.v, var_0_57.v, var_0_58.v = "", "", "", false
					else
						am("������ ������� �������� ������ �� ������� ������ ����.")
					end
				end

				var_0_0.AlignTextToFramePadding()

				if var_0_0.Button(u8("�������"), var_0_0.ImVec2(89, 20)) then
					if not selectedCommands or not SeleListCommands[selectedCommands] or not BindCommand[SeleListCommands[selectedCommands]].v then
						am("�������� ���� ��� ��������.")
					else
						local var_138_43 = {
							name = BindCommand[SeleListCommands[selectedCommands]].v,
							text = BindText[SeleListCommands[selectedCommands]].v,
							latency = BindWait[SeleListCommands[selectedCommands]].v,
							param = BindParamID[SeleListCommands[selectedCommands]].v
						}
						local var_138_44 = io.open("moonloader/PD-Project/export/" .. var_138_43.name .. "_cc.karimoff",
							"w+")

						if var_138_44 then
							var_138_44:write(encodeJson(var_138_43))
							var_138_44:close()
							am("������ �������������� � ����� �������� (����� PD-Project/export). ������������ �����: " ..
							var_138_43.name .. "_cc.")
						else
							am(
							"�� ������� �������������� ������. ��������� ������� ��� ��������� � ����������� ����������.")
						end
					end
				end

				var_0_0.SameLine()

				if var_0_0.Button(u8("������"), var_0_0.ImVec2(90, 20)) then
					local var_138_45, var_138_46 = import_files("cc")

					if var_138_45 then
						local var_138_47 = var_138_46:gsub("_cc.karimoff", "")

						chat("������������� ������: " ..
						(var_138_46:find("_tc%.karimoff") and "���-��� " or var_138_46:find("_cc%.karimoff") and "������� " or var_138_46:find("_kk%.karimoff") and "������� " or "") ..
						var_138_47)

						local var_138_48 = io.open("moonloader/PD-Project/import/" .. var_138_46, "r")

						if var_138_48 then
							local var_138_49 = var_138_48:read("*a")
							local var_138_50 = decodeJson(var_138_49)

							if var_138_50 then
								if var_138_50.name ~= nil and var_138_50.text ~= nil and var_138_50.latency ~= nil and var_138_50.param ~= nil then
									if not isCommandExist(var_138_50.name) then
										ccData[u8:decode(trim(var_138_50.name)):gsub("/", "")] = {
											text = u8:decode(var_138_50.text):gsub("&", " "),
											wait = tonumber(var_138_50.latency),
											param_id = var_138_50.param,
											mode = sha1(sampGetPlayerNickname(select(2,
												sampGetPlayerIdByCharHandle(playerPed))))
										}

										saveCc()
										registerCC()
										seleGet()
									else
										am("��������� ������� ��� ����������������. ������� ������.")
									end

									local var_138_51 = io.open("moonloader/PD-Project/import/imported/" .. var_138_46,
										"w+")

									if var_138_51 then
										var_138_51:write(var_138_49)
										var_138_51:close()
										var_138_48:close()
										os.remove("moonloader/PD-Project/import/" .. var_138_46)
									else
										am("�������� �� ���������. ���� � ��������� \"" ..
										var_138_46 .. "\" ����������� � ����� moonloader/PD-Project/import/imported.")
									end
								else
									am("�������� ����������� �������������� �����.")
								end
							else
								am("�������� ����������� �������������� �����, ��������� �������.")
							end
						else
							am("�� ������� ������������� ������.")
						end
					else
						am("������ ��� ������� �� ����������.")
					end
				end

				var_0_0.EndChild()
				var_0_0.SameLine()
				var_0_0.BeginChild("left pane##bindwindow", var_0_0.ImVec2(0, 0), true)

				if SeleListCommands[selectedCommands] and not addCC then
					if BindCommand[SeleListCommands[selectedCommands]].v then
						var_0_0.InputText(u8("�������"), BindCommand[SeleListCommands[selectedCommands]])
					end

					if BindText[SeleListCommands[selectedCommands]].v then
						var_0_0.InputTextMultiline(u8("�����"), BindText[SeleListCommands[selectedCommands]])
					end

					if BindWait[SeleListCommands[selectedCommands]].v then
						var_0_0.InputText(u8("�������� (��� * 1000)"), BindWait[SeleListCommands[selectedCommands]])
					end

					if BindParamID[SeleListCommands[selectedCommands]].v then
						var_0_0.CheckBox(u8(" �������� �������� ID"), BindParamID[SeleListCommands[selectedCommands]])
					end

					if var_0_0.Button(u8("��������� ���������"), var_138_2) then
						if _G.aln[alnkey] then
							if BindCommand[SeleListCommands[selectedCommands]].v:len() > 0 and BindText[SeleListCommands[selectedCommands]].v:len() > 0 and BindWait[SeleListCommands[selectedCommands]].v:len() > 0 then
								ccData[SeleListCommands[selectedCommands]:gsub("/", "")] = {
									text = u8:decode(BindText[SeleListCommands[selectedCommands]].v):gsub("&", " "),
									wait = tonumber(BindWait[SeleListCommands[selectedCommands]].v),
									param_id = BindParamID[SeleListCommands[selectedCommands]].v,
									mode = sha1(sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))))
								}

								saveCc()
								registerCC()
							else
								am("���������, ��� ��� ���� ���������.")
							end
						else
							am("������ ������� �������� ������ �� ������� ������ ����.")
						end
					end

					if var_0_0.Button(u8("������� �������"), var_138_2) then
						if _G.aln[alnkey] then
							for iter_138_12, iter_138_13 in pairs(ccData) do
								if iter_138_12 == SeleListCommands[selectedCommands] then
									ccData[iter_138_12] = nil
								end
							end

							saveCc()
							registerCC()
							am("������� �������.")

							selectedCommands = 1
						else
							am("������ ������� �������� ������ �� ������� ������ ����.")
						end
					end

					var_0_0.BeginChild("left pane##bindtags", var_0_0.ImVec2(0, 0), true)
					var_0_0.Text(u8("������� �� ���, ����� ����������� ���. ���������� � ���� � (INFO)."))
					var_0_0.Separator()

					for iter_138_14, iter_138_15 in pairs(commands) do
						showCommand(commandsText[iter_138_15])
						var_0_0.SameLine()

						if var_0_0.Button(iter_138_15, var_138_2) then
							setClipboardText(iter_138_15)
						end
					end

					var_0_0.EndChild()
				end

				if addCC == true then
					var_0_0.InputText(u8("������� �������"), var_0_55)
					var_0_0.SameLine()
					showHelp(u8("������� ������� ��� '/'. ������� ������� ������ �� ���������� ��������� ����������."))
					var_0_0.InputTextMultiline(u8("������� �����"), var_0_56)
					var_0_0.SameLine()
					showHelp(u8(
					"������� �����, ������� ����� ������������ ��� ����� �������. ������ ������� � ����� ������."))
					var_0_0.InputText(u8("�������� (��� * 1000)"), var_0_57)
					var_0_0.SameLine()
					showHelp(u8(
					"������� ��������, ������� ����� ����������� ����� ������������� � ��� ������. 1 ��� = 1000."))
					var_0_0.CheckBox(u8(" �������� �������� ID"), var_0_58)
					var_0_0.SameLine()
					showHelp(u8(
					"�������� ID ������������ ��� �������, ����� ���������� ����������������� � ������� ��������. �������� ��� ����� �������, ������� ���������� � ��� ��� ������� ������. ������������ /getname � �������� �������� ID. ������ � ��� /getname ID � � ��� ���������� ��� ���������� ID'a."))

					if var_0_0.Button(u8("��������"), var_138_2) then
						if _G.aln[alnkey] then
							if var_0_55.v:len() > 0 and var_0_56.v:len() > 0 and var_0_57.v:len() > 0 then
								if var_0_55.v == "pd" or var_0_55.v == "Pd" or var_0_55.v == "PD" or var_0_55.v == "pD" then
									am("������ ������� ��������� � �������������.")
								elseif not isCommandExist(var_0_55.v) then
									ccData[u8:decode(trim(var_0_55.v)):gsub("/", "")] = {
										text = u8:decode(var_0_56.v):gsub("&", " "),
										wait = tonumber(var_0_57.v),
										param_id = var_0_58.v,
										mode = sha1(sampGetPlayerNickname(select(2,
											sampGetPlayerIdByCharHandle(playerPed))))
									}

									saveCc()
									registerCC()
									seleGet()

									addCC = false
								else
									am("��������� ������� ��� ����������������. ������� ������.")
								end
							else
								am("���������, ��� ��� ���� ���������.")
							end
						else
							am("������ ������� �������� ������ �� ������� ������ ����.")
						end
					end

					if var_0_0.Button(u8("������� ���� ���������� �������"), var_138_2) then
						addCC = false
					end

					var_0_0.BeginChild("left pane##bindtags", var_0_0.ImVec2(0, 0), true)
					var_0_0.Text(u8("������� �� ���, ����� ����������� ���. ���������� � ���� � (INFO)."))
					var_0_0.Separator()

					for iter_138_16, iter_138_17 in pairs(commands) do
						showCommand(commandsText[iter_138_17])
						var_0_0.SameLine()

						if var_0_0.Button(iter_138_17, var_138_2) and _G.aln[alnkey] then
							setClipboardText(iter_138_17)
						end
					end

					var_0_0.EndChild()
				end

				var_0_0.EndChild()
			elseif selected == 9 then
				var_0_0.Separator()
				var_0_0.Image(var_0_15.settings_bindkeys, var_0_0.ImVec2(715, 80))
				var_0_0.Separator()
				var_0_0.BeginChild("left pane##bindhotkey", var_0_0.ImVec2(200, 0), true)

				for iter_138_18 = 1, #SeleListKeys do
					if var_0_0.Selectable(u8(SeleListKeys[iter_138_18]), SeleListKeysBool[iter_138_18]) then
						selectedKeys = iter_138_18
					end

					var_0_0.Separator()
				end

				if var_0_0.Button(u8("�������� �������"), var_138_2) then
					if _G.aln[alnkey] then
						addKK = true
						var_0_63.v, var_0_64.v, var_0_65.v, var_0_66.v = "", "", "", false
					else
						am("������ ������� �������� ������ �� ������� ������ ����.")
					end
				end

				var_0_0.AlignTextToFramePadding()

				if var_0_0.Button(u8("�������"), var_0_0.ImVec2(89, 20)) then
					if not selectedKeys or not SeleListKeys[selectedKeys] or not hkBindKK[SeleListKeys[selectedKeys]].v then
						am("�������� ���� ��� ��������.")
					else
						local var_138_52 = {
							name = hkBindKK[SeleListKeys[selectedKeys]].v,
							text = hkBindTT[SeleListKeys[selectedKeys]].v,
							latency = hkBindWW[SeleListKeys[selectedKeys]].v,
							param = hkBindPP[SeleListKeys[selectedKeys]].v
						}
						local var_138_53 = io.open("moonloader/PD-Project/export/" .. var_138_52.name .. "_kk.karimoff",
							"w+")

						if var_138_53 then
							var_138_53:write(encodeJson(var_138_52))
							var_138_53:close()
							am("������ �������������� � ����� �������� (����� PD-Project/export). ������������ �����: " ..
							var_138_52.name .. "_kk.")
						else
							am(
							"�� ������� �������������� ������. ��������� ������� ��� ��������� � ����������� ����������.")
						end
					end
				end

				var_0_0.SameLine()

				if var_0_0.Button(u8("������"), var_0_0.ImVec2(90, 20)) then
					local var_138_54, var_138_55 = import_files("kk")

					if var_138_54 then
						local var_138_56 = var_138_55:gsub("_kk.karimoff", "")

						chat("������������� ������: " ..
						(var_138_55:find("_tc%.karimoff") and "���-��� " or var_138_55:find("_cc%.karimoff") and "������� " or var_138_55:find("_kk%.karimoff") and "������� " or "") ..
						var_138_56)

						local var_138_57 = io.open("moonloader/PD-Project/import/" .. var_138_55, "r")

						if var_138_57 then
							local var_138_58 = var_138_57:read("*a")
							local var_138_59 = decodeJson(var_138_58)

							if var_138_59 then
								if var_138_59.name ~= nil and var_138_59.text ~= nil and var_138_59.latency ~= nil and var_138_59.param ~= nil then
									if not isKeyExist(var_138_59.name) then
										local var_138_60 = var_138_59.name

										HotKeysData[var_138_60] = {
											text = u8:decode(var_138_59.text):gsub("&", " "),
											wait = tonumber(var_138_59.latency),
											param_id = var_138_59.param,
											mode = sha1(sampGetPlayerNickname(select(2,
												sampGetPlayerIdByCharHandle(playerPed))))
										}

										saveKk()
										registerKK()
									else
										am("��������� ������� ��� ����������������. ������� ������.")
									end

									local var_138_61 = io.open("moonloader/PD-Project/import/imported/" .. var_138_55,
										"w+")

									if var_138_61 then
										var_138_61:write(var_138_58)
										var_138_61:close()
										var_138_57:close()
										os.remove("moonloader/PD-Project/import/" .. var_138_55)
									else
										am("�������� �� ���������. ���� � ��������� \"" ..
										var_138_55 .. "\" ����������� � ����� moonloader/PD-Project/import/imported.")
									end
								else
									am("�������� ����������� �������������� �����.")
								end
							else
								am("�������� ����������� �������������� �����, ��������� �������.")
							end
						else
							am("�� ������� ������������� ������.")
						end
					else
						am("������ ��� ������� �� ����������.")
					end
				end

				var_0_0.EndChild()
				var_0_0.SameLine()
				var_0_0.BeginChild("left pane##bindkeywindow", var_0_0.ImVec2(0, 0), true)

				if SeleListKeys[selectedKeys] and not addKK then
					if hkBindKK[SeleListKeys[selectedKeys]].v then
						var_0_0.InputText(u8("�������"), hkBindKK[SeleListKeys[selectedKeys]])
					end

					if hkBindTT[SeleListKeys[selectedKeys]].v then
						var_0_0.InputTextMultiline(u8("�����"), hkBindTT[SeleListKeys[selectedKeys]])
					end

					if hkBindWW[SeleListKeys[selectedKeys]].v then
						var_0_0.InputText(u8("�������� (��� * 1000)"), hkBindWW[SeleListKeys[selectedKeys]])
					end

					if hkBindPP[SeleListKeys[selectedKeys]].v then
						var_0_0.CheckBox(u8(" �������� �������� ID"), hkBindPP[SeleListKeys[selectedKeys]])
					end

					if var_0_0.Button(u8("��������� ���������"), var_138_2) then
						if _G.aln[alnkey] then
							if hkBindKK[SeleListKeys[selectedKeys]].v:len() > 0 and hkBindTT[SeleListKeys[selectedKeys]].v:len() > 0 and hkBindWW[SeleListKeys[selectedKeys]].v:len() > 0 then
								local var_138_62 = SeleListKeys[selectedKeys]:gsub("+", "{plus}")

								HotKeysData[var_138_62] = {
									text = u8:decode(hkBindTT[SeleListKeys[selectedKeys]].v):gsub("&", " "),
									wait = tonumber(hkBindWW[SeleListKeys[selectedKeys]].v),
									param_id = hkBindPP[SeleListKeys[selectedKeys]].v,
									mode = sha1(sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))))
								}

								saveKk()
								registerKK()
								am("��������� ���������.")
							else
								am("���������, ��� ��� ���� ���������.")
							end
						else
							am("������ ������� �������� ������ �� ������� ������ ����.")
						end
					end

					if var_0_0.Button(u8("������� �������"), var_138_2) then
						if _G.aln[alnkey] then
							for iter_138_19, iter_138_20 in pairs(HotKeysData) do
								if iter_138_19:gsub("{plus}", "+") == SeleListKeys[selectedKeys] then
									HotKeysData[iter_138_19] = nil
								end
							end

							saveKk()
							registerKK()
							am("������� �������.")

							selectedKeys = 1
						else
							am("������ ������� �������� ������ �� ������� ������ ����.")
						end
					end

					var_0_0.BeginChild("left pane##bindtags", var_0_0.ImVec2(0, 0), true)
					var_0_0.Text(u8("������� �� ���, ����� ����������� ���. ���������� � ���� � (INFO)."))
					var_0_0.Separator()

					for iter_138_21, iter_138_22 in pairs(commands) do
						showCommand(commandsText[iter_138_22])
						var_0_0.SameLine()

						if var_0_0.Button(iter_138_22, var_138_2) then
							setClipboardText(iter_138_22)
						end
					end

					var_0_0.EndChild()
				end

				if addKK == true then
					var_0_0.InputText(u8("������� �������"), var_0_63)
					var_0_0.SameLine()
					showHelp(u8(
					"������� �������, ������� ������ ���������. ������� ����� ��������� ������� � ���������. ������� ���� ������� � ������� 'Alt+P' ��� 'Ctrl+A', � ��������� � ����� �����: 'K', 'F2'. ���������� ������ ������ ��������� � ����� ���� �� ������� �������� ����������."))
					var_0_0.InputTextMultiline(u8("������� �����"), var_0_64)
					var_0_0.SameLine()
					showHelp(u8(
					"������� �����, ������� ����� ������������ ����� ������� ������������� ������. ������ ������� � ����� ������!"))
					var_0_0.InputText(u8("�������� (��� * 1000)"), var_0_65)
					var_0_0.SameLine()
					showHelp(u8("������� ��������, ������� ����� ����������� ����� ������������ � ��� ������."))
					var_0_0.CheckBox(u8(" �������� �������� ID"), var_0_66)
					var_0_0.SameLine()
					showHelp(u8(
					"���� �� �������� �������� ID, �� ������� ����� �������� ������ ��� ������ ���� (���+J). � ���� �������� ���������, ���� �� ����������� ������ � �������������� ������ ������� ������."))

					if var_0_0.Button(u8("��������"), var_138_2) then
						if _G.aln[alnkey] then
							if var_0_63.v:len() > 0 and var_0_64.v:len() > 0 and var_0_65.v:len() > 0 then
								if not isKeyExist(var_0_63.v) then
									local var_138_63 = u8:decode(var_0_63.v)

									HotKeysData[var_138_63] = {
										text = u8:decode(var_0_64.v):gsub("&", " "),
										wait = tonumber(var_0_65.v),
										param_id = var_0_66.v,
										mode = sha1(sampGetPlayerNickname(select(2,
											sampGetPlayerIdByCharHandle(playerPed))))
									}

									saveKk()
									registerKK()
									seleHGet()

									addKK = false
								else
									am("��������� ������� (���������) ��� ����������������. ������� ������.")
								end
							else
								am("���������, ��� ��� ���� ���������.")
							end
						else
							am("������ ������� �������� ������ �� ������� ������ ����.")
						end
					end

					if var_0_0.Button(u8("������� ���� ���������� �������"), var_138_2) then
						addKK = false
					end

					var_0_0.BeginChild("left pane##bindtags", var_0_0.ImVec2(0, 0), true)
					var_0_0.Text(u8("������� �� ���, ����� ����������� ���. ���������� � ���� � (INFO)."))
					var_0_0.Separator()

					for iter_138_23, iter_138_24 in pairs(commands) do
						showCommand(commandsText[iter_138_24])
						var_0_0.SameLine()

						if var_0_0.Button(iter_138_24, var_138_2) then
							setClipboardText(iter_138_24)
						end
					end

					var_0_0.EndChild()
				end

				var_0_0.EndChild()
			elseif selected == 10 then
				var_0_0.Separator()
				var_0_0.Image(var_0_15.settings_bindcheatcodes, var_0_0.ImVec2(715, 80))
				var_0_0.Separator()
				var_0_0.BeginChild("left pane##bindtc", var_0_0.ImVec2(200, 0), true)

				for iter_138_25 = 1, #SeleListCheats do
					if var_0_0.Selectable(u8(SeleListCheats[iter_138_25]), SeleListCheatsBool[iter_138_25]) then
						selectedCheats = iter_138_25
					end

					var_0_0.Separator()
				end

				if var_0_0.Button(u8("�������� ���-���"), var_138_2) then
					if _G.aln[alnkey] then
						addTC = true
						var_0_67.AddTC.v, var_0_67.AddTT.v, var_0_67.AddWW.v, var_0_67.AddPP.v = "", "", "", false
					else
						am("������ ������� �������� ������ �� ������� ������ ����.")
					end
				end

				var_0_0.AlignTextToFramePadding()

				if var_0_0.Button(u8("�������"), var_0_0.ImVec2(89, 20)) then
					if not selectedCheats or not SeleListCheats[selectedCheats] or not var_0_69[SeleListCheats[selectedCheats]].v then
						am("�������� ���� ��� ��������.")
					else
						local var_138_64 = {
							name = var_0_69[SeleListCheats[selectedCheats]].v,
							text = var_0_70[SeleListCheats[selectedCheats]].v,
							latency = var_0_71[SeleListCheats[selectedCheats]].v,
							param = var_0_72[SeleListCheats[selectedCheats]].v
						}
						local var_138_65 = io.open("moonloader/PD-Project/export/" .. var_138_64.name .. "_tc.karimoff",
							"w+")

						if var_138_65 then
							var_138_65:write(encodeJson(var_138_64))
							var_138_65:close()
							am("������ �������������� � ����� �������� (����� PD-Project/export). ������������ �����: " ..
							var_138_64.name .. "_tc.")
						else
							am(
							"�� ������� �������������� ������. ��������� ������� ��� ��������� � ����������� ����������.")
						end
					end
				end

				var_0_0.SameLine()

				if var_0_0.Button(u8("������"), var_0_0.ImVec2(90, 20)) then
					local var_138_66, var_138_67 = import_files("tc")

					if var_138_66 then
						local var_138_68 = var_138_67:gsub("_tc.karimoff", "")

						chat("������������� ������: " ..
						(var_138_67:find("_tc%.karimoff") and "���-��� " or var_138_67:find("_cc%.karimoff") and "������� " or var_138_67:find("_kk%.karimoff") and "������� " or "") ..
						var_138_68)

						local var_138_69 = io.open("moonloader/PD-Project/import/" .. var_138_67, "r")

						if var_138_69 then
							local var_138_70 = var_138_69:read("*a")
							local var_138_71 = decodeJson(var_138_70)

							if var_138_71 then
								if var_138_71.name ~= nil and var_138_71.text ~= nil and var_138_71.latency ~= nil and var_138_71.param ~= nil then
									if not isCheatExist(var_138_71.name) then
										tcData[u8:decode(var_138_71.name)] = {
											text = u8:decode(var_138_71.text):gsub("&", " "),
											wait = tonumber(var_138_71.latency),
											param_id = var_138_71.param,
											mode = sha1(sampGetPlayerNickname(select(2,
												sampGetPlayerIdByCharHandle(playerPed))))
										}

										saveTc()
										registerTC()
									else
										am("��������� ���-��� ��� ���������������. ������� ������.")
									end

									local var_138_72 = io.open("moonloader/PD-Project/import/imported/" .. var_138_67,
										"w+")

									if var_138_72 then
										var_138_72:write(var_138_70)
										var_138_72:close()
										var_138_69:close()
										os.remove("moonloader/PD-Project/import/" .. var_138_67)
									else
										am("�������� �� ���������. ���� � ��������� \"" ..
										var_138_67 .. "\" ����������� � ����� moonloader/PD-Project/import/imported.")
									end
								else
									am("�������� ����������� �������������� �����.")
								end
							else
								am("�������� ����������� �������������� �����, ��������� �������.")
							end
						else
							am("�� ������� ������������� ������.")
						end
					else
						am("������ ��� ������� �� ����������.")
					end
				end

				var_0_0.EndChild()
				var_0_0.SameLine()
				var_0_0.BeginChild("left pane##bindtcwindow", var_0_0.ImVec2(0, 0), true)

				if SeleListCheats[selectedCheats] and not addTC then
					if var_0_69[SeleListCheats[selectedCheats]].v then
						var_0_0.InputText(u8("���-���"), var_0_69[SeleListCheats[selectedCheats]])
					end

					if var_0_70[SeleListCheats[selectedCheats]].v then
						var_0_0.InputTextMultiline(u8("�����"), var_0_70[SeleListCheats[selectedCheats]])
					end

					if var_0_71[SeleListCheats[selectedCheats]].v then
						var_0_0.InputText(u8("�������� (��� * 1000)"), var_0_71[SeleListCheats[selectedCheats]])
					end

					if var_0_72[SeleListCheats[selectedCheats]].v then
						var_0_0.CheckBox(u8(" �������� �������� ID"), var_0_72[SeleListCheats[selectedCheats]])
					end

					if var_0_0.Button(u8("��������� ���������"), var_138_2) then
						if _G.aln[alnkey] then
							if var_0_69[SeleListCheats[selectedCheats]].v:len() > 0 and var_0_70[SeleListCheats[selectedCheats]].v:len() > 0 and var_0_71[SeleListCheats[selectedCheats]].v:len() > 0 then
								tcData[SeleListCheats[selectedCheats]] = {
									text = u8:decode(var_0_70[SeleListCheats[selectedCheats]].v):gsub("&", " "),
									wait = tonumber(var_0_71[SeleListCheats[selectedCheats]].v),
									param_id = var_0_72[SeleListCheats[selectedCheats]].v,
									mode = sha1(sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))))
								}

								saveTc()
								registerTC()
								am("��������� ���������.")
							else
								am("���������, ��� ��� ���� ���������.")
							end
						else
							am("������ ������� �������� ������ �� ������� ������ ����.")
						end
					end

					if var_0_0.Button(u8("������� ���-���"), var_138_2) then
						if _G.aln[alnkey] then
							for iter_138_26, iter_138_27 in pairs(tcData) do
								if iter_138_26 == SeleListCheats[selectedCheats] then
									tcData[iter_138_26] = nil
								end
							end

							saveTc()
							registerTC()
							am("���-��� ������.")

							selectedCheats = 1
						else
							am("������ ������� �������� ������ �� ������� ������ ����.")
						end
					end

					var_0_0.BeginChild("left pane##bindtags", var_0_0.ImVec2(0, 0), true)
					var_0_0.Text(u8("������� �� ���, ����� ����������� ���. ���������� � ���� � (INFO)."))
					var_0_0.Separator()

					for iter_138_28, iter_138_29 in pairs(commands) do
						showCommand(commandsText[iter_138_29])
						var_0_0.SameLine()

						if var_0_0.Button(iter_138_29, var_138_2) then
							setClipboardText(iter_138_29)
						end
					end

					var_0_0.EndChild()
				end

				if addTC == true then
					var_0_0.InputText(u8("������� ���-���"), var_0_67.AddTC)
					var_0_0.SameLine()
					showHelp(u8(
					"������� ���-���, ������� ������ ���������. � ������� ���-��� 'HESOYAM' ��� 'AEZAKMI' ;)"))

					var_0_67.AddTC.v = string.upper(var_0_67.AddTC.v)

					var_0_0.InputTextMultiline(u8("������� �����"), var_0_67.AddTT)
					var_0_0.SameLine()
					showHelp(u8(
					"������� �����, ������� ����� ������������ ����� �������� ���-����. ������ ������� � ����� ������!"))
					var_0_0.InputText(u8("�������� (��� * 1000)"), var_0_67.AddWW)
					var_0_0.SameLine()
					showHelp(u8("������� ��������, ������� ����� ����������� ����� ������������ � ��� ������."))
					var_0_0.CheckBox(u8(" �������� �������� ID"), var_0_67.AddPP)
					var_0_0.SameLine()
					showHelp(u8(
					"���� �� �������� �������� ID, �� ������� ����� �������� ������ ��� ������ ���� (���+J). � ���� �������� ���������, ���� �� ����������� ������ � �������������� ������ ������� ������."))

					if var_0_0.Button(u8("��������"), var_138_2) then
						if _G.aln[alnkey] then
							if var_0_67.AddTC.v:len() > 0 and var_0_67.AddTT.v:len() > 0 and var_0_67.AddWW.v:len() > 0 then
								if not isCheatExist(var_0_67.AddTC.v) then
									tcData[u8:decode(var_0_67.AddTC.v)] = {
										text = u8:decode(var_0_67.AddTT.v):gsub("&", " "),
										wait = tonumber(var_0_67.AddWW.v),
										param_id = var_0_67.AddPP.v,
										mode = sha1(sampGetPlayerNickname(select(2,
											sampGetPlayerIdByCharHandle(playerPed))))
									}

									saveTc()
									registerTC()

									addTC = false
								else
									am("��������� ���-��� ��� ���������������. ������� ������.")
								end
							else
								am("���������, ��� ��� ���� ���������.")
							end
						else
							am("������ ������� �������� ������ �� ������� ������ ����.")
						end
					end

					if var_0_0.Button(u8("������� ���� ���������� �������"), var_138_2) then
						addTC = false
					end

					var_0_0.BeginChild("left pane##bindtags", var_0_0.ImVec2(0, 0), true)
					var_0_0.Text(u8("������� �� ���, ����� ����������� ���. ���������� � ���� � (INFO)."))
					var_0_0.Separator()

					for iter_138_30, iter_138_31 in pairs(commands) do
						showCommand(commandsText[iter_138_31])
						var_0_0.SameLine()

						if var_0_0.Button(iter_138_31, var_138_2) then
							setClipboardText(iter_138_31)
						end
					end

					var_0_0.EndChild()
				end

				var_0_0.EndChild()
			elseif selected == 11 then
				var_0_0.Separator()
				var_0_0.Image(var_0_15.settings_changemessages, var_0_0.ImVec2(715, 80))
				var_0_0.Separator()
				var_0_0.BeginChild("left pane###pain", var_0_0.ImVec2(0, 0), true)
				var_0_0.Text(var_0_7.ICON_COG .. u8(" ��������� ��������� ���������"))
				var_0_0.SameLine()
				var_0_0.SetCursorPos(var_0_0.ImVec2(424, 3))

				if var_0_0.Button(u8("��������� ���������")) then
					saveEdits()
				end

				var_0_0.SameLine()

				if var_0_0.Button(u8("�������� ���������")) then
					resetEdits()
				end

				var_0_0.Separator()
				var_0_0.PushItemWidth(690)

				for iter_138_32, iter_138_33 in pairs(as.other.test_message_edits) do
					if var_0_0.CollapsingHeader(iter_138_33.title) then
						for iter_138_34, iter_138_35 in pairs(iter_138_33.messages.edit) do
							var_0_0.PushTextWrapPos()
							var_0_0.Text(iter_138_35.description .. ":")

							for iter_138_36, iter_138_37 in pairs(iter_138_35.messages[gender()]) do
								if var_0_0.Button(var_0_7.ICON_RETWEET .. "##" .. iter_138_33.code .. iter_138_35.code .. tostring(iter_138_34) .. tostring(iter_138_36) .. "_button") then
									im.edits[iter_138_33.code][iter_138_35.code][gender()][iter_138_36].v = as.other
									.test_message_edits[iter_138_32].messages.default[iter_138_34].messages[gender()]
									[iter_138_36]

									am("�������� ��-��������� �����������!")
								end

								if var_0_0.IsItemHovered() then
									var_0_0.BeginTooltip()
									var_0_0.PushTextWrapPos(var_0_0.GetFontSize() * 35)
									var_0_0.TextUnformatted(u8("������� �������� ��-���������"))
									var_0_0.PopTextWrapPos()
									var_0_0.EndTooltip()
								end

								var_0_0.SameLine()
								var_0_0.InputText(
								"##" ..
								iter_138_33.code .. iter_138_35.code .. tostring(iter_138_34) .. tostring(iter_138_36),
									im.edits[iter_138_33.code][iter_138_35.code][gender()][iter_138_36])

								as.other.test_message_edits[iter_138_32].messages.edit[iter_138_34].messages[gender()][iter_138_36] =
								im.edits[iter_138_33.code][iter_138_35.code][gender()][iter_138_36].v
							end

							var_0_0.Separator()
						end
					end
				end

				var_0_0.EndChild()
			elseif selected == 12 then
				var_0_0.Separator()
				var_0_0.Image(var_0_15.settings_tencodes, var_0_0.ImVec2(715, 80))
				var_0_0.Separator()
				var_0_0.BeginChild("left pane###pa", var_0_0.ImVec2(0, 0), true)
				var_0_0.Text(var_0_7.ICON_COG .. u8(" ���-����"))
				var_0_0.SameLine()
				showHelp(u8(
				"����� �� ������ ���������� ���-����. ���-���� ���������� �� ����� �������� ��������� � ����� �����������."))
				var_0_0.SameLine()
				var_0_0.SetCursorPos(var_0_0.ImVec2(564, 3))

				if var_0_0.Button(u8("��������� ���������")) then
					saveCo()
				end

				var_0_0.Separator()
				var_0_0.PushItemWidth(100)
				var_0_0.InputText(u8("���������� ��������� �������##normal"), co.normal)

				tencodes.normal = co.normal.v

				var_0_0.InputText(u8("����� � �������##patrol_start"), co.patrol_start)

				tencodes.patrol_start = co.patrol_start.v

				var_0_0.InputText(u8("��������� �������##patrol_finish"), co.patrol_finish)

				tencodes.patrol_finish = co.patrol_finish.v

				var_0_0.InputText(u8("������##pursuit"), co.pursuit)

				tencodes.pursuit = co.pursuit.v

				var_0_0.InputText(u8("������##ok"), co.ok)

				tencodes.ok = co.ok.v

				var_0_0.InputText(u8("�� ������##nok"), co.nok)

				tencodes.nok = co.nok.v

				var_0_0.InputText(u8("������ SOS##sos"), co.sos)

				tencodes.sos = co.sos.v

				var_0_0.InputText(u8("������-����##traffic_stop"), co.traffic_stop)

				tencodes.traffic_stop = co.traffic_stop.v

				var_0_0.InputText(u8("������-���� ����������� �����##traffic_stop_66"), co.traffic_stop_66)

				tencodes.traffic_stop_66 = co.traffic_stop_66.v

				var_0_0.InputText(u8("������ ���������##top_message"), co.top_message)

				tencodes.top_message = co.top_message.v

				var_0_0.InputText(u8("�������� �������������##codefour"), co.codefour)

				tencodes.codefour = co.codefour.v

				var_0_0.InputText(u8("����� ������##foxtrot"), co.foxtrot)

				tencodes.foxtrot = co.foxtrot.v

				var_0_0.InputText(u8("������� � �������##officer_down"), co.officer_down)

				tencodes.officer_down = co.officer_down.v

				var_0_0.Text(var_0_7.ICON_HEARTBEAT .. u8(" ���������� � ����� ��� �������"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("���������� � ����� ��� �������"), im.settings.officer_down)

				se.main.officer_down = im.settings.officer_down.v

				var_0_0.EndChild()
			elseif selected == 13 then
				var_0_0.Separator()
				var_0_0.Image(var_0_15.settings_wantedsystem, var_0_0.ImVec2(715, 80))
				var_0_0.BeginChild("left pane###pasu", var_0_0.ImVec2(0, 0), true)
				var_0_0.Text(var_0_7.ICON_COG .. u8(" ������� ������ � ������"))
				var_0_0.SameLine()
				showHelp(u8("����� �� ������ ���������� ������ ��� ������ � ������."))
				var_0_0.SameLine()
				var_0_0.SetCursorPos(var_0_0.ImVec2(268, 3))

				if var_0_0.Button(u8("�������� ������")) then
					addSu = not addSu
				end

				var_0_0.SameLine()

				if var_0_0.Button(u8("��������� ���������")) then
					saveSu()
				end

				var_0_0.SameLine()

				if var_0_0.Button(u8("�������� ���")) then
					setSuData()
					am("������ ��������.")
				end

				var_0_0.SameLine()

				if var_0_0.Button(u8("������� ���")) then
					deleteAllSu()
				end

				if addSu then
					var_0_0.Separator()
					var_0_0.BeginChild("left pane###addsu", var_0_0.ImVec2(690, 150), true)
					var_0_0.PushItemWidth(410)
					var_0_0.InputText(u8("������� ����� ������"), cov.addNum)
					var_0_0.SameLine()
					showHelp(u8("� �������: ��. �21 ��"))
					var_0_0.InputText(u8("������� �������� ������"), cov.addName)
					var_0_0.SameLine()
					showHelp(u8("� �������: ��������"))
					var_0_0.InputText(u8("������� ���������� ������� [1-6]"), cov.addWanted)
					var_0_0.SameLine()
					showHelp(u8("� �������: 5"))
					var_0_0.InputText(u8("������� ���� ������ ������ � ������"), cov.addColor)
					var_0_0.SameLine()
					showHelp(u8("� �������: {008000}"))

					if var_0_0.Button(u8("�������� ������"), var_138_2) then
						if cov.addNum.v:len() > 0 and cov.addName.v:len() > 0 and cov.addWanted.v:len() > 0 then
							local var_138_73 = #suva + 1

							sud.a[var_138_73] = u8:decode(cov.addNum.v)
							sud.b[var_138_73] = u8:decode(cov.addName.v)
							sud.c[var_138_73] = u8:decode(cov.addWanted.v)
							sud.d[var_138_73] = u8:decode(cov.addColor.v)
							cov.addNum.v, cov.addName.v, cov.addWanted.v, cov.addColor.v = "", "", "", ""

							saveSu()
						else
							am("������ ��� ���� ����������� ��� ����������.")
						end
					end

					if var_0_0.Button(u8("������� ���� ���������� ������"), var_138_2) then
						addSu = false
					end

					var_0_0.EndChild()
				end

				var_0_0.Separator()
				var_0_0.Text(u8("������� ������ ������� �� �����������"))
				var_0_0.Separator()
				var_0_0.Columns(3, _, false)
				var_0_0.SetColumnWidth(-1, 100)
				var_0_0.PushItemWidth(100)
				var_0_0.InputText("##autosu1", autosu1)

				sud.f[1] = u8:decode(autosu1.v)

				var_0_0.NextColumn()
				var_0_0.SetColumnWidth(-1, 410)
				var_0_0.PushItemWidth(410)
				var_0_0.InputText("##autosu2", autosu2)

				sud.f[2] = u8:decode(autosu2.v)

				var_0_0.NextColumn()
				var_0_0.SetColumnWidth(-1, 150)
				var_0_0.PushItemWidth(150)
				var_0_0.InputText("##autosu3", autosu3)

				sud.f[3] = u8:decode(autosu3.v)

				var_0_0.Columns(1)
				var_0_0.Separator()
				var_0_0.Text(u8("������� ������ ������� � ������� ������ �� ����"))
				var_0_0.Separator()
				var_0_0.Columns(3, _, false)
				var_0_0.SetColumnWidth(-1, 100)
				var_0_0.PushItemWidth(100)
				var_0_0.InputText("##autopursuit1", autopursuit1)

				sud.e[1] = u8:decode(autopursuit1.v)

				var_0_0.NextColumn()
				var_0_0.SetColumnWidth(-1, 410)
				var_0_0.PushItemWidth(410)
				var_0_0.InputText("##autopursuit2", autopursuit2)

				sud.e[2] = u8:decode(autopursuit2.v)

				var_0_0.NextColumn()
				var_0_0.SetColumnWidth(-1, 150)
				var_0_0.PushItemWidth(150)
				var_0_0.InputText("##autopursuit3", autopursuit3)

				sud.e[3] = u8:decode(autopursuit3.v)

				var_0_0.Columns(1)
				var_0_0.Separator()
				var_0_0.Columns(5, _, false)
				var_0_0.SetColumnWidth(-1, 100)
				var_0_0.Text(u8("������ �"))
				var_0_0.NextColumn()
				var_0_0.SetColumnWidth(-1, 410)
				var_0_0.Text(u8("�������� ������"))
				var_0_0.NextColumn()
				var_0_0.SetColumnWidth(-1, 50)
				var_0_0.Text(u8("������"))
				var_0_0.NextColumn()
				var_0_0.SetColumnWidth(-1, 100)
				var_0_0.Text(u8("���� ������"))
				var_0_0.NextColumn()
				var_0_0.SetColumnWidth(-1, 30)
				var_0_0.Columns(1)
				var_0_0.Separator()
				var_0_0.Columns(5, _, false)
				var_0_0.SetColumnWidth(-1, 100)

				for iter_138_38, iter_138_39 in pairs(suva) do
					var_0_0.PushItemWidth(100)
					var_0_0.InputText("##" .. iter_138_38 .. tostring(iter_138_39), suva[iter_138_38])

					sud.a[iter_138_38] = u8:decode(suva[iter_138_38].v)
				end

				var_0_0.NextColumn()
				var_0_0.SetColumnWidth(-1, 410)

				for iter_138_40, iter_138_41 in pairs(suvb) do
					var_0_0.PushItemWidth(410)
					var_0_0.InputText("##" .. iter_138_40 .. tostring(iter_138_41), suvb[iter_138_40])

					sud.b[iter_138_40] = u8:decode(suvb[iter_138_40].v)
				end

				var_0_0.NextColumn()
				var_0_0.SetColumnWidth(-1, 50)

				for iter_138_42, iter_138_43 in pairs(suvc) do
					var_0_0.PushItemWidth(50)
					var_0_0.InputText("##" .. iter_138_42 .. tostring(iter_138_43), suvc[iter_138_42])

					sud.c[iter_138_42] = suvc[iter_138_42].v
				end

				var_0_0.NextColumn()
				var_0_0.SetColumnWidth(-1, 100)

				for iter_138_44, iter_138_45 in pairs(suvd) do
					var_0_0.PushItemWidth(100)
					var_0_0.InputText("##" .. iter_138_44 .. tostring(iter_138_45), suvd[iter_138_44])

					sud.d[iter_138_44] = suvd[iter_138_44].v
				end

				var_0_0.NextColumn()
				var_0_0.SetColumnWidth(-1, 30)

				for iter_138_46, iter_138_47 in pairs(suva) do
					if var_0_0.Button(var_0_7.ICON_TIMES .. "##" .. iter_138_46 .. tostring(iter_138_47)) and sud and sud.a[iter_138_46] then
						table.remove(sud.a, iter_138_46)
						table.remove(sud.b, iter_138_46)
						table.remove(sud.c, iter_138_46)
						table.remove(sud.d, iter_138_46)
						updateSuData()
					end
				end

				var_0_0.Columns(1)
				var_0_0.Separator()
				var_0_0.AlignTextToFramePadding()
				var_0_0.Text((im.settings.suNumber.v and var_0_7.ICON_EYE or var_0_7.ICON_EYE_SLASH) ..
				u8(" ��������� ����� ������ � /su"))
				var_0_0.SameLine()
				var_0_0.ToggleButton(u8("����� ������ � /su"), im.settings.suNumber)

				se.main.suNumber = im.settings.suNumber.v

				var_0_0.SameLine()
				showHelp(u8(
				"��������� ��� �� ��������� ����� ������ ��� ������ � ������ ����� /su. ���� ��������, �� ����� ����������� ��������� ������ � �������: ���. 2 \"�����������\"�. ���� ���������, �� ����� ����������� ������ �������: ������������."))
				var_0_0.EndChild()
			elseif selected == 14 then
				var_0_0.Separator()
				var_0_0.Image(var_0_15.settings_changeranks, var_0_0.ImVec2(715, 80))
				var_0_0.Separator()
				var_0_0.BeginChild("left pane###fr", var_0_0.ImVec2(0, 0), true)
				var_0_0.Text(var_0_7.ICON_COG .. u8(" ������� ������ �������"))
				var_0_0.SameLine()
				showHelp(u8(
				"����� �� ������ ���������� ������ ����������� ������ �������. ����� ���������� ������ � �����."))
				var_0_0.SameLine()
				var_0_0.SetCursorPos(var_0_0.ImVec2(505, 3))

				if var_0_0.Button(u8("�������� ������")) then
					addRang = not addRang
				end

				var_0_0.SameLine()

				if var_0_0.Button(u8("������� ���")) then
					changedRangs = {}

					saveRangs()
				end

				if addRang then
					var_0_0.BeginChild("left pane###addrang", var_0_0.ImVec2(690, 150), true)
					var_0_0.Text((chRang ~= "" and var_0_7.ICON_CHECK_SQUARE_O or var_0_7.ICON_MINUS_SQUARE_O) ..
					u8(" ���������� ����: ") ..
					(chRang ~= "" and chRang or u8:decode(chRang) == "�������� ����" and u8("-- �� ������ --") or u8("-- �� ������ --")))
					var_0_0.Text((var_0_54.v ~= "" and var_0_7.ICON_CHECK_SQUARE_O or var_0_7.ICON_MINUS_SQUARE_O) ..
					u8(" ����� ����: ") .. (var_0_54.v ~= "" and trim(var_0_54.v) or u8("-- �� ������ --")))
					var_0_0.PushItemWidth(410)

					if var_0_0.Combo(u8("�������� ����"), slc, originalChangeRang) then
						chRang = originalChangeRang[slc.v]
						idRang = slc.v
					end

					var_0_0.InputText(u8("����� ����"), var_0_54)
					var_0_0.TextColoredRGB(chmess)

					if var_0_0.Button(u8("�������� ����"), var_138_2) then
						chmess = ""

						local var_138_74 = u8:decode(chRang)
						local var_138_75 = trim(u8:decode(var_0_54.v))

						if chRang ~= "" and u8:decode(chRang) ~= "�������� ����" and var_138_75:len() > 0 then
							changedRangs[var_138_74] = var_138_75

							saveRangs()

							addRang, chRang, var_0_54.v = false, "", ""
						else
							chmess = "{FF0000}�������� ��������������� ���� ��� ��������� ������ ����"
						end
					end

					if var_0_0.Button(u8("������� ���� ���������� �����"), var_138_2) then
						addRang = false
					end

					var_0_0.EndChild()
				end

				var_0_0.Separator()
				var_0_0.Columns(2)
				var_0_0.Text(u8("���������� ����"))
				var_0_0.NextColumn()
				var_0_0.Text(u8("����� ����"))
				var_0_0.Columns(1)
				var_0_0.Separator()

				for iter_138_48 = 1, #chTable do
					var_0_0.Columns(2)
					var_0_0.Text(u8(chTable[iter_138_48].old))
					var_0_0.NextColumn()
					var_0_0.Text(u8(chTable[iter_138_48].new))
					var_0_0.Separator()
					var_0_0.Columns(1)
				end

				var_0_0.EndChild()
			elseif selected == 15 then
				selectedTickets()
			elseif selected == 16 then
				selectedDispatch()
			elseif selected == 17 then
				selectedTimings()
			elseif selected == 18 then
				selectedRhi()
			elseif selected == 19 then
				selectedFastMapOrSquad()
			elseif selected == 20 then
				blockedFuncs()
			end

			if selectedCommands ~= 0 and #SeleListCommandsBool > 0 then
				clearSeleListCommandsBool(selectedCommands)
			end

			if selectedCheats ~= 0 and #SeleListCheatsBool > 0 then
				clearSeleListCheatsBool(selectedCheats)
			end

			if selectedKeys ~= 0 and #SeleListKeysBool > 0 then
				clearSeleListKeysBool(selectedKeys)
			end

			if im.informer.infMainShowPursuit.v and warn_info.show_pursuit then
				chat("��������! �� �������� ����������� �������!")
				chat("������������ � ������������ ��������� �� ������ ������ �������!")

				warn_info.show_pursuit = false
			end

			if im.informer.infMainAutoSu.v and warn_info.auto_su then
				chat("��������! �� �������� ����������� �������!")
				chat("������������ � ������������ ��������� �� ������ ������ �������!")

				warn_info.auto_su = false
			end

			if im.informer.infMainShowBlip.v and warn_info.show_blip then
				chat("��������! �� �������� ����������� �������!")
				chat("������������ � ������������ ��������� �� ������ ������ �������!")

				warn_info.show_blip = false
			end

			if im.settings.strobe.v and warn_info.strobe then
				chat("��������! �� �������� ����������� �������!")
				chat("������������ � ������������ ��������� �� ������ ������ �������!")

				warn_info.strobe = false
			end

			if im.pursuit.sector.v and warn_info.pursuit_sector then
				chat("��������! �� �������� ����������� �������!")
				chat("������������ � ������������ ��������� �� ������ ������ �������!")

				warn_info.pursuit_sector = false
			end

			if selected ~= 0 then
				clearSeleListBool(selected)
			end

			var_0_0.EndGroup()
			var_0_0.End()
		end

		if var_0_43.v and not sampIsScoreboardOpen() and sampGetGamestate() == 3 and not as.fastmap.fastmap_state then
			var_0_0.SetMouseCursor(-1)
			inform_state_f()
		end

		if im.windows.partner.v and not sampIsScoreboardOpen() and sampGetGamestate() == 3 and not as.fastmap.fastmap_state then
			var_0_0.SetMouseCursor(-1)
			partner_informer()
		end

		if var_0_44.v and im.informer.infMainPursuit.v and not sampIsScoreboardOpen() and sampGetGamestate() == 3 and not as.fastmap.fastmap_state then
			var_0_0.SetMouseCursor(-1)
			pursuit_state_f()
		end

		if im.windows.mycard.v then
			mycard()
		end

		if var_0_48.v and sampGetGamestate() == 3 then
			auth_show()
		end

		if var_0_47.v and sampGetGamestate() == 3 then
			dbstateshow()
		end

		if var_0_53.v and sampGetGamestate() == 3 then
			pursuitshow()
		end

		if im.windows.speedometr.v and sampGetGamestate() == 3 and isCharInCarDriver(playerPed) and not sampIsScoreboardOpen() then
			var_0_0.SetMouseCursor(-1)

			local var_138_76 = var_138_0 / 1.3
			local var_138_77 = var_138_1 / 1.3

			if isKeyDown(VK_SHIFT) and isCharInCarDriver(playerPed) and not sampIsDialogActive() and not sampIsChatInputActive() and not isCharInAnyBoat(playerPed) and not isCharInAnyPlane(playerPed) then
				var_138_76, var_138_77 = var_138_0 / 1.3 - as.spd.cruise_minus, var_138_1 / 1.3
			end

			var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_138_76, var_138_77), var_0_0.ImVec2(0.5, 0.5))
			var_0_0.SetNextWindowSize(var_0_0.ImVec2(as.spd.window_width, as.spd.window_height),
				var_0_0.Cond.FirstUseEver)
			var_0_0.PushStyleColor(var_0_0.Col.WindowBg, var_0_0.ImVec4(0, 0, 0, 0.3))

			local var_138_78 = getGxtText(getNameOfVehicleModel(getCarModel(storeCarCharIsInNoSave(playerPed))))

			if var_0_0.Begin("PD-Project Speedometr", im.windows.speedometr, var_0_0.WindowFlags.NoTitleBar + var_0_0.WindowFlags.NoResize + var_0_0.WindowFlags.AlwaysAutoResize + var_0_0.WindowFlags.NoSavedSettings) then
				var_0_0.PushFont(as.fonts.speedometr.main_font)
				var_0_0.PushStyleColor(var_0_0.Col.Button, var_0_0.ImVec4(0, 0, 0, 0))
				var_0_0.PushStyleColor(var_0_0.Col.ButtonActive, var_0_0.ImVec4(0, 0, 0, 0.5))
				var_0_0.PushStyleColor(var_0_0.Col.ButtonHovered, var_0_0.ImVec4(0, 0, 0.2, 0.3))

				if isKeyDown(VK_SHIFT) and isCharInCarDriver(playerPed) and not sampIsDialogActive() and not sampIsChatInputActive() and not isCharInAnyBoat(playerPed) and not isCharInAnyPlane(playerPed) then
					if not as.other.shwcrs_pos then
						setCursorPos(var_138_76, var_138_77)

						as.other.shwcrs_pos = true
					end

					shwcrs = true

					showCursor(true, false)
					var_0_0.BeginChild("speedometr.leftpanel", var_0_0.ImVec2(as.spd.cruise_w, as.spd.cruise_h), false)
					var_0_0.PushFont(as.fonts.speedometr.main_fa_font)

					if not isCharInAnyHeli(playerPed) then
						if var_0_0.Button(var_0_7.ICON_CARET_SQUARE_O_RIGHT) and not cruise and isCharInAnyCar(playerPed) and not isCharInAnyHeli(playerPed) and not isCharInAnyPlane(playerPed) and not isCharInAnyBoat(playerPed) then
							if speedMyKM then
								cruiseSpeed = tonumber(speedMyKM) / 2
								cruise = true
								cruiseVehicle = storeCarCharIsInNoSave(playerPed)
							else
								cruiseSpeed = 0
								cruise = true
								cruiseVehicle = storeCarCharIsInNoSave(playerPed)
							end
						end

						var_0_0.PushFont(as.fonts.speedometr.main_font)

						if var_0_0.IsItemHovered() then
							var_0_0.BeginTooltip()
							var_0_0.PushTextWrapPos(var_0_0.GetFontSize() * 35)
							var_0_0.TextUnformatted(u8("�����: �����"))
							var_0_0.PopTextWrapPos()
							var_0_0.EndTooltip()
						end

						var_0_0.PopFont()

						if var_0_0.Button(var_0_7.ICON_CARET_SQUARE_O_UP) and cruise and cruiseSpeed <= 59 then
							cruiseSpeed = cruiseSpeed + 5
						end

						var_0_0.PushFont(as.fonts.speedometr.main_font)

						if var_0_0.IsItemHovered() then
							var_0_0.BeginTooltip()
							var_0_0.PushTextWrapPos(var_0_0.GetFontSize() * 35)
							var_0_0.TextUnformatted(u8("�����: ��������� �� 5 ��/�"))
							var_0_0.PopTextWrapPos()
							var_0_0.EndTooltip()
						end

						var_0_0.PopFont()

						if var_0_0.Button(var_0_7.ICON_CARET_SQUARE_O_DOWN) and cruise and cruiseSpeed > 4 then
							cruiseSpeed = cruiseSpeed - 5
						end

						var_0_0.PushFont(as.fonts.speedometr.main_font)

						if var_0_0.IsItemHovered() then
							var_0_0.BeginTooltip()
							var_0_0.PushTextWrapPos(var_0_0.GetFontSize() * 35)
							var_0_0.TextUnformatted(u8("�����: ��������� �� 5 ��/�"))
							var_0_0.PopTextWrapPos()
							var_0_0.EndTooltip()
						end

						var_0_0.PopFont()

						if var_0_0.Button(var_0_7.ICON_LINE_CHART) and cruise and cruiseVehicle ~= -1 then
							cruiseSpeed = math.floor(tonumber(maxspeed)) / 2
						end

						var_0_0.PushFont(as.fonts.speedometr.main_font)

						if var_0_0.IsItemHovered() then
							var_0_0.BeginTooltip()
							var_0_0.PushTextWrapPos(var_0_0.GetFontSize() * 35)
							var_0_0.TextUnformatted(u8("�����: ����. �������� �/�"))
							var_0_0.PopTextWrapPos()
							var_0_0.EndTooltip()
						end

						var_0_0.PopFont()
					else
						if var_0_0.Button(var_0_7.ICON_CARET_SQUARE_O_RIGHT) then
							as.autopilot.state = true

							if zZ and zZ > 0 then
								as.autopilot.height = math.floor(zZ)
							end
						end

						var_0_0.PushFont(as.fonts.speedometr.main_font)

						if var_0_0.IsItemHovered() then
							var_0_0.BeginTooltip()
							var_0_0.PushTextWrapPos(var_0_0.GetFontSize() * 35)
							var_0_0.TextUnformatted(u8("��������� ������: �����"))
							var_0_0.PopTextWrapPos()
							var_0_0.EndTooltip()
						end

						var_0_0.PopFont()

						if var_0_0.Button(var_0_7.ICON_CARET_SQUARE_O_UP) and as.autopilot.height < 490 then
							as.autopilot.height = as.autopilot.height + 10
						end

						var_0_0.PushFont(as.fonts.speedometr.main_font)

						if var_0_0.IsItemHovered() then
							var_0_0.BeginTooltip()
							var_0_0.PushTextWrapPos(var_0_0.GetFontSize() * 35)
							var_0_0.TextUnformatted(u8("��������� ������: ��������� �� 10 �."))
							var_0_0.PopTextWrapPos()
							var_0_0.EndTooltip()
						end

						var_0_0.PopFont()

						if var_0_0.Button(var_0_7.ICON_CARET_SQUARE_O_DOWN) and as.autopilot.height > 10 then
							as.autopilot.height = as.autopilot.height - 10
						end

						var_0_0.PushFont(as.fonts.speedometr.main_font)

						if var_0_0.IsItemHovered() then
							var_0_0.BeginTooltip()
							var_0_0.PushTextWrapPos(var_0_0.GetFontSize() * 35)
							var_0_0.TextUnformatted(u8("��������� ������: ��������� �� 10 �."))
							var_0_0.PopTextWrapPos()
							var_0_0.EndTooltip()
						end

						var_0_0.PopFont()

						if var_0_0.Button(var_0_7.ICON_CERTIFICATE) then
							if speedMyKM > 7 then
								chat("������� �������� �� 7 ��/�. � ���������� ��������, ����� ������������ �������.")
							else
								as.autopilot.impact = not as.autopilot.impact

								_G.freezeCarPosition(storeCarCharIsInNoSave(playerPed), as.autopilot.impact)

								as.autopilot.impact_vehicle = storeCarCharIsInNoSave(playerPed)

								if as.autopilot.impact then
									chat("�������� ����� ������������ �� ������� �����������.")
								end
							end
						end

						var_0_0.PushFont(as.fonts.speedometr.main_font)

						if var_0_0.IsItemHovered() then
							var_0_0.BeginTooltip()
							var_0_0.PushTextWrapPos(var_0_0.GetFontSize() * 35)
							var_0_0.TextUnformatted(u8("��������� ������: ���������� ������� ����������."))
							var_0_0.PopTextWrapPos()
							var_0_0.EndTooltip()
						end

						var_0_0.PopFont()
					end

					var_0_0.PopFont()
					var_0_0.EndChild()
					var_0_0.SameLine()
					var_0_0.VerticalSeparator()
					var_0_0.SameLine()
				elseif shwcrs and not var_0_36.v and not var_0_37.v and not var_0_38.v and not var_0_39.v and not var_0_40.v and not var_0_41.v and not var_0_42.v and not var_0_47.v and not var_0_51.v and not var_0_50.v and not var_0_49.v and not sampIsDialogActive() and not sampIsChatInputActive() and not sampIsScoreboardOpen() then
					showCursor(false, false)

					shwcrs = false
					as.other.shwcrs_pos = false
				end

				var_0_0.PopStyleColor(3)
				var_0_0.BeginChild("speedometr.speed", var_0_0.ImVec2(as.spd.child_left_w, as.spd.child_left_h), false)
				var_0_0.SetCursorPos(var_0_0.ImVec2(10, 0))
				var_0_0.PushFont(as.fonts.speedometr.font)
				var_0_0.CenterText(u8(var_138_78))
				var_0_0.PopFont()
				var_0_0.PushFont(as.fonts.speedometr.speed)
				var_0_0.SetCursorPos(var_0_0.ImVec2(10, as.spd.speed_cursor_pos))
				var_0_0.CenterText(tostring(speedMyKM))
				var_0_0.PushFont(as.fonts.speedometr.font)
				var_0_0.SetCursorPos(var_0_0.ImVec2(10, as.spd.kmh_pos))
				var_0_0.CenterText(u8("��/�"))
				var_0_0.PopFont()
				var_0_0.PopFont()
				var_0_0.EndChild()
				var_0_0.SameLine()
				var_0_0.BeginChild("speedometr.stats", var_0_0.ImVec2(as.spd.child_right_w, as.spd.child_right_h), false)

				local var_138_79 = getCarHealth(storeCarCharIsInNoSave(playerPed))
				local var_138_80 = select(2, sampGetVehicleIdByCarHandle(storeCarCharIsInNoSave(playerPed)))

				var_0_0.Columns(2, _, false)
				var_0_0.SetColumnWidth(-1, as.spd.column_width)
				var_0_0.PushFont(as.fonts.speedometr.main_fa_font)
				var_0_0.CenterFaText(var_0_7.ICON_HEARTBEAT)
				var_0_0.PopFont()
				var_0_0.NextColumn()
				var_0_0.CustomAnimProgressBar("speedometr.carhealth",
					tonumber(var_138_79) > 1000 and tonumber(var_138_79 - (var_138_79 - 1000)) or tonumber(var_138_79),
					1000, var_0_0.ImVec4(1, 0, 0, 0.4), var_0_0.ImVec2(-1, as.spd.main_font + 1))
				var_0_0.Columns(1)

				if var_138_79 > 1000 then
					if as.other.arm[var_138_80] == nil or as.other.arm[var_138_80] == 0 then
						as.other.arm[var_138_80] = math.ceil((var_138_79 - 1000) / 500)
					end

					if var_138_79 - 1000 > as.other.arm[var_138_80] * 500 then
						as.other.arm[var_138_80] = math.ceil((var_138_79 - 1000) / 500)
					end

					var_0_0.Columns(2, _, false)
					var_0_0.SetColumnWidth(-1, as.spd.column_width)
					var_0_0.PushFont(as.fonts.speedometr.main_fa_font)
					var_0_0.CenterFaText(var_0_7.ICON_SHIELD)
					var_0_0.PopFont()
					var_0_0.NextColumn()
					var_0_0.CustomAnimProgressBar("speedometr.cararmour", tonumber(var_138_79 - 1000),
						as.other.arm[select(2, sampGetVehicleIdByCarHandle(storeCarCharIsInNoSave(playerPed)))] * 500,
						var_0_0.ImVec4(1, 1, 1, 0.3), var_0_0.ImVec2(-1, as.spd.main_font + 1))
					var_0_0.Columns(1)
				end

				if not isCharInAnyHeli(playerPed) and not isCharInAnyBoat(playerPed) and not isCharInAnyPlane(playerPed) then
					local var_138_81 = 200

					if var_138_81 < tonumber(as.speedometr.fuel) then
						var_138_81 = 300
					end

					var_0_0.Columns(2, _, false)
					var_0_0.SetColumnWidth(-1, as.spd.column_width)
					var_0_0.PushFont(as.fonts.speedometr.main_fa_font)
					var_0_0.CenterFaText(var_0_7.ICON_TINT)
					var_0_0.PopFont()
					var_0_0.NextColumn()
					var_0_0.CustomAnimProgressBar("speedometr.carfuel", tonumber(as.speedometr.fuel), var_138_81,
						var_0_0.ImVec4(1, 0.7, 0, 0.6), var_0_0.ImVec2(-1, as.spd.main_font + 1))
					var_0_0.Columns(1)
				end

				var_0_0.PushFont(as.fonts.speedometr.icon)
				var_0_0.PushStyleColor(var_0_0.Col.Button, var_0_0.ImVec4(0, 0, 0, 0))
				var_0_0.PushStyleColor(var_0_0.Col.ButtonActive, var_0_0.ImVec4(0, 0, 0, 0.5))
				var_0_0.PushStyleVar(var_0_0.StyleVar.FrameRounding, 12)

				if getCarDoorLockStatus(storeCarCharIsInNoSave(playerPed)) == 0 then
					var_0_0.PushStyleColor(var_0_0.Col.Text, var_0_0.ImVec4(0, 1, 0.2, 0.7))
					var_0_0.PushStyleColor(var_0_0.Col.ButtonHovered, var_0_0.ImVec4(0, 1, 0.2, 0.1))

					if var_0_0.Button(var_0_7.ICON_UNLOCK) then
						sampSendSystemChat("/lock")
					end
				else
					var_0_0.PushStyleColor(var_0_0.Col.Text, var_0_0.ImVec4(1, 0.2, 0, 0.7))
					var_0_0.PushStyleColor(var_0_0.Col.ButtonHovered, var_0_0.ImVec4(1, 0.2, 0, 0.15))

					if var_0_0.Button(var_0_7.ICON_LOCK) then
						sampSendSystemChat("/lock")
					end
				end

				if isCarEngineOn(storeCarCharIsInNoSave(playerPed)) then
					var_0_0.PushStyleColor(var_0_0.Col.Text, var_0_0.ImVec4(0, 1, 0.2, 0.7))
					var_0_0.PushStyleColor(var_0_0.Col.ButtonHovered, var_0_0.ImVec4(0, 1, 0.2, 0.1))
				else
					var_0_0.PushStyleColor(var_0_0.Col.Text, var_0_0.ImVec4(1, 0.2, 0, 0.7))
					var_0_0.PushStyleColor(var_0_0.Col.ButtonHovered, var_0_0.ImVec4(1, 0.2, 0, 0.15))
				end

				var_0_0.SameLine()

				if var_0_0.Button(var_0_7.ICON_KEY) then
					sampSendSystemChat("/en")
				end

				var_0_0.PopStyleColor(6)
				var_0_0.SameLine()
				var_0_0.PushStyleColor(var_0_0.Col.Button, var_0_0.ImVec4(0, 0, 0, 0))
				var_0_0.PushStyleColor(var_0_0.Col.ButtonActive, var_0_0.ImVec4(0, 0, 0, 0.5))

				if isCarSirenOn(storeCarCharIsInNoSave(playerPed)) then
					var_0_0.PushStyleColor(var_0_0.Col.Text,
						var_0_0.ImVec4(as.other.speedsiren.r, as.other.speedsiren.g, as.other.speedsiren.b, 1))
					var_0_0.PushStyleColor(var_0_0.Col.ButtonHovered, var_0_0.ImVec4(0, 0, 0, 0.3))

					if var_0_0.Button(var_0_7.ICON_TAXI) then
						switchCarSiren(storeCarCharIsInNoSave(playerPed),
							not isCarSirenOn(storeCarCharIsInNoSave(playerPed)))
					end

					var_0_0.PopStyleColor(2)
				else
					var_0_0.PushStyleColor(var_0_0.Col.Text, var_0_0.ImVec4(1, 1, 1, 0.5))
					var_0_0.PushStyleColor(var_0_0.Col.ButtonHovered, var_0_0.ImVec4(0, 0, 0, 0.3))

					if var_0_0.Button(var_0_7.ICON_TAXI) then
						switchCarSiren(storeCarCharIsInNoSave(playerPed),
							not isCarSirenOn(storeCarCharIsInNoSave(playerPed)))
					end

					var_0_0.PopStyleColor(2)
				end

				var_0_0.PopStyleColor(2)
				var_0_0.PopStyleVar()
				var_0_0.PopFont()

				if se.main.speedometr_size ~= 0 and cruise then
					var_0_0.PushFont(as.fonts.speedometr.main_fa_font)
					var_0_0.Text(var_0_7.ICON_TACHOMETER)
					var_0_0.PopFont()
					var_0_0.SameLine()
					var_0_0.Text(u8(" �����: " .. math.floor(cruiseSpeed * 2) .. " ��/�"))
				end

				if var_138_79 <= 1000 and se.main.speedometr_size == 0 and cruise then
					var_0_0.PushFont(as.fonts.speedometr.main_fa_font)
					var_0_0.Text(var_0_7.ICON_TACHOMETER)
					var_0_0.PopFont()
					var_0_0.SameLine()
					var_0_0.Text(u8(" �����: " .. math.floor(cruiseSpeed * 2) .. " ��/�"))
				end

				if se.main.speedometr_size ~= 0 and var_138_78:find("Maverick") then
					local var_138_82, var_138_83, var_138_84 = getCharCoordinates(playerPed)
					local var_138_85 = getGroundZFor3dCoord(var_138_82, var_138_83, var_138_84)

					var_0_0.PushFont(as.fonts.speedometr.main_fa_font)
					var_0_0.Text(var_0_7.ICON_SORT_AMOUNT_DESC)
					var_0_0.PopFont()
					var_0_0.SameLine()
					var_0_0.Text(u8(" ������: " ..
					tostring(math.floor(var_138_84 - (var_138_85 and var_138_85 or 0))) .. " �."))
					var_0_0.PushFont(as.fonts.speedometr.main_fa_font)
					var_0_0.Text(var_0_7.ICON_SORT_NUMERIC_DESC)
					var_0_0.PopFont()
					var_0_0.SameLine()
					var_0_0.Text(u8(" ���. ������: " .. tostring(math.floor(var_138_84)) .. " �."))

					if as.autopilot.state == true then
						var_0_0.PushFont(as.fonts.speedometr.main_fa_font)
						var_0_0.Text(var_0_7.ICON_PLANE)
						var_0_0.PopFont()
						var_0_0.SameLine()
						var_0_0.Text(u8(" ��������� ������: " ..
						tostring(math.floor(as.autopilot.height)) ..
						"-" .. tostring(math.floor(as.autopilot.height + 10)) .. " �."))
					end
				end

				if se.main.speedometr_size == 0 and var_138_78:find("Maverick") then
					local var_138_86, var_138_87, var_138_88 = getCharCoordinates(playerPed)
					local var_138_89 = getGroundZFor3dCoord(var_138_86, var_138_87, var_138_88)

					var_0_0.PushFont(as.fonts.speedometr.main_fa_font)
					var_0_0.Text(var_0_7.ICON_SORT_AMOUNT_DESC)
					var_0_0.PopFont()
					var_0_0.SameLine()
					var_0_0.Text(u8(" ������: " ..
					tostring(math.floor(var_138_88 - (var_138_89 and var_138_89 or 0))) .. " �."))
					var_0_0.PushFont(as.fonts.speedometr.main_fa_font)
					var_0_0.Text(var_0_7.ICON_SORT_NUMERIC_DESC)
					var_0_0.PopFont()
					var_0_0.SameLine()
					var_0_0.Text(u8(" ���. ������: " .. tostring(math.floor(var_138_88)) .. " �."))
				end

				var_0_0.EndChild()

				if var_138_79 > 1000 and se.main.speedometr_size == 0 and cruise then
					var_0_0.PushFont(as.fonts.speedometr.main_fa_font)
					var_0_0.Text(var_0_7.ICON_TACHOMETER)
					var_0_0.PopFont()
					var_0_0.SameLine()
					var_0_0.Text(u8(" �����: " .. math.floor(cruiseSpeed * 2) .. " ��/�"))
				end

				if se.main.speedometr_size == 0 and as.autopilot.state == true then
					var_0_0.Separator()
					var_0_0.PushFont(as.fonts.speedometr.main_fa_font)
					var_0_0.Text(var_0_7.ICON_PLANE)
					var_0_0.PopFont()
					var_0_0.SameLine()
					var_0_0.Text(u8(" ��������� ������: " ..
					tostring(math.floor(as.autopilot.height)) ..
					"-" .. tostring(math.floor(as.autopilot.height + 10)) .. " �."))
				end

				var_0_0.PopFont()
				var_0_0.End()
			end

			var_0_0.PopStyleColor()
		end

		if im.windows.timings.v and sampGetGamestate() == 3 and not sampIsScoreboardOpen() and timings and not as.fastmap.fastmap_state and (isPlayerCop(cop, getCharModel(playerPed)) or isPlayerCop(fbi, getCharModel(playerPed)) or tostring(myfrac) == "4" or myName == "Serhiy_Rubin") then
			var_0_0.SetMouseCursor(-1)
			inform_timings()
		end

		if im.windows.squad.v and sampGetGamestate() == 3 and not sampIsScoreboardOpen() then
			var_0_0.SetMouseCursor(-1)
			squad_informer()
		end

		if im.windows.share_settings.v and sampGetGamestate() == 3 then
			share_settings()
		end

		if im.windows.accept_settings.v and sampGetGamestate() == 3 then
			accept_settings()
		end

		if im.windows.notes.v and sampGetGamestate() == 3 then
			notes_window()
		end

		if im.windows.notes_show.v and sampGetGamestate() == 3 then
			notes_show()
		end

		if im.windows.defuse.v and sampGetGamestate() == 3 then
			defuse_show()
		end

		if im.windows.aid.v and sampGetGamestate() == 3 then
			aid_show()
		end

		if im.windows.jrules.v and sampGetGamestate() == 3 then
			var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_138_0 / 2, var_138_1 / 2), var_0_0.Cond.FirstUseEver,
				var_0_0.ImVec2(0.5, 0.5))
			var_0_0.SetNextWindowSize(var_0_0.ImVec2(800, 600), var_0_0.Cond.FirstUseEver)
			var_0_0.Begin(u8("������ ������� ����"), im.windows.jrules, var_0_0.WindowFlags.NoResize)

			for iter_138_49 in jrules_text:gmatch("[^\r\n]+") do
				iter_138_49 = iter_138_49:gsub("%*%*%*%-%-%-%*%*%*", " ")

				var_0_0.Text(iter_138_49)
			end

			var_0_0.End()
		end

		if im.windows.hookchatinfo.v and sampGetGamestate() == 3 then
			var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_138_0 / 2, var_138_1 / 2), var_0_0.Cond.FirstUseEver,
				var_0_0.ImVec2(0.5, 0.5))
			var_0_0.SetNextWindowSize(var_0_0.ImVec2(800, 600), var_0_0.Cond.FirstUseEver)
			var_0_0.Begin(u8("���������� �� ���������� ����������"), im.windows.hookchatinfo,
				var_0_0.WindowFlags.NoResize)
			var_0_0.PushTextWrapPos()
			var_0_0.Text(u8(
			"���������� �� ���������� ���������\n\n���������� ��������� � ��� ����������� ���������� �������� ��� ������ � ��������� ������. �������� � ��� �������: �� ����������� ������ �����, ������� ��� �����, � ��������� ������� ��� ������ � ���� ������.\n\n���������� �����������, � � �������� �������� � �����.\n. -- ����� ������\n%a -- ����� (������ ����.!)\n%A -- ����� ����� (�������), ������, ��� �����, ����� ���������� �����\n%c -- ����������� ������\n%d -- �����\n%D -- ����� �����, ��� ������, ����� �����\n%l -- ����� � ������ ��������� (������ ����.!)\n%L -- ����� �����, ������, ��� �����, ����� ���������� ����� � ������ ���������\n%p -- ������ ����������\n%P -- ����� �����, ������, ��� �����, ����� ������� ����������\n%s -- ������ ������\n%S -- ����� �����, ������, ��� �����, ����� ������� �������\n%u -- ����� � ������� ��������� (������ ����.!)\n%U -- ����� �����, ������, ��� �����, ����� ���������� ����� � ������� ���������\n%w -- ����� �����, ��� ����� (������ ����.!)\n%W -- ����� ������, ��� ����� (�������), ����� ���������� �����, ��� �����\n%x -- ����������������� �����\n%X -- ����� �����, ��� ������, ����� �����, ��� ���������� �����, ������������ � ������ ������������������ �����\n%z -- ��������� ���������, ���������� ������� � ����� 0"))
			var_0_0.TextColoredRGB(
			"{FFFF00}�����! ���������� ������ ������ ����������� ������������ ��� ������ % (��������). � �������: %(�����%). � ��������� ������ ������ ����� ������ � �������!{FFFFFF}")
			var_0_0.Text(u8(
			"��� �� �������� �������. ��������� ������� ����� ����:\n\n� ��������� ���������� �����, ������� ������������� ������ ���������� ������� �� ��������� ������;\n� ��������� ���������� �����, �������������� '*', ��� ������������� 0 ��� �������� ���������� ���������� �������� �� ��������� ������. ��� �������� ���������� ����� ������ ��������������� ����� ������� ��������� ������������������.\n� ��������� ���������� �����, �������������� '+', ��� ������������� 1 ��� �������� ���������� ���������� �������� �� ��������� ������. ��� �������� ���������� ����� ������ ��������������� ����� ������� ��������� ������������������.\n� ��������� ���������� �����, �������������� '-', ��� ����� ������������� 0 ��� �������� ���������� ���������� �������� �� ��������� ������. � ������� �� *, �������� ���������� ����� ������ ��������������� ����� �������� ��������� ������������������\n� ��������� ���������� �����, �������������� '?', ��� ������������� 0 ��� ������������� ��������� ������� �� ��������� �����\n� ������, �������������� '^', ��� ������������� ������ ������."))
			var_0_0.Text(u8("\n������� ������ ������ � ����"))
			var_0_0.InputText(u8("����� SMS##hookex1"), im.other.hookchatex[1], var_0_0.InputTextFlags.ReadOnly)
			var_0_0.InputText(u8("����� ���������� � ������� Infernus##hookex2"), im.other.hookchatex[2],
				var_0_0.InputTextFlags.ReadOnly)
			var_0_0.InputText(u8("����� ���������� � ������� ����##hookex3"), im.other.hookchatex[2],
				var_0_0.InputTextFlags.ReadOnly)
			var_0_0.End()
		end

		if im.windows.markermanage.v and sampGetGamestate() == 3 then
			var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_138_0 / 2, var_138_1 / 2), var_0_0.Cond.FirstUseEver,
				var_0_0.ImVec2(0.5, 0.5))
			var_0_0.SetNextWindowSize(var_0_0.ImVec2(380, 0), var_0_0.Cond.FirstUseEver)
			var_0_0.Begin(u8("���������� ��������� Fastmap"), im.windows.markermanage, var_0_0.WindowFlags.NoResize)
			var_0_0.Text(u8("����� ������ �� ������ " ..
			(as.other.mapClicked.kv ~= nil and as.other.mapClicked.kv or "-")))
			var_0_0.InputText(u8("������� ��������?"), im.squad.new_marker_title)

			if var_0_0.Button(u8("��������"), var_138_2) then
				if not as.other.markerAddStatus then
					as.other.markerAddStatus = true

					local var_138_90 = {}
					local var_138_91, var_138_92 = sampGetCurrentServerAddress()
					local var_138_93, var_138_94 = sampGetPlayerIdByCharHandle(playerPed)
					local var_138_95, var_138_96, var_138_97 = getCharCoordinates(playerPed)
					local var_138_98 = sampGetPlayerNickname(var_138_94)

					var_138_90.info = {
						status = 7,
						sender = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))),
						title = u8:decode(im.squad.new_marker_title.v),
						x = as.other.mapClicked.x,
						y = as.other.mapClicked.y,
						kv = as.other.mapClicked.kv,
						server = tostring(var_138_91) .. ":" .. tostring(var_138_92)
					}

					local var_138_99 = {}

					var_138_99.data = ""
					var_138_99.headers = {
						["content-type"] = "application/x-www-form-urlencoded"
					}

					sequent_async_http_request("POST", _G.buy[144] .. "" .. encodeJson(var_138_90):gsub("%?", "%%3F"),
						var_138_99, function(arg_139_0)
						as.other.markerAddStatus = false
						info = decodeJson(arg_139_0.text)

						if info == nil then
							chat("������ ������������� �������, ���������� �������..")
						elseif info.result == 1 then
							am(u8:decode(info.answer))
						elseif info.result == "error" then
							if info.reason == 700 then
								sChat("�� �� ������ �������������, ���������� �������.")
							elseif info.reason == 701 then
								sChat("������ ������ �� ���� 701, �������� ������������.")
							elseif info.reason == 702 then
								sChat("��� ������ �� ������ �������������, ���������� �������.")
							end
						end
					end, function(arg_140_0)
						as.other.markerAddStatus = false
					end)
				else
					am("��������, ����������� ������..")
				end
			end

			for iter_138_50, iter_138_51 in pairs(as.textdraw.squaders) do
				if tostring(iter_138_50) == myName and iter_138_51.markers then
					var_0_0.BeginChild("left pane##markermanage", var_0_0.ImVec2(360, 150), true)
					var_0_0.Text(u8("���������� ���������:"))
					var_0_0.Separator()

					if iter_138_51.markers ~= nil then
						for iter_138_52, iter_138_53 in pairs(iter_138_51.markers) do
							var_0_0.Columns(2, _, false)
							var_0_0.SetColumnWidth(-1, 315)
							var_0_0.Text(u8((iter_138_53.title ~= "" and u8:decode(iter_138_53.title) or "��� ��������") ..
							" | ") .. iter_138_53.kv)
							var_0_0.NextColumn()
							var_0_0.SetColumnWidth(-1, 30)
							var_0_0.PushStyleColor(var_0_0.Col.Button, var_0_0.ImVec4(0.5, 0.1, 0.1, 1))

							if var_0_0.Button(var_0_7.ICON_TRASH_O .. "##" .. iter_138_52) then
								if not as.other.markerDellStatus then
									as.other.markerDellStatus = true

									local var_138_100 = {}
									local var_138_101, var_138_102 = sampGetCurrentServerAddress()
									local var_138_103, var_138_104 = sampGetPlayerIdByCharHandle(playerPed)
									local var_138_105, var_138_106, var_138_107 = getCharCoordinates(playerPed)
									local var_138_108 = sampGetPlayerNickname(var_138_104)

									var_138_100.info = {
										status = 8,
										sender = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))),
										delete_index = tostring(iter_138_52),
										server = tostring(var_138_101) .. ":" .. tostring(var_138_102)
									}

									local var_138_109 = {}

									var_138_109.data = ""
									var_138_109.headers = {
										["content-type"] = "application/x-www-form-urlencoded"
									}

									sequent_async_http_request("POST",
										_G.buy[144] .. "" .. encodeJson(var_138_100):gsub("%?", "%%3F"), var_138_109,
										function(arg_141_0)
											as.other.markerDellStatus = false
											info = decodeJson(arg_141_0.text)

											if info == nil then
												chat("������ ������������� �������, ���������� �������..")
											elseif info.result == 1 then
												am(u8:decode(info.answer))
											elseif info.result == "error" then
												if info.reason == 700 then
													sChat("�� �� ������ �������������, ���������� �������.")
												elseif info.reason == 701 then
													sChat("������ ������ �� ���� 701, �������� ������������.")
												elseif info.reason == 702 then
													sChat("��� ������ �� ������ �������������, ���������� �������.")
												elseif info.reason == 703 then
													am("������ �� ������!")
												end
											end
										end, function(arg_142_0)
										as.other.markerDellStatus = false
									end)
								else
									am("��������, ����������� ������..")
								end
							end

							var_0_0.PopStyleColor()
							var_0_0.Columns(1)
						end
					end

					var_0_0.EndChild()
				end
			end

			var_0_0.End()
		end

		if im.windows.allkeys.v and sampGetGamestate() == 3 then
			var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_138_0 / 2, var_138_1 / 2), var_0_0.Cond.FirstUseEver,
				var_0_0.ImVec2(0.5, 0.5))
			var_0_0.SetNextWindowSize(var_0_0.ImVec2(0, 600), var_0_0.Cond.FirstUseEver)
			var_0_0.Begin(u8("�������� ������ � ������ ��� �������"), im.windows.allkeys, var_0_0.WindowFlags.NoResize)

			for iter_138_54, iter_138_55 in pairs(allkeys) do
				if iter_138_54 ~= nil and iter_138_54 ~= "" then
					if var_0_0.Button(u8(iter_138_54)) then
						setClipboardText(iter_138_54)
						am("�������� ������� ����������� � ����� ������! ������� Ctrl+V (��������) � ���� ��� �����!")
					end

					var_0_0.SameLine()
					var_0_0.Text(u8(iter_138_55))
				end
			end

			var_0_0.End()
		end

		if im.windows.alltags.v and sampGetGamestate() == 3 then
			var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_138_0 / 2, var_138_1 / 2), var_0_0.Cond.FirstUseEver,
				var_0_0.ImVec2(0.5, 0.5))
			var_0_0.SetNextWindowSize(var_0_0.ImVec2(0, 600), var_0_0.Cond.FirstUseEver)
			var_0_0.Begin(u8("�������� ����� ��� ������"), im.windows.alltags, var_0_0.WindowFlags.NoResize)

			for iter_138_56, iter_138_57 in pairs(commandsText) do
				if iter_138_56 ~= nil and iter_138_56 ~= "" then
					if var_0_0.Button(u8(iter_138_56)) then
						setClipboardText(iter_138_56)
						am("��� ���������� � ����� ������! ������� Ctrl+V (��������) � ���� ��� �����!")
					end

					var_0_0.SameLine()
					var_0_0.Text(u8(iter_138_57))
				end
			end

			var_0_0.End()
		end

		if im.windows.allcommands.v and sampGetGamestate() == 3 then
			var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_138_0 / 2, var_138_1 / 2), var_0_0.Cond.FirstUseEver,
				var_0_0.ImVec2(0.5, 0.5))
			var_0_0.SetNextWindowSize(var_0_0.ImVec2(0, 600), var_0_0.Cond.FirstUseEver)
			var_0_0.Begin(u8("��� ������� �������"), im.windows.allcommands, var_0_0.WindowFlags.NoResize)

			for iter_138_58, iter_138_59 in pairs(allCommands) do
				var_0_0.Text(var_0_7.ICON_ARROW_CIRCLE_RIGHT .. u8(" " .. iter_138_59))
			end

			var_0_0.End()
		end

		if im.windows.deplog.v and sampGetGamestate() == 3 then
			var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_138_0 / 2, var_138_1 / 2), var_0_0.Cond.FirstUseEver,
				var_0_0.ImVec2(0.5, 0.5))
			var_0_0.SetNextWindowSize(var_0_0.ImVec2(800, 600), var_0_0.Cond.FirstUseEver)
			var_0_0.Begin(u8("���� ����� ������������"), im.windows.deplog)

			if not deplog_text then
				local var_138_110 = io.open(
				"moonloader/PD-Project/dep-log/logs-" .. os.date("!%d-%m-%Y", os.time() + 10800) .. ".txt", "r")

				if var_138_110 then
					deplog_text = var_138_110:read("*a")

					var_138_110:close()
				else
					deplog_text = ""
				end
			end

			for iter_138_60 in deplog_text:gmatch("[^\r\n]+") do
				var_0_0.Text(u8:encode(iter_138_60))
			end

			var_0_0.End()
		end

		if im.windows.clearwantedlog.v and sampGetGamestate() == 3 then
			var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_138_0 / 2, var_138_1 / 2), var_0_0.Cond.FirstUseEver,
				var_0_0.ImVec2(0.5, 0.5))
			var_0_0.SetNextWindowSize(var_0_0.ImVec2(800, 600), var_0_0.Cond.FirstUseEver)
			var_0_0.Begin(u8("���� ������ �������"), im.windows.clearwantedlog)

			if not clearwantedlog_text then
				local var_138_111 = io.open(
				"moonloader/PD-Project/clearwanted-log/logs-" .. os.date("!%d-%m-%Y", os.time() + 10800) .. ".txt", "r")

				if var_138_111 then
					clearwantedlog_text = var_138_111:read("*a")

					var_138_111:close()
				else
					clearwantedlog_text = ""
				end
			end

			for iter_138_61 in clearwantedlog_text:gmatch("[^\r\n]+") do
				var_0_0.Text(u8:encode(iter_138_61))
			end

			var_0_0.End()
		end

		if im.windows.smslogs.v and sampGetGamestate() == 3 then
			smslogs_show()
		end

		if im.windows.notepad.v and letsGame then
			notepad_show()
		end
	end
end

function var_0_0.VerticalSeparator()
	local var_143_0 = var_0_0.GetCursorScreenPos()

	var_0_0.GetWindowDrawList():AddLine(var_0_0.ImVec2(var_143_0.x, var_143_0.y),
		var_0_0.ImVec2(var_143_0.x, var_143_0.y + var_0_0.GetContentRegionMax().y),
		var_0_0.GetColorU32(var_0_0.GetStyle().Colors[var_0_0.Col.Separator]))
end

function comma_value(arg_144_0)
	local var_144_0 = arg_144_0

	repeat
		var_144_0, k = string.gsub(var_144_0, "^(-?%d+)(%d%d%d)", "%1,%2")
	until k == 0

	return var_144_0
end

function nbround(arg_145_0, arg_145_1)
	if arg_145_1 then
		return math.floor(arg_145_0 * 10 ^ arg_145_1 + 0.5) / 10 ^ arg_145_1
	else
		return math.floor(arg_145_0 + 0.5)
	end
end

function number_format(arg_146_0, arg_146_1, arg_146_2, arg_146_3)
	local var_146_0
	local var_146_1
	local var_146_2
	local var_146_3

	arg_146_1 = arg_146_1 or 2
	arg_146_3 = arg_146_3 or "-"

	local var_146_4 = math.abs(round(arg_146_0, arg_146_1))
	local var_146_5 = math.floor(var_146_4)
	local var_146_6 = nbround(math.abs(arg_146_0) - var_146_5, arg_146_1)
	local var_146_7 = comma_value(var_146_5)

	if arg_146_1 > 0 then
		local var_146_8 = string.sub(tostring(var_146_6), 3)

		var_146_7 = var_146_7 .. "." .. var_146_8 .. string.rep("0", arg_146_1 - string.len(var_146_8))
	end

	local var_146_9 = (arg_146_2 or "") .. var_146_7

	if arg_146_0 < 0 then
		if arg_146_3 == "()" then
			var_146_9 = "(" .. var_146_9 .. ")"
		else
			var_146_9 = arg_146_3 .. var_146_9
		end
	end

	return var_146_9
end

function sirenColor()
	while true do
		wait(0)

		while not im.windows.speedometr.v or not isCharInAnyCar(playerPed) do
			wait(0)
		end

		as.other.speedsiren.r = 1

		local var_147_0 = 0

		while var_147_0 < 255 do
			wait(0)

			as.other.speedsiren.g = number_format(var_147_0 / 255, 2)
			as.other.speedsiren.b = number_format(var_147_0 / 255, 2)
			var_147_0 = var_147_0 + 20
		end

		as.other.speedsiren.b = 1

		local var_147_1 = 0

		while var_147_1 < 255 do
			wait(0)

			as.other.speedsiren.r = number_format((255 - var_147_1) / 255, 2)
			as.other.speedsiren.g = number_format((255 - var_147_1) / 255, 2)
			var_147_1 = var_147_1 + 20
		end

		as.other.speedsiren.b = 1

		local var_147_2 = 0

		while var_147_2 < 255 do
			wait(0)

			as.other.speedsiren.r = number_format(var_147_2 / 255, 2)
			as.other.speedsiren.g = number_format(var_147_2 / 255, 2)
			var_147_2 = var_147_2 + 20
		end

		as.other.speedsiren.r = 1

		local var_147_3 = 0

		while var_147_3 < 255 do
			wait(0)

			as.other.speedsiren.g = number_format((255 - var_147_3) / 255, 2)
			as.other.speedsiren.b = number_format((255 - var_147_3) / 255, 2)
			var_147_3 = var_147_3 + 20
		end
	end
end

function dateToSec(arg_148_0)
	local var_148_0, var_148_1, var_148_2 = arg_148_0:match("(%d%d)%-(%d%d)%-(%d%d%d%d)")

	if var_148_0 and var_148_1 and var_148_2 then
		return os.time({
			year = var_148_2,
			month = var_148_1,
			day = var_148_0
		})
	end

	return arg_148_0
end

function smslogs_show()
	var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_0_94 / 2, var_0_95 / 2), var_0_0.Cond.FirstUseEver,
		var_0_0.ImVec2(0.5, 0.5))
	var_0_0.SetNextWindowSize(var_0_0.ImVec2(730, 600), var_0_0.Cond.FirstUseEver)
	var_0_0.Begin(u8("���� SMS"), im.windows.smslogs, var_0_0.WindowFlags.NoResize)
	var_0_0.BeginChild("left pane##smslogs", var_0_0.ImVec2(100, 0), true)

	if var_0_0.Button(u8("��������"), var_0_96) then
		getSmsLog()
	end

	var_0_0.Separator()

	if smslogs then
		for iter_149_0, iter_149_1 in pairs(smslogs) do
			if smslogs_tab ~= nil and smslogs_tab == iter_149_1.filename then
				var_0_0.PushStyleColor(var_0_0.Col.Button, var_0_0.ImVec4(0.26, 0.59, 0.98, 0.7))

				if var_0_0.Button(iter_149_1.filename, var_0_96) then
					smslogs_tab, smslogs_name = iter_149_1.filename
				end

				var_0_0.PopStyleColor()
			elseif var_0_0.Button(iter_149_1.filename, var_0_96) then
				smslogs_tab, smslogs_name = iter_149_1.filename
			end
		end
	else
		var_0_0.Text(u8("���� �����"))
	end

	var_0_0.EndChild()
	var_0_0.SameLine()

	if smslogs and smslogs_tab ~= nil then
		var_0_0.BeginChild("left pane##smslogs_names", var_0_0.ImVec2(140, 0), true)

		for iter_149_2, iter_149_3 in pairs(smslogs) do
			if iter_149_3.filename == smslogs_tab then
				as.other.smslogsnames = {}

				for iter_149_4 in iter_149_3.data:gmatch("[^\r\n]+") do
					local var_149_0 = iter_149_4:match("�����������%: (.+)%[")
					local var_149_1 = iter_149_4:match("����������%: (.+)%[")
					local var_149_2 = ""

					if var_149_0 ~= nil or var_149_1 ~= nil then
						if var_149_0 then
							var_149_2 = var_149_0
						elseif var_149_1 then
							var_149_2 = var_149_1
						end

						if var_149_2 ~= myName then
							if not as.other.smslogsnames[var_149_2] then
								if smslogs_name and smslogs_name == var_149_2 then
									var_0_0.PushStyleColor(var_0_0.Col.Button, var_0_0.ImVec4(0.26, 0.59, 0.98, 0.7))

									if var_0_0.Button(var_149_2, var_0_96) then
										smslogs_name = var_149_2
									end

									var_0_0.PopStyleColor()
								elseif var_0_0.Button(var_149_2, var_0_96) then
									smslogs_name = var_149_2
								end
							end

							as.other.smslogsnames[var_149_2] = true
						end
					end
				end
			end
		end

		var_0_0.EndChild()
		var_0_0.SameLine()
	end

	var_0_0.BeginChild("left pane##smslogswindow", var_0_0.ImVec2(0, 0), true, var_0_0.WindowFlags.HorizontalScrollbar)

	if smslogs and smslogs_tab ~= nil and smslogs_name ~= nil then
		for iter_149_5, iter_149_6 in pairs(smslogs) do
			if iter_149_6.filename == smslogs_tab then
				var_0_0.Text(u8("���� SMS � " .. smslogs_name .. " �� " .. iter_149_6.filename))
				var_0_0.Separator()

				for iter_149_7 in iter_149_6.data:gmatch("[^\r\n]+") do
					if iter_149_7:find("�����������%:.*" .. smslogs_name) then
						local var_149_3 = iter_149_7:match("(.*)�����������%: " .. smslogs_name):gsub(" SMS:", "<<- |")

						var_0_0.Text(u8(var_149_3))
					elseif iter_149_7:find("����������%:.*" .. smslogs_name) then
						local var_149_4 = iter_149_7:match("(.*)����������%: " .. smslogs_name):gsub(" SMS:", "->> |")

						var_0_0.Text(u8(var_149_4))
					end
				end
			end
		end
	else
		var_0_0.Text(u8("���� �����, ������� �������� �� SMS, ����� ������ ������������."))
	end

	var_0_0.EndChild()
	var_0_0.End()
end

function notepad_show()
	var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_0_94 * 0.25, var_0_95 / 2), var_0_0.Cond.FirstUseEver,
		var_0_0.ImVec2(0.5, 0.5))
	var_0_0.SetNextWindowSize(var_0_0.ImVec2(315, 300), var_0_0.Cond.FirstUseEver)
	var_0_0.Begin(u8("������ �������"), im.windows.notepad)
	var_0_0.BeginChild("left pane##notepadwindow", var_0_0.ImVec2(0, 0), true)

	if var_0_0.Button(var_0_7.ICON_FLOPPY_O .. u8(" ��������� �������")) then
		as.notepad.file = io.open("moonloader/PD-Project/notepad.karimoff", "w+")

		if as.notepad.file then
			as.notepad.file:write(im.other.notepad.v)
			as.notepad.file:close()
		end
	end

	var_0_0.SameLine()

	if var_0_0.Button(var_0_7.ICON_TRASH_O .. u8(" ������� ��� ������")) then
		os.remove("moonloader/PD-Project/notepad.karimoff")

		im.other.notepad.v = ""
	end

	var_0_0.EndChild()
	var_0_0.BeginChild("left pane##notepadwindow", var_0_0.ImVec2(0, 0), true)

	if not as.notepad.data then
		as.notepad.file = io.open("moonloader/PD-Project/notepad.karimoff", "a+")

		if as.notepad.file then
			as.notepad.data = as.notepad.file:read("*a")
			im.other.notepad.v = as.notepad.data

			as.notepad.file:close()
		end
	end

	var_0_0.InputTextMultiline("##notepadtext", im.other.notepad, var_0_0.ImVec2(-1, -1))
	var_0_0.EndChild()
	var_0_0.End()
end

function getChatRules()
	jrules_text = ""

	local var_151_0 = {
		data = "s=" ..
		select(1, sampGetCurrentServerAddress()) ..
		":" ..
		select(2, sampGetCurrentServerAddress()) ..
		"&n=" .. sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))),
		headers = {
			["content-type"] = "application/x-www-form-urlencoded"
		}
	}

	sequent_async_http_request("POST", "https://pdp-samp.online/config/jrules.php", var_151_0, function(arg_152_0)
		if arg_152_0.text:find("PD%-Project") then
			jrules_text = arg_152_0.text
		end
	end, function(arg_153_0)
		print(arg_153_0)
	end)
end

function selectedFastMapOrSquad()
	var_0_0.Separator()
	var_0_0.Image(var_0_15.settings_fastmap, var_0_0.ImVec2(715, 80))
	var_0_0.BeginChild("left pane##4", var_0_0.ImVec2(712, 0), true)
	var_0_0.Text(var_0_7.ICON_MAP_O .. u8(" ��������� Fastmap:\n"))
	var_0_0.Separator()
	var_0_0.Columns(2, _, false)
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text((se.main.fastmap == true and var_0_7.ICON_CHECK_CIRCLE_O or var_0_7.ICON_CIRCLE_O) ..
	u8(" Fastmap " .. (se.main.fastmap == true and "�������" or "��������")))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("Fastmap"), im.settings.fastmap)

	se.main.fastmap = im.settings.fastmap.v

	var_0_0.SameLine()
	showHelp(u8(
	"���������� ����������� ������� ��������� ����� �� �������. ���������� ����� �������� ���� ��� �� ������� \"+\" (����) � \"-\" (�����). ����������� �� ����������� ����� � ������� ������� ������� ������� ���� ��� ����������� �����, ������, ���� � �����. �������� ������ �� ����� - ���� ��� ������� �� ������ ������ ����. ���������� ������ �� ����� - ���� ��� �� ����� ������ ����. �������� ����� �� ����� ��������� ������������� - ��� ���� �� ���� ����� ����� ������� ����."))

	if se.main.fastmap then
		var_0_0.AlignTextToFramePadding()
		var_0_0.Text((se.main.fastmap_start == true and var_0_7.ICON_CHECK_CIRCLE_O or var_0_7.ICON_CIRCLE_O) ..
		u8(" ���������� FastMap ��� ������� �������"))
		var_0_0.SameLine()
		var_0_0.ToggleButton(u8("���������� FastMap ��� ������� �������"), im.settings.fastmap_start)

		se.main.fastmap_start = im.settings.fastmap_start.v

		var_0_0.SameLine()
		showHelp(u8(
		"���������� FastMap ��� ������� ������� � ��� � ����������� ����� �������� ���������� ��� ������ ������� FastMap."))
	end

	var_0_0.AlignTextToFramePadding()
	var_0_0.Text((se.fastmap.showMark == true and var_0_7.ICON_CHECK_CIRCLE_O or var_0_7.ICON_CIRCLE_O) ..
	u8(" �������� ���������� ��������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("�������� ���������� ��������"), im.fastmap.showMark)

	se.fastmap.showMark = im.fastmap.showMark.v

	var_0_0.SameLine()
	showHelp(u8(
	"������� �� ����� ���������� �������, ������� ����������� �������� /mrk ��� � �������� ���������� �������."))
	var_0_0.NextColumn()
	var_0_0.PushItemWidth(100)
	var_0_0.InputText(u8("������� FastMap"), im.keys.keyFastMap)

	se.keys.fastmap = im.keys.keyFastMap.v

	var_0_0.PopItemWidth()
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text((se.fastmap.showNick == true and var_0_7.ICON_CHECK_CIRCLE_O or var_0_7.ICON_CIRCLE_O) ..
	u8(" �������� ���� �������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("�������� ���� �������"), im.fastmap.showNick)

	se.fastmap.showNick = im.fastmap.showNick.v

	if se.fastmap.showNick then
		var_0_0.AlignTextToFramePadding()
		var_0_0.Text(var_0_7.ICON_COG ..
		u8(" ������ ����: " .. (se.fastmap.showNickFull == true and "������ ���" or "��������")))
		var_0_0.SameLine()
		var_0_0.ToggleButton(u8("������ ����"), im.fastmap.showNickFull)

		se.fastmap.showNickFull = im.fastmap.showNickFull.v
	end

	var_0_0.Columns(1)
	var_0_0.Separator()
	var_0_0.Text(var_0_7.ICON_USERS .. u8(" ��������� ����������������� SQUAD � ��������������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������������� SQUAD � ��������������"), im.windows.squad)

	se.squad.state = im.windows.squad.v

	var_0_0.Separator()
	var_0_0.Columns(2, _, false)
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text((im.squad.ha.v and var_0_7.ICON_EYE or var_0_7.ICON_EYE_SLASH) .. u8(" ���������� �� � �����"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� �� � �����"), im.squad.ha)

	se.squad.ha = im.squad.ha.v

	var_0_0.SameLine()
	showHelp(u8(
	"�������� ���� �� � ����� � ������ SQUAD. �� ������, ���� �� ��������� ������ �������, �� ����� � �� �� ������ ������ �� � ����� ������ �������."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text((im.squad.sector.v and var_0_7.ICON_EYE or var_0_7.ICON_EYE_SLASH) .. u8(" ���������� ������� �������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� ������� �������"), im.squad.sector)

	se.squad.sector = im.squad.sector.v

	var_0_0.SameLine()
	showHelp(u8(
	"�������� ��� ������� ������� � ������ ������� SQUAD, �� ������, ��� �������� ������ �������, �� �� ������ ������ ������� ������� ������ �������."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text((im.squad.afk.v and var_0_7.ICON_EYE or var_0_7.ICON_EYE_SLASH) .. u8(" ���������� AFK"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� AFK"), im.squad.afk)

	se.squad.afk = im.squad.afk.v

	var_0_0.SameLine()
	showHelp(u8("������� ���������� �� AFK ������� � ������ SQUAD."))
	var_0_0.SliderInt("##squad_size", im.squad.size, 8, 24,
		var_0_7.ICON_TEXT_HEIGHT .. u8(" ������ ������: ") .. im.squad.size.v)

	if var_0_0.Button(u8("��������� �����"), var_0_96) then
		se.squad.size = im.squad.size.v

		save_settings()
		chat("����� ��������. ������� ��������������, ����� ��������� �������� � ����.")
		thisScript():reload()
	end

	var_0_0.NextColumn()
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text((im.squad.clist.v and var_0_7.ICON_EYE or var_0_7.ICON_EYE_SLASH) .. u8(" ���������� ���� clist"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� ���� clist"), im.squad.clist)

	se.squad.clist = im.squad.clist.v

	var_0_0.SameLine()
	showHelp(u8(
	"�������� ��� ������� ���� ���� (/clist), �� ������, ��� �������� ������ �������, �� �� ������ ������ ������� ���� ���� ������ �������."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text((im.squad.position.v and var_0_7.ICON_EYE or var_0_7.ICON_EYE_SLASH) .. u8(" ���������� ��������������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� ��������������"), im.squad.position)

	se.squad.position = im.squad.position.v

	var_0_0.SameLine()
	showHelp(u8(
	"���� ������ ������� ���������, �� �� ����� ���������� ���� �������������� � FastMap ��� ����� ������������. ����� � �� �� ������ ������ �������������� ������������ � FastMap."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text((im.squad.show_marker_notify.v and var_0_7.ICON_EYE or var_0_7.ICON_EYE_SLASH) ..
	u8(" ���������� ����������� �� ������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� ����������� �� ������"), im.squad.show_marker_notify)

	se.squad.show_marker_notify = im.squad.show_marker_notify.v

	var_0_0.SameLine()
	showHelp(u8(
	"������� � ��� �����������, ����� ���-�� �� ���, ��� ������� � SQUAD, ��������� ����� �� ����� PD-Project (������� ������� ��� �� ����� FASTMAP)."))

	if var_0_0.Button(u8("�������� ���������##squad"), var_0_96) then
		chat("�������� ������� ������������ ���� � ������� ENTER ��� ����������.")

		var_0_42.v = false
		as.textdraw.squad_changepos = true
	end

	var_0_0.Columns(1)
	var_0_0.EndChild()
end

function blockedFuncs()
	var_0_0.Separator()
	var_0_0.Image(var_0_15.settings_info, var_0_0.ImVec2(715, 80))
	var_0_0.BeginChild("left pane##zapr", var_0_0.ImVec2(0, 0), true)
	var_0_0.Text(var_0_7.ICON_COG .. u8(" �������� ��������� ����:\n"))
	var_0_0.Separator()
	var_0_0.PushTextWrapPos()
	var_0_0.Text(u8(
	"� ������ ��� �������� ��������� �������, ������� ����� ���� ��������� ��������� ��������. ����������� ������������ � ������ ������� ����� ���, ��� ������������ ��������� �������."))
	var_0_0.PushTextWrapPos()
	var_0_0.Text(u8(
	"�� ������������� ���� ������� ��� ������� ����� ���� ������������ �������������� �������. �� ����������� ��, ���� �� �� ������ ����� ���������������. ����������� �� ����� ��������������� �� ���� �������� � ��������� ����� ��������. ���� �� ������������ � �����-�� �������� �������, �������� ���������������, ������� � ���: ��������� ��� ���; ����� �� ���� � ���������� ������� ����������."))
	var_0_0.PushTextWrapPos()
	var_0_0.Text(u8(
	"�������������� ���� ����������������. ���� �� �� ������ ������������ ����������� �������, ���������� �� ����������� �� �� ����� �������� ������������� �� ������ � ��� ����� �� ������������ ���������/�����������, ��� ����� �������� ������������� ����������� �������."))
	var_0_0.PushTextWrapPos()
	var_0_0.Text(u8(
	"\n� �������� /ps �� ����� ������, ����� �� �� ������ ID ������ - �������� ���������� ������ �������. ����������� /ps � ������� ������� ������ ����� �� ������ ID ������ ��� ��� �������.\n\n� �������������� ������. ����� �� ��� ��������, �� ������ ���������� ���������: ��� �� ��� �������� � ��� ��� ������������ ������ ��� clist'a. ���� ���� ������ � �� ��� ���� ����� - �� �� ����� �������� � ������, ���� ��� ��������� ��������� �������. � ������ ������� �� ����������, ����� �� �� ������ ID ������ ��� ��� ������� ���� ����� ���� ��������� ��������� �������.\n\n� ������� ������ ���: ��������� ����������� � ���� ����� ��� ���������� � ���� ���������, ��������� ������� ����� ��� ������� ��� �� �� �����, ��� � ��, ��������� ��� ������ ��� �������� ����� ��� �������. �� ����������� ��, ���� �� ������ �������� ���������� �������� ��������. ���� �� �� �����������, ������ �� ���������� ��� ����, ��� �� ������ �������� ������� ��-�� ���������� ������� �������������� �������.\n\n� �� 01.09.2021 �� ������� Revolution ��������� ������� ������ ������� ����� (�������) ������������� ������ �� ��������� Pursuit Mod.\n\n� ��� �������� ������� \"��������� ���������\", ����� �������������� �������� � ������������� �������� �������.\n\n� ��� �������� ����� ���������� �����������. ��� ����� ���� ��������� ��������� ��������. �������� � ������������� ����� ��������������.\n\n��������! ������ ������ �� ����������� �������������! ������������������� � ������������� ������� ��� �� �������!\n\t\t"))
	var_0_0.EndChild()
end

function isTableEmpty(arg_156_0)
	local var_156_0 = true

	if arg_156_0 then
		for iter_156_0, iter_156_1 in pairs(arg_156_0) do
			if iter_156_0 ~= nil and iter_156_1 ~= nil then
				return false
			end
		end
	end

	return key
end

function selectedTickets()
	var_0_0.Separator()
	var_0_0.Image(var_0_15.settings_ticketsystem, var_0_0.ImVec2(715, 80))
	var_0_0.BeginChild("left pane###patick", var_0_0.ImVec2(0, 0), true)
	var_0_0.Text(var_0_7.ICON_COG .. u8(" ������� �������"))
	var_0_0.SameLine()
	showHelp(u8("����� �� ������ ���������� ������ ��� ����������� �������."))
	var_0_0.SameLine()
	var_0_0.SetCursorPos(var_0_0.ImVec2(358, 3))

	if var_0_0.Button(u8("�������� ������##tick")) then
		addTick = not addTick
	end

	var_0_0.SameLine()

	if var_0_0.Button(u8("��������� ���������##tick")) then
		saveTick()
	end

	var_0_0.SameLine()

	if var_0_0.Button(u8("������� ���##tick")) then
		deleteAllTick()
	end

	if addTick then
		var_0_0.Separator()
		var_0_0.BeginChild("left pane###addtick", var_0_0.ImVec2(690, 230), true)
		var_0_0.PushItemWidth(410)
		var_0_0.InputText(u8("������� ����� ������"), cov.addNumTick)
		var_0_0.SameLine()
		showHelp(u8("� �������: 1. ������ �� ������� ����� �����."))
		var_0_0.InputText(u8("������� �������� ������"), cov.addNameTick)
		var_0_0.SameLine()
		showHelp(u8("� �������: ��������� �������"))
		var_0_0.InputTextMultiline(u8("������� ���� �� �������� � ����� ������"), cov.addAmountTick)
		var_0_0.SameLine()
		showHelp(u8(
		"����� ���������� ������ ������� ������ � ����� ������. ����� ������� ���� �������, � ����� ��������. � �������: \"1-2 500\" - ����� ��������, ��� ��� ������� ������� 1 � 2 ����� ������ ����� 500 ����. \"3-5 2000\" - ����� �������� ��� ��, ��� ��� ������� 3, 4, 5 ����� ����������� ����� ������ 2000 ����. � ���� \"15+ 15000\" - �� ��� ������� ������� 15 � ���� ����� ����������� ����� 15000 ����. � ���� ���������� \"45 45000\" - �� ��� ������ �������� ������ 45 ����� ����������� ����� ������ 45000 �."))

		if var_0_0.Button(u8("�������� ������##tick"), var_0_96) then
			tickwarn = false

			if cov.addNumTick.v:len() > 0 and cov.addNameTick.v:len() > 0 and cov.addAmountTick.v:len() > 0 then
				if cov.addNumTick.v:find("%d+") then
					if cov.addNumTick.v:find("%d+%.%d+") then
						cov.addNumTick.v = cov.addNumTick.v:match("(%d+%.%d+)")
					else
						cov.addNumTick.v = cov.addNumTick.v:match("(%d+)")
					end

					if alltickets[getSrv()][tostring(cov.addNumTick.v)] then
						am("������ � ��������� ������� ��� �������.")
					else
						local var_157_0 = {}

						for iter_157_0 in cov.addAmountTick.v:gmatch("[^\r\n]+") do
							if iter_157_0:find("%d+%-%d+%s%{lvl%}%*%d+") or iter_157_0:find("%d+%s%d+") or iter_157_0:find("%d+%-%d+%s%d+") or iter_157_0:find("%d+%+%s%d+") then
								if iter_157_0:find("%d+%-%d+%s%{lvl%}%*%d+") then
									local var_157_1, var_157_2, var_157_3 = iter_157_0:match(
									"(%d+)%-(%d+)%s%{lvl%}%*(%d+)")

									if var_157_1 and var_157_2 and var_157_3 then
										local var_157_4 = tonumber(var_157_1)
										local var_157_5 = tonumber(var_157_2)

										for iter_157_1 = var_157_4, var_157_5 do
											var_157_0[tostring(iter_157_1)] = iter_157_1 * var_157_3
										end
									else
										am(
										"������ ���-�� ������. ������: 1-50 {lvl}*500 (������ ������ ����, � ������� ��� ��������!")
									end
								else
									local var_157_6, var_157_7 = iter_157_0:match("(.*)%s(%d+)")

									if var_157_6 and var_157_7 then
										var_157_0[var_157_6] = var_157_7
									end
								end
							else
								tickwarn = true
							end
						end

						if tickwarn then
							am(
							"�������� ������ ���. ������ ���� ���������� � ����� ������. �������� LVL ����� ��������� ��������: ��� ���� LVL (������: 1 ��� 2 ��� 3), ��� �������� LVL (������: 1-2 ��� 3-5 ��� 6-10), ��� �� ������-�� LVL � ���� (������: 25+).\n������ ���������:\n1-2 500\n3-5 2500\n6-10 5000\n11-15 10000\n16+ 15000")
						else
							alltickets[getSrv()][tostring(cov.addNumTick.v)] = {
								cov.addNumTick.v,
								u8:decode(cov.addNameTick.v),
								var_157_0
							}

							saveTick()

							cov.addNumTick.v, cov.addNameTick.v, cov.addAmountTick.v = "", "", ""

							am("������ ���������.")
						end
					end
				else
					am("����� ������ ������ ��������� ������ �������� �������� ��� ������ ��������.")
				end
			else
				am("������ ��� ���� ����������� ��� ����������.")
			end
		end

		if var_0_0.Button(u8("������� ���� ���������� ������##tick"), var_0_96) then
			addTick = false
		end

		var_0_0.EndChild()
	end

	var_0_0.Separator()
	var_0_0.Columns(3, _, false)
	var_0_0.SetColumnWidth(-1, 100)
	var_0_0.Text(u8("������ �"))
	var_0_0.NextColumn()
	var_0_0.SetColumnWidth(-1, 560)
	var_0_0.Text(u8("�������� ������"))
	var_0_0.NextColumn()
	var_0_0.SetColumnWidth(-1, 30)
	var_0_0.Columns(1)
	var_0_0.Separator()
	var_0_0.Columns(3, _, false)
	var_0_0.SetColumnWidth(-1, 100)

	for iter_157_2, iter_157_3 in pairs(ticknu) do
		var_0_0.PushItemWidth(100)
		var_0_0.InputText("##" .. iter_157_2 .. tostring(iter_157_3), ticknu[iter_157_2])
	end

	var_0_0.NextColumn()
	var_0_0.SetColumnWidth(-1, 560)

	for iter_157_4, iter_157_5 in pairs(tickna) do
		var_0_0.PushItemWidth(560)
		var_0_0.InputText("##" .. iter_157_4 .. tostring(iter_157_5), tickna[iter_157_4])
	end

	var_0_0.NextColumn()
	var_0_0.SetColumnWidth(-1, 30)

	for iter_157_6, iter_157_7 in pairs(ticknu) do
		if var_0_0.Button(var_0_7.ICON_TIMES .. "##" .. iter_157_6 .. tostring(iter_157_7)) and ticknu and ticknu[iter_157_6] then
			deleteTick(iter_157_6)
		end
	end

	var_0_0.Columns(1)
	var_0_0.EndChild()
end

function selectedDispatch()
	var_0_0.Separator()
	var_0_0.Image(var_0_15.settings_sounds, var_0_0.ImVec2(715, 80))
	var_0_0.BeginChild("left pane##6", var_0_0.ImVec2(0, 0), true)
	var_0_0.Text(var_0_7.ICON_COG .. u8(" ��������� ����������:\n"))
	var_0_0.Separator()
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_EYE_SLASH .. u8(" ������ ���������� �� ���������� �����"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("������ ���������� �� ���������� �����"), im.dispatch.houses)

	se.dispatch.houses = im.dispatch.houses.v

	var_0_0.SameLine()
	showHelp(u8(
	"��� ���������� � ���� �� ���������� ������������� ����, ��������� �������� �������������� ���� � ��� �������������. ��� ���������� �������� �� ������� /rh."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_EYE_SLASH .. u8(" ������ ���������� �� ����������� � ���-�������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("������ ���������� �� ����������� � ���-�������"), im.dispatch.gang_ls)

	se.dispatch.gang_ls = im.dispatch.gang_ls.v

	var_0_0.SameLine()
	showHelp(u8(
	"�� ����� ���������� ��������� 24-7 � ������� � ��������� ������, ��������� ������� �����, ������ � �������� ���������."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_EYE_SLASH .. u8(" ������ ���������� �� ����������� � ���-������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("������ ���������� �� ����������� � ���-������"), im.dispatch.gang_sf)

	se.dispatch.gang_sf = im.dispatch.gang_sf.v

	var_0_0.SameLine()
	showHelp(u8(
	"�� ����� ���������� ��������� 24-7 � ������� � ��������� ������, ��������� ������� �����, ������ � �������� ���������."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_EYE_SLASH .. u8(" ������ ���������� �� ����������� � ���-���������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("������ ���������� �� ����������� � ���-���������"), im.dispatch.gang_lv)

	se.dispatch.gang_lv = im.dispatch.gang_lv.v

	var_0_0.SameLine()
	showHelp(u8(
	"�� ����� ���������� ��������� 24-7 � ������� � ��������� ������, ��������� ������� �����, ������ � �������� ���������."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_EYE_SLASH .. u8(" ������ �� ����� �� ����� ����������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("������ �� ����� �� ����� ����������"), im.dispatch.marker)

	se.dispatch.marker = im.dispatch.marker.v

	var_0_0.SameLine()
	showHelp(u8("�� ����� ���������� ��������� 24-7 � ������� ������ ������ �� �����."))
	var_0_0.Separator()
	var_0_0.Text(var_0_7.ICON_COG .. u8(" ��������� ����� � �������:\n"))
	var_0_0.Separator()
	var_0_0.Columns(2, _, false)
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_MUSIC .. u8(" ����� ���������� � ������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("����� ���������� � ������"), im.radio.radio_copcar)

	se.radio.radio_copcar = im.radio.radio_copcar.v

	var_0_0.SameLine()
	showHelp(u8(
	"����� ������ � ����������� ������ ��� � ������, ��������������� �������� ����� ����������� ������� ���."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_MUSIC .. u8(" ������� ������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("������� ������"), im.sounds.taser)

	se.sounds.taser = im.sounds.taser.v

	var_0_0.SameLine()
	showHelp(u8("� ������ �������� �� ����� � ������� ����� ������������� ���� ������."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_MUSIC .. u8(" ������� ������� 9-1-1"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("������� ������� 9-1-1"), im.sounds.s911)

	se.sounds.s911 = im.sounds.s911.v

	var_0_0.SameLine()
	showHelp(u8("������� ���������� ������ � 9-1-1."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_MUSIC .. u8(" ���� ����������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���� ����������"), im.sounds.tighten)

	se.sounds.tighten = im.sounds.tighten.v

	var_0_0.SameLine()
	showHelp(u8("� ������ ������������ ���������� ��������������� ����."))
	var_0_0.NextColumn()
	var_0_0.SliderInt("##radio_copcar_v", im.radio.radio_copcar_v, 1, 10,
		var_0_7.ICON_VOLUME_UP .. u8(" ��������� ����� �����������: ") .. im.radio.radio_copcar_v.v)

	se.radio.radio_copcar_v = im.radio.radio_copcar_v.v

	var_0_0.SliderInt("##sounds_volume_v", im.sounds.volume, 1, 10,
		var_0_7.ICON_VOLUME_UP .. u8(" ��������� ������ � �������: ") .. im.sounds.volume.v)

	se.sounds.volume = im.sounds.volume.v

	var_0_0.Columns(1)
	var_0_0.EndChild()
end

function selectedRhi()
	var_0_0.Separator()
	var_0_0.Image(var_0_15.settings_changeranks, var_0_0.ImVec2(715, 80))
	var_0_0.Separator()
	var_0_0.BeginChild("left pane###rhi", var_0_0.ImVec2(0, 0), true)
	var_0_0.Text(var_0_7.ICON_COG .. u8(" ������ ������ ��� �����������"))
	var_0_0.SameLine()
	showHelp(u8("����� �� ������ ���������� ������ ����������� ������ ������� ��� ����������� � ������� ������� /rhi."))
	var_0_0.SameLine()
	var_0_0.SetCursorPos(var_0_0.ImVec2(370, 3))

	if var_0_0.Button(u8("�������� ������##rhi")) then
		addRangRhi = not addRangRhi
	end

	var_0_0.SameLine()

	if var_0_0.Button(u8("������� ���##rhi")) then
		rhiData = {}

		saveRhi()
	end

	var_0_0.SameLine()

	if var_0_0.Button(u8("��������� ���������##rhi")) then
		saveRhi()
	end

	if addRangRhi then
		local var_159_0 = 150
		local var_159_1 = slc.v == 1 and 190 or 150

		var_0_0.BeginChild("left pane###addrangrhi", var_0_0.ImVec2(690, tonumber(var_159_1)), true)
		var_0_0.Text((chRang ~= "" and var_0_7.ICON_CHECK_SQUARE_O or var_0_7.ICON_MINUS_SQUARE_O) ..
		u8(" ���������� ����: ") ..
		(chRang ~= "" and chRang or u8:decode(chRang) == "�������� ����" and u8("-- �� ������ --") or u8("-- �� ������ --")))

		if slc.v ~= 0 and slc.v == 1 then
			var_0_0.Text(var_0_7.ICON_USER_O .. u8(" ��� ������, ��� ������ ���������� ��������: ") .. im.other.chName.v)
		end

		var_0_0.Text((var_0_54.v ~= "" and var_0_7.ICON_CHECK_SQUARE_O or var_0_7.ICON_MINUS_SQUARE_O) ..
		u8(" ����� ����: ") .. (var_0_54.v ~= "" and trim(var_0_54.v) or u8("-- �� ������ --")))
		var_0_0.PushItemWidth(410)

		if var_0_0.Combo(u8("�������� ����"), slc, originalChangeRang) then
			chRang = originalChangeRang[slc.v]
			idRang = slc.v
		end

		if slc.v ~= 0 and slc.v == 1 then
			var_0_0.InputText(u8("��� ������"), im.other.chName)
		end

		var_0_0.SameLine()
		showHelp(u8("������� ��� ������ � ������� Nick_Name, ��� ������ ����� ���������� � /rhi �������������."))
		var_0_0.InputText(u8("����� ����"), var_0_54)
		var_0_0.TextColoredRGB(chmess)

		if var_0_0.Button(u8("�������� ����##rhi"), var_0_96) then
			chmess = ""

			local var_159_2 = u8:decode(chRang)
			local var_159_3 = trim(u8:decode(var_0_54.v))

			if chRang ~= "" and u8:decode(chRang) ~= "�������� ����" and var_159_3:len() > 0 then
				if slc.v == 1 then
					if tostring(im.other.chName.v):len() > 0 then
						if tostring(im.other.chName.v):find("%u%a+%_%u%a+") then
							rhiData[im.other.chName.v] = var_159_3

							saveRhi()

							addRang, chRang, var_0_54.v, im.other.chName.v = false, "", "", ""
						else
							chmess = "{FF0000}������� ��� ������ � ������� Nick_Name"
						end
					else
						chmess = "{FF0000}������� ��� ������, ��� ������ ���������� ��������"
					end
				else
					rhiData[var_159_2] = var_159_3

					saveRhi()

					addRang, chRang, var_0_54.v = false, "", ""
				end
			else
				chmess = "{FF0000}�������� ��������������� ���� ��� ��������� ������ ����"
			end
		end

		if var_0_0.Button(u8("������� ���� ���������� �����##rhi"), var_0_96) then
			addRangRhi = false
		end

		var_0_0.EndChild()
	end

	var_0_0.Separator()
	var_0_0.Columns(2)
	var_0_0.Text(u8("���������� ����"))
	var_0_0.NextColumn()
	var_0_0.Text(u8("����� ����"))
	var_0_0.Columns(1)
	var_0_0.Separator()

	for iter_159_0, iter_159_1 in pairs(rhTable) do
		var_0_0.Columns(2)
		var_0_0.Text(u8(rhTable[iter_159_0].old))
		var_0_0.NextColumn()
		var_0_0.Text(u8(rhTable[iter_159_0].new))
		var_0_0.Separator()
		var_0_0.Columns(1)
	end

	var_0_0.EndChild()
end

function selectedTimings()
	var_0_0.Separator()
	var_0_0.Image(var_0_15.settings_timings, var_0_0.ImVec2(715, 80))
	var_0_0.BeginChild("left pane##6", var_0_0.ImVec2(0, 0), true)
	var_0_0.Text(var_0_7.ICON_COG .. u8(" ��������� ����������� ���������\n"))
	var_0_0.SameLine()
	showHelp(u8(
	"������ ������ ������� �������� ��� ����������, ����� ������� � ������� ������� ������� �� ����������, �������� �����������. ����� �������� ��� ������ ������������ ��������, �������������� �������� �� ��������� ����� � ������."))
	var_0_0.Separator()
	var_0_0.Columns(2, _, false)
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_EYE_SLASH .. u8(" ������ ��������� ���������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("������ ��������� ���������"), im.windows.timings)

	se.main.statusTimings = im.windows.timings.v

	var_0_0.SameLine()
	showHelp(u8(
	"���������� ��� �� ���������� �������� (����) �� ������ � ���������� ��������� ���������� ��������� �����."))
	var_0_0.NextColumn()

	if var_0_0.Button(u8("�������� ��������� ���������")) then
		mouseCoord7 = true
		var_0_42.v = false

		am("�������� ����� ����� � ������� ENTER.")
	end

	var_0_0.Columns(1)
	var_0_0.Separator()
	var_0_0.Columns(2, _, false)
	var_0_0.Text(u8("������������"))

	for iter_160_0, iter_160_1 in pairs(se.addedTimings) do
		var_0_0.Text(u8(iter_160_0))
		var_0_0.SameLine()

		if var_0_0.Button(var_0_7.ICON_ARROW_RIGHT .. "##s" .. iter_160_0) then
			se.addedTimings[iter_160_0] = nil
		end
	end

	var_0_0.NextColumn()
	var_0_0.Text(u8("�� ������������"))
	var_0_0.Separator()

	for iter_160_2, iter_160_3 in pairs(noaddedTimings) do
		if not se.addedTimings[iter_160_2] then
			if var_0_0.Button(var_0_7.ICON_ARROW_LEFT .. "##" .. iter_160_2) then
				se.addedTimings[iter_160_2] = true
			end

			var_0_0.SameLine()
			var_0_0.Text(u8(iter_160_2))
		end
	end

	var_0_0.Columns(1)
	var_0_0.EndChild()
end

function deleteTiming(arg_161_0)
	for iter_161_0, iter_161_1 in pairs(se.addedTimings) do
		if arg_161_0 == iter_161_0 then
			table.remove(se.addedTimings, iter_161_0)
		end
	end
end

function radarshowstate()
	var_0_0.SetMouseCursor(-1)

	local var_162_0 = getGxtText(getNameOfVehicleModel(getCarModel(storeCarCharIsInNoSave(playerPed))))
	local var_162_1 = getCarDoorLockStatus(storeCarCharIsInNoSave(playerPed))
	local var_162_2, var_162_3, var_162_4 = getCharCoordinates(playerPed)

	var_0_0.SetNextWindowPos(var_0_0.ImVec2(radX, radY), var_0_0.ImVec2(0.5, 0.5))
	var_0_0.SetNextWindowSize(var_0_0.ImVec2(250, 200), var_0_0.Cond.FirstUseEver)
	var_0_0.PushStyleColor(var_0_0.Col.WindowBg, var_0_0.ImVec4(0, 0, 0, 0.3))

	if var_0_0.Begin("PD-Project Radar", var_0_45, var_0_0.WindowFlags.NoTitleBar + var_0_0.WindowFlags.NoResize + var_0_0.WindowFlags.AlwaysAutoResize + var_0_0.WindowFlags.NoSavedSettings) then
		var_0_0.Text(var_0_7.ICON_CAR ..
		u8(" " ..
		(isCharInAnyHeli(playerPed) and "��������" or isCharInAnyPlane(playerPed) and "�������" or isCharInAnyMoto(playerPed) and "��������" or isCharInAnyCar(playerPed) and "����������" or "���������") ..
		": " .. var_162_0) .. " " .. (var_162_1 == 0 and var_0_7.ICON_UNLOCK or var_0_7.ICON_LOCK))
		var_0_0.Text(var_0_7.ICON_HEART ..
		u8(" ���������: " .. getCarHealth(storeCarCharIsInNoSave(playerPed)) / 10 .. ""))
		var_0_0.Text(var_0_7.ICON_COMPASS .. u8(" ������: " .. kvad(playerPed)))
		var_0_0.Text(var_0_7.ICON_COMPASS .. u8(" �����������: " .. mydirection(playerPed)))

		if var_162_0:find("Maverick") then
			local var_162_5 = getGroundZFor3dCoord(var_162_2, var_162_3, var_162_4)

			var_0_0.Text(var_0_7.ICON_SORT_NUMERIC_DESC ..
			u8(" ������: " ..
			tostring(math.floor(var_162_4 - (var_162_5 and var_162_5 or 0))) ..
			" �. [" .. tostring(math.floor(var_162_4)) .. " �.�]"))

			if as.autopilot.state == true then
				var_0_0.Text(var_0_7.ICON_PLANE ..
				u8(" ���������: " ..
				tostring(math.floor(as.autopilot.height)) ..
				"-" .. tostring(math.floor(as.autopilot.height + 10)) .. " �. �.�."))
			end
		end

		var_0_0.Text(var_0_7.ICON_TACHOMETER .. u8(" ��������: " .. (speedMyKM and speedMyKM or "-") .. " ��/�"))

		if cruise then
			var_0_0.Text(var_0_7.ICON_TACHOMETER .. u8(" �����-��������: " .. math.floor(cruiseSpeed * 2) .. " ��/�"))
		end

		if isKeyDown(VK_SHIFT) and isCharInCarDriver(playerPed) and not sampIsDialogActive() and not sampIsChatInputActive() and not isCharInAnyBoat(playerPed) and not isCharInAnyPlane(playerPed) then
			shwcrs = true

			showCursor(true, false)
			var_0_0.Separator()

			if not isCharInAnyHeli(playerPed) then
				if var_0_0.Button(var_0_7.ICON_CARET_SQUARE_O_RIGHT) and not cruise and isCharInAnyCar(playerPed) and not isCharInAnyHeli(playerPed) and not isCharInAnyPlane(playerPed) and not isCharInAnyBoat(playerPed) then
					if speedMyKM then
						cruiseSpeed = tonumber(speedMyKM) / 2
						cruise = true
						cruiseVehicle = storeCarCharIsInNoSave(playerPed)
					else
						cruiseSpeed = 0
						cruise = true
						cruiseVehicle = storeCarCharIsInNoSave(playerPed)
					end
				end

				var_0_0.SameLine()

				if var_0_0.Button(var_0_7.ICON_CARET_SQUARE_O_UP) and cruise and cruiseSpeed <= 59 then
					cruiseSpeed = cruiseSpeed + 5
				end

				var_0_0.SameLine()

				if var_0_0.Button(var_0_7.ICON_CARET_SQUARE_O_DOWN) and cruise and cruiseSpeed > 4 then
					cruiseSpeed = cruiseSpeed - 5
				end

				var_0_0.SameLine()

				if var_0_0.Button(var_0_7.ICON_STOP_CIRCLE) and cruise and cruiseVehicle ~= -1 then
					vehicle = getCarModel(cruiseVehicle)
					vehicle = var_0_11.getint32(vehicle * 4 + 11120840, false)
					vehicle = var_0_11.getint16(vehicle + 74, false)

					var_0_11.setfloat(vehicle * 224 + 12761564 + 132, maxspeed / 100, false)

					cruise = false
					cruiseSpeed = 0
					maxspeed = -1
				end

				var_0_0.SameLine()

				if var_0_0.Button(var_0_7.ICON_MOUSE_POINTER) and shwcrs and not var_0_36.v and not var_0_47.v and not var_0_42.v and not sampIsDialogActive() and not sampIsChatInputActive() and not sampIsScoreboardOpen() then
					showCursor(false, false)

					shwcrs = false
				end

				var_0_0.SameLine()

				if var_0_0.Button(var_0_7.ICON_LINE_CHART) and cruise and cruiseVehicle ~= -1 then
					cruiseSpeed = math.floor(tonumber(maxspeed)) / 2
				end
			else
				if var_0_0.Button(var_0_7.ICON_CARET_SQUARE_O_RIGHT) then
					as.autopilot.state = true

					if var_162_4 and var_162_4 > 0 then
						as.autopilot.height = math.floor(var_162_4)
					end
				end

				var_0_0.SameLine()

				if var_0_0.Button(var_0_7.ICON_CARET_SQUARE_O_UP) and as.autopilot.height < 490 then
					as.autopilot.height = as.autopilot.height + 10
				end

				var_0_0.SameLine()

				if var_0_0.Button(var_0_7.ICON_CARET_SQUARE_O_DOWN) and as.autopilot.height > 10 then
					as.autopilot.height = as.autopilot.height - 10
				end

				var_0_0.SameLine()

				if var_0_0.Button(var_0_7.ICON_STOP_CIRCLE) then
					as.autopilot.state = false
				end

				var_0_0.SameLine()

				if var_0_0.Button(var_0_7.ICON_CERTIFICATE) then
					if speedMyKM > 7 then
						chat("������� �������� �� 7 ��/�. � ���������� ��������, ����� ������������ �������.")
					else
						as.autopilot.impact = not as.autopilot.impact

						_G.freezeCarPosition(storeCarCharIsInNoSave(playerPed), as.autopilot.impact)

						as.autopilot.impact_vehicle = storeCarCharIsInNoSave(playerPed)

						if as.autopilot.impact then
							chat("�������� ����� ������������ �� ������� �����������.")
						end
					end
				end
			end
		elseif shwcrs and not var_0_36.v and not var_0_37.v and not var_0_38.v and not var_0_39.v and not var_0_40.v and not var_0_41.v and not var_0_42.v and not var_0_47.v and not var_0_51.v and not var_0_50.v and not var_0_49.v and not sampIsDialogActive() and not sampIsChatInputActive() and not sampIsScoreboardOpen() then
			showCursor(false, false)

			shwcrs = false
		end

		var_0_0.End()
	end

	var_0_0.PopStyleColor()
end

function setIdea(arg_163_0)
	local var_163_0 = {
		data = "s=" ..
		select(1, sampGetCurrentServerAddress()) ..
		":" ..
		select(2, sampGetCurrentServerAddress()) ..
		"&n=" ..
		sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))) ..
		"&f=" .. frac .. "&o=3&rt=" .. arg_163_0,
		headers = {
			["content-type"] = "application/x-www-form-urlencoded"
		}
	}

	sequent_async_http_request("POST", "https://pdp-samp.online/scripts/PDProject/setidea", var_163_0,
		function(arg_164_0)
			if arg_164_0.text:find("%[.*%]") or arg_164_0.text:find("%{.*%}") then
				local var_164_0 = decodeJson(arg_164_0.text)

				if var_164_0.status == "1" then
					am(u8:decode(var_164_0.reason))

					reportItem = 1
					im.reports.report_text_3.v = ""

					getReports()
				elseif var_164_0.status == "10" then
					am(u8:decode(var_164_0.reason))
				else
					am("������, ���������� �������.")
				end
			else
				log.warn(arg_164_0.text)
				am("������ � ��������� ������, ���������� ������� #2.")
				print("Can't load report data..")
			end
		end, function(arg_165_0)
		am("������ � ����������� ����� ������, ���������� ������� #1.")
		print(arg_165_0)
	end)
end

function setError(arg_166_0)
	local var_166_0 = {
		data = "s=" ..
		select(1, sampGetCurrentServerAddress()) ..
		":" ..
		select(2, sampGetCurrentServerAddress()) ..
		"&n=" ..
		sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))) ..
		"&f=" .. frac .. "&o=4&rt=" .. arg_166_0,
		headers = {
			["content-type"] = "application/x-www-form-urlencoded"
		}
	}

	sequent_async_http_request("POST", "https://pdp-samp.online/scripts/PDProject/setidea", var_166_0,
		function(arg_167_0)
			if arg_167_0.text:find("%[.*%]") or arg_167_0.text:find("%{.*%}") then
				local var_167_0 = decodeJson(arg_167_0.text)

				if var_167_0.status == "1" then
					am(u8:decode(var_167_0.reason))

					reportItem = 2
					im.reports.report_text_4.v = ""

					getReports()
				elseif var_167_0.status == "10" then
					am(u8:decode(var_167_0.reason))
				else
					am("������, ���������� �������.")
				end
			else
				log.warn(arg_167_0.text)
				am("������ � ��������� ������, ���������� ������� #2.")
				print("Can't load report data..")
			end
		end, function(arg_168_0)
		am("������ � ����������� ����� ������, ���������� ������� #1.")
		print(arg_168_0)
	end)
end

function starsUp(arg_169_0)
	if myReports[arg_169_0] ~= nil then
		am("�� �� ������ ���������� �� ���� ������!")

		return false
	end

	local var_169_0 = {
		data = "s=" ..
		select(1, sampGetCurrentServerAddress()) ..
		":" ..
		select(2, sampGetCurrentServerAddress()) ..
		"&n=" ..
		sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))) ..
		"&f=" .. frac .. "&o=5&rd=" .. arg_169_0,
		headers = {
			["content-type"] = "application/x-www-form-urlencoded"
		}
	}

	sequent_async_http_request("POST", "https://pdp-samp.online/scripts/PDProject/setidea", var_169_0,
		function(arg_170_0)
			if arg_170_0.text:find("%[.*%]") or arg_170_0.text:find("%{.*%}") then
				local var_170_0 = decodeJson(arg_170_0.text)

				if var_170_0.status == "1" then
					am(u8:decode(var_170_0.reason))
					getReports()
				elseif var_170_0.status == "10" then
					am(u8:decode(var_170_0.reason))
				else
					am("������, ���������� �������.")
				end
			else
				log.warn(arg_170_0.text)
				am("������ � ����������� ����� ������, ���������� ������� #2.")
				print("Can't load report data..")
			end
		end, function(arg_171_0)
		am("������ � ����������� ����� ������, ���������� ������� #1.")
		print(arg_171_0)
	end)
end

function starsDown(arg_172_0)
	if myReports[arg_172_0] ~= nil then
		am("�� �� ������ ���������� �� ���� ������!")

		return false
	end

	local var_172_0 = {
		data = "s=" ..
		select(1, sampGetCurrentServerAddress()) ..
		":" ..
		select(2, sampGetCurrentServerAddress()) ..
		"&n=" ..
		sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))) ..
		"&f=" .. frac .. "&o=6&rd=" .. arg_172_0,
		headers = {
			["content-type"] = "application/x-www-form-urlencoded"
		}
	}

	sequent_async_http_request("POST", "https://pdp-samp.online/scripts/PDProject/setidea", var_172_0,
		function(arg_173_0)
			if arg_173_0.text:find("%[.*%]") or arg_173_0.text:find("%{.*%}") then
				local var_173_0 = decodeJson(arg_173_0.text)

				if var_173_0.status == "1" then
					am(u8:decode(var_173_0.reason))
					getReports()
				elseif var_173_0.status == "10" then
					am(u8:decode(var_173_0.reason))
				else
					am("������, ���������� �������.")
				end
			else
				log.warn(arg_173_0.text)
				am("������ � ����������� ����� ������, ���������� ������� #2.")
				print("Can't load report data..")
			end
		end, function(arg_174_0)
		am("������ � ����������� ����� ������, ���������� ������� #1.")
		print(arg_174_0)
	end)
end

function pursuitshow()
	btn_size_db = var_0_0.ImVec2(200, 0)

	var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_0_94 / 2, var_0_95 / 2), var_0_0.ImVec2(0.5, 0.5))
	var_0_0.SetNextWindowSize(var_0_0.ImVec2(250, 140), var_0_0.Cond.FirstUseEver)
	var_0_0.PushStyleColor(var_0_0.Col.WindowBg, var_0_0.ImVec4(0, 0, 0, 0.3))
	var_0_0.Begin("PD Project Database", var_0_47,
		var_0_0.WindowFlags.NoTitleBar + var_0_0.WindowFlags.NoResize + var_0_0.WindowFlags.AlwaysAutoResize)

	if #VTable > 0 then
		for iter_175_0, iter_175_1 in pairs(VTable) do
			if var_0_0.Button(iter_175_1, var_0_0.ImVec2(300, 18)) then
				-- block empty
			end
		end
	end

	var_0_0.End()
	var_0_0.PopStyleColor()
end

function import_files(arg_176_0)
	local var_176_0
	local var_176_1, var_176_2 = findFirstFile("moonloader/PD-Project/import/*_" .. arg_176_0 .. ".karimoff")

	if var_176_2 then
		findClose(var_176_1)

		return true, var_176_2
	end

	return false, nil
end

function share_settings()
	var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_0_94 / 2, var_0_95 / 2), var_0_0.Cond.FirstUseEver,
		var_0_0.ImVec2(0.5, 0.5))
	var_0_0.SetNextWindowSize(var_0_0.ImVec2(450, 340), var_0_0.Cond.FirstUseEver)
	var_0_0.Begin(u8("���������� �����������"), im.windows.share_settings, var_0_0.WindowFlags.NoResize)
	var_0_0.PushTextWrapPos()
	var_0_0.Text(u8(
	"����� �� ������ ���������� ������ ����������� � ������� �������������� PD-Project. ����� ���������� ����������� �������, � ����� ���������� ������ ���������� �������, ��������, �������� ��� ������ � ������ � ���� ��������."))
	var_0_0.Text(u8(
	"����� ��� �������, �������� �� ������ ���� ��� �� ������ ����������, � ����� ������� ������� ��� ������������, ��� uID (������� � ������ �������� ������������) � ��������� �����������."))
	var_0_0.Text(u8(
	"����������� ���������� ���� ��������� ������, ������� �� ������ � ��� ��. �� ��� �� ������ �������� ������� � �������."))
	var_0_0.Separator()
	var_0_0.Combo(u8("�������� ���������"), depss, setlist)
	var_0_0.InputText(u8("������� Nick_Name"), im.settings.share_nick)
	var_0_0.SameLine()
	showHelp(u8(
	"������� ��� ����������� � ������� Nick_Name ��� ������ �������� � � ������ ������. ���������� ������ ���������� ����������� � ������ ��������."))
	var_0_0.InputText(u8("������� uID ������"), im.settings.share_uid)
	var_0_0.SameLine()
	showHelp(u8(
	"������� uID ������, �������� ����������� ����������� � ������ ��������. uID ����������� � ������ �������� ������������."))

	if var_0_0.Button(u8("��������� ���������"), var_0_96) then
		if depss.v > 0 then
			if tostring(im.settings.share_nick.v):len() > 0 then
				if tostring(im.settings.share_nick.v):find("%u%a+%_%u%a+") then
					if tostring(im.settings.share_uid.v):len() > 0 then
						im.settings.share_uid.v = im.settings.share_uid.v:match("(%d+)")
						im.settings.share_nick.v = trim(im.settings.share_nick.v)

						local var_177_0 = {
							data = "s=" ..
							select(1, sampGetCurrentServerAddress()) ..
							":" ..
							select(2, sampGetCurrentServerAddress()) ..
							"&n=" ..
							sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))) ..
							"&t=" .. depss.v .. "&tn=" .. im.settings.share_nick.v .. "&u=" .. im.settings.share_uid.v,
							headers = {
								["content-type"] = "application/x-www-form-urlencoded"
							}
						}

						sequent_async_http_request("POST", "https://pdp-samp.online/scripts/PDProject/settings-share",
							var_177_0, function(arg_178_0)
							if arg_178_0.text:find("%{.*status.*text.*%}") then
								local var_178_0 = decodeJson(arg_178_0.text)

								am(u8:decode(var_178_0.text))

								im.settings.share_nick.v, im.settings.share_uid.v, depss.v = "", "", 0
							else
								am("�� ������� ���������� ������. ��������� ������� �����.")
							end
						end, function(arg_179_0)
							print(arg_179_0)
						end)
					else
						am("������� uID ������������.")
					end
				else
					am("������ ���� ��������. ������� ������� ��� � ������� Nick_Name.")
				end
			else
				am("������� ������� ��� � ������� Nick_Name.")
			end
		else
			am("�������� ��������� �� ������.")
		end
	end

	var_0_0.Separator()
	var_0_0.PushTextWrapPos()
	var_0_0.Text(u8(
	"������ ������������, ������� ������� ����������� � ������ ��������, ������� ����������� � ������ ������� ����������� � ������ ��������� �������� � ������� 30 �����, ����� ��������� 30 ����� ����������� ����� ������������."))
	var_0_0.End()
end

function notes_window()
	var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_0_94 / 2, var_0_95 / 2), var_0_0.Cond.FirstUseEver,
		var_0_0.ImVec2(0.5, 0.5))
	var_0_0.SetNextWindowSize(var_0_0.ImVec2(730, 600), var_0_0.Cond.FirstUseEver)
	var_0_0.Begin(u8("�������"), im.windows.notes, var_0_0.WindowFlags.NoResize)
	var_0_0.Image(var_0_15.user_notes, var_0_0.ImVec2(715, 80))
	var_0_0.Separator()
	var_0_0.PushTextWrapPos()
	var_0_0.Text(u8(
	"� ������ ������� �� ������ ��������� ���� �������, ���������, ��������� ������. ��� ����������� � ������ � � ��� ������ ����� ������ � ���� ������� ���� ���� ��� ��������� ������ ��� �� ������ ������� ������� ������."))
	var_0_0.Separator()
	var_0_0.BeginChild("left pane##notes", var_0_0.ImVec2(200, 0), true)

	for iter_180_0 = 1, #SeleListNotes do
		if var_0_0.Selectable(u8(SeleListNotes[iter_180_0]), SeleListNotesBool[iter_180_0]) then
			selectedNotes = iter_180_0
		end

		var_0_0.Separator()
	end

	if var_0_0.Button(u8("�������� ����� ��������"), var_0_96) then
		if _G.aln[alnkey] then
			addNT = true
			var_0_68.AddName.v, var_0_68.AddCommand.v, var_0_68.AddText.v = "", "", ""
		else
			am("������ ������� �������� ������ �� ������� ������ ����.")
		end
	end

	var_0_0.AlignTextToFramePadding()

	if var_0_0.Button(u8("�������"), var_0_0.ImVec2(89, 20)) then
		if not selectedNotes or not SeleListNotes[selectedNotes] or not ntCommands[SeleListNotes[selectedNotes]].v then
			am("������ ��� �������� �� ������.")
		else
			local var_180_0 = {
				name = ntNames[SeleListNotes[selectedNotes]].v,
				command = ntCommands[SeleListNotes[selectedNotes]].v,
				text = ntTexts[SeleListNotes[selectedNotes]].v
			}
			local var_180_1 = io.open("moonloader/PD-Project/export/" .. var_180_0.command .. "_nt.karimoff", "w+")

			if var_180_1 then
				var_180_1:write(encodeJson(var_180_0))
				var_180_1:close()
				am("������ �������������� � ����� �������� (����� PD-Project/export). ������������ �����: " ..
				var_180_0.command .. "_nt.")
			else
				am("�� ������� �������������� ������. ��������� ������� ��� ��������� � ����������� ����������.")
			end
		end
	end

	var_0_0.SameLine()

	if var_0_0.Button(u8("������"), var_0_0.ImVec2(90, 20)) then
		local var_180_2, var_180_3 = import_files("nt")

		if var_180_2 then
			local var_180_4 = var_180_3:gsub("_nt.karimoff", "")

			chat("������������� ������: " .. var_180_4)

			local var_180_5 = io.open("moonloader/PD-Project/import/" .. var_180_3, "r")

			if var_180_5 then
				local var_180_6 = var_180_5:read("*a")
				local var_180_7 = decodeJson(var_180_6)

				if var_180_7 then
					if var_180_7.name ~= nil and var_180_7.commaand ~= nil and var_180_7.text ~= nil then
						if not isCommandExist(var_180_7.command) then
							ntData[u8:decode(trim(var_180_7.command)):gsub("/", "")] = {
								name = u8:decode(var_180_7.name),
								command = u8:decode(var_180_7.command),
								text = u8:decode(var_180_7.text):gsub("&", " ")
							}

							saveNt()
							registerNT()
							seleNtGet()
						else
							am("��������� ������� ��� ����������������. ������� ������.")
						end

						local var_180_8 = io.open("moonloader/PD-Project/import/imported/" .. var_180_3, "w+")

						if var_180_8 then
							var_180_8:write(var_180_6)
							var_180_8:close()
							var_180_5:close()
							os.remove("moonloader/PD-Project/import/" .. var_180_3)
						else
							am("�������� �� ���������. ���� � ��������� \"" ..
							var_180_3 .. "\" ����������� � ����� moonloader/PD-Project/import/imported.")
						end
					else
						am("�������� ����������� �������������� �����.")
					end
				else
					am("�������� ����������� �������������� �����, ��������� �������.")
				end
			else
				am("�� ������� ������������� ������.")
			end
		else
			am("������ ��� ������� �� ����������.")
		end
	end

	if var_0_0.Button(u8("��������� � ����"), var_0_96) then
		var_0_42.v = not var_0_42.v
		im.windows.notes.v = not im.windows.notes.v
	end

	var_0_0.EndChild()
	var_0_0.SameLine()
	var_0_0.BeginChild("left pane##noticewindow", var_0_0.ImVec2(0, 0), true)

	if SeleListNotes[selectedNotes] and not addNT then
		if ntNames[SeleListNotes[selectedNotes]].v then
			var_0_0.InputText(u8("������������"), ntNames[SeleListNotes[selectedNotes]])
		end

		if ntCommands[SeleListNotes[selectedNotes]].v then
			var_0_0.InputText(u8("������� �������� �������"), ntCommands[SeleListNotes[selectedNotes]])
		end

		if ntTexts[SeleListNotes[selectedNotes]].v then
			var_0_0.Text(u8("����� ������:"))
			var_0_0.InputTextMultiline("##noticetext", ntTexts[SeleListNotes[selectedNotes]], var_0_0.ImVec2(490, 310))
		end

		if var_0_0.Button(u8("��������� ���������"), var_0_96) then
			if _G.aln[alnkey] then
				if ntNames[SeleListNotes[selectedNotes]].v:len() > 0 and ntCommands[SeleListNotes[selectedNotes]].v:len() > 0 and ntTexts[SeleListNotes[selectedNotes]].v:len() > 0 then
					ntData[SeleListNotes[selectedNotes]] = {
						name = u8:decode(ntNames[SeleListNotes[selectedNotes]].v),
						command = u8:decode(ntCommands[SeleListNotes[selectedNotes]].v),
						text = u8:decode(ntTexts[SeleListNotes[selectedNotes]].v):gsub("&", " ")
					}

					saveNt()
					registerNT()
					am("��������� ���������.")
				else
					am("���������, ��� ��� ���� ���������.")
				end
			else
				am("������ ������� �������� ������ �� ������� ������ ����.")
			end
		end

		if var_0_0.Button(u8("������� ��������"), var_0_96) then
			if _G.aln[alnkey] then
				for iter_180_1, iter_180_2 in pairs(ntData) do
					if iter_180_1 == SeleListNotes[selectedNotes] then
						ntData[iter_180_1] = nil
					end
				end

				saveNt()
				registerNT()
				am("�������� ������.")

				selectedNotes = 1
			else
				am("������ ������� �������� ������ �� ������� ������ ����.")
			end
		end
	end

	if addNT == true then
		var_0_0.InputText(u8("������� ������������"), var_0_68.AddName)
		var_0_0.SameLine()
		showHelp(u8("������� ������������ ���������"))
		var_0_0.InputText(u8("������� ������� /"), var_0_68.AddCommand)
		var_0_0.SameLine()
		showHelp(u8(
		"������� ������� (��� /), � ������� ������� �� � ���������� ������� ������ ������� ������� ��������."))

		var_0_68.AddCommand.v = var_0_68.AddCommand.v:gsub("/", "")
		var_0_68.AddCommand.v = var_0_68.AddCommand.v:gsub(" ", "")

		var_0_0.Text(u8("����� ������:"))
		var_0_0.PushItemWidth(492)
		var_0_0.InputTextMultiline("##noticetext", var_0_68.AddText, var_0_0.ImVec2(490, 310))

		var_0_68.AddText.v = var_0_68.AddText.v:gsub("&", " ")

		if var_0_0.Button(u8("��������"), var_0_96) then
			if _G.aln[alnkey] then
				if var_0_68.AddName.v:len() > 0 and var_0_68.AddCommand.v:len() > 0 and var_0_68.AddText.v:len() > 0 then
					if not isCommandExist(var_0_68.AddCommand.v) then
						ntData[u8:decode(var_0_68.AddCommand.v)] = {
							name = u8:decode(var_0_68.AddName.v),
							command = u8:decode(var_0_68.AddCommand.v),
							text = u8:decode(var_0_68.AddText.v):gsub("&", " ")
						}

						saveNt()
						registerNT()

						addNT = false
					else
						am("��������� ������� ��� ����������������. ������� ������.")
					end
				else
					am("���������, ��� ��� ���� ���������.")
				end
			else
				am("������ ������� �������� ������ �� ������� ������ ����.")
			end
		end

		if var_0_0.Button(u8("������� ���� ���������� ���������"), var_0_96) then
			addNT = false
		end
	end

	if selectedNotes ~= 0 and #SeleListNotesBool > 0 then
		clearSeleListNotesBool(selectedNotes)
	end

	var_0_0.EndChild()
	var_0_0.End()
end

function update_notifications()
	while as.settings.setid == "" do
		wait(20000)
		lua_thread.create(getSettings)
		wait(40000)
	end
end

function accept_settings()
	var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_0_94 / 2, var_0_95 / 2), var_0_0.Cond.FirstUseEver,
		var_0_0.ImVec2(0.5, 0.5))
	var_0_0.SetNextWindowSize(var_0_0.ImVec2(450, 310), var_0_0.Cond.FirstUseEver)
	var_0_0.Begin(u8("����� ���������"), im.windows.accept_settings, var_0_0.WindowFlags.NoResize)
	var_0_0.PushTextWrapPos()
	var_0_0.Text(u8(
	"��� ���������� ������� ������������� ���������. ������ ����� �����������! �� ���������� ����������� �� ����������� ������� � ����������� ������, ���� ����� ��� �� ������ � �� �� ������� ��� ���������."))
	var_0_0.Text(u8("���� �� ������� ���������, ���� ������� ��������� ����� �������� � ������������ �� ����� ������."))
	var_0_0.Separator()
	var_0_0.Columns(2)
	var_0_0.Text(u8("����������� �� ������"))
	var_0_0.Text(u8("���������� ��� ���������"))
	var_0_0.Text(u8("����� ����������� �����������"))
	var_0_0.NextColumn()
	var_0_0.Text(as.settings.from)
	var_0_0.Text(as.settings.setting)
	var_0_0.Text(as.settings.time)
	var_0_0.Columns(1)
	var_0_0.Separator()

	if var_0_0.Button(u8("������� ���������"), var_0_96) then
		local var_182_0 = {
			data = "s=" ..
			select(1, sampGetCurrentServerAddress()) ..
			":" ..
			select(2, sampGetCurrentServerAddress()) ..
			"&n=" ..
			sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))) ..
			"&o=1&fn=" .. as.settings.from .. "&sd=" .. as.settings.setid,
			headers = {
				["content-type"] = "application/x-www-form-urlencoded"
			}
		}

		sequent_async_http_request("POST", "https://pdp-samp.online/scripts/PDProject/settings-accept", var_182_0,
			function(arg_183_0)
				if arg_183_0.text:find("%{.*status.*%}") then
					local var_183_0 = decodeJson(arg_183_0.text)

					if var_183_0.status == 1 then
						as.other.notifications = as.other.notifications - 1

						am(u8:decode(var_183_0.text))
						am("������������ �������..")
						thisScript():reload()
					elseif var_183_0.status == 2 then
						am(u8:decode(var_183_0.text))

						im.windows.accept_settings.v, as.other.notifications, as.settings.from, as.settings.setid, as.settings.time, as.settings.setting =
						false, as.other.notifications - 1, "", "", "", ""
					else
						am(u8:decode(var_183_0.text))
					end
				end
			end, function(arg_184_0)
			print(arg_184_0)
		end)
	end

	if var_0_0.Button(u8("��������� �����������"), var_0_96) then
		local var_182_1 = {
			data = "s=" ..
			select(1, sampGetCurrentServerAddress()) ..
			":" ..
			select(2, sampGetCurrentServerAddress()) ..
			"&n=" ..
			sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))) ..
			"&o=2&fn=" .. as.settings.from .. "&sd=" .. as.settings.setid,
			headers = {
				["content-type"] = "application/x-www-form-urlencoded"
			}
		}

		sequent_async_http_request("POST", "https://pdp-samp.online/scripts/PDProject/settings-accept", var_182_1,
			function(arg_185_0)
				if arg_185_0.text:find("%{.*status.*%}") then
					local var_185_0 = decodeJson(arg_185_0.text)

					if var_185_0.status == 1 or var_185_0.status == 2 then
						am(u8:decode(var_185_0.text))

						im.windows.accept_settings.v, as.other.notifications, as.settings.from, as.settings.setid, as.settings.time, as.settings.setting =
						false, as.other.notifications - 1, "", "", "", ""
					else
						am(u8:decode(var_185_0.text))
					end
				end
			end, function(arg_186_0)
			print(arg_186_0)
		end)
	end

	if var_0_0.Button(u8("������������ �� ������"), var_0_96) then
		local var_182_2 = {
			data = "s=" ..
			select(1, sampGetCurrentServerAddress()) ..
			":" ..
			select(2, sampGetCurrentServerAddress()) ..
			"&n=" ..
			sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))) ..
			"&o=3&fn=" .. as.settings.from .. "&sd=" .. as.settings.setid,
			headers = {
				["content-type"] = "application/x-www-form-urlencoded"
			}
		}

		sequent_async_http_request("POST", "https://pdp-samp.online/scripts/PDProject/settings-accept", var_182_2,
			function(arg_187_0)
				if arg_187_0.text:find("%{.*status.*%}") then
					local var_187_0 = decodeJson(arg_187_0.text)

					if var_187_0.status == 1 or var_187_0.status == 2 then
						am(u8:decode(var_187_0.text))

						im.windows.accept_settings.v, as.other.notifications, as.settings.from, as.settings.setid, as.settings.time, as.settings.setting =
						false, as.other.notifications - 1, "", "", "", ""
					else
						am(u8:decode(var_187_0.text))
					end
				end
			end, function(arg_188_0)
			print(arg_188_0)
		end)
	end

	var_0_0.Separator()
	var_0_0.Text(u8(
	"��������! ����� ���, ��� ����������, ���������, ��� �� ��� ����� ������ � ��� ��� ������������� ������. ���� �� ������ ��������� ��� ������, �� ����� �������� ���������� � �������, ��� � ��."))
	var_0_0.End()
end

function dbstateshow()
	btn_size_db = var_0_0.ImVec2(200, 0)

	var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_0_94 / 2, var_0_95 / 2), var_0_0.ImVec2(0.5, 0.5))
	var_0_0.SetNextWindowSize(var_0_0.ImVec2(250, 140), var_0_0.Cond.FirstUseEver)
	var_0_0.PushStyleColor(var_0_0.Col.WindowBg, var_0_0.ImVec4(0, 0, 0, 0.3))
	var_0_0.Begin("PD Project Database", var_0_47,
		var_0_0.WindowFlags.NoTitleBar + var_0_0.WindowFlags.NoResize + var_0_0.WindowFlags.AlwaysAutoResize)

	if srv_name == "revolution" then
		if tostring(myfrac) == "1" and var_0_0.Button(u8("������ ������� ��"), btn_size_db) then
			var_0_49.v = not var_0_49.v
		end

		if tostring(myfrac) == "2" and var_0_0.Button(u8("������ ������� ��"), btn_size_db) then
			var_0_50.v = not var_0_50.v
		end

		if tostring(myfrac) == "3" and var_0_0.Button(u8("������ ������� ��"), btn_size_db) then
			var_0_51.v = not var_0_51.v
		end

		if tostring(myfrac) == "4" and var_0_0.Button(u8("������ ���"), btn_size_db) then
			var_0_52.v = not var_0_52.v
		end

		if var_0_0.Button(u8("����"), btn_size_db) then
			var_0_38.v = not var_0_38.v
		end

		if var_0_0.Button(u8("���������������� ������"), btn_size_db) then
			var_0_39.v = not var_0_39.v
		end

		if var_0_0.Button(u8("��������� ������"), btn_size_db) then
			var_0_40.v = not var_0_40.v
		end

		if var_0_0.Button(u8("����������� �������������"), btn_size_db) then
			var_0_41.v = not var_0_41.v
		end
	end

	if srv_name == "legacy" then
		if tostring(myfrac) == "1" and var_0_0.Button(u8("������ ������� ��"), btn_size_db) then
			var_0_49.v = not var_0_49.v
		end

		if tostring(myfrac) == "2" and var_0_0.Button(u8("������ ������� ��"), btn_size_db) then
			var_0_50.v = not var_0_50.v
		end

		if tostring(myfrac) == "3" and var_0_0.Button(u8("������ ������� ��"), btn_size_db) then
			var_0_51.v = not var_0_51.v
		end

		if tostring(myfrac) == "4" and var_0_0.Button(u8("������ ���"), btn_size_db) then
			var_0_52.v = not var_0_52.v
		end

		if var_0_0.Button(u8("����� \"� �������\""), btn_size_db) then
			var_0_38.v = not var_0_38.v
		end

		if var_0_0.Button(u8("���������������� ������"), btn_size_db) then
			var_0_39.v = not var_0_39.v
		end

		if var_0_0.Button(u8("��������� ������"), btn_size_db) then
			var_0_40.v = not var_0_40.v
		end

		if var_0_0.Button(u8("����������� �������������"), btn_size_db) then
			var_0_41.v = not var_0_41.v
		end
	end

	if srv_name == "evolve" then
		if tostring(myfrac) == "1" and var_0_0.Button(u8("������ ������� ��"), btn_size_db) then
			var_0_49.v = not var_0_49.v
		end

		if tostring(myfrac) == "2" and var_0_0.Button(u8("������ ������� ��"), btn_size_db) then
			var_0_50.v = not var_0_50.v
		end

		if tostring(myfrac) == "3" and var_0_0.Button(u8("������ ������� ��"), btn_size_db) then
			var_0_51.v = not var_0_51.v
		end

		if tostring(myfrac) == "4" and var_0_0.Button(u8("������ ���"), btn_size_db) then
			var_0_52.v = not var_0_52.v
		end

		if var_0_0.Button(u8("����� \"� �������\""), btn_size_db) then
			var_0_38.v = not var_0_38.v
		end

		if var_0_0.Button(u8("���������������� ������"), btn_size_db) then
			var_0_39.v = not var_0_39.v
		end

		if var_0_0.Button(u8("��������� ������"), btn_size_db) then
			var_0_40.v = not var_0_40.v
		end

		if var_0_0.Button(u8("����������� �������������"), btn_size_db) then
			var_0_41.v = not var_0_41.v
		end
	end

	if srv_name == "second" then
		if tostring(myfrac) == "1" and var_0_0.Button(u8("������ ������� ��"), btn_size_db) then
			var_0_49.v = not var_0_49.v
		end

		if tostring(myfrac) == "2" and var_0_0.Button(u8("������ ������� ��"), btn_size_db) then
			var_0_50.v = not var_0_50.v
		end

		if tostring(myfrac) == "3" and var_0_0.Button(u8("������ ������� ��"), btn_size_db) then
			var_0_51.v = not var_0_51.v
		end

		if tostring(myfrac) == "4" and var_0_0.Button(u8("������ ���"), btn_size_db) then
			var_0_52.v = not var_0_52.v
		end

		if var_0_0.Button(u8("����� \"� �������\""), btn_size_db) then
			var_0_38.v = not var_0_38.v
		end

		if var_0_0.Button(u8("���������������� ������"), btn_size_db) then
			var_0_39.v = not var_0_39.v
		end

		if var_0_0.Button(u8("��������� ������"), btn_size_db) then
			var_0_40.v = not var_0_40.v
		end

		if var_0_0.Button(u8("����������� �������������"), btn_size_db) then
			var_0_41.v = not var_0_41.v
		end
	end

	if srv_name == "classic" then
		if tostring(myfrac) == "1" and var_0_0.Button(u8("������ ������� ��"), btn_size_db) then
			var_0_49.v = not var_0_49.v
		end

		if tostring(myfrac) == "2" and var_0_0.Button(u8("������ ������� ��"), btn_size_db) then
			var_0_50.v = not var_0_50.v
		end

		if tostring(myfrac) == "3" and var_0_0.Button(u8("������ ������� ��"), btn_size_db) then
			var_0_51.v = not var_0_51.v
		end

		if tostring(myfrac) == "4" and var_0_0.Button(u8("������ ���"), btn_size_db) then
			var_0_52.v = not var_0_52.v
		end

		if var_0_0.Button(u8("����� ����������"), btn_size_db) then
			var_0_38.v = not var_0_38.v
		end

		if var_0_0.Button(u8("���������������� ������"), btn_size_db) then
			var_0_39.v = not var_0_39.v
		end

		if var_0_0.Button(u8("��������� ������"), btn_size_db) then
			var_0_40.v = not var_0_40.v
		end

		if var_0_0.Button(u8("����������� �������������"), btn_size_db) then
			var_0_41.v = not var_0_41.v
		end
	end

	if srv_name == "underground" then
		var_0_0.Text(u8("�������������� ��������� �������"))
		var_0_0.Separator()
	end

	if var_0_0.Button(u8("�������"), btn_size_db) then
		var_0_47.v = false
	end

	var_0_0.End()
	var_0_0.PopStyleColor()
end

function isCommandExist(arg_190_0)
	for iter_190_0, iter_190_1 in pairs(ccData) do
		if iter_190_0 == arg_190_0 then
			return true
		end
	end

	for iter_190_2, iter_190_3 in pairs(ntData) do
		if iter_190_3.command == arg_190_0 then
			return true
		end
	end

	return false
end

function isKeyExist(arg_191_0)
	local var_191_0 = arg_191_0:gsub("+", "{plus}")

	for iter_191_0, iter_191_1 in pairs(HotKeysData) do
		if iter_191_0 == var_191_0 then
			return true
		end
	end

	return false
end

function isCheatExist(arg_192_0)
	for iter_192_0, iter_192_1 in pairs(tcData) do
		if iter_192_0 == arg_192_0 then
			return true
		end
	end

	return false
end

function auth_show()
	var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_0_94 / 2, var_0_95 / 2), var_0_0.ImVec2(0.5, 0.5))
	var_0_0.SetNextWindowSize(var_0_0.ImVec2(250, 130), var_0_0.Cond.FirstUseEver)
	var_0_0.PushStyleColor(var_0_0.Col.WindowBg, var_0_0.ImVec4(0, 0, 0, 0.3))
	var_0_0.Begin("Author", var_0_48,
		var_0_0.WindowFlags.NoTitleBar + var_0_0.WindowFlags.NoResize + var_0_0.WindowFlags.AlwaysAutoResize +
		var_0_0.WindowFlags.NoSavedSettings)
	var_0_0.Text(u8("�����: karimoff"))
	var_0_0.Text(u8("����: karimoff.dev"))
	var_0_0.Text(u8("��.�����: me@karimoff.dev"))
	var_0_0.Text(u8("������ ��: vk.com/karimoff_dev"))
	var_0_0.Text(u8("������ �� ��������: vk.com/samp_pdp"))
	var_0_0.Text(u8(">> ����� LUA �������� <<"))

	if auth_cl ~= nil then
		auth_bt = "��������� ����� " .. tostring(auth_cl) .. " ��� :)"
	else
		auth_bt = ""
	end

	var_0_0.Text(u8(auth_bt))

	if auth_cl == 0 then
		var_0_48.v = false
	end

	var_0_0.End()
	var_0_0.PopStyleColor()
end

function getSprintLocalPlayer()
	local var_194_0 = var_0_11.getfloat(12045748)

	if var_194_0 > 0 then
		return math.floor(var_194_0 / 31.47000244)
	else
		return 0
	end
end

function getWaterLocalPlayer()
	local var_195_0 = var_0_11.getfloat(12045792)

	return math.floor(var_195_0 / 39.97000244)
end

function inform_timings()
	if tonumber(timingsX) == 0 and tonumber(timingsY) == 0 then
		timingsX = var_0_94 / 2
		timingsY = var_0_95 / 2
	end

	var_0_0.SetNextWindowPos(var_0_0.ImVec2(tonumber(timingsX), tonumber(timingsY)), var_0_0.ImVec2(0.5, 0.5))
	var_0_0.SetNextWindowSize(var_0_0.ImVec2(0, 0), var_0_0.Cond.FirstUseEver)
	var_0_0.PushStyleColor(var_0_0.Col.WindowBg, var_0_0.ImVec4(0, 0, 0, 0.3))

	if var_0_0.Begin("PD-Project Timings", im.windows.timings, var_0_0.WindowFlags.NoTitleBar + var_0_0.WindowFlags.NoResize + var_0_0.WindowFlags.AlwaysAutoResize + var_0_0.WindowFlags.NoSavedSettings) then
		var_0_0.CenterText(u8("��������"))
		var_0_0.Separator()

		for iter_196_0, iter_196_1 in pairs(timings) do
			if se.addedTimings[tostring("���������� " .. iter_196_0)] then
				var_0_0.Text(u8(iter_196_0 .. ": ~" .. iter_196_1))
			end
		end

		var_0_0.End()
	end

	var_0_0.PopStyleColor()
end

function squad_informer()
	if as.textdraw.squad_status and var_0_89[tonumber(se.squad.size)] ~= nil then
		var_0_0.SetNextWindowPos(var_0_0.ImVec2(tonumber(se.squad.x), tonumber(se.squad.y)), var_0_0.ImVec2(0.5, 0.5))
		var_0_0.SetNextWindowSize(var_0_0.ImVec2(0, 0), var_0_0.Cond.FirstUseEver)
		var_0_0.PushStyleColor(var_0_0.Col.WindowBg, var_0_0.ImVec4(0, 0, 0, 0.3))

		if var_0_0.Begin("PD-Project Squad", im.windows.squad, var_0_0.WindowFlags.NoTitleBar + var_0_0.WindowFlags.NoResize + var_0_0.WindowFlags.AlwaysAutoResize + var_0_0.WindowFlags.NoSavedSettings) then
			var_0_0.PushFont(var_0_89[tonumber(se.squad.size)])
			var_0_0.CenterText(u8("SQUAD"))
			var_0_0.PopFont()
			var_0_0.Separator()

			as.other.squad_max_width2 = 0

			for iter_197_0, iter_197_1 in pairs(as.textdraw.squad_users) do
				if as.textdraw.squaders[tostring(iter_197_1)] then
					local var_197_0 = as.textdraw.squaders[tostring(iter_197_1)]

					if var_197_0.id == nil or var_197_0.id == "" or var_197_0.id == "N/A" then
						-- block empty
					else
						as.other.squad_afk = ""

						if se and se.squad.afk and as.textdraw.squaders[tostring(iter_197_1)] ~= nil and var_197_0.afk ~= nil and tonumber(var_197_0.afk) > 10 and sampIsPlayerConnected(var_197_0.id) and sampGetPlayerNickname(var_197_0.id) == tostring(iter_197_1) then
							as.other.squad_afk = " AFK: " .. math.floor(tonumber(var_197_0.afk))
						end

						local var_197_1 = "# " ..
						tostring(iter_197_1) ..
						"[" .. tostring(var_197_0.id) .. "] " .. var_197_0.sector .. as.other.squad_afk

						if var_197_1:len() > as.other.squad_max_width then
							as.other.squad_max_width = var_197_1:len()
						end

						if var_197_1:len() > as.other.squad_max_width2 then
							as.other.squad_max_width2 = var_197_1:len()
						end

						var_0_0.PushFont(var_0_92[tonumber(se.squad.size)])
						var_0_0.TextColoredRGB2("{" ..
						(var_197_0.color ~= nil and var_197_0.color or "FFFFFF") ..
						"}" .. var_0_7.ICON_USER_O .. " {FFFFFF}")
						var_0_0.PopFont()
						var_0_0.SameLine()
						var_0_0.PushFont(var_0_89[tonumber(se.squad.size)])

						if var_197_0.id ~= nil and (sampIsPlayerConnected(var_197_0.id) and select(1, sampGetCharHandleBySampPlayerId(tonumber(var_197_0.id))) == true or var_197_0.id == myID) then
							var_0_0.TextColoredRGB2(tostring(iter_197_1) ..
							"[" .. tostring(var_197_0.id) .. "] " .. var_197_0.sector .. as.other.squad_afk)
						else
							var_0_0.TextColoredRGB2(
							"{FFFFFF}" ..
							tostring(iter_197_1) ..
							"[" .. tostring(var_197_0.id) .. "] " .. var_197_0.sector .. as.other.squad_afk .. "{FFFFFF}",
								nil, true)
						end

						var_0_0.PopFont()

						if as.other.squad_max_width == 0 then
							as.other.squad_max_width = var_0_0.GetWindowWidth()
						end

						local var_197_2 = as.other.squad_max_width * tonumber(se.squad.size) * 0.215
						local var_197_3 = var_197_2

						if var_197_0.health ~= nil and var_197_0.armour ~= nil then
							var_0_0.AnimProgressBar("squader_health##" .. tostring(iter_197_1),
								tonumber(var_197_0.health), var_0_0.ImVec4(1, 0, 0, 0.4),
								var_0_0.ImVec2(var_197_2, tonumber(as.textdraw.squad_size) / 4), true)
							var_0_0.SameLine()
							var_0_0.AnimProgressBar("squader_armour##" .. tostring(iter_197_1),
								tonumber(var_197_0.armour), var_0_0.ImVec4(1, 1, 1, 0.4),
								var_0_0.ImVec2(var_197_3, tonumber(as.textdraw.squad_size) / 4), true)
						end
					end
				else
					if as.other.id_list[tostring(iter_197_1)] == nil then
						local var_197_4 = sampGetPlayerIdByNickname(tostring(iter_197_1))

						if var_197_4 and sampIsPlayerConnected(var_197_4) then
							as.other.id_list[tostring(iter_197_1)] = var_197_4
						end
					end

					if as.other.id_list[tostring(iter_197_1)] ~= nil then
						if sampIsPlayerConnected(as.other.id_list[tostring(iter_197_1)]) and sampGetPlayerNickname(as.other.id_list[tostring(iter_197_1)]) == tostring(iter_197_1) then
							var_0_0.PushFont(var_0_92[tonumber(se.squad.size)])
							var_0_0.TextColoredRGB2("{" ..
							string.format("%06X",
								ARGBtoRGB(sampGetPlayerColor(tonumber(as.other.id_list[tostring(iter_197_1)])))) ..
							"}" .. var_0_7.ICON_USER_O .. " {FFFFFF}")
							var_0_0.PopFont()
							var_0_0.SameLine()
							var_0_0.PushFont(var_0_89[tonumber(se.squad.size)])

							if as.other.id_list[tostring(iter_197_1)] ~= nil and sampIsPlayerConnected(as.other.id_list[tostring(iter_197_1)]) and select(1, sampGetCharHandleBySampPlayerId(tonumber(as.other.id_list[tostring(iter_197_1)]))) == true then
								var_0_0.TextColoredRGB2(tostring(iter_197_1) ..
								"[" .. tostring(as.other.id_list[tostring(iter_197_1)]) .. "]")
							else
								var_0_0.TextColoredRGB2(
								"{FFFFFF}" ..
								tostring(iter_197_1) ..
								"[" .. tostring(as.other.id_list[tostring(iter_197_1)]) .. "]{FFFFFF}", nil, true)
							end

							var_0_0.PopFont()
						else
							as.other.id_list[tostring(iter_197_1)] = nil
						end
					end
				end
			end

			if as.other.squad_max_width > as.other.squad_max_width2 then
				as.other.squad_max_width = as.other.squad_max_width2
			end

			var_0_0.End()
		end

		var_0_0.PopStyleColor()
	end
end

function squad_informer2()
	if as.textdraw.squad_status then
		var_0_0.SetNextWindowPos(var_0_0.ImVec2(tonumber(se.squad.x), tonumber(se.squad.y)), var_0_0.ImVec2(0.5, 0.5))
		var_0_0.SetNextWindowSize(var_0_0.ImVec2(0, 0), var_0_0.Cond.FirstUseEver)
		var_0_0.PushStyleColor(var_0_0.Col.WindowBg, var_0_0.ImVec4(0, 0, 0, 0.3))

		if var_0_0.Begin("PD-Project Squad", im.windows.squad, var_0_0.WindowFlags.NoTitleBar + var_0_0.WindowFlags.NoResize + var_0_0.WindowFlags.AlwaysAutoResize + var_0_0.WindowFlags.NoSavedSettings) then
			if #as.textdraw.squad_users < 8 then
				var_0_0.PushFont(var_0_89[tonumber(se.squad.size)])
				var_0_0.CenterText(u8("SQUAD"))
				var_0_0.PopFont()
				var_0_0.Separator()
			end

			local var_198_0
			local var_198_1

			for iter_198_0, iter_198_1 in pairs(as.textdraw.squad_users) do
				if as.textdraw.squaders[tostring(iter_198_1)] then
					var_198_0 = as.textdraw.squaders[tostring(iter_198_1)].sector
				end

				if not as.other.id_list[tostring(iter_198_1)] then
					local var_198_2 = sampGetPlayerIdByNickname(tostring(iter_198_1))

					if var_198_2 and sampIsPlayerConnected(var_198_2) then
						as.other.id_list[tostring(iter_198_1)] = var_198_2
						var_198_1 = var_198_2
					else
						var_198_1 = "N/A"
					end
				else
					var_198_1 = as.other.id_list[tostring(iter_198_1)]
				end

				local var_198_3 = ("# " .. tostring(iter_198_1) .. "[" .. var_198_1 .. "]" .. (var_198_0 ~= nil and " " .. var_198_0 or ""))
				:len()

				if var_198_3 > max_width then
					max_width = var_198_3
				end
			end

			for iter_198_2, iter_198_3 in pairs(as.textdraw.squad_users) do
				if as.textdraw.squaders[tostring(iter_198_3)] then
					local var_198_4 = as.textdraw.squaders[tostring(iter_198_3)]

					if var_198_4.id == nil or var_198_4.id == "" or var_198_4.id == "N/A" then
						if tostring(iter_198_3) == myName then
							as.textdraw.squaders[tostring(iter_198_3)].id = myID
							var_198_4.id = myID
						else
							local var_198_5 = sampGetPlayerIdByNickname(tostring(iter_198_3))

							if var_198_5 and sampIsPlayerConnected(var_198_5) then
								as.textdraw.squaders[tostring(iter_198_3)].id = var_198_5
								var_198_4.id = var_198_5
							else
								var_198_4.id = "N/A"
							end
						end
					end

					for iter_198_4, iter_198_5 in pairs(as.textdraw.squad_users) do
						as.other.squad_afk = ""

						if se and se.squad.afk and as.textdraw.squaders[tostring(iter_198_5)] ~= nil and as.textdraw.squaders[tostring(iter_198_5)].updated ~= nil and os.time(os.date("!*t")) + 10800 - as.textdraw.squaders[tostring(iter_198_5)].updated > 10 and sampIsPlayerConnected(as.textdraw.squaders[tostring(iter_198_5)].id) and sampGetPlayerNickname(as.textdraw.squaders[tostring(iter_198_5)].id) == tostring(iter_198_5) then
							as.other.squad_afk = " AFK: " ..
							math.floor(os.time(os.date("!*t")) + 10800 -
							as.textdraw.squaders[tostring(iter_198_5)].updated)
						end

						if as.textdraw.squaders[tostring(iter_198_5)] == nil then
							local var_198_6 = ("# " .. tostring(iter_198_5) .. "[000]"):len()

							if var_198_6 > max_width then
								max_width = var_198_6
							end
						else
							local var_198_7 = ("# " .. tostring(iter_198_5) .. "[" .. (as.textdraw.squaders[tostring(iter_198_5)].id ~= nil and as.textdraw.squaders[tostring(iter_198_5)].id or "000") .. "]" .. (as.textdraw.squaders[tostring(iter_198_5)].sector ~= nil and " " .. as.textdraw.squaders[tostring(iter_198_5)].sector or "") .. as.other.squad_afk)
							:len()

							if var_198_7 > max_width then
								max_width = var_198_7
							end
						end
					end

					if as.other.squad_max_width == 0 then
						as.other.squad_max_width = var_0_0.GetWindowWidth()
					end

					local var_198_8 = as.other.squad_max_width * tonumber(se.squad.size) * 0.215
					local var_198_9 = var_198_8

					var_0_0.PushFont(var_0_92[tonumber(se.squad.size)])
					var_0_0.TextColoredRGB2("{" ..
					(var_198_4.color ~= nil and var_198_4.color or "FFFFFF") .. "}" .. var_0_7.ICON_USER_O .. " {FFFFFF}")
					var_0_0.PopFont()
					var_0_0.SameLine()
					var_0_0.PushFont(var_0_89[tonumber(se.squad.size)])

					if tostring(iter_198_3) == myName then
						var_0_0.TextColoredRGB2(tostring(iter_198_3) ..
						"[" .. var_198_4.id .. "]" .. (var_198_4.sector ~= nil and " " .. var_198_4.sector or ""))
					else
						as.other.squad_afk = ""

						if se.squad.afk and var_198_4.updated ~= nil and os.time(os.date("!*t")) + 10800 - var_198_4.updated > 10 and sampIsPlayerConnected(var_198_4.id) and sampGetPlayerNickname(var_198_4.id) == tostring(iter_198_3) then
							as.other.squad_afk = " AFK: " ..
							tostring(math.floor(os.time(os.date("!*t")) + 10800 - var_198_4.updated))
						end

						if var_198_4.id ~= nil and sampIsPlayerConnected(var_198_4.id) and select(1, sampGetCharHandleBySampPlayerId(tonumber(var_198_4.id))) == true then
							var_0_0.TextColoredRGB2(tostring(iter_198_3) ..
							"[" ..
							var_198_4.id ..
							"]" ..
							(var_198_4.sector ~= nil and (var_198_4.sector ~= "" and " " .. var_198_4.sector or "")) ..
							as.other.squad_afk)
						else
							var_198_4.sector = tostring(var_198_4.sector)

							if var_198_4.sector == "true" or var_198_4.sector == "false" or var_198_4.sector == "nil" then
								var_198_4.sector = ""
							end

							var_0_0.TextColoredRGB2(
							"{FFFFFF}" ..
							tostring(iter_198_3) ..
							"[" ..
							(var_198_4.id ~= nil and var_198_4.id or "N/A") ..
							"]" ..
							(var_198_4.sector ~= nil and (var_198_4.sector ~= "" and " " .. var_198_4.sector or "")) ..
							as.other.squad_afk .. "{FFFFFF}", nil, true)
						end
					end

					var_0_0.PopFont()

					if var_198_4.health ~= nil and var_198_4.armour ~= nil then
						var_0_0.AnimProgressBar("squader_health##" .. tostring(iter_198_3), tonumber(var_198_4.health),
							var_0_0.ImVec4(1, 0, 0, 0.4), var_0_0.ImVec2(var_198_8, tonumber(as.textdraw.squad_size) / 4),
							true)
						var_0_0.SameLine()
						var_0_0.AnimProgressBar("squader_armour##" .. tostring(iter_198_3), tonumber(var_198_4.armour),
							var_0_0.ImVec4(1, 1, 1, 0.4), var_0_0.ImVec2(var_198_9, tonumber(as.textdraw.squad_size) / 4),
							true)
					end
				elseif not as.other.id_list[tostring(iter_198_3)] then
					local var_198_10 = sampGetPlayerIdByNickname(tostring(iter_198_3))

					if var_198_10 and sampIsPlayerConnected(var_198_10) then
						as.other.id_list[tostring(iter_198_3)] = var_198_10
					else
						var_0_0.PushFont(var_0_92[tonumber(se.squad.size)])
						var_0_0.TextColoredRGB2("{FFFFFF}" .. var_0_7.ICON_USER_O .. " {FFFFFF}")
						var_0_0.PopFont()
						var_0_0.SameLine()
						var_0_0.PushFont(var_0_89[tonumber(se.squad.size)])
						var_0_0.TextColoredRGB2(tostring(iter_198_3) .. "[N/A]")
						var_0_0.PopFont()
					end
				elseif sampIsPlayerConnected(as.other.id_list[tostring(iter_198_3)]) then
					var_0_0.PushFont(var_0_92[tonumber(se.squad.size)])
					var_0_0.TextColoredRGB2("{" ..
					string.format("%06X", ARGBtoRGB(sampGetPlayerColor(tonumber(as.other.id_list[tostring(iter_198_3)])))) ..
					"}" .. var_0_7.ICON_USER_O .. " {FFFFFF}")
					var_0_0.PopFont()
					var_0_0.SameLine()
					var_0_0.PushFont(var_0_89[tonumber(se.squad.size)])

					if as.other.id_list[tostring(iter_198_3)] ~= nil and sampIsPlayerConnected(as.other.id_list[tostring(iter_198_3)]) and select(1, sampGetCharHandleBySampPlayerId(tonumber(as.other.id_list[tostring(iter_198_3)]))) == true then
						var_0_0.TextColoredRGB2(tostring(iter_198_3) ..
						"[" .. as.other.id_list[tostring(iter_198_3)] .. "]")
					else
						var_0_0.TextColoredRGB2(
						"{FFFFFF}" ..
						tostring(iter_198_3) .. "[" .. as.other.id_list[tostring(iter_198_3)] .. "]{FFFFFF}", nil, true)
					end

					var_0_0.PopFont()
				end
			end

			var_0_0.End()
		end

		var_0_0.PopStyleColor()
	end
end

function inform_state_f()
	inform_arr = {
		armourNew = getCharArmour(playerPed),
		healNew = getCharHealth(playerPed),
		moneyNew = var_0_11.getint32(12045904),
		weaponNew = getGun(getCurrentCharWeapon(playerPed))
	}

	local var_199_0 = getCityPlayerIsIn(playerPed)

	if var_199_0 > 0 then
		playerCity = as.other.citiesList[var_199_0]
	else
		playerCity = "��� �������"
	end

	local var_199_1, var_199_2, var_199_3 = getCharCoordinates(playerPed)

	var_0_0.SetNextWindowPos(var_0_0.ImVec2(tonumber(infoX), tonumber(infoY)), var_0_0.ImVec2(0.5, 0.5))
	var_0_0.SetNextWindowSize(var_0_0.ImVec2(250, 200), var_0_0.Cond.FirstUseEver)
	var_0_0.PushStyleColor(var_0_0.Col.WindowBg, var_0_0.ImVec4(0, 0, 0, 0.3))

	if var_0_0.Begin("PD-Project", var_0_43, var_0_0.WindowFlags.NoTitleBar + var_0_0.WindowFlags.NoResize + var_0_0.WindowFlags.AlwaysAutoResize + var_0_0.WindowFlags.NoSavedSettings) then
		var_0_0.CenterText(var_0_7.ICON_MODX .. " PD-PROJECT " .. var_0_7.ICON_MODX)
		var_0_0.Separator()

		if player_exp ~= nil then
			var_0_0.Text(var_0_7.ICON_ID_CARD .. " " .. userNick .. "[" .. myID .. "] [" .. player_exp .. "]")

			if im.informer.infShowClist.v then
				var_0_0.SameLine()
				var_0_0.TextColoredRGB("[{" ..
				string.format("%06X", ARGBtoRGB(sampGetPlayerColor(myID))) ..
				"}" ..
				(as.other.colorlist[sampGetPlayerColor(myID)] ~= nil and as.other.colorlist[sampGetPlayerColor(myID)] or "-") ..
				"{FFFFFF}]")
			end
		else
			var_0_0.Text(var_0_7.ICON_ID_CARD .. " " .. userNick .. "[" .. myID .. "] [EXP]")

			if im.informer.infShowClist.v then
				var_0_0.SameLine()
				var_0_0.TextColoredRGB("[{" ..
				string.format("%06X", ARGBtoRGB(sampGetPlayerColor(myID))) ..
				"}" ..
				(as.other.colorlist[sampGetPlayerColor(myID)] ~= nil and as.other.colorlist[sampGetPlayerColor(myID)] or "-") ..
				"{FFFFFF}]")
			end
		end

		if im.informer.infFracRang.v then
			if frac ~= nil and rang ~= nil then
				var_0_0.Text(var_0_7.ICON_ID_CARD_O .. u8(" " .. frac .. " | " .. rang))
			else
				var_0_0.Text(var_0_7.ICON_ID_CARD_O .. u8(" ����������� | ����"))
			end
		end

		if im.informer.infPatrolArea.v then
			var_0_0.Text(u8("���������� �������: ") .. string.upper(u8(se.main.area)))
		end

		if im.informer.infPartner.v then
			if se.main.partner ~= 0 then
				local var_199_4, var_199_5 = sampGetCharHandleBySampPlayerId(se.main.partner)

				if var_199_4 and doesCharExist(var_199_5) then
					var_0_0.Text(u8("��������: ") ..
					sampGetPlayerNickname(se.main.partner) .. "[" .. se.main.partner .. "]")
				else
					var_0_0.Text(u8("��������: -"))
				end
			else
				var_0_0.Text(u8("��������: -"))
			end
		end

		var_0_0.Separator()

		if CL_CAR and im.informer.infMainFastPursuit.v and isCharInAnyCar(playerPed) then
			var_0_0.Text(var_0_7.ICON_CAR .. u8(" ���������: ") .. CL_CAR)
		end

		if im.informer.infSprint.v and not isCharInAnyCar(playerPed) then
			if im.informer.infNewProgressbar.v then
				var_0_0.Text(var_0_7.ICON_CHILD .. " ")
				var_0_0.SameLine()
				var_0_0.AnimProgressBar("my_sprint", tonumber(getSprintLocalPlayer()), var_0_0.ImVec4(1, 1, 0, 0.4))
			else
				var_0_0.Text((getSprintLocalPlayer() >= 80 and var_0_7.ICON_BATTERY_FULL or getSprintLocalPlayer() >= 50 and var_0_7.ICON_BATTERY_THREE_QUARTERS or getSprintLocalPlayer() >= 25 and var_0_7.ICON_BATTERY_HALF or getSprintLocalPlayer() >= 10 and var_0_7.ICON_BATTERY_QUARTER or var_0_7.ICON_BATTERY_EMPTY) ..
				u8(" ������������: " .. getSprintLocalPlayer()))
			end
		end

		if im.informer.infOxygen.v and isCharInWater(playerPed) then
			if im.informer.infNewProgressbar.v then
				var_0_0.Text(var_0_7.ICON_SNOWFLAKE_O)
				var_0_0.SameLine()
				var_0_0.AnimProgressBar("my_oxygen", tonumber(getWaterLocalPlayer()), var_0_0.ImVec4(0.2, 0.5, 1, 0.4))
			else
				var_0_0.Text((getWaterLocalPlayer() >= 80 and var_0_7.ICON_BATTERY_FULL or getWaterLocalPlayer() >= 50 and var_0_7.ICON_BATTERY_THREE_QUARTERS or getWaterLocalPlayer() >= 25 and var_0_7.ICON_BATTERY_HALF or getWaterLocalPlayer() >= 10 and var_0_7.ICON_BATTERY_QUARTER or var_0_7.ICON_BATTERY_EMPTY) ..
				u8(" ��������: " .. getWaterLocalPlayer()))
			end
		end

		if im.informer.infHP.v then
			if im.informer.infNewProgressbar.v then
				var_0_0.Text(var_0_7.ICON_HEARTBEAT)
				var_0_0.SameLine()
				var_0_0.AnimProgressBar("my_health", tonumber(inform_arr.healNew), var_0_0.ImVec4(1, 0, 0, 0.4))
			else
				var_0_0.Text(var_0_7.ICON_HEARTBEAT .. u8(" ��������: " .. inform_arr.healNew))
			end
		end

		if im.informer.infArmour.v then
			if im.informer.infNewProgressbar.v then
				var_0_0.Text(var_0_7.ICON_SHIELD .. " ")
				var_0_0.SameLine()
				var_0_0.AnimProgressBar("my_armour", tonumber(inform_arr.armourNew))
			else
				var_0_0.Text(var_0_7.ICON_SHIELD .. u8(" �����: " .. inform_arr.armourNew))
			end
		end

		if im.informer.infWeapon.v then
			var_0_0.Text(var_0_7.ICON_ROCKET .. u8(" ������: " .. inform_arr.weaponNew))

			if getCurrentCharWeapon(playerPed) ~= 0 and getCurrentCharWeapon(playerPed) ~= 3 and getCurrentCharWeapon(playerPed) ~= 46 then
				var_0_0.Text(var_0_7.ICON_DOT_CIRCLE_O ..
				u8(" �������: " ..
				getAmmoInClip() ..
				"/" .. getAmmoInCharWeapon(playerPed, getCurrentCharWeapon(playerPed)) - getAmmoInClip()))
			end
		end

		if im.informer.grenade.v and getCurrentCharWeapon(playerPed) == 17 then
			var_0_0.Text((as.other.grenade == 0 and var_0_7.ICON_CLOUD or var_0_7.ICON_BOLT) ..
			u8(" ��� �������: " .. (as.other.grenade == 0 and "�������" or "������������")))
		end

		if im.informer.infTaser.v and (isPlayerCop(cop, getCharModel(playerPed)) or isPlayerCop(fbi, getCharModel(playerPed))) then
			var_0_0.Text(var_0_7.ICON_BOLT)
			var_0_0.SameLine()
			var_0_0.TextColoredRGB("�����: " ..
			(tazer_state == "ON" and "{00FF00}�������{FFFFFF}" or "��������") ..
			(as.other.taser_timer >= os.time() and " {FF0000}[" .. math.ceil(as.other.taser_timer - os.time()) .. " ���]{FFFFFF}" or ""))
		end

		if im.informer.infMoney.v then
			var_0_0.Text(var_0_7.ICON_USD .. u8(" �������: $" .. inform_arr.moneyNew))
		end

		if im.informer.hpStatus and sampIsPlayerConnected(hpID) then
			var_0_0.Separator()
			var_0_0.Text(var_0_7.ICON_USER_CIRCLE_O .. u8(" ����: " .. sampGetPlayerNickname(hpID) .. "[" .. hpID .. "]"))
		end

		if im.informer.infWanted.v then
			local var_199_6 = var_0_11.getuint8(5823328)

			if var_199_6 > 0 then
				var_0_0.Text(var_0_7.ICON_BINOCULARS)
				var_0_0.SameLine()
				var_0_0.TextColoredRGB("������: {FF0000}" .. var_199_6)
			end
		end

		if im.informer.infHP.v or im.informer.infArmour.v or im.informer.infWeapon.v or im.informer.infMoney.v then
			var_0_0.Separator()
		end

		if im.informer.infCity.v then
			var_0_0.Text(var_0_7.ICON_CIRCLE_THIN .. u8(" �����: " .. playerCity))
		end

		if im.informer.infArea.v then
			var_0_0.Text(var_0_7.ICON_GG_CIRCLE .. u8(" �����: " .. calcZ(var_199_1, var_199_2, var_199_3)))
		end

		if im.informer.direction.v then
			var_0_0.Text(var_0_7.ICON_COMPASS .. u8(" �����������: " .. mydirection(playerPed)))
		end

		if im.informer.infKv.v then
			var_0_0.Text(var_0_7.ICON_COMPASS .. u8(" �������: " .. tostring(kvadUli(playerPed))))
		end

		if im.informer.infCarSpawn.v and endTime > os.clock() and carSpawnTime then
			var_0_0.Text(var_0_7.ICON_CLOCK_O)
			var_0_0.SameLine()
			var_0_0.TextColoredRGB("����� ���������� ��: {" .. spawnColor .. "}" .. os.date("%M:%S", carSpawnTime))
		end

		if im.informer.infZp.v then
			if PayCheck ~= nil then
				var_0_0.Text(var_0_7.ICON_USD .. u8(" ��������: $" .. PayCheck))
			else
				var_0_0.Text(var_0_7.ICON_USD .. u8(" ��������: -"))
			end
		end

		if im.informer.infStenovisor.v then
			local var_199_7 = sampGetPlayerCount(true) - 1
			local var_199_8 = var_199_7 > 0 and
			(tostring(var_199_7):len() == 1 and (var_199_7 > 1 and (var_199_7 < 5 and "��������" or "�������") or "�������") or tonumber(tostring(var_199_7):match("%d+(%d)$")) > 1 and (tonumber(tostring(var_199_7):match("^(%d)%d+$")) ~= 1 and (tonumber(tostring(var_199_7):match("%d+(%d)$")) < 5 and "��������" or "�������") or "�������") or "�������") or
			""

			var_0_0.Text(var_0_7.ICON_LAPTOP ..
			u8(" ����������: " .. (var_199_7 > 0 and tostring(var_199_7) .. " " .. var_199_8 or "�� ���������")))
		end

		if im.informer.infDepTimerState.v then
			if im.informer.dep_timer.v >= os.time() then
				local var_199_9 = var_0_7.ICON_HOURGLASS_START

				if im.informer.dep_timer.v - os.time() < 10 then
					var_199_9 = var_0_7.ICON_HOURGLASS_HALF
				end

				if im.informer.dep_timer.v - os.time() < 3 then
					var_199_9 = var_0_7.ICON_HOURGLASS_END
				end

				var_0_0.Text(var_199_9 .. u8(" ����� ������������: " .. im.informer.dep_timer.v - os.time() .. " ���."))
			else
				var_0_0.Text(var_0_7.ICON_HOURGLASS_END .. u8(" ����� ������������: ��������"))
			end
		end

		if im.informer.infGameTime.v then
			todayingame = as.other.ongametime + as.other.allgametime > 3600 and
			os.date("%H", as.other.ongametime + as.other.allgametime) - 5 ..
			os.date(":%M:%S", as.other.ongametime + as.other.allgametime) or
			os.date("%M:%S", as.other.ongametime + as.other.allgametime)

			var_0_0.Text(var_0_7.ICON_CLOCK_O .. u8(" � ���� �� �������: " .. todayingame))
		end

		if im.informer.infTime.v then
			var_0_0.Text(var_0_7.ICON_HISTORY .. u8(" �����: " .. os.date("%H:%M:%S - %d/%m/%y")))
		end

		var_0_0.End()
	end

	var_0_0.PopStyleColor()
end

function partner_informer()
	if as.partner.name ~= nil and as.partner.name ~= "" and se.main.partner ~= 0 and _G.mass[mkey] then
		var_0_0.SetNextWindowPos(var_0_0.ImVec2(tonumber(se.partner.x), tonumber(se.partner.y)), var_0_0.ImVec2(0.5, 0.5))
		var_0_0.SetNextWindowSize(var_0_0.ImVec2(250, 200), var_0_0.Cond.FirstUseEver)
		var_0_0.PushStyleColor(var_0_0.Col.WindowBg, var_0_0.ImVec4(0, 0, 0, 0.3))

		if var_0_0.Begin("Partner Informer", im.windows.partner, var_0_0.WindowFlags.NoTitleBar + var_0_0.WindowFlags.NoResize + var_0_0.WindowFlags.AlwaysAutoResize + var_0_0.WindowFlags.NoSavedSettings) then
			if as.partner.name ~= nil and as.partner.name ~= "" then
				var_0_0.Text(var_0_7.ICON_ID_CARD ..
				u8(" ��������: ") .. as.partner.name .. "[" .. se.main.partner .. "]")

				if as.partner.color ~= nil and as.partner.color ~= "" then
					var_0_0.SameLine()
					var_0_0.TextColoredRGB2("{" .. as.partner.color .. "}" .. var_0_7.ICON_USER_O)
				else
					var_0_0.SameLine()
					var_0_0.TextColoredRGB2("{FFFFFF}" .. var_0_7.ICON_USER_O)
				end
			else
				var_0_0.Text(var_0_7.ICON_ID_CARD .. u8(" ��������: ��������� �������� ���������"))
			end

			if as.partner.rang ~= nil and as.partner.rang ~= "" then
				var_0_0.Text(var_0_7.ICON_ID_CARD_O .. u8(" ������: " .. as.partner.rang))
			else
				var_0_0.Text(var_0_7.ICON_ID_CARD_O .. u8(" ������: ��������� �������� ���������"))
			end

			if as.partner.health ~= nil and as.partner.health ~= "" then
				var_0_0.Text(var_0_7.ICON_HEARTBEAT)
				var_0_0.SameLine()
				var_0_0.AnimProgressBar("partner_health", tonumber(as.partner.health), var_0_0.ImVec4(1, 0, 0, 0.4))
			end

			if as.partner.armour ~= nil and as.partner.armour ~= "" then
				var_0_0.Text(var_0_7.ICON_SHIELD .. " ")
				var_0_0.SameLine()
				var_0_0.AnimProgressBar("partner_armour", tonumber(as.partner.armour))
			end

			if as.partner.weapon ~= nil and as.partner.weapon ~= "" then
				var_0_0.Text(var_0_7.ICON_ROCKET .. u8(" ������: " .. getGun(as.partner.weapon)))

				if tonumber(as.partner.weapon) ~= 0 and tonumber(as.partner.weapon) ~= 3 and tonumber(as.partner.weapon) ~= 46 and as.partner.bullets ~= nil then
					var_0_0.Text(var_0_7.ICON_DOT_CIRCLE_O .. u8(" �������: " .. as.partner.bullets))
				end
			end

			if as.partner.sector ~= nil and as.partner.sector ~= "" then
				var_0_0.Text(var_0_7.ICON_COMPASS .. u8(" �������: " .. as.partner.sector))
			end

			var_0_0.End()
		end

		var_0_0.PopStyleColor()
	end
end

function mycard()
	var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_0_94 / 2, var_0_95 / 2), var_0_0.Cond.FirstUseEver,
		var_0_0.ImVec2(0.5, 0.5))
	var_0_0.SetNextWindowSize(var_0_0.ImVec2(450, 215), var_0_0.Cond.FirstUseEver)
	var_0_0.Begin(u8("������ �� ") .. (tostring(myfrac) == "4" and u8("������") or u8("�������")), im.windows.mycard,
		var_0_0.WindowFlags.NoTitleBar + var_0_0.WindowFlags.NoResize)
	var_0_0.Separator()
	var_0_0.Columns(2)
	var_0_0.Text(u8(tostring(myfrac) == "4" and "�����" or "������"))
	var_0_0.NextColumn()
	var_0_0.Text(myName:gsub("_", " "))
	var_0_0.Columns(1)
	var_0_0.Separator()
	var_0_0.Columns(2)
	var_0_0.Text(u8("�����������"))
	var_0_0.NextColumn()
	var_0_0.Text(u8(fracn))
	var_0_0.Columns(1)
	var_0_0.Separator()
	var_0_0.Columns(2)
	var_0_0.Text(u8("����"))
	var_0_0.NextColumn()
	var_0_0.Text(u8(rang))
	var_0_0.Columns(1)
	var_0_0.Separator()
	var_0_0.Columns(2)
	var_0_0.Text(u8("�������"))
	var_0_0.NextColumn()
	var_0_0.Text(u8(as.mycard.hours ~= "" and as.mycard.hours or "������ �����������..."))
	var_0_0.Columns(1)
	var_0_0.Separator()
	var_0_0.Columns(2)
	var_0_0.SetColumnWidth(-1, 200)
	var_0_0.Text(u8("���� ���������� ���������"))
	var_0_0.NextColumn()
	var_0_0.Text(u8(as.mycard.uprank ~= "" and as.mycard.uprank or "������ �����������..."))
	var_0_0.Columns(1)
	var_0_0.Separator()
	var_0_0.Columns(2)
	var_0_0.Text(u8("��������"))
	var_0_0.NextColumn()
	var_0_0.Text(u8(as.mycard.warns ~= "" and as.mycard.warns or "������ �����������..."))
	var_0_0.Columns(1)
	var_0_0.Separator()
	var_0_0.Columns(2)
	var_0_0.Text(u8("��������������"))
	var_0_0.NextColumn()
	var_0_0.Text(u8(as.mycard.notice ~= "" and as.mycard.notice or "������ �����������..."))
	var_0_0.Columns(1)
	var_0_0.Separator()
	var_0_0.Columns(2)
	var_0_0.Text((im.informer.infMainSex.v and u8("������") or u8("�������")) .. u8(" � �����������"))
	var_0_0.NextColumn()
	var_0_0.Text(u8(as.mycard.invited ~= "" and as.mycard.invited or "������ �����������..."))
	var_0_0.Columns(1)
	var_0_0.Separator()
	var_0_0.PushStyleColor(var_0_0.Col.Button, var_0_0.ImVec4(0, 0, 0, 0.5))
	var_0_0.PushStyleColor(var_0_0.Col.ButtonHovered, var_0_0.ImVec4(0.2, 0.2, 0.3, 0.5))
	var_0_0.PushStyleColor(var_0_0.Col.ButtonActive, var_0_0.ImVec4(0, 0, 0, 0.5))

	if var_0_0.Button(u8("�������"), var_0_96) then
		im.windows.mycard.v = not im.windows.mycard.v
	end

	var_0_0.PopStyleColor()
	var_0_0.PopStyleColor()
	var_0_0.PopStyleColor()
	var_0_0.End()
end

function pursuit_state_f()
	armourNew = getCharArmour(playerPed)
	healNew = getCharHealth(playerPed)

	local var_202_0 = getCityPlayerIsIn(playerPed)

	if var_202_0 > 0 then
		playerCity = as.other.citiesList[var_202_0]
	else
		playerCity = "��� �������"
	end

	local var_202_1, var_202_2, var_202_3 = getCharCoordinates(playerPed)

	var_0_0.SetNextWindowPos(var_0_0.ImVec2(pursX, pursY), var_0_0.ImVec2(0.5, 0.5))
	var_0_0.SetNextWindowSize(var_0_0.ImVec2(250, 200), var_0_0.Cond.FirstUseEver)
	var_0_0.PushStyleColor(var_0_0.Col.WindowBg, var_0_0.ImVec4(0, 0, 0, 0.3))

	if var_0_0.Begin("PD-Project Pursuit", var_0_44, var_0_0.WindowFlags.NoTitleBar + var_0_0.WindowFlags.NoResize + var_0_0.WindowFlags.AlwaysAutoResize + var_0_0.WindowFlags.NoSavedSettings) then
		if suspect_veh_handle ~= nil and doesVehicleExist(suspect_veh_handle) then
			suspect_health = getCarHealth(suspect_veh_handle)
		elseif suspect_id ~= nil then
			local var_202_4, var_202_5 = sampGetCharHandleBySampPlayerId(suspect_id)

			if var_202_4 and doesCharExist(var_202_5) and isCharInAnyCar(var_202_5) then
				suspect_veh_handle = storeCarCharIsInNoSave(var_202_5)
				suspect_health = getCarHealth(suspect_veh_handle)
			end
		end

		if suspect_veh ~= nil then
			var_0_0.Text(var_0_7.ICON_CAR ..
			u8(" ������������: " .. suspect_veh .. " [" .. (suspect_health ~= nil and suspect_health or "-") .. "]"))
		else
			var_0_0.Text(var_0_7.ICON_CAR .. u8(" ������������: -"))
		end

		if suspect_num ~= nil then
			var_0_0.Text(var_0_7.ICON_ID_CARD_O .. u8(" ��� �����: " .. suspect_num))
		else
			var_0_0.Text(var_0_7.ICON_ID_CARD_O .. u8(" ��� �����: -"))
		end

		if sampIsPlayerConnected(suspect_id) then
			var_0_0.Text(var_0_7.ICON_ID_CARD ..
			u8(" ��������: " .. sampGetPlayerNickname(suspect_id) .. "[" .. suspect_id .. "]"))
		else
			var_0_0.Text(var_0_7.ICON_ID_CARD .. u8(" ��������: -"))
		end

		if im.pursuit.sector.v then
			if sampIsPlayerConnected(suspect_id) then
				local var_202_6, var_202_7 = sampGetCharHandleBySampPlayerId(suspect_id)

				if var_202_6 and doesCharExist(var_202_7) then
					var_0_0.Text(var_0_7.ICON_COMPASS .. u8(" ����������: " .. kvad(var_202_7)))
				else
					var_0_0.Text(var_0_7.ICON_COMPASS .. u8(" ����������: -"))
				end
			else
				var_0_0.Text(var_0_7.ICON_COMPASS .. u8(" ����������: -"))
			end
		end

		if sampIsPlayerConnected(suspect_id) then
			local var_202_8, var_202_9 = sampGetCharHandleBySampPlayerId(suspect_id)

			if var_202_8 and doesCharExist(var_202_9) then
				if isCharInAnyCar(var_202_9) then
					local var_202_10 = storeCarCharIsInNoSave(var_202_9)

					if var_202_10 then
						var_0_0.Text(var_0_7.ICON_TACHOMETER ..
						u8(" ��������: " ..
						(as.other.speeds[var_202_10] ~= nil and as.other.speeds[var_202_10] or "-") .. " ��/�"))
					else
						var_0_0.Text(var_0_7.ICON_TACHOMETER .. u8(" ��������: -"))
					end
				else
					var_0_0.Text(var_0_7.ICON_TACHOMETER .. u8(" ��������: -"))
				end

				var_0_0.Text(var_0_7.ICON_COMPASS .. u8(" �����������: " .. mydirection(var_202_9)))
			else
				var_0_0.Text(var_0_7.ICON_TACHOMETER .. u8(" ��������: -"))
				var_0_0.Text(var_0_7.ICON_COMPASS .. u8(" �����������: -"))
			end
		else
			var_0_0.Text(var_0_7.ICON_TACHOMETER .. u8(" ��������: -"))
		end

		var_0_0.End()
	end

	var_0_0.PopStyleColor()
end

function getAmmoInClip()
	local var_203_0 = getCharPointer(playerPed)
	local var_203_1 = var_203_0 + 1816
	local var_203_2 = var_0_11.getint8(var_203_1, false) * 28
	local var_203_3 = var_203_0 + 1440 + var_203_2 + 8

	return (var_0_11.getint32(var_203_3, false))
end

function vspdAddByVeh(arg_204_0)
	if doesVehicleExist(arg_204_0) then
		as.other.vspd[#as.other.vspd], as.other.speeds[arg_204_0] = arg_204_0, 0
	end
end

function vspdAddByChar(arg_205_0)
	if doesCharExist(arg_205_0) and isCharInAnyCar(arg_205_0) then
		vspdAddByVeh(storeCarCharIsInNoSave(arg_205_0))
	end
end

function vspd()
	while true do
		wait(300)

		for iter_206_0, iter_206_1 in pairs(as.other.vspd) do
			if not doesVehicleExist(iter_206_1) then
				as.other.vspd[iter_206_0], as.other.speeds[iter_206_1] = nil, 0
			else
				as.other.speeds[iter_206_1] = math.ceil(getCarSpeed(iter_206_1) * 2)
			end
		end
	end
end

function getMySpeed()
	lua_thread.create(function()
		while true do
			wait(0)

			if isCharInAnyCar(playerPed) and sampGetGamestate() == 3 then
				local var_208_0 = storeCarCharIsInNoSave(playerPed)

				if var_208_0 then
					speedMyMile = getCarSpeed(var_208_0)
					speedMyKM = round(speedMyMile * 2)

					wait(50)
				end
			end
		end
	end)
end

function selectedIm7()
	var_0_0.Separator()
	var_0_0.Image(var_0_15.settings_cruisecontrol, var_0_0.ImVec2(715, 80))
	var_0_0.Separator()
	var_0_0.Text(var_0_7.ICON_INFO .. u8(" ����� ���������:\n"))
	var_0_0.BeginChild("left pane##4", var_0_0.ImVec2(712, 343), true)
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_EYE_SLASH .. u8(" ������ ������ ����������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("������ ������ ����������"), im.windows.speedometr)

	if se.main.speedometr ~= im.windows.speedometr.v then
		if im.windows.speedometr.v == false then
			restoreSpeedometer()
		end

		if im.windows.speedometr.v == true then
			onceDeleteSpeedometer()
		end

		se.main.speedometr = im.windows.speedometr.v
	end

	if var_0_0.Combo(u8("������ ����������##speedometr_size"), im.settings.speedometr_size, as.other.speedometr_size_combo) then
		se.main.speedometr_size = im.settings.speedometr_size.v
	end

	var_0_0.SameLine()
	showHelp(u8(
	"���������� / �� ���������� ������ ������ ���������� ������ �����������. ����� ���������� ���������� ������������� ������."))
	var_0_0.Text(u8("������ ���������� ���������� ����� ���������� � ������������ �������."))
	var_0_0.Text(u8("��������! ���� �� ������������ ������ � ����������, ����������� ��������� ��������� �� classic:"))
	var_0_0.Text(u8("������� /mm, ��������� � '���������', ����� '���������' � ����������� ��������� �� CLASSIC!"))
	var_0_0.Separator()
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_EYE_SLASH .. u8(" ������ �����-��������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("������ �����-��������"), im.informer.infMainCruise)

	se.main.cruise = im.informer.infMainCruise.v

	var_0_0.SameLine()
	showHelp(u8("���������� / �� ���������� ������ �����-��������."))
	var_0_0.SameLine()

	if var_0_0.Button(u8("�������� ���������##3")) then
		mouseCoord4 = true
		var_0_42.v = false
	end

	var_0_0.Separator()
	var_0_0.Text(u8(
	"�����-�������� ������������ ����� �������, ������� ������������ � ���������� �������� ������������� ��������."))
	var_0_0.Text(u8("����� �������� �����-�������� �� ����� ���������� �����������, ���������� ������ SHIFT."))
	var_0_0.Text(u8("����������� ������ ���� ������� ������ �����-��������, ����� �� �� ������� �������� �������."))
	var_0_0.Text(u8("����� ������� ������� SHIFT, �� ��������� �������� ������ ���������� �����."))
	var_0_0.Separator()
	var_0_0.Text(u8("�� �������� ������������ ���������:"))

	if var_0_0.Button(var_0_7.ICON_CARET_SQUARE_O_RIGHT) then
		-- block empty
	end

	var_0_0.SameLine()
	var_0_0.Text(u8("- �������� �����-��������."))

	if var_0_0.Button(var_0_7.ICON_CARET_SQUARE_O_UP) then
		-- block empty
	end

	var_0_0.SameLine()
	var_0_0.Text(u8("- ��������� 10 � �������� �����-��������."))

	if var_0_0.Button(var_0_7.ICON_CARET_SQUARE_O_DOWN) then
		-- block empty
	end

	var_0_0.SameLine()
	var_0_0.Text(u8("- ������� �������� �� 10 �����-��������."))

	if var_0_0.Button(var_0_7.ICON_STOP_CIRCLE) then
		-- block empty
	end

	var_0_0.SameLine()
	var_0_0.Text(u8("- ��������� �����-��������."))

	if var_0_0.Button(var_0_7.ICON_LINE_CHART) then
		-- block empty
	end

	var_0_0.SameLine()
	var_0_0.Text(u8("- ���������� ������������ ��������."))
	var_0_0.Text(u8("�����-�������� ����� ���������, ����� ������� S."))
	var_0_0.Separator()
	var_0_0.Text(u8("�� ���������� Maverick:"))

	if var_0_0.Button(var_0_7.ICON_CARET_SQUARE_O_RIGHT) then
		-- block empty
	end

	var_0_0.SameLine()
	var_0_0.Text(u8("- �������� ��������� ��� ��������� ������."))

	if var_0_0.Button(var_0_7.ICON_CARET_SQUARE_O_UP) then
		-- block empty
	end

	var_0_0.SameLine()
	var_0_0.Text(u8("- ���� 10 �. � ������ ������."))

	if var_0_0.Button(var_0_7.ICON_CARET_SQUARE_O_DOWN) then
		-- block empty
	end

	var_0_0.SameLine()
	var_0_0.Text(u8("- ����� 10 �. �� ������ ������."))

	if var_0_0.Button(var_0_7.ICON_STOP_CIRCLE) then
		-- block empty
	end

	var_0_0.SameLine()
	var_0_0.Text(u8("- ��������� ���������."))

	if var_0_0.Button(var_0_7.ICON_CERTIFICATE) then
		-- block empty
	end

	var_0_0.SameLine()
	var_0_0.Text(u8(
	"- ������������� �������� �� ������� ����������� (���������� �������� �������� � ��������� ��������)."))
	var_0_0.Text(u8("��������� ����� ���������, ����� �� ������� S."))
	var_0_0.Separator()
	var_0_0.PushTextWrapPos()
	var_0_0.Text(u8(
	"����� �� ���������� � ��������� Maverick, � ��������� ������������� �������� ������ \"������\", ����������� ����������� ������ � ������ �� ����������� ����� ��� ������, ��� ������� ����������, ����� � ���������� ������� ����������� �������� \"�.�.\" - ��� �������� ������ �� ����������� ����. ��� ��������� ������ � ���������� ������ ����������� ������ � �.�."))
	var_0_0.EndChild()
end

function selectedIm5()
	var_0_0.Separator()
	var_0_0.Image(var_0_15.settings_hotkeys, var_0_0.ImVec2(715, 80))
	var_0_0.Separator()
	var_0_0.Text(var_0_7.ICON_INFO .. u8(" ������� �������"))
	var_0_0.SameLine()

	if var_0_0.Button(u8("�������� ��������� ���������")) then
		mouseCoord5 = true
		var_0_42.v = false

		am("�������� ������ ����� � ������� ENTER.")
	end

	var_0_0.SameLine()

	if var_0_0.Button(u8("�������� ��������� ��������� ��� ������������")) then
		mouseCoord6 = true
		var_0_42.v = false

		am("�������� ����� ����� � ������� ENTER.")
	end

	var_0_0.BeginChild("left pane##8", var_0_0.ImVec2(0, 0), true)
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text((im.informer.infMainHotBbool.v and var_0_7.ICON_CHECK_CIRCLE_O or var_0_7.ICON_CIRCLE_O) ..
	u8(" ������ ������� ������� 'B'"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("������ ������� ������� 'B'"), im.informer.infMainHotBbool)

	se.main.hotBbool = im.informer.infMainHotBbool.v

	var_0_0.SameLine()
	showHelp(u8("������������ / �������������� ������� ������� ������� \"B\"."))
	var_0_0.Text(var_0_7.ICON_ARROW_CIRCLE_RIGHT .. u8(" B + 1 - ����������� � ���. ��� ����� ������ � �������."))
	var_0_0.Text(var_0_7.ICON_ARROW_CIRCLE_RIGHT .. u8(" B + 2 - ���������� ���������� �� �����."))
	var_0_0.Text(var_0_7.ICON_ARROW_CIRCLE_RIGHT .. u8(" B + 3 - �������� ����� �� �����."))
	var_0_0.Text(var_0_7.ICON_ARROW_CIRCLE_RIGHT .. u8(" B + 4 - ������� �������� � �������� ������."))
	var_0_0.Text(var_0_7.ICON_ARROW_CIRCLE_RIGHT .. u8(" B + 5 - ������ ������ ���������."))
	var_0_0.Text(var_0_7.ICON_ARROW_CIRCLE_RIGHT .. u8(" B + 6 - ��������� ��������."))
	var_0_0.Text(var_0_7.ICON_ARROW_CIRCLE_RIGHT .. u8(" B + 7 - ������ ������ ��������� �������."))
	var_0_0.Text(var_0_7.ICON_ARROW_CIRCLE_RIGHT .. u8(" B + 8 - ������ ������ ��������� ������."))
	var_0_0.Text(var_0_7.ICON_ARROW_CIRCLE_RIGHT .. u8(" B + 9 - ��������� ������ ������."))
	var_0_0.Text(var_0_7.ICON_ARROW_CIRCLE_RIGHT .. u8(" B + 0 - ���������� ������ ������ �� ��������."))
	var_0_0.Separator()
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text((im.informer.infMainHotZbool.v and var_0_7.ICON_CHECK_CIRCLE_O or var_0_7.ICON_CIRCLE_O) ..
	u8(" ������ ������� ������� 'Z'"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("������ ������� ������� 'Z'"), im.informer.infMainHotZbool)

	se.main.hotZbool = im.informer.infMainHotZbool.v

	var_0_0.SameLine()
	showHelp(u8("������������ / �������������� ������� ������� ������� \"Z\"."))
	var_0_0.Text(var_0_7.ICON_ARROW_CIRCLE_RIGHT ..
	u8(" Z + 1 - ��������� /do ������ ������. �������������� ���������� ���������."))
	var_0_0.Text(var_0_7.ICON_ARROW_CIRCLE_RIGHT .. u8(" Z + 2 - �������� ������� ������� ������������."))
	var_0_0.Text(var_0_7.ICON_ARROW_CIRCLE_RIGHT ..
	u8(" Z + 3 - SOS �� ���� ����������, ������� ���������� ������������� (���������� �� � ����)."))
	var_0_0.Text(var_0_7.ICON_ARROW_CIRCLE_RIGHT .. u8(" Z + 4 - �������� � 10-66 �� ����� ��������."))
	var_0_0.Text(var_0_7.ICON_ARROW_CIRCLE_RIGHT ..
	u8(" Z + 5 - ���������� �������� �� ���� � ����, ���� ������ - /cuff."))
	var_0_0.Text(var_0_7.ICON_ARROW_CIRCLE_RIGHT .. u8(" Z + 6 - �������� �� ������ (/ceject � ����������)"))
	var_0_0.Text(var_0_7.ICON_ARROW_CIRCLE_RIGHT .. u8(" Z + 7 - �������� �������� �� ������ (/ceject � ����������)"))
	var_0_0.Separator()
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text((im.informer.infMainHotXbool.v and var_0_7.ICON_CHECK_CIRCLE_O or var_0_7.ICON_CIRCLE_O) ..
	u8(" ������ ������� ������� 'X'"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("������ ������� ������� 'X'"), im.informer.infMainHotXbool)

	se.main.hotXbool = im.informer.infMainHotXbool.v

	var_0_0.SameLine()
	showHelp(u8("������������ / �������������� ������� ������� ������� \"X\"."))
	var_0_0.Text(var_0_7.ICON_ARROW_CIRCLE_RIGHT ..
	u8(" X + 1 - ������ � ������ � �������. �������������� ���������� ��������� � �������� ����."))
	var_0_0.Text(var_0_7.ICON_ARROW_CIRCLE_RIGHT ..
	u8(" X + 2 - �������� � 10-0 � �������. �������������� ���������� ���� � ���������."))
	var_0_0.Text(var_0_7.ICON_ARROW_CIRCLE_RIGHT .. u8(" X + 3 - �������� � 10-2."))
	var_0_0.Text("")
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_ARROW_CIRCLE_RIGHT .. u8(" ������� ������� \"R\" ������� ��� ��� �����."))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("������� ������� \"R\" ������� ��� ��� �����."), im.informer.infMainDoubleR)

	se.main.doubleR = im.informer.infMainDoubleR.v

	var_0_0.SameLine()
	showHelp(u8("������������ / �������������� ������� �������� ���� �� �������� ������� \"R\"."))
	var_0_0.EndChild()
end

function selectedIm3()
	var_0_0.Separator()
	var_0_0.Image(var_0_15.settings_informer, var_0_0.ImVec2(715, 80))
	var_0_0.Separator()
	var_0_0.BeginChild("left pane##3", var_0_0.ImVec2(0, 0), true)
	var_0_0.Text(var_0_7.ICON_COG .. u8(" ��������� ���������:\n"))
	var_0_0.SameLine()
	showHelp(u8(
	"����� �������� ��������� ���������, ������� � ��� /mswi �, ���������� �������� �� ������ �����, ������� ENTER."))
	var_0_0.Separator()
	var_0_0.Columns(2, _, false)
	var_0_0.SetColumnWidth(-1, 340)
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_EYE_SLASH .. u8(" ������ ���������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("������ ���������"), im.informer.infState)

	se.main.informer = im.informer.infState.v

	var_0_0.SameLine()
	showHelp(u8("���������� / �� ���������� ��������� �������� �� ���������."))
	var_0_0.SameLine()

	if var_0_0.Button(u8("�������� ���������")) then
		mouseCoord = true
		var_0_42.v = false
	end

	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_EYE_SLASH .. u8(" ���������� ����������� � ����"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� ����������� � ����"), im.informer.infFracRang)

	se.informer.fracrang = im.informer.infFracRang.v

	var_0_0.SameLine()
	showHelp(u8("���������� / �� ���������� ���� ����������� � ���� � ���."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_EYE_SLASH .. u8(" ���������� ���������� �������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� ���������� �������"), im.informer.infPatrolArea)

	se.informer.patrolarea = im.informer.infPatrolArea.v

	var_0_0.SameLine()
	showHelp(u8("���������� / �� ���������� ���� �������."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_EYE_SLASH .. u8(" ���������� ���������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� ���������"), im.informer.infPartner)

	se.informer.partner = im.informer.infPartner.v

	var_0_0.SameLine()
	showHelp(u8("���������� / �� ���������� ������ ���������."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_EYE_SLASH .. u8(" ���������� ������ ������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� ������ ������"), im.informer.infTaser)

	se.informer.taser = im.informer.infTaser.v

	var_0_0.SameLine()
	showHelp(u8("���������� / �� ���������� ������ ������ �� ���������."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_EYE_SLASH .. u8(" ������� �������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("������� �������"), im.informer.infWanted)

	se.main.wanted = im.informer.infWanted.v

	var_0_0.SameLine()
	showHelp(u8("���������� ������� �������, ���� ��� ����."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_EYE_SLASH .. u8(" ��� �������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("��� �������"), im.informer.grenade)

	se.informer.grenade = im.informer.grenade.v

	var_0_0.SameLine()
	showHelp(u8("���������� ��� ������� �� ���������, ����� ������� � ���� �������."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_COMPASS .. u8(" ���������� �����������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� �����������"), im.informer.direction)

	se.informer.direction = im.informer.direction.v

	var_0_0.SameLine()
	showHelp(u8("���������� / �� ���������� ����������� ������ ��������� � ���������."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_EYE_SLASH .. u8(" ������ ����� ������������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("������ ����� ������������"), im.informer.infDepTimerState)

	se.informer.deptimer = im.informer.infDepTimerState.v

	var_0_0.SameLine()
	showHelp(u8("���������� ������ � 15 ������ ����� ����������� �� ����� ������������ (/dep)."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_EYE_SLASH .. u8(" �������� ����������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("�������� ����������"), im.informer.infStenovisor)

	se.informer.stenovisor = im.informer.infStenovisor.v

	var_0_0.SameLine()
	showHelp(u8(
	"������� � ����� �������� ����������. ��� ���������� ���, ����������� �������� ������� ������� ������ ���������� ��������� �� ������ ������. ���������� ����� ���������� �� ��������� ����� ���� ����� ���� �� ��������� ���� � ������ ��������."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_EYE_SLASH .. u8(" ����� ������ HP & AR"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("����� ������ HP & AR"), im.informer.infNewProgressbar)

	se.informer.new_progressbar = im.informer.infNewProgressbar.v

	var_0_0.SameLine()
	showHelp(u8("�������� � ����� ������� � �������� � ����� ������� � ���� �������� ����."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_EYE_SLASH .. u8(" �������� ���� Clist �� �����"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("�������� ���� Clist �� �����"), im.informer.infShowClist)

	se.informer.showclist = im.informer.infShowClist.v

	var_0_0.SameLine()
	showHelp(u8("������� ������� ���� ���� � ��������� �� ������� ����� � ���������� ����� � ��� ����."))
	var_0_0.NextColumn()
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_HEARTBEAT .. u8(" ���������� ��������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� ��������"), im.informer.infHP)

	se.informer.hp = im.informer.infHP.v

	var_0_0.SameLine()
	showHelp(u8("���������� / �� ���������� ��������� �������� �� ���������."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_SHIELD .. u8(" ���������� �����"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� �����"), im.informer.infArmour)

	se.informer.armour = im.informer.infArmour.v

	var_0_0.SameLine()
	showHelp(u8("���������� / �� ���������� ��������� ����������� �� ���������."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_EYE_SLASH .. u8(" ���������� ������������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� ������������"), im.informer.infSprint)

	se.main.sprint = im.informer.infSprint.v

	var_0_0.SameLine()
	showHelp(u8("���������� / �� ���������� �������� ������������ �� ���������."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_EYE_SLASH .. u8(" ���������� ��������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� ��������"), im.informer.infOxygen)

	se.main.oxygen = im.informer.infOxygen.v

	var_0_0.SameLine()
	showHelp(u8("���������� / �� ���������� �������� ��������� �� ���������."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_SHIELD .. u8(" ���������� ������� ������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� ������� ������"), im.informer.infWeapon)

	se.informer.weapon = im.informer.infWeapon.v

	var_0_0.SameLine()
	showHelp(u8("���������� / �� ���������� ������� ������ � �����."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_USD .. u8(" ���������� ������� ������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� ������� ������"), im.informer.infMoney)

	se.informer.money = im.informer.infMoney.v

	var_0_0.SameLine()
	showHelp(u8("���������� / �� ���������� �������� �������� �� �����."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_CIRCLE_THIN .. u8(" ���������� �����"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� �����"), im.informer.infCity)

	se.informer.city = im.informer.infCity.v

	var_0_0.SameLine()
	showHelp(u8("���������� / �� ���������� ������� ����� �� ���������."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_GG_CIRCLE .. u8(" ���������� �����"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� �����"), im.informer.infArea)

	se.informer.area = im.informer.infArea.v

	var_0_0.SameLine()
	showHelp(u8("���������� / �� ���������� ������� ����� �� ���������."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_COMPASS .. u8(" ���������� ������ ����� (��)"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� ������ ����� (��)"), im.informer.infKv)

	se.informer.kv = im.informer.infKv.v

	var_0_0.SameLine()
	showHelp(u8("���������� / �� ���������� ������� ������� ����� �� ���������."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_CLOCK_O .. u8(" ���������� ������ ������ ���������� ��"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� ������ ������ ���������� ��"), im.informer.infCarSpawn)

	se.main.carspawn = im.informer.infCarSpawn.v

	var_0_0.SameLine()
	showHelp(u8("���������� / �� ���������� ������ ��������� ������� ����� ������ � ���������� �� ������."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_USD .. u8(" ���������� ��������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� ��������"), im.informer.infZp)

	se.informer.zp = im.informer.infZp.v

	var_0_0.SameLine()
	showHelp(u8("���������� / �� ���������� �������� �� ������� ���."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_CLOCK_O .. u8(" ���������� ���������� �����"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� ���������� �����"), im.informer.infGameTime)

	se.informer.gametime = im.informer.infGameTime.v

	var_0_0.SameLine()
	showHelp(u8(
	"���������� / �� ���������� �����, ������� �� ������� ������� � ����. ����������� ����� ����� � ������ AFK."))
	var_0_0.Columns(1)
	var_0_0.Columns(3, _, false)
	var_0_0.Separator()
	var_0_0.Text(var_0_7.ICON_COG .. u8(" ��������� ���������:\n"))
	var_0_0.SameLine()
	showHelp(u8(
	"��������� ���������, ������� ����� ���������� ��� � ���. �������� - ��� �����������, �������������� �� ������������ ���������."))
	var_0_0.Separator()
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text((im.warns.drugs.v and var_0_7.ICON_BELL_O or var_0_7.ICON_BELL_SLASH_O) .. u8(" ������� ����������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("������� ����������"), im.warns.drugs)

	se.warns.drugs = im.warns.drugs.v

	var_0_0.SameLine()
	showHelp(u8("����� ��������� ��� ������������ ���������� ��������, ������������ � ���� ��������� (200 �)."))
	var_0_0.NextColumn()
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text((im.warns.gribheal.v and var_0_7.ICON_BELL_O or var_0_7.ICON_BELL_SLASH_O) .. u8(" ������� ���������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("������� ���������"), im.warns.gribheal)

	se.warns.gribheal = im.warns.gribheal.v

	var_0_0.SameLine()
	showHelp(u8("����� ��������� ��� ������������ ��������� ��������, ������������ � ���� ��������� (200 �)."))
	var_0_0.NextColumn()
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text((im.warns.quits.v and var_0_7.ICON_BELL_O or var_0_7.ICON_BELL_SLASH_O) .. u8(" ������� ������ �� ����"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("������� ������ �� ����"), im.warns.quits)

	se.warns.quits = im.warns.quits.v

	var_0_0.SameLine()
	showHelp(u8("����� ��������� ��� ������ �� ���� �������, ������� ��������� � ���� ��������� (200 �)."))
	var_0_0.Columns(1)
	var_0_0.EndChild()
end

function selectedIm4()
	var_0_0.Separator()
	var_0_0.Image(var_0_15.settings_allcommands, var_0_0.ImVec2(715, 80))
	var_0_0.Separator()
	var_0_0.BeginChild("left pane##4", var_0_0.ImVec2(0, 0), true)
	var_0_0.Text(var_0_7.ICON_INFO .. u8(" �������� ������ ����:\n"))
	var_0_0.SameLine()
	var_0_0.SetCursorPos(var_0_0.ImVec2(380, 3))

	if var_0_0.Button(u8("����������")) then
		im.windows.hookchatinfo.v = not im.windows.hookchatinfo.v
	end

	var_0_0.SameLine()

	if var_0_0.Button(u8("��������� ���������")) then
		saveHooks()
	end

	var_0_0.SameLine()

	if var_0_0.Button(u8(as.other.hookchatAdd and "�������� ����������" or "�������� �����")) then
		as.other.hookchatAdd = not as.other.hookchatAdd
	end

	var_0_0.Separator()

	if as.other.hookchatAdd then
		var_0_0.SetNextTreeNodeOpen(true)

		if var_0_0.CollapsingHeader(u8("���������� ����� �������")) then
			var_0_0.InputText(u8("�������� �������##newhook"), as.other.addhookim.title)
			var_0_0.InputText(u8("������� ������##newhook"), as.other.addhookim.find)

			if var_0_0.Combo(u8("�������� ��������##newhook"), as.other.addhookim.select, as.other.hookchatcombo) then
				-- block empty
			end

			if as.other.addhookim.select.v == 1 then
				var_0_0.InputText(u8("����� ���������� � ���##newhook"), as.other.addhookim.message)
				var_0_0.InputText(u8("�������� ����� ��������� (1000=1���)##newhook"), as.other.addhookim.wait)
			elseif as.other.addhookim.select.v == 3 then
				var_0_0.Text("moonloader/PD-Project/hooklogs/")
				var_0_0.SameLine()
				var_0_0.PushItemWidth(300)
				var_0_0.InputText(u8("���� � ���-�����##newhook"), as.other.addhookim.log_file)
			end

			var_0_0.ToggleButton(u8("�������� �����������##newhook"), as.other.addhookim.sound)
			var_0_0.SameLine()
			var_0_0.Text(u8("�������� �����������"))
			var_0_0.ToggleButton(u8("����������� �����������##newhook"), as.other.addhookim.notify)
			var_0_0.SameLine()
			var_0_0.Text(u8("����������� �����������"))

			if var_0_0.Button(u8("����������� ����������##newhook"), var_0_96) then
				if as.other.addhookim.title.v and as.other.addhookim.title.v ~= "" and as.other.addhookim.find.v and as.other.addhookim.find.v ~= "" and as.other.addhookim.select.v > 0 then
					local var_212_0 = false

					if as.other.addhookim.select.v == 2 and not as.other.addhookim.sound.v and not as.other.addhookim.notify.v then
						var_212_0 = true
					end

					if as.other.addhookim.select.v == 1 and (as.other.addhookim.message.v == "" or as.other.addhookim.wait.v == "") then
						var_212_0 = true
					end

					if as.other.addhookim.select.v == 3 and as.other.addhookim.log_file.v == "" then
						var_212_0 = true
					end

					if not var_212_0 then
						local var_212_1 = #as.other.hookchat + 1

						as.other.hookchat[var_212_1] = {}
						as.other.hookchat[var_212_1].title = as.other.addhookim.title.v
						as.other.hookchat[var_212_1].find = as.other.addhookim.find.v
						as.other.hookchat[var_212_1].message = as.other.addhookim.message.v
						as.other.hookchat[var_212_1].wait = tostring(as.other.addhookim.wait.v)
						as.other.hookchat[var_212_1].log_file = as.other.addhookim.log_file.v
						as.other.hookchat[var_212_1].sound = as.other.addhookim.sound.v
						as.other.hookchat[var_212_1].notify = as.other.addhookim.notify.v
						as.other.hookchat[var_212_1].action = as.other.addhookim.select.v

						am("��������� ��������� �������. �� �������� ��������� ��������� ��������� ����!")
						hookChatRegister()

						as.other.hookchatAdd = not as.other.hookchatAdd
					else
						am("���-�� ������, ��������� ����� ����������� �� �������������� ����.")
					end
				else
					am("��������� ������������ ����: ��������, ������� �����, ��������.")
				end
			end
		end
	end

	for iter_212_0, iter_212_1 in pairs(as.other.hookchat) do
		if var_0_0.CollapsingHeader(iter_212_1.title) then
			var_0_0.InputText(u8("�������� �������##") .. iter_212_0, im.hookchat[iter_212_0].title)
			var_0_0.InputText(u8("������� ������##") .. iter_212_0, im.hookchat[iter_212_0].find)

			if var_0_0.Combo(u8("�������� ��������##") .. iter_212_0, im.hookchat[iter_212_0].select, as.other.hookchatcombo) then
				as.other.hookchat[iter_212_0].action = tostring(im.hookchat[iter_212_0].select.v)
			end

			if im.hookchat[iter_212_0].select.v == 1 then
				var_0_0.InputText(u8("����� ���������� � ���##") .. iter_212_0, im.hookchat[iter_212_0].message)
				var_0_0.InputText(u8("�������� ����� ��������� (1000=1���)##") .. iter_212_0,
					im.hookchat[iter_212_0].wait)
			elseif im.hookchat[iter_212_0].select.v == 3 then
				var_0_0.Text("moonloader/PD-Project/hooklogs/")
				var_0_0.SameLine()
				var_0_0.PushItemWidth(270)
				var_0_0.InputText(u8("���� � ���-�����##") .. iter_212_0, im.hookchat[iter_212_0].log_file)

				if var_0_0.Button(u8("������� ���� � ����������##" .. iter_212_0), var_0_96) then
					os.execute("\"" ..
					u8(getGameDirectory() ..
					"\\moonloader\\PD-Project\\hooklogs\\" .. im.hookchat[iter_212_0].log_file.v:gsub("/", "\\")) .. "\"")
				end
			end

			var_0_0.ToggleButton(u8("�������� �����������##") .. iter_212_0, im.hookchat[iter_212_0].sound)
			var_0_0.SameLine()
			var_0_0.Text(u8("�������� �����������"))
			var_0_0.ToggleButton(u8("����������� �����������##") .. iter_212_0, im.hookchat[iter_212_0].notify)
			var_0_0.SameLine()
			var_0_0.Text(u8("����������� �����������"))
			var_0_0.PushStyleColor(var_0_0.Col.Button, var_0_0.ImVec4(0, 0.75, 0.1, 0.6))
			var_0_0.PushStyleColor(var_0_0.Col.ButtonHovered, var_0_0.ImVec4(0, 0.75, 0.1, 0.85))
			var_0_0.PushStyleColor(var_0_0.Col.ButtonActive, var_0_0.ImVec4(0, 0.75, 0.1, 0.98))

			if var_0_0.Button(u8("��������� ��������� ���������##") .. iter_212_0, var_0_96) then
				as.other.hookchat[iter_212_0].title = im.hookchat[iter_212_0].title.v
				as.other.hookchat[iter_212_0].find = im.hookchat[iter_212_0].find.v
				as.other.hookchat[iter_212_0].message = im.hookchat[iter_212_0].message.v
				as.other.hookchat[iter_212_0].wait = im.hookchat[iter_212_0].wait.v
				as.other.hookchat[iter_212_0].log_file = im.hookchat[iter_212_0].log_file.v
				as.other.hookchat[iter_212_0].sound = im.hookchat[iter_212_0].sound.v
				as.other.hookchat[iter_212_0].notify = im.hookchat[iter_212_0].notify.v

				am("��������� ��������� �������. �� �������� ��������� ��������� ��������� ����!")
			end

			var_0_0.PopStyleColor(3)
			var_0_0.PushStyleColor(var_0_0.Col.Button, var_0_0.ImVec4(0.8, 0, 0, 0.6))
			var_0_0.PushStyleColor(var_0_0.Col.ButtonHovered, var_0_0.ImVec4(0.8, 0, 0, 0.85))
			var_0_0.PushStyleColor(var_0_0.Col.ButtonActive, var_0_0.ImVec4(0.8, 0, 0, 0.98))

			if var_0_0.Button(u8("������� ������� �������"), var_0_96) then
				table.remove(as.other.hookchat, iter_212_0)
				hookChatRegister()
			end

			var_0_0.PopStyleColor(3)
		end
	end

	var_0_0.EndChild()
end

function selectedIm()
	var_0_0.Separator()
	var_0_0.Image(var_0_15.settings_changekeys, var_0_0.ImVec2(715, 80))
	var_0_0.Separator()
	var_0_0.BeginChild("left pane##5", var_0_0.ImVec2(0, 0), true)
	var_0_0.Text(var_0_7.ICON_COG .. u8(" ��������� ������:\n"))
	var_0_0.SameLine()
	var_0_0.SetCursorPos(var_0_0.ImVec2(530, 3))

	if var_0_0.Button(u8("���������� �� ��������")) then
		im.windows.allkeys.v = not im.windows.allkeys.v
	end

	var_0_0.Separator()
	var_0_0.Columns(2, _, false)
	var_0_0.SetColumnWidth(-1, 340)
	var_0_0.PushItemWidth(100)
	var_0_0.InputText(u8("������ ������"), im.keys.keyPursuitStart)

	se.keys.pursuit_start = im.keys.keyPursuitStart.v

	var_0_0.InputText(u8("������ � ������ �������� [����]"), im.keys.keyPursuitSu)

	se.keys.pursuit_su = im.keys.keyPursuitSu.v

	var_0_0.InputText(u8("������� �������� �� ���� [MDC]"), im.keys.keyPursuitMdc)

	se.keys.pursuit_mdc = im.keys.keyPursuitMdc.v

	var_0_0.InputText(u8("�������� � ������-�����"), im.keys.keyPursuit55)

	se.keys.pursuit_55 = im.keys.keyPursuit55.v

	var_0_0.InputText(u8("�������� � ������-����� ����������� �����"), im.keys.keyPursuit66)

	se.keys.pursuit_66 = im.keys.keyPursuit66.v

	var_0_0.InputText(u8("����������� � �����"), im.keys.keyPursuitKoord)

	se.keys.pursuit_koord = im.keys.keyPursuitKoord.v

	var_0_0.InputText(u8("����������� � SQUAD"), im.keys.keyPursuitSquad)

	se.keys.fsquad = im.keys.keyPursuitSquad.v

	var_0_0.InputText(u8("���������� ��������� [/m]"), im.keys.keyPursuitOralo)

	se.keys.pursuit_oralo = im.keys.keyPursuitOralo.v

	var_0_0.InputText(u8("���������� � ������ � �� [/m]"), im.keys.keyPursuitOralo2)

	se.keys.pursuit_oralo2 = im.keys.keyPursuitOralo2.v

	var_0_0.InputText(u8("���������� �������������"), im.keys.keyPursuitStop)

	se.keys.pursuit_stop = im.keys.keyPursuitStop.v

	var_0_0.InputText(u8("�������� ������������� �����"), im.keys.keySetClist)

	se.keys.setclist = im.keys.keySetClist.v

	var_0_0.InputText(u8("������ ������ �� ��������� �/�"), im.keys.keyPursuitFast)

	se.keys.pursuit_fast = im.keys.keyPursuitFast.v

	var_0_0.InputText(u8("��������� /ps"), im.keys.keyPursuitPs)

	se.keys.pursuit_ps = im.keys.keyPursuitPs.v

	var_0_0.InputText(u8("��������� /patrul"), im.keys.keyPursuitPatrul)

	se.keys.pursuit_patrul = im.keys.keyPursuitPatrul.v

	var_0_0.InputText(u8("��������� �������"), im.keys.target_freeze)

	se.keys.target_freeze = im.keys.target_freeze.v

	var_0_0.InputText(u8("������� ����� �� ���"), im.keys.fastsms)

	se.keys.fastsms = im.keys.fastsms.v

	var_0_0.InputText(u8("������� FastMap"), im.keys.keyFastMap)

	se.keys.fastmap = im.keys.keyFastMap.v

	var_0_0.NextColumn()
	var_0_0.PushItemWidth(100)
	var_0_0.InputText(u8("������ ���������"), im.keys.keyTargetCuff)

	se.keys.target_cuff = im.keys.keyTargetCuff.v

	var_0_0.InputText(u8("����� ���������"), im.keys.keyTargetUncuff)

	se.keys.target_uncuff = im.keys.keyTargetUncuff.v

	var_0_0.InputText(u8("�������� � ������"), im.keys.keyTargetCput)

	se.keys.target_cput = im.keys.keyTargetCput.v

	var_0_0.InputText(u8("��������"), im.keys.keyTargetFrisk)

	se.keys.target_frisk = im.keys.keyTargetFrisk.v

	var_0_0.InputText(u8("����� �� �����"), im.keys.keyTargetFollow)

	se.keys.target_follow = im.keys.keyTargetFollow.v

	var_0_0.InputText(u8("�������� � ������"), im.keys.keyTargetSu)

	se.keys.target_su = im.keys.keyTargetSu.v

	var_0_0.InputText(u8("�������� ���"), im.keys.keyTargetOop)

	se.keys.target_oop = im.keys.keyTargetOop.v

	var_0_0.InputText(u8("�������� � ������"), im.keys.keyTargetArrest)

	se.keys.target_arrest = im.keys.keyTargetArrest.v

	var_0_0.InputText(u8("��������������"), im.keys.keyInterplay)

	se.keys.interplay = im.keys.keyInterplay.v

	var_0_0.InputText(u8("������� �����"), im.keys.keyTargetMask)

	se.keys.target_mask = im.keys.keyTargetMask.v

	var_0_0.InputText(u8("������� /ps"), im.keys.keyTargetPs)

	se.keys.target_ps = im.keys.keyTargetPs.v

	var_0_0.InputText(u8("�������� �����"), im.keys.keyTargetTicket)

	se.keys.target_ticket = im.keys.keyTargetTicket.v

	var_0_0.InputText(u8("����������� �����"), im.keys.keySetTazer)

	se.keys.tazz = im.keys.keySetTazer.v

	var_0_0.InputText(u8("������� ������"), im.keys.keyFastSiren)

	se.keys.fastsiren = im.keys.keyFastSiren.v

	var_0_0.InputText(u8("�������� ����� ��� �������"), im.keys.keyUpdateRanks)

	se.keys.update_ranks = im.keys.keyUpdateRanks.v

	var_0_0.InputText(u8("��������� ������������� ��� �������"), im.keys.keyPursuitFastStop)

	se.keys.pursuit_fast_stop = im.keys.keyPursuitFastStop.v

	var_0_0.EndChild()
end

member_state = false
gunstat = true
tazer_state = "OFF"
cheater = false
cheater_cuff = false
mouseCoord = false
mouseCoord2 = false
mouseCoord3 = false
mouseCoord4 = false
mouseCoord5 = false
mouseCoord6 = false
mouseCoord7 = false
paycheck_state = false
hotKeyX = false
hotKeyB = false
hotKeyZ = false
oks_state = false
pol_act = false
catch = false
siren_status = false
mswstatus = true
plmarks = {}
cruise = false
cruiseSpeed, maxspeed, cruiseVehicle = 0, -1, -1
Wantedlvl = 0
wanted = {}
okt = {}
blip = {}
blip_pol, blip_want = {}, {}
patrol = {}
oralo_st = 0
marks = {}
markid = 0
active = false
incol = false
trstop = false
shwcrs = false
record, recordID, recordName, recordFile = false
addedTimings, noaddedTimings = {}, {
	["���������� Flats 24-7"] = true,
	["���������� Easter 24-7"] = true,
	["���������� Bayside 24-7"] = true,
	["���������� Ammo LS"] = true,
	["���������� Fort Carson 24-7"] = true,
	["���������� Ammo LV"] = true,
	["���������� Julius 24-7"] = true,
	["���������� Dillimore 24-7"] = true,
	["���������� Whetstone 24-7"] = true,
	["���������� Redsands West 24-7"] = true,
	["���������� Palomino Creek 24-7"] = true,
	["���������� Mulholland 24-7"] = true,
	["���������� Ammo SF"] = true,
	["���������� Juniper 24-7"] = true,
	["���������� Emerald Isle 24-7"] = true,
	["���������� Creek 24-7"] = true,
	["���������� Victim SF"] = true,
	["���������� Idlewood 24-7"] = true,
	["���������� Victim LS"] = true,
	["���������� Victim LV"] = true,
	["���������� Flint 24-7"] = true,
	["���������� Come-A-Lot 24-7"] = true
}
cop = {
	165,
	166,
	265,
	266,
	267,
	280,
	281,
	282,
	283,
	284,
	285,
	286,
	287,
	288,
	300,
	301,
	302,
	303,
	304,
	305,
	306,
	307,
	309,
	310,
	311,
	163,
	164
}
fbi = {
	163,
	164,
	165,
	166,
	286,
	141
}
copcars = {
	427,
	490,
	497,
	523,
	596,
	597,
	598,
	599
}
mkey = math.random(1, 100)
alnkey = math.random(1, 20)

function sendtimer(arg_214_0)
	lua_thread.create(function()
		while arg_214_0 > 0 do
			wait(1000)

			arg_214_0 = arg_214_0 - 1
			timer = arg_214_0
		end
	end)
end

function clauth(arg_216_0)
	lua_thread.create(function()
		while arg_216_0 > 0 do
			wait(1000)

			arg_216_0 = arg_216_0 - 1
			auth_cl = arg_216_0
		end
	end)
end

local var_0_97 = {
	{
		filePath = "moonloader/PD-Project/config/img/logo-settings-c.jpg",
		url = "https://pdp-samp.online/scripts/PDProject/download?file=logo-settings.jpg"
	},
	{
		filePath = "moonloader\\PD-Project\\resource\\m\\m1.mp3",
		url = "https://pdp-samp.online/scripts/PDProject/download?file=m1"
	},
	{
		filePath = "moonloader\\PD-Project\\resource\\m\\m2.mp3",
		url = "https://pdp-samp.online/scripts/PDProject/download?file=m2"
	},
	{
		filePath = "moonloader\\PD-Project\\resource\\m\\m3.mp3",
		url = "https://pdp-samp.online/scripts/PDProject/download?file=m3"
	},
	{
		filePath = "moonloader/PD-Project/resource/m/m4.mp3",
		url = "https://pdp-samp.online/scripts/PDProject/download?file=m4"
	},
	{
		filePath = "moonloader/PD-Project/resource/m/m5.mp3",
		url = "https://pdp-samp.online/scripts/PDProject/download?file=m5"
	},
	{
		filePath = "moonloader/PD-Project/resource/m/m6.mp3",
		url = "https://pdp-samp.online/scripts/PDProject/download?file=m6"
	},
	{
		filePath = "moonloader/PD-Project/resource/m/m7.mp3",
		url = "https://pdp-samp.online/scripts/PDProject/download?file=m7"
	},
	{
		filePath = "moonloader/PD-Project/resource/m/m8.mp3",
		url = "https://pdp-samp.online/scripts/PDProject/download?file=m8"
	},
	{
		filePath = "moonloader/PD-Project/resource/m/m9.mp3",
		url = "https://pdp-samp.online/scripts/PDProject/download?file=m9"
	},
	{
		filePath = "moonloader/PD-Project/resource/m/taserx26.mp3",
		url = "https://pdp-samp.online/scripts/PDProject/download?file=taserx26"
	},
	{
		filePath = "moonloader/PD-Project/resource/m/civilshot.mp3",
		url = "https://pdp-samp.online/scripts/PDProject/download?file=civilshot"
	},
	{
		filePath = "moonloader/PD-Project/resource/m/tighten.wav",
		url = "https://pdp-samp.online/scripts/PDProject/download?file=tighten"
	}
}

for iter_0_6, iter_0_7 in ipairs(var_0_97) do
	if not doesFileExist(iter_0_7.filePath) then
		_G.downloadUrlToFile(iter_0_7.url, iter_0_7.filePath)
	end
end

aln = {}

function setMarker(arg_218_0, arg_218_1, arg_218_2, arg_218_3, arg_218_4, arg_218_5)
	if doesBlipExist(checkpoint) then
		removeBlip(checkpoint)
		deleteCheckpoint(marker)
	end

	checkpoint = addBlipForCoord(arg_218_1, arg_218_2, arg_218_3)
	marker = createCheckpoint(arg_218_0, arg_218_1, arg_218_2, arg_218_3, 1, 1, 1, arg_218_4)

	changeBlipColour(checkpoint, arg_218_5)
	lua_thread.create(function()
		repeat
			wait(0)

			if not doesBlipExist(checkpoint) then
				return
			end

			local var_219_0, var_219_1, var_219_2 = getCharCoordinates(PLAYER_PED)
		until getDistanceBetweenCoords3d(arg_218_1, arg_218_2, arg_218_3, var_219_0, var_219_1, var_219_2) < arg_218_4

		deleteCheckpoint(marker)
		removeBlip(checkpoint)
		addOneOffSound(0, 0, 0, 1149)
	end)
end

addSu, addTick = false, false

local var_0_98 = {
	[0] = chat,
	_G.sampAddChatMessage,
	print,
	sampShowDialog,
	_G.downloadUrlToFile,
	sequent_async_http_request
}
local var_0_99 = {
	ekgs_uk_s = var_0_0.ImBuffer(128),
	ekgs_s = var_0_0.ImBuffer(128),
	ekgs_ak_s = var_0_0.ImBuffer(128),
	federal_p_s = var_0_0.ImBuffer(128),
	sf_manual_s = var_0_0.ImBuffer(128),
	lv_manual_s = var_0_0.ImBuffer(128),
	ls_manual_s = var_0_0.ImBuffer(128),
	fbi_manual_s = var_0_0.ImBuffer(128),
	fbi_cost_s = var_0_0.ImBuffer(128),
	notes = var_0_0.ImBuffer(128),
	notes_last = var_0_0.ImBuffer(128)
}

function getCarModelCornersIn2d(arg_220_0)
	local var_220_0, var_220_1, var_220_2, var_220_3, var_220_4, var_220_5 = getModelDimensions(getCarModel(arg_220_0))

	return {
		{
			convert3DCoordsToScreen(getOffsetFromCarInWorldCoords(arg_220_0, var_220_0, var_220_1 * -1.1, var_220_2))
		},
		{
			convert3DCoordsToScreen(getOffsetFromCarInWorldCoords(arg_220_0, var_220_0 * -1, var_220_1 * -1.1, var_220_2))
		},
		{
			convert3DCoordsToScreen(getOffsetFromCarInWorldCoords(arg_220_0, var_220_0 * -1, var_220_1, var_220_2))
		},
		{
			convert3DCoordsToScreen(getOffsetFromCarInWorldCoords(arg_220_0, var_220_0, var_220_1, var_220_2))
		},
		{
			convert3DCoordsToScreen(getOffsetFromCarInWorldCoords(arg_220_0, var_220_3 * -1, var_220_4, var_220_5))
		},
		{
			convert3DCoordsToScreen(getOffsetFromCarInWorldCoords(arg_220_0, var_220_3 * -1, var_220_4 * -0.9, var_220_5))
		},
		{
			convert3DCoordsToScreen(getOffsetFromCarInWorldCoords(arg_220_0, var_220_3, var_220_4 * -0.9, var_220_5))
		},
		{
			convert3DCoordsToScreen(getOffsetFromCarInWorldCoords(arg_220_0, var_220_3, var_220_4, var_220_5))
		}
	}
end

function getCarModelCornersIn3d(arg_221_0)
	local var_221_0, var_221_1, var_221_2, var_221_3, var_221_4, var_221_5 = getModelDimensions(getCarModel(arg_221_0))

	return {
		{
			getOffsetFromCarInWorldCoords(arg_221_0, var_221_0, var_221_1 * -1.1, var_221_2)
		},
		{
			getOffsetFromCarInWorldCoords(arg_221_0, var_221_0 * -1, var_221_1 * -1.1, var_221_2)
		},
		{
			getOffsetFromCarInWorldCoords(arg_221_0, var_221_0 * -1, var_221_1, var_221_2)
		},
		{
			getOffsetFromCarInWorldCoords(arg_221_0, var_221_0, var_221_1, var_221_2)
		},
		{
			getOffsetFromCarInWorldCoords(arg_221_0, var_221_3 * -1, var_221_4, var_221_5)
		},
		{
			getOffsetFromCarInWorldCoords(arg_221_0, var_221_3 * -1, var_221_4 * -0.9, var_221_5)
		},
		{
			getOffsetFromCarInWorldCoords(arg_221_0, var_221_3, var_221_4 * -0.9, var_221_5)
		},
		{
			getOffsetFromCarInWorldCoords(arg_221_0, var_221_3, var_221_4, var_221_5)
		}
	}
end

function getCommandData(arg_222_0)
	local var_222_0 = {}
	local var_222_1 = io.open("moonloader/PD-Project/sys/cc.karimoff", "r")

	if var_222_1 then
		local var_222_2 = decodeJson(var_222_1:read("*a"))

		for iter_222_0, iter_222_1 in pairs(var_222_2) do
			if arg_222_0 == iter_222_0 then
				var_222_0.text = iter_222_1.text
				var_222_0.wait = iter_222_1.wait
				var_222_0.param_id = iter_222_1.param_id
			end
		end
	end

	return var_222_0
end

function showinfmainweapon()
	var_0_0.Separator()
	var_0_0.Columns(3, _, false)
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_SHIELD .. u8(" Deagle"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("Deagle"), im.weapons.infGunDeagle)

	se.weapon.deagle = im.weapons.infGunDeagle.v

	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_SHIELD .. u8(" Shotgun"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("Shotgun"), im.weapons.infGunShotgun)

	se.weapon.shotgun = im.weapons.infGunShotgun.v

	var_0_0.Text(var_0_7.ICON_SHIELD .. u8(" MP5"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("MP5"), im.weapons.infGunMP5)

	se.weapon.mp5 = im.weapons.infGunMP5.v

	var_0_0.NextColumn()
	var_0_0.Text(var_0_7.ICON_SHIELD .. u8(" M4"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("M4"), im.weapons.infGunM4)

	se.weapon.m4 = im.weapons.infGunM4.v

	var_0_0.Text(var_0_7.ICON_SHIELD .. u8(" Rifle"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("Rifle"), im.weapons.infGunRifle)

	se.weapon.rifle = im.weapons.infGunRifle.v

	var_0_0.Text(var_0_7.ICON_SHIELD .. u8(" Armor"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("Armor"), im.weapons.infGunArmor)

	se.weapon.armor = im.weapons.infGunArmor.v

	var_0_0.NextColumn()
	var_0_0.Text(var_0_7.ICON_SHIELD .. u8(" Special"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("Special"), im.weapons.infGunSpecial)

	se.weapon.special = im.weapons.infGunSpecial.v
end

function showinfwanted()
	var_0_0.Separator()
	var_0_0.Columns(2, _, false)
	var_0_0.SliderInt("##wanted_lines", im.wanted.lines, 3, 15,
		var_0_7.ICON_LIST .. u8(" ���������� �����: " .. im.wanted.lines.v))

	se.wanted.lines = im.wanted.lines.v

	var_0_0.SliderInt("##wanted_size", im.wanted.size, 6, 16,
		var_0_7.ICON_TEXT_HEIGHT .. u8(" ������ ������: " .. im.wanted.size.v))

	if im.wanted.size.v ~= se.wanted.size then
		wantedFont = renderCreateFont(as.wanted.font, tonumber(im.wanted.size.v), 5)
	end

	se.wanted.size = im.wanted.size.v

	var_0_0.SliderInt("##wanted_interval", im.wanted.interval, 5, 25,
		var_0_7.ICON_ALIGN_JUSTIFY .. u8(" ��������: " .. im.wanted.interval.v))

	se.wanted.interval = im.wanted.interval.v

	var_0_0.NextColumn()
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(var_0_7.ICON_CLOCK_O .. u8(" �������� Timestamp"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("�������� Timestamp"), im.wanted.timestamp)

	se.wanted.timestamp = im.wanted.timestamp.v

	if var_0_0.Button(u8("�������� ���������##wanted"), var_0_96) then
		chat("�������� ������� ������������ ���� � ������� ENTER ��� ����������.")

		var_0_42.v = false
		as.wanted.changepos = true
	end

	var_0_0.Columns(1)
end

function showinfsquad()
	var_0_0.Separator()
	var_0_0.Columns(2, _, false)
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text((im.squad.ha.v and var_0_7.ICON_EYE or var_0_7.ICON_EYE_SLASH) .. u8(" ���������� �� � �����"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� �� � �����"), im.squad.ha)

	se.squad.ha = im.squad.ha.v

	var_0_0.SameLine()
	showHelp(u8(
	"�������� ���� �� � ����� � ������ SQUAD. �� ������, ���� �� ��������� ������ �������, �� ����� � �� �� ������ ������ �� � ����� ������ �������."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text((im.squad.sector.v and var_0_7.ICON_EYE or var_0_7.ICON_EYE_SLASH) .. u8(" ���������� ������� �������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� ������� �������"), im.squad.sector)

	se.squad.sector = im.squad.sector.v

	var_0_0.SameLine()
	showHelp(u8(
	"�������� ��� ������� ������� � ������ ������� SQUAD, �� ������, ��� �������� ������ �������, �� �� ������ ������ ������� ������� ������ �������."))
	var_0_0.SliderInt("##squad_size", im.squad.size, 8, 16,
		var_0_7.ICON_TEXT_HEIGHT .. u8(" ������ ������: ") .. im.squad.size.v)

	se.squad.size = im.squad.size.v

	var_0_0.NextColumn()
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text((im.squad.clist.v and var_0_7.ICON_EYE or var_0_7.ICON_EYE_SLASH) .. u8(" ���������� ���� clist"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� ���� clist"), im.squad.clist)

	se.squad.clist = im.squad.clist.v

	var_0_0.SameLine()
	showHelp(u8(
	"�������� ��� ������� ���� ���� (/clist), �� ������, ��� �������� ������ �������, �� �� ������ ������ ������� ���� ���� ������ �������."))
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text((im.squad.position.v and var_0_7.ICON_EYE or var_0_7.ICON_EYE_SLASH) .. u8(" ���������� ��������������"))
	var_0_0.SameLine()
	var_0_0.ToggleButton(u8("���������� ��������������"), im.squad.position)

	se.squad.position = im.squad.position.v

	var_0_0.SameLine()
	showHelp(u8(
	"���� ������ ������� ���������, �� �� ����� ���������� ���� �������������� � FastMap ��� ����� ������������. ����� � �� �� ������ ������ �������������� ������������ � FastMap."))

	if var_0_0.Button(u8("�������� ���������##squad"), var_0_96) then
		chat("�������� ������� ������������ ���� � ������� ENTER ��� ����������.")

		var_0_42.v = false
		as.textdraw.squad_changepos = true
	end

	var_0_0.Columns(1)
end

function getSrv()
	return srv_name
end

function allcommansSet()
	return
end

function get_crosshair_position()
	local var_230_0 = var_0_10.new("float[3]")
	local var_230_1 = var_0_10.new("float[3]")

	var_0_10.cast("void (__thiscall*)(void*, float, float, float, float, float*, float*)", 5327216)(
	var_0_10.cast("void*", 11989032), 15, var_230_1[0], var_230_1[1], var_230_1[2], var_230_1, var_230_0)

	return var_230_0[0], var_230_0[1], var_230_0[2]
end

local var_0_100 = ""
local var_0_101 = ""

var_0_10.cdef(
"    struct stGangzone\n    {\n        float    fPosition[4];\n        uint32_t    dwColor;\n        uint32_t    dwAltColor;\n    };\n\n    struct stGangzonePool\n    {\n        struct stGangzone    *pGangzone[1024];\n        int iIsListed[1024];\n    };\n\n    int __stdcall GetVolumeInformationA(\n\t\tconst char* lpRootPathName,\n\t\tchar* lpVolumeNameBuffer,\n\t\tuint32_t nVolumeNameSize,\n\t\tuint32_t* lpVolumeSerialNumber,\n\t\tuint32_t* lpMaximumComponentLength,\n\t\tuint32_t* lpFileSystemFlags,\n\t\tchar* lpFileSystemNameBuffer,\n\t\tuint32_t nFileSystemNameSize\n\t);\n\n\tint MessageBoxA(\n\t\tvoid* hWnd,\n\t\tconst char* lpText,\n\t\tconst char* lpCaption,\n\t\tunsigned int uType\n\t);\n\n\tbool SetCursorPos(int X, int Y);\n")

function main()
	while not isSampAvailable() do
		wait(0)

		letsGameGo = true
	end

	repairFile()
	var_0_14()

	while sampGetCurrentServerName() == "SA-MP" do
		wait(0)

		letsGameGo = true
	end

	onstarttime = os.time()
	gz_pool = var_0_10.cast("struct stGangzonePool*", sampGetGangzonePoolPtr())

	while var_0_12 == false do
		wait(0)
	end

	_, myID = sampGetPlayerIdByCharHandle(playerPed)
	myName = sampGetPlayerNickname(myID)

	if sampGetGamestate() == 3 then
		letsGame = true
	end

	if _G.getGxtText("PDP_DISCONNECTED") == "1" then
		chat("����������, ����������� � ���� ��� ������ �������, ���������� ������ �������.")
	end

	while _G.getGxtText("PDP_DISCONNECTED") == "1" do
		wait(10)
	end

	allcommansSet()

	local var_231_0, var_231_1 = getA()

	print("Loading server data...")

	while remote_srvname == nil and not var_231_0 do
		wait(100)
	end

	srv_name = remote_srvname

	setGxtEntry("KDF_PDP_SERVER", srv_name)
	setGxtEntry("KDF_PDP_USER", myName)
	load_settings()

	if getGxtText("GLOBAL_GAME_STATE") == "" then
		setGxtEntry("GLOBAL_GAME_STATE", os.time())

		as.textdraw.squad_code = getGxtText("GLOBAL_GAME_STATE")
	else
		as.textdraw.squad_code = getGxtText("GLOBAL_GAME_STATE")

		local var_231_2 = tmpGet("PDPGGZZ")

		if var_231_2 ~= "" then
			local var_231_3 = decodeJson(var_231_2)

			if var_231_3 then
				for iter_231_0, iter_231_1 in pairs(var_231_3) do
					gg.gz[tonumber(iter_231_0)] = {
						zoneId = tonumber(iter_231_1.zoneId),
						x1 = iter_231_1.x1,
						y1 = iter_231_1.y1,
						x2 = iter_231_1.x2,
						y2 = iter_231_1.y2,
						color = iter_231_1.color,
						mcolor = iter_231_1.mcolor
					}
				end
			end

			tmpRemove("PDPGGZZ")
		end

		local var_231_4 = tmpGet("PDPGGZZFF")

		if var_231_4 ~= "" then
			local var_231_5 = decodeJson(var_231_4)

			if var_231_5 then
				for iter_231_2, iter_231_3 in pairs(var_231_5) do
					gg.gz_flash[iter_231_2] = {
						color = iter_231_3.color,
						f = os.time(),
						m = os.time() + 1
					}
				end
			end

			tmpRemove("PDPGGZZFF")
		end
	end

	while not var_0_68 do
		wait(100)
	end

	while not se do
		wait(100)
	end

	getGameTime()

	while as.other.allgametime == 0 do
		wait(100)
	end

	if not doesFileExist("moonloader/ml-op.luac") then
		local var_231_6 = "https://pdp-samp.online/scripts/PDProject/download?file=ml-op"
		local var_231_7 = "moonloader/ml-op.luac"

		_G.downloadUrlToFile(var_231_6, var_231_7, function(arg_232_0, arg_232_1, arg_232_2, arg_232_3)
			if arg_232_1 == var_0_5.STATUSEX_ENDDOWNLOAD then
				script.load("moonloader/ml-op.luac")
			end
		end)
	end

	local var_231_8, var_231_9 = sampGetPlayerIdByCharHandle(playerPed)

	level = sampGetPlayerScore(var_231_9)

	datefull()

	while level == 0 do
		wait(0)

		level = sampGetPlayerScore(var_231_9)
	end

	activate()
	printString("~r~Loading your license...", 7000)

	while active == false do
		wait(0)
	end

	if active then
		registerCC()
		closestCar()
		registerKK()
		registerTC()
		registerNT()
		hotkeyCycle()
		tcCycle()
		getblack()
		getFPS()
		getMySpeed()

		if checkSize() == false then
			print("Resources are not available. Starting to repair..")
			checkImages()

			while not isImagesExists() do
				printStringNow("~y~DOWNLOADING FILES OF PD-PROJECT", 1000)
				wait(1000)
			end
		else
			print("All resources are available.")
		end

		local var_231_10 = {
			settings_cruisecontrol = "settings-cruisecontrol.jpg",
			settings_hotkeys = "settings-hotkeys.jpg",
			settings_bindcommands = "settings-bindcommands.jpg",
			settings_info = "settings-info.jpg",
			settings_timings = "settings-timings.jpg",
			settings_tencodes = "settings-tencodes.jpg",
			settings_main = "settings-main.jpg",
			settings_bindcheatcodes = "settings-bindcheatcodes.jpg",
			settings_bindkeys = "settings-bindkeys.jpg",
			settings_changeranks = "settings-changeranks.jpg",
			user_notes = "user-notes.jpg",
			settings_changekeys = "settings-changekeys.jpg",
			settings_fastmap = "settings-fastmap.jpg",
			settings_support = "settings-support.jpg",
			settings_informer = "settings-informer.jpg",
			logo = "main-logo.png",
			settings_ticketsystem = "settings-ticketsystem.jpg",
			settings_sounds = "settings-sounds.jpg",
			settings_allcommands = "settings-allcommands.jpg",
			settings_wantedsystem = "settings-wantedsystem.jpg",
			settings_changemessages = "settings-changemessages.jpg"
		}
		local var_231_11 = "moonloader/PD-Project/config/img/"

		for iter_231_4, iter_231_5 in pairs(var_231_10) do
			var_0_15[iter_231_4] = var_0_0.CreateTextureFromFile(var_231_11 .. iter_231_5)
		end

		update()
		checkSquad()

		if se.radio.radio_copcar then
			getradio()
		end

		while update ~= false do
			wait(100)
		end

		userNick = sampGetPlayerNickname(myID)
		nickName = userNick:gsub("_", " ")

		if se then
			timefix = 3
			unix_time = os.time(os.date("!*t"))
			moscow_time = unix_time + timefix * 60 * 60
		end

		gnUserID, gnName = nil

		gn()

		while gnUserID == nil do
			wait(0)
		end

		print("Loading license of " .. myName .. ", v. " .. thisScript().version .. ".")
		log.info("Loading license of " .. myName .. ".")
		log.info("License active for " .. tostring(licdate) .. " days.")
		pchat("������� ��������. ���� ���� - /pd. ������ ���������: vk.com/samp_pdp.")
		am("���� ���� - /pd. ������ ���������: vk.com/samp_pdp.", 5, 1)

		var_0_100, var_0_101 = convert3DCoordsToScreen(get_crosshair_position())

		printString("~y~Activating...", 2000)
		am(
		(getTimeOfDay() ~= "" and getTimeOfDay() or "������������") ..
		", " ..
		(gnName and gnName or myName:gsub("_", " ")) ..
		". ���� �������� � �PD-Project� ������������� " .. tostring(licdate) .. " " .. licDays(licdate) .. ".", 5, 1)
		printString("~g~Activated.", 2000)
		showCursor(false, false)
		updateTick()
		lua_thread.create(update_notifications)
		lua_thread.create(setShowranks)
		lua_thread.create(vspd)
		lua_thread.create(awaitSendChatSystem)

		if _G.sampIsChatCommandDefined("j") then
			_G.sampUnregisterChatCommand("j")
		end

		_G.sampRegisterChatCommand("j", function(arg_233_0)
			if im.settings.chat.v and _G.buy[144] ~= nil then
				if arg_233_0 and tostring(arg_233_0):len() > 0 then
					arg_233_0 = tostring(arg_233_0):gsub("%{%S%S%S%S%S%S%}", "")
					arg_233_0 = tostring(arg_233_0):gsub("%%", " (����)")
					arg_233_0 = tostring(arg_233_0):gsub("%#", "")

					local var_233_0 = {}
					local var_233_1, var_233_2 = sampGetCurrentServerAddress()
					local var_233_3, var_233_4 = sampGetPlayerIdByCharHandle(playerPed)
					local var_233_5, var_233_6, var_233_7 = getCharCoordinates(playerPed)
					local var_233_8 = sampGetPlayerNickname(var_233_4)

					var_233_0.info = {
						status = 1,
						sender = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))),
						message = arg_233_0,
						server = tostring(var_233_1) .. ":" .. tostring(var_233_2)
					}

					local var_233_9 = {
						data = u8:encode(encodeJson(var_233_0)),
						headers = {
							["content-type"] = "application/json"
						}
					}

					sequent_async_http_request("POST", _G.buy[144] .. "post", var_233_9, function(arg_234_0)
						info = decodeJson(arg_234_0.text)

						if info == nil then
							chat("������ ������������� ����, ���������� �������..")
						elseif info.result == 1 then
							sChat(u8:decode(info.answer))
						elseif info.result == "error" then
							if info.reason == 425 then
								sChat("�� �������!")
							elseif info.reason == 441 then
								sChat("�� ������� ����� ����������!")
							elseif info.reason == 205 then
								sChat("��� ��� ������������. �� ������������� " .. tostring(info.finish) .. " ���.")
								sChat("����� �� ��������� ������, ������������ � ��������� ���� - /jrules")
							end
						end
					end, function(arg_235_0)
						return
					end)
				else
					chat("��������� �� ����� ���� ������.")
				end
			else
				chat("�� ��������� ��� � ���������� �������!")
			end
		end)

		if _G.sampIsChatCommandDefined("cmdc") then
			_G.sampUnregisterChatCommand("cmdc")
		end

		_G.sampRegisterChatCommand("cmdc", function(arg_236_0)
			if _G.buy[144] ~= nil then
				if arg_236_0 and tostring(arg_236_0):len() > 0 then
					arg_236_0 = tostring(arg_236_0):match("^(%d+)$")

					if arg_236_0 then
						if not sampIsPlayerConnected(tonumber(arg_236_0)) then
							chat("����� �������")

							return
						end

						local var_236_0 = {}
						local var_236_1, var_236_2 = sampGetCurrentServerAddress()
						local var_236_3, var_236_4 = sampGetPlayerIdByCharHandle(playerPed)
						local var_236_5 = sampGetPlayerNickname(var_236_4)

						var_236_0.info = {
							status = 5,
							sender = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))),
							fraction = frac ~= nil and frac or "-",
							message = arg_236_0,
							name = sampGetPlayerNickname(tonumber(arg_236_0)),
							id = var_236_4,
							server = tostring(var_236_1) .. ":" .. tostring(var_236_2)
						}

						local var_236_6 = {
							data = u8:encode(encodeJson(var_236_0)),
							headers = {
								["content-type"] = "application/json"
							}
						}

						sequent_async_http_request("POST", _G.buy[144] .. "post", var_236_6, function(arg_237_0)
							info = decodeJson(arg_237_0.text)

							if info == nil then
								chat("������ ������������� ������, ���������� �������..")
							elseif info.result == 1 then
								chat(u8:decode(info.answer))
							end
						end, function(arg_238_0)
							return
						end)
					else
						chat("������� ID ������ � /cmdc ID.")
					end
				else
					chat("������� ID ������: /cmdc ID.")
				end
			end
		end)
		_G.sampRegisterChatCommand("jre", function(arg_239_0)
			if im.settings.chat.v and _G.buy[144] ~= nil then
				if arg_239_0 and tostring(arg_239_0):len() > 0 then
					arg_239_0 = tostring(arg_239_0):gsub("%{%S%S%S%S%S%S%}", "")
					arg_239_0 = tostring(arg_239_0):gsub("%%", " (����)")
					arg_239_0 = tostring(arg_239_0):gsub("%#", "")

					local var_239_0, var_239_1 = arg_239_0:match("^(%d+)%s(.*)$")

					if var_239_0 and var_239_1 then
						local var_239_2 = {}
						local var_239_3, var_239_4 = sampGetCurrentServerAddress()
						local var_239_5, var_239_6 = sampGetPlayerIdByCharHandle(playerPed)
						local var_239_7, var_239_8, var_239_9 = getCharCoordinates(playerPed)
						local var_239_10 = sampGetPlayerNickname(var_239_6)

						var_239_2.info = {
							status = 4,
							sender = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))),
							reported = var_239_0,
							reason = var_239_1,
							server = tostring(var_239_3) .. ":" .. tostring(var_239_4)
						}

						local var_239_11 = {
							data = u8:encode(encodeJson(var_239_2)),
							headers = {
								["content-type"] = "application/json"
							}
						}

						sequent_async_http_request("POST", _G.buy[144] .. "post", var_239_11, function(arg_240_0)
							info = decodeJson(arg_240_0.text)

							if info == nil then
								chat("������ ������������� ����, ���������� �������..")
							elseif info.result == 1 then
								sChat(u8:decode(info.answer))
							elseif info.result == "error" then
								if info.reason == 425 then
									sChat("�� �������!")
								elseif info.reason == 441 then
									sChat("�� ������� ����� ����������!")
								elseif info.reason == 205 then
									sChat("��� ��� ������������. �� ������������� " .. tostring(info.finish) .. " ���.")
									sChat("����� �� ��������� ������, ������������ � ��������� ���� - /jrules")
								elseif info.reason == 482 then
									sChat("������ ������� ���������� �����������.")
								elseif info.reason == 426 then
									sChat("������ ����� ���������� ���� ��� � 30 ������.")
								elseif info.reason == 428 then
									sChat("��������� ������������ �� ������. ���������� ��� ���.")
								elseif info.reason == 432 then
									sChat("��������� �� ���������� ������������ �����������.")
								end
							end
						end, function(arg_241_0)
							return
						end)
					else
						chat("������� /jre [������������� ��������� ����] [�������]")
						chat("������: /jre 4 �����������")
					end
				end
			else
				chat("�� ��������� ��� � ���������� �������!")
			end
		end)

		if _G.sampIsChatCommandDefined("jmute") then
			_G.sampUnregisterChatCommand("jmute")
		end

		_G.sampRegisterChatCommand("jmute", function(arg_242_0)
			if im.settings.chat.v and _G.buy[144] ~= nil then
				if arg_242_0 and tostring(arg_242_0):len() > 0 then
					local var_242_0, var_242_1, var_242_2 = arg_242_0:match("(%d+)%s(%d+)%s(.*)")

					if var_242_0 and var_242_2 and var_242_1 then
						local var_242_3 = {}
						local var_242_4, var_242_5 = sampGetCurrentServerAddress()
						local var_242_6, var_242_7 = sampGetPlayerIdByCharHandle(playerPed)
						local var_242_8, var_242_9, var_242_10 = getCharCoordinates(playerPed)
						local var_242_11 = sampGetPlayerNickname(var_242_7)

						var_242_3.info = {
							status = 3,
							sender = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))),
							user = var_242_0,
							reason = var_242_2,
							mute = var_242_1,
							server = tostring(var_242_4) .. ":" .. tostring(var_242_5)
						}

						local var_242_12 = {
							data = u8:encode(encodeJson(var_242_3)),
							headers = {
								["content-type"] = "application/json"
							}
						}

						sequent_async_http_request("POST", _G.buy[144] .. "post", var_242_12, function(arg_243_0)
							info = decodeJson(arg_243_0.text)

							if info == nil then
								chat("������ ������������� ����, ���������� �������..")
							elseif info.result == 1 then
								sChat(u8:decode(info.answer))
							elseif info.result == "error" then
								if info.reason == 425 then
									chat("�� �������!")
								elseif info.reason == 441 then
									chat("�� ������� ����� ����������!")
								elseif info.reason == 205 then
									chat("��� ��� ������������. �� ������������� " .. tostring(info.finish) .. " ���.")
								elseif info.reason == 808 then
									chat("� ��� ��� ���������� ��� ������������� ������� �����������.")
								elseif info.reason == 810 then
									chat("� ������������ ������� �������� Mute!")
								elseif info.reason == 819 then
									chat("��������� ������������ �� ������.")
								end
							end
						end, function(arg_244_0)
							return
						end)
					else
						chat("������� ��������. � �������: /jmute 1 60 ����")
					end
				else
					chat("������� ��������. � �������: /jmute 1 60 ����")
				end
			else
				chat("�� ��������� ��� � ���������� �������!")
			end
		end)
		_G.sampRegisterChatCommand("setcase", function(arg_245_0)
			if myfrac == "4" then
				if arg_245_0:len() > 0 then
					local var_245_0 = arg_245_0:match("(%d+)")

					if var_245_0 then
						if sampIsPlayerConnected(tonumber(var_245_0)) then
							local var_245_1 = sampGetPlayerNickname(var_245_0)
							local var_245_2, var_245_3, var_245_4 = getCharCoordinates(select(2,
								sampGetCharHandleBySampPlayerId(var_245_0)))
							local var_245_5, var_245_6, var_245_7 = getCharCoordinates(playerPed)

							if getDistanceBetweenCoords3d(var_245_2, var_245_3, var_245_4, var_245_5, var_245_6, var_245_7) < 6 then
								caseStatus, caseTargetId, caseTargetName = true, var_245_0, var_245_1

								chat("������������������ ���������� �� ���� " ..
								caseTargetName:gsub("_", " ") .. " ����������. ��� �������� ����� ������� ����������.")
								chat(
								"��� ���������� ���������� �� ���������� �� ����� 200 ������, ����� ������ ����� �� ����������.")
							else
								chat("���������� ���������� �� ������ 5 ������.")
							end
						else
							chat("��������� ������������� �� ������.")
						end
					else
						chat("ID �� ���������.")
					end
				else
					chat("������� ID ������.")
				end
			else
				chat("������������������ ���������� �������� ������� FBI.")
			end
		end)
		_G.sampRegisterChatCommand("rh", function()
			if sdate.robhouse and #sdate.robhouse > 0 and sdate.robhouse ~= nil then
				local var_246_0 = {}

				table.sort(sdate.robhouse, function(arg_247_0, arg_247_1)
					return arg_247_0[1] > arg_247_1[1]
				end)

				for iter_246_0, iter_246_1 in pairs(sdate.robhouse) do
					table.insert(var_246_0, iter_246_1[2] .. "\t" .. iter_246_1[3] .. "\t" .. iter_246_1[4])
				end

				sampShowDialog(9651, "������������ � �����",
					"�����\t��������������� [�����]\t�����\n" .. table.concat(var_246_0, "\n"), "GPS", "Close", 5)
			else
				chat("������ ����.")
			end
		end)
		_G.sampRegisterChatCommand("smdc", function(arg_248_0)
			if tostring(arg_248_0):len() > 0 then
				sendmdc, smdcID, mdctype = true, arg_248_0, 2

				sampSendChat("/mdc " .. arg_248_0)
			else
				chat("������� /smdc ID, ����� ��������� ������ ������ � ���.")
			end
		end)
		_G.sampRegisterChatCommand("fmdc", function(arg_249_0)
			if tostring(arg_249_0):len() > 0 then
				sendmdc, smdcID, mdctype = true, arg_249_0, 3

				sampSendChat("/mdc " .. arg_249_0)
			else
				chat("������� /fmdc ID, ����� ��������� ������ ������ � SQUAD.")
			end
		end)
		_G.sampRegisterChatCommand("rmdc", function(arg_250_0)
			if tostring(arg_250_0):len() > 0 then
				sendmdc, smdcID, mdctype = true, arg_250_0, 1

				sampSendChat("/mdc " .. arg_250_0)
			else
				chat("������� /rmdc ID, ����� ��������� ������ ������ � ���.")
			end
		end)
		_G.sampRegisterChatCommand("pdpteam", function()
			local var_251_0 = {}

			if var_0_33 then
				for iter_251_0, iter_251_1 in pairs(var_0_33) do
					local var_251_1 = u8:decode(iter_251_1):gsub("{%S%S%S%S%S%S}", ""):gsub("\n", " � ")

					if iter_251_0 == myName then
						var_251_0[#var_251_0 + 1] = iter_251_0 .. "[" .. myID .. "]" .. "\t" .. var_251_1
					else
						local var_251_2 = sampGetPlayerIdByNickname(iter_251_0)

						if var_251_2 and sampIsPlayerConnected(var_251_2) then
							var_251_0[#var_251_0 + 1] = iter_251_0 .. "[" .. var_251_2 .. "]" .. "\t" .. var_251_1
						end
					end
				end

				if #var_251_0 > 0 then
					sampShowDialog(9834, "����� ������� PD-PROJECT � ����",
						"������� ��� [ID]\t���������\n" .. table.concat(var_251_0, "\n"), "Ok", "Cancel", 5)
				else
					chat("������ �� ������� ��� � ����.")
				end
			else
				chat("������ ������ ����������. ������������� ������ � ���������� ��� ���.")
			end
		end)
		_G.sampRegisterChatCommand("spw", setWaypoint)
		_G.sampRegisterChatCommand("pdcl", function()
			chat("�������� ��������� �������� � ���������� �� vk.com/samp_pdp")
		end)
		_G.sampRegisterChatCommand("pdreload", function()
			chat("������������..")
			thisScript():reload()
		end)
		_G.sampRegisterChatCommand("rec", function(arg_254_0)
			if arg_254_0:len() > 0 then
				if sampIsPlayerConnected(arg_254_0) then
					local var_254_0, var_254_1 = sampGetCharHandleBySampPlayerId(arg_254_0)

					if var_254_0 then
						recordID = arg_254_0
						recordName = sampGetPlayerNickname(arg_254_0)
						recordFile = io.open(
						"moonloader/PD-Project/records/" .. recordName .. "-" .. os.date("%d-%m-%Y") .. ".txt", "a")

						if recordFile then
							record = true

							chat("������ ��������� ��������. ����� ���������� ������� /recoff.")
						else
							chat("�� ������� ������ ������, ��������� ������� ����� ������������ �������.")
						end
					else
						chat("����� ������ ���������� � ���� ���������.")
					end
				else
					chat("����� ����������.")
				end
			else
				chat("����� ������ ������ ���������, ������� /rec ID.")
			end
		end)
		_G.sampRegisterChatCommand("recoff", function()
			if record then
				chat("������ �����������. ������ ��������� -> 'moonloader/PD-Project/records/" ..
				recordName .. "-" .. os.date("%d-%m-%Y") .. ".txt'")

				record, recordID, recordName = false

				recordFile:close()
			else
				am("������ ��������� �� ��������. ������� /rec ID.")
			end
		end)
		_G.sampRegisterChatCommand("maski", function()
			lua_thread.create(function()
				wait(p(1000))
				sampSendChat("/do �� ���� �����. �� ����� ��������. �������� �������� ����������.")
				wait(p(1000))
				sampSendChat("/clist 32")
			end)
		end)
		_G.sampRegisterChatCommand("dp", function()
			pol_act = false
			pol_id = nil

			remu_pol()
			remu()
			remu_want()
		end)
		_G.sampRegisterChatCommand("govk", function()
			os.execute("explorer \"https://vk.com/samp_pdp\"")
		end)
		_G.sampRegisterChatCommand("micoff", function()
			if reaver then
				rID, rName, reaver, reaver_micro = nil, nil, false, false

				am("����� ������.")
			else
				chat("����� �� ����������. ���������� ����� - /mic ID.")
			end
		end)
		_G.sampRegisterChatCommand("csp", function(arg_261_0)
			if arg_261_0:len() > 0 then
				if sampIsPlayerConnected(arg_261_0) then
					local var_261_0, var_261_1 = sampGetCharHandleBySampPlayerId(arg_261_0)

					if var_261_0 then
						lua_thread.create(function()
							sampSendSystemChat("/clear " .. arg_261_0 .. " ���")
							wait(p(1000))
							sampSendSystemChat("/su " .. arg_261_0 .. " 1 ���")
						end)
					else
						chat("����� ������ ���������� � ���� ���������.")
					end
				else
					chat("����� ����������.")
				end
			else
				chat("����� ��������� ���, ���������� ������ /csp ID.")
			end
		end)
		_G.sampRegisterChatCommand("ctie", function(arg_263_0)
			if arg_263_0:len() > 0 then
				if sampIsPlayerConnected(arg_263_0) then
					local var_263_0, var_263_1 = sampGetCharHandleBySampPlayerId(arg_263_0)

					if var_263_0 then
						lua_thread.create(function()
							local var_264_0 = getEditByCode("cuffs.ctie", 1)
							local var_264_1 = getEditByCode("cuffs.ctie", 2)
							local var_264_2 = var_264_0:gsub("{name}", sampGetPlayerNickname(arg_263_0):gsub("_", " "))
							local var_264_3 = var_264_1:gsub("{name}", sampGetPlayerNickname(arg_263_0):gsub("_", " "))

							sampSendSystemChat(var_264_2)
							wait(350)
							sampSendChat("/uncuff " .. arg_263_0)
							wait(p(1000))
							sampSendSystemChat(var_264_3)
							wait(350)
							sampSendChat("/cuff " .. arg_263_0)
						end)
					else
						am("����� ������ ���������� � ���� ���������.")
					end
				else
					am("����� ����������.")
				end
			else
				chat("����� ����������� ����������� ������ � �����, ������� /ctie ID.")
			end
		end)
		_G.sampRegisterChatCommand("msk", function(arg_265_0)
			if arg_265_0:len() > 0 then
				if sampIsPlayerConnected(arg_265_0) then
					local var_265_0, var_265_1 = sampGetCharHandleBySampPlayerId(arg_265_0)

					if var_265_0 then
						sampSendSystemChat(gsub(getEditByCode("hottarget.unmask", 1)):gsub("{name}",
							sampGetPlayerNickname(arg_265_0):gsub("_", " ")))
						awaitSendChat("/unmask " .. tostring(arg_265_0), 1, 1000, false)
					else
						am("����� ������ ���������� � ���� ���������.")
					end
				else
					am("����� ����������.")
				end
			else
				chat("����� ������� ����� � ���� ������, ������� /msk ID.")
			end
		end)
		_G.sampRegisterChatCommand("micfs", function()
			if reaver then
				mcfs = not mcfs

				chat(mcfs and "������ ������������� � SQUAD." or "������ ������������� � �����.")
			else
				am("����� �� ����������. ������ ���������� �����.")
			end
		end)
		_G.sampRegisterChatCommand("mic", function(arg_267_0)
			if tostring(myfrac) == "4" or myName == "Serhiy_Rubin" then
				if arg_267_0 == "" or arg_267_0 == nil then
					chat("������� /mic ID, ����� ������ �������� ������.")
				elseif sampIsPlayerConnected(arg_267_0) then
					mcfs = false
					mes_stat = 0
					rID = arg_267_0
					rName = sampGetPlayerNickname(rID)
					reaver, reaver_micro = true, true

					chat("����� ���������� �� " .. rName .. "[" .. rID .. "]")
					chat(
					"������ ������������� � �����. ����� ������������ � SQUAD, ������� /micfs. ��������� ����� /micoff.")
				else
					am("���� ����������.")
				end
			else
				am("� ��� ��� �����. ��� ������ ����. ������� ���.")
			end
		end)
		_G.sampRegisterChatCommand("psa", function()
			lua_thread.create(function()
				pskl = 0

				am("������� ����.")

				for iter_269_0 = 0, sampGetMaxPlayerId(false) do
					wait(0)

					local var_269_0, var_269_1 = sampGetCharHandleBySampPlayerId(iter_269_0)

					if var_269_0 and doesCharExist(var_269_1) then
						local var_269_2 = iter_269_0

						if not checkIntable(cop, getCharModel(var_269_1)) then
							local var_269_3, var_269_4 = sampGetCharHandleBySampPlayerId(var_269_2)

							if var_269_3 then
								local var_269_5, var_269_6, var_269_7 = getCharCoordinates(var_269_4)
								local var_269_8, var_269_9, var_269_10 = getCharCoordinates(playerPed)
								local var_269_11 = getDistanceBetweenCoords3d(var_269_5, var_269_6, var_269_7, var_269_8,
									var_269_9, var_269_10)

								if var_269_11 and var_269_11 <= 100 then
									sampSendChat("/ps " .. var_269_2)
									chat("������ ������������ " .. sampGetPlayerNickname(var_269_2))

									pskl = pskl + 1

									wait(p(1000))
								end
							end
						end
					end
				end

				if pskl == 0 then
					am("���������� ��� �����������.")
				end

				if pskl > 0 then
					am("���� ��������.")
				end
			end)
		end)
		_G.sampRegisterChatCommand("m", function(arg_270_0)
			if _G.mass[mkey] then
				sampSendChat("/m " .. arg_270_0)

				meg = {
					"m1",
					"m2",
					"m3",
					"m4",
					"m5",
					"m6",
					"m7",
					"m8",
					"m9"
				}
				smeg = math.random(1, 9)
				sound_meg = meg[smeg] .. ".mp3"

				if #arg_270_0 > 0 and sound_meg ~= nil and isCharInAnyPoliceVehicle(playerPed) then
					local var_270_0 = var_0_9.BASS_StreamCreateFile(false,
						"moonloader/PD-Project/resource/m/" .. sound_meg, 0, 0, 0)

					var_0_9.BASS_ChannelSetAttribute(var_270_0, BASS_ATTRIB_VOL, im.sounds.volume.v)
					var_0_9.BASS_ChannelPlay(var_270_0, false)
				end
			end
		end)
		_G.sampRegisterChatCommand("pt", function()
			if _G.mass[mkey] then
				table.sort(patrol, function(arg_272_0, arg_272_1)
					return arg_272_0[1] > arg_272_1[1]
				end)

				local var_271_0 = {}

				for iter_271_0, iter_271_1 in pairs(patrol) do
					table.insert(var_271_0, iter_271_1[2])
				end

				remu_pol()
				sampShowDialog(202, "������� � ������", "������\t������\t�����\n" .. table.concat(var_271_0, "\n"), "Ok",
					"Cancel", 5)
			end
		end)

		massi()

		alns()


		_G.sampRegisterChatCommand("rhi", function(arg_273_0)
			if _G.mass[mkey] then
				lua_thread.create(function()
					if arg_273_0 ~= nil then
						oRang = nil
						fRang = nil
						oID = arg_273_0
						oNick = sampGetPlayerNickname(oID)
						oks_state = true

						sampSendSystemChat("/members 1")

						while oRang == nil do
							wait(0)
						end

						if oRang ~= nil then
							fRang = oRang

							if rhiData and rhiData[oNick] then
								while ms < 1200 + sampGetPlayerPing(myID) do
									wait(10)
								end

								sampSendChat("/r " ..
								u8:decode(se.main.tag) ..
								" �����������, " .. rhiData[oNick] .. " " .. oNick:gsub(".*_", "") .. ".")
							else
								while ms < 1200 + sampGetPlayerPing(myID) do
									wait(10)
								end

								if rhiData[fRang] and rhiData[fRang] ~= "" then
									sampSendChat("/r " ..
									u8:decode(se.main.tag) ..
									" �����������, " .. rhiData[fRang] .. " " .. oNick:gsub(".*_", "") .. ".")
								elseif rhiChangeRanks[fRang] then
									sampSendChat("/r " ..
									u8:decode(se.main.tag) ..
									" �����������, " .. rhiChangeRanks[fRang] .. " " .. oNick:gsub(".*_", "") .. ".")
								else
									sampSendChat("/r " ..
									u8:decode(se.main.tag) ..
									" �����������, " .. fRang .. " " .. oNick:gsub(".*_", "") .. ".")
								end
							end
						end
					end
				end)
			end
		end)
		_G.sampRegisterChatCommand("ce", function(arg_275_0)
			if _G.mass[mkey] then
				if arg_275_0 ~= "" and sampIsPlayerConnected(arg_275_0) then
					local var_275_0 = sampGetPlayerNickname(arg_275_0):gsub("_", " ")
					local var_275_1, var_275_2 = sampGetCharHandleBySampPlayerId(arg_275_0)

					if var_275_0 ~= nil and var_275_1 and var_275_2 ~= nil then
						if isCharInAnyCar(var_275_2) then
							local var_275_3 = getGxtText(getNameOfVehicleModel(getCarModel(storeCarCharIsInNoSave(
							var_275_2))))

							lua_thread.create(function()
								if isCharInAnyMoto(var_275_2) then
									local var_276_0 = getEditByCode("other.scemoto", 1):gsub("{name}", var_275_0):gsub(
									"{car}", var_275_3)

									sampSendSystemChat(var_276_0)
								else
									local var_276_1 = getEditByCode("hotkey_z.z6", 1):gsub("{name}", var_275_0):gsub(
									"{car}", var_275_3)

									sampSendSystemChat(var_276_1)
								end

								wait(p(500))
								sampSendChat("/ceject " .. arg_275_0)
							end)
						else
							am("����� ������ ���������� � ����������.")
						end
					else
						am("ID ������ �������.")
					end
				else
					chat("    �������: /ce [ID] - ����� �������� ������ �� ������ � ����������", -1)
				end
			end
		end)
		_G.sampRegisterChatCommand("sce", sce)
		_G.sampRegisterChatCommand("mswi", function()
			if _G.mass[mkey] then
				mouseCoord = true
			end
		end)
		_G.sampRegisterChatCommand("mswt", function()
			if _G.mass[mkey] then
				mouseCoord2 = true
			end
		end)
		_G.sampRegisterChatCommand("mswp", function()
			if _G.mass[mkey] then
				mouseCoord3 = true
			end
		end)
		_G.sampRegisterChatCommand("op", function(arg_280_0)
			if _G.mass[mkey] then
				if #arg_280_0 > 0 then
					local var_280_0 = arg_280_0:match("(%d)%s.*")

					if var_280_0 == "1" then
						if srv_name == "revolution" then
							local var_280_1, var_280_2, var_280_3 = arg_280_0:match("(%d) (%d%.%d%.%d) (%d+)")

							if var_280_1 ~= nil and var_280_2 ~= nil and var_280_3 ~= nil then
								if sampIsPlayerConnected(tonumber(var_280_3)) then
									local var_280_4 = sampGetPlayerNickname(var_280_3):gsub("_", " ")

									if var_280_4 ~= nil then
										sampSendChat(string.format(
										"/dep Mayor, ��. ���� �%d \"%s\" �������� ������ ��� [%s]", var_280_3, var_280_4,
											var_280_2))
									end
								else
									chat("��������� ����� �� ��������.")
								end
							else
								chat("�����������: /op [���������� ����������� ���] [�������] [id1] [id2] [id3]", -1)
								chat("����������: /op 1 2.1.1 269", -1)
							end
						end

						if srv_name == "underground" then
							local var_280_5, var_280_6, var_280_7 = arg_280_0:match("(%d) (%d%.%d) (%d+)")

							if var_280_5 ~= nil and var_280_6 ~= nil and var_280_7 ~= nil then
								if sampIsPlayerConnected(tonumber(var_280_7)) then
									local var_280_8 = sampGetPlayerNickname(var_280_7):gsub("_", " ")

									if var_280_8 ~= nil then
										sampSendChat(string.format(
										"/dep Mayor, ��. ���� �%d \"%s\" �������� ������ ��� [%s]", var_280_7, var_280_8,
											var_280_6))
									end
								else
									chat("��������� ����� �� ��������.")
								end
							else
								chat("�����������: /op [���������� ����������� ���] [�������] [id1] [id2] [id3]", -1)
								chat("����������: /op 1 2.1 269", -1)
							end
						end

						if srv_name == "legacy" then
							local var_280_9, var_280_10 = arg_280_0:match("(%d) (%d+)")

							if var_280_9 ~= nil and var_280_10 ~= nil then
								if sampIsPlayerConnected(tonumber(var_280_10)) then
									local var_280_11 = sampGetPlayerNickname(var_280_10):gsub("_", " ")

									if var_280_11 ~= nil then
										sampSendChat(string.format(
										"/dep Mayor, ��. ���� �%d \"%s\" - �� �������� ������������. ���.", var_280_10,
											var_280_11))
									end
								else
									chat("��������� ����� �� ��������.")
								end
							else
								chat("�����������: /op [���������� ����������� ���] [id1] [id2] [id3]", -1)
								chat("����������: /op 1 269", -1)
							end
						end

						if srv_name == "evolve" then
							local var_280_12, var_280_13 = arg_280_0:match("(%d) (%d+)")

							if var_280_12 ~= nil and var_280_13 ~= nil then
								if sampIsPlayerConnected(tonumber(var_280_13)) then
									local var_280_14 = sampGetPlayerNickname(var_280_13):gsub("_", " ")

									if var_280_14 ~= nil then
										sampSendChat(string.format(
										"/dep Mayor, ��. ���� �%d \"%s\" - �� �������� ������������. ���.", var_280_13,
											var_280_14))
									end
								else
									chat("��������� ����� �� ��������.")
								end
							else
								chat("�����������: /op [���������� ����������� ���] [id1] [id2] [id3]", -1)
								chat("����������: /op 1 269", -1)
							end
						end
					end

					if var_280_0 == "2" then
						if srv_name == "underground" then
							local var_280_15, var_280_16, var_280_17, var_280_18 = arg_280_0:match(
							"(%d) (%d%.%d) (%d+) (%d+)")

							if var_280_15 ~= nil and var_280_16 ~= nil and var_280_17 ~= nil and var_280_18 ~= nil then
								if sampIsPlayerConnected(tonumber(var_280_17)) and sampIsPlayerConnected(tonumber(var_280_18)) then
									local var_280_19 = sampGetPlayerNickname(var_280_17):gsub("_", " ")
									local var_280_20 = sampGetPlayerNickname(var_280_18):gsub("_", " ")

									if var_280_19 ~= nil and var_280_20 ~= nil then
										sampSendChat(string.format(
										"/dep Mayor, ��. ���� �%d \"%s\" & �%d \"%s\" - ��� [%s]", var_280_17, var_280_19,
											var_280_18, var_280_20, var_280_16))
									end
								else
									chat("���� �� ������� ����������.")
								end
							else
								chat("�����������: /op [���������� ����������� ���] [�������] [id1] [id2] [id3]", -1)
								chat("����������: /op 2 2.1 269 176", -1)
							end
						end

						if srv_name == "revolution" then
							local var_280_21, var_280_22, var_280_23, var_280_24 = arg_280_0:match(
							"(%d) (%d%.%d%.%d) (%d+) (%d+)")

							if var_280_21 ~= nil and var_280_22 ~= nil and var_280_23 ~= nil and var_280_24 ~= nil then
								if sampIsPlayerConnected(tonumber(var_280_23)) and sampIsPlayerConnected(tonumber(var_280_24)) then
									local var_280_25 = sampGetPlayerNickname(var_280_23):gsub("_", " ")
									local var_280_26 = sampGetPlayerNickname(var_280_24):gsub("_", " ")

									if var_280_25 ~= nil and var_280_26 ~= nil then
										sampSendChat(string.format(
										"/dep Mayor, ��. ���� �%d \"%s\" & �%d \"%s\" - ��� [%s]", var_280_23, var_280_25,
											var_280_24, var_280_26, var_280_22))
									end
								else
									chat("���� �� ������� ����������.")
								end
							else
								chat("�����������: /op [���������� ����������� ���] [�������] [id1] [id2] [id3]", -1)
								chat("����������: /op 2 2.1.2 269 176", -1)
							end
						end

						if srv_name == "legacy" then
							local var_280_27, var_280_28, var_280_29 = arg_280_0:match("(%d) (%d+) (%d+)")

							if var_280_27 ~= nil and var_280_28 ~= nil and var_280_29 ~= nil then
								if sampIsPlayerConnected(tonumber(var_280_28)) and sampIsPlayerConnected(tonumber(var_280_29)) then
									local var_280_30 = sampGetPlayerNickname(var_280_28):gsub("_", " ")
									local var_280_31 = sampGetPlayerNickname(var_280_29):gsub("_", " ")

									if var_280_30 ~= nil and var_280_31 ~= nil then
										sampSendChat(string.format("/dep Mayor, ��. ���� �%d \"%s\" & �%d \"%s\" - ���.",
											var_280_28, var_280_30, var_280_29, var_280_31))
									end
								else
									chat("���� �� ������� ����������.")
								end
							else
								chat("�����������: /op [���������� ����������� ���] [id1] [id2] [id3]", -1)
								chat("����������: /op 2 269 176", -1)
							end
						end

						if srv_name == "evolve" then
							local var_280_32, var_280_33, var_280_34 = arg_280_0:match("(%d) (%d+) (%d+)")

							if var_280_32 ~= nil and var_280_33 ~= nil and var_280_34 ~= nil then
								if sampIsPlayerConnected(tonumber(var_280_33)) and sampIsPlayerConnected(tonumber(var_280_34)) then
									local var_280_35 = sampGetPlayerNickname(var_280_33):gsub("_", " ")
									local var_280_36 = sampGetPlayerNickname(var_280_34):gsub("_", " ")

									if var_280_35 ~= nil and var_280_36 ~= nil then
										sampSendChat(string.format("/dep Mayor, ��. ���� �%d \"%s\" & �%d \"%s\" - ���.",
											var_280_33, var_280_35, var_280_34, var_280_36))
									end
								else
									chat("���� �� ������� ����������.")
								end
							else
								chat("�����������: /op [���������� ����������� ���] [id1] [id2] [id3]", -1)
								chat("����������: /op 2 269 176", -1)
							end
						end
					end

					if var_280_0 == "3" then
						if srv_name == "underground" then
							local var_280_37, var_280_38, var_280_39, var_280_40, var_280_41 = arg_280_0:match(
							"(%d) (%d%.%d) (%d+) (%d+) (%d+)")

							if var_280_37 ~= nil and var_280_38 ~= nil and var_280_39 ~= nil and var_280_40 ~= nil and var_280_41 ~= nil then
								if sampIsPlayerConnected(tonumber(var_280_39)) and sampIsPlayerConnected(tonumber(var_280_40)) and sampIsPlayerConnected(tonumber(var_280_41)) then
									local var_280_42 = sampGetPlayerNickname(var_280_39)
									local var_280_43 = sampGetPlayerNickname(var_280_40)
									local var_280_44 = sampGetPlayerNickname(var_280_41)

									if var_280_42 ~= nil and var_280_43 ~= nil and var_280_44 ~= nil then
										local var_280_45, var_280_46 = var_280_42:match("(%u).*%_(.*)")
										local var_280_47, var_280_48 = var_280_43:match("(%u).*%_(.*)")
										local var_280_49, var_280_50 = var_280_44:match("(%u).*%_(.*)")
										local var_280_51 = var_280_45 .. "." .. var_280_46
										local var_280_52 = var_280_47 .. "." .. var_280_48
										local var_280_53 = var_280_49 .. "." .. var_280_50

										sampSendChat("/dep Mayor, ��. ���� �" ..
										var_280_39 ..
										" \"" ..
										var_280_51 ..
										"\" & �" ..
										var_280_40 ..
										" \"" ..
										var_280_52 ..
										"\" & �" ..
										var_280_41 .. " \"" .. var_280_53 .. "\" - ��� [" .. var_280_38 .. "]")
									end
								else
									chat("���� �� ������� ����������.")
								end
							else
								chat("�����������: /op [���������� ����������� ���] [�������] [id1] [id2] [id3]", -1)
								chat("����������: /op 3 2.1 269 176 587", -1)
							end
						end

						if srv_name == "revolution" then
							local var_280_54, var_280_55, var_280_56, var_280_57, var_280_58 = arg_280_0:match(
							"(%d) (%d%.%d%.%d) (%d+) (%d+) (%d+)")

							if var_280_54 ~= nil and var_280_55 ~= nil and var_280_56 ~= nil and var_280_57 ~= nil and var_280_58 ~= nil then
								if sampIsPlayerConnected(tonumber(var_280_56)) and sampIsPlayerConnected(tonumber(var_280_57)) and sampIsPlayerConnected(tonumber(var_280_58)) then
									local var_280_59 = sampGetPlayerNickname(var_280_56)
									local var_280_60 = sampGetPlayerNickname(var_280_57)
									local var_280_61 = sampGetPlayerNickname(var_280_58)

									if var_280_59 ~= nil and var_280_60 ~= nil and var_280_61 ~= nil then
										local var_280_62, var_280_63 = var_280_59:match("(%u).*%_(.*)")
										local var_280_64, var_280_65 = var_280_60:match("(%u).*%_(.*)")
										local var_280_66, var_280_67 = var_280_61:match("(%u).*%_(.*)")
										local var_280_68 = var_280_62 .. "." .. var_280_63
										local var_280_69 = var_280_64 .. "." .. var_280_65
										local var_280_70 = var_280_66 .. "." .. var_280_67

										sampSendChat("/dep Mayor, ��. ���� �" ..
										var_280_56 ..
										" \"" ..
										var_280_68 ..
										"\" & �" ..
										var_280_57 ..
										" \"" ..
										var_280_69 ..
										"\" & �" ..
										var_280_58 .. " \"" .. var_280_70 .. "\" - ��� [" .. var_280_55 .. "]")
									end
								else
									chat("���� �� ������� ����������.")
								end
							else
								chat("�����������: /op [���������� ����������� ���] [�������] [id1] [id2] [id3]", -1)
								chat("����������: /op 3 2.1.5 269 176 587", -1)
							end
						end

						if srv_name == "legacy" then
							local var_280_71, var_280_72, var_280_73, var_280_74 = arg_280_0:match(
							"(%d) (%d+) (%d+) (%d+)")

							if var_280_71 ~= nil and var_280_72 ~= nil and var_280_73 ~= nil and var_280_74 ~= nil then
								if sampIsPlayerConnected(tonumber(var_280_72)) and sampIsPlayerConnected(tonumber(var_280_73)) and sampIsPlayerConnected(tonumber(var_280_74)) then
									local var_280_75 = sampGetPlayerNickname(var_280_72)
									local var_280_76 = sampGetPlayerNickname(var_280_73)
									local var_280_77 = sampGetPlayerNickname(var_280_74)

									if var_280_75 ~= nil and var_280_76 ~= nil and var_280_77 ~= nil then
										local var_280_78, var_280_79 = var_280_75:match("(%u).*%_(.*)")
										local var_280_80, var_280_81 = var_280_76:match("(%u).*%_(.*)")
										local var_280_82, var_280_83 = var_280_77:match("(%u).*%_(.*)")
										local var_280_84 = var_280_78 .. "." .. var_280_79
										local var_280_85 = var_280_80 .. "." .. var_280_81
										local var_280_86 = var_280_82 .. "." .. var_280_83

										sampSendChat("/dep Mayor, ��. ���� �" ..
										var_280_72 ..
										" \"" ..
										var_280_84 ..
										"\" & �" ..
										var_280_73 ..
										" \"" ..
										var_280_85 .. "\" & �" .. var_280_74 .. " \"" .. var_280_86 .. "\" - ���.")
									end
								else
									chat("���� �� ������� ����������.")
								end
							else
								chat("�����������: /op [���������� ����������� ���] [id1] [id2] [id3]", -1)
								chat("����������: /op 3 269 176 587", -1)
							end
						end

						if srv_name == "evolve" then
							local var_280_87, var_280_88, var_280_89, var_280_90 = arg_280_0:match(
							"(%d) (%d+) (%d+) (%d+)")

							if var_280_87 ~= nil and var_280_88 ~= nil and var_280_89 ~= nil and var_280_90 ~= nil then
								if sampIsPlayerConnected(tonumber(var_280_88)) and sampIsPlayerConnected(tonumber(var_280_89)) and sampIsPlayerConnected(tonumber(var_280_90)) then
									local var_280_91 = sampGetPlayerNickname(var_280_88)
									local var_280_92 = sampGetPlayerNickname(var_280_89)
									local var_280_93 = sampGetPlayerNickname(var_280_90)

									if var_280_91 ~= nil and var_280_92 ~= nil and var_280_93 ~= nil then
										local var_280_94, var_280_95 = var_280_91:match("(%u).*%_(.*)")
										local var_280_96, var_280_97 = var_280_92:match("(%u).*%_(.*)")
										local var_280_98, var_280_99 = var_280_93:match("(%u).*%_(.*)")
										local var_280_100 = var_280_94 .. "." .. var_280_95
										local var_280_101 = var_280_96 .. "." .. var_280_97
										local var_280_102 = var_280_98 .. "." .. var_280_99

										sampSendChat("/dep Mayor, ��. ���� �" ..
										var_280_88 ..
										" \"" ..
										var_280_100 ..
										"\" & �" ..
										var_280_89 ..
										" \"" ..
										var_280_101 .. "\" & �" .. var_280_90 .. " \"" .. var_280_102 .. "\" - ���.")
									end
								else
									chat("���� �� ������� ����������.")
								end
							else
								chat("�����������: /op [���������� ����������� ���] [id1] [id2] [id3]", -1)
								chat("����������: /op 3 269 176 587", -1)
							end
						end
					end
				else
					if srv_name == "revolution" or srv_name == "underground" then
						chat("�����������: /op [���������� ����������� ���] [�������] [id1] [id2] [id3]", -1)
					end

					if srv_name == "legacy" then
						chat("�����������: /op [���������� ����������� ���] [id1] [id2] [id3]", -1)
					end

					if srv_name == "evolve" then
						chat("�����������: /op [���������� ����������� ���] [id1] [id2] [id3]", -1)
					end
				end
			end
		end)
		_G.sampRegisterChatCommand("pr", function(arg_281_0)
			if _G.mass[mkey] then
				if tostring(arg_281_0) ~= "" and not tostring(arg_281_0):find("%,") then
					se.main.partner = arg_281_0
					im.informer.infMainPartner.v = arg_281_0

					am("�� ������� ������ ��������� - " .. tostring(arg_281_0) .. ".")
					chat("����� ��� �������� ��������� ��� � �������� ������ ���������, �������� ��������.")
				else
					chat("������� /pr ID ID / ��� /pr N.Name N.Name ����� ������!")
				end
			end
		end)
		_G.sampRegisterChatCommand("mo", function(arg_282_0)
			if _G.mass[mkey] then
				local var_282_0, var_282_1 = arg_282_0:match("(%d+)%s+(.+)")

				if var_282_0 == nil or var_282_1 == nil then
					chat("�������: /mo [1-3] [���������� ����]")
					chat("1 - MO LS | 2 - MO SF | 3 - MO LV")

					return
				end

				if tonumber(var_282_0) ~= nil then
					if tonumber(var_282_0) < 1 or tonumber(var_282_0) > 3 then
						chat(" {FFFFFF}| �������: /mo [1-3] [���������� ����]")
						chat(" {FFFFFF}| 1 - LSPD | 2 - SFPD | 3 - LVPD")
					elseif tonumber(var_282_0) == 1 then
						sampSendChat("/dep LVa, ������� ������ LS ��� ��������, �������� ��������: " .. var_282_1)
					elseif tonumber(var_282_0) == 2 then
						sampSendChat("/dep LVa, ������� ������ SF ��� ��������, �������� ��������: " .. var_282_1)
					elseif tonumber(var_282_0) == 3 then
						sampSendChat("/dep LVa, ������� ������ LV ��� ��������, �������� ��������: " .. var_282_1)
					end
				end
			end
		end)
		_G.sampRegisterChatCommand("ar", function(arg_283_0)
			if _G.mass[mkey] then
				local var_283_0 = arg_283_0:match("(%d+)")

				if var_283_0 == nil then
					chat("�������: /mo [1-2]")
					chat("1 - SFa | 2 - LVa")

					return
				end

				if tonumber(var_283_0) ~= nil then
					if tonumber(var_283_0) < 1 or tonumber(var_283_0) > 2 then
						chat(" {FFFFFF}| �������: /mo [1-2]")
						chat(" {FFFFFF}| 1 - SFa | 2 - LVa ")
					elseif tonumber(var_283_0) == 1 then
						sampSendChat("/dep SFa, ��������� ����� �� ���������� ����? ����� �� �. " .. myID)
					elseif tonumber(var_283_0) == 2 then
						sampSendChat("/dep LVa, ��������� ����� �� ���������� ����? ����� �� �. " .. myID)
					end
				end
			end
		end)
		_G.sampRegisterChatCommand("prn", function(arg_284_0)
			if _G.mass[mkey] then
				if tostring(arg_284_0):len() > 0 then
					if tostring(arg_284_0):find("%d+%s%d+%s%d+") then
						local var_284_0, var_284_1, var_284_2 = tostring(arg_284_0):match("(%d+)%s(%d+)%s(%d+)")

						if var_284_0 and var_284_1 and var_284_2 then
							if var_284_0 ~= var_284_1 and var_284_0 ~= var_284_2 and var_284_1 ~= var_284_2 then
								if sampIsPlayerConnected(var_284_0) and sampIsPlayerConnected(var_284_1) and sampIsPlayerConnected(var_284_2) then
									im.informer.infMainPartner.v = var_284_0

									local var_284_3 = sampGetPlayerNickname(var_284_0)
									local var_284_4 = sampGetPlayerNickname(var_284_1)
									local var_284_5 = sampGetPlayerNickname(var_284_2)
									local var_284_6 = var_284_3:match("(%u)%a+%_%u%a+") ..
									"." .. var_284_3:match("%u%a+%_(%u%a+)")
									local var_284_7 = var_284_4:match("(%u)%a+%_%u%a+") ..
									"." .. var_284_4:match("%u%a+%_(%u%a+)")
									local var_284_8 = var_284_5:match("(%u)%a+%_%u%a+") ..
									"." .. var_284_5:match("%u%a+%_(%u%a+)")

									if var_284_6 and var_284_7 and var_284_8 then
										se.main.partner = var_284_6 .. ", " .. var_284_7 .. ", " .. var_284_8

										chat("�� ���������� ����������: " .. se.main.partner)
									end
								else
									chat("���� �� ������ ����������.")
								end
							else
								chat("ID ������� �����������.")
							end
						end
					elseif tostring(arg_284_0):find("%d+%s%d+") then
						local var_284_9, var_284_10 = tostring(arg_284_0):match("(%d+)%s(%d+)")

						if var_284_9 and var_284_10 then
							if var_284_9 ~= var_284_10 then
								if sampIsPlayerConnected(var_284_9) and sampIsPlayerConnected(var_284_10) then
									local var_284_11 = sampGetPlayerNickname(var_284_9)
									local var_284_12 = sampGetPlayerNickname(var_284_10)
									local var_284_13 = var_284_11:match("(%u)%a+%_%u%a+") ..
									"." .. var_284_11:match("%u%a+%_(%u%a+)")
									local var_284_14 = var_284_12:match("(%u)%a+%_%u%a+") ..
									"." .. var_284_12:match("%u%a+%_(%u%a+)")

									if var_284_13 and var_284_14 then
										se.main.partner = var_284_13 .. ", " .. var_284_14

										chat("�� ���������� ����������: " .. se.main.partner)
									end
								else
									chat("���� �� ������ ����������.")
								end
							else
								chat("ID ������� �����������.")
							end
						end
					elseif tostring(arg_284_0):find("%d+") then
						local var_284_15 = tostring(arg_284_0):match("(%d+)")

						if var_284_15 then
							if sampIsPlayerConnected(var_284_15) then
								local var_284_16 = sampGetPlayerNickname(var_284_15)
								local var_284_17 = var_284_16:match("(%u)%a+%_%u%a+") ..
								"." .. var_284_16:match("%u%a+%_(%u%a+)")

								if var_284_17 then
									se.main.partner = var_284_17

									chat("�� ���������� ���������: " .. se.main.partner)
								end
							else
								chat("����� ����������.")
							end
						end
					else
						chat("������� /prn ID [1-3]")
					end
				else
					chat("������� /prn ID [1-3]")
				end
			end
		end)
		_G.sampRegisterChatCommand("mrk", function(arg_285_0)
			if _G.mass[mkey] then
				if #arg_285_0 > 0 then
					se.main.area = arg_285_0

					am("�� ���������� ����������: " .. string.upper(arg_285_0) .. ".")
				else
					chat("���������� ���������� - /mrk MARK")
				end
			end
		end)
		_G.sampRegisterChatCommand("off", function()
			printStringNow("~b~PD-PROJECT ~g~FINISHED", 3000)

			active = false

			sampTextdrawDelete(1)
			sampTextdrawDelete(2)
			thisScript():unload()
		end)
		_G.sampRegisterChatCommand("ss", ss)
		_G.sampRegisterChatCommand("taz", function()
			if _G.mass[mkey] then
				if se.main.tazer then
					se.main.tazer = false

					am("������ ������ �����.")
				else
					se.main.tazer = true

					am("������ ������ �������.")
				end
			end
		end)
		_G.sampRegisterChatCommand("tt", function(arg_288_0)
			if tostring(arg_288_0):len() > 0 then
				if sampIsPlayerConnected(arg_288_0) then
					ticket_id = arg_288_0
					ticket_name = sampGetPlayerNickname(arg_288_0):gsub("_", " ")
					ticket_lvl = sampGetPlayerScore(arg_288_0)

					local var_288_0 = tickets(ticket_lvl)

					tickforcom = {}

					if var_288_0 then
						table.sort(var_288_0, function(arg_289_0, arg_289_1)
							return arg_289_0[1] < arg_289_1[1]
						end)

						ticksfortab = {}

						for iter_288_0, iter_288_1 in pairs(var_288_0) do
							table.insert(ticksfortab,
								"�" .. iter_288_1[1] .. "\t" .. iter_288_1[2] .. "\t" .. iter_288_1[3])
							table.insert(tickforcom,
								iter_288_1[3] .. " ������ �" .. iter_288_1[1] .. " �" .. iter_288_1[2] .. "�")
						end

						sampShowDialog(8729, "{FFFFFF}����� �� ��� " .. ticket_name .. ", �������� " .. ticket_lvl,
							"����� ������\t�������� ������\t������ ������\n" .. table.concat(ticksfortab, "\n"),
							"��������", "�������", 5)
					end
				else
					chat("��������� ����� �� ��������.")
				end
			else
				chat("������� /tt [ID], ����� �������� �����.")
			end
		end)
		_G.sampRegisterChatCommand("pd", mainmenu)
		_G.sampRegisterChatCommand("depjur", function(arg_290_0)
			if _G.mass[mkey] then
				if arg_290_0:len() > 0 then
					if se.main.partner == "0" or se.main.partner == "" or se.main.partner == nil then
						sampSendChat("/dep FBI, ��������� ������� ����������. �������: " .. arg_290_0 .. ".")
					else
						sampSendChat("/dep FBI, ���������� ������� ����������. �������: " ..
						arg_290_0 .. ". ���������: " .. se.main.partner .. ".")
					end
				else
					sampSendChat("/dep FBI, ���������� ������� ����������. ����� ������.")
				end
			end
		end)
		_G.sampRegisterChatCommand("delmark", function()
			if _G.mass[mkey] then
				sampDestroy3dText(marker)
			end
		end)
		_G.sampRegisterChatCommand("showranks", function()
			if _G.mass[mkey] then
				se.main.showranks = true

				sampSendSystemChat("/members 1")
			end
		end)
		_G.sampRegisterChatCommand("delranks", function()
			if _G.mass[mkey] then
				se.main.showranks = false

				for iter_293_0, iter_293_1 in pairs(plmarks) do
					sampDestroy3dText(iter_293_1)
				end
			end
		end)
		_G.sampRegisterChatCommand("showhud", function()
			if _G.mass[mkey] then
				displayHud(true)
			end
		end)
		_G.sampRegisterChatCommand("hidehud", function()
			if _G.mass[mkey] then
				displayHud(false)
			end
		end)
		getPayCheck()
		getRank()

		if se.main.equest then
			getEquest()
		end

		getWanted()
		lua_thread.create(strobe)

		if not doesFileExist("moonloader/PD-Project/sys/ekgs_uk.txt") then
			sequent_async_http_request("GET", "https://pdp-samp.online/scripts/PDProject/" .. srv_name .. "/ekgs_uk.txt",
				nil, function(arg_296_0)
				local var_296_0 = io.open("moonloader/PD-Project/sys/ekgs_uk.txt", "w+")

				if var_296_0 then
					var_296_0:write(arg_296_0.text ..
					"\n\n������ ����� ����� �������� � ����� moonloader/PD-Project/sys/ekgs_uk.txt")
				end

				ekgs_uk = arg_296_0.text

				local var_296_1 = arg_296_0.text

				ekgs_uk_arr = {}

				local var_296_2 = 0

				for iter_296_0 in var_296_1:gmatch("[^\r\n]+") do
					ekgs_uk_arr[var_296_2] = iter_296_0
					var_296_2 = var_296_2 + 1
				end
			end)
		else
			ekgs_uk = io.open("moonloader/PD-Project/sys/ekgs_uk.txt", "r"):read("*a")
			ekgs_uk_arr = {}

			local var_231_12 = 0

			for iter_231_6 in ekgs_uk:gmatch("[^\r\n]+") do
				ekgs_uk_arr[var_231_12] = iter_231_6
				var_231_12 = var_231_12 + 1
			end
		end

		if not doesFileExist("moonloader/PD-Project/sys/ekgs.txt") then
			sequent_async_http_request("GET", "https://pdp-samp.online/scripts/PDProject/" .. srv_name .. "/ekgs.txt",
				nil, function(arg_297_0)
				local var_297_0 = io.open("moonloader/PD-Project/sys/ekgs.txt", "w+")

				if var_297_0 then
					var_297_0:write(arg_297_0.text ..
					"\n\n������ ����� ����� �������� � ����� moonloader/PD-Project/sys/ekgs.txt")
				end

				ekgs = arg_297_0.text

				local var_297_1 = arg_297_0.text

				ekgs_arr = {}

				local var_297_2 = 0

				for iter_297_0 in var_297_1:gmatch("[^\r\n]+") do
					ekgs_arr[var_297_2] = iter_297_0
					var_297_2 = var_297_2 + 1
				end
			end)
		else
			ekgs = io.open("moonloader/PD-Project/sys/ekgs.txt", "r"):read("*a")
			ekgs_arr = {}

			local var_231_13 = 0

			for iter_231_7 in ekgs:gmatch("[^\r\n]+") do
				ekgs_arr[var_231_13] = iter_231_7
				var_231_13 = var_231_13 + 1
			end
		end

		if not doesFileExist("moonloader/PD-Project/sys/ekgs_ak.txt") then
			sequent_async_http_request("GET", "https://pdp-samp.online/scripts/PDProject/" .. srv_name .. "/ekgs_ak.txt",
				nil, function(arg_298_0)
				local var_298_0 = io.open("moonloader/PD-Project/sys/ekgs_ak.txt", "w+")

				if var_298_0 then
					var_298_0:write(arg_298_0.text ..
					"\n\n������ ����� ����� �������� � ����� moonloader/PD-Project/sys/ekgs_ak.txt")
				end

				ekgs_ak = arg_298_0.text

				local var_298_1 = arg_298_0.text

				ekgs_ak_arr = {}

				local var_298_2 = 0

				for iter_298_0 in var_298_1:gmatch("[^\r\n]+") do
					ekgs_ak_arr[var_298_2] = iter_298_0
					var_298_2 = var_298_2 + 1
				end
			end)
		else
			ekgs_ak = io.open("moonloader/PD-Project/sys/ekgs_ak.txt", "r"):read("*a")
			ekgs_ak_arr = {}

			local var_231_14 = 0

			for iter_231_8 in ekgs_ak:gmatch("[^\r\n]+") do
				ekgs_ak_arr[var_231_14] = iter_231_8
				var_231_14 = var_231_14 + 1
			end
		end

		if not doesFileExist("moonloader/PD-Project/sys/federal_p.txt") then
			sequent_async_http_request("GET",
				"https://pdp-samp.online/scripts/PDProject/" .. srv_name .. "/federal_p.txt", nil, function(arg_299_0)
				local var_299_0 = io.open("moonloader/PD-Project/sys/federal_p.txt", "w+")

				if var_299_0 then
					var_299_0:write(arg_299_0.text ..
					"\n\n������ ����� ����� �������� � ����� moonloader/PD-Project/sys/federal_p.txt")
				end

				federal_p = arg_299_0.text

				local var_299_1 = arg_299_0.text

				federal_p_arr = {}

				local var_299_2 = 0

				for iter_299_0 in var_299_1:gmatch("[^\r\n]+") do
					federal_p_arr[var_299_2] = iter_299_0
					var_299_2 = var_299_2 + 1
				end
			end)
		else
			federal_p = io.open("moonloader/PD-Project/sys/federal_p.txt", "r"):read("*a")
			federal_p_arr = {}

			local var_231_15 = 0

			for iter_231_9 in federal_p:gmatch("[^\r\n]+") do
				federal_p_arr[var_231_15] = iter_231_9
				var_231_15 = var_231_15 + 1
			end
		end

		if not doesFileExist("moonloader/PD-Project/sys/sf_manual.txt") then
			sequent_async_http_request("GET",
				"https://pdp-samp.online/scripts/PDProject/" .. srv_name .. "/sf_manual.txt", nil, function(arg_300_0)
				local var_300_0 = io.open("moonloader/PD-Project/sys/sf_manual.txt", "w+")

				if var_300_0 then
					var_300_0:write(arg_300_0.text ..
					"\n\n������ ����� ����� �������� � ����� moonloader/PD-Project/sys/sf_manual.txt")
				end

				sf_manual = arg_300_0.text

				local var_300_1 = arg_300_0.text

				sf_manual_arr = {}

				local var_300_2 = 0

				for iter_300_0 in var_300_1:gmatch("[^\r\n]+") do
					sf_manual_arr[var_300_2] = iter_300_0
					var_300_2 = var_300_2 + 1
				end
			end)
		else
			sf_manual = io.open("moonloader/PD-Project/sys/sf_manual.txt", "r"):read("*a")
			sf_manual_arr = {}

			local var_231_16 = 0

			for iter_231_10 in sf_manual:gmatch("[^\r\n]+") do
				sf_manual_arr[var_231_16] = iter_231_10
				var_231_16 = var_231_16 + 1
			end
		end

		if not doesFileExist("moonloader/PD-Project/sys/lv_manual.txt") then
			sequent_async_http_request("GET",
				"https://pdp-samp.online/scripts/PDProject/" .. srv_name .. "/lv_manual.txt", nil, function(arg_301_0)
				local var_301_0 = io.open("moonloader/PD-Project/sys/lv_manual.txt", "w+")

				if var_301_0 then
					var_301_0:write(arg_301_0.text ..
					"\n\n������ ����� ����� �������� � ����� moonloader/PD-Project/sys/lv_manual.txt")
				end

				lv_manual = arg_301_0.text

				local var_301_1 = arg_301_0.text

				lv_manual_arr = {}

				local var_301_2 = 0

				for iter_301_0 in var_301_1:gmatch("[^\r\n]+") do
					lv_manual_arr[var_301_2] = iter_301_0
					var_301_2 = var_301_2 + 1
				end
			end)
		else
			lv_manual = io.open("moonloader/PD-Project/sys/lv_manual.txt", "r"):read("*a")
			lv_manual_arr = {}

			local var_231_17 = 0

			for iter_231_11 in lv_manual:gmatch("[^\r\n]+") do
				lv_manual_arr[var_231_17] = iter_231_11
				var_231_17 = var_231_17 + 1
			end
		end

		if not doesFileExist("moonloader/PD-Project/sys/ls_manual.txt") then
			sequent_async_http_request("GET",
				"https://pdp-samp.online/scripts/PDProject/" .. srv_name .. "/ls_manual.txt", nil, function(arg_302_0)
				local var_302_0 = io.open("moonloader/PD-Project/sys/ls_manual.txt", "w+")

				if var_302_0 then
					var_302_0:write(arg_302_0.text ..
					"\n\n������ ����� ����� �������� � ����� moonloader/PD-Project/sys/ls_manual.txt")
				end

				ls_manual = arg_302_0.text

				local var_302_1 = arg_302_0.text

				ls_manual_arr = {}

				local var_302_2 = 0

				for iter_302_0 in var_302_1:gmatch("[^\r\n]+") do
					ls_manual_arr[var_302_2] = iter_302_0
					var_302_2 = var_302_2 + 1
				end
			end)
		else
			ls_manual = io.open("moonloader/PD-Project/sys/ls_manual.txt", "r"):read("*a")
			ls_manual_arr = {}

			local var_231_18 = 0

			for iter_231_12 in ls_manual:gmatch("[^\r\n]+") do
				ls_manual_arr[var_231_18] = iter_231_12
				var_231_18 = var_231_18 + 1
			end
		end

		if not doesFileExist("moonloader/PD-Project/sys/fbi_manual.txt") then
			sequent_async_http_request("GET",
				"https://pdp-samp.online/scripts/PDProject/" .. srv_name .. "/fbi_manual.txt", nil, function(arg_303_0)
				local var_303_0 = io.open("moonloader/PD-Project/sys/fbi_manual.txt", "w+")

				if var_303_0 then
					var_303_0:write(arg_303_0.text ..
					"\n\n������ ����� ����� �������� � ����� moonloader/PD-Project/sys/fbi_manual.txt")
				end

				fbi_manual = arg_303_0.text

				local var_303_1 = arg_303_0.text

				fbi_manual_arr = {}

				local var_303_2 = 0

				for iter_303_0 in var_303_1:gmatch("[^\r\n]+") do
					fbi_manual_arr[var_303_2] = iter_303_0
					var_303_2 = var_303_2 + 1
				end
			end)
		else
			fbi_manual = io.open("moonloader/PD-Project/sys/fbi_manual.txt", "r"):read("*a")
			fbi_manual_arr = {}

			local var_231_19 = 0

			for iter_231_13 in fbi_manual:gmatch("[^\r\n]+") do
				fbi_manual_arr[var_231_19] = iter_231_13
				var_231_19 = var_231_19 + 1
			end
		end

		print("Waiting for info about system..")

		local var_231_20 = {
			data = "s=" .. select(1, sampGetCurrentServerAddress()) .. ":" .. select(2, sampGetCurrentServerAddress()),
			headers = {
				["content-type"] = "application/x-www-form-urlencoded"
			}
		}

		var_0_33 = {}

		while not var_0_33 do
			wait(100)
		end

		print("Info about system gotten.")

		houses, hclass = {}, {}

		police_cars = decodeJson('{"391":497,"392":497,"402":421,"403":405,"404":402,"405":402,"406":402,"407":551,"408":426,"420":402,"421":402,"422":402,"423":551,"429":421,"424":405,"430":426,"443":497,"444":497,"445":497,"446":497,"469":551,"470":421,"471":426,"472":405,"473":402,"474":402,"475":402,"476":497,"477":497,"478":560,"489":521,"490":521,"491":521,"492":560,"493":560,"494":415,"495":415,"499":482,"500":482,"501":482}')

		lua_thread.create(checkteam)

		as.threads.checkMessages = {
			handle = lua_thread.create(checkMessages),
			started = os.time()
		}
		as.threads.sirenColor = {
			handle = lua_thread.create(sirenColor),
			started = os.time()
		}

		getChatRules()

		as.fastmap.mapmode = 0
		as.fastmap.modX = 2
		as.fastmap.modY = 2
		as.fastmap.active = false

		fastmap_init()
		lua_thread.create(fastmap_viewer)

		if se and se.main.fastmap_start and se.main.fastmap then
			as.fastmap.first_start = false

			fastmap()

			as.fastmap.first_start = true
		end

		slc = var_0_0.ImInt(0)
		sendtime = os.clock() * 1000
		lastactivity = os.time()
		hotB = {
			"'1' - ����������� � ���. ����� ������ � �������",
			"'2' - ���������� ���������� �� �����",
			"'3' - �������� ����� �� �����",
			"'4' - ������� �������� � �������� ������",
			"'5' - ������ ������ ���������",
			"'6' - ��������� ��������",
			"'7' - ������ ������ � ��������� ������",
			"'8' - ������ ������ ������",
			"'9' - ��������� ������",
			"'0' - ���������� ������ �� �� ��������"
		}
		hotX = {
			"'1' - �������� � ������ � ������� [����������: " ..
			string.upper(se.main.area) .. ". ��������: " .. (se.main.partner and se.main.partner or "-") .. "]",
			"'2' - �������� � ��������� ������� [����������: " ..
			string.upper(se.main.area) .. ". ��������: " .. (se.main.partner and se.main.partner or "-") .. "]",
			"'3' - �������� �� ��������� ������� [����������: " ..
			string.upper(se.main.area) .. ". ��������: " .. (se.main.partner and se.main.partner or "-") .. "]",
			"'4' - ��������� SOS � ����� � ���������� ��.",
			"'5' - ��������� SOS � ����� � ���������� ����.",
			"'6' - ��������� SOS � ����� � ���������� �������� 24/7.",
			"'7' - �������� � ����� ������"
		}
		hotKeys = {
			"'" .. tostring(se.keys.pursuit_su) .. "' - ������ � ������ �������� �� '����'",
			"'" .. tostring(se.keys.pursuit_mdc) .. "' - ��������� �� ���� [/mdc]",
			"'" .. tostring(se.keys.pursuit_55) .. "' - �������� � ������-�����",
			"'" .. tostring(se.keys.pursuit_66) .. "' - �������� � ������-����� ����������� �����",
			"'" .. tostring(se.keys.pursuit_koord) .. "' - �����������",
			"'" .. tostring(se.keys.pursuit_oralo) .. "' - ���������� ���������",
			"'" .. tostring(se.keys.pursuit_oralo2) .. "' - ���������� ����� ���������",
			"'" .. tostring(se.keys.fsquad) .. "' - �������������� � SQUAD",
			"'" .. tostring(se.keys.pursuit_ps) .. "' - ��������� /ps",
			"'" .. tostring(se.keys.pursuit_patrul) .. "' - ��������� /patrul",
			"'" .. tostring(se.keys.pursuit_fast_stop) .. "' - ��������� ������������� ��� �������",
			"'" .. tostring(se.keys.pursuit_stop) .. "' - ��������� �������������"
		}
		hotZ = {
			"'1' - ��������� /do ������ ������",
			"'2' - �������� ������� �������",
			"'3' - �������� " .. (tencodes.sos ~= "" and tencodes.sos or "SOS") .. " � ������������",
			"'4' - �������� � ������-����� ����������� ����� � �������",
			"'5' - ���������� �������� �� ����",
			"'6' - �������� ������������ �� ������",
			"'7' - �������� �������� ������������ �� ������",
			"'8' - �������� �������� ���������� (����� ���������� � ���������)"
		}
		hotTarget = {
			"'" .. tostring(se.keys.target_cuff) .. "' - ������ ���������",
			"'" .. tostring(se.keys.target_uncuff) .. "' - ����� ���������",
			"'" ..
			tostring(se.keys.target_follow) ..
			"' - " .. (as.other.follow and "���������� �� ����" or "����� �� �����") .. "",
			"'" .. tostring(se.keys.target_cput) .. "' - �������� � ������",
			"'" .. tostring(se.keys.target_frisk) .. "' - ��������",
			"'" .. tostring(se.keys.target_arrest) .. "' - �������� � ������",
			"'" .. tostring(se.keys.target_su) .. "' - ������ � ������",
			"'" .. tostring(se.keys.target_oop) .. "' - �������� ���",
			"'" .. tostring(se.keys.interplay) .. "' - ��������������",
			"'" .. tostring(se.keys.target_mask) .. "' - ������� �����",
			"'" .. tostring(se.keys.target_ps) .. "' - ������� /ps",
			"'" .. tostring(se.keys.target_ticket) .. "' - �������� �����"
		}

		if im.windows.speedometr.v then
			onceDeleteSpeedometer()
		end

		while true do
			wait(0)

			lastactivity = os.time()
			ms = os.clock() * 1000 - sendtime

			while letsGame == false do
				wait(10)
			end

			while sampGetGamestate() ~= 3 do
				wait(10)
			end

			as.other.ongametime = os.time() - onstarttime

			if as.other.ongameactualdate ~= os.date("%Y%m%d") then
				setGameTime(true)
			end

			if im.informer.infGameTime.v and os.time() - as.other.saveongame > 60 then
				try(setGameTime())

				as.other.saveongame = os.time()
			end

			if active and letsGame and sampGetGamestate() == 3 then
				var_0_0.Process = var_0_36.v or var_0_53.v or var_0_43.v or var_0_42.v or var_0_44.v or var_0_46.v or
				var_0_47.v or var_0_45.v or im.windows.share_settings.v or im.windows.mycard.v or im.windows.jrules.v or
				im.windows.markermanage.v or im.windows.hookchatinfo.v or im.windows.allkeys.v or im.windows.partner.v or
				im.windows.smslogs.v or im.windows.squad.v or im.windows.notepad.v or im.windows.speedometr.v

				if se.wanted.state and #as.other.renderWanted > 0 and not sampIsScoreboardOpen() and sampGetGamestate() == 3 and not as.fastmap.fastmap_state then
					if #as.other.renderWanted > se.wanted.lines then
						table.remove(as.other.renderWanted, 1)
					end

					local var_231_23 = se.wanted.y

					for iter_231_14, iter_231_15 in pairs(as.other.renderWanted) do
						if iter_231_14 <= se.wanted.lines then
							renderFontDrawText(wantedFont,
								(se.wanted.timestamp == true and os.date("[%H:%M:%S] ", iter_231_15[1]) or "") ..
								iter_231_15[2], se.wanted.x, var_231_23, 4294952961)

							var_231_23 = var_231_23 + se.wanted.interval
						end
					end
				end

				if as and as.threads then
					for iter_231_16, iter_231_17 in pairs(as.threads) do
						if os.time() - iter_231_17.started > 300 then
							iter_231_17.handle:terminate()

							as.threads[iter_231_16].handle = lua_thread.create(_G[iter_231_16])
							as.threads[iter_231_16].started = os.time()

							collectgarbage()
						end
					end
				end

				if im.settings.aircircle.v and isCharInAnyHeli(playerPed) then
					local var_231_24, var_231_25, var_231_26 = getCharCoordinates(playerPed)
					local var_231_27 = getGroundZFor3dCoord(var_231_24, var_231_25, var_231_26)

					if var_231_26 - var_231_27 >= 15 then
						local var_231_28 = var_231_24 + 1 * math.sin(-math.rad(getCharHeading(PLAYER_PED)))
						local var_231_29 = var_231_25 + 1 * math.cos(-math.rad(getCharHeading(PLAYER_PED)))

						drawCircleIn3d(var_231_28, var_231_29, var_231_27, 2, 4294901760, 4, 100)
					end
				end

				if isKeyJustPressed(VK_PAUSE) then
					as.other.pausebinder = not as.other.pausebinder

					am(as.other.pausebinder and
					"�� ��������� ������� ���� �� �����. ������� ����� ������� Pause, ����� �����������." or
					"�� ����������� ������� ����.")
				end

				if as.other.mdcinfo ~= nil and isKeyJustPressed(VK_Y) and not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive() and sampIsPlayerConnected(tonumber(as.other.mdcinfo.id)) and sampGetPlayerNickname(tonumber(as.other.mdcinfo.id)) == as.other.mdcinfo.name then
					as.other.mdcsend = true
					as.other.mdcdata = {}

					sampSendSystemChat("/mdc " .. as.other.mdcinfo.id)
				end

				if not as.other.stopbinder and isKeyJustPressed(VK_MENU) and not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive() then
					if as.other.stopclick >= 2 then
						as.other.stopbinder = true
						as.other.stopclick = 0
					else
						as.other.stopclick = as.other.stopclick + 1
					end
				end

				if as.chatlist and #as.chatlist > 0 then
					for iter_231_18, iter_231_19 in pairs(as.chatlist) do
						if ms > 1200 + sampGetPlayerPing(myID) then
							sampSendSystemChat(iter_231_19)

							as.chatlist[iter_231_18] = nil
							sendtime = os.clock() * 1000
							ms = os.clock() * 1000 - sendtime
						end
					end
				end

				if endTime > os.clock() then
					carSpawnTime = endTime - os.clock()

					if carSpawnTime <= 60 then
						spawnColor = "FFA500"
					end

					if carSpawnTime <= 30 then
						spawnColor = "FF0000"
					end
				end

				if _G.mass[mkey] and isKeyDown(VK_RBUTTON) and se.main.newsp and not as.fastmap.fastmap_state and getActiveInterior() == 0 and (getCurrentCharWeapon(playerPed) <= 15 or getCurrentCharWeapon(playerPed) == 46 or isCharInAnyCar(playerPed)) and not sampIsDialogActive() and not sampIsScoreboardOpen() and not isSampfuncsConsoleActive() and not sampIsChatInputActive() then
					renderDrawPolygon(var_0_100, var_0_101, 12, 12, 100, 0, 4294967295)

					as.crosshair.id, as.crosshair.handle, as.crosshair.car = GetClosestToSight(50)

					if as.crosshair.id and as.crosshair.handle and as.crosshair.car then
						if not as.other.speedCarPlayerHandle or as.other.speedCarPlayerHandle ~= as.crosshair.handle then
							as.other.speedCarPlayerHandle = as.crosshair.handle
							as.other.speedCarModel = getCarModel(storeCarCharIsInNoSave(as.crosshair.handle))
							as.other.speedCarKm = nil

							if doesCharExist(as.crosshair.handle) and isCharInAnyCar(as.crosshair.handle) then
								vspdAddByVeh(storeCarCharIsInNoSave(as.crosshair.handle))
							end
						end

						if not doesCharExist(as.crosshair.handle) or not isCharInAnyCar(as.crosshair.handle) then
							as.other.speedCarPlayerHandle = nil
							as.other.speedCarModel = nil
							as.other.speedCarKm = nil
						end

						local var_231_30 = storeCarCharIsInNoSave(as.crosshair.handle)

						if as and as.crosshair.car then
							renderFontDrawText(as.crosshair.font,
								as.crosshair.car ..
								" � " .. (var_231_30 ~= nil and as.other.speeds[var_231_30] .. " km/h" or ""),
								var_0_100 + 18, var_0_101, 4294967295)
						end
					end
				end

				if as.wanted.changepos then
					showCursor(true, true)

					se.wanted.x, se.wanted.y = getCursorPos()

					if isKeyDown(VK_RETURN) then
						se.wanted.x = math.floor(se.wanted.x)
						se.wanted.y = math.floor(se.wanted.y)
						as.wanted.changepos = false

						showCursor(false, false)
					end
				end

				if as.partner.changepos then
					showCursor(true, true)

					se.partner.x, se.partner.y = getCursorPos()

					if isKeyDown(VK_RETURN) then
						se.partner.x = math.floor(se.partner.x)
						se.partner.y = math.floor(se.partner.y)
						as.partner.changepos = false

						showCursor(false, false)
					end
				end

				if as.textdraw.squad_changepos then
					showCursor(true, true)

					se.squad.x, se.squad.y = getCursorPos()

					if isKeyDown(VK_RETURN) then
						se.squad.x = math.floor(se.squad.x)
						se.squad.y = math.floor(se.squad.y)
						as.textdraw.squad_changepos = false

						showCursor(false, false)
					end
				end

				if updateReportsTime ~= nil and os.time() - updateReportsTime > 30 then
					updateReportsTime = nil
				end

				if changeRatingTime ~= nil and os.time() - changeRatingTime > 15 then
					changeRatingTime = nil
				end

				if defusing_proccess then
					printStringNow("~y~DEFUSING THE BOMB", 1)
				end

				if aid_proccess then
					printStringNow("~y~FIRST AID PROVIDING..", 1)
				end

				if isCharInAnyCar(playerPed) or isCharInAnyHeli(playerPed) and not isCharInAnyBoat(playerPed) and not isCharInAnyPlane(playerPed) then
					-- block empty
				elseif cruise and cruiseVehicle ~= -1 and maxspeed ~= -1 and isCharOnFoot(playerPed) then
					if doesVehicleExist(cruiseVehicle) then
						vehicle = getCarModel(cruiseVehicle)
						vehicle = var_0_11.getint32(vehicle * 4 + 11120840, false)
						vehicle = var_0_11.getint16(vehicle + 74, false)

						var_0_11.setfloat(vehicle * 224 + 12761564 + 132, maxspeed / 100, false)
					end

					cruiseVehicle = -1
					maxspeed = -1
					cruise = false
					cruiseSpeed = 0
				end

				if tostring(myfrac) ~= "0" and not originalChangeRang then
					if myfrac == "4" then
						originalChangeRang = {
							[0] = u8("�������� ����"),
							u8("�������� ���� ������"),
							u8("������"),
							u8("��������"),
							u8("��.�����"),
							u8("����� DEA"),
							u8("����� CID"),
							u8("����� DEA"),
							u8("����� CID"),
							u8("���������"),
							u8("���.���������"),
							u8("��������")
						}
					else
						originalChangeRang = {
							[0] = u8("�������� ����"),
							u8("�������� ���� ������"),
							u8("�����"),
							u8("������"),
							u8("��.�������"),
							u8("�������"),
							u8("���������"),
							u8("��.���������"),
							u8("��.���������"),
							u8("���������"),
							u8("��.���������"),
							u8("�������"),
							u8("�����"),
							u8("������������"),
							u8("���������"),
							u8("�����")
						}
					end
				end

				if isCurrentCharWeapon(playerPed, 17) then
					sendGren = true
				else
					lua_thread.create(function()
						wait(100)

						sendGren = false
					end)
				end

				if isCharShooting(playerPed) and se.main.grenade and sendGren and tostring(myfrac) == "4" then
					lua_thread.create(function()
						if as.other.grenade == 0 then
							sampSendSystemChat(gsub(getEditByCode("grenades.gas", 1)))
							wait(500)
							sampSendSystemChat(gsub(getEditByCode("grenades.gas", 2)))
						else
							sampSendSystemChat(gsub(getEditByCode("grenades.flash", 1)))
							wait(500)
							sampSendSystemChat(gsub(getEditByCode("grenades.flash", 2)))
						end
					end)
				end

				if not sampIsChatInputActive() and not sampIsDialogActive() and not sampIsScoreboardOpen() and not isSampfuncsConsoleActive() and isKeyJustPressed(VK_T) then
					sampSetChatInputEnabled(true)
				end

				if isKeyJustPressed(var_0_6.name_to_id(se.keys.fastsms)) and SMS_ID and not sampIsDialogActive() and not sampIsChatInputActive() then
					sampSetChatInputEnabled(true)
					sampSetChatInputText("/sms " .. SMS_ID .. " ")
				end

				if isKeyJustPressed(var_0_6.name_to_id(se.keys.target_freeze)) and isGun(getCurrentCharWeapon(playerPed)) and not isCharInAnyCar(playerPed) then
					letstarget = not letstarget
				end

				if isKeyJustPressed(var_0_6.name_to_id(se.keys.update_ranks)) then
					as.other.showranks_start = true
				end

				if isKeyJustPressed(VK_RBUTTON) and letstarget then
					letstarget = false
				end

				if letstarget then
					writeMemory(12006500, 2, 128, true)
				end

				if not isCharInAnyCar(playerPed) and shwcrs then
					showCursor(false, false)

					shwcrs = false
				end

				if isCharInAnyCar(playerPed) and im.informer.infMainCruise.v and not isCharInAnyHeli(playerPed) and not isCharInAnyBoat(playerPed) and not isCharInAnyPlane(playerPed) and cruise then
					if maxspeed <= 0 then
						maxspeed = var_0_11.getfloat(GetVehicleHeader() * 224 + 12761564 + 132, false) * 100
					end

					if cruiseSpeed > maxspeed / 2 and _G.mass[mkey] then
						cruiseSpeed = maxspeed / 2
					end

					setGameKeyState(16, 255)
					var_0_11.setfloat(GetVehicleHeader() * 224 + 12761564 + 132, cruiseSpeed / 100 * 2, false)

					if isKeyJustPressed(VK_S) and not sampIsDialogActive() and not sampIsChatInputActive() then
						cruise = false
						cruiseSpeed = 0

						if doesVehicleExist(cruiseVehicle) then
							vehicle = getCarModel(cruiseVehicle)
							vehicle = var_0_11.getint32(vehicle * 4 + 11120840, false)
							vehicle = var_0_11.getint16(vehicle + 74, false)

							var_0_11.setfloat(vehicle * 224 + 12761564 + 132, maxspeed / 100, false)
						end

						maxspeed = -1
						cruiseVehicle = -1
					end
				end

				if isCharInAnyHeli(playerPed) and as.autopilot.state == true then
					if as.autopilot.height > 1 then
						local var_231_31, var_231_32, var_231_33 = getCharCoordinates(playerPed)
						local var_231_34 = getGroundZFor3dCoord(var_231_31, var_231_32, var_231_33)
						local var_231_35 = math.floor(var_231_33 - (var_231_34 and var_231_34 or 0))

						if var_231_33 < as.autopilot.height then
							setGameKeyState(16, 255)
						end
					end

					if isKeyJustPressed(VK_S) and not sampIsDialogActive() and not sampIsChatInputActive() then
						as.autopilot.state = false
					end
				end

				if (isKeyJustPressed(VK_S) or isKeyJustPressed(VK_W) or isKeyJustPressed(VK_A) or isKeyJustPressed(VK_D)) and as.autopilot.impact == true and not sampIsDialogActive() and not sampIsChatInputActive() then
					as.autopilot.impact = false

					_G.freezeCarPosition(storeCarCharIsInNoSave(playerPed), false)
				end

				if as.autopilot.impact and not isCharInAnyHeli(playerPed) then
					as.autopilot.impact = false

					_G.freezeCarPosition(as.autopilot.impact_vehicle, false)
				end

				if as.autopilot.impact and isCharInAnyHeli(playerPed) and not isCarEngineOn(storeCarCharIsInNoSave(playerPed)) then
					as.autopilot.impact = false

					_G.freezeCarPosition(as.autopilot.impact_vehicle, false)
				end

				if suspect_veh ~= nil and suspect_num ~= nil and suspect_id ~= nil and depnotifi then
					if tostring(myfrac) == "1" then
						if getCity() ~= "San Fierro" then
							chat(
							"�� ��������� ������� ����� ����������. ������� {00FF00}/depjur{FFFFFF}, ����� �������� �� ����� ������������.")

							depnotifi = false
						end
					elseif tostring(myfrac) == "2" then
						if getCity() ~= "Las Venturas" then
							chat(
							"�� ��������� ������� ����� ����������. ������� {00FF00}/depjur{FFFFFF}, ����� �������� �� ����� ������������.")

							depnotifi = false
						end
					elseif tostring(myfrac) == "3" and getCity() ~= "Los Santos" then
						chat(
						"�� ��������� ������� ����� ����������. ������� {00FF00}/depjur{FFFFFF}, ����� �������� �� ����� ������������.")

						depnotifi = false
					end
				end

				local var_231_36, var_231_37

				reset_result, reset_button, var_231_36, var_231_37 = sampHasDialogRespond(4827)

				local var_231_38

				oop_result, oop_button, oops_list, var_231_38 = sampHasDialogRespond(3481)

				if oop_result and oop_button == 1 then
					if oops_list == 0 then
						as.oop.type = 0

						sampShowDialog(3482, "{FFFFFF}������� ID ��������", "", "���������", "������", 1)
					end

					if oops_list ~= nil and oops_list ~= 0 then
						local var_231_39 = oop_list[oops_list]:match(".*%\t.*%\t(.*)%\t")

						as.oop.type, as.oop.criminal = 1, var_231_39

						sampShowDialog(3482, "{FFFFFF}������� ID ��������", "", "���������", "������", 1)
					end
				end

				oopsend_result, oopsend_button, oopsend_list, oopsend_input = sampHasDialogRespond(3482)

				if oopsend_result and oopsend_button == 1 then
					if tostring(oopsend_input):len() > 0 then
						if as.oop.type == 0 then
							local var_231_40 = tostring(oopsend_input):match("(%d+)")

							if sampIsPlayerConnected(var_231_40) then
								local var_231_41 = {}

								for iter_231_20, iter_231_21 in pairs(oop_list) do
									local var_231_42 = iter_231_21:match(".*%\t.*%\t(.*)%\t")

									if var_231_42 then
										table.insert(var_231_41, var_231_42)
									end
								end

								if var_231_41 then
									sampSendChat("/t " .. var_231_40 .. " ���: " .. table.concat(var_231_41, ", "))

									as.oop.criminal = ""
								else
									chat("��� �� �������.")
								end
							else
								chat("��������� ����� ����������.")
							end
						elseif as.oop.type == 1 and as.oop.criminal ~= "" then
							local var_231_43 = tostring(oopsend_input):match("(%d+)")

							if sampIsPlayerConnected(var_231_43) then
								sampSendChat("/t " .. var_231_43 .. " ���: " .. as.oop.criminal)
							else
								chat("��������� ����� ����������.")
							end
						end
					else
						chat("�� �� ����� ������.")
					end
				end

				if reset_result and reset_button == 1 then
					local var_231_44 = {
						data = "s=" ..
						select(1, sampGetCurrentServerAddress()) ..
						":" ..
						select(2, sampGetCurrentServerAddress()) ..
						"&n=" .. sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))),
						headers = {
							["content-type"] = "application/x-www-form-urlencoded"
						}
					}

					sequent_async_http_request("POST", "https://pdp-samp.online/script/PDProject/settings-reset",
						var_231_44, function(arg_312_0)
						if arg_312_0.text:find("successfull") then
							am("��������� ��������.")
							thisScript():reload()
						else
							am("��������� ������, ���������� �����.")
						end
					end, function(arg_313_0)
						print(arg_313_0)
					end)
				end

				resDial_188, button_188, list_188, input_188 = sampHasDialogRespond(188)
				resHouse, buttonHouse, listHouse, inputHouse = sampHasDialogRespond(9651)

				if resHouse and buttonHouse == 1 and listHouse then
					local var_231_45 = sdate.robhouse[listHouse + 1][2]

					chat("������ ��� �" .. var_231_45 .. ". �� ����� �������� ��������������� ����.")
					sampSendChat("/gpshouse " .. var_231_45)
					wait(1500)

					if getMyPartner() ~= "-" and getMyPartner() ~= "" then
						sampSendChat("/r �������� �� ������������ � ���� �" ..
						var_231_45 .. ", ��������: " .. getMyPartner() .. ".")
					else
						sampSendChat("/r �������� �� ������������ � ���� �" .. var_231_45 .. ".")
					end
				end

				if resDial_188 and button_188 == 1 and list_188 ~= nil and list ~= 0 and list_188 ~= 33 then
					if im.settings.suNumber.v then
						_G.sampAddChatMessage(
						"| {FFFFFF}�� ������ � ������ {7B68EE}" ..
						ssqNick ..
						"{FFFFFF} �� ������� {7B68EE}" ..
						sud.a[tonumber(list_188)] .. " \"" .. sud.b[tonumber(list_188)] .. "\"{FFFFFF}.", clr)
						sampSendSystemChat("/su " ..
						ssid ..
						" " ..
						sud.c[tonumber(list_188)] ..
						" " .. sud.a[tonumber(list_188)] .. " \"" .. sud.b[tonumber(list_188)] .. "\"")

						ssqNick, ssid = nil
					else
						_G.sampAddChatMessage(
						"| {FFFFFF}�� ������ � ������ {7B68EE}" ..
						ssqNick ..
						"{FFFFFF} �� ������� {7B68EE}" ..
						sud.a[tonumber(list_188)] .. " \"" .. sud.b[tonumber(list_188)] .. "\"{FFFFFF}.", clr)
						sampSendSystemChat("/su " ..
						ssid .. " " .. sud.c[tonumber(list_188)] .. " " .. sud.b[tonumber(list_188)] .. "")

						ssqNick, ssid = nil
					end
				end

				if resDial_188 and button_188 == 0 then
					ssid = nil
				end

				local var_231_46, var_231_47, var_231_48, var_231_49 = sampHasDialogRespond(101)

				if var_231_46 and suspect_veh ~= nil and suspect_num ~= nil and suspect_id ~= nil and _G.mass[mkey] then
					if var_231_48 == 0 and var_231_47 == 1 and _G.mass[mkey] then
						_G.sampAddChatMessage(
						"| {FFFFFF}�� ���������� ������������� - " ..
						c_suspect_veh .. " [" .. c_suspect_num .. "] ID [" .. c_suspect_id .. "]", clr)

						suspect_veh, suspect_veh_handle = nil
						suspect_num = nil
						suspect_id = nil
						suspect_name = nil
						suspect_health = nil
						trstop = false

						remu()
					elseif var_231_48 == 1 and _G.mass[mkey] then
						sampSendChat("/r " ..
						u8:decode(se.main.tag) ..
						" " ..
						(tencodes.nok ~= "" and tencodes.nok or "�����") ..
						" �� " ..
						(tencodes.pursuit ~= "" and tencodes.pursuit or "�������������") ..
						" " .. c_suspect_veh .. " [" .. c_suspect_num .. "], ������������ �������.")

						suspect_veh, suspect_veh_handle = nil
						suspect_num = nil
						suspect_id = nil
						suspect_name = nil
						suspect_health = nil

						remu()
					elseif var_231_48 == 2 then
						sampSendChat("/r " ..
						u8:decode(se.main.tag) ..
						" " ..
						(tencodes.codefour ~= "" and tencodes.codefour or "�������� �������������") ..
						" �� " ..
						(tencodes.pursuit ~= "" and tencodes.pursuit or "�������������") ..
						", �������� " .. c_suspect_veh .. " - " .. c_suspect_name .. " ��������.")

						suspect_veh, suspect_veh_handle = nil
						suspect_num = nil
						suspect_id = nil
						suspect_name = nil
						suspect_health = nil

						remu()
					elseif var_231_48 == 3 then
						sampSendChat("/r " ..
						u8:decode(se.main.tag) ..
						" " ..
						(tencodes.codefour ~= "" and tencodes.codefour or "�������� �������������") ..
						" �� " ..
						(tencodes.traffic_stop ~= "" and tencodes.traffic_stop or "������-�����") ..
						", �������� " .. c_suspect_veh .. " - " .. c_suspect_name .. " ��������.")

						suspect_veh, suspect_veh_handle = nil
						suspect_num = nil
						suspect_id = nil
						suspect_name = nil
						suspect_health = nil
						trstop = false

						remu()
					elseif var_231_48 == 4 then
						if myfrac ~= "4" then
							sampSendChat("/r " ..
							u8:decode(se.main.tag) ..
							" " ..
							(tencodes.codefour ~= "" and tencodes.codefour or "�������� �������������") ..
							" �� " ..
							(tencodes.traffic_stop ~= "" and tencodes.traffic_stop or "������-�����") ..
							", �������� " .. c_suspect_veh .. " - " .. c_suspect_name .. " ������� �����.")
						else
							am("��� �� ������ ���������� ������, ���.")
						end

						suspect_veh, suspect_veh_handle = nil
						suspect_num = nil
						suspect_id = nil
						suspect_health = nil
						trstop = false

						remu()
					elseif var_231_48 == 5 then
						sampSendChat("/r " ..
						u8:decode(se.main.tag) ..
						" " ..
						(tencodes.codefour ~= "" and tencodes.codefour or "�������� �������������") ..
						" �� " ..
						(tencodes.traffic_stop ~= "" and tencodes.traffic_stop or "������-�����") ..
						", �������� " .. c_suspect_veh .. " - " .. c_suspect_name .. " �������� ��������������.")

						suspect_veh, suspect_veh_handle = nil
						suspect_num = nil
						suspect_id = nil
						suspect_health = nil
						trstop = false

						remu()
					end
				end

				if im.informer.infMainSiren.v then
					if isCharInAnyCar(playerPed) then
						plcar = storeCarCharIsInNoSave(playerPed)

						if plcar then
							siren_status = isCarSirenOn(plcar)
						end
					else
						siren_status = false
					end
				else
					siren_status = false
				end

				local var_231_50, var_231_51, var_231_52, var_231_53 = sampHasDialogRespond(202)

				if var_231_50 and patrol ~= nil and var_231_51 == 1 and _G.mass[mkey] and var_231_52 then
					pol_id, pol_sec = patrol[var_231_52 + 1][2]:match("%u%a+%_%u%a+%[(%d+)%].*(%S%-%d+)")

					if sampIsPlayerConnected(pol_id) then
						if pol_sec then
							if as.other.pol_sec[pol_sec] ~= nil then
								pol_sec = as.other.pol_sec[pol_sec]
							end

							pt_sec = pol_sec
							pt_id = pol_id

							setWaypoint(pol_sec)

							pol_act = true

							_G.sampAddChatMessage(
							"| {FFFFFF}�� ������������ � ������ ������� " ..
							sampGetPlayerNickname(pol_id) .. "[" .. pol_id .. "].", clr)
						end
					else
						_G.sampAddChatMessage("| {FFFFFF}�������� ������. ID �� �������.", clr)

						pol_act = false
					end
				end

				if active and im.informer.infMainOopFunc.v and #wanted > 0 then
					lua_thread.create(function()
						for iter_314_0 = 0, 1000 do
							wait(0)

							if sampIsPlayerConnected(iter_314_0) and wantedLevel[iter_314_0] then
								local var_314_0, var_314_1 = sampGetCharHandleBySampPlayerId(iter_314_0)

								if var_314_0 and doesCharExist(var_314_1) and not wanted_info[iter_314_0] then
									chat("� ���� ��������� �������� " ..
									sampGetPlayerNickname(iter_314_0) ..
									"[" .. iter_314_0 .. "] � " .. tostring(wantedLevel[iter_314_0]) .. " ��.�.")

									wanted_info[iter_314_0] = iter_314_0

									if im.informer.infMainShowBlip.v then
										wanted_blip = addBlipForChar(var_314_1)

										changeBlipColour(wanted_blip, 4278190335)
										setBlipAlwaysDisplayOnZoomedRadar(wanted_blip, -1)

										blip_want[#blip_want + 1] = wanted_blip
									end
								end
							end
						end
					end)
				end

				timefix = 3
				unix_time = os.time(os.date("!*t"))
				moscow_time = unix_time + timefix * 60 * 60

				local var_231_54, var_231_55, var_231_56, var_231_57 = sampHasDialogRespond(1488)

				if var_231_54 and VTable ~= nil and var_231_55 == 1 and var_231_56 and _G.mass[mkey] then
					local var_231_58, var_231_59, var_231_60 = VTable[var_231_56 + 1]:match(
					"%[(.*)%].*%[(.*)%].*%[%{.*%}(.*)%{.*%}%]")

					_G.sampAddChatMessage(
					"| {FFFFFF}�� ������ ������������� " .. var_231_58 .. " [" .. var_231_59 .. "].", clr)

					if im.informer.infMainShowPursuit.v then
						lua_thread.create(function()
							wait(p(300))
							sampSendChat("/patrul " .. var_231_60)
						end)
					end

					oralo_st = 0
					suspect_veh = var_231_58
					suspect_num = var_231_59
					suspect_id = var_231_60
					suspect_name = sampGetPlayerNickname(var_231_60)

					vspdAddByChar(select(2, sampGetCharHandleBySampPlayerId(var_231_60)))

					depnotifi = true

					local var_231_61, var_231_62 = sampGetCharHandleBySampPlayerId(var_231_60)

					if var_231_61 then
						local var_231_63 = storeCarCharIsInNoSave(var_231_62)

						suspect_veh_handle = var_231_63

						if isCharInAnyHeli(var_231_62) then
							heli = true
						else
							heli = false
						end

						if getCarModel(var_231_63) == 461 or getCarModel(var_231_63) == 462 or getCarModel(var_231_63) == 463 or getCarModel(var_231_63) == 468 or getCarModel(var_231_63) == 471 or getCarModel(var_231_63) == 521 or getCarModel(var_231_63) == 522 or getCarModel(var_231_63) == 581 or getCarModel(var_231_63) == 586 or getCarModel(var_231_63) == 523 then
							moto = true
						else
							moto = false
						end
					end
				end

				local var_231_64, var_231_65, var_231_66, var_231_67 = sampHasDialogRespond(11)

				if var_231_64 and #var_231_67 ~= 0 and var_0_6.name_to_id(var_231_67) ~= nil then
					_G.sampAddChatMessage(
					"| {FFFFFF}�� ���������� ����� ������� - " .. var_0_6.name_to_id(var_231_67) .. ".", clr)
				end

				if isKeyJustPressed(VK_G) and _G.mass[mkey] then
					gunstat = true
				end

				if im.informer.infMainAutoSu.v and keySu and _G.mass[mkey] and sampIsPlayerConnected(keySu) then
					renderFontDrawText(var_0_29,
						"�� ��� �������� {" ..
						string.format("%06X", ARGBtoRGB(sampGetPlayerColor(keySu))) ..
						"}" ..
						sampGetPlayerNickname(keySu) ..
						" [" .. keySu .. "]{FFFFFF}\n'F9' - ����� ������ � ������.\n'F12' - ����� �������� ����.",
						var_0_94 * 0.02, var_0_95 / 2.5, 4294967295)
				end

				if reaver and rID and rName then
					renderFontDrawText(var_0_32,
						"����� �������\n��������: " ..
						(reaver_micro == true and "{00FF00}���{FFFFFF}" or "{FF0000}����{FFFFFF}") .. " [������]",
						var_0_94 * 0.02, var_0_95 / 2.5, 4294967295)
				end

				if reaver and isKeyJustPressed(VK_SPACE) and not sampIsDialogActive() and not sampIsChatInputActive() then
					reaver_micro = not reaver_micro
				end

				if isCharShooting(playerPed) and getCurrentCharWeapon(playerPed) == 24 and tazer_state == "ON" and im.sounds.taser.v then
					local var_231_68 = var_0_9.BASS_StreamCreateFile(false,
						"moonloader/PD-Project/resource/m/taserx26.mp3", 0, 0, 0)

					var_0_9.BASS_ChannelSetAttribute(var_231_68, BASS_ATTRIB_VOL, im.sounds.volume.v)
					var_0_9.BASS_ChannelPlay(var_231_68, false)
				end

				if im.informer.infMainAutoSu.v and keySu and _G.mass[mkey] and isKeyJustPressed(VK_F9) and not sampIsDialogActive() and not sampIsChatInputActive() then
					if autosu1.v and autosu1.v ~= "" and autosu2.v and autosu2.v ~= "" and autosu3.v and autosu3.v ~= "" then
						if im.settings.suNumber.v then
							sampSendSystemChat("/su " ..
							keySu ..
							" " ..
							u8:decode(autosu3.v) .. " " .. u8:decode(autosu1.v) .. " \"" .. u8:decode(autosu2.v) .. "\"")
						else
							sampSendSystemChat("/su " ..
							keySu .. " " .. u8:decode(autosu3.v) .. " " .. u8:decode(autosu2.v) .. "")
						end
					else
						chat("�� �� ���������� ������ �� ���������. ���������� � ���������� ������� ������ �������.")
					end
				end

				if im.informer.infMainAutoSu.v and keySu and _G.mass[mkey] and isKeyJustPressed(VK_F12) and not sampIsDialogActive() and not sampIsChatInputActive() then
					keySu = nil
				end

				if isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.setclist))) and not sampIsDialogActive() and not sampIsChatInputActive() and _G.mass[mkey] then
					sampSendChat("/clist " .. se.main.clist)
					wait(p(1000))

					if tostring(myfrac) == "4" then
						local var_231_69 = getEditByCode("other.fbi_badge", 1)
						local var_231_70 = gsub(var_231_69)

						sampSendSystemChat(var_231_70)
					else
						local var_231_71 = getEditByCode("other.cop_badge", 1)
						local var_231_72 = gsub(var_231_71)

						sampSendSystemChat(var_231_72)
					end
				end

				if isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.fastsiren))) and not sampIsDialogActive() and not sampIsChatInputActive() and isCharInCarDriver(playerPed) and isPlayerInCopCar(playerPed) then
					if isCarSirenOn(storeCarCharIsInNoSave(playerPed)) then
						switchCarSiren(storeCarCharIsInNoSave(playerPed), false)
					else
						switchCarSiren(storeCarCharIsInNoSave(playerPed), true)
					end
				end

				if isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.pursuit_fast))) and not sampIsDialogActive() and not sampIsChatInputActive() and CL_SUSPECT_HANDLE and CL_CAR_ID and CL_CAR_NUM and CL_CAR_HANDLE and CL_CAR_VEHICLE and CL_CAR_NAME and _G.mass[mkey] then
					if doesVehicleExist(CL_CAR_HANDLE) then
						_G.sampAddChatMessage(
						"| {FFFFFF}�� ������ ������������� " .. CL_CAR_VEHICLE .. " [" .. CL_CAR_NUM .. "].", clr)

						oralo_st = 0
						suspect_veh, suspect_num, suspect_id, suspect_name, suspect_handle = CL_CAR_VEHICLE, CL_CAR_NUM,
							CL_CAR_ID, CL_CAR_NAME, CL_SUSPECT_HANDLE

						vspdAddByChar(suspect_handle)

						depnotifi = true

						local var_231_73, var_231_74 = sampGetCharHandleBySampPlayerId(suspect_id)

						if var_231_73 then
							local var_231_75 = storeCarCharIsInNoSave(var_231_74)

							if isCharInAnyHeli(var_231_74) then
								heli = true
							else
								heli = false
							end

							if isCharInAnyMoto(var_231_74) then
								moto = true
							else
								moto = false
							end
						end

						if im.informer.infMainShowPursuit.v then
							lua_thread.create(function()
								wait(p(300))
								sampSendChat("/patrul " .. suspect_id)
							end)
						end
					else
						chat("��������� ����� ����������.")
					end
				end

				if isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.pursuit_fast_stop))) and suspect_veh ~= nil and suspect_num ~= nil and suspect_id ~= nil and not sampIsDialogActive() and not sampIsChatInputActive() and _G.mass[mkey] then
					_G.sampAddChatMessage(
					"| {FFFFFF}�� ���������� ������������� - " ..
					suspect_veh .. " [" .. suspect_num .. "] ID [" .. suspect_id .. "]", clr)

					suspect_veh, suspect_veh_handle = nil
					suspect_num = nil
					suspect_id = nil
					suspect_name = nil
					suspect_health = nil
					trstop = false

					remu()
				end

				if isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.pursuit_oralo))) and isCharInAnyCar(playerPed) and suspect_veh ~= nil and suspect_num ~= nil and suspect_id ~= nil and not sampIsDialogActive() and not sampIsChatInputActive() and _G.mass[mkey] then
					local var_231_76 = "/m"
					local var_231_77 = isPlayerInCopCar(playerPed) and "/m" or "/s"

					if oralo_st >= 3 then
						if heli then
							local var_231_78 = getEditByCode("megaphone.air", 3):gsub("{vehicle}", suspect_veh):gsub(
							"{vehicle_num}", suspect_num):gsub("%/m", var_231_77)

							sampSendSystemChat(var_231_78)

							oralo_st = 0

							sendOraloDistance()
						else
							local var_231_79 = getEditByCode("megaphone.auto", 3):gsub("{vehicle}", suspect_veh):gsub(
							"{vehicle_num}", suspect_num):gsub("%/m", var_231_77)

							sampSendSystemChat(var_231_79)

							oralo_st = 0

							sendOraloDistance()
						end
					elseif heli then
						oralo_st = oralo_st + 1

						local var_231_80 = getEditByCode("megaphone.air", 1):gsub("{vehicle}", suspect_veh):gsub(
						"{vehicle_num}", suspect_num):gsub("%/m", var_231_77)

						sampSendSystemChat(var_231_80)
						sendOraloDistance()
					else
						oralo_st = oralo_st + 1

						local var_231_81 = getEditByCode("megaphone.auto", 1):gsub("{vehicle}", suspect_veh):gsub(
						"{vehicle_num}", suspect_num):gsub("%/m", var_231_77)

						sampSendSystemChat(var_231_81)
						sendOraloDistance()
					end
				end

				if isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.pursuit_koord))) and suspect_veh ~= nil and suspect_num ~= nil and suspect_id ~= nil and not sampIsDialogActive() and not sampIsChatInputActive() and _G.mass[mkey] then
					local var_231_82, var_231_83 = sampGetCharHandleBySampPlayerId(suspect_id)

					if doesCharExist(var_231_83) then
						local var_231_84, var_231_85, var_231_86 = getCharCoordinates(var_231_83)

						sampSendChat("/r " ..
						u8:decode(se.main.tag) ..
						" " ..
						(tencodes.pursuit ~= "" and tencodes.pursuit or "���������") ..
						" " ..
						suspect_veh ..
						" [" ..
						suspect_num ..
						"] �� " ..
						calcZ(var_231_84, var_231_85, var_231_86) ..
						", " .. kvadUli(var_231_83) .. " �� " .. direction(var_231_83) .. ".")
					else
						local var_231_87, var_231_88, var_231_89 = getCharCoordinates(playerPed)

						sampSendChat("/r " ..
						u8:decode(se.main.tag) ..
						" " ..
						(tencodes.pursuit ~= "" and tencodes.pursuit or "���������") ..
						" " ..
						suspect_veh ..
						" [" ..
						suspect_num ..
						"] �� " ..
						calcZ(var_231_87, var_231_88, var_231_89) ..
						", " .. kvadUli(playerPed) .. " �� " .. direction(playerPed) .. ".")
					end
				end

				if isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.pursuit_oralo2))) and isCharInAnyCar(playerPed) and suspect_veh ~= nil and suspect_num ~= nil and suspect_id ~= nil and not sampIsDialogActive() and not sampIsChatInputActive() and _G.mass[mkey] then
					local var_231_90 = "/m"
					local var_231_91 = isPlayerInCopCar(playerPed) and "/m" or "/s"

					if heli then
						local var_231_92 = getEditByCode("megaphone.air", 2):gsub("{vehicle}", suspect_veh):gsub(
						"{vehicle_num}", suspect_num):gsub("%/m", var_231_91)

						awaitSendChat(var_231_92, 1, 1)
						sendOraloDistance()

						local var_231_93 = getEditByCode("megaphone.attention", 1):gsub("%/m", var_231_91):gsub(
						"{member_type}", tostring(myfrac) == "4" and "������" or "�������")

						awaitSendChat(var_231_93, 1, 1500)
					elseif moto then
						local var_231_94 = getEditByCode("megaphone.moto", 1):gsub("{vehicle}", suspect_veh):gsub(
						"{vehicle_num}", suspect_num):gsub("%/m", var_231_91)

						awaitSendChat(var_231_94, 1, 1)
						sendOraloDistance()

						local var_231_95 = getEditByCode("megaphone.attention", 1):gsub("%/m", var_231_91):gsub(
						"{member_type}", tostring(myfrac) == "4" and "������" or "�������")

						awaitSendChat(var_231_95, 1, 1500)
					else
						local var_231_96 = getEditByCode("megaphone.auto", 2):gsub("{vehicle}", suspect_veh):gsub(
						"{vehicle_num}", suspect_num):gsub("%/m", var_231_91)

						awaitSendChat(var_231_96, 1, 1)

						local var_231_97 = getEditByCode("megaphone.attention", 1):gsub("%/m", var_231_91):gsub(
						"{member_type}", tostring(myfrac) == "4" and "������" or "�������")

						awaitSendChat(var_231_97, 1, 1500)
						sendOraloDistance()
					end
				end

				if isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.pursuit_55))) and not sampIsDialogActive() and not sampIsChatInputActive() and suspect_veh ~= nil and suspect_num ~= nil and suspect_id ~= nil and _G.mass[mkey] then
					sampSendChat("/r " ..
					u8:decode(se.main.tag) ..
					" " ..
					(tencodes.traffic_stop ~= "" and tencodes.traffic_stop or "������� ������-����") ..
					" " .. suspect_veh .. " [" .. suspect_num .. "] � " .. kvadUli(playerPed) .. ".")
				end

				if isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.pursuit_66))) and not sampIsDialogActive() and not sampIsChatInputActive() and suspect_veh ~= nil and suspect_num ~= nil and suspect_id ~= nil and _G.mass[mkey] then
					sampSendChat("/r " ..
					u8:decode(se.main.tag) ..
					" " ..
					(tencodes.traffic_stop_66 ~= "" and tencodes.traffic_stop_66 or "������� ������-���� ����������� �����") ..
					" " .. suspect_veh .. " [" .. suspect_num .. "] � " .. kvadUli(playerPed) .. ".")
				end

				if isKeyJustPressed(var_0_6.name_to_id(se.keys.pursuit_mdc)) and not sampIsDialogActive() and not sampIsChatInputActive() and suspect_veh ~= nil and suspect_num ~= nil and suspect_id ~= nil and _G.mass[mkey] then
					sampSendChat("/mdc " .. suspect_id)
				end

				if isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.pursuit_stop))) and not sampIsDialogActive() and not sampIsChatInputActive() and suspect_veh ~= nil and suspect_num ~= nil and suspect_id ~= nil and _G.mass[mkey] then
					c_suspect_veh = suspect_veh
					c_suspect_num = suspect_num
					c_suspect_id = suspect_id
					c_result, c_handle = sampGetCharHandleBySampPlayerId(c_suspect_id)
					c_suspect_name = suspect_name:gsub("_", " ")

					if c_suspect_name ~= nil and _G.mass[mkey] then
						if myfrac ~= "" and myfrac then
							sampShowDialog(101, "�������� �������� ��������� ������",
								"[0] ���������� ������������� ��� �������\n[1] " ..
								(tencodes.nok ~= "" and tencodes.nok or "�����") ..
								" �� " ..
								(tencodes.pursuit ~= "" and tencodes.pursuit or "�������������") ..
								", " ..
								c_suspect_veh ..
								" [" ..
								c_suspect_num ..
								"] �������.\n[2] " ..
								(tencodes.codefour ~= "" and tencodes.codefour or "�������� �������������") ..
								" �� " ..
								(tencodes.pursuit ~= "" and tencodes.pursuit or "�������������") ..
								", �������� " ..
								c_suspect_veh ..
								" - " ..
								c_suspect_name ..
								" ��������.\n[3] " ..
								(tencodes.codefour ~= "" and tencodes.codefour or "�������� �������������") ..
								" �� " ..
								(tencodes.traffic_stop ~= "" and tencodes.traffic_stop or "������-�����") ..
								", �������� " ..
								c_suspect_veh ..
								" - " ..
								c_suspect_name ..
								" ��������.\n[4] " ..
								(tencodes.codefour ~= "" and tencodes.codefour or "�������� �������������") ..
								" �� " ..
								(tencodes.traffic_stop ~= "" and tencodes.traffic_stop or "������-�����") ..
								", �������� " ..
								c_suspect_veh ..
								" - " ..
								c_suspect_name ..
								" ������� �����.\n[5] " ..
								(tencodes.codefour ~= "" and tencodes.codefour or "�������� �������������") ..
								" �� " ..
								(tencodes.traffic_stop ~= "" and tencodes.traffic_stop or "������-�����") ..
								", �������� " .. c_suspect_veh .. " - " .. c_suspect_name .. " �������� ��������������.",
								"Ok", "Cancel", 2)
						end
					else
						_G.sampAddChatMessage(
						"| {FFFFFF}������������ ���������� ������ �� �������� (off/������ �� ���).", clr)
					end
				end

				if sampIsChatInputActive() and im.informer.infMainChatTools.v and _G.mass[mkey] then
					ptr1 = sampGetInputInfoPtr()
					ptr1 = getStructElement(ptr1, 8, 4)
					ptr2 = getStructElement(ptr1, 8, 4)
					ptr3 = getStructElement(ptr1, 12, 4)
					shs = tonumber(ptr3) + 45
					sws = tonumber(ptr2) + 5

					local var_231_98 = "{" .. string.format("%06X", ARGBtoRGB(sampGetPlayerColor(myID))) .. "}"
					local var_231_99 = sampGetPlayerScore(myID)
					local var_231_100 = sampGetPlayerPing(myID)
					local var_231_101 = sampGetChatInputText():len()

					capsState = var_0_10.C.GetKeyState(20)
					numState = var_0_10.C.GetKeyState(144)
					success = var_0_10.C.GetKeyboardLayoutNameA(var_0_87)
					errorCode = var_0_10.C.GetLocaleInfoA(tonumber(var_0_10.string(var_0_87), 16), 2, var_0_88, var_0_86)
					localName = var_0_10.string(var_0_88)

					renderFontDrawText(var_0_28,
						(var_231_101 > 120 and "{FF0000}" .. tostring(var_231_101) .. "{FFFFFF}" or tostring(var_231_101)) ..
						" | " ..
						tostring(var_231_98) ..
						tostring(myName) ..
						" [" ..
						tostring(myID) ..
						"] {FFFFFF}| LVL: " ..
						getLvl(var_231_99) ..
						" | Ping: " ..
						getPing(var_231_100) ..
						" | Caps: " ..
						getCaps(capsState) ..
						" | Num: " ..
						getNum(numState) ..
						" | FPS: " ..
						getFpsStr(fps) ..
						" | ���������: " ..
						(localName:gsub("%(.*%)", ""):find("�������") and localName:gsub("%(.*%)", "") .. "{FF0000}�" or localName:gsub("%(.*%)", "") .. "{FFFF00}�"),
						tonumber(sws), tonumber(shs), 4294967295)
				end

				if isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.pursuit_ps))) and not sampIsDialogActive() and not sampIsChatInputActive() and suspect_veh ~= nil and suspect_num ~= nil and suspect_id ~= nil and _G.mass[mkey] then
					sampSendChat("/ps " .. suspect_id)
				end

				if isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.pursuit_patrul))) and not sampIsDialogActive() and not sampIsChatInputActive() and suspect_veh ~= nil and suspect_num ~= nil and suspect_id ~= nil and _G.mass[mkey] then
					sampSendChat("/patrul " .. suspect_id)
				end

				if isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.pursuit_su))) and not sampIsDialogActive() and not sampIsChatInputActive() and suspect_veh ~= nil and suspect_num ~= nil and suspect_id ~= nil and _G.mass[mkey] then
					if autopursuit1.v and autopursuit1.v ~= "" and autopursuit2.v and autopursuit2.v ~= "" and autopursuit3.v and autopursuit3.v ~= "" then
						if im.settings.suNumber.v then
							sampSendSystemChat("/su " ..
							suspect_id ..
							" " ..
							u8:decode(autopursuit3.v) ..
							" " .. u8:decode(autopursuit1.v) .. " \"" .. u8:decode(autopursuit2.v) .. "\"")
						else
							sampSendSystemChat("/su " ..
							suspect_id .. " " .. u8:decode(autopursuit3.v) .. " " .. u8:decode(autopursuit2.v) .. "")
						end
					else
						chat("�� �� ���������� ������ �� ����. ���������� � ���������� ������� ������ �������.")
					end
				end

				if im.settings.wdis.v then
					local var_231_102, var_231_103 = getCharPlayerIsTargeting(playerHandle)

					if var_231_102 and var_231_103 then
						local var_231_104 = getCurrentCharWeapon(playerPed)

						if var_0_35[var_231_104] then
							local var_231_105 = "{FFFFFF}"
							local var_231_106 = var_0_35[getCurrentCharWeapon(playerPed)]
							local var_231_107, var_231_108, var_231_109 = getCharCoordinates(var_231_103)
							local var_231_110, var_231_111, var_231_112 = getCharCoordinates(playerPed)
							local var_231_113 = math.sqrt((var_231_107 - var_231_110) ^ 2 + (var_231_108 - var_231_111) ^
							2 + (var_231_109 - var_231_112) ^ 2)
							local var_231_114 = math.floor(tonumber(var_231_113))
							local var_231_115 = isLineOfSightClear(var_231_107, var_231_108, var_231_109, var_231_110,
								var_231_111, var_231_112 + 0.5, true, true, false, true, false)

							if var_231_104 == 24 and tazer_state == "ON" then
								var_231_106 = 9
							end

							if var_231_115 then
								local var_231_116 = ""
								local var_231_117

								if var_231_114 <= var_231_106 then
									var_231_105 = "{008000}"
									var_231_117 = "�������!"
								else
									var_231_105 = "{FF0000}"
									var_231_117 = "�����!"
								end

								if se.main.wdis_distance == false then
									renderFontDrawText(var_0_31,
										var_231_105 .. var_231_117 .. (tazer_state == "ON" and " TAZER!" or ""),
										var_0_94 / 1.9, var_0_95 / 2.1, 4294967295)
								else
									renderFontDrawText(var_0_31,
										var_231_105 ..
										var_231_114 .. "/" .. var_231_106 .. (tazer_state == "ON" and " TAZER!" or ""),
										var_0_94 / 1.9, var_0_95 / 2.1, 4294967295)
								end
							end
						end
					elseif _G.mass[mkey] and isKeyDown(VK_RBUTTON) and im.settings.wdis.v then
						local var_231_118 = getCurrentCharWeapon(playerPed)

						if not as.fastmap.fastmap_state and var_0_35[var_231_118] ~= nil and not isCharInAnyCar(playerPed) and not sampIsDialogActive() and not sampIsScoreboardOpen() and not isSampfuncsConsoleActive() and not sampIsChatInputActive() then
							if test_fov == nil then
								test_fov = 10
							end

							local var_231_119 = "{FFFFFF}"
							local var_231_120 = var_0_35[getCurrentCharWeapon(playerPed)]

							if var_231_118 == 24 and tazer_state == "ON" then
								var_231_120 = 9
							end

							local var_231_121, var_231_122, var_231_123, var_231_124 = getTargetDistanceFov(30)

							if var_231_121 and var_231_123 then
								local var_231_125 = ""

								if var_231_123 <= var_231_120 then
									var_231_119, var_231_125 = "{008000}", "�������!"
								else
									var_231_119, var_231_125 = "{FF0000}", "�����!"
								end

								if se.main.wdis_distance == false then
									renderFontDrawText(var_0_31,
										var_231_119 .. var_231_125 .. (tazer_state == "ON" and " TAZER!" or ""),
										var_0_94 / 1.9, var_0_95 / 2.1, 4294967295)
								else
									renderFontDrawText(var_0_31,
										var_231_119 ..
										var_231_123 .. "/" .. var_231_120 .. (tazer_state == "ON" and " TAZER!" or ""),
										var_0_94 / 1.9, var_0_95 / 2.1, 4294967295)
								end
							end
						end
					end
				end

				if isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.fsquad))) and not sampIsDialogActive() and not sampIsChatInputActive() and suspect_veh ~= nil and suspect_num ~= nil and suspect_id ~= nil and _G.mass[mkey] then
					local var_231_126, var_231_127 = sampGetCharHandleBySampPlayerId(suspect_id)
					local var_231_128 = {
						"� ���-�������",
						"� ���-������",
						"� ���-���������"
					}
					local var_231_129 = getCityPlayerIsIn(playerPed)
					local var_231_130, var_231_131, var_231_132 = getCharCoordinates(playerPed)

					if var_231_129 > 0 then
						playerCity1 = var_231_128[var_231_129]
					else
						playerCity1 = "� " .. calcZ(var_231_130, var_231_131, var_231_132)
					end

					if doesCharExist(var_231_127) then
						local var_231_133, var_231_134, var_231_135 = getCharCoordinates(var_231_127)

						sampSendChat("/fs " ..
						(tencodes.pursuit ~= "" and tencodes.pursuit or "���������") ..
						" " ..
						suspect_veh ..
						" [" ..
						suspect_num ..
						"] �� " .. kvadUli(var_231_127) .. " �� " .. direction(var_231_127) .. " " .. playerCity1 .. ".")
					else
						sampSendChat("/fs " ..
						(tencodes.pursuit ~= "" and tencodes.pursuit or "���������") ..
						" " ..
						suspect_veh ..
						" [" ..
						suspect_num ..
						"] �� " .. kvadUli(playerPed) .. " �� " .. direction(playerPed) .. " " .. playerCity1 .. ".")
					end
				end

				if testCheat("rr") and se.main.doubleR and not sampIsDialogActive() and not sampIsChatInputActive() and _G.mass[mkey] then
					sampSetChatInputEnabled(true)
					sampSetChatInputText("/r ")
				end

				if testCheat("bnb") then
					if im.windows.notepad.v then
						as.notepad.file = io.open("moonloader/PD-Project/notepad.karimoff", "w+")

						if as.notepad.file then
							as.notepad.file:write(im.other.notepad.v)
							as.notepad.file:close()

							im.other.notepad.v = ""
						end

						im.windows.notepad.v = false
					else
						as.notepad.file, as.notepad.data = nil
						im.windows.notepad.v = true
					end
				end

				if isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.tazz))) and not sampIsDialogActive() and not sampIsChatInputActive() and _G.mass[mkey] then
					if tazer_state == "OFF" then
						sampSendChat("/tazer")
						wait(p(1000))
						sampSendSystemChat(getEditByCode("taser.gettaser", 1))
					else
						sampSendChat("/tazer")
						wait(p(1000))
						sampSendSystemChat(getEditByCode("taser.gettaser", 2))
					end
				end

				if mouseCoord3 then
					local var_231_136, var_231_137 = sampGetPlayerNickname(myID):match("(%u)%a+%_(%u)%a+")

					suspect_veh = "FCR-900"
					suspect_num = "[" .. numberPlate(myID) .. "]"
					suspect_id = myID
					suspect_name = myName:gsub("_", " ")

					showCursor(true, true)

					pursX, pursY = getCursorPos()

					if isKeyDown(VK_RETURN) then
						se.pursuit.pursX = math.floor(pursX)
						se.pursuit.pursY = math.floor(pursY)
						mouseCoord3 = false

						showCursor(false, false)

						suspect_veh, suspect_veh_handle = nil
						suspect_num = nil
						suspect_id = nil
						suspect_name = nil
					end
				end

				if mouseCoord4 then
					showCursor(true, true)

					radX, radY = getCursorPos()

					if isKeyDown(VK_RETURN) then
						se.main.radX = math.floor(radX)
						se.main.radY = math.floor(radY)
						mouseCoord4 = false

						showCursor(false, false)
					end
				end

				if mouseCoord5 then
					showCursor(true, true)

					hotkkX, hotkkY = getCursorPos()

					local var_231_138 = hotkkX
					local var_231_139 = hotkkY

					for iter_231_22 = 1, #hotKeys do
						renderFontDrawText(var_0_27, hotKeys[iter_231_22], var_231_138, var_231_139, 4294967295)

						var_231_139 = var_231_139 + 17
					end

					if isKeyDown(VK_RETURN) then
						se.main.hkPlaceX = math.floor(hotkkX)
						se.main.hkPlaceY = math.floor(hotkkY)
						mouseCoord5 = false

						showCursor(false, false)
					end
				end

				if mouseCoord6 then
					showCursor(true, true)

					hotTarX, hotTarY = getCursorPos()

					local var_231_140 = hotTarX
					local var_231_141 = hotTarY

					for iter_231_23 = 1, #hotTarget do
						renderFontDrawText(var_0_27, hotTarget[iter_231_23], var_231_140, var_231_141, 4294967295)

						var_231_141 = var_231_141 + 17
					end

					if isKeyDown(VK_RETURN) then
						se.main.hotTarX = math.floor(hotTarX)
						se.main.hotTarY = math.floor(hotTarY)
						mouseCoord6 = false

						showCursor(false, false)
					end
				end

				if mouseCoord7 then
					showCursor(true, true)

					timingsX, timingsY = getCursorPos()

					local var_231_142 = timingsX
					local var_231_143 = timingsY

					if isKeyDown(VK_RETURN) then
						se.main.timingsX = math.floor(timingsX)
						se.main.timingsY = math.floor(timingsY)
						mouseCoord7 = false

						showCursor(false, false)
					end
				end

				if suspect_veh ~= nil and suspect_num ~= nil and suspect_id ~= nil then
					if mouseCoord3 then
						showCursor(true, true)

						pursX, pursY = getCursorPos()

						if isKeyDown(VK_RETURN) then
							se.pursuit.pursX = math.floor(pursX)
							se.pursuit.pursY = math.floor(pursY)
							mouseCoord3 = false

							showCursor(false, false)
						end
					end

					var_0_44.v = true

					if not hotKeyX and not hotKeyZ and not hotKeyB and se.main.pursuit then
						if se.main.hkPlaceX == 0 and se.main.hkPlaceY == 0 then
							local var_231_144 = var_0_95 / 2
							local var_231_145 = 400

							for iter_231_24 = 1, #hotKeys do
								if not hotKeys[iter_231_24]:find("%'%'%s%-%s%S+") then
									renderFontDrawText(var_0_27, hotKeys[iter_231_24], var_0_94 * 0.02, var_231_145,
										4294967295)

									var_231_145 = var_231_145 + 17
								end
							end
						else
							local var_231_146 = se.main.hkPlaceX
							local var_231_147 = se.main.hkPlaceY

							for iter_231_25 = 1, #hotKeys do
								if not hotKeys[iter_231_25]:find("%'%'%s%-%s%S+") then
									renderFontDrawText(var_0_27, hotKeys[iter_231_25], var_231_146, var_231_147,
										4294967295)

									var_231_147 = var_231_147 + 17
								end
							end
						end
					end
				else
					var_0_44.v = false

					remu()
				end

				if isKeyDown(VK_X) and not sampIsDialogActive() and not sampIsChatInputActive() and _G.mass[mkey] and im.informer.infMainHotXbool.v then
					hotKeyX = true

					if se.main.hkPlaceX == 0 and se.main.hkPlaceY == 0 then
						local var_231_148 = var_0_95 / 2
						local var_231_149 = 400

						for iter_231_26 = 1, #hotX do
							renderFontDrawText(var_0_27, hotX[iter_231_26], var_0_94 * 0.02, var_231_149, 4294967295)

							var_231_149 = var_231_149 + 17
						end
					else
						local var_231_150 = se.main.hkPlaceX
						local var_231_151 = se.main.hkPlaceY

						for iter_231_27 = 1, #hotX do
							renderFontDrawText(var_0_27, hotX[iter_231_27], var_231_150, var_231_151, 4294967295)

							var_231_151 = var_231_151 + 17
						end
					end
				else
					hotKeyX = false
				end

				if pedSpawned then
					wait(p(1000))
					sampSendChat("/clist " .. se.main.clist)
					wait(p(1000))

					if tostring(myfrac) == "4" then
						local var_231_152 = getEditByCode("other.fbi_badge", 1)
						local var_231_153 = gsub(var_231_152)

						sampSendSystemChat(var_231_153)
					else
						local var_231_154 = getEditByCode("other.cop_badge", 1)
						local var_231_155 = gsub(var_231_154)

						sampSendSystemChat(var_231_155)
					end

					pedSpawned = false
				end

				if as.other.killedSector ~= nil and se.main.officer_down then
					sampSendSystemChat("/r " ..
					(tencodes.officer_down ~= "" and tencodes.officer_down or im.informer.infMainSex.v and "�����" or "������") ..
					" " .. as.other.killedSector .. ".")

					as.other.killedSector = nil
				end

				if isKeyDown(VK_Z) and im.informer.infMainHotZbool.v and not sampIsDialogActive() and not sampIsChatInputActive() and _G.mass[mkey] then
					hotKeyZ = true

					if se.main.hkPlaceX == 0 and se.main.hkPlaceY == 0 then
						local var_231_156 = var_0_95 / 2
						local var_231_157 = 400

						for iter_231_28 = 1, #hotZ do
							renderFontDrawText(var_0_27, hotZ[iter_231_28], var_0_94 * 0.02, var_231_157, 4294967295)

							var_231_157 = var_231_157 + 17
						end
					else
						local var_231_158 = se.main.hkPlaceX
						local var_231_159 = se.main.hkPlaceY

						for iter_231_29 = 1, #hotZ do
							renderFontDrawText(var_0_27, hotZ[iter_231_29], var_231_158, var_231_159, 4294967295)

							var_231_159 = var_231_159 + 17
						end
					end
				else
					hotKeyZ = false
				end

				if isKeyDown(VK_B) and not sampIsDialogActive() and not sampIsChatInputActive() and _G.mass[mkey] and im.informer.infMainHotBbool.v then
					hotKeyB = true

					if se.main.hkPlaceX == 0 and se.main.hkPlaceY == 0 then
						local var_231_160 = var_0_95 / 2
						local var_231_161 = 360

						for iter_231_30 = 1, #hotB do
							renderFontDrawText(var_0_27, hotB[iter_231_30], var_0_94 * 0.02, var_231_161, 4294967295)

							var_231_161 = var_231_161 + 17
						end
					else
						local var_231_162 = se.main.hkPlaceX
						local var_231_163 = se.main.hkPlaceY

						for iter_231_31 = 1, #hotB do
							renderFontDrawText(var_0_27, hotB[iter_231_31], var_231_162, var_231_163, 4294967295)

							var_231_163 = var_231_163 + 17
						end
					end
				else
					hotKeyB = false
				end

				if suspect_veh == nil and suspect_num == nil and suspect_id == nil and isKeyJustPressed(VK_J) then
					removeBlip(bliper_handle)
				end

				if isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.pursuit_start))) and _G.mass[mkey] and not sampIsDialogActive() and not sampIsChatInputActive() then
					if se.main.newsp and isKeyDown(VK_RBUTTON) then
						if as.crosshair.id and sampIsPlayerConnected(tonumber(as.crosshair.id)) and as.crosshair.handle ~= nil and as.crosshair.car ~= nil then
							as.crosshair.name = sampGetPlayerNickname(as.crosshair.id)

							_G.sampAddChatMessage(
							"| {FFFFFF}�� ������ ������������� " ..
							as.crosshair.car .. " [" .. numberPlate(as.crosshair.id) .. "].", clr)

							if im.informer.infMainShowPursuit.v then
								lua_thread.create(function()
									wait(p(300))
									sampSendChat("/patrul " .. tostring(as.crosshair.id))
								end)
							end

							oralo_st = 0
							suspect_veh = as.crosshair.car
							suspect_num = numberPlate(as.crosshair.id)
							suspect_id = as.crosshair.id
							suspect_name = as.crosshair.name

							vspdAddByChar(as.crosshair.handle)

							depnotifi = true

							local var_231_164, var_231_165 = sampGetCharHandleBySampPlayerId(as.crosshair.handle)

							if var_231_164 then
								local var_231_166 = storeCarCharIsInNoSave(var_231_165)

								suspect_veh_handle = var_231_166

								if isCharInAnyHeli(var_231_165) then
									heli = true
								else
									heli = false
								end

								if getCarModel(var_231_166) == 461 or getCarModel(var_231_166) == 462 or getCarModel(var_231_166) == 463 or getCarModel(var_231_166) == 468 or getCarModel(var_231_166) == 471 or getCarModel(var_231_166) == 521 or getCarModel(var_231_166) == 522 or getCarModel(var_231_166) == 581 or getCarModel(var_231_166) == 586 or getCarModel(var_231_166) == 523 then
									moto = true
								else
									moto = false
								end
							end
						end
					else
						VTable = {}
						heli = false
						moto = false
						oralo_st = 0

						for iter_231_32 = 0, sampGetMaxPlayerId() do
							if sampIsPlayerConnected(iter_231_32) then
								local var_231_167, var_231_168 = sampGetCharHandleBySampPlayerId(iter_231_32)

								player = var_231_168

								if var_231_167 and doesCharExist(player) and isCharInCarDriver(player) then
									cpId = iter_231_32
									cpName = sampGetPlayerNickname(cpId)

									local var_231_169 = getGxtText(getNameOfVehicleModel(getCarModel(
									storeCarCharIsInNoSave(player))))
									local var_231_170 = storeCarCharIsInNoSave(player)
									local var_231_171, var_231_172, var_231_173 = getCharCoordinates(player)

									cNum = numberPlate(cpId)

									table.insert(VTable,
										"[" ..
										var_231_169 ..
										"]\t[" ..
										cNum ..
										"]\t[{" ..
										string.format("%06X", ARGBtoRGB(sampGetPlayerColor(cpId))) ..
										"}" .. cpId .. "{FFFFFF}]")

									table_status = "start"
								end
							end
						end

						if table_status == "start" then
							suspect_health = nil

							sampShowDialog(1488, "    ",
								"����������\t���. �����\tID ��������\n" .. table.concat(VTable, "\n"), "��", "������", 5)

							table_status = "stop"
						elseif table_status ~= "start" then
							chat("����� �� ��������� ������������ �������� ����������.")
						end
					end
				end

				if isKeyDown(VK_Z) and isKeyJustPressed(VK_2) and _G.mass[mkey] and im.informer.infMainHotZbool.v and not sampIsDialogActive() and not sampIsChatInputActive() then
					awaitSendChat({
						getEditByCode("hotkey_z.z2", 1),
						getEditByCode("hotkey_z.z2", 2),
						getEditByCode("hotkey_z.z2", 3),
						getEditByCode("hotkey_z.z2", 4)
					}, 1, 2000, true, false)
				end

				if isKeyDown(VK_Z) and isKeyJustPressed(VK_8) and _G.mass[mkey] and im.informer.infMainHotZbool.v and not sampIsDialogActive() and not sampIsChatInputActive() then
					local var_231_174 = getClosestCarName()

					if var_231_174 then
						local var_231_175 = getEditByCode("hotkey_z.z8", 1):gsub("{tfcar}", var_231_174)
						local var_231_176 = getEditByCode("hotkey_z.z8", 2):gsub("{tfcar}", var_231_174)

						sampSendSystemChat(var_231_175)
						wait(1200)
						sampSendSystemChat(var_231_176)
						wait(1000)
						sampSendChat("/tfrisk")

						as.other.tfrisk_start = true
					else
						chat("���������� ��� ����������.")
					end
				end

				if isKeyJustPressed(VK_1) and isKeyJustPressed(VK_Z) and _G.mass[mkey] and im.informer.infMainHotZbool.v and not sampIsDialogActive() and not sampIsChatInputActive() then
					if frac ~= nil then
						if tostring(myfrac) == "4" then
							if rang then
								local var_231_177 = gsub(getEditByCode("hotkey_z.fbi_z1", 1))
								local var_231_178 = gsub(getEditByCode("hotkey_z.fbi_z1", 2))
								local var_231_179 = gsub(getEditByCode("hotkey_z.fbi_z1", 3))

								sampSendSystemChat(var_231_177)
								wait(2000)
								sampSendSystemChat(var_231_178)
								wait(2000)
								sampSendSystemChat(var_231_179)
							else
								chat("�� ������� �������� ���� ������.")
							end
						else
							rtab = {}
							rtab.����� = "�������"
							rtab.������ = "�������"
							rtab["��.�������"] = "�������"
							rtab.������� = "�������"
							rtab.��������� = "�������"
							rtab["��.���������"] = "�������"
							rtab["��.���������"] = "��������� �������"
							rtab.��������� = "��������� �������"
							rtab["��.���������"] = "��������� �������"
							rtab.������� = "��������� �������"
							rtab.����� = "��������� �������"
							rtab.������������ = "��������� �������"
							rtab.��������� = "��������� �������"
							rtab.����� = "��������� �������"

							local var_231_180 = "������"

							if rtab[rang] then
								var_231_180 = rtab[rang]
							end

							local var_231_181 = gsub(getEditByCode("hotkey_z.cop_z1", 1):gsub("{badge_type}", var_231_180))
							local var_231_182 = gsub(getEditByCode("hotkey_z.cop_z1", 2):gsub("{badge_type}", var_231_180))

							sampSendSystemChat(var_231_181)
							wait(p(1000))
							sampSendSystemChat(var_231_182)
						end
					else
						chat("�� ������� �������� ���� ������.")
					end
				end

				if isKeyJustPressed(VK_7) and isKeyJustPressed(VK_X) and not sampIsDialogActive() and not sampIsChatInputActive() and _G.mass[mkey] and im.informer.infMainHotXbool.v then
					local var_231_183, var_231_184, var_231_185 = getCharCoordinates(playerPed)

					sampProcessChatInput("/r " ..
					(tencodes.foxtrot == "" and "����� ������" or tencodes.foxtrot) ..
					" �� " ..
					calcZ(var_231_183, var_231_184, var_231_185) ..
					", " .. kvadUli(playerPed) .. " �� " .. direction(playerPed) .. ".")
				end

				if isKeyJustPressed(VK_0) and isKeyJustPressed(VK_X) and _G.mass[mkey] and im.informer.infMainHotXbool.v and not sampIsDialogActive() and not sampIsChatInputActive() then
					sampSendChat("/m ��������, ������� ������ � ������������!")
				end

				if isKeyJustPressed(VK_1) and isKeyJustPressed(VK_X) and _G.mass[mkey] and im.informer.infMainHotXbool.v and not sampIsDialogActive() and not sampIsChatInputActive() and se then
					if getMyPartner() == "" or getMyPartner() == "-" then
						local var_231_186 = getCityPlayerIsIn(playerPed)
						local var_231_187, var_231_188, var_231_189 = getCharCoordinates(playerPed)

						if var_231_186 > 0 then
							playerCity = as.other.citiesList[var_231_186]
						else
							playerCity = "��� �������"
						end

						_G.sampAddChatMessage("| {FFFFFF}�� �� ������� ������ ���������. ���������� ��������� �������.",
							clr)

						if srv_name == "revolution" then
							if tostring(myfrac) == "1" then
								sampSendChat("/r " ..
								u8:decode(se.main.tag) ..
								" " .. u8:decode(string.upper(se.main.area)) .. ", " .. tencodes.patrol_start .. ".")
								setmark()
							elseif tostring(myfrac) == "2" then
								sampSendChat("/r " ..
								u8:decode(se.main.tag) ..
								" " ..
								(se.main.area ~= "" and " " .. u8:decode(se.main.area) .. "," or "") ..
								" " ..
								(tencodes.patrol_start ~= "" and tencodes.patrol_start or se.main.area ~= "" and "������� � ��������������" or "������� � ��������������") ..
								" " .. playerCity .. ".")
							elseif tostring(myfrac) == "3" then
								sampSendChat("/r " ..
								u8:decode(se.main.tag) ..
								" " ..
								u8:decode(se.main.area) ..
								", " ..
								tencodes.patrol_start .. " " .. calcZ(var_231_187, var_231_188, var_231_189) .. ".")
								setmark()
							elseif tostring(myfrac) == "4" then
								sampSendChat("/r " ..
								u8:decode(se.main.tag) ..
								"" ..
								(se.main.area ~= "" and " " .. u8:decode(se.main.area) .. "," or "") ..
								" " ..
								(tencodes.patrol_start ~= "" and tencodes.patrol_start or se.main.area ~= "" and "������� � ��������������" or "������� � ��������������") ..
								" " .. playerCity .. ".")
							end
						end

						if srv_name == "legacy" or srv_name == "evolve" or srv_name == "underground" then
							sampSendChat("/r " ..
							u8:decode(se.main.tag) ..
							"" ..
							(se.main.area ~= "" and " " .. u8:decode(se.main.area) .. "," or "") ..
							" " ..
							(tencodes.patrol_start ~= "" and tencodes.patrol_start or se.main.area ~= "" and "������� � ��������������" or "������� � ��������������") ..
							" " .. playerCity .. ".")
							wait(300)
						end
					else
						local var_231_190 = getCityPlayerIsIn(playerPed)
						local var_231_191, var_231_192, var_231_193 = getCharCoordinates(playerPed)

						if var_231_190 > 0 then
							playerCity = as.other.citiesList[var_231_190]
						else
							playerCity = "��� �������"
						end

						if srv_name == "revolution" then
							if tostring(myfrac) == "1" then
								sampSendChat("/r " ..
								u8:decode(se.main.tag) ..
								" #" ..
								tostring(se.main.partner):gsub(" ", " & #") ..
								", " .. u8:decode(string.upper(se.main.area)) .. ", " .. tencodes.patrol_start .. ".")
								setmark()
							elseif tostring(myfrac) == "2" then
								sampSendChat("/r " ..
								u8:decode(se.main.tag) ..
								"" ..
								(se.main.area ~= "" and " " .. u8:decode(se.main.area) .. "," or "") ..
								" " ..
								(tencodes.patrol_start ~= "" and tencodes.patrol_start or se.main.area ~= "" and "������� � ��������������" or "������� � ��������������") ..
								" " .. playerCity .. ". ��������: " .. se.main.partner .. ".")
							elseif tostring(myfrac) == "3" then
								sampSendChat("/r " ..
								u8:decode(se.main.tag) ..
								" " ..
								u8:decode(se.main.area) ..
								", " ..
								tencodes.patrol_start ..
								" " ..
								calcZ(var_231_191, var_231_192, var_231_193) .. ". ��������: " .. se.main.partner .. ".")
								setmark()
							elseif tostring(myfrac) == "4" then
								sampSendChat("/r " ..
								u8:decode(se.main.tag) ..
								"" ..
								(se.main.area ~= "" and " " .. u8:decode(se.main.area) .. "," or "") ..
								" " ..
								(tencodes.patrol_start ~= "" and tencodes.patrol_start or se.main.area ~= "" and "������� � ��������������" or "������� � ��������������") ..
								" " .. playerCity .. ". ��������: " .. se.main.partner .. ".")
							end
						end

						if srv_name == "legacy" or srv_name == "evolve" or srv_name == "underground" then
							sampSendChat("/r " ..
							u8:decode(se.main.tag) ..
							"" ..
							(se.main.area ~= "" and " " .. u8:decode(se.main.area) .. "," or "") ..
							" " ..
							(tencodes.patrol_start ~= "" and tencodes.patrol_start or se.main.area ~= "" and "������� � ��������������" or "������� � ��������������") ..
							" " .. playerCity .. ". ��������: " .. getMyPartner() .. ".")
							wait(300)
						end
					end
				end

				if isKeyJustPressed(VK_4) and isKeyJustPressed(VK_X) and _G.mass[mkey] and im.informer.infMainHotXbool.v and not sampIsDialogActive() and not sampIsChatInputActive() then
					local var_231_194, var_231_195 = closestClothesShop()

					if var_231_194 ~= "" then
						if var_231_195 < 100 then
							sampSendChat(string.format("/r %s %s %s! � �� �����.", u8:decode(se.main.tag),
								tencodes.sos ~= "" and tencodes.sos or "��������� ���������!", var_231_194))
						else
							sampSendChat(string.format("/r %s %s %s! � � %d �. �� ����.", u8:decode(se.main.tag),
								tencodes.sos ~= "" and tencodes.sos or "��������� ���������!", var_231_194, var_231_195))
						end
					else
						chat("��������� ������� ������ �� ���������.")
					end
				end

				if isKeyJustPressed(VK_5) and isKeyJustPressed(VK_X) and _G.mass[mkey] and im.informer.infMainHotXbool.v and not sampIsDialogActive() and not sampIsChatInputActive() then
					local var_231_196, var_231_197 = closestGunShop()

					if var_231_196 ~= "" then
						if var_231_197 < 100 then
							sampSendChat(string.format("/r %s %s %s! � �� �����.", u8:decode(se.main.tag),
								tencodes.sos ~= "" and tencodes.sos or "��������� ���������!", var_231_196))
						else
							sampSendChat(string.format("/r %s %s %s! � � %d �. �� ����.", u8:decode(se.main.tag),
								tencodes.sos ~= "" and tencodes.sos or "��������� ���������!", var_231_196, var_231_197))
						end
					else
						chat("��������� ������� ������ �� ���������.")
					end
				end

				if isKeyJustPressed(VK_6) and isKeyJustPressed(VK_X) and _G.mass[mkey] and im.informer.infMainHotXbool.v and not sampIsDialogActive() and not sampIsChatInputActive() then
					local var_231_198, var_231_199 = closestShop()

					if var_231_198 ~= "" then
						if var_231_199 < 100 then
							sampSendChat(string.format("/r %s %s %s! � �� �����.", u8:decode(se.main.tag),
								tencodes.sos ~= "" and tencodes.sos or "��������� ���������!", var_231_198))
						else
							sampSendChat(string.format("/r %s %s %s! � � %d �. �� ����.", u8:decode(se.main.tag),
								tencodes.sos ~= "" and tencodes.sos or "��������� ���������!", var_231_198, var_231_199))
						end
					else
						chat("��������� ������� ������ �� ���������.")
					end
				end

				if isKeyJustPressed(VK_3) and isKeyJustPressed(VK_Z) and im.informer.infMainHotZbool.v and not sampIsDialogActive() and not sampIsChatInputActive() and _G.mass[mkey] then
					if kvad(playerPed) == "�-2" or kvad(playerPed) == "�-6" or kvad(playerPed) == "�-21" or kvad(playerPed) == "�-18" or kvad(playerPed) == "�-18" or kvad(playerPed) == "�-2" then
						if kvad(playerPed) == "�-2" then
							sampSendChat("/r " ..
							u8:decode(se.main.tag) ..
							" " ..
							(tencodes.sos ~= "" and tencodes.sos or "���������� ���������") ..
							" � ���� �. San Fierro [" .. kvad(playerPed) .. "].")
						elseif kvad(playerPed) == "�-6" then
							sampSendChat("/r " ..
							u8:decode(se.main.tag) ..
							" " ..
							(tencodes.sos ~= "" and tencodes.sos or "���������� ���������") ..
							" � �� �. San Fierro [" .. kvad(playerPed) .. "].")
						elseif kvad(playerPed) == "�-21" then
							sampSendChat("/r " ..
							u8:decode(se.main.tag) ..
							" " ..
							(tencodes.sos ~= "" and tencodes.sos or "���������� ���������") ..
							" � ���� �. Las Venturas [" .. kvad(playerPed) .. "].")
						elseif kvad(playerPed) == "�-18" or kvad(playerPed) == "�-18" then
							sampSendChat("/r " ..
							u8:decode(se.main.tag) ..
							" " ..
							(tencodes.sos ~= "" and tencodes.sos or "���������� ���������") ..
							" � ���� �. Los Santos [" .. kvad(playerPed) .. "].")
						elseif kvad(playerPed) == "�-2" then
							sampSendChat("/r " ..
							u8:decode(se.main.tag) ..
							" " ..
							(tencodes.sos ~= "" and tencodes.sos or "���������� ���������") ..
							" � ��������� �. San Fierro [" .. kvad(playerPed) .. "].")
						end
					else
						sampSendChat("/r " ..
						u8:decode(se.main.tag) ..
						" " ..
						(tencodes.sos ~= "" and tencodes.sos or "���������� ���������") ..
						" � ���������������: " .. kvadUli(playerPed))
					end
				end

				if isKeyJustPressed(VK_2) and isKeyJustPressed(VK_X) and im.informer.infMainHotXbool.v and not sampIsDialogActive() and not sampIsChatInputActive() and _G.mass[mkey] and se then
					if getMyPartner() == "" or getMyPartner() == "-" then
						local var_231_200 = getCityPlayerIsIn(playerPed)
						local var_231_201, var_231_202, var_231_203 = getCharCoordinates(playerPed)

						if var_231_200 > 0 then
							playerCity = as.other.citiesList[var_231_200]
						else
							playerCity = "��� �������"
						end

						if srv_name == "revolution" then
							if tostring(myfrac) == "1" then
								sampSendChat("/r " ..
								u8:decode(se.main.tag) ..
								" " .. u8:decode(string.upper(se.main.area)) .. ", " .. tencodes.normal .. ".")
								setmark()
							elseif tostring(myfrac) == "2" then
								sampSendChat("/r " ..
								u8:decode(se.main.tag) ..
								" " ..
								(se.main.area ~= "" and u8:decode(se.main.area) .. "," or "�������") ..
								" " ..
								playerCity ..
								(tencodes.normal ~= "" and ", " .. tencodes.normal or ", ����������� ���������") .. ".")
							elseif tostring(myfrac) == "3" then
								sampSendChat("/r " ..
								u8:decode(se.main.tag) ..
								" " ..
								(tencodes.normal ~= "" and tencodes.normal or "�������") ..
								" " ..
								u8:decode(se.main.area) .. ", " .. calcZ(var_231_201, var_231_202, var_231_203) .. ".")
								setmark()
							elseif tostring(myfrac) == "4" then
								sampSendChat("/r " ..
								u8:decode(se.main.tag) ..
								" " ..
								(se.main.area ~= "" and u8:decode(se.main.area) .. "," or "�������") ..
								" " ..
								tostring(playerCity ~= "��� �������" and playerCity or
								calcZ(var_231_201, var_231_202, var_231_203)) ..
								(tencodes.normal ~= "" and ", " .. tencodes.normal or ", ����������� ���������") .. ".")
							end
						end

						if srv_name == "legacy" or srv_name == "underground" or srv_name == "evolve" then
							sampSendChat("/r " ..
							u8:decode(se.main.tag) ..
							" " ..
							(se.main.area ~= "" and u8:decode(se.main.area) .. "," or "�������") ..
							" " ..
							playerCity ..
							(tencodes.normal ~= "" and ", " .. tencodes.normal or ", ����������� ���������") .. ".")
						end
					else
						local var_231_204 = getCityPlayerIsIn(playerPed)
						local var_231_205, var_231_206, var_231_207 = getCharCoordinates(playerPed)

						if var_231_204 > 0 then
							playerCity = as.other.citiesList[var_231_204]
						else
							playerCity = "��� �������"
						end

						if srv_name == "revolution" then
							if tostring(myfrac) == "1" then
								sampSendChat("/r " ..
								u8:decode(se.main.tag) ..
								" #" ..
								tostring(se.main.partner):gsub(" ", " & #") ..
								", " .. u8:decode(string.upper(se.main.area)) .. ", " .. tencodes.normal .. ".")
								setmark()
							elseif tostring(myfrac) == "2" then
								sampSendChat("/r " ..
								u8:decode(se.main.tag) ..
								" " ..
								(se.main.area ~= "" and u8:decode(se.main.area) .. "," or "�������") ..
								" " ..
								playerCity ..
								(tencodes.normal ~= "" and ", " .. tencodes.normal or ", ����������� ���������") ..
								". ��������: " .. se.main.partner .. ".")
							elseif tostring(myfrac) == "3" then
								sampSendChat("/r " ..
								u8:decode(se.main.tag) ..
								" " ..
								(tencodes.normal ~= "" and tencodes.normal or "�������") ..
								" " ..
								u8:decode(se.main.area) ..
								", " ..
								calcZ(var_231_205, var_231_206, var_231_207) .. ". ��������: " .. se.main.partner .. ".")
								setmark()
							elseif tostring(myfrac) == "4" then
								sampSendChat("/r " ..
								u8:decode(se.main.tag) ..
								" " ..
								(se.main.area ~= "" and u8:decode(se.main.area) .. "," or "�������") ..
								" " ..
								(playerCity ~= "��� �������" and tostring(playerCity) or calcZ(var_231_205, var_231_206, var_231_207)) ..
								". ��������: " .. se.main.partner .. ".")
							end
						end

						if srv_name == "legacy" or srv_name == "underground" or srv_name == "evolve" then
							sampSendChat("/r " ..
							u8:decode(se.main.tag) ..
							" " ..
							(se.main.area ~= "" and u8:decode(se.main.area) .. "," or "�������") ..
							" " ..
							playerCity ..
							(tencodes.normal ~= "" and ", " .. tencodes.normal or ", ����������� ���������") ..
							". ��������: " .. getMyPartner() .. ".")
						end
					end
				end

				if isKeyJustPressed(VK_4) and isKeyJustPressed(VK_Z) and im.informer.infMainHotZbool.v and not sampIsDialogActive() and not sampIsChatInputActive() and _G.mass[mkey] then
					sampSendChat("/r " ..
					u8:decode(se.main.tag) .. " ��������� ����������� �����, " .. kvadUli(playerPed) .. ".")
				end

				if isKeyDown(VK_Z) and isKeyJustPressed(VK_5) and _G.mass[mkey] and im.informer.infMainHotZbool.v and not sampIsDialogActive() and not sampIsChatInputActive() then
					if getClosestPlayerId() ~= -1 then
						sampSendChat(string.format("/try ��������� �������� �� ���� %s",
							sampGetPlayerNickname(getClosestPlayerId())))

						catch_id = getClosestPlayerId()
						catch = true
					else
						_G.sampAddChatMessage("| {FFFFFF}���������� ��� �����������.", clr)
					end
				end

				if testCheat("cop") then
					mainmenu()
				end

				if isKeyDown(VK_Z) and isKeyJustPressed(VK_6) and _G.mass[mkey] and im.informer.infMainHotZbool.v and not sampIsDialogActive() and not sampIsChatInputActive() then
					if not isCharInAnyCar(playerPed) and getClosestPlayerId() ~= -1 then
						local var_231_208 = getClosestPlayerId()

						if sampIsPlayerConnected(var_231_208) then
							local var_231_209, var_231_210 = sampGetCharHandleBySampPlayerId(var_231_208)

							if var_231_209 and doesCharExist(var_231_210) then
								if isCharInAnyCar(var_231_210) and not isPlayerCop(cop, getCharModel(var_231_210)) then
									local var_231_211 = getGxtText(getNameOfVehicleModel(getCarModel(
									storeCarCharIsInNoSave(var_231_210))))

									if isCharInAnyMoto(var_231_210) then
										local var_231_212 = getEditByCode("other.scemoto", 1):gsub("{name}",
											sampGetPlayerNickname(var_231_208):gsub("_", " ")):gsub("{car}", var_231_211)

										sampSendSystemChat(var_231_212)
									else
										local var_231_213 = getEditByCode("hotkey_z.z6", 1):gsub("{name}",
											sampGetPlayerNickname(var_231_208):gsub("_", " ")):gsub("{car}", var_231_211)

										sampSendSystemChat(var_231_213)
									end

									wait(p(500))
									sampSendChat(string.format("/ceject %d", var_231_208))
								else
									am("����� ������ ���������� � ������.")
								end
							else
								am("����� �� ��������.")
							end
						end
					else
						am("���������� � ������ ��� ���������� ��� �������.")
					end
				end

				if isKeyDown(VK_Z) and isKeyJustPressed(VK_7) and _G.mass[mkey] and im.informer.infMainHotZbool.v and not sampIsDialogActive() and not sampIsChatInputActive() then
					if not isCharInAnyCar(playerPed) and getClosestPlayerId() ~= -1 then
						local var_231_214 = getClosestPlayerId()

						if sampIsPlayerConnected(var_231_214) then
							local var_231_215, var_231_216 = sampGetCharHandleBySampPlayerId(var_231_214)

							if var_231_215 and doesCharExist(var_231_216) then
								if isCharInAnyCar(var_231_216) and not isPlayerCop(cop, getCharModel(var_231_216)) then
									local var_231_217 = getGxtText(getNameOfVehicleModel(getCarModel(
									storeCarCharIsInNoSave(var_231_216))))

									if isCharInAnyMoto(var_231_216) then
										local var_231_218 = getEditByCode("other.scemoto", 1):gsub("{name}",
											sampGetPlayerNickname(var_231_214):gsub("_", " ")):gsub("{car}", var_231_217)

										sampSendSystemChat(var_231_218)
									else
										local var_231_219 = getEditByCode("hotkey_z.z7", 1):gsub("{name}",
											sampGetPlayerNickname(var_231_214):gsub("_", " ")):gsub("{car}", var_231_217)

										sampSendSystemChat(var_231_219)
									end

									wait(p(1000))
									sampSendChat(string.format("/ceject %d", var_231_214))
									wait(p(3000))
									sampSendChat(string.format("/cuff %d", var_231_214))
								else
									am("����� ������ ���������� � ������.")
								end
							else
								am("����� �� ��������.")
							end
						end
					else
						am("���������� � ������ ��� ���������� ��� �������.")
					end
				end

				if isKeyDown(VK_X) and isKeyJustPressed(VK_3) and _G.mass[mkey] and im.informer.infMainHotXbool.v and not sampIsDialogActive() and not sampIsChatInputActive() and se then
					if getMyPartner() == "" or getMyPartner() == "-" then
						local var_231_220 = getCityPlayerIsIn(playerPed)
						local var_231_221, var_231_222, var_231_223 = getCharCoordinates(playerPed)

						if var_231_220 > 0 then
							playerCity = as.other.citiesList[var_231_220]
						else
							playerCity = "��� �������"
						end

						if srv_name == "revolution" then
							if tostring(myfrac) == "1" then
								sampSendChat("/r " ..
								u8:decode(se.main.tag) ..
								" " .. u8:decode(string.upper(se.main.area)) .. ", " .. tencodes.patrol_finish .. ".")
								sampDestroy3dText(marker)
							elseif tostring(myfrac) == "2" then
								sampSendChat("/r " ..
								u8:decode(se.main.tag) ..
								" " ..
								(tencodes.patrol_finish ~= "" and tencodes.patrol_finish or "�������� �������") ..
								" " .. playerCity .. ".")
							elseif tostring(myfrac) == "3" then
								sampSendChat("/r " ..
								u8:decode(se.main.tag) ..
								" " ..
								(tencodes.patrol_finish ~= "" and tencodes.patrol_finish or "�������� �������") ..
								" " .. playerCity .. ".")
								sampDestroy3dText(marker)
							elseif tostring(myfrac) == "4" then
								sampSendChat("/r " ..
								u8:decode(se.main.tag) ..
								" " ..
								(tencodes.patrol_finish ~= "" and tencodes.patrol_finish or "�������� �������") ..
								" " .. (playerCity ~= "" and tostring(playerCity)) or
								calcZ(var_231_221, var_231_222, var_231_223) .. ".")
							end
						end

						if srv_name == "legacy" or srv_name == "underground" or srv_name == "evolve" then
							sampSendChat("/r " ..
							u8:decode(se.main.tag) ..
							" " ..
							(tencodes.patrol_finish ~= "" and tencodes.patrol_finish or "�������� �������") ..
							" " .. playerCity .. ".")
						end
					else
						local var_231_224 = getCityPlayerIsIn(playerPed)
						local var_231_225, var_231_226, var_231_227 = getCharCoordinates(playerPed)

						if var_231_224 > 0 then
							playerCity = as.other.citiesList[var_231_224]
						else
							playerCity = "��� �������"
						end

						if srv_name == "revolution" then
							if tostring(myfrac) == "1" then
								sampSendChat("/r " ..
								u8:decode(se.main.tag) ..
								" #" ..
								tostring(se.main.partner):gsub(" ", " & #") ..
								", " .. u8:decode(string.upper(se.main.area)) .. ", " .. tencodes.patrol_finish .. ".")
								sampDestroy3dText(marker)
							elseif tostring(myfrac) == "2" then
								sampSendChat("/r " ..
								u8:decode(se.main.tag) ..
								" " ..
								(tencodes.patrol_finish ~= "" and tencodes.patrol_finish or "�������� �������") ..
								" " .. playerCity .. ". ��������: " .. se.main.partner .. ".")
							elseif tostring(myfrac) == "3" then
								sampSendChat("/r " ..
								u8:decode(se.main.tag) ..
								" " ..
								(tencodes.patrol_finish ~= "" and tencodes.patrol_finish or "�������� �������") ..
								" " .. playerCity .. ". ��������: " .. se.main.partner .. ".")
								sampDestroy3dText(marker)
							elseif tostring(myfrac) == "4" then
								sampSendChat("/r " ..
								u8:decode(se.main.tag) ..
								" �������� ������� " ..
								(playerCity ~= "��� �������" and tostring(playerCity) or calcZ(var_231_225, var_231_226, var_231_227)) ..
								". ��������: " .. se.main.partner .. ".")
							end
						end

						if srv_name == "legacy" or srv_name == "underground" or srv_name == "evolve" then
							sampSendChat("/r " ..
							u8:decode(se.main.tag) ..
							" " ..
							(tencodes.patrol_finish ~= "" and tencodes.patrol_finish or "�������� �������") ..
							" " .. playerCity .. ". ��������: " .. getMyPartner() .. ".")
						end
					end
				end

				if isKeyDown(VK_B) and isKeyJustPressed(VK_1) and _G.mass[mkey] and im.informer.infMainHotBbool.v and not sampIsDialogActive() and not sampIsChatInputActive() then
					if frac ~= nil and rang ~= nil then
						local var_231_228 = getEditByCode("hotkey_b.b1", 1)
						local var_231_229 = {
							["��.�������"] = "������� �������",
							["����� CID"] = "����� CID",
							["�������� FBI"] = "��������",
							["��.���������"] = "������� ���������",
							["��.���������"] = "������� ���������",
							["��������� FBI"] = "���������",
							["����� DEA"] = "����� DEA",
							["����� CID"] = "����� CID",
							["��.�����"] = "������� �����",
							["��.���������"] = "������� ���������",
							["����� DEA"] = "����� DEA"
						}

						if var_231_229[rang] then
							myRangB1 = var_231_229[rang]
						else
							myRangB1 = string.nlower(rang)
						end

						local var_231_230 = var_231_228:gsub("{rank}", myRangB1)
						local var_231_231 = gsub(var_231_230)

						sampSendSystemChat(var_231_231)
					else
						am("���������� �� ��������. ��������� �������.")
					end
				end

				if isKeyDown(VK_B) and isKeyJustPressed(VK_2) and _G.mass[mkey] and im.informer.infMainHotBbool.v and not sampIsDialogActive() and not sampIsChatInputActive() then
					if frac ~= nil and rang ~= nil then
						local var_231_232 = {
							["��.�������"] = "������� �������",
							["����� CID"] = "����� CID",
							["�������� FBI"] = "��������",
							["��.���������"] = "������� ���������",
							["��.���������"] = "������� ���������",
							["��������� FBI"] = "���������",
							["����� DEA"] = "����� DEA",
							["����� CID"] = "����� CID",
							["��.�����"] = "������� �����",
							["��.���������"] = "������� ���������",
							["����� DEA"] = "����� DEA"
						}

						if var_231_232[rang] then
							myRangB2 = var_231_232[rang]
						else
							myRangB2 = string.nlower(rang)
						end

						local var_231_233 = getEditByCode("hotkey_b.b2", 1):gsub("{rank}", myRangB2)
						local var_231_234 = gsub(var_231_233)

						sampSendChat("/s " .. var_231_234)
					else
						am("���������� �� ��������. ��������� �������.")
					end
				end

				if isKeyDown(VK_B) and isKeyJustPressed(VK_3) and im.informer.infMainHotBbool.v and not sampIsDialogActive() and not sampIsChatInputActive() then
					if im.informer.infMainSex.v then
						sampSendChat("/me ������ ��������� ������ �� ����� � ��������� � ����������� ����.")
					else
						sampSendChat("/me ������� ��������� ������ �� ����� � ���������� � ����������� ����.")
					end

					wait(200)
					sampSetChatInputText("/do �� ������ ������� " ..
					(tostring(myfrac) == "4" and "���������" or "������") .. " " .. (frac ~= nil and frac or "") .. " ")
					sampSetChatInputEnabled(true)
				end

				if isKeyDown(VK_B) and isKeyJustPressed(VK_4) and _G.mass[mkey] and im.informer.infMainHotBbool.v and not sampIsDialogActive() and not sampIsChatInputActive() then
					sampSendSystemChat(gsub(getEditByCode("hotkey_b.b4", 1)))
				end

				if isKeyDown(VK_B) and isKeyJustPressed(VK_5) and _G.mass[mkey] and im.informer.infMainHotBbool.v and not sampIsDialogActive() and not sampIsChatInputActive() then
					sampSendSystemChat(gsub(getEditByCode("hotkey_b.b5", 1)))
				end

				if isKeyDown(VK_B) and isKeyJustPressed(VK_6) and _G.mass[mkey] and im.informer.infMainHotBbool.v and not sampIsDialogActive() and not sampIsChatInputActive() then
					sampSendSystemChat(gsub(getEditByCode("hotkey_b.b6", 1)))
				end

				if isKeyDown(VK_B) and isKeyJustPressed(VK_7) and _G.mass[mkey] and im.informer.infMainHotBbool.v and not sampIsDialogActive() and not sampIsChatInputActive() then
					sampSendSystemChat(gsub(getEditByCode("hotkey_b.b7", 1)))
				end

				if isKeyDown(VK_B) and isKeyJustPressed(VK_8) and _G.mass[mkey] and im.informer.infMainHotBbool.v and not sampIsDialogActive() and not sampIsChatInputActive() then
					sampSendSystemChat(gsub(getEditByCode("hotkey_b.b8", 1)))
				end

				if isKeyDown(VK_B) and isKeyJustPressed(VK_9) and _G.mass[mkey] and im.informer.infMainHotBbool.v then
					sampSendSystemChat(gsub(getEditByCode("hotkey_b.b9", 1)))
				end

				if isKeyDown(VK_B) and isKeyJustPressed(VK_0) and _G.mass[mkey] and im.informer.infMainHotBbool.v and not sampIsDialogActive() and not sampIsChatInputActive() then
					sampSendSystemChat(gsub(getEditByCode("hotkey_b.b0", 1)))
				end

				local var_231_235, var_231_236 = getCharPlayerIsTargeting(playerHandle)

				if var_231_235 and se.main.help_st and not isCharDead(playerPed) and not hotKeyZ and not hotKeyB and not hotKeyX and not sampIsDialogActive() and not sampIsChatInputActive() and _G.mass[mkey] and (isCurrentCharWeapon(playerPed, 0) or isCurrentCharWeapon(playerPed, 3) or isCurrentCharWeapon(playerPed, 1)) then
					if se.main.hotTarX == 0 and se.main.hotTarY == 0 then
						local var_231_237 = 500

						for iter_231_33 = 1, #hotTarget do
							local var_231_238 = hotTarget[iter_231_33]

							if hotTarget[iter_231_33]:find(" - ������� �����") then
								local var_231_239, var_231_240, var_231_241 = getCharCoordinates(var_231_236)
								local var_231_242, var_231_243, var_231_244 = getCharCoordinates(playerPed)
								local var_231_245 = getDistanceBetweenCoords3d(var_231_239, var_231_240, var_231_241,
									var_231_242, var_231_243, var_231_244)

								var_231_238 = hotTarget[iter_231_33] ..
								" " .. (var_231_245 < 1.5 and "{00FF00}�����" or "{FF0000}������")
							end

							renderFontDrawText(var_0_27, var_231_238, 500, var_231_237, 4294967295)

							var_231_237 = var_231_237 + 17
						end
					else
						local var_231_246 = se.main.hotTarX
						local var_231_247 = se.main.hotTarY

						for iter_231_34 = 1, #hotTarget do
							local var_231_248 = hotTarget[iter_231_34]

							if hotTarget[iter_231_34]:find(" - ������� �����") then
								local var_231_249, var_231_250, var_231_251 = getCharCoordinates(var_231_236)
								local var_231_252, var_231_253, var_231_254 = getCharCoordinates(playerPed)
								local var_231_255 = getDistanceBetweenCoords3d(var_231_249, var_231_250, var_231_251,
									var_231_252, var_231_253, var_231_254)

								var_231_248 = hotTarget[iter_231_34] ..
								" " .. (var_231_255 < 1.5 and "{00FF00}�����" or "{FF0000}������")
							end

							renderFontDrawText(var_0_27, var_231_248, var_231_246, var_231_247, 4294967295)

							var_231_247 = var_231_247 + 17
						end
					end
				end

				if var_231_235 and doesCharExist(var_231_236) and isKeyJustPressed(VK_J) and not sampIsDialogActive() and not sampIsChatInputActive() then
					local var_231_256, var_231_257 = sampGetPlayerIdByCharHandle(var_231_236)

					if sampIsPlayerConnected(var_231_257) then
						hpID = var_231_257
						hpHandle = var_231_236
					end

					hpStatus = true
				end

				if not var_231_235 and isKeyJustPressed(VK_J) then
					hpID, hpStatus = nil, false
				end

				if var_231_235 and isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.target_mask))) and _G.mass[mkey] and not sampIsDialogActive() and not sampIsChatInputActive() then
					local var_231_258, var_231_259 = sampGetPlayerIdByCharHandle(var_231_236)

					if var_231_258 then
						member_state = true
						Nid = var_231_259
						Nnick = sampGetPlayerNickname(Nid)

						sampSendSystemChat(
						gsub(getEditByCode("hottarget.unmask", 1)):gsub("{name}", Nnick:gsub("_", " ")), 1)
						awaitSendChat("/unmask " .. tostring(var_231_259), 1, 1000, false)
					end
				end

				if var_231_235 and isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.target_ticket))) and _G.mass[mkey] and not sampIsDialogActive() and not sampIsChatInputActive() then
					local var_231_260, var_231_261 = sampGetPlayerIdByCharHandle(var_231_236)

					if var_231_260 then
						ticket_id = var_231_261
						ticket_name = sampGetPlayerNickname(var_231_261):gsub("_", " ")
						ticket_lvl = sampGetPlayerScore(var_231_261)

						local var_231_262 = tickets(ticket_lvl)

						tickforcom = {}

						if var_231_262 then
							table.sort(var_231_262, function(arg_318_0, arg_318_1)
								return arg_318_0[1] < arg_318_1[1]
							end)

							ticksfortab = {}

							for iter_231_35, iter_231_36 in pairs(var_231_262) do
								table.insert(ticksfortab,
									"�" .. iter_231_36[1] .. "\t" .. iter_231_36[2] .. "\t" .. iter_231_36[3])
								table.insert(tickforcom,
									iter_231_36[3] .. " ������ �" .. iter_231_36[1] .. " �" .. iter_231_36[2] .. "�")
							end

							sampShowDialog(8729, "{FFFFFF}����� �� ��� " .. ticket_name .. ", �������� " .. ticket_lvl,
								"����� ������\t�������� ������\t������ ������\n" .. table.concat(ticksfortab, "\n"),
								"��������", "�������", 5)
						end
					end
				end

				if var_231_235 and isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.target_ps))) and _G.mass[mkey] and not sampIsDialogActive() and not sampIsChatInputActive() then
					local var_231_263, var_231_264 = sampGetPlayerIdByCharHandle(var_231_236)

					if var_231_263 then
						sampSendChat("/ps " .. var_231_264)
					end
				end

				if var_231_235 and isKeyDown(var_0_6.name_to_id("]")) and _G.mass[mkey] and not sampIsDialogActive() and not sampIsChatInputActive() then
					local var_231_265, var_231_266 = sampGetPlayerIdByCharHandle(var_231_236)

					if var_231_265 and not member_state then
						member_state = true
						Nid = var_231_266
						cHandle = var_231_236
						Nnick = sampGetPlayerNickname(Nid)

						sampSendChat("/members 1")
					elseif not var_231_265 or var_231_236 ~= cHandle then
						member_state = false
						rangn = nil
						nrang = nil
					elseif member_state and rangn ~= nil and n_rang ~= nil then
						renderFontDrawText(var_0_26,
							Nnick .. " - " .. rangn:gsub("%[%]%s+", "") .. "[" .. n_rang:gsub("%[%d%]%s+", "") .. "]",
							var_0_94 * 0.7, var_0_95 / 2, 4294967295)
					end
				end

				if var_231_235 and isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.target_cuff))) and not isCharDead(playerPed) and _G.mass[mkey] and not sampIsDialogActive() and not sampIsChatInputActive() then
					local var_231_267, var_231_268 = sampGetPlayerIdByCharHandle(var_231_236)

					if var_231_267 then
						local var_231_269 = var_231_268
						local var_231_270 = sampGetPlayerNickname(var_231_269):gsub("_", " ")

						sampSendSystemChat(gsub(getEditByCode("hottarget.cuff", 1)):gsub("{name}", var_231_270))
						wait(p(500))
						sampSendChat("/cuff " .. var_231_269)
					end
				end

				if var_231_235 and isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.interplay))) and _G.mass[mkey] and not sampIsDialogActive() and not sampIsChatInputActive() and (isCurrentCharWeapon(playerPed, 0) or isCurrentCharWeapon(playerPed, 3)) then
					local var_231_271, var_231_272 = sampGetPlayerIdByCharHandle(var_231_236)

					inpID = var_231_272
					inpName = sampGetPlayerNickname(inpID)

					sampShowDialog(6090, "�������� ��������������",
						"[0] ������ ����\n[1] �������� ������� � ��������\n[2] �������� �����\n[3] ���� � ������� (��������� ���������)\n[4] �������� ������� ������\n[5] �������� ����� ��������\n[6] �������� ���. �����\n[7] ������/������� �������\n[8] ����������",
						"�������", "�������", 2)
				end

				local var_231_273, var_231_274, var_231_275, var_231_276 = sampHasDialogRespond(6090)

				if var_231_273 and var_231_274 == 1 and _G.mass[mkey] then
					if var_231_275 == 0 then
						if inpID and inpName then
							if im.informer.infMainSex.v then
								lua_thread.create(function()
									sampSendChat("/me �������� ���� " .. inpName:gsub("_", " ") .. " ��� �����������.")
									wait(1200)
									sampSendChat("/hi " .. inpID)
								end)
							else
								lua_thread.create(function()
									sampSendChat("/me ��������� ���� " .. inpName:gsub("_", " ") .. " ��� �����������.")
									wait(1200)
									sampSendChat("/hi " .. inpID)
								end)
							end
						else
							am("�� �������� ������ �� ������, ��������� �������.")
						end
					elseif var_231_275 == 1 then
						if inpID and inpName then
							if im.informer.infMainSex.v then
								sampSendChat("/me �������� " .. inpName:gsub("_", " ") .. " ����� ������� � ��������.")
							else
								sampSendChat("/me ��������� " .. inpName:gsub("_", " ") .. " ����� ������� � ��������.")
							end

							sampSetChatInputText("/pay " .. inpID .. " ")
							sampSetChatInputEnabled(true)
						else
							am("�� �������� ������ �� ������, ��������� �������.")
						end
					elseif var_231_275 == 2 then
						if inpID and inpName then
							if im.informer.infMainSex.v then
								sampSendChat("/me ������ ��-�� ����� ����� ������ � �������� " ..
								inpName:gsub("_", " ") .. ".")
							else
								sampSendChat("/me ������� ��-�� ����� ����� ������ � ��������� " ..
								inpName:gsub("_", " ") .. ".")
							end
						else
							am("�� �������� ������ �� ������, ��������� �������.")
						end
					elseif var_231_275 == 3 then
						if inpID and inpName then
							inpNameG = inpName:gsub("_", " ")
							tryMes = {
								"/try ������ ��������� �������� ��������� � ��������� � " .. inpNameG,
								"/try �������� ��� � ������ � " .. inpNameG,
								"/try ������ RPG-400 �, ������� ���, ��������� � " .. inpNameG,
								"/try ������ ������ �, ��������������, ���� ������ " .. inpNameG,
								"/try ������� ������ " .. inpNameG,
								"/try ������� �������� � ����� ����� � " .. inpNameG,
								"/try ������ �������� � " .. inpNameG .. " � ����� � ����"
							}
							ind = math.random(1, #tryMes)

							sampSendChat(tryMes[ind])
						else
							am("�� �������� ������ �� ������, ��������� �������.")
						end
					elseif var_231_275 == 4 then
						if inpID and inpName then
							lua_thread.create(function()
								sampSendChat("/me " ..
								(im.informer.infMainSex.v and "������" or "�������") .. " ������� �� ����������� �������")
								wait(1000)
								sampSendChat("/showpass " .. inpID)
							end)
						end
					elseif var_231_275 == 5 then
						if inpID and inpName then
							lua_thread.create(function()
								sampSendChat("/me " ..
								(im.informer.infMainSex.v and "������" or "�������") ..
								" �������� �� ������� ������� � " ..
								(im.informer.infMainSex.v and "��������" or "��������� ��") ..
								" " .. inpName:gsub("_", " "))
								wait(1000)
								sampSendChat("/showlicenses " .. inpID)
							end)
						end
					elseif var_231_275 == 6 then
						if inpID and inpName then
							lua_thread.create(function()
								sampSendChat("/me " ..
								(im.informer.infMainSex.v and "������" or "�������") ..
								" ���.����� � " ..
								(im.informer.infMainSex.v and "��������" or "��������� ��") ..
								" " .. inpName:gsub("_", " "))
								wait(1000)
								sampSendChat("/showmc " .. inpID)
							end)
						end
					elseif var_231_275 == 7 then
						if inpID and inpName then
							sampSendChat("/givecopkeys " .. inpID)
						end
					elseif var_231_275 == 8 and inpID and inpName then
						lua_thread.create(function()
							sampSendChat("/me " ..
							(im.informer.infMainSex.v and "������" or "�������") ..
							" ���������� � " ..
							(im.informer.infMainSex.v and "��������" or "��������� ��") .. " " .. inpName:gsub("_", " "))
							wait(1000)
							sampSendChat("/bh " .. inpID)
						end)
					end
				end

				local var_231_277, var_231_278, var_231_279, var_231_280 = sampHasDialogRespond(8729)

				if var_231_277 and var_231_278 == 1 and _G.mass[mkey] and var_231_279 then
					as.ticket.f.sname = tickforcom[var_231_279 + 1]:match("%d+%s(.*)")
					as.ticket.f.sum = tickforcom[var_231_279 + 1]:match("(%d+)%s.*")

					sampShowDialog(8730, "{FFFFFF}�������� ��������",
						"[0] �������� �����\n[1] �������� ������ ��������� � �����\n[2] �������� ������ ��������� ��� ����\n[3] ������� �����",
						"Ok", "Cancel", 2)
				end

				local var_231_281, var_231_282, var_231_283, var_231_284 = sampHasDialogRespond(8730)

				if var_231_281 and var_231_282 == 1 then
					if var_231_283 == 0 then
						lua_thread.create(function()
							if im.informer.infMainSex.v then
								sampSendChat("/me ������ ����� ��������� ������ � �����")
								wait(1200)
								sampSendChat("/me �������� ����� ��������� �� ��� " .. ticket_name)
								wait(1200)
								sampSendChat("/me ���� ������ \"" .. as.ticket.f.sname .. "\"")
								wait(1200)
							else
								sampSendChat("/me ������� ����� ��������� ������ � �����")
								wait(1200)
								sampSendChat("/me ��������� ����� ��������� �� ��� " .. ticket_name)
								wait(1200)
								sampSendChat("/me ������ ������ \"" .. as.ticket.f.sname .. "\"")
								wait(1200)
							end

							sampSendChat("/ticket " .. ticket_id .. " " .. as.ticket.f.sum .. " " .. as.ticket.f.sname)
						end)
					elseif var_231_283 == 1 then
						sampSendChat("�� �������� ������ " ..
						as.ticket.f.sname:gsub("������ ", "") .. ". ����� " .. as.ticket.f.sum .. " �.")
					elseif var_231_283 == 2 then
						sampSendChat("�� �������� ������ " .. as.ticket.f.sname:gsub("������ ", "") .. ".")
					elseif var_231_283 == 3 then
						sampShowDialog(8731, "{FFFFFF}�������� ������ ������ ������",
							"����� ������\t�������� ������\t������ ������\n" .. table.concat(ticksfortab, "\n"),
							"��������", "�������", 5)
					end
				end

				local var_231_285, var_231_286, var_231_287, var_231_288 = sampHasDialogRespond(8731)

				if var_231_285 and var_231_286 == 1 and _G.mass[mkey] and var_231_287 then
					as.ticket.s.sname = tickforcom[var_231_287 + 1]:match("%d+%s(.*)")
					as.ticket.s.sum = tickforcom[var_231_287 + 1]:match("(%d+)%s.*")

					sampShowDialog(8732, "{FFFFFF}�������� ��������",
						"[0] �������� �����\n[1] �������� ������ ��������� � �����\n[2] �������� ������ ��������� ��� ����",
						"Ok", "Cancel", 2)
				end

				local var_231_289, var_231_290, var_231_291, var_231_292 = sampHasDialogRespond(8732)

				if var_231_289 and var_231_290 == 1 then
					if var_231_291 == 0 then
						double_ticket_sname = "��. " ..
						as.ticket.f.sname:match("������ (�%d+).*") ..
						" � ��. " ..
						as.ticket.s.sname:match("������ (�%d+).*") ..
						((srv_name == "revolution" or srv_name == "underground") and " ��" or "")
						double_ticket_sname_full = "������ " ..
						as.ticket.f.sname:gsub("������ ", "") ..
						" � " ..
						as.ticket.s.sname:gsub("������ ", "") ..
						((srv_name == "revolution" or srv_name == "underground") and " ��" or "")
						double_ticket_sum = tonumber(as.ticket.f.sum) + tonumber(as.ticket.s.sum)

						lua_thread.create(function()
							if im.informer.infMainSex.v then
								sampSendChat("/me ������ ����� ��������� ������ � �����")
								wait(1200)
								sampSendChat("/me �������� ����� ��������� �� ��� " .. ticket_name)
								wait(1200)
								sampSendChat("/me ���� ������ \"" .. double_ticket_sname .. "\"")
								wait(1200)
							else
								sampSendChat("/me ������� ����� ��������� ������ � �����")
								wait(1200)
								sampSendChat("/me ��������� ����� ��������� �� ��� " .. ticket_name)
								wait(1200)
								sampSendChat("/me ������ ������ \"" .. double_ticket_sname .. "\"")
								wait(1200)
							end

							sampSendChat("/ticket " ..
							ticket_id .. " " .. double_ticket_sum .. " " .. double_ticket_sname)
						end)
					elseif var_231_291 == 1 then
						double_ticket_sname = "��. " ..
						as.ticket.f.sname:match("������ (�%d+).*") ..
						" � ��. " ..
						as.ticket.s.sname:match("������ (�%d+).*") ..
						((srv_name == "revolution" or srv_name == "underground") and " ��" or "")
						double_ticket_sname_full = "������ " ..
						as.ticket.f.sname:gsub("������ ", "") ..
						" � " ..
						as.ticket.s.sname:gsub("������ ", "") ..
						((srv_name == "revolution" or srv_name == "underground") and " ��" or "")
						double_ticket_sum = tonumber(as.ticket.f.sum) + tonumber(as.ticket.s.sum)

						sampSendChat("�� �������� " ..
						double_ticket_sname_full .. ". ����� " .. double_ticket_sum .. " �.")
					elseif var_231_291 == 2 then
						double_ticket_sname = "��. " ..
						as.ticket.f.sname:match("������ (�%d+).*") ..
						" � ��. " ..
						as.ticket.s.sname:match("������ (�%d+).*") ..
						((srv_name == "revolution" or srv_name == "underground") and " ��" or "")
						double_ticket_sname_full = "������ " ..
						as.ticket.f.sname:gsub("������ ", "") ..
						" � " ..
						as.ticket.s.sname:gsub("������ ", "") ..
						((srv_name == "revolution" or srv_name == "underground") and " ��" or "")
						double_ticket_sum = tonumber(as.ticket.f.sum) + tonumber(as.ticket.s.sum)

						sampSendChat("�� �������� " .. double_ticket_sname_full .. ".")
					end
				end

				if var_231_235 and isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.target_oop))) and not isCharDead(playerPed) and _G.mass[mkey] and not sampIsDialogActive() and not sampIsChatInputActive() then
					if srv_name == "revolution" or srv_name == "underground" then
						local var_231_293, var_231_294 = sampGetPlayerIdByCharHandle(var_231_236)

						if var_231_293 then
							qsId = var_231_294
							qsNick = sampGetPlayerNickname(qsId):gsub("_", " ")
							qReason = "0"

							if qReason == "0" then
								sampShowDialog(99, "��", "{7B68EE}|{FFFFFF}������� ������� ��� [��-�: 2.1]\n��", "��", "",
									1)
							end
						end
					end

					if srv_name == "legacy" then
						local var_231_295, var_231_296 = sampGetPlayerIdByCharHandle(var_231_236)

						if var_231_295 then
							qsId = var_231_296
							qsNick = sampGetPlayerNickname(qsId):gsub("_", " ")

							sampSendChat(string.format("/dep Mayor, ��. ���� �%d \"%s\" �� �������� ������������ - ���.",
								qsId, qsNick))
						end
					end

					if srv_name == "evolve" then
						local var_231_297, var_231_298 = sampGetPlayerIdByCharHandle(var_231_236)

						if var_231_297 then
							qsId = var_231_298
							qsNick = sampGetPlayerNickname(qsId):gsub("_", " ")

							sampSendChat(string.format("/dep Mayor, ��. ���� �%d \"%s\" �� �������� ������������ - ���.",
								qsId, qsNick))
						end
					end
				end

				local var_231_299, var_231_300, var_231_301, var_231_302 = sampHasDialogRespond(99)

				if var_231_299 and _G.mass[mkey] and #var_231_302 ~= 0 then
					qReason = var_231_302

					if qsId ~= nil and qsNick ~= nil and qReason ~= nil then
						sampSendChat(string.format("/dep Mayor, ��. ���� �%d \"%s\" �� �������� ������������ - ��� [%s]",
							qsId, qsNick, qReason))
					end
				end

				if var_231_235 and isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.target_uncuff))) and not isCharDead(playerPed) and _G.mass[mkey] and not sampIsDialogActive() and not sampIsChatInputActive() and (isCurrentCharWeapon(playerPed, 0) or isCurrentCharWeapon(playerPed, 3)) then
					local var_231_303, var_231_304 = sampGetPlayerIdByCharHandle(var_231_236)

					if var_231_303 then
						local var_231_305 = var_231_304
						local var_231_306 = sampGetPlayerNickname(var_231_305):gsub("_", " ")

						sampSendSystemChat(gsub(getEditByCode("hottarget.uncuff", 1)):gsub("{name}", var_231_306))
						wait(p(1000))
						sampSendChat("/uncuff " .. var_231_305)
					end
				end

				if var_231_235 and isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.target_frisk))) and not isCharDead(playerPed) and _G.mass[mkey] and not sampIsDialogActive() and not sampIsChatInputActive() and (isCurrentCharWeapon(playerPed, 0) or isCurrentCharWeapon(playerPed, 3)) then
					local var_231_307, var_231_308 = sampGetPlayerIdByCharHandle(var_231_236)

					if var_231_307 then
						local var_231_309 = var_231_308
						local var_231_310 = sampGetPlayerNickname(var_231_308):gsub("_", " ")
						local var_231_311 = isInJail(var_231_236)

						sampSendSystemChat(gsub(getEditByCode("hottarget.frisk", 1)):gsub("{name}", var_231_310))

						if im.informer.infMainSex.v then
							wait(p(1000))

							if checkKpzObject() and var_231_311 then
								sampSendChat(im.informer.infMainSex.v == true and
								"/me ������ ���� �� ������, ������ �� � ����� � ������." or
								"/me ������� ���� �� ������, ������� �� � ����� � ������.")
								wait(p(1000))
							end
						else
							wait(p(1000))

							if checkKpzObject() and var_231_311 then
								sampSendChat(im.informer.infMainSex.v == true and
								"/me ������ ���� �� ������, ������ �� � ����� � ������." or
								"/me ������� ���� �� ������, ������� �� � ����� � ������.")
								wait(p(1000))
							end
						end

						sampSendSystemChat(gsub(getEditByCode("hottarget.frisk", 2)):gsub("{name}", var_231_310))
						sampSetChatInputEnabled(true)
						sampSetChatInputText("/frisk " .. var_231_309)

						as.other.frisk_start, as.other.frisk_jail = true, var_231_311
					end
				end

				if var_231_235 and isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.target_follow))) and not isCharDead(playerPed) and _G.mass[mkey] and not sampIsDialogActive() and not sampIsChatInputActive() and (isCurrentCharWeapon(playerPed, 0) or isCurrentCharWeapon(playerPed, 3) and _G.mass[mkey]) then
					local var_231_312, var_231_313 = sampGetPlayerIdByCharHandle(var_231_236)

					if var_231_312 then
						local var_231_314 = var_231_313

						as.other.followNick = sampGetPlayerNickname(var_231_314):gsub("_", " ")

						sampSendChat("/follow " .. var_231_314)
					end
				end

				if var_231_235 and isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.target_cput))) and not isCharDead(playerPed) and _G.mass[mkey] and not sampIsDialogActive() and not sampIsChatInputActive() and (isCurrentCharWeapon(playerPed, 0) or isCurrentCharWeapon(playerPed, 3) and _G.mass[mkey]) then
					local var_231_315, var_231_316 = sampGetPlayerIdByCharHandle(var_231_236)

					if var_231_315 then
						local var_231_317 = var_231_316
						local var_231_318 = sampGetPlayerNickname(var_231_317):gsub("_", " ")

						sampSendSystemChat(gsub(getEditByCode("hottarget.cput", 1)):gsub("{name}", var_231_318))
						wait(p(500))
						sampSendSystemChat(gsub(getEditByCode("hottarget.cput", 2)):gsub("{name}", var_231_318))
						wait(p(500))
						sampSendChat("/cput " .. var_231_317)
					end
				end

				if var_231_235 and isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.target_arrest))) and not isCharDead(playerPed) and not sampIsDialogActive() and not sampIsChatInputActive() and (isCurrentCharWeapon(playerPed, 0) or isCurrentCharWeapon(playerPed, 3) and _G.mass[mkey]) then
					local var_231_319, var_231_320 = sampGetPlayerIdByCharHandle(var_231_236)

					if var_231_319 then
						local var_231_321 = var_231_320
						local var_231_322 = sampGetPlayerNickname(var_231_321):gsub("_", " ")

						if im.informer.infMainSex.v then
							sampSendSystemChat("/me ������ ������ ������ � ������������ �����.")
							wait(p(1000))
							sampSendSystemChat("/me ������� ���� � ����� � ������ ������.")
							wait(p(1000))
							sampSendSystemChat("/me ���� ��������� � " .. var_231_322 .. " � ������ ��� � ������.")
							wait(p(1000))
							sampSendSystemChat("/me ��������� ��������� ������ ������ �� ������.")
						else
							sampSendSystemChat("/me ������� ������ ������ � ������������ �����.")
							wait(p(1000))
							sampSendSystemChat("/me �������� ���� � ����� � ������� ������.")
							wait(p(1000))
							sampSendSystemChat("/me ����� ��������� � " .. var_231_322 .. " � ������� ��� � ������.")
							wait(p(1000))
							sampSendSystemChat("/me ��������� ��������� ������� ������ �� ������.")
						end

						wait(p(1000))
						sampSendChat("/arrest " .. var_231_321)
					end
				end

				if var_231_235 and isKeyJustPressed(VK_R) and not isCharDead(playerPed) and _G.mass[mkey] and not sampIsDialogActive() and not sampIsChatInputActive() and (isCurrentCharWeapon(playerPed, 0) or isCurrentCharWeapon(playerPed, 3) and _G.mass[mkey]) then
					local var_231_323, var_231_324 = sampGetPlayerIdByCharHandle(var_231_236)

					if var_231_323 then
						local var_231_325 = var_231_324
						local var_231_326 = sampGetPlayerNickname(var_231_325):gsub("_", " ")

						if im.informer.infMainSex.v then
							sampSendChat("/me ������ ����� ������� � ������� �� ������� " .. var_231_326 .. ".")
						else
							sampSendChat("/me ������� ����� ������� � �������� �� ������� " .. var_231_326 .. ".")
						end

						wait(p(500))
						sampSendChat("/ceject " .. var_231_325)
					end
				end

				if var_231_235 and isKeyJustPressed(var_0_6.name_to_id(tostring(se.keys.target_su))) and not isCharDead(playerPed) and _G.mass[mkey] and not sampIsDialogActive() and not sampIsChatInputActive() then
					local var_231_327, var_231_328 = sampGetPlayerIdByCharHandle(var_231_236)

					if var_231_327 then
						sstab = {}

						for iter_231_37 = 1, 100 do
							if sud.a[iter_231_37] and #sud.a[iter_231_37] > 0 then
								table.insert(sstab,
									sud.d[iter_231_37] ..
									sud.a[iter_231_37] ..
									"\t" ..
									sud.d[iter_231_37] ..
									sud.b[iter_231_37] .. "\t" .. sud.d[iter_231_37] .. sud.c[iter_231_37])
							end
						end

						qqId = var_231_328
						qqNick = sampGetPlayerNickname(qqId):gsub("_", " ")

						sampShowDialog(187, "������ � ������ ������ " .. qqNick,
							"������\t�������� ������\t������� �������\n�������� ������\t\t\n" ..
							table.concat(sstab, "\n"), "�������", "�������", 5)
					end
				end

				local var_231_329, var_231_330, var_231_331, var_231_332 = sampHasDialogRespond(187)

				if var_231_329 and var_231_330 == 1 then
					if var_231_331 ~= nil and var_231_331 ~= 0 then
						if sud.a[var_231_331] ~= nil and sud.b[var_231_331] ~= nil and sud.c[var_231_331] ~= nil then
							if im.settings.suNumber.v then
								_G.sampAddChatMessage(
								"| {FFFFFF}�� ������ � ������ {7B68EE}" ..
								qqNick ..
								"{FFFFFF} �� ������� {7B68EE}" ..
								sud.a[var_231_331] .. " \"" .. sud.b[var_231_331] .. "\"{FFFFFF}.", clr)
								sampSendSystemChat("/su " ..
								qqId ..
								" " ..
								sud.c[var_231_331] .. " " .. sud.a[var_231_331] .. " \"" .. sud.b[var_231_331] .. "\"")

								qqNick, qqId = nil
							else
								_G.sampAddChatMessage(
								"| {FFFFFF}�� ������ � ������ {7B68EE}" ..
								qqNick ..
								"{FFFFFF} �� ������� {7B68EE}" ..
								sud.a[var_231_331] .. " \"" .. sud.b[var_231_331] .. "\"{FFFFFF}.", clr)
								sampSendSystemChat("/su " ..
								qqId .. " " .. sud.c[var_231_331] .. " " .. sud.b[var_231_331] .. "")

								qqNick, qqId = nil
							end
						else
							chat("��������� ������ �� ������� ���� ���� ������� ������� ����������� ������.")
						end
					end

					if var_231_329 and var_231_330 == 0 then
						qqId, qqNick = nil
					end
				end

				if se.main.tazer and active then
					if mouseCoord2 then
						showCursor(true, true)

						tazX, tazY = getCursorPos()

						if isKeyDown(VK_RETURN) then
							se.main.tazX = math.floor(tazX)
							se.main.tazY = math.floor(tazY)
							mouseCoord2 = false

							showCursor(false, false)
						end
					end

					sampTextdrawCreate(1, "TAZER:", tazX, tazY)
					sampTextdrawSetOutlineColor(1, 1, -16777216)
					sampTextdrawSetLetterSizeAndColor(1, 0.3, 1.6, -1)
					sampTextdrawSetStyle(1, 2)
					sampTextdrawCreate(2, "" .. tazer_state .. "", tazX + 46, tazY)
					sampTextdrawSetOutlineColor(2, 1, -16777216)

					if tazer_state == "ON" then
						sampTextdrawSetLetterSizeAndColor(2, 0.3, 1.6, 2858002005)
					else
						sampTextdrawSetLetterSizeAndColor(2, 0.3, 1.6, 2868838400)
					end

					sampTextdrawSetStyle(2, 2)
				else
					sampTextdrawDelete(1)
					sampTextdrawDelete(2)
				end

				if im.informer.infState.v then
					if _G.mass[mkey] then
						var_0_43.v = true
					end

					if mouseCoord then
						showCursor(true, true)

						infoX, infoY = getCursorPos()

						if isKeyDown(VK_RETURN) then
							se.informer.infoX = math.floor(infoX)
							se.informer.infoY = math.floor(infoY)
							mouseCoord = false

							showCursor(false, false)
						end
					end
				else
					var_0_43.v = false
				end

				if reaver and #as.other.miclist > 0 then
					for iter_231_38, iter_231_39 in pairs(as.other.miclist) do
						if iter_231_39 and ms > 1000 + sampGetPlayerPing(myID) then
							sampSendSystemChat(iter_231_39)
							table.remove(as.other.miclist, iter_231_38)
						end
					end
				end
			end
		end
	end
end

function getMyPartner()
	if se.main.partner == nil or se.main.partner == "" then
		return "-"
	end

	if not se.main.partner:find("%s") and se.main.partner:find("%d+") then
		local var_327_0 = se.main.partner:match("(%d+)")

		if var_327_0 and sampIsPlayerConnected(tonumber(var_327_0)) then
			return sampGetPlayerNickname(tonumber(var_327_0)):gsub("_", " ")
		end
	end

	if se.main.partner:find("%d+%s+%d+") then
		local var_327_1 = se.main.partner:match("^(%d+)%s")
		local var_327_2 = se.main.partner:match("^%d+%s(%d+)$")

		if var_327_2 == nil then
			var_327_2 = se.main.partner:match("^%d+%s(%d+)%s")
		end

		local var_327_3 = se.main.partner:match("^%d+%s%d+%s(%d+)$")
		local var_327_4 = ""

		if var_327_1 ~= nil and sampIsPlayerConnected(tonumber(var_327_1)) then
			local var_327_5 = sampGetPlayerNickname(tonumber(var_327_1))
			local var_327_6 = var_327_5:match("^(%u)%a+%_%a+") .. "." .. var_327_5:match("%a+%_(%a+)")

			if var_327_4 == "" then
				var_327_4 = var_327_6
			else
				var_327_4 = var_327_4 .. ", " .. var_327_6
			end
		end

		if var_327_2 ~= nil and sampIsPlayerConnected(tonumber(var_327_2)) then
			local var_327_7 = sampGetPlayerNickname(tonumber(var_327_2))
			local var_327_8 = var_327_7:match("^(%u)%a+%_%a+") .. "." .. var_327_7:match("%a+%_(%a+)")

			if var_327_4 == "" then
				var_327_4 = var_327_8
			else
				var_327_4 = var_327_4 .. ", " .. var_327_8
			end
		end

		if var_327_3 ~= nil and sampIsPlayerConnected(tonumber(var_327_3)) then
			local var_327_9 = sampGetPlayerNickname(tonumber(var_327_3))
			local var_327_10 = var_327_9:match("^(%u)%a+%_%a+") .. "." .. var_327_9:match("%a+%_(%a+)")

			if var_327_4 == "" then
				var_327_4 = var_327_10
			else
				var_327_4 = var_327_4 .. ", " .. var_327_10
			end
		end

		return var_327_4 ~= "" and var_327_4 or se.main.partner
	end

	return se.main.partner
end

function awaitSendChat(arg_328_0, arg_328_1, arg_328_2, arg_328_3, arg_328_4)
	if arg_328_4 == nil then
		arg_328_4 = false
	end

	as.sendchat[#as.sendchat + 1] = {
		text = arg_328_0,
		type = arg_328_1,
		wait = arg_328_2,
		time = os.time(),
		isjson = arg_328_3,
		ignore = arg_328_4
	}
end

function numberPlate(arg_329_0)
	local var_329_0 = tonumber(arg_329_0)

	if var_329_0 == 0 then
		return "SA-000"
	end

	if math.numbs(var_329_0) == 1 then
		return "SA-00" .. tostring(var_329_0)
	elseif math.numbs(var_329_0) == 2 then
		return "SA-0" .. tostring(var_329_0)
	elseif math.numbs(var_329_0) == 3 then
		return "SA-" .. tostring(var_329_0)
	end

	return "SA-" .. tostring(var_329_0)
end

function tickets(arg_330_0)
	local var_330_0 = {}
	local var_330_1 = ""
	local var_330_2 = ""
	local var_330_3 = ""

	for iter_330_0, iter_330_1 in pairs(alltickets[getSrv()]) do
		for iter_330_2, iter_330_3 in pairs(iter_330_1) do
			var_330_1 = iter_330_1[1]
			var_330_2 = iter_330_1[2]
			var_330_3 = ""

			for iter_330_4, iter_330_5 in pairs(iter_330_1[3]) do
				if tostring(iter_330_4):find("%{plus%}") then
					iter_330_4 = tostring(iter_330_4):gsub("{plus}", "+")
				end

				if tostring(iter_330_4):find("%-") or tostring(iter_330_4):find("%+") then
					if tostring(iter_330_4):find("%-") then
						local var_330_4, var_330_5 = tostring(iter_330_4):match("(%d+)%-(%d+)")

						if var_330_4 and var_330_5 and tonumber(arg_330_0) >= tonumber(var_330_4) and tonumber(arg_330_0) <= tonumber(var_330_5) then
							var_330_3 = iter_330_5
						end
					end

					if tostring(iter_330_4):find("%+") then
						local var_330_6 = tostring(iter_330_4):match("(%d+)%+")

						if var_330_6 and tonumber(arg_330_0) >= tonumber(var_330_6) then
							var_330_3 = iter_330_5
						end
					end
				elseif tostring(iter_330_4):find("%d+") then
					local var_330_7 = tostring(iter_330_4):match("(%d+)")

					if var_330_7 and tonumber(var_330_7) == tonumber(arg_330_0) then
						var_330_3 = iter_330_5
					end
				end
			end
		end

		table.insert(var_330_0, {
			var_330_1,
			var_330_2,
			var_330_3
		})
	end

	return var_330_0
end

function math.numbs(arg_331_0)
	if arg_331_0 == nil then
		return 1
	end

	return math.floor(math.log10(arg_331_0)) + 1
end

function checkKpzObject()
	for iter_332_0, iter_332_1 in pairs(getAllObjects()) do
		model = getObjectModel(iter_332_1)

		if model == 19303 then
			return true
		end
	end

	return false
end

function dispatch(arg_333_0)
	_G.sampAddChatMessage(string.format(" ���������: %s", arg_333_0), 964989657)
end

function pchat(arg_334_0)
	_G.sampAddChatMessage("[PD-PROJECT] {FFFFFF}" .. (arg_334_0 and arg_334_0 or ""), clr)
end

function checkIntable(arg_335_0, arg_335_1)
	for iter_335_0, iter_335_1 in pairs(arg_335_0) do
		if iter_335_1 == arg_335_1 then
			return true
		end
	end

	return false
end

function isInJail(arg_336_0)
	if not doesCharExist(arg_336_0) then
		return false
	end

	local var_336_0, var_336_1, var_336_2 = getCharCoordinates(arg_336_0)
	local var_336_3 = {
		{
			"LSPD",
			236.41782836914,
			-12.696719360352,
			1500,
			241.4925567627,
			2.840186548233,
			1503
		},
		{
			"SFPD",
			233.86939697266,
			23.429005432129,
			1500,
			238.94374389648,
			42.236106109619,
			1503
		},
		{
			"LVPD",
			46.564457702637,
			-69.714343261719,
			1700,
			51.651171875,
			-59.02728729248,
			1703
		}
	}

	for iter_336_0, iter_336_1 in pairs(var_336_3) do
		if var_336_0 >= iter_336_1[2] and var_336_1 >= iter_336_1[3] and var_336_2 >= iter_336_1[4] and var_336_0 <= iter_336_1[5] and var_336_1 <= iter_336_1[6] and var_336_2 <= iter_336_1[7] then
			return true
		end
	end

	return false
end

function getPayCheck()
	lua_thread.create(function()
		while true do
			wait(0)

			if im.informer.infZp.v and sampGetGamestate() == 3 and ms ~= nil then
				paycheck_state = true

				while paycheck_state do
					wait(3000)

					while reaver do
						wait(0)
					end

					while defusing_proccess or aid_proccess do
						wait(0)
					end

					while ms < 1000 + sampGetPlayerPing(myID) do
						wait(0)
					end

					if paycheck_state then
						sampSendSystemChat("/paycheck")
					end

					wait(p(1000))
				end

				wait(300000)
			end
		end
	end)
end

function setWaypoint(arg_339_0)
	if arg_339_0:len() > 0 then
		removeWaypoint()

		if arg_339_0:find("%A%-%d+%-%d") then
			local var_339_0, var_339_1, var_339_2 = arg_339_0:match("(%A)%-(%d+)%-(%d)")

			if var_339_0 and var_339_1 and var_339_2 then
				local var_339_3 = {
					� = 15,
					� = 5,
					� = 7,
					� = 11,
					� = 16,
					� = 17,
					� = 6,
					� = 19,
					� = 2,
					� = 21,
					� = 8,
					� = 23,
					� = 1,
					� = 24,
					� = 14,
					� = 20,
					� = 13,
					� = 12,
					� = 18,
					� = 10,
					� = 4,
					� = 9,
					� = 22,
					� = 3
				}

				if var_339_3[var_339_0] ~= nil and tonumber(var_339_1) >= 1 and tonumber(var_339_1) <= 24 then
					local var_339_4 = 0
					local var_339_5 = 0
					local var_339_6 = tonumber(var_339_2)

					local function var_339_7(arg_340_0)
						return 27.7 * arg_340_0
					end

					if var_339_6 == 1 then
						var_339_4 = var_339_7(7.5)
						var_339_5 = var_339_7(1.5)
					elseif var_339_6 == 2 then
						var_339_4 = var_339_7(4.5)
						var_339_5 = var_339_7(1.5)
					elseif var_339_6 == 3 then
						var_339_4 = var_339_7(1.5)
						var_339_5 = var_339_7(1.5)
					elseif var_339_6 == 4 then
						var_339_4 = var_339_7(1.5)
						var_339_5 = var_339_7(4.5)
					elseif var_339_6 == 5 then
						var_339_4 = var_339_7(1.5)
						var_339_5 = var_339_7(7.5)
					elseif var_339_6 == 6 then
						var_339_4 = var_339_7(4.5)
						var_339_5 = var_339_7(7.5)
					elseif var_339_6 == 7 then
						var_339_4 = var_339_7(7.5)
						var_339_5 = var_339_7(7.5)
					elseif var_339_6 == 8 then
						var_339_4 = var_339_7(7.5)
						var_339_5 = var_339_7(4.5)
					elseif var_339_6 == 9 then
						var_339_4 = var_339_7(4.5)
						var_339_5 = var_339_7(4.5)
					end

					sY = tonumber(var_339_1) * 250 - 3000 - var_339_4
					sX = (tonumber(var_339_3[var_339_0] - 1) * 250 - 3000 + var_339_5) / -1

					placeWaypoint(sY, sX, 10)
					chat("������ ���������� �� ������� " .. arg_339_0 .. ".")
				else
					chat(
					"����� ���������� ������ �� ������ ����� (�� ������), ������� /spw [������]. ������: /spw �-4-2.")
				end
			else
				chat("����� ���������� ������ �� ������ ����� (�� ������), ������� /spw [������]. ������: /spw �-4-2.")
			end
		else
			local var_339_8, var_339_9 = arg_339_0:match("(%A)%-(%d+)")

			if var_339_8 and var_339_9 then
				local var_339_10 = {
					� = 15,
					� = 5,
					� = 7,
					� = 11,
					� = 16,
					� = 17,
					� = 6,
					� = 19,
					� = 2,
					� = 21,
					� = 8,
					� = 23,
					� = 1,
					� = 24,
					� = 14,
					� = 20,
					� = 13,
					� = 12,
					� = 18,
					� = 10,
					� = 4,
					� = 9,
					� = 22,
					� = 3
				}

				if var_339_10[var_339_8] ~= nil and tonumber(var_339_9) >= 1 and tonumber(var_339_9) <= 24 then
					sY = tonumber(var_339_9) * 250 - 3000 - 125
					sX = (tonumber(var_339_10[var_339_8] - 1) * 250 - 3000 + 125) / -1

					placeWaypoint(sY, sX, 10)
					chat("������ ���������� �� ������� " .. arg_339_0 .. ".")
				else
					chat("����� ���������� ������ �� ������ �����, ������� /spw [������]. ������: /spw �-4.")
				end
			else
				chat("����� ���������� ������ �� ������ �����, ������� /spw [������]. ������: /spw �-4.")
			end
		end
	else
		chat("����� ���������� ������ �� ������ �����, ������� /spw [������]. ������: /spw �-4 ��� /spw �-4-2.")
	end
end

function setWaypointPursuit(arg_341_0)
	if arg_341_0:len() > 0 then
		removeWaypoint()

		if arg_341_0:find("%A%-%d+%-%d") then
			local var_341_0, var_341_1, var_341_2 = arg_341_0:match("(%A)%-(%d+)%-(%d)")

			if var_341_0 and var_341_1 and var_341_2 then
				local var_341_3 = {
					� = 15,
					� = 5,
					� = 7,
					� = 11,
					� = 16,
					� = 17,
					� = 6,
					� = 19,
					� = 2,
					� = 21,
					� = 8,
					� = 23,
					� = 1,
					� = 24,
					� = 14,
					� = 20,
					� = 13,
					� = 12,
					� = 18,
					� = 10,
					� = 4,
					� = 9,
					� = 22,
					� = 3
				}

				if var_341_3[var_341_0] ~= nil and tonumber(var_341_1) >= 1 and tonumber(var_341_1) <= 24 then
					local var_341_4 = 0
					local var_341_5 = 0
					local var_341_6 = tonumber(var_341_2)

					local function var_341_7(arg_342_0)
						return 27.7 * arg_342_0
					end

					if var_341_6 == 1 then
						var_341_4 = var_341_7(7.5)
						var_341_5 = var_341_7(1.5)
					elseif var_341_6 == 2 then
						var_341_4 = var_341_7(4.5)
						var_341_5 = var_341_7(1.5)
					elseif var_341_6 == 3 then
						var_341_4 = var_341_7(1.5)
						var_341_5 = var_341_7(1.5)
					elseif var_341_6 == 4 then
						var_341_4 = var_341_7(1.5)
						var_341_5 = var_341_7(4.5)
					elseif var_341_6 == 5 then
						var_341_4 = var_341_7(1.5)
						var_341_5 = var_341_7(7.5)
					elseif var_341_6 == 6 then
						var_341_4 = var_341_7(4.5)
						var_341_5 = var_341_7(7.5)
					elseif var_341_6 == 7 then
						var_341_4 = var_341_7(7.5)
						var_341_5 = var_341_7(7.5)
					elseif var_341_6 == 8 then
						var_341_4 = var_341_7(7.5)
						var_341_5 = var_341_7(4.5)
					elseif var_341_6 == 9 then
						var_341_4 = var_341_7(4.5)
						var_341_5 = var_341_7(4.5)
					end

					sY = tonumber(var_341_1) * 250 - 3000 - var_341_4
					sX = (tonumber(var_341_3[var_341_0] - 1) * 250 - 3000 + var_341_5) / -1

					placeWaypoint(sY, sX, 10)
					printString("~y~UPDATE UNIT COORD " .. arg_341_0, 2500)
				end
			end
		else
			local var_341_8, var_341_9 = arg_341_0:match("(%A)%-(%d+)")

			if var_341_8 and var_341_9 then
				local var_341_10 = {
					� = 15,
					� = 5,
					� = 7,
					� = 11,
					� = 16,
					� = 17,
					� = 6,
					� = 19,
					� = 2,
					� = 21,
					� = 8,
					� = 23,
					� = 1,
					� = 24,
					� = 14,
					� = 20,
					� = 13,
					� = 12,
					� = 18,
					� = 10,
					� = 4,
					� = 9,
					� = 22,
					� = 3
				}

				if var_341_10[var_341_8] ~= nil and tonumber(var_341_9) >= 1 and tonumber(var_341_9) <= 24 then
					sY = tonumber(var_341_9) * 250 - 3000 - 125
					sX = (tonumber(var_341_10[var_341_8] - 1) * 250 - 3000 + 125) / -1

					placeWaypoint(sY, sX, 10)
					printStringNow("~y~UPDATE UNIT COORD " .. arg_341_0, 2500)
				end
			end
		end
	end
end

function getRank()
	frac, rang, scheck = nil, nil, 0

	lua_thread.create(function()
		if player_exp == nil or frac == nil or rang == nil then
			while frac == nil and rang == nil do
				wait(1000)

				if scheck > 10 then
					am("�������� ������ ��� ������������������ �������.")
					thisScript():unload()

					return
				elseif ms ~= nil then
					while not sampIsLocalPlayerSpawned() do
						wait(0)
					end

					while sampIsDialogActive() do
						wait(0)
					end

					while defusing_proccess or aid_proccess do
						wait(0)
					end

					while ms < 1000 + sampGetPlayerPing(myID) do
						wait(0)
					end

					rank_state = true

					print("1")
					sampSendSystemChat("/stats")
					wait(3000)
					print("3")
				end
			end
		end
	end)
end

function getEquest()
	equestRequest = true

	lua_thread.create(function()
		while equestRequest do
			wait(4000)

			if ms ~= nil and equestRequest then
				while not sampIsLocalPlayerSpawned() do
					wait(0)
				end

				while sampIsDialogActive() do
					wait(0)
				end

				while rank_state do
					wait(0)
				end

				while ms < 1000 + sampGetPlayerPing(myID) do
					wait(0)
				end

				while defusing_proccess or aid_proccess do
					wait(0)
				end

				while paycheck_state do
					wait(0)
				end

				sampSendSystemChat("/equest")
			end
		end
	end)
end

cop = {
	165,
	166,
	265,
	266,
	267,
	280,
	281,
	282,
	283,
	284,
	285,
	286,
	287,
	288,
	300,
	301,
	302,
	303,
	304,
	305,
	306,
	307,
	309,
	310,
	311,
	163,
	164
}

function isPlayerCop(arg_347_0, arg_347_1)
	if _G.mass[mkey] then
		for iter_347_0, iter_347_1 in pairs(arg_347_0) do
			if iter_347_1 == arg_347_1 then
				return true
			end
		end
	end

	return false
end

function deleteFromTable(arg_348_0)
	lua_thread.create(function()
		if arg_348_0 then
			for iter_349_0, iter_349_1 in pairs(okt) do
				if iter_349_1:find(arg_348_0) then
					table.remove(okt, iter_349_0)
				end
			end
		end
	end)
end

function deleteTableKey(arg_350_0, arg_350_1)
	for iter_350_0, iter_350_1 in pairs(arg_350_0) do
		if iter_350_1 == arg_350_1 then
			table.remove(arg_350_0, iter_350_0)
		end
	end
end

function setShowranks()
	while true do
		wait(0)

		if not gunstat then
			wait(7000)
			am("�� ����� ������ ����� ������.")

			gunstat = true
		end

		while not frac do
			wait(2500)
		end

		if se.main.showranks == true then
			if not as.other.showranks_start and os.clock() - showRanksSet > 300 then
				as.other.showranks_start = true
			end

			while as.other.showranks_start do
				wait(1000)

				if se.main.equest then
					while equestRequest do
						wait(0)
					end
				end

				while not sampIsLocalPlayerSpawned() do
					wait(0)
				end

				while sampIsDialogActive() do
					wait(0)
				end

				while rank_state do
					wait(0)
				end

				while paycheck_state do
					wait(0)
				end

				while reaver do
					wait(0)
				end

				while defusing_proccess or aid_proccess do
					wait(0)
				end

				if ms ~= nil then
					while sampIsChatInputActive() == true do
						wait(500)
					end

					while ms < 1000 + sampGetPlayerPing(myID) do
						wait(0)
					end

					sampSendSystemChat("/members 1")
					wait(4000)
				end
			end
		end
	end
end

function getFPS()
	lua_thread.create(function()
		while true do
			wait(0)

			fps_m = var_0_11.getfloat(12045136, true)
			fps = math.ceil(fps_m)

			wait(500)
		end
	end)
end

function awaitSendChatSystem()
	sendtime = os.clock() * 1000

	while true do
		wait(0)

		ms = os.clock() * 1000 - sendtime

		if #as.sendchat > 0 then
			for iter_354_0, iter_354_1 in pairs(as.sendchat) do
				ms = os.clock() * 1000 - sendtime

				if iter_354_1.isjson then
					local var_354_0 = true

					for iter_354_2, iter_354_3 in pairs(iter_354_1.text) do
						ms = os.clock() * 1000 - sendtime

						if iter_354_1.wait > 0 then
							while not var_354_0 and os.time() - iter_354_1.time <= iter_354_1.wait / 1000 do
								wait(0)
							end
						end

						while ms < 1000 + sampGetPlayerPing(myID) do
							ms = os.clock() * 1000 - sendtime

							wait(0)
						end

						if iter_354_1.type == 0 then
							sampSendChat(iter_354_3)

							sendtime = os.clock() * 1000
						end

						if iter_354_1.type == 1 then
							sampSendSystemChat(iter_354_3)

							sendtime = os.clock() * 1000
						end

						if iter_354_1.type == 2 then
							sampProcessChatInput(iter_354_3)

							sendtime = os.clock() * 1000
						end

						var_354_0 = false
					end

					if iter_354_1.ignore == true then
						var_0_23 = false
					end

					table.remove(as.sendchat, iter_354_0)
				else
					if iter_354_1.wait > 0 then
						while os.time() - iter_354_1.time <= iter_354_1.wait / 1000 do
							wait(0)
						end
					end

					while ms < 1000 + sampGetPlayerPing(myID) do
						ms = os.clock() * 1000 - sendtime

						wait(0)
					end

					if iter_354_1.type == 0 then
						sampSendChat(iter_354_1.text)

						sendtime = os.clock() * 1000
					end

					if iter_354_1.type == 1 then
						sampSendSystemChat(iter_354_1.text)

						sendtime = os.clock() * 1000
					end

					if iter_354_1.type == 2 then
						sampProcessChatInput(iter_354_1.text)

						sendtime = os.clock() * 1000
					end

					if iter_354_1.ignore == true then
						var_0_23 = false
					end

					table.remove(as.sendchat, iter_354_0)
				end
			end
		end
	end
end

function isGun(arg_355_0)
	local var_355_0 = {
		22,
		23,
		24,
		25,
		26,
		27,
		28,
		29,
		30,
		31,
		32,
		33,
		34,
		35,
		36,
		37,
		38
	}

	for iter_355_0, iter_355_1 in pairs(var_355_0) do
		if arg_355_0 == iter_355_1 then
			return true
		end
	end

	return false
end

function getFromTable(arg_356_0)
	if arg_356_0 then
		for iter_356_0, iter_356_1 in pairs(okt) do
			if iter_356_1:find(arg_356_0) then
				return true
			end
		end

		return false
	end

	return false
end

function sce(arg_357_0)
	lua_thread.create(function()
		if sampIsPlayerConnected(arg_357_0) and _G.mass[mkey] then
			local var_358_0 = sampGetPlayerNickname(arg_357_0):gsub("_", " ")
			local var_358_1, var_358_2 = sampGetCharHandleBySampPlayerId(arg_357_0)

			if var_358_0 ~= nil and doesCharExist(var_358_2) then
				if isCharInAnyCar(var_358_2) then
					local var_358_3 = getGxtText(getNameOfVehicleModel(getCarModel(storeCarCharIsInNoSave(var_358_2))))

					if isCharInAnyMoto(var_358_2) then
						local var_358_4 = getEditByCode("other.scemoto", 1):gsub("{name}", var_358_0):gsub("{car}",
							var_358_3)

						sampSendSystemChat(var_358_4)
					else
						local var_358_5 = getEditByCode("hotkey_z.z7", 1):gsub("{name}", var_358_0):gsub("{car}",
							var_358_3)

						sampSendSystemChat(var_358_5)
					end

					wait(p(500))
					sampSendChat("/ceject " .. arg_357_0)
					wait(p(2000))
					sampSendChat("/cuff " .. arg_357_0)
				else
					_G.sampAddChatMessage("| {FFFFFF}����� ������ ���������� � ������.", clr)
				end
			else
				_G.sampAddChatMessage("| {FFFFFF}ID ������ �������.", clr)
			end
		else
			_G.sampAddChatMessage("    �������: /sce [ID] - ����� �������� �������� ������ �� ������ � ����������", -1)
		end
	end)
end

function var_0_3.onGangZoneFlash(arg_359_0, arg_359_1)
	local var_359_0 = var_0_10.cast("struct stGangzonePool*", sampGetGangzonePoolPtr())

	if var_359_0.iIsListed[arg_359_0] ~= 0 and var_359_0.pGangzone[arg_359_0] ~= nil then
		local var_359_1 = var_359_0.pGangzone[arg_359_0].fPosition

		gg.gz_flash[arg_359_0] = {
			color = tostring(getGGColor(arg_359_1)),
			f = os.time(),
			m = os.time() + 1
		}
	end
end

function var_0_3.onGangZoneDestroy(arg_360_0)
	if gg.gz[arg_360_0] ~= nil then
		gg.gz[arg_360_0] = nil
	end

	if gg.gz_flash[arg_360_0] ~= nil then
		gg.gz_flash[arg_360_0] = nil
	end
end

function var_0_3.onCreateGangZone(arg_361_0, arg_361_1, arg_361_2, arg_361_3)
	gg.gz[arg_361_0] = {
		zoneId = arg_361_0,
		x1 = arg_361_1.x,
		y1 = arg_361_1.y,
		x2 = arg_361_2.x,
		y2 = arg_361_2.y,
		color = tostring(getGGColor(arg_361_3)),
		mcolor = tostring(arg_361_3)
	}
end

function var_0_3.onGangZoneStopFlash(arg_362_0)
	if gg.gz_flash[arg_362_0] ~= nil then
		gg.gz_flash[arg_362_0] = nil
	end
end

function var_0_3.onSendDialogResponse(arg_363_0, arg_363_1, arg_363_2, arg_363_3)
	if as ~= nil and as.other.frisk_start and arg_363_0 == 22 and arg_363_1 == 0 and sampGetDialogCaption() == "����" and arg_363_3 ~= "[0] ������������" then
		if as.other.frisk_jail == true then
			as.f.chat(im.informer.infMainSex.v == true and "/me ����� �� ������, ��������� ����� ������ � ����� �����." or
			"/me ����� �� ������, ���������� ����� ������ � ������ �����.")
		end

		as.f.chat(im.informer.infMainSex.v == true and "/me ���� �������� � ����� �� � ����������� ����." or
		"/me ����� �������� � ������ �� � ����������� ����.")

		as.other.frisk_start, as.other.frisk_jail = false, false
	end

	if as ~= nil and as.other.tfrisk_start and arg_363_0 == 1259 and sampGetDialogCaption():find("����� ���������") and arg_363_1 == 0 then
		as.f.chat(im.informer.infMainSex.v == true and "/me ������ ��������, ���� �������� � ����� ��." or
		"/me ������� ��������, ����� ������� � ������ ��.")

		as.other.tfrisk_start = false
	end
end

function var_0_3.onSendDeathNotification(arg_364_0, arg_364_1)
	if isPlayerCop(cop, getCharModel(playerPed)) or isPlayerCop(fbi, getCharModel(playerPed)) then
		local var_364_0, var_364_1, var_364_2 = getCharCoordinates(playerPed)
		local var_364_3 = kvadUli(playerPed)
		local var_364_4 = kvad(playerPed)

		if var_364_4 == "�-23" or var_364_4 == "�-24" or var_364_4 == "�-23" or var_364_4 == "�-24" then
			as.other.killedSector = "�� ���������� Army LS [" .. var_364_3 .. "]"
		elseif var_364_4 == "�-19" and var_364_2 ~= nil and var_364_2 < 12 then
			as.other.killedSector = "� ������ Police LS [" .. var_364_3 .. "]"
		elseif var_364_4 == "�-6" and var_364_2 ~= nil and var_364_2 < 6 then
			as.other.killedSector = "� ������ Police SF [" .. var_364_3 .. "]"
		elseif var_364_4 == "�-21" or var_364_4 == "�-22" then
			if var_364_2 ~= nil and var_364_2 < 10 then
				as.other.killedSector = "� ������ Police LV [" .. var_364_3 .. "]"
			else
				as.other.killedSector = "� ������� " .. var_364_3
			end
		elseif var_364_4 == "�-2" or var_364_4 == "�-3" or var_364_4 == "�-2" or var_364_4 == "�-3" then
			if var_364_2 ~= nil and var_364_2 < -40 then
				as.other.killedSector = "� ������ FBI [" .. var_364_3 .. "]"
			else
				as.other.killedSector = "� ������� " .. var_364_3
			end
		elseif var_364_3 == "�-2-2" then
			as.other.killedSector = "� ���� �. San Fierro [" .. var_364_3 .. "]"
		elseif var_364_3 == "�-4-3" or var_364_3 == "�-4-4" then
			as.other.killedSector = "� ��������� �. San Fierro [" .. var_364_3 .. "]"
		elseif var_364_4 == "�-6" or var_364_3 == "�-7-1" or var_364_4 == "�-7" or var_364_3 == "�-8-1" or var_364_4 == "�-8" then
			if var_364_2 ~= nil and var_364_2 > 35 then
				as.other.killedSector = "�� ����� San Fierro - Las Venturas [" .. var_364_3 .. "]"
			else
				as.other.killedSector = "� ������� " .. var_364_3
			end
		else
			as.other.killedSector = "� ������� " .. var_364_3
		end
	end
end

function var_0_3.onSendSpawn()
	if active and se.main.clist_st and se.main.clist ~= "" and _G.mass[mkey] and not clistingFirst then
		pedSpawned = true
	end
end

function getClosestPlayerId()
	local var_366_0 = 9999
	local var_366_1 = -1
	local var_366_2, var_366_3, var_366_4 = getCharCoordinates(PLAYER_PED)

	for iter_366_0 = 0, 999 do
		local var_366_5, var_366_6 = sampGetCharHandleBySampPlayerId(iter_366_0)

		if var_366_5 then
			local var_366_7, var_366_8, var_366_9 = getCharCoordinates(var_366_6)
			local var_366_10 = math.sqrt((var_366_7 - var_366_2) ^ 2 + (var_366_8 - var_366_3) ^ 2 +
			(var_366_9 - var_366_4) ^ 2)

			if var_366_10 < var_366_0 then
				var_366_0 = var_366_10
				var_366_1 = iter_366_0
			end
		end
	end

	return var_366_1
end

function getClosestDriverId()
	local var_367_0 = 9999
	local var_367_1 = -1
	local var_367_2, var_367_3, var_367_4 = getCharCoordinates(PLAYER_PED)

	for iter_367_0 = 0, 999 do
		local var_367_5, var_367_6 = sampGetCharHandleBySampPlayerId(iter_367_0)

		if var_367_5 and isCharInCarDriver(var_367_6) then
			local var_367_7, var_367_8, var_367_9 = getCharCoordinates(var_367_6)
			local var_367_10 = math.sqrt((var_367_7 - var_367_2) ^ 2 + (var_367_8 - var_367_3) ^ 2 +
			(var_367_9 - var_367_4) ^ 2)

			if var_367_10 < var_367_0 then
				var_367_0 = var_367_10
				var_367_1 = iter_367_0
			end
		end
	end

	return var_367_1
end

function setPstart()
	sampShowDialog(400, "��", "{7B68EE}| {FFFFFF}������� �������� ������� [A-Z, 0-9, F1-F12]", "OK", "Cancel", 1)
	lua_thread.create(function()
		while true do
			wait(0)

			local var_369_0, var_369_1, var_369_2, var_369_3 = sampHasDialogRespond(400)

			if var_369_0 and sampGetGamestate() == 3 and #var_369_3 ~= 0 then
				se.keys.pursuit_start = var_369_3
			end
		end
	end)
end

function closestCar()
	lua_thread.create(function()
		while true do
			wait(500)

			if isCharInAnyCar(playerPed) and se.main.fastpursuit and sampGetGamestate() == 3 then
				local var_371_0 = getClosestCar()

				if var_371_0 ~= false and not var_371_0:find("Police Car") and not var_371_0:find("FBI Rancher") and not var_371_0:find("Police Maverick") then
					CL_CAR = var_371_0
				end
			end
		end
	end)
end

function licDays(arg_372_0)
	local var_372_0 = tonumber(arg_372_0)

	if var_372_0 > 0 then
		if var_372_0 == 11 then
			return "����"
		else
			if math.numbs(var_372_0) == 1 then
				if var_372_0 == 1 then
					return "����"
				end

				if var_372_0 >= 2 and var_372_0 <= 4 then
					return "���"
				end

				if var_372_0 >= 5 and var_372_0 <= 9 then
					return "����"
				end
			end

			if math.numbs(var_372_0) == 2 then
				local var_372_1 = tostring(var_372_0):match("%d(%d)")

				if var_372_1 then
					local var_372_2 = tonumber(var_372_1)

					if var_372_2 == 0 then
						return "����"
					end

					if var_372_2 == 1 then
						return "����"
					end

					if var_372_2 >= 2 and var_372_2 <= 4 then
						return "���"
					end

					if var_372_2 >= 5 and var_372_2 <= 9 then
						return "����"
					end
				end
			end

			if math.numbs(var_372_0) == 3 then
				local var_372_3 = tostring(var_372_0):match("%d%d(%d)")

				if var_372_3 then
					local var_372_4 = tonumber(var_372_3)

					if var_372_4 == 0 then
						return "����"
					end

					if var_372_4 == 1 then
						return "����"
					end

					if var_372_4 >= 2 and var_372_4 <= 4 then
						return "���"
					end

					if var_372_4 >= 5 and var_372_4 <= 9 then
						return "����"
					end
				end
			end

			if math.numbs(var_372_0) == 4 then
				local var_372_5 = tostring(var_372_0):match("%d%d%d(%d)")

				if var_372_5 then
					local var_372_6 = tonumber(var_372_5)

					if var_372_6 == 0 then
						return "����"
					end

					if var_372_6 == 1 then
						return "����"
					end

					if var_372_6 >= 2 and var_372_6 <= 4 then
						return "���"
					end

					if var_372_6 >= 5 and var_372_6 <= 9 then
						return "����"
					end
				end
			end

			if math.numbs(var_372_0) == 5 then
				local var_372_7 = tostring(var_372_0):match("%d%d%d%d(%d)")

				if var_372_7 then
					local var_372_8 = tonumber(var_372_7)

					if var_372_8 == 0 then
						return "����"
					end

					if var_372_8 == 1 then
						return "����"
					end

					if var_372_8 >= 2 and var_372_8 <= 4 then
						return "���"
					end

					if var_372_8 >= 5 and var_372_8 <= 9 then
						return "����"
					end
				end
			end
		end
	end

	return "��"
end

function getClosestCar()
	if getClosestDriverId() ~= -1 then
		local var_373_0 = getClosestDriverId()
		local var_373_1, var_373_2 = sampGetCharHandleBySampPlayerId(var_373_0)

		if var_373_1 and doesCharExist(var_373_2) and isCharInCarDriver(var_373_2) then
			local var_373_3 = getGxtText(getNameOfVehicleModel(getCarModel(storeCarCharIsInNoSave(var_373_2))))

			if var_373_3 ~= "Police Car" and var_373_3 ~= "FBI Rancher" and var_373_3 ~= "Enforcer" and var_373_3 ~= "Police Maverick" and var_373_3 ~= "FBI Truck" and var_373_3 ~= "HPV1000" then
				local var_373_4 = storeCarCharIsInNoSave(var_373_2)
				local var_373_5, var_373_6, var_373_7 = getCharCoordinates(var_373_2)

				cNum = numberPlate(var_373_0)

				local var_373_8 = var_373_3 .. " [" .. (cNum ~= nil and cNum or "-") .. "]"

				CL_CAR_ID = var_373_0
				CL_CAR_NAME = sampGetPlayerNickname(var_373_0)
				CL_CAR_HANDLE = var_373_4
				CL_CAR_VEHICLE = var_373_3
				CL_CAR_NUM = cNum
				CL_SUSPECT_HANDLE = var_373_2

				return var_373_8
			end
		end
	end

	return false
end

function getClosestCarName()
	local var_374_0 = getAllVehicles()
	local var_374_1 = 300

	for iter_374_0, iter_374_1 in pairs(var_374_0) do
		if doesVehicleExist(iter_374_1) then
			local var_374_2, var_374_3, var_374_4 = getCarCoordinates(iter_374_1)
			local var_374_5, var_374_6, var_374_7 = getCharCoordinates(playerPed)
			local var_374_8 = getDistanceBetweenCoords3d(var_374_5, var_374_6, mposZ, var_374_2, var_374_3, var_374_4)

			if var_374_8 <= var_374_1 then
				name = getGxtText(getNameOfVehicleModel(getCarModel(iter_374_1)))
				var_374_1 = var_374_8
			end
		end
	end

	return name
end

function isPoliceCar(arg_375_0, arg_375_1)
	for iter_375_0, iter_375_1 in pairs(arg_375_0) do
		if iter_375_1 == arg_375_1 then
			return true
		end
	end

	return false
end

function isPlayerInCopCar(arg_376_0)
	if isCharInAnyPoliceVehicle(arg_376_0) then
		return true
	end

	if not police_cars then
		return false
	end

	local var_376_0 = storeCarCharIsInNoSave(arg_376_0)

	if not var_376_0 then
		return false
	end

	local var_376_1 = select(2, sampGetVehicleIdByCarHandle(var_376_0))

	if as and as.other.sirens[var_376_1] ~= nil then
		return true
	end

	for iter_376_0 = 0, 10 do
		local var_376_2 = var_376_1 + iter_376_0
		local var_376_3 = var_376_1 - iter_376_0

		for iter_376_1, iter_376_2 in pairs(police_cars) do
			if tonumber(iter_376_1) == var_376_1 and getCarModel(var_376_0) == iter_376_2 then
				return true
			end

			if tonumber(iter_376_1) == var_376_2 and getCarModel(var_376_0) == iter_376_2 then
				return true
			end

			if tonumber(iter_376_1) == var_376_3 and getCarModel(var_376_0) == iter_376_2 then
				return true
			end
		end
	end

	return false
end

function var_0_3.onPlayerJoin(arg_377_0, arg_377_1, arg_377_2, arg_377_3)
	if as then
		as.other.id_list[arg_377_3] = arg_377_0
	end

	if active then
		if var_0_33 and var_0_33[arg_377_3] and not var_0_34[arg_377_3] then
			local var_377_0 = sampCreate3dText(u8:decode(var_0_33[arg_377_3]), 4294967210, 0, 0, 0.9, 20, false,
				arg_377_0, -1)

			var_0_34[arg_377_3] = var_377_0
		end

		if as.other.newmans and as.other.newmans[arg_377_3] and not as.other.newmansset[arg_377_3] and not var_0_33[k] then
			local var_377_1 = sampCreate3dText(u8:decode(as.other.newmans[arg_377_3]), 4294967210, 0, 0, 0.9, 20, false,
				arg_377_0, -1)

			as.other.newmansset[arg_377_3] = var_377_1
		end
	end
end

function var_0_3.onSendExitVehicle(arg_378_0)
	if se and se.radio.radio_copcar and radio_copcar ~= nil and radio_copcar_state == "play" then
		setAudioStreamState(radio_copcar, var_0_8.PAUSE)

		radio_copcar_state = "pause"
	end

	if isPlayerCop(cop, getCharModel(playerPed)) or isPlayerCop(fbi, getCharModel(playerPed)) then
		local var_378_0 = select(2, sampGetCarHandleBySampVehicleId(arg_378_0))
		local var_378_1 = getCarModel(var_378_0)

		if isPoliceCar(copcars, var_378_1) then
			endTime = os.clock() + 900
			spawnColor = "FFFFFF"
		elseif var_378_1 == 521 or var_378_1 == 415 or var_378_1 == 560 then
			local var_378_2, var_378_3 = getCarColours(var_378_0)

			if var_378_2 == 0 and var_378_3 == 0 then
				endTime = os.clock() + 900
				spawnColor = "FFFFFF"
			end
		end
	end
end

function var_0_3.onSendEnterVehicle(arg_379_0, arg_379_1)
	if isPlayerCop(cop, getCharModel(playerPed)) or isPlayerCop(fbi, getCharModel(playerPed)) then
		local var_379_0 = select(2, sampGetCarHandleBySampVehicleId(arg_379_0))
		local var_379_1 = getCarModel(var_379_0)

		if isPoliceCar(copcars, var_379_1) then
			endTime = os.clock()
			spawnColor = "FFFFFF"
		elseif var_379_1 == 521 or var_379_1 == 415 or var_379_1 == 560 then
			local var_379_2, var_379_3 = getCarColours(var_379_0)

			if var_379_2 == 0 and var_379_3 == 0 then
				endTime = os.clock()
				spawnColor = "FFFFFF"
			end
		end

		if se.radio.radio_copcar and isPoliceCar(copcars, var_379_1) and im.radio.radio_copcar.v and radio_copcar then
			if radio_copcar_state == "pause" then
				setAudioStreamVolume(radio_copcar, im.radio.radio_copcar_v.v)
				setAudioStreamState(radio_copcar, var_0_8.RESUME)
				setAudioStreamLooped(radio_copcar, true)

				radio_copcar_state = "resume"
			elseif radio_copcar_state == "stop" then
				setAudioStreamVolume(radio_copcar, im.radio.radio_copcar_v.v)
				setAudioStreamState(radio_copcar, var_0_8.PLAY)
				setAudioStreamLooped(radio_copcar, true)

				radio_copcar_state = "play"
			end
		end
	end
end

function getradio()
	if se.radio.radio_copcar then
		local var_380_0 = {
			data = "s=" ..
			select(1, sampGetCurrentServerAddress()) ..
			":" ..
			select(2, sampGetCurrentServerAddress()) ..
			"&n=" .. sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))),
			headers = {
				["content-type"] = "application/x-www-form-urlencoded"
			}
		}

		sequent_async_http_request("POST", "https://pdp-samp.online/script/PDProject/radio", var_380_0,
			function(arg_381_0)
				if arg_381_0.text:find("files") then
					radio_copcar = loadAudioStream(arg_381_0.text)
				else
					radio_copcar = nil
				end
			end, function(arg_382_0)
			print(arg_382_0)
		end)
	end
end

function var_0_3.onPlayerStreamIn(arg_383_0, arg_383_1, arg_383_2, arg_383_3, arg_383_4, arg_383_5, arg_383_6)
	if active and im.informer.infMainOopFunc.v and #wanted > 0 and wantedLevel[arg_383_0] then
		local var_383_0, var_383_1 = sampGetCharHandleBySampPlayerId(arg_383_0)

		if var_383_0 and doesCharExist(var_383_1) and not wanted_info[arg_383_0] then
			chat("� ���� ��������� �������� " ..
			sampGetPlayerNickname(arg_383_0) ..
			"[" .. arg_383_0 .. "] � " .. tostring(wantedLevel[arg_383_0]) .. " ��.�.")

			wanted_info[arg_383_0] = arg_383_0
			wanted_blip = addBlipForChar(var_383_1)

			changeBlipColour(wanted_blip, 4278190335)
			setBlipAlwaysDisplayOnZoomedRadar(wanted_blip, -1)

			blip_want[#blip_want + 1] = wanted_blip
		end
	end
end

function var_0_3.onPlayerStreamOut(arg_384_0)
	if wanted_info[arg_384_0] then
		wanted_info[arg_384_0] = nil
	end
end

function showekgs()
	if ekgs ~= nil and _G.mass[mkey] then
		var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_0_94 / 2, var_0_95 / 2), var_0_0.Cond.FirstUseEver,
			var_0_0.ImVec2(0.5, 0.5))
		var_0_0.SetNextWindowSize(var_0_0.ImVec2(1000, 600), var_0_0.Cond.FirstUseEver)
		var_0_0.Begin(u8("����"), var_0_38, var_0_0.WindowFlags.HorizontalScrollbar)
		var_0_0.InputText(u8("����� �� ����"), var_0_99.ekgs_s)
		var_0_0.Separator()
		var_0_0.PushTextWrapPos()

		if var_0_99.ekgs_s.v:len() > 0 then
			var_0_0.Text(u8("�����: ") .. var_0_99.ekgs_s.v)

			for iter_385_0, iter_385_1 in pairs(ekgs_arr) do
				if u8(iter_385_1):find(var_0_99.ekgs_s.v) then
					var_0_0.Text(u8(iter_385_1))
				end
			end
		else
			for iter_385_2 in string.gmatch(ekgs, "[^\r\n]+") do
				var_0_0.Text(u8(iter_385_2))
			end
		end

		var_0_0.End()
	end
end

function notes_show()
	if note_for_show ~= nil and _G.mass[mkey] then
		var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_0_94 / 2, var_0_95 / 2), var_0_0.Cond.FirstUseEver,
			var_0_0.ImVec2(0.5, 0.5))
		var_0_0.SetNextWindowSize(var_0_0.ImVec2(1000, 600), var_0_0.Cond.FirstUseEver)
		var_0_0.Begin(u8(ntData[note_for_show].name), im.windows.notes_show, var_0_0.WindowFlags.HorizontalScrollbar)
		var_0_0.PushItemWidth(200)
		var_0_0.InputText(u8("����� (�����������������)"), var_0_99.notes, var_0_0.InputTextFlags.AlwaysInsertMode)
		var_0_0.SameLine()

		if not as.other.notes_copy then
			if var_0_0.Button(u8("����� �����������")) then
				as.other.notes_copy = not as.other.notes_copy
			end
		else
			var_0_0.PushStyleColor(var_0_0.Col.Button, var_0_0.ImVec4(0.1, 0.6, 0.1, 1))
			var_0_0.PushStyleColor(var_0_0.Col.ButtonHovered, var_0_0.ImVec4(0.1, 0.8, 0.1, 1))

			if var_0_0.Button(u8("����� �����������")) then
				as.other.notes_copy = not as.other.notes_copy
			end

			var_0_0.PopStyleColor(2)
		end

		var_0_0.PushTextWrapPos()

		local var_386_0 = var_0_0.GetWindowWidth() * 0.98
		local var_386_1 = var_0_0.GetWindowHeight() * 0.9

		if not as.other.notes_copy then
			var_0_0.BeginChild("##notes_show_1", var_0_0.ImVec2(0, 0), true)

			for iter_386_0 in string.gmatch(ntData[note_for_show].text, "[^\r\n]+") do
				if var_0_99.notes.v ~= var_0_99.notes_last.v then
					as.garbage.searched = {}
				end

				if var_0_99.notes.v:len() > 0 and u8(iter_386_0):find(var_0_99.notes.v) then
					var_0_0.TextColoredRGB2(u8(iter_386_0):gsub(var_0_99.notes.v,
						"{FFFF00}" .. var_0_99.notes.v .. "{FFFFFF}"))

					if not as.garbage.searched[u8(var_0_99.notes.v)] then
						var_0_0.SetScrollHere()

						as.garbage.searched[u8(var_0_99.notes.v)] = true
					end
				else
					var_0_0.Text(u8(iter_386_0))

					if as.garbage.searched[1] ~= nil then
						as.garbage.searched = {}
					end
				end
			end

			var_0_99.notes_last.v = var_0_99.notes.v

			var_0_0.EndChild()
		else
			im.other.notepad_show.v = ""

			for iter_386_1 in string.gmatch(ntData[note_for_show].text, "[^\r\n]+") do
				if im.other.notepad_show.v == "" then
					im.other.notepad_show.v = u8(iter_386_1)
				else
					im.other.notepad_show.v = im.other.notepad_show.v .. "\n" .. u8(iter_386_1)
				end
			end

			var_0_0.InputTextMultiline("##nnotepad_show_v", im.other.notepad_show, var_0_0.ImVec2(var_386_0, var_386_1),
				var_0_0.InputTextFlags.ReadOnly)
		end

		var_0_0.End()
	end
end

function defuse_show()
	var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_0_94 / 2, var_0_95 / 2), var_0_0.Cond.FirstUseEver,
		var_0_0.ImVec2(0.5, 0.5))
	var_0_0.SetNextWindowSize(var_0_0.ImVec2(317, 405), var_0_0.Cond.FirstUseEver)
	var_0_0.Begin(u8("��������������"), im.windows.defuse,
		var_0_0.WindowFlags.NoMove + var_0_0.WindowFlags.NoTitleBar + var_0_0.WindowFlags.NoResize)
	var_0_0.PushItemWidth(300)
	var_0_0.SliderInt("##defuse_wait", im.settings.defuse_wait, 1000, 5000,
		var_0_7.ICON_CLOCK_O .. u8(" ����� �����������: " .. im.settings.defuse_wait.v / 1000 .. " ���."))

	se.main.defuse_wait = im.settings.defuse_wait.v

	if var_0_0.Button(var_0_7.ICON_BOMB .. u8(" ���������� � �����������"), var_0_0.ImVec2(300, 80)) then
		activeDefusing("mobile")

		im.windows.defuse.v = not im.windows.defuse.v
	end

	if var_0_0.Button(var_0_7.ICON_BOMB .. u8(" ���������� � ������������� �����������"), var_0_0.ImVec2(300, 80)) then
		activeDefusing("distance")

		im.windows.defuse.v = not im.windows.defuse.v
	end

	if var_0_0.Button(var_0_7.ICON_BOMB .. u8(" ���������� � ������� ����������"), var_0_0.ImVec2(300, 80)) then
		activeDefusing("clock")

		im.windows.defuse.v = not im.windows.defuse.v
	end

	if var_0_0.Button(var_0_7.ICON_BOMB .. u8(" ���������� � �����"), var_0_0.ImVec2(300, 80)) then
		activeDefusing("code")

		im.windows.defuse.v = not im.windows.defuse.v
	end

	if var_0_0.Button(var_0_7.ICON_WINDOW_CLOSE_O .. u8(" ������� ����"), var_0_0.ImVec2(300, 25)) then
		im.windows.defuse.v = not im.windows.defuse.v
	end

	var_0_0.End()
end

function aidCount()
	local var_388_0 = 0

	for iter_388_0, iter_388_1 in pairs(aidData) do
		var_388_0 = var_388_0 + 1
	end

	return var_388_0
end

function aid_show()
	var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_0_94 / 2, var_0_95 / 2), var_0_0.Cond.FirstUseEver,
		var_0_0.ImVec2(0.5, 0.5))
	var_0_0.SetNextWindowSize(var_0_0.ImVec2(317, as.aid_window_size), var_0_0.Cond.FirstUseEver)
	var_0_0.Begin(u8("������ ������"), im.windows.aid,
		var_0_0.WindowFlags.NoMove + var_0_0.WindowFlags.NoTitleBar + var_0_0.WindowFlags.NoResize)
	var_0_0.PushItemWidth(300)
	var_0_0.SliderInt("##aid_wait", im.settings.aid_wait, 1000, 12000,
		var_0_7.ICON_CLOCK_O .. u8(" ����� �����������: " .. im.settings.aid_wait.v / 1000 .. " ���."))

	se.main.aid_wait = im.settings.aid_wait.v

	if aidData ~= nil then
		for iter_389_0, iter_389_1 in pairs(aidData) do
			if var_0_0.Button(var_0_7.ICON_HEARTBEAT .. " " .. iter_389_0, var_0_0.ImVec2(300, 40)) then
				activeAid(iter_389_0)

				im.windows.aid.v = not im.windows.aid.v
			end
		end
	end

	if var_0_0.Button(var_0_7.ICON_WINDOW_CLOSE_O .. u8(" ������� ����"), var_0_0.ImVec2(300, 25)) then
		im.windows.aid.v = not im.windows.aid.v
	end

	var_0_0.End()
end

function show_sf_manual()
	if sf_manual ~= nil and _G.mass[mkey] then
		var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_0_94 / 2, var_0_95 / 2), var_0_0.Cond.FirstUseEver,
			var_0_0.ImVec2(0.5, 0.5))
		var_0_0.SetNextWindowSize(var_0_0.ImVec2(1000, 600), var_0_0.Cond.FirstUseEver)
		var_0_0.Begin(u8("������ ������� ��"), var_0_49, var_0_0.WindowFlags.HorizontalScrollbar)
		var_0_0.InputText(u8("����� �� ����"), var_0_99.sf_manual_s)
		var_0_0.Separator()
		var_0_0.PushTextWrapPos()

		if var_0_99.sf_manual_s.v:len() > 0 then
			var_0_0.Text(u8("�����: ") .. var_0_99.sf_manual_s.v)

			for iter_390_0, iter_390_1 in pairs(sf_manual_arr) do
				if u8(iter_390_1):find(var_0_99.sf_manual_s.v) then
					var_0_0.Text(u8(iter_390_1))
				end
			end
		else
			for iter_390_2 in string.gmatch(sf_manual, "[^\r\n]+") do
				var_0_0.Text(u8(iter_390_2))
			end
		end

		var_0_0.End()
	end
end

function show_lv_manual()
	if lv_manual ~= nil and _G.mass[mkey] then
		var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_0_94 / 2, var_0_95 / 2), var_0_0.Cond.FirstUseEver,
			var_0_0.ImVec2(0.5, 0.5))
		var_0_0.SetNextWindowSize(var_0_0.ImVec2(1000, 600), var_0_0.Cond.FirstUseEver)
		var_0_0.Begin(u8("������ ������� ��"), var_0_50, var_0_0.WindowFlags.HorizontalScrollbar)
		var_0_0.InputText(u8("����� �� ����"), var_0_99.lv_manual_s)
		var_0_0.Separator()
		var_0_0.PushTextWrapPos()

		if var_0_99.lv_manual_s.v:len() > 0 then
			var_0_0.Text(u8("�����: ") .. var_0_99.lv_manual_s.v)

			for iter_391_0, iter_391_1 in pairs(lv_manual_arr) do
				if u8(iter_391_1):find(var_0_99.lv_manual_s.v) then
					var_0_0.Text(u8(iter_391_1))
				end
			end
		else
			for iter_391_2 in string.gmatch(lv_manual, "[^\r\n]+") do
				var_0_0.Text(u8(iter_391_2))
			end
		end

		var_0_0.End()
	end
end

function isCharInAnyMoto(arg_392_0)
	local var_392_0 = {
		461,
		462,
		463,
		468,
		471,
		521,
		522,
		581,
		586,
		523
	}

	if doesCharExist(arg_392_0) and isCharInAnyCar(arg_392_0) then
		local var_392_1 = getCarModel(storeCarCharIsInNoSave(arg_392_0))

		if var_392_1 then
			for iter_392_0, iter_392_1 in pairs(var_392_0) do
				if iter_392_1 == var_392_1 then
					return true
				end
			end
		end
	end

	return false
end

function getCarModelType(arg_393_0)
	local var_393_0 = tonumber(arg_393_0)

	if var_393_0 == 0 then
		return false
	end

	local var_393_1 = {
		461,
		462,
		463,
		468,
		471,
		521,
		522,
		581,
		586,
		523
	}
	local var_393_2 = {
		548,
		425,
		417,
		487,
		488,
		497,
		563,
		447,
		469
	}
	local var_393_3 = {
		592,
		577,
		511,
		512,
		593,
		520,
		553,
		476,
		519,
		460,
		513
	}
	local var_393_4 = {
		472,
		473,
		493,
		595,
		484,
		430,
		453,
		452,
		446,
		454
	}
	local var_393_5 = {
		427,
		528,
		523,
		596,
		597,
		598,
		599
	}

	if var_393_0 then
		for iter_393_0, iter_393_1 in pairs(var_393_1) do
			if iter_393_1 == var_393_0 then
				return "moto"
			end
		end

		for iter_393_2, iter_393_3 in pairs(var_393_2) do
			if iter_393_3 == var_393_0 then
				return "heli"
			end
		end

		for iter_393_4, iter_393_5 in pairs(var_393_3) do
			if iter_393_5 == var_393_0 then
				return "heli"
			end
		end

		for iter_393_6, iter_393_7 in pairs(var_393_4) do
			if iter_393_7 == var_393_0 then
				return "boat"
			end
		end

		for iter_393_8, iter_393_9 in pairs(var_393_5) do
			if iter_393_9 == var_393_0 then
				return "police"
			end
		end

		if var_393_0 == 490 then
			return "fbi"
		end

		return "car"
	end

	return false
end

function getSmsLog()
	smslogs = {}

	local var_394_0
	local var_394_1, var_394_2 = findFirstFile("moonloader/PD-Project/sms-log/*.txt")

	if var_394_2 then
		local var_394_3 = var_394_2:gsub("logs%-", ""):gsub(".txt", "")
		local var_394_4 = dateToSec(var_394_3)
		local var_394_5 = io.open("moonloader/PD-Project/sms-log/" .. var_394_2, "r")

		if var_394_5 then
			smslogs[tonumber(var_394_4)] = {
				filename = var_394_3,
				data = var_394_5:read("*a")
			}

			var_394_5:close()
		end

		while var_394_2 do
			var_394_2 = findNextFile(var_394_1)

			if var_394_2 then
				local var_394_6 = var_394_2:gsub("logs%-", ""):gsub(".txt", "")
				local var_394_7 = dateToSec(var_394_6)
				local var_394_8 = io.open("moonloader/PD-Project/sms-log/" .. var_394_2, "r")

				if var_394_8 then
					smslogs[tonumber(var_394_7)] = {
						filename = var_394_6,
						data = var_394_8:read("*a")
					}

					var_394_8:close()
				end
			end
		end

		findClose(var_394_1)
	end

	smslogs = sortKeysAnother(smslogs)

	return smslogs
end

function show_ls_manual()
	if ls_manual ~= nil and _G.mass[mkey] then
		var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_0_94 / 2, var_0_95 / 2), var_0_0.Cond.FirstUseEver,
			var_0_0.ImVec2(0.5, 0.5))
		var_0_0.SetNextWindowSize(var_0_0.ImVec2(1000, 600), var_0_0.Cond.FirstUseEver)
		var_0_0.Begin(u8("������ ������� ��"), var_0_51, var_0_0.WindowFlags.HorizontalScrollbar)
		var_0_0.InputText(u8("����� �� ����"), var_0_99.ls_manual_s)
		var_0_0.Separator()
		var_0_0.PushTextWrapPos()

		if var_0_99.ls_manual_s.v:len() > 0 then
			var_0_0.Text(u8("�����: ") .. var_0_99.ls_manual_s.v)

			for iter_395_0, iter_395_1 in pairs(ls_manual_arr) do
				if u8(iter_395_1):find(var_0_99.ls_manual_s.v) then
					var_0_0.Text(u8(iter_395_1))
				end
			end
		else
			for iter_395_2 in string.gmatch(ls_manual, "[^\r\n]+") do
				var_0_0.Text(u8(iter_395_2))
			end
		end

		var_0_0.End()
	end
end

function show_fbi_manual()
	if fbi_manual ~= nil and _G.mass[mkey] then
		var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_0_94 / 2, var_0_95 / 2), var_0_0.Cond.FirstUseEver,
			var_0_0.ImVec2(0.5, 0.5))
		var_0_0.SetNextWindowSize(var_0_0.ImVec2(1000, 600), var_0_0.Cond.FirstUseEver)
		var_0_0.Begin(u8("������ ���"), var_0_52, var_0_0.WindowFlags.HorizontalScrollbar)
		var_0_0.InputText(u8("����� �� ����"), var_0_99.fbi_manual_s)
		var_0_0.Separator()
		var_0_0.PushTextWrapPos()

		if var_0_99.fbi_manual_s.v:len() > 0 then
			var_0_0.Text(u8("�����: ") .. var_0_99.fbi_manual_s.v)

			for iter_396_0, iter_396_1 in pairs(fbi_manual_arr) do
				if u8(iter_396_1):find(var_0_99.fbi_manual_s.v) then
					var_0_0.Text(u8(iter_396_1))
				end
			end
		else
			for iter_396_2 in string.gmatch(fbi_manual, "[^\r\n]+") do
				var_0_0.Text(u8(iter_396_2))
			end
		end

		var_0_0.End()
	end
end

function showuk()
	if ekgs_uk ~= nil and _G.mass[mkey] then
		var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_0_94 / 2, var_0_95 / 2), var_0_0.Cond.FirstUseEver,
			var_0_0.ImVec2(0.5, 0.5))
		var_0_0.SetNextWindowSize(var_0_0.ImVec2(1000, 600), var_0_0.Cond.FirstUseEver)
		var_0_0.Begin(u8("��������� ������"), var_0_40, var_0_0.WindowFlags.HorizontalScrollbar)
		var_0_0.InputText(u8("����� �� ����"), var_0_99.ekgs_uk_s)
		var_0_0.Separator()
		var_0_0.PushTextWrapPos()

		if var_0_99.ekgs_uk_s.v:len() > 0 then
			var_0_0.Text(u8("�����: ") .. var_0_99.ekgs_uk_s.v)

			for iter_397_0, iter_397_1 in pairs(ekgs_uk_arr) do
				if u8(iter_397_1):find(var_0_99.ekgs_uk_s.v) then
					if iter_397_0 > 0 and ekgs_uk_arr[iter_397_0 - 1] ~= nil then
						var_0_0.Text(u8(ekgs_uk_arr[iter_397_0 - 1]))
					end

					var_0_0.Text(u8(iter_397_1))

					if iter_397_0 < #ekgs_uk_arr and ekgs_uk_arr[iter_397_0 + 1] ~= nil then
						var_0_0.Text(u8(ekgs_uk_arr[iter_397_0 + 1]))
					end

					if iter_397_1:find("��%.") or iter_397_1:find("������") then
						var_0_0.Text(u8(ekgs_uk_arr[iter_397_0 + 2]))
					end
				end
			end
		else
			for iter_397_2 in string.gmatch(ekgs_uk, "[^\r\n]+") do
				var_0_0.Text(u8(iter_397_2))
			end
		end

		var_0_0.End()
	end
end

function showfp()
	if federal_p ~= nil and _G.mass[mkey] then
		var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_0_94 / 2, var_0_95 / 2), var_0_0.Cond.FirstUseEver,
			var_0_0.ImVec2(0.5, 0.5))
		var_0_0.SetNextWindowSize(var_0_0.ImVec2(1000, 600), var_0_0.Cond.FirstUseEver)
		var_0_0.Begin(u8("����������� �������������"), var_0_41, var_0_0.WindowFlags.HorizontalScrollbar)
		var_0_0.InputText(u8("����� �� ����"), var_0_99.federal_p_s)
		var_0_0.Separator()
		var_0_0.PushTextWrapPos()

		if var_0_99.federal_p_s.v:len() > 0 then
			var_0_0.Text(u8("�����: ") .. var_0_99.federal_p_s.v)

			for iter_398_0, iter_398_1 in pairs(federal_p_arr) do
				if u8(iter_398_1):find(var_0_99.federal_p_s.v) then
					var_0_0.Text(u8(iter_398_1))
				end
			end
		else
			for iter_398_2 in string.gmatch(federal_p, "[^\r\n]+") do
				var_0_0.Text(u8(iter_398_2))
			end
		end

		var_0_0.End()
	end
end

function sosCode()
	if tencodes.sos ~= "" then
		soscode = tencodes.sos or "SOS"
	end

	return soscode
end

function showekgsak()
	if ekgs_ak ~= nil and _G.mass[mkey] then
		var_0_0.SetNextWindowPos(var_0_0.ImVec2(var_0_94 / 2, var_0_95 / 2), var_0_0.Cond.FirstUseEver,
			var_0_0.ImVec2(0.5, 0.5))
		var_0_0.SetNextWindowSize(var_0_0.ImVec2(1000, 600), var_0_0.Cond.FirstUseEver)
		var_0_0.Begin(u8("���������������� ������"), var_0_39, var_0_0.WindowFlags.HorizontalScrollbar)
		var_0_0.InputText(u8("����� �� ����"), var_0_99.ekgs_ak_s)
		var_0_0.Separator()
		var_0_0.PushTextWrapPos()

		if var_0_99.ekgs_ak_s.v:len() > 0 then
			var_0_0.Text(u8("�����: ") .. var_0_99.ekgs_ak_s.v)

			for iter_400_0, iter_400_1 in pairs(ekgs_ak_arr) do
				if u8(iter_400_1):find(var_0_99.ekgs_ak_s.v) then
					if iter_400_0 > 0 and ekgs_ak_arr[iter_400_0 - 1] ~= nil then
						var_0_0.Text(u8(ekgs_ak_arr[iter_400_0 - 1]))
					end

					var_0_0.Text(u8(iter_400_1))

					if iter_400_0 < #ekgs_ak and ekgs_ak_arr[iter_400_0 + 1] ~= nil then
						var_0_0.Text(u8(ekgs_ak_arr[iter_400_0 + 1]))
					end

					if iter_400_1:find("��%.") or iter_400_1:find("������") and ekgs_ak_arr[iter_400_0 + 2] ~= nil then
						var_0_0.Text(u8(ekgs_ak_arr[iter_400_0 + 2]))
					end
				end
			end
		else
			for iter_400_2 in string.gmatch(ekgs_ak, "[^\r\n]+") do
				var_0_0.Text(u8(iter_400_2))
			end
		end

		var_0_0.End()
	end
end

function var_0_3.onPlayerQuit(arg_401_0, arg_401_1)
	if as then
		local var_401_0 = sampGetPlayerNickname(arg_401_0)

		if var_401_0 and as.other.id_list[var_401_0] ~= nil then
			as.other.id_list[var_401_0] = nil
		end
	end

	if rID ~= nil and rID ~= "" and arg_401_0 == rID then
		rID, rName, reaver, reaver_micro = nil, nil, false, false

		chat("������� ����� � ������.")
	end

	if active and im.warns.quits.v and sampIsPlayerConnected(tonumber(arg_401_0)) and sampGetPlayerHealth(tonumber(arg_401_0)) > 0 then
		local var_401_1 = ({
			[0] = "����/�����",
			"����� �� ����",
			"������",
			"�������",
			"���������� ��������",
			"������� ����� �������� ����������"
		})[arg_401_1]

		if var_401_1 then
			chat(string.format("%s[%d] ���������� �� �������. �������: %s.", sampGetPlayerNickname(arg_401_0), arg_401_0,
				var_401_1))

			as.other.offlist[#as.other.offlist + 1] = arg_401_0 ..
			"\t" ..
			sampGetPlayerNickname(arg_401_0) .. "\t" .. var_401_1 .. "\t" .. os.date("!%H:%M:%S", os.time() + 10800)
		end
	end

	if active then
		if var_0_34[sampGetPlayerNickname(arg_401_0)] and sampIs3dTextDefined(var_0_34[sampGetPlayerNickname(arg_401_0)]) then
			sampDestroy3dText(var_0_34[sampGetPlayerNickname(arg_401_0)])

			var_0_34[sampGetPlayerNickname(arg_401_0)] = nil
		end

		if as.other.newmansset[sampGetPlayerNickname(arg_401_0)] and sampIs3dTextDefined(as.other.newmansset[sampGetPlayerNickname(arg_401_0)]) then
			sampDestroy3dText(as.other.newmansset[sampGetPlayerNickname(arg_401_0)])

			as.other.newmansset[sampGetPlayerNickname(arg_401_0)] = nil
		end

		if suspect_id and _G.mass[mkey] and sampGetPlayerNickname(arg_401_0) == suspect_name and tonumber(arg_401_0) == tonumber(suspect_id) then
			if arg_401_1 == 0 then
				mreason = "����/�����"
			elseif arg_401_1 == 1 then
				mreason = "����� �� ����"
			elseif arg_401_1 == 2 then
				mreason = "������"
			elseif arg_401_1 == 3 then
				mreason = "�������"
			elseif arg_401_1 == 4 then
				mreason = "���������� ��������"
			elseif arg_401_1 == 5 then
				mreason = "������� ����� �������� ����������"
			end

			if mreason then
				chat("��� ������������ " ..
				sampGetPlayerNickname(arg_401_0) .. " [" .. arg_401_0 .. "] ����������. �������: " .. mreason .. ".")
				chat("�������� ���� �� ���������, ����� �� ������� \"" ..
				tostring(se.keys.pursuit_stop) .. "\", � ��������� ������.")

				mreason = nil
			end
		end
	end
end

function checkteam()
	while true do
		wait(0)

		for iter_402_0, iter_402_1 in pairs(var_0_33) do
			local var_402_0 = sampGetPlayerIdByNickname(iter_402_0)

			if var_402_0 and sampIsPlayerConnected(var_402_0) and var_0_33 and var_0_33[iter_402_0] and not var_0_34[iter_402_0] then
				local var_402_1 = sampCreate3dText(u8:decode(var_0_33[iter_402_0]), 4294967210, 0, 0, 0.9, 20, false,
					var_402_0, -1)

				var_0_34[iter_402_0] = var_402_1
			end
		end

		for iter_402_2, iter_402_3 in pairs(as.other.newmans) do
			local var_402_2 = sampGetPlayerIdByNickname(iter_402_2)

			if var_402_2 and sampIsPlayerConnected(var_402_2) and as.other.newmans and as.other.newmans[iter_402_2] and not as.other.newmansset[iter_402_2] and not var_0_33[iter_402_2] then
				local var_402_3 = sampCreate3dText(u8:decode(as.other.newmans[iter_402_2]), 4294967210, 0, 0, 0.9, 20,
					false, var_402_2, -1)

				as.other.newmansset[iter_402_2] = var_402_3
			end
		end

		wait(10000)
	end
end

function SearchMarker(arg_403_0, arg_403_1, arg_403_2, arg_403_3, arg_403_4)
	local var_403_0 = 0
	local var_403_1 = 0
	local var_403_2 = 0
	local var_403_3 = false

	for iter_403_0 = 0, 31 do
		local var_403_4 = 0

		if arg_403_4 then
			var_403_4 = 13103464 + iter_403_0 * 56
		else
			var_403_4 = 13098376 + iter_403_0 * 160
		end

		local var_403_5 = representIntAsFloat(readMemory(var_403_4 + 0, 4, false))
		local var_403_6 = representIntAsFloat(readMemory(var_403_4 + 4, 4, false))
		local var_403_7 = representIntAsFloat(readMemory(var_403_4 + 8, 4, false))

		if (var_403_5 ~= 0 or var_403_6 ~= 0 or var_403_7 ~= 0) and arg_403_3 > getDistanceBetweenCoords3d(var_403_5, var_403_6, var_403_7, arg_403_0, arg_403_1, arg_403_2) then
			var_403_0 = var_403_5
			var_403_1 = var_403_6
			var_403_2 = var_403_7
			var_403_3 = true
			arg_403_3 = getDistanceBetweenCoords3d(var_403_5, var_403_6, var_403_7, arg_403_0, arg_403_1, arg_403_2)
		end
	end

	return var_403_3, var_403_0, var_403_1, var_403_2
end

function getA()
	remote_srvname = 'server'

	if sampGetCurrentServerName():find('Legacy') then
		remote_srvname = 'legacy'
	elseif sampGetCurrentServerName():find('Underground') then
		remote_srvname = 'underground'
	elseif sampGetCurrentServerName():find('Revolution') then
		remote_srvname = 'revolution'
	end

	return true, remote_srvname
end

function var_0_0.CenterText(arg_407_0, arg_407_1)
	arg_407_1 = arg_407_1 or var_0_0.GetStyle().Colors[var_0_0.Col.Text]

	local var_407_0 = var_0_0.GetWindowWidth()

	for iter_407_0 in arg_407_0:gmatch("[^\n]+") do
		local var_407_1 = var_0_0.CalcTextSize(iter_407_0).x

		var_0_0.SetCursorPosX((var_407_0 - var_407_1) / 2)
		var_0_0.TextColored(arg_407_1, iter_407_0)
	end
end

function var_0_0.CenterFaText(arg_408_0)
	local var_408_0 = as.spd.column_width

	for iter_408_0 in arg_408_0:gmatch("[^\n]+") do
		local var_408_1 = var_0_0.CalcTextSize(iter_408_0).x

		var_0_0.SetCursorPosX((var_408_0 - var_408_1) / 2)
		var_0_0.Text(iter_408_0)
	end
end

function sendOraloDistance()
	if suspect_id and sampIsPlayerConnected(suspect_id) then
		local var_409_0, var_409_1 = sampGetCharHandleBySampPlayerId(suspect_id)

		if var_409_0 and doesCharExist(var_409_1) then
			local var_409_2, var_409_3, var_409_4 = getCharCoordinates(var_409_1)
			local var_409_5, var_409_6, var_409_7 = getCharCoordinates(playerPed)
			local var_409_8 = math.sqrt((var_409_2 - var_409_5) ^ 2 + (var_409_3 - var_409_6) ^ 2 +
			(var_409_4 - var_409_7) ^ 2)
			local var_409_9 = math.floor(tonumber(var_409_8))
			local var_409_10 = 60

			if not isPlayerInCopCar(playerPed) then
				var_409_10 = 30
			end

			if var_409_9 < var_409_10 then
				_G.sampAddChatMessage(" ������������ ������� ���� ���������� �� ���������� " .. var_409_9 .. " �.", 32768)
			else
				_G.sampAddChatMessage(
				" ������������ �� ������� ���� ����������, ��������� ���������� �� " ..
				var_409_10 .. " ������. ������ " .. var_409_9 .. " �.", 16711680)
			end
		else
			_G.sampAddChatMessage(" ������������ �� ������� ���� ����������, �� �� � ���� ���������.", 16711680)
		end
	else
		_G.sampAddChatMessage(" ������������ ����������.", 16711680)
	end
end

function datefull()
	return
end

function getFpsStr(arg_413_0)
	if arg_413_0 >= 60 then
		return string.format("{00FF00}%d{FFFFFF}", arg_413_0)
	end

	if arg_413_0 >= 30 then
		return string.format("{FFD700}%d{FFFFFF}", arg_413_0)
	end

	return string.format("{FF0000}%d{FFFFFF}", arg_413_0)
end

function getCaps(arg_414_0)
	if arg_414_0 == 0 then
		return "{B22222}Off{FFFFFF}"
	end

	return "{008000}On{FFFFFF}"
end

function getNum(arg_415_0)
	if arg_415_0 == 0 then
		return "{B22222}Off{FFFFFF}"
	end

	return "{008000}On{FFFFFF}"
end

function getPing(arg_416_0)
	if arg_416_0 >= 150 then
		return string.format("{FF0000}%d{FFFFFF}", arg_416_0)
	end

	if arg_416_0 >= 100 then
		return string.format("{FFFF00}%d{FFFFFF}", arg_416_0)
	end

	if arg_416_0 >= 60 then
		return string.format("{00FF00}%d{FFFFFF}", arg_416_0)
	end

	return string.format("{00FF00}%d{FFFFFF}", arg_416_0)
end

function getLvl(arg_417_0)
	if arg_417_0 >= 30 then
		return string.format("{FF4500}%d{FFFFFF}", arg_417_0)
	end

	if arg_417_0 >= 25 then
		return string.format("{FF00FF}%d{FFFFFF}", arg_417_0)
	end

	if arg_417_0 >= 20 then
		return string.format("{00FFFF}%d{FFFFFF}", arg_417_0)
	end

	if arg_417_0 >= 15 then
		return string.format("{00FF00}%d{FFFFFF}", arg_417_0)
	end

	if arg_417_0 >= 10 then
		return string.format("{FFFF00}%d{FFFFFF}", arg_417_0)
	end

	if arg_417_0 >= 5 then
		return string.format("{A0522D}%d{FFFFFF}", arg_417_0)
	end

	return string.format("{FFFFFF}%d{FFFFFF}", arg_417_0)
end

function getPlayerSeatId(arg_418_0)
	local var_418_0, var_418_1 = sampGetCharHandleBySampPlayerId(arg_418_0)

	if var_418_0 and isCharInAnyCar(var_418_1) then
		local var_418_2 = storeCarCharIsInNoSave(var_418_1)

		for iter_418_0 = 0, getMaximumNumberOfPassengers(var_418_2) do
			if not isCarPassengerSeatFree(var_418_2, iter_418_0) and getCharInCarPassengerSeat(var_418_2, iter_418_0) == var_418_1 then
				return iter_418_0
			end
		end
	end

	return nil
end

function getblack()
	getblack = false
end

function gn()
	gnUserID = 1
	gnName = myName
end

function getTimeOfDay()
	local var_425_0 = os.date("%H")

	if tonumber(var_425_0) >= 23 then
		return "������ ����"
	elseif tonumber(var_425_0) >= 0 and tonumber(var_425_0) <= 5 then
		return "������ ����"
	elseif tonumber(var_425_0) >= 6 and tonumber(var_425_0) <= 11 then
		return "������ ����"
	elseif tonumber(var_425_0) >= 12 and tonumber(var_425_0) <= 17 then
		return "������ ����"
	elseif tonumber(var_425_0) >= 18 and tonumber(var_425_0) <= 22 then
		return "������ �����"
	end

	return ""
end

function activate()
	active = true
	licdate = 29
	_G.buy[144] = 'http://pdp.deadpoo.net/'
end

function var_0_0.CheckBox(arg_429_0, arg_429_1, arg_429_2)
	local var_429_0 = var_0_0.GetCursorScreenPos()
	local var_429_1 = var_0_0.GetWindowDrawList()
	local var_429_2 = var_0_0.GetTextLineHeightWithSpacing() + var_0_0.GetStyle().FramePadding.y / 2
	local var_429_3 = var_429_2
	local var_429_4 = arg_429_2 == nil and arg_429_0 or arg_429_2

	if var_0_0.InvisibleButton("##" .. var_429_4, var_0_0.ImVec2(var_429_3, var_429_2)) then
		arg_429_1.v = not arg_429_1.v
	end

	local var_429_5

	if var_0_0.IsItemHovered() then
		var_429_5 = var_0_0.GetColorU32(var_0_0.GetStyle().Colors[var_0_0.Col.FrameBgHovered])
	else
		var_429_5 = var_0_0.GetColorU32(var_0_0.GetStyle().Colors[var_0_0.Col.FrameBg])
	end

	var_429_1:AddRectFilled(var_429_0, var_0_0.ImVec2(var_429_0.x + var_429_3, var_429_0.y + var_429_2), var_429_5,
		var_0_0.GetStyle().FrameRounding)
	var_429_1:AddRectFilled(var_429_0, var_0_0.ImVec2(var_429_0.x + var_429_3, var_429_0.y + var_429_2),
		var_0_0.GetColorU32(arg_429_1.v and var_0_0.GetStyle().Colors[var_0_0.Col.ButtonActive] or
		var_0_0.GetStyle().Colors[var_0_0.Col.Button]), var_0_0.GetStyle().FrameRounding)
	var_0_0.SameLine(var_0_0.GetStyle().ItemSpacing.x + var_429_3 + var_0_0.GetStyle().FramePadding.x)
	var_0_0.AlignTextToFramePadding()
	var_0_0.Text(arg_429_0)
end

function var_0_3.onSendChat(arg_430_0)
	if active and arg_430_0:find("%{.+%}") then
		return {
			gsub(arg_430_0)
		}
	end

	if se and se.main.perenos then
		if var_0_23 then
			return true
		end

		local var_430_0 = {}
		local var_430_1 = var_0_22 - 3

		while arg_430_0:len() > var_0_22 do
			table.insert(var_430_0, "..." .. arg_430_0:sub(1, var_430_1) .. "...")

			arg_430_0 = arg_430_0:sub(var_430_1 + 1, arg_430_0:len())
		end

		table.insert(var_430_0, "..." .. arg_430_0)

		var_430_0[1] = var_430_0[1]:sub(4, var_430_0[1]:len())
		var_0_23 = true

		local var_430_2 = false

		for iter_430_0, iter_430_1 in pairs(var_430_0) do
			if #var_430_0 == 1 then
				var_430_2 = true
			end

			if var_430_2 == true then
				awaitSendChat(iter_430_1, 1, var_430_2 == true and 0 or 1200, false)
			end
		end

		if not var_430_2 then
			awaitSendChat(var_430_0, 1, 1200, true, true)
		else
			var_0_23 = false
		end

		return false
	end

	sendtime = os.clock() * 1000
end

function args(arg_431_0)
	local var_431_0, var_431_1, var_431_2 = getCharCoordinates(playerPed)

	arg_431_0 = arg_431_0:gsub("{nick}", tostring(userNick))
	arg_431_0 = arg_431_0:gsub("{rpnick}", tostring(userNick:gsub("_", " ")))
	arg_431_0 = arg_431_0:gsub("{hi}", tostring("�����������, � � " .. userNick:gsub("_", " ") .. "."))
	arg_431_0 = arg_431_0:gsub("{id}", tostring(myID))
	arg_431_0 = arg_431_0:gsub("{fraction}", tostring(frac and frac or ""))
	arg_431_0 = arg_431_0:gsub("{rank}", tostring(rang and rang or ""))
	arg_431_0 = arg_431_0:gsub("{time}", tostring(os.date("%H:%M:%S")))
	arg_431_0 = arg_431_0:gsub("{date}", tostring(os.date("%d.%m.%Y")))
	arg_431_0 = arg_431_0:gsub("{kvadrat}", tostring(kvad(playerPed)))
	arg_431_0 = arg_431_0:gsub("{tag}", tostring(se.main.tag))
	arg_431_0 = arg_431_0:gsub("{zone}", tostring(calcZ(var_431_0, var_431_1, var_431_2)))
	arg_431_0 = arg_431_0:gsub("{city}", tostring(getCity()))

	return arg_431_0
end

function getCity()
	local var_432_0 = getCityPlayerIsIn(playerPed)

	if var_432_0 > 0 then
		return as.other.citiesList[var_432_0]
	else
		return "��� �������"
	end
end

function sampGetAllTextDraws()
	local var_433_0 = {}

	pTd = sampGetTextdrawPoolPtr() + 9216

	for iter_433_0 = 0, 2303 do
		if readMemory(pTd + iter_433_0 * 4, 4) ~= 0 then
			table.insert(var_433_0, iter_433_0)
		end
	end

	return var_433_0
end

function var_0_3.onShowTextDraw(arg_434_0, arg_434_1)
	if active and se.squad.state and arg_434_1.text:find("~w~SQUAD") then
		as.textdraw.squad_id = arg_434_0

		getSquadUsers(sampTextdrawGetStyle(arg_434_0))

		as.textdraw.squad_status = true
		as.textdraw.squad_updated = os.time()

		return false
	end

	if as and im.windows.speedometr.v and arg_434_1.position.x >= 474 and arg_434_1.position.x <= 603 and arg_434_1.position.y >= 361 and arg_434_1.position.y <= 419 then
		as.other.deletedTextdraws[arg_434_0] = {
			x = arg_434_1.position.x,
			y = arg_434_1.position.y
		}
		arg_434_1.position.x = 2000 + arg_434_0 / 10
		arg_434_1.position.y = 3000 + arg_434_0 / 10

		return {
			arg_434_0,
			arg_434_1
		}
	end
end

function onceDeleteSpeedometer()
	for iter_435_0 = 0, 2500 do
		if sampTextdrawIsExists(iter_435_0) then
			local var_435_0, var_435_1 = sampTextdrawGetPos(iter_435_0)

			if var_435_0 >= 474 and var_435_0 <= 603 and var_435_1 >= 361 and var_435_1 <= 419 then
				as.other.deletedTextdraws[iter_435_0] = {
					x = var_435_0,
					y = var_435_1
				}

				sampTextdrawSetPos(iter_435_0, 2000 + iter_435_0 / 10, 3000 + iter_435_0 / 10)
			end
		end
	end
end

function restoreSpeedometer()
	if as then
		for iter_436_0, iter_436_1 in pairs(as.other.deletedTextdraws) do
			if sampTextdrawIsExists(iter_436_0) then
				sampTextdrawSetPos(iter_436_0, iter_436_1.x, iter_436_1.y)
			end
		end
	end
end

function var_0_3.onTextDrawSetString(arg_437_0, arg_437_1)
	if as and arg_437_1:find("FUEL %~%S%~%d+") then
		as.speedometr.fuel = arg_437_1:gsub("FUEL ~%S~", "")
	end

	if active and se.squad.state and arg_437_1:find("~w~SQUAD") then
		as.textdraw.squad_status = true
		as.textdraw.squad_updated = os.time()

		getSquadUsers(arg_437_1)

		if sampTextdrawIsExists(arg_437_0) then
			sampTextdrawDelete(arg_437_0)
		end
	end
end

function getSquadTextdrawId()
	local var_438_0 = sampGetAllTextDraws()

	if var_438_0 and #var_438_0 > 0 then
		for iter_438_0, iter_438_1 in pairs(var_438_0) do
			local var_438_1 = sampTextdrawGetString(iter_438_1)

			if var_438_1 and var_438_1:find("~w~SQUAD") then
				as.textdraw.squad_id = iter_438_1

				return iter_438_1
			end
		end
	end

	return 0
end

function var_0_3.onTextDrawHide(arg_439_0)
	if as and arg_439_0 == as.textdraw.squad_id then
		tmpRemove("squad-info")

		as.textdraw.squad_status = false
	end
end

function explode(arg_440_0, arg_440_1)
	if arg_440_0 == nil then
		arg_440_0 = "%s"
	end

	local var_440_0 = {}

	for iter_440_0 in string.gmatch(arg_440_1, "([^" .. arg_440_0 .. "]+)") do
		table.insert(var_440_0, iter_440_0)
	end

	return var_440_0
end

function getSquadUsers(arg_441_0)
	arg_441_0 = tostring(arg_441_0)

	if arg_441_0 == nil or arg_441_0 == "" then
		return {}
	end

	arg_441_0 = arg_441_0:gsub("%~w%~SQUAD", "")
	arg_441_0 = arg_441_0:gsub("%~b%~", "")
	arg_441_0 = arg_441_0:gsub("%~n%~", "\n")

	local var_441_0 = explode("\n", arg_441_0)

	if var_441_0 then
		as.textdraw.squad_users = var_441_0
	end

	return var_441_0
end

function checkSquad()
	if se.squad.state then
		local var_442_0 = getSquadTextdrawId()

		if var_442_0 ~= 0 then
			as.textdraw.squad_id = var_442_0
			as.textdraw.squad_users = getSquadUsers(sampTextdrawGetString(var_442_0))
			as.textdraw.squad_status = true

			sampTextdrawDelete(var_442_0)
			tmpRemove("squad-info")
		else
			local var_442_1 = tmpGet("squad-info")

			if var_442_1 ~= "" then
				local var_442_2 = decodeJson(var_442_1)

				if var_442_2 and getGxtText("GLOBAL_GAME_STATE") == var_442_2.squad_code then
					as.textdraw = var_442_2

					tmpRemove("squad-info")
					checkSquad()
				end
			end
		end
	end
end

function sampSendSystemChat(arg_443_0)
	arg_443_0 = tostring(arg_443_0)

	if tostring(arg_443_0):len() > 0 then
		if tostring(arg_443_0):find("^%/.*") then
			local var_443_0 = se.main.tag:gsub("%[", "%%["):gsub("%]", "%%]"):gsub("%(", "%%("):gsub("%)", "%%)"):gsub(
			"%-", "%%-"):gsub("%.", "%%."):gsub("%+", "%%+"):gsub("%#", "%%#"):gsub("%:", "%%:"):gsub("%/", "%%/")

			if not tostring(arg_443_0):find("%/r " .. u8:decode(var_443_0) .. " ") and not tostring(arg_443_0):find("%/r %� %[.*%]") then
				arg_443_0 = tostring(arg_443_0):gsub("%/r ",
					"%/r" .. (se.main.tag ~= nil and se.main.tag ~= "" and " " .. u8:decode(se.main.tag) or "") .. " ")
			end

			if not tostring(arg_443_0):find("%/f " .. u8:decode(var_443_0) .. " ") and not tostring(arg_443_0):find("%/f %� %[.*%]") then
				arg_443_0 = tostring(arg_443_0):gsub("%/f ",
					"%/f" .. (se.main.tag ~= nil and se.main.tag ~= "" and " " .. u8:decode(se.main.tag) or "") .. " ")
			end

			local var_443_1 = raknetNewBitStream()

			raknetBitStreamWriteInt32(var_443_1, arg_443_0:len())
			raknetBitStreamWriteString(var_443_1, arg_443_0)
			raknetSendRpc(50, var_443_1)

			sendtime = os.clock() * 1000
		else
			local var_443_2 = raknetNewBitStream()

			raknetBitStreamWriteInt8(var_443_2, arg_443_0:len())
			raknetBitStreamWriteString(var_443_2, arg_443_0)
			raknetSendRpc(101, var_443_2)

			sendtime = os.clock() * 1000
		end
	end
end

function var_0_3.onSendCommand(arg_444_0)
	if arg_444_0 == "/getpdperror" then
		error(1)
	end

	if arg_444_0 == "/rcn" then
		reconnect()
	end

	if active then
		local var_444_0 = se.main.tag:gsub("%[", "%%["):gsub("%]", "%%]"):gsub("%(", "%%("):gsub("%)", "%%)"):gsub("%-",
			"%%-"):gsub("%.", "%%."):gsub("%+", "%%+"):gsub("%#", "%%#"):gsub("%:", "%%:"):gsub("%/", "%%/")

		if arg_444_0:find("^/f%s.+") and se.main.tag ~= "" and not arg_444_0:find("^/f " .. u8:decode(var_444_0)) and not arg_444_0:find("%/r %� %[.*%]") then
			arg_444_0 = arg_444_0:gsub("^/f ", "/f " .. u8:decode(se.main.tag) .. " ")
		end

		if arg_444_0:find("^/r%s.+") and se.main.tag ~= "" and not arg_444_0:find("^/r " .. u8:decode(var_444_0)) and not arg_444_0:find("%/r %� %[.*%]") then
			arg_444_0 = arg_444_0:gsub("^/r ", "/r " .. u8:decode(se.main.tag) .. " ")
		end

		if arg_444_0:find("^%/thanks%s%d+") then
			local var_444_1 = arg_444_0:match("^%/thanks%s(%d+)$")

			if var_444_1 then
				local var_444_2 = tonumber(var_444_1)

				if tostring(var_444_2) == tostring(sampGetPlayerIdByCharHandle(playerPed)) then
					as.other.thank_name = sampGetPlayerNickname(sampGetPlayerIdByCharHandle(playerPed))
				elseif sampIsPlayerConnected(var_444_2) then
					as.other.thank_name = sampGetPlayerNickname(var_444_2)
				else
					chat("����� �������.")

					return false
				end

				as.other.sendthanks, as.other.sendthanks_error = true, false

				sampSendSystemChat("/mdc " .. var_444_2)
			else
				chat("������� /thanks ID, ����� ������������� ������ � /dep.")
			end

			return false
		end

		if arg_444_0 == "/recuff" then
			chat("������� /recuff ID, ����� ���������� ���������.")
		end

		if arg_444_0:find("^%/recuff%s%d+") then
			local var_444_3 = arg_444_0:match("%/recuff%s(%d+)")

			if var_444_3 then
				awaitSendChat("/uncuff " .. trim(var_444_3), 1, 1)
				awaitSendChat("/cuff " .. trim(var_444_3), 1, 1)
			else
				chat("������� /recuff ID, ����� ���������� ���������.")
			end

			return false
		end

		if arg_444_0:find("^%/id%s%d+$") then
			local var_444_4 = arg_444_0:match("^%/id%s(%d+)$")

			if var_444_4 and sampIsPlayerConnected then
				as.other.lastCheckedId = var_444_4
			end
		end

		if arg_444_0 == "/prs" then
			se.main.partner = ""

			am("�������� ������.")
		end

		if arg_444_0 == "/offlist" then
			if not im.warns.quits.v then
				chat("�������� ������� �������������� ������ ������� �� ����.")

				return false
			end

			if #as.other.offlist == 0 then
				chat("������ ����.")

				return false
			end

			sampShowDialog(84142, "{FFFFFF}����� �� ���� � ���� ���������",
				"ID\t������� ���\t�������\t�����\n" .. table.concat(as.other.offlist, "\n"), "Ok", "Cancel", "5")

			return false
		end

		if arg_444_0 == "/smslog" then
			if im.settings.smslog.v then
				getSmsLog()

				im.windows.smslogs.v = not im.windows.smslogs.v
			else
				am("������� ����������� ��������� � ����������.")
			end

			return false
		end

		if arg_444_0:find("%{.+%}") then
			return {
				gsub(arg_444_0)
			}
		end

		if arg_444_0 == "/deplog" then
			if im.settings.deplog.v then
				im.windows.deplog.v = not im.windows.deplog.v
			else
				am("������� ����������� ��������� � ����������.")
			end

			return false
		end

		if arg_444_0 == "/pdefuse" then
			if rank_state then
				chat("���������, ���� PD-Project ������� ���� ������..")
			else
				im.windows.defuse.v = not im.windows.defuse.v
			end

			return false
		end

		if arg_444_0 == "/pdaid" then
			if rank_state then
				chat("���������, ���� PD-Project ������� ���� ������..")
			else
				as.aid_window_size = 65 + 45 * aidCount()
				im.windows.aid.v = not im.windows.aid.v
			end

			return false
		end

		if arg_444_0 == "/cwlog" then
			if im.settings.clearwantedlog.v then
				im.windows.clearwantedlog.v = not im.windows.clearwantedlog.v
			else
				am("������� ����������� ��������� � ����������.")
			end

			return false
		end

		if arg_444_0:find("%/cfbi") then
			if myfrac == "4" or myName == "Serhiy_Rubin" then
				cfbi, cfbi_id, cfbi_name, cfbi_frac, cfbi_minutes, cfbi_error = false, nil, nil, nil, nil, false

				local var_444_5, var_444_6 = arg_444_0:match("%/cfbi%s(%d+)%s(%d+)")

				if var_444_5 and var_444_6 then
					if sampIsPlayerConnected(tostring(var_444_5)) then
						if var_444_6 and tonumber(var_444_6) > 0 then
							cfbi, cfbi_id, cfbi_name, cfbi_minutes = true, var_444_5,
								sampGetPlayerNickname(var_444_5):gsub("_", " "), var_444_6

							chat("������� ������ �������, ��������..")
							sampSendChat("/mdc " .. var_444_5)
						else
							chat("������� �������� ����� ������ ����.")
						end
					else
						chat("��������� ������������� �� ������!")
					end
				else
					chat("������� /cfbi id minutes - ����� ������� ������ � ���� ���.")
				end
			else
				chat("�������� ��� ���.")
			end

			return false
		end

		if im.settings.seeme.v and string.lower(arg_444_0):match("^%/seeme .*") then
			if arg_444_0:find("/seeme") then
				local var_444_7 = arg_444_0:match("^%/seeme (.*)")

				if not seeme_last or seeme_last ~= var_444_7 then
					_G.sampAddChatMessage(" SeeMe: {FFFFFF}" .. var_444_7, 9662683)
				end

				seeme_last = var_444_7
			elseif arg_444_0:find("/seeMe") then
				local var_444_8 = arg_444_0:match("^%/seeMe (.*)")

				if not seeme_last or seeme_last ~= var_444_8 then
					_G.sampAddChatMessage(" SeeMe: {FFFFFF}" .. var_444_8, 9662683)
				end

				seeme_last = var_444_8
			end
		end

		if im.settings.seedo.v and string.lower(arg_444_0):match("^%/seedo .*") then
			if arg_444_0:find("/seedo") then
				local var_444_9 = arg_444_0:match("^%/seedo (.*)")

				if not seedo_last or seedo_last ~= var_444_9 then
					_G.sampAddChatMessage(" SeeDo: {FFFFFF}" .. var_444_9, 16747520)
				end

				seedo_last = var_444_9
			elseif arg_444_0:find("/seeDo") then
				local var_444_10 = arg_444_0:match("^%/seeDo (.*)")

				if not seedo_last or seedo_last ~= var_444_10 then
					_G.sampAddChatMessage(" SeeDo: {FFFFFF}" .. var_444_10, 16747520)
				end

				seedo_last = var_444_10
			end
		end

		if arg_444_0 == "/jrules" then
			im.windows.jrules.v = not im.windows.jrules.v
		end

		if arg_444_0 == "/dmlog" then
			local var_444_11 = {}

			for iter_444_0, iter_444_1 in pairs(im.arr.kills) do
				local var_444_12 = iter_444_1[1]
				local var_444_13 = iter_444_1[2]
				local var_444_14 = iter_444_1[3]
				local var_444_15 = iter_444_1[4]

				table.insert(var_444_11,
					var_444_12 .. " [" .. var_444_13 .. "]\t" .. getGun(var_444_15) .. "\t" .. math.floor(var_444_14))
			end

			sampShowDialog(2343, "���� ����������� ��� �����",
				"����� [ID]\t������\t����\n" .. table.concat(var_444_11, "\n"), "Ok", "Cancel", 5)
		end

		if arg_444_0 == "/pdreset" then
			sampShowDialog(4827, "����� �������� ��������",
				"{FF0000}|{FFFFFF} �� ������������� ������ �������� ��������� ��������? \n{FF0000}|{FFFFFF} ��� ������� ����� �������, ��� �������� � �����������. \n{FF0000}|{FFFFFF} ����� ������ �������� ���������� ������� ���������� ���������.",
				"��", "���", 0)
		end

		if arg_444_0 == "/sgr" then
			if tostring(myfrac) == "4" then
				if as.other.grenade == 0 then
					as.other.grenade = 1

					chat("�� ����������� �� ������������ �������.")
				else
					as.other.grenade = 0

					chat("�� ����������� �� ������� �������.")
				end
			else
				chat("�������� ��� ���.")
			end
		end

		if arg_444_0:find("%/cuff%s%d+") and im.sounds.tighten.v then
			local var_444_16 = var_0_9.BASS_StreamCreateFile(false, "moonloader/PD-Project/resource/m/tighten.wav", 0, 0,
				0)

			var_0_9.BASS_ChannelSetAttribute(var_444_16, BASS_ATTRIB_VOL, im.sounds.volume.v)
			var_0_9.BASS_ChannelPlay(var_444_16, false)
		end
	end

	if active then
		for iter_444_2, iter_444_3 in pairs(ntData) do
			if arg_444_0 == "/" .. iter_444_3.command then
				showNotes(iter_444_3.command)
			end
		end
	end

	if active and se.main.perenos and (arg_444_0:find("^%/t%s") or arg_444_0:find("^%/sms%s") or arg_444_0:find("^%/r%s") or arg_444_0:find("^%/rb%s") or arg_444_0:find("^%/f%s") or arg_444_0:find("^%/fb%s") or arg_444_0:find("^%/fs%s") or arg_444_0:find("^%/j%s") or arg_444_0:find("^%/me%s") or arg_444_0:find("^%/do%s")) and not var_0_23 and arg_444_0:find(" ") then
		local var_444_17 = var_0_22
		local var_444_18 = var_0_21
		local var_444_19, var_444_20 = arg_444_0:find(" ")

		if arg_444_0:find("^/t%s%d+%s") or arg_444_0:find("^/sms%s%d+%s+") then
			if arg_444_0:find("^/t") then
				local var_444_21 = arg_444_0:match("%/t%s(%d+)%s")

				if var_444_21 and sampIsPlayerConnected(var_444_21) then
					local var_444_22 = sampGetPlayerNickname(var_444_21)
					local var_444_23 = "SMS: . ����������: " .. var_444_22 .. "[" .. var_444_21 .. "]"

					var_444_17 = var_444_17 + 5 - var_444_23:len()
				end

				commandText = arg_444_0:match("(/t%s%d+)")
				arg_444_0 = arg_444_0:gsub(commandText, " ")
			elseif arg_444_0:find("/sms") then
				local var_444_24 = arg_444_0:match("%/sms%s(%d+)%s")

				if var_444_24 and sampIsPlayerConnected(var_444_24) then
					local var_444_25 = sampGetPlayerNickname(var_444_24)

					var_444_17 = var_444_17 - ("SMS: . ����������: " .. var_444_25 .. "[" .. var_444_24 .. "]"):len()
				end

				commandText = arg_444_0:match("(/sms%s%d+)")
				arg_444_0 = arg_444_0:gsub(commandText, "   ")
			end
		else
			commandText = arg_444_0:sub(0, var_444_19 - 1)
		end

		local var_444_26 = arg_444_0:sub(var_444_19, arg_444_0:len())
		local var_444_27 = {}
		local var_444_28 = var_444_17 - 3

		while var_444_26:len() > var_0_22 do
			table.insert(var_444_27, "..." .. var_444_26:sub(1, var_444_28) .. "...")

			var_444_26 = var_444_26:sub(var_444_28 + 1, var_444_26:len())
		end

		table.insert(var_444_27, "..." .. var_444_26)

		var_444_27[1] = var_444_27[1]:sub(4, var_444_27[1]:len())

		if commandText:find("^%/r%s") or commandText:find("^%/f%s") then
			var_0_23 = true

			local var_444_29 = false
			local var_444_30 = {}

			for iter_444_4, iter_444_5 in pairs(var_444_27) do
				if iter_444_5:sub(0, 1) ~= " " then
					iter_444_5 = " " .. iter_444_5
				end

				if #var_444_27 == 1 then
					var_444_29 = true

					awaitSendChat(commandText .. iter_444_5, 1, 0, false, true)
				end

				var_444_30[#var_444_30 + 1] = commandText .. iter_444_5
			end

			if not var_444_29 then
				awaitSendChat(var_444_30, 1, 1200, true, true)
			end

			if im.informer.infMainAutoRadio.v and not commandText:find("%/rb") and not commandText:find("%/fb") then
				if tostring(myfrac) == "4" then
					if isPlayerCop(fbi, getCharModel(playerPed)) then
						awaitSendChat("/seeDo ����� ������ ��������� � �������� ���������", 0, 1200, false)
					end
				elseif isPlayerCop(cop, getCharModel(playerPed)) then
					awaitSendChat("/seeDo �������� ���-�� �� �����", 0, 1200, false)
				end
			end
		else
			var_0_23 = true

			local var_444_31 = false
			local var_444_32 = {}

			for iter_444_6, iter_444_7 in pairs(var_444_27) do
				if iter_444_7:sub(0, 1) ~= " " then
					iter_444_7 = " " .. iter_444_7
				end

				if #var_444_27 == 1 then
					var_444_31 = true

					awaitSendChat(commandText .. iter_444_7, 1, 0, false, true)
				end

				var_444_32[#var_444_32 + 1] = commandText .. iter_444_7
			end

			if not var_444_31 then
				awaitSendChat(var_444_32, 1, 1200, true, true)
			end
		end

		return false
	end

	sendtime = os.clock() * 1000
end

function showNotes(arg_445_0)
	if ntData[arg_445_0] then
		note_for_show = arg_445_0
		im.windows.notes_show.v = true
	end
end

function var_0_3.onSendTakeDamage(arg_446_0, arg_446_1, arg_446_2)
	if active and se.main.auto_su and _G.mass[mkey] and arg_446_0 ~= nil and arg_446_0 ~= moid then
		au_su_id = arg_446_0
		au_su_gun = arg_446_2
		moid = arg_446_0

		if au_su_gun == 24 then
			gun = "Deagle"
		elseif au_su_gun == 25 then
			gun = "Shotgun"
		elseif au_su_gun == 30 then
			gun = "AK-47"
		elseif au_su_gun == 31 then
			gun = "M4"
		elseif au_su_gun == 33 then
			gun = "Rifle"
		end

		if au_su_gun == 24 or au_su_gun == 25 or au_su_gun == 30 or au_su_gun == 31 or au_su_gun == 33 then
			keySu = au_su_id

			return false
		end
	end

	lua_thread.create(function()
		if active and arg_446_0 ~= nil and sampIsPlayerConnected(arg_446_0) then
			local var_447_0 = sampGetPlayerNickname(arg_446_0)

			table.insert(im.arr.kills, {
				var_447_0,
				arg_446_0,
				arg_446_1,
				arg_446_2
			})
		end
	end)
end

function isCharInCarDriver(arg_448_0)
	return isCharInAnyCar(arg_448_0) and getDriverOfCar(storeCarCharIsInNoSave(arg_448_0)) == arg_448_0
end

function show_i()
	wait(12000)

	if not se.info.i_73 and se.info.i_73 ~= false then
		sampShowDialog(854, "��",
			"{7B68EE}| {FFFFFF}������, " ..
			myName:gsub("_", " ") .. ". ����� ���������� v" .. thisScript().version .. "!\n\t\t\n\t\t" .. changelog, "OK",
			"", 0)

		se.info.i_73 = false

		save_settings()
	end
end

changelog =
"{FFFFFF}\n� � ���� ���������� ���������� ��������� ������ �� ������ ������� ����������.\n\n� ��������� ������ ��� ������ ������� �������\n� ����� ������ ���������� �������� ���� ���� �������� ����������, ������� AdBlock ���� ���������� ��� ���\n� ��������� ������� ������� \"��������� /patrul\" �� ����� �������������\n� �������� ��� � /f\n� ���������� ������� ����� ����� � ���� (��� - ������� �����), ����������� ����� �� ������� ��� ���\n� ��������� ������ �� 24 ������� ��� SQUAD\n� �������� ����� /ceject � /cuff ��������� �����\n� ���������� ��������� ��������� �������� ������ ������ �� ������ ������\n� ��������� ������������ ��������� � /rh\n� ��������� ������� /pdaid - ������ ����������� ������ (������ /pdefuse)\n� �������� ������� ���������� �����\n� ��������� ��� � ������ � ����� /mic\n� ���������� /rmdc, /smdc\n� ��������� ������� /thanks ID - ��������� ������������� � /dep\n� ��������� ������� /cmdc ID - ��������� /mdc � ������� ����� ������� �������\n\n���������� ������ ��������.\n������ ���������� - ���������� ������� ������������ (�� ����������� ���� ���� ������� ������ �����, ��������).\n\n� ���� ��� ���-�� ������� ������ � ��� ������������� ����� ������� ��� ��� � ������, ����� ����������� � ������� ����� � �������������.\n\n� �������� � ���������� �������� �������� -> {00FF00}vk.com/samp_pdp{FFFFFF}\n\n�������� ���� � �������� ����������!\n\n2018-2024 � Karimoff Dev. & William Tudor [karimoff.dev]\n"

function ss(arg_450_0)
	if arg_450_0 ~= "" and _G.mass[mkey] then
		if sampIsPlayerConnected(arg_450_0) then
			if sud then
				sstab = {}

				for iter_450_0 = 1, 100 do
					if sud.a[iter_450_0] then
						if #sud.a[iter_450_0] > 0 then
							table.insert(sstab,
								sud.d[iter_450_0] ..
								sud.a[iter_450_0] ..
								"\t" ..
								sud.d[iter_450_0] .. sud.b[iter_450_0] .. "\t" .. sud.d[iter_450_0] .. sud.c[iter_450_0])
						else
							table.insert(sstab, "--\t--\t--")
						end
					end
				end

				qqId = arg_450_0
				qqNick = sampGetPlayerNickname(arg_450_0):gsub("_", " ")

				sampShowDialog(187, "������ � ������ ������ " .. qqNick,
					"������\t�������� ������\t������� �������\n�������� ������\t\t\n" .. table.concat(sstab, "\n"),
					"�������", "�������", 5)
			else
				am("���� �����������, ��������.")
			end
		else
			chat("������� ���������� ID.")
		end
	end
end

function p(arg_451_0)
	arg_451_0 = arg_451_0 + sampGetPlayerPing(select(2, sampGetPlayerIdByCharHandle(playerPed)))

	return tonumber(arg_451_0)
end

function try(arg_452_0)
	pcall(arg_452_0)
end

function getKM(arg_453_0)
	if doesCharExist(arg_453_0) and isCharInAnyCar(arg_453_0) then
		local var_453_0 = storeCarCharIsInNoSave(arg_453_0)

		if var_453_0 and doesVehicleExist(var_453_0) then
			speedMile = getCarSpeed(var_453_0)
			speedKM = math.ceil(speedMile * 2)
		else
			speedKM = "-"
		end
	else
		speedKM = "-"
	end

	return speedKM
end

function getClr(arg_454_0)
	return string.format("%06X", ARGBtoRGB(tonumber(arg_454_0)))
end

function ARGBtoRGB(arg_455_0)
	local var_455_0 = bit.band(bit.rshift(arg_455_0, 24), 255)
	local var_455_1 = bit.band(bit.rshift(arg_455_0, 16), 255)
	local var_455_2 = bit.band(bit.rshift(arg_455_0, 8), 255)
	local var_455_3 = bit.band(arg_455_0, 255)
	local var_455_4 = bit.bor(var_455_3, bit.lshift(var_455_2, 8))

	return (bit.bor(var_455_4, bit.lshift(var_455_1, 16)))
end

function var_0_3.onServerMessage(arg_456_0, arg_456_1)
	if lastactivity and os.time() - lastactivity > 15 and not notactive then
		lua_thread.create(function()
			as.other.onafktime = as.other.onafktime + (os.time() - lastactivity)
			notactive = true

			wait(2000)

			notactive = false
		end)
	end

	if active then
		if se.main.adblock then
			if arg_456_0 == 14221567 and (arg_456_1:find("����������%:.+�������.+���%:.+") or arg_456_1:find("�������� News .*%. ��������������.*") or arg_456_1:find("�������� News .+%. �������� ��������.+")) then
				local var_456_0 = false

				if se.other.adblockignore ~= nil and se.other.adblockignore ~= "" then
					if not se.other.adblockignore:find("%,") and arg_456_1:find(se.other.adblockignore) then
						var_456_0 = true
					end

					if se.other.adblockignore:find("%,") then
						local var_456_1 = explode(",", se.other.adblockignore)

						if var_456_1 then
							for iter_456_0, iter_456_1 in pairs(var_456_1) do
								if trim(iter_456_1) ~= "" and arg_456_1:find(trim(iter_456_1)) then
									var_456_0 = true
								end
							end
						end
					end
				end

				if not var_456_0 then
					if not arg_456_1:find(myName) then
						if as.other.adblock_index == 0 then
							return false
						elseif arg_456_1:find("�������� News .*%. ��������������.*") or arg_456_1:find("�������� News .+%. �������� ��������.+") then
							as.other.adblock_index = as.other.adblock_index - 1
						else
							return false
						end
					else
						as.other.adblock_index = 1
					end
				end
			end

			if arg_456_0 == -1950935126 and arg_456_1:find("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~") then
				return false
			end

			if arg_456_0 == 751250602 and (arg_456_1:find("������� ��� ������ � ��������� �������") or arg_456_1:find("������� ������ � ������� �� ������������ ����� Samp RolePlay") or arg_456_1:find("��� ������������ ��� ���������� �� ������ �������� �� �����")) then
				return false
			end
		end

		if as.other.hookchat and #as.other.hookchat > 0 then
			for iter_456_2, iter_456_3 in pairs(as.other.hookchat) do
				if arg_456_1:find(u8:decode(iter_456_3.find)) then
					if iter_456_3.action == 1 then
						awaitSendChat(u8:decode(iter_456_3.message), 1, tonumber(iter_456_3.wait), false, false)

						if iter_456_3.sound then
							addOneOffSound(0, 0, 0, 1058)
						end

						if iter_456_3.notify then
							am("������� ������� ������ � ����!")
						end
					elseif iter_456_3.action == 2 then
						if iter_456_3.sound then
							addOneOffSound(0, 0, 0, 1058)
						end

						if iter_456_3.notify then
							am("������� ������� ������ � ����!")
						end
					elseif iter_456_3.action == 3 then
						local var_456_2 = io.open("moonloader/PD-Project/hooklogs/" .. u8:decode(iter_456_3.log_file),
							"a+")

						if var_456_2 then
							var_456_2:write(os.date("!%Y-%m-%d %H:%M:%S", os.time() + 10800) ..
							" | " .. arg_456_1 .. "\r\n")
							var_456_2:close()

							if iter_456_3.sound then
								addOneOffSound(0, 0, 0, 1058)
							end

							if iter_456_3.notify then
								am("������ ������� ��������� � ���-����!")
							end
						else
							am("�� ������� ������� ��������� ���-����. ��������� � ����������!")
						end
					end
				end
			end
		end

		if arg_456_0 == -1 and arg_456_1:find("���������� ������� �� ����") then
			local var_456_3 = gsub(getEditByCode("hottarget.follow", 1)):gsub("{name}",
				as.other.followNick ~= nil and as.other.followNick or "������������")
			local var_456_4 = gsub(getEditByCode("hottarget.follow", 2)):gsub("{name}",
				as.other.followNick ~= nil and as.other.followNick or "������������")

			awaitSendChat({
				var_456_3,
				var_456_4
			}, 1, 1200, true, false)

			as.other.follow = true
		end

		if arg_456_0 == -1 and arg_456_1:find("���������� ������ �� ������� �� ����") then
			awaitSendChat(
			gsub(getEditByCode("hottarget.unfollow", 1)):gsub("{name}",
				as.other.followNick ~= nil and as.other.followNick or "������������"), 1, 1200, false, false)

			as.other.follow = false
		end

		if arg_456_0 == -1347440641 and arg_456_1:find("�������� ������� ������������� �������� ����") and as.other.tfrisk_start == true then
			as.f.chat(im.informer.infMainSex.v == true and "/me ������ ��������, ���� �������� � ����� ��." or
			"/me ������� ��������, ����� �������� � ������ ��.")

			as.other.tfrisk_start = false
		end

		if catchTry and arg_456_0 == -1029514497 then
			if arg_456_1:find(myName .. ".*%[������%]") then
				catchTry, failTry = false, false
			elseif arg_456_1:find(myName .. ".*%[��������%]") then
				catchTry, failTry = false, true
			end
		end

		if arg_456_0 == -3669560 and arg_456_1:find("%[Clear%].*������.*��.*�������������.*%..*�������%:.*") and se.main.clearwantedlog then
			local var_456_5 = os.date("!%H:%M:%S %d.%m.%Y", os.time() + 10800)
			local var_456_6 = io.open(
			"moonloader/PD-Project/clearwanted-log/logs-" .. os.date("!%d-%m-%Y", os.time() + 10800) .. ".txt", "a+")

			if var_456_6 then
				var_456_6:write(var_456_5 .. " | " .. arg_456_1 .. "\n")
				var_456_6:close()
			else
				print("�� ������� �������� ���� CLEAR, �� ������� ������� ����.")
			end
		end

		if im.settings.deplog.v and arg_456_0 == -8224001 and arg_456_1:find("%[.*%] .* %u%a+%_%u%a+%[%d+%]%: .+") then
			local var_456_7 = os.date("!%H:%M:%S %d.%m.%Y", os.time() + 10800)
			local var_456_8 = io.open(
			"moonloader/PD-Project/dep-log/logs-" .. os.date("!%d-%m-%Y", os.time() + 10800) .. ".txt", "a+")

			if var_456_8 then
				var_456_8:write(var_456_7 .. " | " .. arg_456_1 .. "\n")
				var_456_8:close()
			else
				print("�� ������� �������� ���� DEP, �� ������� ������� ����.")
			end
		end

		if im.informer.infDepTimerState.v and arg_456_0 == -8224001 and arg_456_1:find("%[.*%] .* %u%a+%_%u%a+%[%d+%]%: .+") then
			im.informer.dep_timer.v = os.time() + 15
		end

		if tencodes.pursuit ~= "" and arg_456_1:find(".*%u%a+%_%u%a+%[%d+%]%:.*" .. tencodes.pursuit:gsub("-", "%%-") .. ".*%S%-%d+") and _G.mass[mkey] then
			local var_456_15, var_456_16, var_456_17 = arg_456_1:match(".*(%u%a+%_%u%a+)%[(%d+)%]%:(.*" ..
			tencodes.pursuit:gsub("-", "%%-") .. ".*)")

			if var_456_15 ~= nil and var_456_16 ~= nil and var_456_17 ~= nil and var_456_15 ~= myName then
				if pt_id and pt_sec then
					if arg_456_1:find(".*%u%a+%_%u%a+%[%d+%]%:.*%S%-%d+%-%d.*") then
						local var_456_18 = arg_456_1:match(".*%u%a+%_%u%a+%[%d+%]%:.*(%S%-%d+%-%d).*")

						if var_456_18 and tostring(pt_id) == tostring(var_456_16) and tostring(pt_sec) ~= tostring(var_456_18) then
							pt_sec = var_456_18

							setWaypointPursuit(tostring(var_456_18))
						end
					elseif arg_456_1:find(".*%u%a+%_%u%a+%[%d+%]%:.*%S%-%d+%[%d%].*") then
						local var_456_19 = arg_456_1:match(".*%u%a+%_%u%a+%[%d+%]%:.*(%S%-%d+%[%d%]).*")

						if var_456_19 and tostring(pt_id) == tostring(var_456_16) and tostring(pt_sec) ~= tostring(var_456_19) then
							pt_sec = var_456_19

							setWaypointPursuit(tostring(var_456_19))
						end
					else
						local var_456_20 = arg_456_1:match(".*%u%a+%_%u%a+%[%d+%]%:.*(%S%-%d+).*")

						if var_456_20 and tostring(pt_id) == tostring(var_456_16) and tostring(pt_sec) ~= tostring(var_456_20) then
							pt_sec = var_456_20

							setWaypointPursuit(tostring(var_456_20))
						end
					end
				end

				table.insert(patrol, {
					#patrol + 1,
					var_456_15 .. "[" .. var_456_16 .. "]" .. "\t" .. var_456_17 .. "\t" .. os.date("%H:%M:%S")
				})
				printStringNow("~y~New " .. tencodes.pursuit, 2500)
			end
		end

		if tencodes.foxtrot ~= "" and arg_456_1:find(".*%u%a+%_%u%a+%[%d+%]%:.*" .. tencodes.foxtrot:gsub("-", "%%-") .. ".*%S%-%d+") and _G.mass[mkey] then
			local var_456_21, var_456_22, var_456_23 = arg_456_1:match(".*(%u%a+%_%u%a+)%[(%d+)%]%:(.*" ..
			tencodes.foxtrot:gsub("-", "%%-") .. ".*)")

			if var_456_21 ~= nil and var_456_22 ~= nil and var_456_23 ~= nil and var_456_21 ~= myName then
				if pt_id and pt_sec then
					if arg_456_1:find(".*%u%a+%_%u%a+%[%d+%]%:.*%S%-%d+%-%d.*") then
						local var_456_24 = arg_456_1:match(".*%u%a+%_%u%a+%[%d+%]%:.*(%S%-%d+%-%d).*")

						if var_456_24 and tostring(pt_id) == tostring(var_456_22) and tostring(pt_sec) ~= tostring(var_456_24) then
							pt_sec = var_456_24

							setWaypointPursuit(tostring(var_456_24))
						end
					elseif arg_456_1:find(".*%u%a+%_%u%a+%[%d+%]%:.*%S%-%d+%[%d%].*") then
						local var_456_25 = arg_456_1:match(".*%u%a+%_%u%a+%[%d+%]%:.*(%S%-%d+%[%d%]).*")

						if var_456_25 and tostring(pt_id) == tostring(var_456_22) and tostring(pt_sec) ~= tostring(var_456_25) then
							pt_sec = var_456_25

							setWaypointPursuit(tostring(var_456_25))
						end
					else
						local var_456_26 = arg_456_1:match(".*%u%a+%_%u%a+%[%d+%]%:.*(%S%-%d+).*")

						if var_456_26 and tostring(pt_id) == tostring(var_456_22) and tostring(pt_sec) ~= tostring(var_456_26) then
							pt_sec = var_456_26

							setWaypointPursuit(tostring(var_456_26))
						end
					end
				end

				table.insert(patrol, {
					#patrol + 1,
					var_456_21 .. "[" .. var_456_22 .. "]" .. "\t" .. var_456_23 .. "\t" .. os.date("%H:%M:%S")
				})
				printStringNow("~y~New " .. tencodes.foxtrot, 2500)
			end
		end

		if arg_456_1:find(".*%u%a+%_%u%a+%[%d+%]%:.*���������.*%S%-%d+") and _G.mass[mkey] then
			local var_456_27, var_456_28, var_456_29 = arg_456_1:match(".*(%u%a+%_%u%a+)%[(%d+)%]%:(.*���������.*)")

			if var_456_27 ~= nil and var_456_28 ~= nil and var_456_29 ~= nil and var_456_27 ~= myName then
				if pt_id and pt_sec then
					if arg_456_1:find(".*%u%a+%_%u%a+%[%d+%]%:.*%S%-%d+%-%d.*") then
						local var_456_30 = arg_456_1:match(".*%u%a+%_%u%a+%[%d+%]%:.*(%S%-%d+%-%d).*")

						if var_456_30 and tostring(pt_id) == tostring(var_456_28) and tostring(pt_sec) ~= tostring(var_456_30) then
							pt_sec = var_456_30

							setWaypointPursuit(tostring(var_456_30))
						end
					elseif arg_456_1:find(".*%u%a+%_%u%a+%[%d+%]%:.*%S%-%d+%[%d%].*") then
						local var_456_31 = arg_456_1:match(".*%u%a+%_%u%a+%[%d+%]%:.*(%S%-%d+%[%d%]).*")

						if var_456_31 and tostring(pt_id) == tostring(var_456_28) and tostring(pt_sec) ~= tostring(var_456_31) then
							pt_sec = var_456_31

							setWaypointPursuit(tostring(var_456_31))
						end
					else
						local var_456_32 = arg_456_1:match(".*%u%a+%_%u%a+%[%d+%]%:.*(%S%-%d+).*")

						if var_456_32 and tostring(pt_id) == tostring(var_456_28) and tostring(pt_sec) ~= tostring(var_456_32) then
							pt_sec = var_456_32

							setWaypointPursuit(tostring(var_456_32))
						end
					end
				end

				table.insert(patrol, {
					#patrol + 1,
					var_456_27 .. "[" .. var_456_28 .. "]" .. "\t" .. var_456_29 .. "\t" .. os.date("%H:%M:%S")
				})
				printStringNow("~y~New " .. tencodes.pursuit, 2500)
			end
		end

		if arg_456_1:find(".*%u%a+%_%u%a+%[%d+%]%:.*�����������.*%S%-%d+") and _G.mass[mkey] then
			local var_456_33, var_456_34, var_456_35 = arg_456_1:match(".*(%u%a+%_%u%a+)%[(%d+)%]%:(.*�����������.*)")

			if var_456_33 ~= nil and var_456_34 ~= nil and var_456_35 ~= nil and var_456_33 ~= myName then
				if pt_id and pt_sec then
					if arg_456_1:find(".*%u%a+%_%u%a+%[%d+%]%:.*%S%-%d+%-%d.*") then
						local var_456_36 = arg_456_1:match(".*%u%a+%_%u%a+%[%d+%]%:.*(%S%-%d+%-%d).*")

						if var_456_36 and tostring(pt_id) == tostring(var_456_34) and tostring(pt_sec) ~= tostring(var_456_36) then
							pt_sec = var_456_36

							setWaypointPursuit(tostring(var_456_36))
						end
					elseif arg_456_1:find(".*%u%a+%_%u%a+%[%d+%]%:.*%S%-%d+%[%d%].*") then
						local var_456_37 = arg_456_1:match(".*%u%a+%_%u%a+%[%d+%]%:.*(%S%-%d+%[%d%]).*")

						if var_456_37 and tostring(pt_id) == tostring(var_456_34) and tostring(pt_sec) ~= tostring(var_456_37) then
							pt_sec = var_456_37

							setWaypointPursuit(tostring(var_456_37))
						end
					else
						local var_456_38 = arg_456_1:match(".*%u%a+%_%u%a+%[%d+%]%:.*(%S%-%d+).*")

						if var_456_38 and tostring(pt_id) == tostring(var_456_34) and tostring(pt_sec) ~= tostring(var_456_38) then
							pt_sec = var_456_38

							setWaypointPursuit(tostring(var_456_38))
						end
					end
				end

				table.insert(patrol, {
					#patrol + 1,
					var_456_33 .. "[" .. var_456_34 .. "]" .. "\t" .. var_456_35 .. "\t" .. os.date("%H:%M:%S")
				})
				printStringNow("~y~New " .. tencodes.pursuit, 2500)
			end
		end

		if arg_456_1:find(".*%u%a+%_%u%a+%[%d+%]%:.*���� ������.*%S%-%d+") and _G.mass[mkey] then
			local var_456_39, var_456_40, var_456_41 = arg_456_1:match(".*(%u%a+%_%u%a+)%[(%d+)%]%:(.*���� ������.*)")

			if var_456_39 ~= nil and var_456_40 ~= nil and var_456_41 ~= nil and var_456_39 ~= myName then
				if pt_id and pt_sec then
					if arg_456_1:find(".*%u%a+%_%u%a+%[%d+%]%:.*%S%-%d+%-%d.*") then
						local var_456_42 = arg_456_1:match(".*%u%a+%_%u%a+%[%d+%]%:.*(%S%-%d+%-%d).*")

						if var_456_42 and tostring(pt_id) == tostring(var_456_40) and tostring(pt_sec) ~= tostring(var_456_42) then
							pt_sec = var_456_42

							setWaypointPursuit(tostring(var_456_42))
						end
					elseif arg_456_1:find(".*%u%a+%_%u%a+%[%d+%]%:.*%S%-%d+%[%d%].*") then
						local var_456_43 = arg_456_1:match(".*%u%a+%_%u%a+%[%d+%]%:.*(%S%-%d+%[%d%]).*")

						if var_456_43 and tostring(pt_id) == tostring(var_456_40) and tostring(pt_sec) ~= tostring(var_456_43) then
							pt_sec = var_456_43

							setWaypointPursuit(tostring(var_456_43))
						end
					else
						local var_456_44 = arg_456_1:match(".*%u%a+%_%u%a+%[%d+%]%:.*(%S%-%d+).*")

						if var_456_44 and tostring(pt_id) == tostring(var_456_40) and tostring(pt_sec) ~= tostring(var_456_44) then
							pt_sec = var_456_44

							setWaypointPursuit(tostring(var_456_44))
						end
					end
				end

				table.insert(patrol, {
					#patrol + 1,
					var_456_39 .. "[" .. var_456_40 .. "]" .. "\t" .. var_456_41 .. "\t" .. os.date("%H:%M:%S")
				})
				printStringNow("~y~New " .. tencodes.pursuit, 2500)
			end
		end

		if arg_456_1:find(".*%u%a+%_%u%a+%[%d+%]%:.*���� �������������.*%S%-%d+") and _G.mass[mkey] then
			local var_456_45, var_456_46, var_456_47 = arg_456_1:match(
			".*(%u%a+%_%u%a+)%[(%d+)%]%:(.*���� �������������.*)")

			if var_456_45 ~= nil and var_456_46 ~= nil and var_456_47 ~= nil and var_456_45 ~= myName then
				if pt_id and pt_sec then
					if arg_456_1:find(".*%u%a+%_%u%a+%[%d+%]%:.*%S%-%d+%-%d.*") then
						local var_456_48 = arg_456_1:match(".*%u%a+%_%u%a+%[%d+%]%:.*(%S%-%d+%-%d).*")

						if var_456_48 and tostring(pt_id) == tostring(var_456_46) and tostring(pt_sec) ~= tostring(var_456_48) then
							pt_sec = var_456_48

							setWaypointPursuit(tostring(var_456_48))
						end
					elseif arg_456_1:find(".*%u%a+%_%u%a+%[%d+%]%:.*%S%-%d+%[%d%].*") then
						local var_456_49 = arg_456_1:match(".*%u%a+%_%u%a+%[%d+%]%:.*(%S%-%d+%[%d%]).*")

						if var_456_49 and tostring(pt_id) == tostring(var_456_46) and tostring(pt_sec) ~= tostring(var_456_49) then
							pt_sec = var_456_49

							setWaypointPursuit(tostring(var_456_49))
						end
					else
						local var_456_50 = arg_456_1:match(".*%u%a+%_%u%a+%[%d+%]%:.*(%S%-%d+).*")

						if var_456_50 and tostring(pt_id) == tostring(var_456_46) and tostring(pt_sec) ~= tostring(var_456_50) then
							pt_sec = var_456_50

							setWaypointPursuit(tostring(var_456_50))
						end
					end
				end

				table.insert(patrol, {
					#patrol + 1,
					var_456_45 .. "[" .. var_456_46 .. "]" .. "\t" .. var_456_47 .. "\t" .. os.date("%H:%M:%S")
				})
				printStringNow("~y~New " .. tencodes.pursuit, 2500)
			end
		end

		if arg_456_1:find(".*%u%a+%_%u%a+%[%d+%]%:.*����� ������.*%S%-%d+") and _G.mass[mkey] then
			local var_456_51, var_456_52, var_456_53 = arg_456_1:match(".*(%u%a+%_%u%a+)%[(%d+)%]%:(.*����� ������.*)")

			if var_456_51 ~= nil and var_456_52 ~= nil and var_456_53 ~= nil and var_456_51 ~= myName then
				if pt_id and pt_sec then
					if arg_456_1:find(".*%u%a+%_%u%a+%[%d+%]%:.*%S%-%d+%-%d.*") then
						local var_456_54 = arg_456_1:match(".*%u%a+%_%u%a+%[%d+%]%:.*(%S%-%d+%-%d).*")

						if var_456_54 and tostring(pt_id) == tostring(var_456_52) and tostring(pt_sec) ~= tostring(var_456_54) then
							pt_sec = var_456_54

							setWaypointPursuit(tostring(var_456_54))
						end
					elseif arg_456_1:find(".*%u%a+%_%u%a+%[%d+%]%:.*%S%-%d+%[%d%].*") then
						local var_456_55 = arg_456_1:match(".*%u%a+%_%u%a+%[%d+%]%:.*(%S%-%d+%[%d%]).*")

						if var_456_55 and tostring(pt_id) == tostring(var_456_52) and tostring(pt_sec) ~= tostring(var_456_55) then
							pt_sec = var_456_55

							setWaypointPursuit(tostring(var_456_55))
						end
					else
						local var_456_56 = arg_456_1:match(".*%u%a+%_%u%a+%[%d+%]%:.*(%S%-%d+).*")

						if var_456_56 and tostring(pt_id) == tostring(var_456_52) and tostring(pt_sec) ~= tostring(var_456_56) then
							pt_sec = var_456_56

							setWaypointPursuit(tostring(var_456_56))
						end
					end
				end

				table.insert(patrol, {
					#patrol + 1,
					var_456_51 .. "[" .. var_456_52 .. "]" .. "\t" .. var_456_53 .. "\t" .. os.date("%H:%M:%S")
				})
				printStringNow("~y~New " .. tencodes.pursuit, 2500)
			end
		end

		if srv_name ~= "revolution" then
			if arg_456_1:find("%[Police SF%].*%[%d+%]%:.*���") then
				local var_456_57, var_456_58, var_456_59, var_456_60 = arg_456_1:match(
				"%[Police SF%] .* (%a+%_%a+)%[(%d+)%]%:.*City Hall.*(%u%a+%s%u%a+).*")
				local var_456_61, var_456_62, var_456_63 = arg_456_1:match(
				"%[Police SF%] .* (%a+%_%a+)%[(%d+)%]%:.*City Hall.*(%u%a+%s%u%a+).*")

				if var_456_61 ~= nil and var_456_62 ~= nil and preas2 ~= nil and var_456_63 ~= nil then
					local var_456_64 = var_456_61
					local var_456_65 = "Police SF"
					local var_456_66 = var_456_63
					local var_456_67 = io.open(
					"moonloader/PD-Project/OOPLOGS/ooplog-" .. os.date("!%d-%m-%Y", os.time() + 10800) .. ".txt", "a+")

					if var_456_67 then
						local var_456_68 = os.date("!%H:%M:%S %d.%m.%Y", os.time() + 10800)

						var_456_67:write(var_456_64 ..
						"\t" .. var_456_65 .. "\t" .. var_456_66 .. "\t" .. var_456_68 .. "\n")
						var_456_67:close()
					end

					local var_456_69
					local var_456_70
					local var_456_71
				end

				if var_456_57 ~= nil and var_456_58 ~= nil and var_456_60 ~= nil and var_456_59 ~= nil then
					local var_456_72 = var_456_57
					local var_456_73 = "Police SF"
					local var_456_74 = var_456_59
					local var_456_75 = io.open(
					"moonloader/PD-Project/OOPLOGS/ooplog-" .. os.date("!%d-%m-%Y", os.time() + 10800) .. ".txt", "a+")

					if var_456_75 then
						local var_456_76 = os.date("!%H:%M:%S %d.%m.%Y", os.time() + 10800)

						var_456_75:write(var_456_72 ..
						"\t" .. var_456_73 .. "\t" .. var_456_74 .. "\t" .. var_456_76 .. "\n")
						var_456_75:close()
					end

					local var_456_77
					local var_456_78
					local var_456_79
				end
			end

			if arg_456_1:find("%[Police LS%].*%[%d+%]%:.*���") then
				local var_456_80, var_456_81, var_456_82 = arg_456_1:match(
				"%[Police LS%] .* (%a+%_%a+)%[(%d+)%]%:.*City Hall.*(%u%a+%s%u%a+).*")
				local var_456_83, var_456_84, var_456_85 = arg_456_1:match(
				"%[Police LS%] .* (%a+%_%a+)%[(%d+)%]%:.*City Hall.*(%u%a+%s%u%a+).*")

				if var_456_83 ~= nil and var_456_84 ~= nil and var_456_85 ~= nil then
					local var_456_86 = var_456_83
					local var_456_87 = "Police LS"
					local var_456_88 = var_456_85
					local var_456_89 = io.open(
					"moonloader/PD-Project/OOPLOGS/ooplog-" .. os.date("!%d-%m-%Y", os.time() + 10800) .. ".txt", "a+")

					if var_456_89 then
						local var_456_90 = os.date("!%H:%M:%S %d.%m.%Y", os.time() + 10800)

						var_456_89:write(var_456_86 ..
						"\t" .. var_456_87 .. "\t" .. var_456_88 .. "\t" .. var_456_90 .. "\n")
						var_456_89:close()
					end

					local var_456_91
					local var_456_92
					local var_456_93
				end

				if var_456_80 ~= nil and var_456_81 ~= nil then
					local var_456_94 = var_456_80
					local var_456_95 = "Police LS"
					local var_456_96 = var_456_82
					local var_456_97 = io.open(
					"moonloader/PD-Project/OOPLOGS/ooplog-" .. os.date("!%d-%m-%Y", os.time() + 10800) .. ".txt", "a+")

					if var_456_97 then
						local var_456_98 = os.date("!%H:%M:%S %d.%m.%Y", os.time() + 10800)

						var_456_97:write(var_456_94 ..
						"\t" .. var_456_95 .. "\t" .. var_456_96 .. "\t" .. var_456_98 .. "\n")
						var_456_97:close()
					end

					local var_456_99
					local var_456_100
					local var_456_101
				end
			end

			if arg_456_1:find("%[Police LV%].*%[%d+%]%:.*���") then
				local var_456_102, var_456_103, var_456_104 = arg_456_1:match(
				"%[Police LV%] .* (%a+%_%a+)%[(%d+)%]%:.*City Hall.*(%u%a+%s%u%a+).*")
				local var_456_105, var_456_106, var_456_107 = arg_456_1:match(
				"%[Police LV%] .* (%a+%_%a+)%[(%d+)%]%:.*City Hall.*(%u%a+%s%u%a+).*")

				if var_456_105 ~= nil and var_456_106 ~= nil and pnick2 ~= nil then
					local var_456_108 = var_456_105
					local var_456_109 = "Police LV"
					local var_456_110 = pnick2
					local var_456_111 = io.open(
					"moonloader/PD-Project/OOPLOGS/ooplog-" .. os.date("!%d-%m-%Y", os.time() + 10800) .. ".txt", "a+")

					if var_456_111 then
						local var_456_112 = os.date("!%H:%M:%S %d.%m.%Y", os.time() + 10800)

						var_456_111:write(var_456_108 ..
						"\t" .. var_456_109 .. "\t" .. var_456_110 .. "\t" .. var_456_112 .. "\n")
						var_456_111:close()
					end

					local var_456_113
					local var_456_114
					local var_456_115
				end

				if var_456_102 ~= nil and var_456_103 ~= nil then
					local var_456_116 = var_456_102
					local var_456_117 = "Police LV"
					local var_456_118 = var_456_104
					local var_456_119 = io.open(
					"moonloader/PD-Project/OOPLOGS/ooplog-" .. os.date("!%d-%m-%Y", os.time() + 10800) .. ".txt", "a+")

					if var_456_119 then
						local var_456_120 = os.date("!%H:%M:%S %d.%m.%Y", os.time() + 10800)

						var_456_119:write(var_456_116 ..
						"\t" .. var_456_117 .. "\t" .. var_456_118 .. "\t" .. var_456_120 .. "\n")
						var_456_119:close()
					end

					local var_456_121
					local var_456_122
					local var_456_123
				end
			end

			if arg_456_1:find("%[FBI%].*%[%d+%]%:.*���") then
				local var_456_124, var_456_125, var_456_126, var_456_127 = arg_456_1:match(
				"%[FBI%] .* (%a+%_%a+)%[(%d+)%]%:.*(%u%a+%s%u%a+).*(%d%.%d).*")
				local var_456_128, var_456_129, var_456_130, var_456_131 = arg_456_1:match(
				"%[FBI%] .* (%a+%_%a+)%[(%d+)%]%:.*(%d%.%d).*(%u%a+%s%u%a+).*")

				if var_456_128 ~= nil and var_456_129 ~= nil and var_456_131 ~= nil then
					local var_456_132 = var_456_128
					local var_456_133 = "FBI"
					local var_456_134 = var_456_131
					local var_456_135 = io.open(
					"moonloader/PD-Project/OOPLOGS/ooplog-" .. os.date("!%d-%m-%Y", os.time() + 10800) .. ".txt", "a+")

					if var_456_135 then
						local var_456_136 = os.date("!%H:%M:%S %d.%m.%Y", os.time() + 10800)

						var_456_135:write(var_456_132 ..
						"\t" .. var_456_133 .. "\t" .. var_456_134 .. "\t" .. var_456_136 .. "\n")
						var_456_135:close()
					end

					local var_456_137
					local var_456_138
					local var_456_139
				end

				if var_456_124 ~= nil and var_456_125 ~= nil then
					local var_456_140 = var_456_124
					local var_456_141 = "FBI"
					local var_456_142 = var_456_126
					local var_456_143 = io.open(
					"moonloader/PD-Project/OOPLOGS/ooplog-" .. os.date("!%d-%m-%Y", os.time() + 10800) .. ".txt", "a+")

					if var_456_143 then
						local var_456_144 = os.date("!%H:%M:%S %d.%m.%Y", os.time() + 10800)

						var_456_143:write(var_456_140 ..
						"\t" .. var_456_141 .. "\t" .. var_456_142 .. "\t" .. var_456_144 .. "\n")
						var_456_143:close()
					end

					local var_456_145
					local var_456_146
					local var_456_147
				end
			end
		end

		if se.main.soswp and arg_456_0 == -1920073729 then
			if arg_456_1:find((tencodes.sos ~= "" and tencodes.sos:gsub("-", "%%-") or "��������") .. ".*%S%-%d+") then
				if arg_456_1:find((tencodes.sos ~= "" and tencodes.sos:gsub("-", "%%-") or "��������") .. ".*%S%-%d+%-%d") then
					local var_456_148 = arg_456_1:match(".*(%S%-%d+%-%d)")

					if var_456_148 then
						setWaypoint(tostring(trim(var_456_148)))
					end
				else
					local var_456_149 = arg_456_1:match(".*(%S%-%d+)")

					if var_456_149 then
						setWaypoint(tostring(trim(var_456_149)))
					end
				end
			elseif arg_456_1:find("������.*%S%-%d+") or arg_456_1:find("�����.*%S%-%d+") or arg_456_1:find("��������.*%S%-%d+") or arg_456_1:find("SOS.*%S%-%d+") or arg_456_1:find("sos.*%S%-%d+") or arg_456_1:find("Sos.*%S%-%d+") or arg_456_1:find("���.*%S%-%d+") or arg_456_1:find("���.*%S%-%d+") or arg_456_1:find("�����.*%S%-%d+") or arg_456_1:find(".*����� �� �����.*%S%-%d+") or arg_456_1:find("���.*%S%-%d+") or arg_456_1:find("���.*%S%-%d+") then
				if arg_456_1:find(".*%S%-%d+%-%d") then
					local var_456_150 = arg_456_1:match(".*(%S%-%d+%-%d)")

					if var_456_150 then
						setWaypoint(tostring(trim(var_456_150)))
					end
				else
					local var_456_151 = arg_456_1:match(".*(%S%-%d+)")

					if var_456_151 then
						setWaypoint(tostring(trim(var_456_151)))
					end
				end
			end
		end

		if arg_456_0 == -65281 and arg_456_1:find("SMS%: .*%. �����������%: .*%[%d+%]") then
			if not as.other.informed and arg_456_1:find("SMS%: .*%. �����������%:.*William%_Tudor%[%d+%]") then
				chat("��� ����� ����������� PD-Project � Serhiy_Rubin.")
				addOneOffSound(0, 0, 0, 1058)

				as.other.informed = true
			end

			if se.main.smslog then
				local var_456_152 = os.date("!%H:%M:%S %d.%m.%Y", os.time() + 10800)
				local var_456_153 = io.open(
				"moonloader/PD-Project/sms-log/logs-" .. os.date("!%d-%m-%Y", os.time() + 10800) .. ".txt", "a+")

				if var_456_153 then
					var_456_153:write(var_456_152 .. "\t" .. arg_456_1 .. "\n")
					var_456_153:close()
				end
			end

			local var_456_154 = arg_456_1:match("SMS%: .*%. �����������%: .*%[(%d+)%]")

			if var_456_154 then
				SMS_ID = var_456_154
			end
		end

		if arg_456_0 == -65281 and arg_456_1:find("SMS%: .*%. ����������%: .*%[%d+%]") and se.main.smslog then
			local var_456_155 = os.date("!%H:%M:%S %d.%m.%Y", os.time() + 10800)
			local var_456_156 = io.open(
			"moonloader/PD-Project/sms-log/logs-" .. os.date("!%d-%m-%Y", os.time() + 10800) .. ".txt", "a+")

			if var_456_156 then
				var_456_156:write(var_456_155 .. "\t" .. arg_456_1 .. "\n")
				var_456_156:close()
			end
		end

		if not notactive and arg_456_0 == -1137955670 and arg_456_1:find("���������: ����� �� .*%[%d+%]%. ��������� ���������� %d+ �") and im.sounds.s911.v then
			local var_456_157 = var_0_9.BASS_StreamCreateFile(false, "moonloader/PD-Project/resource/m/civilshot.mp3", 0,
				0, 0)

			var_0_9.BASS_ChannelSetAttribute(var_456_157, BASS_ATTRIB_VOL, im.sounds.volume.v)
			var_0_9.BASS_ChannelPlay(var_456_157, false)
		end

		if sendmdc then
			if arg_456_0 == -1920073729 then
				return false
			end

			if arg_456_1:find("�� �� � ��������� ������ %/ ����� �������") then
				smdcName, smdcWanted, smdcReason, smdcFrac, sendmdc = nil, nil, nil, nil, false
			end

			if arg_456_0 == -1 and arg_456_1:find("���%: .*") then
				smdcName = arg_456_1:match("���%: (.*)")

				return false
			end

			if arg_456_0 == -1 and arg_456_1:find("���%: .*%[%d+%]") and smdcName == nil then
				smdcName = arg_456_1:match("���%: (.*)%[%d+%]")

				return false
			end

			if arg_456_0 == -1 and arg_456_1:find("������� �������%: %d+") then
				smdcWanted = arg_456_1:match("������� �������%: (%d+)")

				return false
			end

			if arg_456_0 == -1 and arg_456_1:find("�������%: .*") then
				smdcReason = arg_456_1:match("�������%: (.*)")

				return false
			end

			if arg_456_0 == -1 and arg_456_1:find("�����������%: .*") then
				smdcFrac = arg_456_1:match("�����������%: (.*)")

				if smdcName and smdcWanted and smdcReason and smdcFrac then
					local var_456_158 = string.format("/%s %s, %s. %s%s.",
						mdctype == 1 and "r" or mdctype == 2 and "rb" or mdctype == 3 and "fs" or "rb",
						smdcName:gsub("_", " "), smdcFrac == "���" and "�����������" or smdcFrac,
						tonumber(smdcWanted) > 0 and smdcWanted .. " ��.�, " or "�� � �������",
						tonumber(smdcWanted) > 0 and smdcReason or "")

					lua_thread.create(function()
						wait(500)
						sampProcessChatInput(var_456_158)

						smdcName, smdcWanted, smdcReason, smdcFrac, sendmdc = nil, nil, nil, nil, false
					end)
				end

				return false
			end

			if arg_456_0 == -1 then
				return false
			end
		end

		if as.other.mdcsend then
			if arg_456_0 == -1347440641 and arg_456_1:find("��� ���������� ��� �������") then
				as.other.mdcsend, mdclist = false

				chat("� ��� ��� ���������� ��� ����������� ������������.")

				return false
			end

			if arg_456_0 == -1347440641 and arg_456_1:find("����� �������") then
				as.other.mdcsend, mdclist = false

				chat("��������� ���� �� ����������.")

				return false
			end

			if arg_456_1:find("�� �� � ��������� ������ %/ ����� �������") then
				as.other.mdcsend = false

				chat("���������� ���������� � ��������� ������ ��� � �����.")

				return false
			end

			if arg_456_0 == -1920073729 and arg_456_1:find("==============================================") then
				as.other.mdcsend = false

				sendMdcData()
			end

			if arg_456_0 == -1920073729 then
				return false
			end

			if arg_456_0 == -1 then
				as.other.mdcdata[#as.other.mdcdata + 1] = arg_456_1

				return false
			end
		end

		if as.other.sendthanks then
			if arg_456_0 == -1347440641 and arg_456_1:find("��� ���������� ��� �������") then
				as.other.sendthanks = false

				chat("� ��� ��� ���������� ��� ����������� ������������.")

				return false
			end

			if arg_456_0 == -1347440641 and arg_456_1:find("����� �������") then
				as.other.sendthanks = false

				chat("��������� ���� �� ����������.")

				return false
			end

			if arg_456_1:find("�� �� � ��������� ������ %/ ����� �������") then
				as.other.sendthanks = false

				chat("���������� ���������� � ��������� ������ ��� � �����.")

				return false
			end

			if arg_456_0 == -1920073729 then
				return false
			end

			if arg_456_0 == -1 and arg_456_1:find("���%: .*") then
				return false
			end

			if arg_456_0 == -1 and arg_456_1:find("������� �������%: %d+") then
				return false
			end

			if arg_456_0 == -1 and arg_456_1:find("�������%: .*") then
				return false
			end

			if arg_456_0 == -1 and arg_456_1:find("�����������%: .*") then
				local var_456_159 = arg_456_1:match("�����������%: (.*)")

				if var_456_159 then
					if var_456_159 == "���" then
						as.other.sendthanks_error = true

						chat("��������� ���� �� ������� � �����������.")
					end

					if not as.other.sendthanks_error then
						if isFracIsForce(var_456_159) then
							if var_456_159 == "Medic" then
								var_456_159 = "MoH"
							elseif var_456_159 == "Instructors" then
								var_456_159 = "��"
							end

							local var_456_160 = string.format("/dep %s, ������� ������������� %s. ������!", var_456_159,
								as.other.thank_name:gsub("_", " "))

							sampSetChatInputEnabled(true)
							sampSetChatInputText(var_456_160)
							lua_thread.create(function()
								wait(500)

								as.other.sendthanks = false
							end)
						else
							as.other.sendthanks_error = true

							chat("��������� ���� �� ������� � ��������������� �������.")
						end
					end
				end

				return false
			end

			if arg_456_0 == -1 then
				return false
			end

			if as.other.sendthanks_error then
				as.other.sendthanks = false
			end
		end

		if cfbi and cfbi_id ~= nil and cfbi_name ~= nil and cfbi_minutes ~= nil then
			if arg_456_0 == -1347440641 and arg_456_1:find("��� ���������� ��� �������") then
				cfbi, cfbi_id, cfbi_name, cfbi_minutes = nil

				chat("� ��� ��� ���������� ��� ����������� ������������.")

				return false
			end

			if arg_456_0 == -1347440641 and arg_456_1:find("����� �������") then
				cfbi, cfbi_id, cfbi_name, cfbi_minutes = nil

				chat("��������� ���� �� ����������.")

				return false
			end

			if arg_456_0 == -1920073729 then
				return false
			end

			if arg_456_1:find("�� �� � ��������� ������ %/ ����� �������") then
				cfbi, cfbi_id, cfbi_name, cfbi_minutes = nil

				chat("���������� ���������� � ��������� ������ ��� � �����.")

				return false
			end

			if arg_456_0 == -1 and arg_456_1:find("���%: .*") then
				return false
			end

			if arg_456_0 == -1 and arg_456_1:find("������� �������%: %d+") then
				return false
			end

			if arg_456_0 == -1 and arg_456_1:find("�������%: .*") then
				return false
			end

			if arg_456_0 == -1 and arg_456_1:find("�����������%: .*") then
				cfbi_frac = arg_456_1:match("�����������%: (.*)")

				if cfbi and cfbi_name ~= nil and cfbi_minutes ~= nil then
					if cfbi_frac == "���" then
						cfbi_error = true

						chat("��������� ���� �� ������� � �����������.")
					end

					if not cfbi_error then
						if isFracIsForce(cfbi_frac) then
							local var_456_161 = string.format("/dep %s, %s, ������� � ���� ��� � ������� %d %s.",
								cfbi_frac, cfbi_name, cfbi_minutes, tonumber(cfbi_minutes) == 1 and "������" or "�����")

							lua_thread.create(function()
								wait(500)
								sampProcessChatInput(var_456_161)

								cfbi, cfbi_id, cfbi_name, cfbi_minutes = nil
							end)
						else
							cfbi_error = true

							chat("��������� ���� �� ������� � ��������������� �������.")
						end
					end
				end

				return false
			end

			if arg_456_0 == -1 then
				return false
			end

			if cfbi_error then
				cfbi, cfbi_id, cfbi_name, cfbi_minutes = nil
			end
		end

		if arg_456_0 == -1920073729 and arg_456_1:find(".*%s%s%u%a+%_%u%a+%[%d+%]%:%s%s.*") then
			local var_456_162 = ""
			local var_456_163, var_456_164, var_456_165, var_456_166 = arg_456_1:match(
			"(.*)%s%s(%u%a+%_%u%a+)%[(%d+)%]%:%s%s(.*)")

			if var_456_163 and var_456_164 and var_456_165 and var_456_166 then
				if tostring(var_456_165) == tostring(myID) then
					var_456_162 = string.format("%06X", ARGBtoRGB(sampGetPlayerColor(var_456_165)))
				elseif sampIsPlayerConnected(var_456_165) then
					var_456_162 = string.format("%06X", ARGBtoRGB(sampGetPlayerColor(var_456_165)))
				end

				local var_456_167 = var_456_163:gsub("%s+", "")

				if changedRangs[var_456_167] ~= nil and changedRangs[var_456_167] ~= "" then
					if se.main.changeradiocolor then
						return {
							arg_456_0,
							" " ..
							changedRangs[var_456_167] ..
							"  {" ..
							var_456_162 .. "}" .. var_456_164 .. "{8492D9}[" .. var_456_165 .. "]:  " .. var_456_166
						}
					else
						return {
							arg_456_0,
							" " ..
							changedRangs[var_456_167] ..
							"  " .. var_456_164 .. "[" .. var_456_165 .. "]:  " .. var_456_166
						}
					end
				end
			end
		end

		if reaver and rID and rName then
			if arg_456_1:find("%- " .. rName .. "%[" .. rID .. "%]%:") then
				local var_456_168 = arg_456_1:match("%- " .. rName .. "%[" .. rID .. "%]%: (.*)")

				if var_456_168 then
					if mcfs then
						table.insert(as.other.miclist, "/fs � [�����������] " .. removeBadWords(var_456_168))
					else
						table.insert(as.other.miclist, "/r � [�����������] " .. removeBadWords(var_456_168))
					end
				end
			end

			if reaver_micro and arg_456_1:find("%- " .. myName .. "%[" .. myID .. "%]%:") then
				local var_456_169 = arg_456_1:match("%- " .. myName .. "%[" .. myID .. "%]%: (.*)")

				if var_456_169 then
					if mcfs then
						table.insert(as.other.miclist, "/fs � [�����] " .. var_456_169)
					else
						table.insert(as.other.miclist, "/r � [�����] " .. var_456_169)
					end
				end
			end

			if arg_456_1:find(rName .. " �������%: .+%!%!") then
				local var_456_170 = arg_456_1:match(rName .. " �������%: (.+)%!%!")

				if var_456_170 then
					if mcfs then
						table.insert(as.other.miclist, "/fs � [�����������] *����* " .. removeBadWords(var_456_170))
					else
						table.insert(as.other.miclist, "/r � [�����������] *����* " .. removeBadWords(var_456_170))
					end
				end
			end

			if arg_456_1:find(rName .. " ��������%: .+%!%!") then
				local var_456_171 = arg_456_1:match(rName .. " ��������%: (.+)%!%!")

				if var_456_171 then
					if mcfs then
						table.insert(as.other.miclist, "/fs � [�����������] *����* " .. removeBadWords(var_456_171))
					else
						table.insert(as.other.miclist, "/r � [�����������] *����* " .. removeBadWords(var_456_171))
					end
				end
			end

			if reaver_micro and arg_456_1:find(myName .. " �������%: .+%!%!") then
				local var_456_172 = arg_456_1:match(myName .. " �������%: (.+)%!%!")

				if var_456_172 then
					if mcfs then
						table.insert(as.other.miclist, "/fs � [�����] *����* " .. var_456_172)
					else
						table.insert(as.other.miclist, "/r � [�����] *����* " .. var_456_172)
					end
				end
			end

			if reaver_micro and arg_456_1:find(myName .. " ��������%: .+%!%!") then
				local var_456_173 = arg_456_1:match(myName .. " ��������%: (.+)%!%!")

				if var_456_173 then
					if mcfs then
						table.insert(as.other.miclist, "/fs � [�����] *����* " .. var_456_173)
					else
						table.insert(as.other.miclist, "/r � [�����] *����* " .. var_456_173)
					end
				end
			end

			if arg_456_1:find("^%s+%[�������%] " .. rName .. "%: .*") and arg_456_0 == -65281 then
				local var_456_174 = arg_456_1:match("^%s+%[�������%] .*%: (.*)")

				if var_456_174 then
					if mcfs then
						table.insert(as.other.miclist, "/fs � [�����������] *���* " .. removeBadWords(var_456_174))
					else
						table.insert(as.other.miclist, "/r � [�����������] *���* " .. removeBadWords(var_456_174))
					end
				end
			end

			if reaver_micro and arg_456_1:find("^%s+%[�������%] " .. myName .. "%: .*") and arg_456_0 == -421075226 then
				local var_456_175 = arg_456_1:match("^%s+%[�������%] .*%: (.*)")

				if var_456_175 then
					if mcfs then
						table.insert(as.other.miclist, "/fs � [�����] *���* " .. var_456_175)
					else
						table.insert(as.other.miclist, "/r � [�����] *���* " .. var_456_175)
					end
				end
			end

			if arg_456_1:find("^%s+" .. rName .. ".*������%(�%)%s*:%s*.+") then
				local var_456_176 = arg_456_1:match("^%s+.*������%(�%)%s*:%s*(.+)")

				if var_456_176 then
					if mcfs then
						table.insert(as.other.miclist, "/fs � [�����������] *�����* " .. removeBadWords(var_456_176))
					else
						table.insert(as.other.miclist, "/r � [�����������] *�����* " .. removeBadWords(var_456_176))
					end
				end
			end

			if reaver_micro and arg_456_1:find("^%s+" .. myName .. ".*������%(�%)%s*:%s*.+") then
				local var_456_177 = arg_456_1:match("^%s+.*������%(�%)%s*:%s*(.+)")

				if var_456_177 then
					if mcfs then
						table.insert(as.other.miclist, "/fs � [�����] *�����* " .. var_456_177)
					else
						table.insert(as.other.miclist, "/r � [�����] *�����* " .. var_456_177)
					end
				end
			end

			if arg_456_1:find("^%s+" .. rName .. "%s+������") or arg_456_1:find("^%s+" .. rName .. "%s+�������� �� �����") or arg_456_1:find("^%s+" .. rName .. "%s+������� �� ���� �����") then
				if mcfs then
					table.insert(as.other.miclist, "/fs � [�����������] *����*")
				else
					table.insert(as.other.miclist, "/r � [�����������] *����*")
				end
			end

			if reaver_micro and arg_456_1:find("^%s+" .. myName .. "%s+������") or arg_456_1:find("^%s+" .. myName .. "%s+�������� �� �����") or arg_456_1:find("^%s+" .. myName .. "%s+������� �� ���� �����") then
				if mcfs then
					table.insert(as.other.miclist, "/fs � [�����] *����*")
				else
					table.insert(as.other.miclist, "/r � [�����] *����*")
				end
			end

			if arg_456_1:find("^%s+" .. rName .. "%S*%:%s+%(%(%s*.*%s*%)%)") then
				local var_456_178 = arg_456_1:match("^%s+" .. rName .. "%S*%:%s+%(%(%s*(.*)%s*%)%)")

				if var_456_178 then
					if mcfs then
						table.insert(as.other.miclist, "/fs (( � [�����������] " .. removeBadWords(var_456_178) .. " )) ")
					else
						table.insert(as.other.miclist, "/rb � [�����������] " .. removeBadWords(var_456_178))
					end
				end
			end

			if reaver_micro and arg_456_1:find("^%s+" .. myName .. "%S*%:%s+%(%(%s*.*%s*%)%)") then
				local var_456_179 = arg_456_1:match("^%s+" .. myName .. "%S*%:%s+%(%(%s*(.*)%s*%)%)")

				if var_456_179 then
					if mcfs then
						table.insert(as.other.miclist, "/fs (( � [�����] " .. trim(var_456_179) .. " )) ")
					else
						table.insert(as.other.miclist, "/rb � [�����] " .. trim(var_456_179))
					end
				end
			end

			local var_456_180 = arg_456_1:gsub("%{%S%S%S%S%S%S%}", "")

			if arg_456_1:find("^%s*.*%s%-%s������%(�%)%s" .. rName .. ".*%,%s.+") then
				local var_456_181 = arg_456_1:match("^%s*(.*)%s%-%s������%(�%)%s" .. rName .. ".*%,%s.+")

				if var_456_181 then
					if mcfs then
						table.insert(as.other.miclist, "/fs � [�����������] " .. removeBadWords(trim(var_456_181)))
					else
						table.insert(as.other.miclist, "/r � [�����������] " .. removeBadWords(trim(var_456_181)))
					end
				end
			end

			if reaver_micro and var_456_180:find("^%s*.*%s%-%s������%(�%)%s" .. myName .. ".*%,%s.+") then
				local var_456_182 = var_456_180:match("^%s*(.*)%s%-%s������%(�%)%s" .. myName .. ".*%,%s.+")

				if var_456_182 then
					if mcfs then
						table.insert(as.other.miclist, "/fs � [�����] " .. trim(var_456_182))
					else
						table.insert(as.other.miclist, "/r � [�����] " .. trim(var_456_182))
					end
				end
			end
		end

		if record and recordID and recordName and recordFile then
			if arg_456_1:find("%- " .. recordName .. "%[" .. recordID .. "%]%:.*") then
				local var_456_183 = arg_456_1:match("%- " .. recordName .. "%[" .. recordID .. "%]%:(.*)")

				if var_456_183 then
					recordFile:write("[" ..
					os.date("%d.%m.%y %H:%M:%S") ..
					"] - " .. tostring(recordName) .. "[" .. tostring(recordID) .. "]:" .. tostring(var_456_183) .. "\n")
				end
			end

			if arg_456_1:find("%- " .. myName .. "%[" .. myID .. "%]%:.*") then
				local var_456_184 = arg_456_1:match("%- " .. myName .. "%[" .. myID .. "%]%:(.*)")

				if var_456_184 then
					recordFile:write("[" ..
					os.date("%d.%m.%y %H:%M:%S") ..
					"] - " .. tostring(myName) .. "[" .. tostring(myID) .. "]:" .. tostring(var_456_184) .. "\n")
				end
			end
		end

		_, myID = sampGetPlayerIdByCharHandle(playerPed)
		myName = sampGetPlayerNickname(myID)

		lua_thread.create(function()
			if arg_456_1:find(".*������� ���� �����.*") and se.main.clist_st and se.main.clist ~= "" and _G.mass[mkey] then
				clistingFirst = true

				wait(p(1000))
				sampSendSystemChat("/clist " .. se.main.clist)
				wait(p(1000))

				if tostring(myfrac) == "4" then
					local var_465_0 = getEditByCode("other.fbi_badge", 1)
					local var_465_1 = gsub(var_465_0)

					sampSendSystemChat(var_465_1)
				else
					local var_465_2 = getEditByCode("other.cop_badge", 1)
					local var_465_3 = gsub(var_465_2)

					sampSendSystemChat(var_465_3)
				end

				clistingFirst = false
			end

			if catch and catch_id ~= nil and arg_456_1:find(".*" .. myName .. ".*��������� �������� �� ����.*%[������%]") and _G.mass[mkey] then
				wait(500)
				sampSendSystemChat(gsub(getEditByCode("hottarget.cuff", 1)):gsub("{name}",
					sampGetPlayerNickname(catch_id):gsub("_", " ")))
				wait(500)
				sampSendChat(string.format("/cuff %d", catch_id))

				catch = false

				return {
					clr,
					msg
				}
			elseif arg_456_1:find(".*" .. myName .. ".*��������� �������� �� ����.*%[��������%]") then
				catch = false

				_G.sampAddChatMessage("| {FFFFFF}���������� ��� ���.", clr)
			end

			if myName == "Serhiy_Rubin" and arg_456_1:find(".*�������%:.*Serhiy_Rubin") then
				addOneOffSound(0, 0, 0, 1058)
			end

			if arg_456_1:find(".*���������%:.*" .. myName .. ".*������ ����� ��.*%[%d+%]") and _G.mass[mkey] then
				wait(p(1000))

				if tostring(myfrac) == "1" then
					if isMan() then
						sampSendSystemChat("/r ������ �����, ���������� �� ������.")
					else
						sampSendSystemChat("/r ������� �����, ���������� �� ������.")
					end
				elseif tostring(myfrac) == "2" then
					if isMan() then
						sampSendSystemChat("/r ������ �����, ���������� �� ������.")
					else
						sampSendSystemChat("/r ������� �����, ���������� �� ������.")
					end
				elseif tostring(myfrac) == "3" then
					if isMan() then
						sampSendSystemChat("/r ������ �����, ���������� �� ������.")
					else
						sampSendSystemChat("/r ������� �����, ���������� �� ������.")
					end
				elseif tostring(myfrac) == "4" then
					if isMan() then
						sampSendSystemChat("/r ������ �����, ���������� �� ������.")
					else
						sampSendSystemChat("/r ������� �����, ���������� �� ������.")
					end
				end
			end
		end)

		if tostring(arg_456_0) == "-3669560" and arg_456_1:find("%[Wanted %d%: .*%]%s%[.*%:%s.*%]%s%[.*%]") then
			local var_456_185 = arg_456_1:match("%[Wanted %d%: .*%]%s%[.*%:%s.*%]%s%[(.*)%]")

			if var_456_185 then
				if orientir[tostring(var_456_185)] and not orientirNotify[var_456_185] then
					if orientirCity[tostring(var_456_185)] == "LS" and im.dispatch.gang_ls.v then
						dispatch(orientir[tostring(var_456_185)])

						orientirNotify[var_456_185] = true

						deleteOrientir(var_456_185)

						if im.dispatch.marker.v then
							setWaypoint(orientirSector[tostring(var_456_185)])
						end
					elseif orientirCity[tostring(var_456_185)] == "SF" and im.dispatch.gang_sf.v then
						dispatch(orientir[tostring(var_456_185)])

						orientirNotify[var_456_185] = true

						deleteOrientir(var_456_185)

						if im.dispatch.marker.v then
							setWaypoint(orientirSector[tostring(var_456_185)])
						end
					elseif orientirCity[tostring(var_456_185)] == "LV" and im.dispatch.gang_lv.v then
						dispatch(orientir[tostring(var_456_185)])

						orientirNotify[var_456_185] = true

						deleteOrientir(var_456_185)

						if im.dispatch.marker.v then
							setWaypoint(orientirSector[tostring(var_456_185)])
						end
					end
				end

				if timingReasons[tostring(var_456_185)] and not notactive then
					local var_456_186 = var_456_185:gsub("���������� ", "")
					local var_456_187 = os.date("!%H:%M:%S", os.time() + 10800)
					local var_456_188 = strtotime(var_456_187) + 1800

					as.other.timingsForSend[var_456_186] = os.date("!%H:%M", var_456_188)
				end
			end
		end

		if arg_456_1:find(".*��������:.*%d+") and _G.mass[mkey] then
			getPayCheck()
			getRank()
		end

		if arg_456_0 == -1920073729 and arg_456_1:find(".*%s%s%u%a+%_%u%a+%[%d+%]%:%s%s.*") and se.main.changeradiocolor then
			local var_456_189, var_456_190, var_456_191, var_456_192 = arg_456_1:match(
			"(.*)%s%s(%u%a+%_%u%a+)%[(%d+)%]%:%s%s(.*)")

			if var_456_189 and var_456_190 and var_456_191 and var_456_192 then
				if tostring(var_456_191) == tostring(myID) then
					local var_456_193 = string.format("%06X", ARGBtoRGB(sampGetPlayerColor(var_456_191)))

					arg_456_1 = arg_456_1:gsub(var_456_190, "{" .. var_456_193 .. "}" .. var_456_190 .. "{8492D9}")
				elseif sampIsPlayerConnected(var_456_191) then
					local var_456_194 = string.format("%06X", ARGBtoRGB(sampGetPlayerColor(var_456_191)))

					arg_456_1 = arg_456_1:gsub(var_456_190, "{" .. var_456_194 .. "}" .. var_456_190 .. "{8492D9}")
				end
			end

			return {
				arg_456_0,
				arg_456_1
			}
		end

		if arg_456_1:find("�� �������� ���� �� ���������") and _G.mass[mkey] then
			tazer_state = "ON"
		end

		if arg_456_1:find("�� �������� ���� �� �������") and _G.mass[mkey] then
			tazer_state = "OFF"
		end

		if paycheck_state then
			if arg_456_1:find("�� ���������� %d+ ����. ������ ����� ��������� �� ��� ���������� ���� �") then
				PayCheck = arg_456_1:match("�� ���������� (%d+) ����. ������ ����� ��������� �� ��� ���������� ���� �")
				paycheck_state = false

				return false
			end

			if arg_456_1:find("�� ���������� %d+%s%/%s%d+ ����. ������ ����� ��������� �� ��� ���������� ���� �") then
				PayCheck = arg_456_1:match(
				"�� ���������� (%d+)%s%/%s%d+ ����. ������ ����� ��������� �� ��� ���������� ���� �")
				paycheck_state = false

				return false
			end
		end

		if se.wanted.state and arg_456_0 == -3669560 and arg_456_1:find("%[Wanted %d%: .*%] %[.*%: .*%] %[.*%]") then
			local var_456_195 = io.open(getFolderPath(5) .. "\\GTA San Andreas User Files\\SAMP\\chatlog.txt", "a")

			if se.main.chatid and arg_456_1:find("%u%a+%_%u%a+") then
				local var_456_196 = {}

				for iter_456_4 in string.gmatch(arg_456_1, "%u%a+%_%u%a+") do
					var_456_196[iter_456_4] = true
				end

				for iter_456_5 in string.gmatch(arg_456_1, "%u%a+%_%u%a+%[%d+%]") do
					var_456_196[iter_456_5:match("(%u%a+%_%u%a+)%[%d+%]")] = nil
				end

				for iter_456_6, iter_456_7 in pairs(var_456_196) do
					if iter_456_7 then
						if as.other.id_list[nick] then
							arg_456_1 = arg_456_1:gsub(iter_456_6,
								iter_456_6 .. "[" .. as.other.id_list[iter_456_6] .. "]")
						else
							local var_456_197 = sampGetPlayerIdByNickname(iter_456_6)

							if var_456_197 then
								as.other.id_list[iter_456_6] = var_456_197
								arg_456_1 = arg_456_1:gsub(iter_456_6, iter_456_6 .. "[" .. var_456_197 .. "]")
							end
						end
					end
				end
			end

			var_456_195:write(os.date("[%H:%M:%S] ") .. arg_456_1 .. "\n")
			var_456_195:close()
			table.insert(as.other.renderWanted, {
				os.time(),
				arg_456_1
			})

			return false
		end

		if arg_456_0 == -1 and arg_456_1:find(".+ %[%d+%] %[LVL%:.*%d+%]") then
			local var_456_198 = arg_456_1:match("(.+) %[%d+%] %[LVL%: %d+%]")

			if var_456_198 then
				local var_456_199 = trim(var_456_198)

				if as.other.lastCheckedId ~= nil and sampIsPlayerConnected(as.other.lastCheckedId) and sampGetPlayerNickname(as.other.lastCheckedId) == var_456_199 then
					local var_456_200 = sampGetPlayerColor(as.other.lastCheckedId)

					arg_456_1 = arg_456_1 .. " {" .. getClr(var_456_200) .. "}CLIST{FFFFFF}"

					return {
						arg_456_0,
						arg_456_1
					}
				end
			end
		end

		if se.main.chatid and arg_456_1:find("%u%a+%_%u%a+") then
			local var_456_201 = {}

			for iter_456_8 in string.gmatch(arg_456_1, "%u%a+%_%u%a+") do
				var_456_201[iter_456_8] = true
			end

			for iter_456_9 in string.gmatch(arg_456_1, "%u%a+%_%u%a+%[%d+%]") do
				var_456_201[iter_456_9:match("(%u%a+%_%u%a+)%[%d+%]")] = nil
			end

			for iter_456_10, iter_456_11 in pairs(var_456_201) do
				if iter_456_11 then
					if as.other.id_list[nick] then
						arg_456_1 = arg_456_1:gsub(iter_456_10,
							iter_456_10 .. "[" .. as.other.id_list[iter_456_10] .. "]")
					else
						local var_456_202 = sampGetPlayerIdByNickname(iter_456_10)

						if var_456_202 then
							as.other.id_list[iter_456_10] = var_456_202
							arg_456_1 = arg_456_1:gsub(iter_456_10, iter_456_10 .. "[" .. var_456_202 .. "]")
						end
					end
				end
			end

			return {
				arg_456_0,
				arg_456_1
			}
		end
	end
end

function isFracIsForce(arg_466_0)
	if arg_466_0 and (arg_466_0 == "Army LV" or arg_466_0 == "Army SF" or arg_466_0 == "Police SF" or arg_466_0 == "Police LS" or arg_466_0 == "Police LV" or arg_466_0 == "Medic" or arg_466_0 == "Mayor" or arg_466_0 == "FBI") then
		return true
	end

	return false
end

function onReceivePacket(arg_467_0)
	if ({
			[36] = "������������ ��������",
			[35] = "������ ����������",
			[37] = "�������� ������",
			[31] = "�� ������� ��� ������������ ���������� �������",
			[32] = "�������� �� �������",
			[33] = "�������� ���������� � ��������!"
		})[arg_467_0] ~= nil then
		chat("���������� � �������� ��������, �������� ����������..")

		letsGame = false

		_G.setGxtEntry("PDP_DISCONNECTED", "1")
	end

	if arg_467_0 == 34 then
		chat("���������� �����������. �������� �����������..")

		letsGame = true
	end
end

function sendMdcData()
	if not as.other.mdcdata then
		chat("�� ������� �������� ������, �������� �� ���������.")

		return
	end

	local var_468_0 = {}
	local var_468_1, var_468_2 = sampGetCurrentServerAddress()
	local var_468_3, var_468_4 = sampGetPlayerIdByCharHandle(playerPed)
	local var_468_5 = sampGetPlayerNickname(var_468_4)

	var_468_0.info = {
		status = 6,
		sender = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))),
		fraction = frac ~= nil and frac or "-",
		message = as.other.mdcinfo.id,
		name = as.other.mdcinfo.name,
		id = var_468_4,
		server = tostring(var_468_1) .. ":" .. tostring(var_468_2),
		forwhom = as.other.mdcinfo.sender,
		data = as.other.mdcdata
	}

	local var_468_6 = {
		data = u8:encode(encodeJson(var_468_0)),
		headers = {
			["content-type"] = "application/json"
		}
	}

	sequent_async_http_request("POST", _G.buy[144] .. "post", var_468_6, function(arg_469_0)
		info = decodeJson(arg_469_0.text)

		if info == nil then
			chat("�� ������� ��������� ������, ���������� �������..")
		elseif info.result == 1 then
			chat(u8:decode(info.answer))
		end
	end, function(arg_470_0)
		return
	end)

	as.other.mdcinfo = nil
end

function var_0_3.onPlayerChatBubble(arg_471_0, arg_471_1, arg_471_2, arg_471_3, arg_471_4)
	if active and sampIsPlayerConnected(arg_471_0) and not arg_471_4:find("AFK") then
		if arg_471_4:find("��������") and caseStatus then
			local var_471_0 = sampGetPlayerNickname(arg_471_0)
			local var_471_1, var_471_2, var_471_3 = getCharCoordinates(select(2,
				sampGetCharHandleBySampPlayerId(arg_471_0)))
			local var_471_4, var_471_5, var_471_6 = getCharCoordinates(playerPed)
			local var_471_7 = getDistanceBetweenCoords3d(var_471_1, var_471_2, var_471_3, var_471_4, var_471_5, var_471_6)
			local var_471_8 = arg_471_4:match("������%(�%) �������� � ������� ������ (.*)")

			if var_471_8 and tonumber(caseTargetId) == arg_471_0 and caseTargetName == var_471_0 then
				chat(string.format("���� %s ��� ������� ������� � %d �. �� ���.", var_471_0:gsub("_", " "), var_471_7))
				chat(string.format("������� ����������� �� ����� ����� ���������� ��������� ������� %s.",
					var_471_8:gsub("_", " ")))

				caseStatus, caseTargetId, caseTargetName = false
			end
		end

		if arg_471_4:find("��������") or arg_471_4:find("��������") then
			if im.warns.drugs.v and arg_471_1 == -1029514497 and arg_471_4 == "��������� ��������" then
				local var_471_9 = sampGetPlayerNickname(arg_471_0)
				local var_471_10, var_471_11, var_471_12 = getCharCoordinates(select(2,
					sampGetCharHandleBySampPlayerId(arg_471_0)))
				local var_471_13, var_471_14, var_471_15 = getCharCoordinates(playerPed)
				local var_471_16 = getDistanceBetweenCoords3d(var_471_10, var_471_11, var_471_12, var_471_13, var_471_14,
					var_471_15)

				if srv_name == "revolution" or srv_name == "underground" then
					chat(string.format("%s[%d] ��������� ��������.", var_471_9, arg_471_0))
				else
					chat(string.format("%s[%d] ��������� �������� � %d �. �� ���.", var_471_9, arg_471_0, var_471_16))
				end
			end

			if im.warns.gribheal.v and arg_471_1 == -1029514497 and arg_471_4 == "��������� ��������" then
				local var_471_17 = sampGetPlayerNickname(arg_471_0)
				local var_471_18, var_471_19, var_471_20 = getCharCoordinates(select(2,
					sampGetCharHandleBySampPlayerId(arg_471_0)))
				local var_471_21, var_471_22, var_471_23 = getCharCoordinates(playerPed)
				local var_471_24 = getDistanceBetweenCoords3d(var_471_18, var_471_19, var_471_20, var_471_21, var_471_22,
					var_471_23)

				if srv_name == "revolution" or srv_name == "underground" then
					chat(string.format("%s[%d] ��������� ��������.", var_471_17, arg_471_0))
				else
					chat(string.format("%s[%d] ��������� �������� � %d �. �� ���.", var_471_17, arg_471_0, var_471_24))
				end
			end
		end
	end
end

function trim(arg_472_0)
	return (string.gsub(arg_472_0, "^%s*(.-)%s*$", "%1"))
end

function dcity()
	if frac then
		return ({
			["Police LS"] = "Los Santos",
			["Police SF"] = "San Fierro",
			["Police LV"] = "Las Venturas"
		})[frac]
	end

	return nil
end

function ShowMessage(arg_474_0, arg_474_1, arg_474_2)
	local var_474_0 = var_0_10.cast("void*", readMemory(13160328, 4, false))

	var_0_10.C.MessageBoxA(var_474_0, arg_474_0, arg_474_1, arg_474_2 and arg_474_2 + 327680 or 327680)
end

function getSeNumber()
	local var_475_0 = var_0_10.new("unsigned long[1]", 0)

	var_0_10.C.GetVolumeInformationA(nil, nil, 0, var_475_0, nil, nil, nil, 0)

	return var_475_0[0]
end

function getGun(arg_476_0)
	if arg_476_0 then
		guns = {
			[0] = "�����",
			"������",
			"������",
			"�������",
			"���",
			"����",
			"������",
			"���",
			"������",
			"���������",
			"�����",
			"�����",
			"��������",
			"���������",
			"�����",
			"������",
			"�������",
			"������������ ���",
			"�������� ��������",
			nil,
			nil,
			nil,
			"����� 9��",
			"�������� � ����������",
			"��������� ����",
			"������",
			"������",
			"������",
			"���",
			"��5",
			"��-47",
			"�4",
			"Tec-9",
			"��������",
			"����������� ��������",
			"���",
			"������",
			"�������",
			"�������",
			"����� � ������",
			"���������",
			"��������",
			"������������",
			"�����������",
			"������ ������� �������",
			"����������",
			"�������"
		}
		gunName = nil

		if guns[arg_476_0] ~= nil then
			return guns[arg_476_0]
		else
			return "����������"
		end
	end
end

function closestGunShop()
	local var_477_0 = ""
	local var_477_1 = 5000

	for iter_477_0, iter_477_1 in pairs(gunshops) do
		local var_477_2 = iter_477_1.x
		local var_477_3 = iter_477_1.y
		local var_477_4 = iter_477_1.z
		local var_477_5, var_477_6, var_477_7 = getCharCoordinates(playerPed)
		local var_477_8 = getDistanceBetweenCoords3d(var_477_2, var_477_3, var_477_4, var_477_5, var_477_6, var_477_7)

		if var_477_8 <= var_477_1 then
			var_477_0 = iter_477_0
			var_477_1 = var_477_8
		end
	end

	return var_477_0, var_477_1
end

function deleteOrientir(arg_478_0)
	if orientirNotify[arg_478_0] then
		lua_thread.create(function()
			wait(10000)

			orientirNotify[arg_478_0] = false
		end)
	end
end

function closestShop()
	local var_480_0 = ""
	local var_480_1 = 5000

	for iter_480_0, iter_480_1 in pairs(shops) do
		local var_480_2 = iter_480_1.x
		local var_480_3 = iter_480_1.y
		local var_480_4 = iter_480_1.z
		local var_480_5, var_480_6, var_480_7 = getCharCoordinates(playerPed)
		local var_480_8 = getDistanceBetweenCoords3d(var_480_2, var_480_3, var_480_4, var_480_5, var_480_6, var_480_7)

		if var_480_8 <= var_480_1 then
			var_480_0 = iter_480_0
			var_480_1 = var_480_8
		end
	end

	return var_480_0, var_480_1
end

function closestClothesShop()
	local var_481_0 = ""
	local var_481_1 = 5000

	for iter_481_0, iter_481_1 in pairs(clothesshops) do
		local var_481_2 = iter_481_1.x
		local var_481_3 = iter_481_1.y
		local var_481_4 = iter_481_1.z
		local var_481_5, var_481_6, var_481_7 = getCharCoordinates(playerPed)
		local var_481_8 = getDistanceBetweenCoords3d(var_481_2, var_481_3, var_481_4, var_481_5, var_481_6, var_481_7)

		if var_481_8 <= var_481_1 then
			var_481_0 = iter_481_0
			var_481_1 = var_481_8
		end
	end

	return var_481_0, var_481_1
end

clothesshops = {
	["�� �. ���-������"] = {
		z = 31,
		x = 457,
		y = -1502
	},
	["�� �. ���-������"] = {
		z = 24,
		x = -1696,
		y = 949
	},
	["�� �. ���-��������"] = {
		z = 11,
		x = 2802,
		y = 2429
	}
}
gunshops = {
	["���� �. ���-������"] = {
		z = 13,
		x = 1364,
		y = -1280
	},
	["���� �. ���-������"] = {
		z = 4,
		x = -2626,
		y = 212
	},
	["���� �. ���-��������"] = {
		z = 10,
		x = 2155,
		y = 943
	}
}

function isCharInAnyCopCar(arg_482_0)
	local var_482_0 = {
		415,
		426,
		427,
		490,
		528,
		560,
		596,
		597,
		598,
		599
	}

	for iter_482_0, iter_482_1 in ipairs(var_482_0) do
		if isCharInModel(arg_482_0, iter_482_1) then
			return true
		end
	end

	return false
end

function strtotime(arg_483_0)
	if tostring(arg_483_0):len() > 0 then
		if tostring(arg_483_0):find("%d%d%:%d%d%:%d%d") then
			local var_483_0 = tonumber(arg_483_0:match("(%d%d)%:%d%d%:%d%d"))
			local var_483_1 = tonumber(arg_483_0:match("%d%d%:(%d%d)%:%d%d"))
			local var_483_2 = tonumber(arg_483_0:match("%d%d%:%d%d%:(%d%d)"))

			return var_483_0 * 60 * 60 + var_483_1 * 60 + var_483_2
		end

		if arg_483_0:find("%d%d%:%d%d") then
			local var_483_3 = tonumber(arg_483_0:match("(%d%d)%:%d%d"))
			local var_483_4 = tonumber(arg_483_0:match("%d%d%:(%d%d)"))

			return var_483_3 * 60 + var_483_4
		end
	end

	return 0
end

function strobe()
	while true do
		wait(0)

		if isCharInAnyCopCar(playerPed) then
			local var_484_0 = storeCarCharIsInNoSave(playerPed)
			local var_484_1 = getDriverOfCar(var_484_0)

			if isCarSirenOn(var_484_0) and playerPed == var_484_1 and im.settings.strobe.v then
				local var_484_2 = getCarPointer(var_484_0) + 1440

				forceCarLights(var_484_0, 2)

				while isCarSirenOn(var_484_0) and im.settings.strobe.v do
					wait(0)
					wait(150)
					stroboscopes(7086336, var_484_2, 2, 0, 1, 0)
					stroboscopes(7086336, var_484_2, 1, 0, 3, 0)
					wait(80)
					stroboscopes(7086336, var_484_2, 2, 0, 1, 3)
					stroboscopes(7086336, var_484_2, 2, 0, 0, 0)
					stroboscopes(7086336, var_484_2, 1, 0, 0, 0)
					stroboscopes(7086336, var_484_2, 1, 0, 3, 0)

					if not isCarSirenOn(var_484_0) or not isCharInAnyCopCar(playerPed) or not im.settings.strobe.v then
						break
					end

					wait(150)
					stroboscopes(7086336, var_484_2, 2, 0, 1, 1)
					wait(150)
					stroboscopes(7086336, var_484_2, 2, 0, 0, 1)
					stroboscopes(7086336, var_484_2, 1, 0, 3, 3)
					stroboscopes(7086336, var_484_2, 1, 0, 1, 0)
					wait(80)
					stroboscopes(7086336, var_484_2, 2, 0, 1, 0)

					if not isCarSirenOn(var_484_0) or not isCharInAnyCopCar(playerPed) or not im.settings.strobe.v then
						break
					end

					wait(150)
					stroboscopes(7086336, var_484_2, 2, 0, 1, 0)
					stroboscopes(7086336, var_484_2, 2, 0, 1, 1)
					stroboscopes(7086336, var_484_2, 1, 0, 1, 0)
					stroboscopes(7086336, var_484_2, 1, 0, 1, 1)
					wait(150)
					stroboscopes(7086336, var_484_2, 2, 0, 1, 1)
					wait(80)
					stroboscopes(7086336, var_484_2, 2, 0, 1, 0)
					stroboscopes(7086336, var_484_2, 2, 0, 1, 1)
					stroboscopes(7086336, var_484_2, 1, 0, 1, 0)
					stroboscopes(7086336, var_484_2, 1, 0, 1, 1)
					wait(150)
					stroboscopes(7086336, var_484_2, 2, 0, 1, 0)

					if not isCarSirenOn(var_484_0) or not isCharInAnyCopCar(playerPed) or not im.settings.strobe.v then
						break
					end

					wait(150)
					stroboscopes(7086336, var_484_2, 2, 0, 1, 3)
					stroboscopes(7086336, var_484_2, 2, 0, 0, 0)
					stroboscopes(7086336, var_484_2, 1, 0, 0, 0)
					stroboscopes(7086336, var_484_2, 1, 0, 3, 0)
					wait(150)
					stroboscopes(7086336, var_484_2, 2, 0, 1, 0)
					stroboscopes(7086336, var_484_2, 1, 0, 3, 0)

					if not isCarSirenOn(var_484_0) or not isCharInAnyCopCar(playerPed) or not im.settings.strobe.v then
						break
					end
				end
			end
		end
	end
end

function stroboscopes(arg_485_0, arg_485_1, arg_485_2, arg_485_3, arg_485_4, arg_485_5)
	if not isCharInAnyCopCar(playerPed) then
		return
	end

	if not isCarSirenOn(storeCarCharIsInNoSave(playerPed)) then
		forceCarLights(storeCarCharIsInNoSave(playerPed), 0)
		callMethod(7086336, arg_485_1, 2, 0, 1, 3)
		callMethod(7086336, arg_485_1, 2, 0, 0, 0)
		callMethod(7086336, arg_485_1, 2, 0, 1, 0)
		callMethod(7086336, arg_485_1, 1, 0, 3, 0)
		markCarAsNoLongerNeeded(storeCarCharIsInNoSave(playerPed))

		return
	end

	if not im.settings.strobe.v then
		forceCarLights(storeCarCharIsInNoSave(playerPed), 0)
		callMethod(7086336, arg_485_1, 2, 0, 1, 3)
		callMethod(7086336, arg_485_1, 2, 0, 0, 0)
		callMethod(7086336, arg_485_1, 2, 0, 1, 0)
		callMethod(7086336, arg_485_1, 1, 0, 3, 0)
		markCarAsNoLongerNeeded(storeCarCharIsInNoSave(playerPed))

		return
	end

	callMethod(arg_485_0, arg_485_1, arg_485_2, arg_485_3, arg_485_4, arg_485_5)
end

shops = {
	["Idlewood 24-7"] = {
		z = 13.3802,
		x = 1920.6521,
		y = -1791.8212
	},
	["Mulholland 24-7"] = {
		z = 42.1803,
		x = 995.0821,
		y = -920.3821
	},
	["Flint 24-7"] = {
		z = 1.8501,
		x = -66.4521,
		y = -1172.1201
	},
	["Whestone 24-7"] = {
		z = 48.5401,
		x = -1581.6712,
		y = -2714.9921
	},
	["Juniper 24-7"] = {
		z = 45.3012,
		x = -2428.3821,
		y = 993.9012
	},
	["Easter 24-7"] = {
		z = 7.1821,
		x = -1699.9421,
		y = 413.5921
	},
	["Emerald Isle 24-7"] = {
		z = 10.8201,
		x = 2173.1231,
		y = 2478.3012
	},
	["Jullius 24-7"] = {
		z = 10.8201,
		x = 2639.6113,
		y = 1121.9921
	},
	["Redsands West 24-7"] = {
		z = 10.8201,
		x = 1597.5412,
		y = 2213.281
	},
	["Creek 24-7"] = {
		z = 10.8201,
		x = 2886.9901,
		y = 2446.2721
	},
	["Flats 24-7"] = {
		x = -2714,
		y = 4
	},
	["Bayside 24-7"] = {
		z = 4,
		x = -2518,
		y = 2338
	},
	["Fort Carson 24-7"] = {
		z = 19,
		x = -182,
		y = 1177
	},
	["Come-A-Lot 24-7"] = {
		z = 10,
		x = 2117,
		y = 900
	},
	["Palomino Creek 24-7"] = {
		z = 26,
		x = 2249,
		y = 50
	},
	["Dillimore 24-7"] = {
		z = 16,
		x = 658,
		y = -573
	}
}

function var_0_3.onShowDialog(arg_486_0, arg_486_1, arg_486_2, arg_486_3, arg_486_4, arg_486_5)
	local var_486_0 = arg_486_5

	if active then
		if equestRequest and se.main.equest and arg_486_0 == 1013 and arg_486_2:find("���������� �������%:") then
			local var_486_1, var_486_2, var_486_3, var_486_4, var_486_5 = arg_486_2:gsub("%{%S%S%S%S%S%S%}", ""):match(
			"���������� �������%:%s(%d%d%d%d)%/(%d%d)%/(%d%d)%s(%d%d)%:(%d%d)")

			if var_486_1 and var_486_2 and var_486_3 and var_486_4 and var_486_5 then
				local var_486_6 = string.format("%s:%s:00 %s/%s/%s", tostring(var_486_4), tostring(var_486_5),
					tostring(var_486_3), tostring(var_486_2), tostring(var_486_1))

				setEquest(var_486_6)
			end

			equestRequest = false

			return false
		end

		if se.main.equest and arg_486_0 == 1013 and arg_486_2:find("���������� �������%:") then
			local var_486_7, var_486_8, var_486_9, var_486_10, var_486_11 = arg_486_2:gsub("%{%S%S%S%S%S%S%}", ""):match(
			"���������� �������%:%s(%d%d%d%d)%/(%d%d)%/(%d%d)%s(%d%d)%:(%d%d)")

			if var_486_7 and var_486_8 and var_486_9 and var_486_10 and var_486_11 then
				local var_486_12 = string.format("%s:%s:00 %s/%s/%s", tostring(var_486_10), tostring(var_486_11),
					tostring(var_486_9), tostring(var_486_8), tostring(var_486_7))

				setEquest(var_486_12)
			end
		end

		if wanted_list and arg_486_0 == 22 and arg_486_1 == 5 and arg_486_2 == "������ �������������" then
			for iter_486_0 in arg_486_5:gmatch("[^\r\n]+") do
				if iter_486_0:find("%[.*%] .*%[ID%:%d+%].*%d") then
					local var_486_13, var_486_14, var_486_15 = iter_486_0:match("%[.*%] (.*)%[ID%:(%d+)%].*(%d)")

					if var_486_13 and var_486_14 and var_486_15 and tonumber(var_486_15) >= 4 then
						table.insert(wanted, var_486_14)

						wantedLevel[tonumber(var_486_14)] = tonumber(var_486_15)
					end
				end
			end

			wanted_list = false

			return false
		end

		if not wanted_list and arg_486_0 == 22 and arg_486_1 == 5 and arg_486_2 == "������ �������������" then
			wanted, wantedLevel, wanted_info = {}, {}, {}

			for iter_486_1 in arg_486_5:gmatch("[^\r\n]+") do
				if iter_486_1:find("%[.*%] .*%[ID%:%d+%].*%d") then
					local var_486_16, var_486_17, var_486_18 = iter_486_1:match("%[.*%] (.*)%[ID%:(%d+)%].*(%d)")

					if var_486_16 and var_486_17 and var_486_18 and tonumber(var_486_18) >= 4 then
						table.insert(wanted, var_486_17)

						wantedLevel[tonumber(var_486_17)] = tonumber(var_486_18)
					end
				end
			end
		end

		if member_state and arg_486_5:find("%[" .. Nid .. "%] " .. Nnick .. "(%A+)%[(%d+)%]") and _G.mass[mkey] then
			rangn, n_rang = arg_486_5:match("%[" .. Nid .. "%] " .. Nnick .. "(%A+)%[(%d+)%]")

			return false
		end

		if oks_state then
			for iter_486_2 in arg_486_5:gsub("{%S%S%S%S%S%S}", ""):gmatch("[^\r\n]+") do
				if iter_486_2:find("%[" .. oID .. "%].*" .. oNick .. "(.+)%s%[%d+%]") and _G.mass[mkey] then
					oRang = iter_486_2:match("%[" .. oID .. "%].*" .. oNick .. "(.+)%s+%[%d+%]")

					if oRang then
						oRang = trim(oRang)
					end

					if not oRang then
						am("������ ������ �� ��������.")
					end

					oks_state = false

					return false
				end
			end
		end

		if se.main.showranks and as.other.showranks_start and arg_486_2:find("������ ������") and arg_486_0 == 22 and _G.mass[mkey] then
			for iter_486_3, iter_486_4 in pairs(plmarks) do
				sampDestroy3dText(iter_486_4)
			end

			for iter_486_5 in arg_486_5:gmatch("[^\r\n]+") do
				if iter_486_5:find("%a+%_%a+") then
					local var_486_19, var_486_20, var_486_21 = iter_486_5:match(
					"%[%d+%].*%[(%d+)%].*(%u%a+%_%u%a+)%\t(%S+)")

					if var_486_19 and var_486_20 and var_486_21 and var_486_19 ~= myID then
						if plmarks[var_486_19] then
							sampDestroy3dText(plmarks[var_486_19])

							if changedRangs and changedRangs[var_486_21] ~= "" then
								plmarks[var_486_19] = sampCreate3dText(changedRangs[var_486_21], 4294967210, 0, 0, 0, 20,
									false, var_486_19, -1)
							else
								plmarks[var_486_19] = sampCreate3dText(var_486_21, 4294967210, 0, 0, 0, 20, false,
									var_486_19, -1)
							end
						elseif changedRangs and changedRangs[var_486_21] ~= "" then
							plmarks[var_486_19] = sampCreate3dText(changedRangs[var_486_21], 4294967210, 0, 0, 0, 20,
								false, var_486_19, -1)
						else
							plmarks[var_486_19] = sampCreate3dText(var_486_21, 4294967210, 0, 0, 0, 20, false, var_486_19,
								-1)
						end
					end
				end
			end

			as.other.showranks_start = false
			showRanksSet = os.clock()

			return false
		end

		if se.main.showranks and arg_486_2:find("������ ������") and arg_486_0 == 22 and _G.mass[mkey] then
			for iter_486_6, iter_486_7 in pairs(plmarks) do
				sampDestroy3dText(iter_486_7)
			end

			for iter_486_8 in arg_486_5:gmatch("[^\r\n]+") do
				if iter_486_8:find("%a+%_%a+") then
					local var_486_22, var_486_23, var_486_24 = iter_486_8:match(
					"%[%d+%].*%[(%d+)%].*(%u%a+%_%u%a+)%\t(%S+)")

					if var_486_22 and var_486_23 and var_486_24 and var_486_22 ~= myID then
						if plmarks[var_486_22] then
							sampDestroy3dText(plmarks[var_486_22])

							plmarks[var_486_22] = sampCreate3dText(var_486_24, 4294967210, 0, 0, 0, 20, false, var_486_22,
								-1)
						else
							plmarks[var_486_22] = sampCreate3dText(var_486_24, 4294967210, 0, 0, 0, 20, false, var_486_22,
								-1)
						end
					end
				end
			end
		end

		if (srv_name == "legacy" or srv_name == "revolution" or srv_name == "underground") and rank_state and arg_486_2:find("���������� ���������") then
			player_exp, frac, rang = var_486_0:match(
			".*\nExp\t(%d+ %/ %d+)\n.*�����������\t(.*)\n����\t(.*)%s%[.*%]\n������\t.*")

			if myName == "Diego_Steward" then
				player_exp, frac, rang = "10 / 100", "FBI", "�������� FBI"
			end

			if player_exp == nil then
				print("NO RESULT", "EXP")
			end

			if frac == nil then
				print("NO RESULT", "FRAC")
			end

			if rang == nil then
				print("NO RESULT", "RANG")
			end

			if player_exp ~= nil and frac ~= nil and rang ~= nil then
				player_exp = player_exp:gsub(" ", "")

				if frac:find("Police") or frac:find("Army") or frac:find("FBI") or frac:find("Court") then
					if frac == "Police SF" then
						myfrac = "1"
						fracn = "������� ������ ���-������"
					elseif frac == "Police LV" then
						myfrac = "2"
						fracn = "������� ������ ���-��������"
					elseif frac == "Police LS" then
						myfrac = "3"
						fracn = "������� ������ ���-������"
					elseif frac == "FBI" then
						myfrac = "4"
						fracn = "����������� ���� �������������"
					elseif frac == "Court" then
						myfrac = "5"
						fracn = "���"
					end
				else
					player_exp, frac, rang = nil

					print("NO RESULT FRACTION")

					scheck = scheck + 1
				end
			else
				player_exp, frac, rang = var_486_0:match(
				".*\nExp\t(%d+ %/ %d+)\n.*�����������\t.*(FBI).*\n����\t(.*)\n������\t.*")

				if player_exp and frac and rang then
					player_exp = player_exp:gsub(" ", "")
					myfrac = "4"
					fracn = "����������� ���� �������������"
				else
					print("NO RESULT FBI")

					scheck = scheck + 1
				end
			end

			rank_state = false

			sampSendDialogResponse(arg_486_0, 0, 0, "")

			return false
		end

		if srv_name == "evolve" and rank_state and arg_486_0 == 9901 then
			print("2")

			player_exp = string.match(arg_486_5, "Exp%s*(.-)\n")
			player_exp = player_exp:gsub("\t", "")

			sampAddChatMessage("����: " .. player_exp, -1)

			frac = string.match(arg_486_5, "�����������%s*(.-)\n")
			frac = frac:gsub("\t", "")

			sampAddChatMessage("�����������: " .. frac, -1)

			rang = string.match(arg_486_5, "���������%s*(.-)\n������%s*(.+)")
			rang = rang:gsub("\t", "")

			sampAddChatMessage("���������: " .. rang, -1)

			if player_exp == nil then
				print("NO RESULT", "EXP")
			end

			if frac == nil then
				print("NO RESULT", "FRAC")
			end

			if rang == nil then
				print("NO RESULT", "RANG")
			end

			if player_exp ~= nil and frac ~= nil and rang ~= nil then
				player_exp = player_exp:gsub(" ", "")

				if frac:find("Police") or frac:find("Army") or frac:find("FBI") or frac:find("Court") or frac:find("�����������") then
					if frac == "Police SF" then
						myfrac = "1"
						fracn = "������� ������ ���-������"
					elseif frac == "Police LV" then
						myfrac = "2"
						fracn = "������� ������ ���-��������"
					elseif frac == "Police LS" then
						myfrac = "3"
						fracn = "������� ������ ���-������"
					elseif frac == "FBI" then
						myfrac = "4"
						fracn = "����������� ���� �������������"
					elseif frac == "Court" then
						myfrac = "5"
						fracn = "���"
					end
				else
					player_exp, frac, rang = nil

					print("NO RESULT FRACTION")

					scheck = scheck + 1
				end
			else
				player_exp, frac, rang = var_486_0:match(
				".*\nExp\t(%d+ %/ %d+)\n.*�����������\t.*(FBI).*\n����\t(.*)\n������\t.*")

				if player_exp and frac and rang then
					player_exp = player_exp:gsub(" ", "")
					myfrac = "4"
					fracn = "����������� ���� �������������"
				else
					print("NO RESULT FBI")

					scheck = scheck + 1
				end
			end

			rank_state = false

			sampSendDialogResponse(arg_486_0, 0, 0, "")

			return false
		end

		if arg_486_2:find("����� ������") and im.informer.infMainWeapon.v and _G.mass[mkey] then
			if isKeyDown(VK_MENU) then
				if gunstat and _G.mass[mkey] then
					sampSendDialogResponse(arg_486_0, 1, 7, "")

					gunstat = false
				end
			elseif gunstat and _G.mass[mkey] then
				if im.weapons.infGunDeagle.v and _G.mass[mkey] then
					sampSendDialogResponse(arg_486_0, 1, 0, "")
				end

				if im.weapons.infGunShotgun.v and _G.mass[mkey] then
					sampSendDialogResponse(arg_486_0, 1, 1, "")
				end

				if im.weapons.infGunMP5.v and _G.mass[mkey] then
					sampSendDialogResponse(arg_486_0, 1, 2, "")
				end

				if im.weapons.infGunM4.v and _G.mass[mkey] then
					sampSendDialogResponse(arg_486_0, 1, 3, "")
				end

				if im.weapons.infGunRifle.v and _G.mass[mkey] then
					sampSendDialogResponse(arg_486_0, 1, 4, "")
				end

				if im.weapons.infGunArmor.v and _G.mass[mkey] then
					sampSendDialogResponse(arg_486_0, 1, 5, "")
				end

				if im.weapons.infGunSpecial.v and _G.mass[mkey] then
					sampSendDialogResponse(arg_486_0, 1, 6, "")

					if myfrac == "4" then
						sampSendDialogResponse(arg_486_0, 1, 6, "")
					end
				end

				gunstat = false
			end

			return false
		end

		if arg_486_0 == 22 and arg_486_2 == "������ ������" then
			local var_486_25 = arg_486_5

			for iter_486_9 in arg_486_5:gmatch("[^\r\n]+") do
				if iter_486_9:find("%u%a+%_%u%a+") then
					local var_486_26 = iter_486_9:match("(%u%a+%_%u%a+)")

					if var_486_26 then
						local var_486_27 = sampGetPlayerIdByNickname(var_486_26)

						if var_486_27 and sampIsPlayerConnected(var_486_27) then
							local var_486_28 = string.format("%06X", ARGBtoRGB(sampGetPlayerColor(var_486_27)))

							var_486_25 = var_486_25:gsub(var_486_26, "{" .. var_486_28 .. "}" .. var_486_26 .. "{FFFFFF}")
						elseif var_486_27 == select(2, sampGetPlayerIdByCharHandle(playerPed)) then
							local var_486_29 = string.format("%06X", ARGBtoRGB(sampGetPlayerColor(var_486_27)))

							var_486_25 = var_486_25:gsub(var_486_26, "{" .. var_486_29 .. "}" .. var_486_26 .. "{FFFFFF}")
						end
					end
				end
			end

			return {
				arg_486_0,
				arg_486_1,
				arg_486_2,
				arg_486_3,
				arg_486_4,
				var_486_25
			}
		end
	end
end

function getMessages(arg_487_0, arg_487_1, arg_487_2, arg_487_3, arg_487_4)
	local var_487_0 = var_0_2.thread(function(arg_488_0, arg_488_1, arg_488_2)
		local var_488_0 = require("requests")
		local var_488_1, var_488_2 = pcall(var_488_0.request, arg_488_0, arg_488_1, arg_488_2)

		if var_488_1 then
			var_488_2.json, var_488_2.xml = nil

			return true, var_488_2
		else
			return false, var_488_2
		end
	end)(arg_487_0, arg_487_1, arg_487_2)

	arg_487_3 = arg_487_3 or function()
		return
	end
	arg_487_4 = arg_487_4 or function()
		return
	end

	local var_487_1 = var_487_0

	while true do
		local var_487_2, var_487_3 = var_487_1:status()

		if not var_487_3 then
			if var_487_2 == "completed" then
				local var_487_4, var_487_5 = var_487_1:get()

				if var_487_4 then
					arg_487_3(var_487_5)
				else
					log.fatal("NOT RESULT GETM\t" .. var_487_5)
					arg_487_4(var_487_5)
				end

				return
			elseif var_487_2 == "canceled" then
				log.fatal("NOT COMPLETED\t" .. var_487_2)

				return arg_487_4(var_487_2)
			end
		else
			log.fatal("ERR GETM\t" .. var_487_3)

			return arg_487_4(var_487_3)
		end

		wait(0)
	end
end

function getBullets()
	local var_491_0 = getCurrentCharWeapon(playerPed)

	if var_491_0 ~= 0 and var_491_0 ~= 3 and var_491_0 ~= 46 then
		return getAmmoInClip() .. "/" .. getAmmoInCharWeapon(playerPed, var_491_0) - getAmmoInClip()
	else
		return ""
	end
end

function checkMessages()
	checkMessCol = 0
	garbageCol = 0

	while true do
		wait(0)

		if sampGetGamestate() ~= 3 or _G.buy[144] == nil then
			break
		end

		if active and letsGame then
			if checkMessCol >= 60 then
				chat("������ ������������� ����, ���� ������ �����������, �������� ������������.")

				checkMessCol = 0
			end

			local var_492_0 = {}
			local var_492_1, var_492_2 = sampGetCurrentServerAddress()
			local var_492_3, var_492_4 = sampGetPlayerIdByCharHandle(playerPed)
			local var_492_5, var_492_6, var_492_7 = getCharCoordinates(playerPed)
			local var_492_8 = sampGetPlayerNickname(var_492_4)

			var_492_0.info = {
				status = 2,
				sender = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))),
				server = tostring(var_492_1) .. ":" .. tostring(var_492_2),
				posx = var_492_5,
				posy = var_492_6,
				posz = var_492_7,
				heading = getCharHeading(playerPed),
				partner = se.main.partner ~= nil and se.main.partner ~= "" and
				(sampIsPlayerConnected(se.main.partner) and sampGetPlayerNickname(se.main.partner) or "") or "",
				health = getCharHealth(playerPed),
				armour = getCharArmour(playerPed),
				weapon = getCurrentCharWeapon(playerPed),
				sector = tostring(kvadUli(playerPed)),
				fraction = frac,
				rang = rang,
				bullets = getBullets(),
				color = string.format("%06X",
					ARGBtoRGB(sampGetPlayerColor(select(2, sampGetPlayerIdByCharHandle(playerPed))))),
				squad = {
					settings = se.squad,
					info = as.textdraw.squad_users,
					marker = {
						x = as.fastmap.c2x,
						y = as.fastmap.c2y
					}
				},
				timings = as.other.timingsForSend,
				interior = getActiveInterior(),
				vehicle = isCharInAnyCar(playerPed) and getCarModel(storeCarCharIsInNoSave(playerPed)) or 0,
				id = select(2, sampGetPlayerIdByCharHandle(playerPed)),
				sex = se ~= nil and (se.main.sex and 1 or 0) or true,
				mark = se ~= nil and se.main.area or "",
				clock = os.clock()
			}

			local var_492_9 = {
				data = u8:encode(encodeJson(var_492_0)),
				headers = {
					["content-type"] = "application/json"
				}
			}

			try(getMessages("POST", _G.buy[144] .. "post", var_492_9, function(arg_493_0)
				garbageCol = garbageCol + 1

				if im.settings.chat.v and (arg_493_0.text:find("^%{.*%}$") or arg_493_0.text:find("^%[.*%]$")) then
					info = decodeJson(arg_493_0.text)

					if info == nil then
						checkMessCol = checkMessCol + 1
					else
						checkMessCol = 0

						if info.result == 1 then
							if info.answer ~= nil then
								local var_493_0 = decodeJson(info.answer)

								if var_493_0 == nil then
									if im.settings.chat.v then
										print("������ �������������..")
									end
								else
									local var_493_1 = sortKeys(var_493_0)

									for iter_493_0, iter_493_1 in pairs(var_493_1) do
										sChat(u8:decode(iter_493_1))
									end
								end
							end
						elseif info.result == "error" then
							if info.reason == 425 then
								sChat("�� �������!")
							elseif info.reason == 441 then
								sChat("�� ������� ����� ����������!")
							end
						end
					end
				end

				if arg_493_0.text:find("^%{.*%}$") or arg_493_0.text:find("^%[.*%]$") then
					info = decodeJson(arg_493_0.text)

					if info ~= nil then
						if info.mdc ~= nil then
							local var_493_2 = decodeJson(info.mdc)

							if var_493_2 ~= nil and var_493_2.id ~= "1001" and var_493_2.sender_id ~= "1002" then
								if var_493_2.sender_id == var_492_4 and var_493_2.sender == var_492_8 then
									if sampIsPlayerConnected(tonumber(var_493_2.id)) and sampGetPlayerNickname(tonumber(var_493_2.id)) == var_493_2.name then
										sChat(string.format("MDC | ������ ������ �� %s[%d] ������� ��������� ��������.",
											sampGetPlayerNickname(tonumber(var_493_2.id)):gsub("_", " "), var_493_2.id))
									end
								elseif sampIsPlayerConnected(tonumber(var_493_2.id)) and sampGetPlayerNickname(tonumber(var_493_2.id)) == var_493_2.name and sampIsPlayerConnected(tonumber(var_493_2.sender_id)) and sampGetPlayerNickname(tonumber(var_493_2.sender_id)) == var_493_2.sender then
									sChat(string.format(
									"MDC | %s[%d] �������� ������ �� %s[%d]. ������� Y, ����� ��������� ������.",
										var_493_2.sender:gsub("_", " "), var_493_2.sender_id,
										sampGetPlayerNickname(tonumber(var_493_2.id)):gsub("_", " "), var_493_2.id))

									as.other.mdcinfo = var_493_2
								end
							end
						end

						if info.mdcresponse ~= nil then
							local var_493_3 = decodeJson(info.mdcresponse)

							if var_493_3 and var_493_3.from_name ~= nil then
								sChat("MDC | " ..
								var_493_3.from_name .. "[" .. var_493_3.from_id .. "] �������� ����� �� ��� ������..")
								sampAddChatMessage("----------------===[ MOBILE DATA COMPUTER ]===---------------",
									9013752)

								for iter_493_2, iter_493_3 in pairs(var_493_3.data) do
									sampAddChatMessage(u8:decode(iter_493_3), -1)
								end

								sampAddChatMessage("==============================================", 9013752)
							end
						end

						if info.partner ~= nil then
							local var_493_4 = decodeJson(info.partner)

							if var_493_4 ~= nil then
								as.partner.name = var_493_4.name ~= nil and var_493_4.name or ""
								as.partner.rang = var_493_4.rang ~= nil and u8:decode(var_493_4.rang) or var_493_4.rang
								as.partner.health = var_493_4.health ~= nil and var_493_4.health or "0"
								as.partner.armour = var_493_4.armour ~= nil and var_493_4.armour or "0"
								as.partner.weapon = var_493_4.weapon ~= nil and var_493_4.weapon or "0"
								as.partner.sector = var_493_4.sector ~= nil and u8:decode(var_493_4.sector) or
								var_493_4.sector
								as.partner.bullets = var_493_4.bullets ~= nil and var_493_4.bullets or "0/0"
								as.partner.color = var_493_4.color ~= nil and var_493_4.color or ""
							end
						end

						if info.squad ~= nil then
							local var_493_5 = decodeJson(info.squad)

							if var_493_5 ~= nil then
								if se.squad.show_marker_notify == true and var_492_8 ~= nil then
									for iter_493_4, iter_493_5 in pairs(var_493_5) do
										if as.textdraw.squaders[tostring(iter_493_4)] ~= nil and tostring(iter_493_4) ~= var_492_8 and iter_493_5.markers ~= nil and as.textdraw.squaders[tostring(iter_493_4)].markers ~= nil then
											for iter_493_6, iter_493_7 in pairs(iter_493_5.markers) do
												if not as.textdraw.squaders[tostring(iter_493_4)].markers[iter_493_6] then
													sChat("SQUAD | " ..
													tostring(iter_493_4) ..
													" ���������" ..
													(iter_493_5.sex == 1 and "" or "�") ..
													" ����� �� " ..
													kvadUliXY(iter_493_7.x, iter_493_7.y) ..
													". ������� ����� �� ��. " .. se.keys.fastmap .. ".")
												end
											end
										end
									end
								end

								as.textdraw.squaders = var_493_5
								as.textdraw.squad_updated = os.time()
							end
						end

						if info.timings ~= nil then
							local var_493_6 = decodeJson(info.timings)

							if var_493_6 ~= nil then
								timings = var_493_6
							end
						end

						if info.others ~= nil then
							local var_493_7 = decodeJson(info.others)

							if var_493_7 then
								as.other.players = var_493_7
							end
						end
					end
				end
			end, function(arg_494_0)
				return
			end))
			wait(300)

			if letsGame and garbageCol > 10 then
				collectgarbage()

				garbageCol = 0
			end
		end
	end
end

function GetVehicleHeader()
	local var_495_0 = 0
	local var_495_1 = storeCarCharIsInNoSave(playerPed)

	if var_495_1 then
		var_495_0 = getCarModel(var_495_1)
		var_495_0 = var_0_11.getint32(var_495_0 * 4 + 11120840, false)
		var_495_0 = var_0_11.getint16(var_495_0 + 74, false)
	end

	return var_495_0
end

function tmpWrite(arg_496_0, arg_496_1)
	local var_496_0, var_496_1 = os.getenv("TEMP"):gsub("\\", "/")
	local var_496_2 = var_496_0 .. "/" .. sha1(arg_496_0)
	local var_496_3 = io.open(var_496_2, "w+")

	var_496_3:write(arg_496_1)
	var_496_3:close()
end

function tmpGet(arg_497_0)
	local var_497_0, var_497_1 = os.getenv("TEMP"):gsub("\\", "/")
	local var_497_2 = var_497_0 .. "/" .. sha1(arg_497_0)
	local var_497_3 = io.open(var_497_2, "r")

	if var_497_3 then
		local var_497_4 = var_497_3:read("*a")

		var_497_3:close()

		return var_497_4
	end

	return ""
end

function tmpRemove(arg_498_0)
	local var_498_0, var_498_1 = os.getenv("TEMP"):gsub("\\", "/")
	local var_498_2 = var_498_0 .. "/" .. sha1(arg_498_0)

	if doesFileExist(var_498_2) then
		os.remove(var_498_2)
	end
end

function onExitScript(arg_499_0)
	setGameTime()

	if not arg_499_0 then
		for iter_499_0, iter_499_1 in pairs(plmarks) do
			if sampIs3dTextDefined(iter_499_1) then
				sampDestroy3dText(iter_499_1)
			end
		end

		if sampIs3dTextDefined(marker) then
			sampDestroy3dText(marker)
		end

		sampTextdrawDelete(1)
		sampTextdrawDelete(2)

		for iter_499_2, iter_499_3 in pairs(var_0_34) do
			if sampIs3dTextDefined(iter_499_3) then
				sampDestroy3dText(iter_499_3)
			end
		end

		if as then
			for iter_499_4, iter_499_5 in pairs(as.other.newmansset) do
				if sampIs3dTextDefined(iter_499_5) then
					sampDestroy3dText(iter_499_5)
				end
			end
		end

		if as then
			tmpWrite("squad-info", encodeJson(as.textdraw))
		end

		if gg.gz and #gg.gz > 0 then
			tmpWrite("PDPGGZZ", encodeJson(gg.gz))
		end

		if gg.gz_flash and #gg.gz_flash > 0 then
			tmpWrite("PDPGGZZFF", encodeJson(gg.gz_flash))
		end

		restoreSpeedometer()
	end

	log.fatal("System exit.")
end

function onScriptTerminate(arg_500_0, arg_500_1)
	if arg_500_0 == thisScript() then
		setGameTime()

		if se and se.main.hud == false then
			displayHud(true)
		end

		for iter_500_0, iter_500_1 in pairs(plmarks) do
			if sampIs3dTextDefined(iter_500_1) then
				sampDestroy3dText(iter_500_1)
			end
		end

		if sampIs3dTextDefined(marker) then
			sampDestroy3dText(marker)
		end

		for iter_500_2, iter_500_3 in pairs(var_0_34) do
			if sampIs3dTextDefined(iter_500_3) then
				sampDestroy3dText(iter_500_3)
			end
		end

		if as then
			for iter_500_4, iter_500_5 in pairs(as.other.newmansset) do
				if sampIs3dTextDefined(iter_500_5) then
					sampDestroy3dText(iter_500_5)
				end
			end
		end

		sampTextdrawDelete(1)
		sampTextdrawDelete(2)

		if as then
			tmpWrite("squad-info", encodeJson(as.textdraw))
		end

		if gg.gz and #gg.gz > 0 then
			tmpWrite("PDPGGZZ", encodeJson(gg.gz))
		end

		if gg.gz_flash and #gg.gz_flash > 0 then
			tmpWrite("PDPGGZZFF", encodeJson(gg.gz_flash))
		end

		restoreSpeedometer()
	end
end

function getUli(arg_501_0, arg_501_1)
	if arg_501_0 == nil or arg_501_1 == nil then
		arg_501_0, arg_501_1 = getCharCoordinates(playerPed)
	end

	local var_501_0 = (arg_501_1 * -1 + 3000) / 250
	local var_501_1, var_501_2 = math.modf(round(var_501_0, 2))
	local var_501_3 = (arg_501_0 + 3000) / 250
	local var_501_4, var_501_5 = math.modf(round(var_501_3, 2))
	local var_501_6 = 0

	if var_501_5 <= 0.33 and var_501_2 <= 0.33 then
		var_501_6 = 1
	end

	if var_501_5 > 0.33 and var_501_5 <= 0.66 and var_501_2 <= 0.33 then
		var_501_6 = 2
	end

	if var_501_5 > 0.66 and var_501_2 <= 0.33 then
		var_501_6 = 3
	end

	if var_501_5 > 0.66 and var_501_2 > 0.33 and var_501_2 <= 0.66 then
		var_501_6 = 4
	end

	if var_501_5 > 0.66 and var_501_2 > 0.66 then
		var_501_6 = 5
	end

	if var_501_5 > 0.33 and var_501_5 <= 0.66 and var_501_2 > 0.66 then
		var_501_6 = 6
	end

	if var_501_5 <= 0.33 and var_501_2 > 0.66 then
		var_501_6 = 7
	end

	if var_501_5 <= 0.33 and var_501_2 > 0.33 and var_501_2 <= 0.66 then
		var_501_6 = 8
	end

	if var_501_5 > 0.33 and var_501_5 <= 0.66 and var_501_2 > 0.33 and var_501_2 <= 0.66 then
		var_501_6 = 9
	end

	return var_501_6
end

function kvad(arg_502_0)
	local var_502_0 = {
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�"
	}

	if doesCharExist(arg_502_0) then
		if getCharCoordinates(arg_502_0) ~= nil then
			local var_502_1, var_502_2, var_502_3 = getCharCoordinates(arg_502_0)

			if var_502_1 ~= nil and var_502_2 ~= nil and var_502_3 ~= nil then
				local var_502_4 = math.ceil((var_502_1 + 3000) / 250)
				local var_502_5 = math.ceil((var_502_2 * -1 + 3000) / 250)

				if var_502_0[var_502_5] ~= nil then
					return var_502_0[var_502_5] .. "-" .. var_502_4
				else
					return "No signal"
				end
			else
				return "No signal"
			end
		else
			return "No signal"
		end
	else
		return "No signal"
	end
end

function kvadUli(arg_503_0)
	local var_503_0 = {
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�"
	}

	if doesCharExist(arg_503_0) then
		if getCharCoordinates(arg_503_0) ~= nil then
			local var_503_1, var_503_2, var_503_3 = getCharCoordinates(arg_503_0)
			local var_503_4 = getUli(var_503_1, var_503_2)

			if var_503_1 ~= nil and var_503_2 ~= nil and var_503_3 ~= nil then
				local var_503_5 = math.ceil((var_503_1 + 3000) / 250)
				local var_503_6 = math.ceil((var_503_2 * -1 + 3000) / 250)

				if var_503_0[var_503_6] ~= nil then
					return var_503_0[var_503_6] .. "-" .. var_503_5 .. "-" .. var_503_4
				else
					return "No signal"
				end
			else
				return "No signal"
			end
		else
			return "No signal"
		end
	else
		return "No signal"
	end
end

function kvadUliXY(arg_504_0, arg_504_1)
	local var_504_0 = {
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�"
	}

	if arg_504_0 ~= nil and arg_504_1 ~= nil then
		local var_504_1 = getUli(arg_504_0, arg_504_1)

		arg_504_0 = math.ceil((arg_504_0 + 3000) / 250)
		arg_504_1 = math.ceil((arg_504_1 * -1 + 3000) / 250)

		if var_504_0[arg_504_1] ~= nil then
			arg_504_1 = var_504_0[arg_504_1]

			return arg_504_1 .. "-" .. arg_504_0 .. "-" .. var_504_1
		else
			return "No signal"
		end
	else
		return "No signal"
	end
end

function sortKeys(arg_505_0)
	local var_505_0 = {}
	local var_505_1 = {}

	for iter_505_0, iter_505_1 in pairs(arg_505_0) do
		table.insert(var_505_0, iter_505_0)
	end

	table.sort(var_505_0)

	for iter_505_2, iter_505_3 in pairs(var_505_0) do
		var_505_1[iter_505_2] = arg_505_0[iter_505_3]
	end

	return var_505_1
end

function sortKeysAnother(arg_506_0)
	local var_506_0 = {}
	local var_506_1 = {}

	for iter_506_0, iter_506_1 in pairs(arg_506_0) do
		table.insert(var_506_0, iter_506_0)
	end

	table.sort(var_506_0, function(arg_507_0, arg_507_1)
		return arg_507_1 < arg_507_0
	end)

	for iter_506_2, iter_506_3 in pairs(var_506_0) do
		var_506_1[iter_506_2] = arg_506_0[iter_506_3]
	end

	return var_506_1
end

function var_0_0.AnimProgressBar(arg_508_0, arg_508_1, arg_508_2, arg_508_3, arg_508_4)
	local var_508_0 = 8

	local function var_508_1(arg_509_0, arg_509_1, arg_509_2, arg_509_3)
		local var_509_0 = os.clock() - arg_509_2

		if var_509_0 >= 0 and var_509_0 <= arg_509_3 then
			return arg_509_0 + var_509_0 / (arg_509_3 / 100) * (arg_509_1 - arg_509_0) / 100, var_509_0, false
		end

		return arg_509_3 < var_509_0 and arg_509_1 or arg_509_0, var_509_0, true
	end

	if arg_508_1 == nil then
		arg_508_1 = 0
	end

	if arg_508_1 > 100 then
		arg_508_1 = 100
	end

	if IMGUI_ANIM_PROGRESS_BAR == nil then
		IMGUI_ANIM_PROGRESS_BAR = {}
	end

	if IMGUI_ANIM_PROGRESS_BAR ~= nil and IMGUI_ANIM_PROGRESS_BAR[arg_508_0] == nil then
		IMGUI_ANIM_PROGRESS_BAR[arg_508_0] = {
			clock = 0,
			int = arg_508_1 or 0
		}
	end

	local var_508_2 = math.floor
	local var_508_3 = IMGUI_ANIM_PROGRESS_BAR[arg_508_0]

	if var_508_3.int ~= arg_508_1 then
		if var_508_3.clock == 0 then
			var_508_3.clock = os.clock()
		end

		local var_508_4 = {
			var_508_1(var_508_3.int, arg_508_1, var_508_3.clock, var_508_0 or 2.25)
		}

		if arg_508_1 <= var_508_4[1] then
			if arg_508_1 > var_508_4[1] - 0.01 then
				var_508_3.clock = 0
				var_508_3.int = var_508_2(var_508_4[1] - 0.01)
			end
		elseif arg_508_1 > var_508_4[1] and arg_508_1 < var_508_4[1] + 0.01 then
			var_508_3.clock = 0
			var_508_3.int = var_508_2(var_508_4[1] + 0.01)
		end

		var_508_3.int = var_508_4[1]
	end

	if arg_508_2 == nil then
		arg_508_2 = var_0_0.ImVec4(1, 1, 1, 0.3)
	end

	if arg_508_4 == true then
		ptext = ""
	else
		ptext = string.format("%i", var_508_3.int)

		if var_508_3.int >= 99.8 then
			ptext = "100"
		end
	end

	var_0_0.PushStyleVar(6, 15)
	var_0_0.PushStyleColor(var_0_0.Col.Text, var_0_0.ImVec4(0, 0, 0, 0.5))
	var_0_0.PushStyleColor(var_0_0.Col.FrameBg, var_0_0.ImVec4(1, 1, 1, 0.2))
	var_0_0.PushStyleColor(var_0_0.Col.PlotHistogram, arg_508_2)
	var_0_0.ProgressBar(var_508_3.int / 100, arg_508_3 or var_0_0.ImVec2(-1, 15), ptext)
	var_0_0.PopStyleColor(3)
	var_0_0.PopStyleVar()
end

function var_0_0.CustomAnimProgressBar(arg_510_0, arg_510_1, arg_510_2, arg_510_3, arg_510_4, arg_510_5)
	if arg_510_2 == nil then
		arg_510_2 = 100
	end

	local var_510_0 = 8

	local function var_510_1(arg_511_0, arg_511_1, arg_511_2, arg_511_3)
		local var_511_0 = os.clock() - arg_511_2

		if var_511_0 >= 0 and var_511_0 <= arg_511_3 then
			return arg_511_0 + var_511_0 / (arg_511_3 / 100) * (arg_511_1 - arg_511_0) / 100, var_511_0, false
		end

		return arg_511_3 < var_511_0 and arg_511_1 or arg_511_0, var_511_0, true
	end

	if arg_510_1 == nil then
		arg_510_1 = 0
	end

	if IMGUI_ANIM_PROGRESS_BAR == nil then
		IMGUI_ANIM_PROGRESS_BAR = {}
	end

	if IMGUI_ANIM_PROGRESS_BAR ~= nil and IMGUI_ANIM_PROGRESS_BAR[arg_510_0] == nil then
		IMGUI_ANIM_PROGRESS_BAR[arg_510_0] = {
			clock = 0,
			int = arg_510_1 or 0
		}
	end

	local var_510_2 = math.floor
	local var_510_3 = IMGUI_ANIM_PROGRESS_BAR[arg_510_0]

	if var_510_3.int ~= arg_510_1 then
		if var_510_3.clock == 0 then
			var_510_3.clock = os.clock()
		end

		local var_510_4 = {
			var_510_1(var_510_3.int, arg_510_1, var_510_3.clock, var_510_0 or 2.25)
		}

		if arg_510_1 <= var_510_4[1] then
			if arg_510_1 > var_510_4[1] - 0.01 then
				var_510_3.clock = 0
				var_510_3.int = var_510_2(var_510_4[1] - 0.01)
			end
		elseif arg_510_1 > var_510_4[1] and arg_510_1 < var_510_4[1] + 0.01 then
			var_510_3.clock = 0
			var_510_3.int = var_510_2(var_510_4[1] + 0.01)
		end

		var_510_3.int = var_510_4[1]
	end

	if arg_510_3 == nil then
		arg_510_3 = var_0_0.ImVec4(1, 1, 1, 0.3)
	end

	if arg_510_5 == true then
		ptext = ""
	else
		ptext = string.format("%i", round(var_510_3.int))
	end

	var_0_0.PushStyleVar(6, 15)
	var_0_0.PushStyleColor(var_0_0.Col.Text, var_0_0.ImVec4(0, 0, 0, 0.5))
	var_0_0.PushStyleColor(var_0_0.Col.FrameBg, var_0_0.ImVec4(1, 1, 1, 0.2))
	var_0_0.PushStyleColor(var_0_0.Col.PlotHistogram, arg_510_3)
	var_0_0.ProgressBar(var_510_3.int / arg_510_2, arg_510_4 or var_0_0.ImVec2(-1, 15), ptext)
	var_0_0.PopStyleColor(3)
	var_0_0.PopStyleVar()
end

function setmark()
	if isCharInAnyCar(playerPed) then
		if getCarModel(storeCarCharIsInNoSave(playerPed)) == 427 or getCarModel(storeCarCharIsInNoSave(playerPed)) == 523 or getCarModel(storeCarCharIsInNoSave(playerPed)) == 599 or getCarModel(storeCarCharIsInNoSave(playerPed)) == 426 or getCarModel(storeCarCharIsInNoSave(playerPed)) == 597 or getCarModel(storeCarCharIsInNoSave(playerPed)) == 596 then
			if marker then
				sampDestroy3dText(marker)

				if getCarModel(storeCarCharIsInNoSave(playerPed)) == 427 then
					fposX, fposY, fposZ = 0.7, -4, -0.2
				elseif getCarModel(storeCarCharIsInNoSave(playerPed)) == 523 then
					fposX, fposY, fposZ = 0.3, -1.1, 0
				elseif getCarModel(storeCarCharIsInNoSave(playerPed)) == 599 then
					fposX, fposY, fposZ = 0.8, -2.9, -0.1
				elseif getCarModel(storeCarCharIsInNoSave(playerPed)) == 426 then
					fposX, fposY, fposZ = 0.7, -2.9, -0.2
				elseif getCarModel(storeCarCharIsInNoSave(playerPed)) == 596 then
					fposX, fposY, fposZ = 0.7, -2.9, -0.3
				elseif getCarModel(storeCarCharIsInNoSave(playerPed)) == 597 then
					fposX, fposY, fposZ = 0.7, -2.9, -0.3
				end

				marker = sampCreate3dText(string.upper(se.main.area), 4294967295, fposX, fposY, fposZ, 25, false, -1,
					select(2, sampGetVehicleIdByCarHandle(storeCarCharIsInNoSave(playerPed))))
			else
				if getCarModel(storeCarCharIsInNoSave(playerPed)) == 427 then
					fposX, fposY, fposZ = 0.7, -4, -0.2
				elseif getCarModel(storeCarCharIsInNoSave(playerPed)) == 523 then
					fposX, fposY, fposZ = 0.3, -1.1, 0
				elseif getCarModel(storeCarCharIsInNoSave(playerPed)) == 599 then
					fposX, fposY, fposZ = 0.8, -2.9, -0.1
				elseif getCarModel(storeCarCharIsInNoSave(playerPed)) == 426 then
					fposX, fposY, fposZ = 0.7, -2.9, -0.2
				elseif getCarModel(storeCarCharIsInNoSave(playerPed)) == 596 then
					fposX, fposY, fposZ = 0.7, -2.9, -0.3
				elseif getCarModel(storeCarCharIsInNoSave(playerPed)) == 597 then
					fposX, fposY, fposZ = 0.7, -2.9, -0.3
				end

				marker = sampCreate3dText(string.upper(se.main.area), 4294967295, fposX, fposY, fposZ, 25, false, -1,
					select(2, sampGetVehicleIdByCarHandle(storeCarCharIsInNoSave(playerPed))))
			end
		else
			am("�������� ������ � ���������� �������.")
		end
	end
end

function round(arg_513_0, arg_513_1)
	local var_513_0 = 10 ^ (arg_513_1 or 0)

	return math.floor(arg_513_0 * var_513_0 + 0.5) / var_513_0
end

function unkvad(arg_514_0)
	if arg_514_0:find("%S+%-%d+") then
		local var_514_0, var_514_1 = arg_514_0:match("(%S)%-(%d+)")

		if var_514_1 and var_514_0 then
			var_514_0 = var_514_1
			var_514_1 = (var_514_1 - 3000) * 250
		end

		return var_514_1, var_514_0
	end
end

function section(arg_515_0, arg_515_1, arg_515_2)
	local var_515_0 = {
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�",
		"�"
	}

	if arg_515_0 and arg_515_1 and arg_515_2 then
		arg_515_0 = math.ceil((arg_515_0 + 3000) / 250)
		arg_515_1 = math.ceil((arg_515_1 * -1 + 3000) / 250)
		arg_515_1 = var_515_0[arg_515_1]

		return arg_515_1 .. "-" .. arg_515_0
	else
		return "No signal"
	end
end

function sampSetChatInputCursor(arg_516_0, arg_516_1)
	local var_516_0 = arg_516_1 or arg_516_0
	local var_516_1 = tonumber(arg_516_0)
	local var_516_2 = tonumber(var_516_0)
	local var_516_3 = require("memory")
	local var_516_4 = sampGetInputInfoPtr()
	local var_516_5 = getStructElement(var_516_4, 8, 4)

	var_516_3.setint8(var_516_5 + 286, var_516_1)
	var_516_3.setint8(var_516_5 + 281, var_516_2)

	return true
end

function sampGetPlayerIdByNickname(arg_517_0)
	local var_517_0, var_517_1 = sampGetPlayerIdByCharHandle(playerPed)

	if tostring(arg_517_0) == sampGetPlayerNickname(var_517_1) then
		return var_517_1
	end

	for iter_517_0 = 0, 1000 do
		if sampIsPlayerConnected(iter_517_0) and sampGetPlayerNickname(iter_517_0) == tostring(arg_517_0) then
			return iter_517_0
		end
	end
end

function remu()
	for iter_518_0 = 0, 1000 do
		local var_518_0 = blip[#blip]

		removeBlip(var_518_0)

		blip[#blip] = nil
	end
end

function var_0_0.TextColoredRGB(arg_519_0, arg_519_1)
	local var_519_0 = var_0_0.GetStyle().Colors
	local var_519_1 = var_0_0.Col
	local var_519_2 = require("encoding").UTF8

	local function var_519_3(arg_520_0)
		if arg_520_0:upper():sub(1, 6) == "SSSSSS" then
			return var_0_0.ImVec4(var_519_0[var_519_1.Text].x, var_519_0[var_519_1.Text].y, var_519_0[var_519_1.Text].z,
				tonumber(arg_520_0:sub(7, 8), 16) and tonumber(arg_520_0:sub(7, 8), 16) / 255 or
				var_519_0[var_519_1.Text].w)
		end

		local var_520_0 = type(arg_520_0) == "number" and ("%X"):format(arg_520_0):upper() or arg_520_0:upper()
		local var_520_1 = {}

		for iter_520_0 = 1, #var_520_0 / 2 do
			var_520_1[#var_520_1 + 1] = tonumber(var_520_0:sub(2 * iter_520_0 - 1, 2 * iter_520_0), 16)
		end

		return var_0_0.ImVec4(var_520_1[1] / 255, var_520_1[2] / 255, var_520_1[3] / 255,
			var_520_1[4] and var_520_1[4] / 255 or var_519_0[var_519_1.Text].w)
	end

	; (function(arg_521_0)
		for iter_521_0 in arg_521_0:gmatch("[^\r\n]+") do
			local var_521_0 = {}
			local var_521_1 = {}
			local var_521_2 = 1
			local var_521_3 = 1

			if iter_521_0:sub(1, 8) == "[center]" then
				var_521_2 = 2
				iter_521_0 = iter_521_0:sub(9)
			elseif iter_521_0:sub(1, 7) == "[right]" then
				var_521_2 = 3
				iter_521_0 = iter_521_0:sub(8)
			end

			iter_521_0 = iter_521_0:gsub("{(......)}", "{%1FF}")

			while iter_521_0:find("{........}") do
				local var_521_4, var_521_5 = iter_521_0:find("{........}")

				if tonumber(iter_521_0:sub(var_521_4 + 1, var_521_5 - 1), 16) or iter_521_0:sub(var_521_4 + 1, var_521_5 - 3):upper() == "SSSSSS" and tonumber(iter_521_0:sub(var_521_5 - 2, var_521_5 - 1), 16) or iter_521_0:sub(var_521_5 - 2, var_521_5 - 1):upper() == "SS" then
					var_521_0[#var_521_0], var_521_0[#var_521_0 + 1] = iter_521_0:sub(var_521_3, var_521_4 - 1),
						iter_521_0:sub(var_521_5 + 1, #iter_521_0)
					var_521_1[#var_521_1 + 1] = var_519_3(iter_521_0:sub(var_521_4 + 1, var_521_5 - 1))
					iter_521_0 = iter_521_0:sub(1, var_521_4 - 1) .. iter_521_0:sub(var_521_5 + 1, #iter_521_0)
					var_521_3 = var_521_4
				else
					iter_521_0 = iter_521_0:sub(1, var_521_4 - 1) ..
					iter_521_0:sub(var_521_4, var_521_5 - 3) .. "}" .. iter_521_0:sub(var_521_5 + 1, #iter_521_0)
				end
			end

			local var_521_6 = var_0_0.CalcTextSize(var_519_2(iter_521_0))

			if var_521_2 == 2 then
				var_0_0.NewLine()
				var_0_0.SameLine(arg_519_1 / 2 - var_521_6.x / 2)
			elseif var_521_2 == 3 then
				var_0_0.NewLine()
				var_0_0.SameLine(arg_519_1 - var_521_6.x - 5)
			end

			if var_521_0[0] then
				for iter_521_1, iter_521_2 in pairs(var_521_0) do
					var_0_0.TextColored(var_521_1[iter_521_1] or var_519_0[var_519_1.Text], var_519_2(iter_521_2))
					var_0_0.SameLine(nil, 0)
				end

				var_0_0.NewLine()
			else
				var_0_0.Text(var_519_2(iter_521_0))
			end
		end
	end)(arg_519_0)
end

function var_0_0.TextColoredRGB2(arg_522_0, arg_522_1, arg_522_2)
	local var_522_0 = var_0_0.GetStyle().Colors
	local var_522_1 = var_0_0.Col
	local var_522_2 = require("encoding").UTF8

	local function var_522_3(arg_523_0)
		if arg_523_0:upper():sub(1, 6) == "SSSSSS" then
			return var_0_0.ImVec4(var_522_0[var_522_1.Text].x, var_522_0[var_522_1.Text].y, var_522_0[var_522_1.Text].z,
				tonumber(arg_523_0:sub(7, 8), 16) and tonumber(arg_523_0:sub(7, 8), 16) / 255 or
				var_522_0[var_522_1.Text].w)
		end

		local var_523_0 = type(arg_523_0) == "number" and ("%X"):format(arg_523_0):upper() or arg_523_0:upper()
		local var_523_1 = {}

		for iter_523_0 = 1, #var_523_0 / 2 do
			var_523_1[#var_523_1 + 1] = tonumber(var_523_0:sub(2 * iter_523_0 - 1, 2 * iter_523_0), 16)
		end

		return var_0_0.ImVec4(var_523_1[1] / 255, var_523_1[2] / 255, var_523_1[3] / 255,
			var_523_1[4] and var_523_1[4] / 255 or var_522_0[var_522_1.Text].w)
	end

	; (function(arg_524_0)
		for iter_524_0 in arg_524_0:gmatch("[^\r\n]+") do
			local var_524_0 = {}
			local var_524_1 = {}
			local var_524_2 = 1
			local var_524_3 = 1

			if iter_524_0:sub(1, 8) == "[center]" then
				var_524_2 = 2
				iter_524_0 = iter_524_0:sub(9)
			elseif iter_524_0:sub(1, 7) == "[right]" then
				var_524_2 = 3
				iter_524_0 = iter_524_0:sub(8)
			end

			if not arg_522_2 then
				iter_524_0 = iter_524_0:gsub("{(......)}", "{%1FF}")
			else
				iter_524_0 = iter_524_0:gsub("{(......)}", "{%199}")
			end

			while iter_524_0:find("{........}") do
				local var_524_4, var_524_5 = iter_524_0:find("{........}")

				if tonumber(iter_524_0:sub(var_524_4 + 1, var_524_5 - 1), 16) or iter_524_0:sub(var_524_4 + 1, var_524_5 - 3):upper() == "SSSSSS" and tonumber(iter_524_0:sub(var_524_5 - 2, var_524_5 - 1), 16) or iter_524_0:sub(var_524_5 - 2, var_524_5 - 1):upper() == "SS" then
					var_524_0[#var_524_0], var_524_0[#var_524_0 + 1] = iter_524_0:sub(var_524_3, var_524_4 - 1),
						iter_524_0:sub(var_524_5 + 1, #iter_524_0)
					var_524_1[#var_524_1 + 1] = var_522_3(iter_524_0:sub(var_524_4 + 1, var_524_5 - 1))
					iter_524_0 = iter_524_0:sub(1, var_524_4 - 1) .. iter_524_0:sub(var_524_5 + 1, #iter_524_0)
					var_524_3 = var_524_4
				else
					iter_524_0 = iter_524_0:sub(1, var_524_4 - 1) ..
					iter_524_0:sub(var_524_4, var_524_5 - 3) .. "}" .. iter_524_0:sub(var_524_5 + 1, #iter_524_0)
				end
			end

			local var_524_6 = var_0_0.CalcTextSize(iter_524_0)

			if var_524_2 == 2 then
				var_0_0.NewLine()
				var_0_0.SameLine(arg_522_1 / 2 - var_524_6.x / 2)
			elseif var_524_2 == 3 then
				var_0_0.NewLine()
				var_0_0.SameLine(arg_522_1 - var_524_6.x - 5)
			end

			if var_524_0[0] then
				for iter_524_1, iter_524_2 in pairs(var_524_0) do
					var_0_0.TextColored(var_524_1[iter_524_1] or var_522_0[var_522_1.Text], iter_524_2)
					var_0_0.SameLine(nil, 0)
				end

				var_0_0.NewLine()
			else
				var_0_0.Text(iter_524_0)
			end
		end
	end)(arg_522_0)
end

function var_0_0.CenterTextColoredRGB(arg_525_0)
	local var_525_0 = var_0_0.GetWindowWidth()
	local var_525_1 = var_0_0.GetStyle().Colors
	local var_525_2 = var_0_0.ImVec4

	local function var_525_3(arg_526_0)
		local var_526_0 = bit.band(bit.rshift(arg_526_0, 24), 255)
		local var_526_1 = bit.band(bit.rshift(arg_526_0, 16), 255)
		local var_526_2 = bit.band(bit.rshift(arg_526_0, 8), 255)
		local var_526_3 = bit.band(arg_526_0, 255)

		return var_526_0, var_526_1, var_526_2, var_526_3
	end

	local function var_525_4(arg_527_0)
		if arg_527_0:sub(1, 6):upper() == "SSSSSS" then
			local var_527_0 = var_525_1[1].x
			local var_527_1 = var_525_1[1].y
			local var_527_2 = var_525_1[1].z
			local var_527_3 = tonumber(arg_527_0:sub(7, 8), 16) or var_525_1[1].w * 255

			return var_525_2(var_527_0, var_527_1, var_527_2, var_527_3 / 255)
		end

		local var_527_4 = type(arg_527_0) == "string" and tonumber(arg_527_0, 16) or arg_527_0

		if type(var_527_4) ~= "number" then
			return
		end

		local var_527_5, var_527_6, var_527_7, var_527_8 = var_525_3(var_527_4)

		return var_0_0.ImColor(var_527_5, var_527_6, var_527_7, var_527_8):GetVec4()
	end

	; (function(arg_528_0)
		for iter_528_0 in arg_528_0:gmatch("[^\r\n]+") do
			local var_528_0 = iter_528_0:gsub("{.-}", "")
			local var_528_1 = var_0_0.CalcTextSize(u8(var_528_0))

			var_0_0.SetCursorPosX(var_525_0 / 2 - var_528_1.x / 2)

			local var_528_2 = {}
			local var_528_3 = {}
			local var_528_4 = 1

			iter_528_0 = iter_528_0:gsub("{(......)}", "{%1FF}")

			while iter_528_0:find("{........}") do
				local var_528_5, var_528_6 = iter_528_0:find("{........}")
				local var_528_7 = var_525_4(iter_528_0:sub(var_528_5 + 1, var_528_6 - 1))

				if var_528_7 then
					var_528_2[#var_528_2], var_528_2[#var_528_2 + 1] = iter_528_0:sub(var_528_4, var_528_5 - 1),
						iter_528_0:sub(var_528_6 + 1, #iter_528_0)
					var_528_3[#var_528_3 + 1] = var_528_7
					var_528_4 = var_528_5
				end

				iter_528_0 = iter_528_0:sub(1, var_528_5 - 1) .. iter_528_0:sub(var_528_6 + 1, #iter_528_0)
			end

			if var_528_2[0] then
				for iter_528_1 = 0, #var_528_2 do
					var_0_0.TextColored(var_528_3[iter_528_1] or var_525_1[1], var_528_2[iter_528_1])
					var_0_0.SameLine(nil, 0)
				end

				var_0_0.NewLine()
			else
				var_0_0.Text(iter_528_0)
			end
		end
	end)(arg_525_0)
end

function remu_pol()
	for iter_529_0 = 0, 1000 do
		local var_529_0 = blip_pol[#blip_pol]

		removeBlip(var_529_0)

		blip_pol[#blip_pol] = nil
	end
end

function remu_want()
	for iter_530_0 = 0, 1000 do
		local var_530_0 = blip_want[#blip_want]

		removeBlip(var_530_0)

		blip_want[#blip_want] = nil
	end
end

function direction(arg_531_0)
	if sampIsLocalPlayerSpawned() then
		local var_531_0 = math.ceil(getCharHeading(arg_531_0))

		if var_531_0 then
			if var_531_0 >= 0 and var_531_0 <= 30 or var_531_0 <= 360 and var_531_0 >= 330 then
				return "�����"
			elseif var_531_0 > 80 and var_531_0 < 100 then
				return "�����"
			elseif var_531_0 > 260 and var_531_0 < 280 then
				return "������"
			elseif var_531_0 >= 170 and var_531_0 <= 190 then
				return "��"
			elseif var_531_0 >= 31 and var_531_0 <= 79 then
				return "������-�����"
			elseif var_531_0 >= 191 and var_531_0 <= 259 then
				return "���-������"
			elseif var_531_0 >= 81 and var_531_0 <= 169 then
				return "���-�����"
			elseif var_531_0 >= 259 and var_531_0 <= 329 then
				return "������-������"
			else
				return var_531_0
			end
		else
			return "����������� �����������"
		end
	else
		return "����������� �����������"
	end
end

function getWanted()
	lua_thread.create(function()
		while true do
			wait(p(1000))

			if im.informer.infMainOopFunc.v then
				if (isPlayerCop(cop, getCharModel(playerPed)) or isPlayerCop(fbi, getCharModel(playerPed)) and sampGetGamestate() == 3) and isCharInAnyPoliceVehicle(playerPed) and ms ~= nil then
					wanted, wantedLevel = {}, {}
					wanted_list = true

					while sampIsChatInputActive() == true do
						wait(500)
					end

					while ms < 1000 + sampGetPlayerPing(myID) do
						wait(0)
					end

					sampSendChat("/wanted")
				end

				wait(180000)
			end
		end
	end)
end

function mydirection(arg_534_0)
	if sampIsLocalPlayerSpawned() then
		local var_534_0 = math.ceil(getCharHeading(arg_534_0))

		if var_534_0 then
			if var_534_0 >= 0 and var_534_0 <= 30 or var_534_0 <= 360 and var_534_0 >= 330 then
				return "�����"
			elseif var_534_0 > 80 and var_534_0 < 100 then
				return "�����"
			elseif var_534_0 > 260 and var_534_0 < 280 then
				return "������"
			elseif var_534_0 >= 170 and var_534_0 <= 190 then
				return "��"
			elseif var_534_0 >= 31 and var_534_0 <= 79 then
				return "������-�����"
			elseif var_534_0 >= 191 and var_534_0 <= 259 then
				return "���-������"
			elseif var_534_0 >= 81 and var_534_0 <= 169 then
				return "���-�����"
			elseif var_534_0 >= 259 and var_534_0 <= 329 then
				return "������-������"
			else
				return var_534_0
			end
		else
			return "����������"
		end
	else
		return "����������"
	end
end

function calcZ(arg_535_0, arg_535_1, arg_535_2)
	local var_535_0 = {
		{
			"Avispa Country Club",
			-2667.81,
			-302.135,
			-28.831,
			-2646.4,
			-262.32,
			71.169
		},
		{
			"Easter Bay Airport",
			-1315.42,
			-405.388,
			15.406,
			-1264.4,
			-209.543,
			25.406
		},
		{
			"Avispa Country Club",
			-2550.04,
			-355.493,
			0,
			-2470.04,
			-318.493,
			39.7
		},
		{
			"Easter Bay Airport",
			-1490.33,
			-209.543,
			15.406,
			-1264.4,
			-148.388,
			25.406
		},
		{
			"Garcia",
			-2395.14,
			-222.589,
			-5.3,
			-2354.09,
			-204.792,
			200
		},
		{
			"Shady Cabin",
			-1632.83,
			-2263.44,
			-3,
			-1601.33,
			-2231.79,
			200
		},
		{
			"East Los Santos",
			2381.68,
			-1494.03,
			-89.084,
			2421.03,
			-1454.35,
			110.916
		},
		{
			"LVA Freight Depot",
			1236.63,
			1163.41,
			-89.084,
			1277.05,
			1203.28,
			110.916
		},
		{
			"Blackfield Intersection",
			1277.05,
			1044.69,
			-89.084,
			1315.35,
			1087.63,
			110.916
		},
		{
			"Avispa Country Club",
			-2470.04,
			-355.493,
			0,
			-2270.04,
			-318.493,
			46.1
		},
		{
			"Temple",
			1252.33,
			-926.999,
			-89.084,
			1357,
			-910.17,
			110.916
		},
		{
			"Unity Station",
			1692.62,
			-1971.8,
			-20.492,
			1812.62,
			-1932.8,
			79.508
		},
		{
			"LVA Freight Depot",
			1315.35,
			1044.69,
			-89.084,
			1375.6,
			1087.63,
			110.916
		},
		{
			"Los Flores",
			2581.73,
			-1454.35,
			-89.084,
			2632.83,
			-1393.42,
			110.916
		},
		{
			"Starfish Casino",
			2437.39,
			1858.1,
			-39.084,
			2495.09,
			1970.85,
			60.916
		},
		{
			"Easter Bay Chemicals",
			-1132.82,
			-787.391,
			0,
			-956.476,
			-768.027,
			200
		},
		{
			"Downtown Los Santos",
			1370.85,
			-1170.87,
			-89.084,
			1463.9,
			-1130.85,
			110.916
		},
		{
			"Esplanade East",
			-1620.3,
			1176.52,
			-4.5,
			-1580.01,
			1274.26,
			200
		},
		{
			"Market Station",
			787.461,
			-1410.93,
			-34.126,
			866.009,
			-1310.21,
			65.874
		},
		{
			"Linden Station",
			2811.25,
			1229.59,
			-39.594,
			2861.25,
			1407.59,
			60.406
		},
		{
			"Montgomery Intersection",
			1582.44,
			347.457,
			0,
			1664.62,
			401.75,
			200
		},
		{
			"Frederick Bridge",
			2759.25,
			296.501,
			0,
			2774.25,
			594.757,
			200
		},
		{
			"Yellow Bell Station",
			1377.48,
			2600.43,
			-21.926,
			1492.45,
			2687.36,
			78.074
		},
		{
			"Downtown Los Santos",
			1507.51,
			-1385.21,
			110.916,
			1582.55,
			-1325.31,
			335.916
		},
		{
			"Jefferson",
			2185.33,
			-1210.74,
			-89.084,
			2281.45,
			-1154.59,
			110.916
		},
		{
			"Mulholland",
			1318.13,
			-910.17,
			-89.084,
			1357,
			-768.027,
			110.916
		},
		{
			"Avispa Country Club",
			-2361.51,
			-417.199,
			0,
			-2270.04,
			-355.493,
			200
		},
		{
			"Jefferson",
			1996.91,
			-1449.67,
			-89.084,
			2056.86,
			-1350.72,
			110.916
		},
		{
			"Julius Thruway West",
			1236.63,
			2142.86,
			-89.084,
			1297.47,
			2243.23,
			110.916
		},
		{
			"Jefferson",
			2124.66,
			-1494.03,
			-89.084,
			2266.21,
			-1449.67,
			110.916
		},
		{
			"Julius Thruway North",
			1848.4,
			2478.49,
			-89.084,
			1938.8,
			2553.49,
			110.916
		},
		{
			"Rodeo",
			422.68,
			-1570.2,
			-89.084,
			466.223,
			-1406.05,
			110.916
		},
		{
			"Cranberry Station",
			-2007.83,
			56.306,
			0,
			-1922,
			224.782,
			100
		},
		{
			"Downtown Los Santos",
			1391.05,
			-1026.33,
			-89.084,
			1463.9,
			-926.999,
			110.916
		},
		{
			"Redsands West",
			1704.59,
			2243.23,
			-89.084,
			1777.39,
			2342.83,
			110.916
		},
		{
			"Little Mexico",
			1758.9,
			-1722.26,
			-89.084,
			1812.62,
			-1577.59,
			110.916
		},
		{
			"Blackfield Intersection",
			1375.6,
			823.228,
			-89.084,
			1457.39,
			919.447,
			110.916
		},
		{
			"Los Santos International",
			1974.63,
			-2394.33,
			-39.084,
			2089,
			-2256.59,
			60.916
		},
		{
			"Beacon Hill",
			-399.633,
			-1075.52,
			-1.489,
			-319.033,
			-977.516,
			198.511
		},
		{
			"Rodeo",
			334.503,
			-1501.95,
			-89.084,
			422.68,
			-1406.05,
			110.916
		},
		{
			"Richman",
			225.165,
			-1369.62,
			-89.084,
			334.503,
			-1292.07,
			110.916
		},
		{
			"Downtown Los Santos",
			1724.76,
			-1250.9,
			-89.084,
			1812.62,
			-1150.87,
			110.916
		},
		{
			"The Strip",
			2027.4,
			1703.23,
			-89.084,
			2137.4,
			1783.23,
			110.916
		},
		{
			"Downtown Los Santos",
			1378.33,
			-1130.85,
			-89.084,
			1463.9,
			-1026.33,
			110.916
		},
		{
			"Blackfield Intersection",
			1197.39,
			1044.69,
			-89.084,
			1277.05,
			1163.39,
			110.916
		},
		{
			"Conference Center",
			1073.22,
			-1842.27,
			-89.084,
			1323.9,
			-1804.21,
			110.916
		},
		{
			"Montgomery",
			1451.4,
			347.457,
			-6.1,
			1582.44,
			420.802,
			200
		},
		{
			"Foster Valley",
			-2270.04,
			-430.276,
			-1.2,
			-2178.69,
			-324.114,
			200
		},
		{
			"Blackfield Chapel",
			1325.6,
			596.349,
			-89.084,
			1375.6,
			795.01,
			110.916
		},
		{
			"Los Santos International",
			2051.63,
			-2597.26,
			-39.084,
			2152.45,
			-2394.33,
			60.916
		},
		{
			"Mulholland",
			1096.47,
			-910.17,
			-89.084,
			1169.13,
			-768.027,
			110.916
		},
		{
			"Yellow Bell Gol Course",
			1457.46,
			2723.23,
			-89.084,
			1534.56,
			2863.23,
			110.916
		},
		{
			"The Strip",
			2027.4,
			1783.23,
			-89.084,
			2162.39,
			1863.23,
			110.916
		},
		{
			"Jefferson",
			2056.86,
			-1210.74,
			-89.084,
			2185.33,
			-1126.32,
			110.916
		},
		{
			"Mulholland",
			952.604,
			-937.184,
			-89.084,
			1096.47,
			-860.619,
			110.916
		},
		{
			"Aldea Malvada",
			-1372.14,
			2498.52,
			0,
			-1277.59,
			2615.35,
			200
		},
		{
			"Las Colinas",
			2126.86,
			-1126.32,
			-89.084,
			2185.33,
			-934.489,
			110.916
		},
		{
			"Las Colinas",
			1994.33,
			-1100.82,
			-89.084,
			2056.86,
			-920.815,
			110.916
		},
		{
			"Richman",
			647.557,
			-954.662,
			-89.084,
			768.694,
			-860.619,
			110.916
		},
		{
			"LVA Freight Depot",
			1277.05,
			1087.63,
			-89.084,
			1375.6,
			1203.28,
			110.916
		},
		{
			"Julius Thruway North",
			1377.39,
			2433.23,
			-89.084,
			1534.56,
			2507.23,
			110.916
		},
		{
			"Willowfield",
			2201.82,
			-2095,
			-89.084,
			2324,
			-1989.9,
			110.916
		},
		{
			"Julius Thruway North",
			1704.59,
			2342.83,
			-89.084,
			1848.4,
			2433.23,
			110.916
		},
		{
			"Temple",
			1252.33,
			-1130.85,
			-89.084,
			1378.33,
			-1026.33,
			110.916
		},
		{
			"Little Mexico",
			1701.9,
			-1842.27,
			-89.084,
			1812.62,
			-1722.26,
			110.916
		},
		{
			"Queens",
			-2411.22,
			373.539,
			0,
			-2253.54,
			458.411,
			200
		},
		{
			"Las Venturas Airport",
			1515.81,
			1586.4,
			-12.5,
			1729.95,
			1714.56,
			87.5
		},
		{
			"Richman",
			225.165,
			-1292.07,
			-89.084,
			466.223,
			-1235.07,
			110.916
		},
		{
			"Temple",
			1252.33,
			-1026.33,
			-89.084,
			1391.05,
			-926.999,
			110.916
		},
		{
			"East Los Santos",
			2266.26,
			-1494.03,
			-89.084,
			2381.68,
			-1372.04,
			110.916
		},
		{
			"Julius Thruway East",
			2623.18,
			943.235,
			-89.084,
			2749.9,
			1055.96,
			110.916
		},
		{
			"Willowfield",
			2541.7,
			-1941.4,
			-89.084,
			2703.58,
			-1852.87,
			110.916
		},
		{
			"Las Colinas",
			2056.86,
			-1126.32,
			-89.084,
			2126.86,
			-920.815,
			110.916
		},
		{
			"Julius Thruway East",
			2625.16,
			2202.76,
			-89.084,
			2685.16,
			2442.55,
			110.916
		},
		{
			"Rodeo",
			225.165,
			-1501.95,
			-89.084,
			334.503,
			-1369.62,
			110.916
		},
		{
			"Las Brujas",
			-365.167,
			2123.01,
			-3,
			-208.57,
			2217.68,
			200
		},
		{
			"Julius Thruway East",
			2536.43,
			2442.55,
			-89.084,
			2685.16,
			2542.55,
			110.916
		},
		{
			"Rodeo",
			334.503,
			-1406.05,
			-89.084,
			466.223,
			-1292.07,
			110.916
		},
		{
			"Vinewood",
			647.557,
			-1227.28,
			-89.084,
			787.461,
			-1118.28,
			110.916
		},
		{
			"Rodeo",
			422.68,
			-1684.65,
			-89.084,
			558.099,
			-1570.2,
			110.916
		},
		{
			"Julius Thruway North",
			2498.21,
			2542.55,
			-89.084,
			2685.16,
			2626.55,
			110.916
		},
		{
			"Downtown Los Santos",
			1724.76,
			-1430.87,
			-89.084,
			1812.62,
			-1250.9,
			110.916
		},
		{
			"Rodeo",
			225.165,
			-1684.65,
			-89.084,
			312.803,
			-1501.95,
			110.916
		},
		{
			"Jefferson",
			2056.86,
			-1449.67,
			-89.084,
			2266.21,
			-1372.04,
			110.916
		},
		{
			"Hampton Barns",
			603.035,
			264.312,
			0,
			761.994,
			366.572,
			200
		},
		{
			"Temple",
			1096.47,
			-1130.84,
			-89.084,
			1252.33,
			-1026.33,
			110.916
		},
		{
			"Kincaid Bridge",
			-1087.93,
			855.37,
			-89.084,
			-961.95,
			986.281,
			110.916
		},
		{
			"Verona Beach",
			1046.15,
			-1722.26,
			-89.084,
			1161.52,
			-1577.59,
			110.916
		},
		{
			"Commerce",
			1323.9,
			-1722.26,
			-89.084,
			1440.9,
			-1577.59,
			110.916
		},
		{
			"Mulholland",
			1357,
			-926.999,
			-89.084,
			1463.9,
			-768.027,
			110.916
		},
		{
			"Rodeo",
			466.223,
			-1570.2,
			-89.084,
			558.099,
			-1385.07,
			110.916
		},
		{
			"Mulholland",
			911.802,
			-860.619,
			-89.084,
			1096.47,
			-768.027,
			110.916
		},
		{
			"Mulholland",
			768.694,
			-954.662,
			-89.084,
			952.604,
			-860.619,
			110.916
		},
		{
			"Julius Thruway South",
			2377.39,
			788.894,
			-89.084,
			2537.39,
			897.901,
			110.916
		},
		{
			"Idlewood",
			1812.62,
			-1852.87,
			-89.084,
			1971.66,
			-1742.31,
			110.916
		},
		{
			"Ocean Docks",
			2089,
			-2394.33,
			-89.084,
			2201.82,
			-2235.84,
			110.916
		},
		{
			"Commerce",
			1370.85,
			-1577.59,
			-89.084,
			1463.9,
			-1384.95,
			110.916
		},
		{
			"Julius Thruway North",
			2121.4,
			2508.23,
			-89.084,
			2237.4,
			2663.17,
			110.916
		},
		{
			"Temple",
			1096.47,
			-1026.33,
			-89.084,
			1252.33,
			-910.17,
			110.916
		},
		{
			"Glen Park",
			1812.62,
			-1449.67,
			-89.084,
			1996.91,
			-1350.72,
			110.916
		},
		{
			"Easter Bay Airport",
			-1242.98,
			-50.096,
			0,
			-1213.91,
			578.396,
			200
		},
		{
			"Martin Bridge",
			-222.179,
			293.324,
			0,
			-122.126,
			476.465,
			200
		},
		{
			"The Strip",
			2106.7,
			1863.23,
			-89.084,
			2162.39,
			2202.76,
			110.916
		},
		{
			"Willowfield",
			2541.7,
			-2059.23,
			-89.084,
			2703.58,
			-1941.4,
			110.916
		},
		{
			"Marina",
			807.922,
			-1577.59,
			-89.084,
			926.922,
			-1416.25,
			110.916
		},
		{
			"Las Venturas Airport",
			1457.37,
			1143.21,
			-89.084,
			1777.4,
			1203.28,
			110.916
		},
		{
			"Idlewood",
			1812.62,
			-1742.31,
			-89.084,
			1951.66,
			-1602.31,
			110.916
		},
		{
			"Esplanade East",
			-1580.01,
			1025.98,
			-6.1,
			-1499.89,
			1274.26,
			200
		},
		{
			"Downtown Los Santos",
			1370.85,
			-1384.95,
			-89.084,
			1463.9,
			-1170.87,
			110.916
		},
		{
			"The Mako Span",
			1664.62,
			401.75,
			0,
			1785.14,
			567.203,
			200
		},
		{
			"Rodeo",
			312.803,
			-1684.65,
			-89.084,
			422.68,
			-1501.95,
			110.916
		},
		{
			"Pershing Square",
			1440.9,
			-1722.26,
			-89.084,
			1583.5,
			-1577.59,
			110.916
		},
		{
			"Mulholland",
			687.802,
			-860.619,
			-89.084,
			911.802,
			-768.027,
			110.916
		},
		{
			"Gant Bridge",
			-2741.07,
			1490.47,
			-6.1,
			-2616.4,
			1659.68,
			200
		},
		{
			"Las Colinas",
			2185.33,
			-1154.59,
			-89.084,
			2281.45,
			-934.489,
			110.916
		},
		{
			"Mulholland",
			1169.13,
			-910.17,
			-89.084,
			1318.13,
			-768.027,
			110.916
		},
		{
			"Julius Thruway North",
			1938.8,
			2508.23,
			-89.084,
			2121.4,
			2624.23,
			110.916
		},
		{
			"Commerce",
			1667.96,
			-1577.59,
			-89.084,
			1812.62,
			-1430.87,
			110.916
		},
		{
			"Rodeo",
			72.648,
			-1544.17,
			-89.084,
			225.165,
			-1404.97,
			110.916
		},
		{
			"Roca Escalante",
			2536.43,
			2202.76,
			-89.084,
			2625.16,
			2442.55,
			110.916
		},
		{
			"Rodeo",
			72.648,
			-1684.65,
			-89.084,
			225.165,
			-1544.17,
			110.916
		},
		{
			"Market",
			952.663,
			-1310.21,
			-89.084,
			1072.66,
			-1130.85,
			110.916
		},
		{
			"Las Colinas",
			2632.74,
			-1135.04,
			-89.084,
			2747.74,
			-945.035,
			110.916
		},
		{
			"Mulholland",
			861.085,
			-674.885,
			-89.084,
			1156.55,
			-600.896,
			110.916
		},
		{
			"King's",
			-2253.54,
			373.539,
			-9.1,
			-1993.28,
			458.411,
			200
		},
		{
			"Redsands East",
			1848.4,
			2342.83,
			-89.084,
			2011.94,
			2478.49,
			110.916
		},
		{
			"Downtown",
			-1580.01,
			744.267,
			-6.1,
			-1499.89,
			1025.98,
			200
		},
		{
			"Conference Center",
			1046.15,
			-1804.21,
			-89.084,
			1323.9,
			-1722.26,
			110.916
		},
		{
			"Richman",
			647.557,
			-1118.28,
			-89.084,
			787.461,
			-954.662,
			110.916
		},
		{
			"Ocean Flats",
			-2994.49,
			277.411,
			-9.1,
			-2867.85,
			458.411,
			200
		},
		{
			"Greenglass College",
			964.391,
			930.89,
			-89.084,
			1166.53,
			1044.69,
			110.916
		},
		{
			"Glen Park",
			1812.62,
			-1100.82,
			-89.084,
			1994.33,
			-973.38,
			110.916
		},
		{
			"LVA Freight Depot",
			1375.6,
			919.447,
			-89.084,
			1457.37,
			1203.28,
			110.916
		},
		{
			"Regular Tom",
			-405.77,
			1712.86,
			-3,
			-276.719,
			1892.75,
			200
		},
		{
			"Verona Beach",
			1161.52,
			-1722.26,
			-89.084,
			1323.9,
			-1577.59,
			110.916
		},
		{
			"East Los Santos",
			2281.45,
			-1372.04,
			-89.084,
			2381.68,
			-1135.04,
			110.916
		},
		{
			"Caligula's Palace",
			2137.4,
			1703.23,
			-89.084,
			2437.39,
			1783.23,
			110.916
		},
		{
			"Idlewood",
			1951.66,
			-1742.31,
			-89.084,
			2124.66,
			-1602.31,
			110.916
		},
		{
			"Pilgrim",
			2624.4,
			1383.23,
			-89.084,
			2685.16,
			1783.23,
			110.916
		},
		{
			"Idlewood",
			2124.66,
			-1742.31,
			-89.084,
			2222.56,
			-1494.03,
			110.916
		},
		{
			"Queens",
			-2533.04,
			458.411,
			0,
			-2329.31,
			578.396,
			200
		},
		{
			"Downtown",
			-1871.72,
			1176.42,
			-4.5,
			-1620.3,
			1274.26,
			200
		},
		{
			"Commerce",
			1583.5,
			-1722.26,
			-89.084,
			1758.9,
			-1577.59,
			110.916
		},
		{
			"East Los Santos",
			2381.68,
			-1454.35,
			-89.084,
			2462.13,
			-1135.04,
			110.916
		},
		{
			"Marina",
			647.712,
			-1577.59,
			-89.084,
			807.922,
			-1416.25,
			110.916
		},
		{
			"Richman",
			72.648,
			-1404.97,
			-89.084,
			225.165,
			-1235.07,
			110.916
		},
		{
			"Vinewood",
			647.712,
			-1416.25,
			-89.084,
			787.461,
			-1227.28,
			110.916
		},
		{
			"East Los Santos",
			2222.56,
			-1628.53,
			-89.084,
			2421.03,
			-1494.03,
			110.916
		},
		{
			"Rodeo",
			558.099,
			-1684.65,
			-89.084,
			647.522,
			-1384.93,
			110.916
		},
		{
			"Easter Tunnel",
			-1709.71,
			-833.034,
			-1.5,
			-1446.01,
			-730.118,
			200
		},
		{
			"Rodeo",
			466.223,
			-1385.07,
			-89.084,
			647.522,
			-1235.07,
			110.916
		},
		{
			"Redsands East",
			1817.39,
			2202.76,
			-89.084,
			2011.94,
			2342.83,
			110.916
		},
		{
			"The Clown's Pocket",
			2162.39,
			1783.23,
			-89.084,
			2437.39,
			1883.23,
			110.916
		},
		{
			"Idlewood",
			1971.66,
			-1852.87,
			-89.084,
			2222.56,
			-1742.31,
			110.916
		},
		{
			"Montgomery Intersection",
			1546.65,
			208.164,
			0,
			1745.83,
			347.457,
			200
		},
		{
			"Willowfield",
			2089,
			-2235.84,
			-89.084,
			2201.82,
			-1989.9,
			110.916
		},
		{
			"Temple",
			952.663,
			-1130.84,
			-89.084,
			1096.47,
			-937.184,
			110.916
		},
		{
			"Prickle Pine",
			1848.4,
			2553.49,
			-89.084,
			1938.8,
			2863.23,
			110.916
		},
		{
			"Los Santos International",
			1400.97,
			-2669.26,
			-39.084,
			2189.82,
			-2597.26,
			60.916
		},
		{
			"Garver Bridge",
			-1213.91,
			950.022,
			-89.084,
			-1087.93,
			1178.93,
			110.916
		},
		{
			"Garver Bridge",
			-1339.89,
			828.129,
			-89.084,
			-1213.91,
			1057.04,
			110.916
		},
		{
			"Kincaid Bridge",
			-1339.89,
			599.218,
			-89.084,
			-1213.91,
			828.129,
			110.916
		},
		{
			"Kincaid Bridge",
			-1213.91,
			721.111,
			-89.084,
			-1087.93,
			950.022,
			110.916
		},
		{
			"Verona Beach",
			930.221,
			-2006.78,
			-89.084,
			1073.22,
			-1804.21,
			110.916
		},
		{
			"Verdant Bluffs",
			1073.22,
			-2006.78,
			-89.084,
			1249.62,
			-1842.27,
			110.916
		},
		{
			"Vinewood",
			787.461,
			-1130.84,
			-89.084,
			952.604,
			-954.662,
			110.916
		},
		{
			"Vinewood",
			787.461,
			-1310.21,
			-89.084,
			952.663,
			-1130.84,
			110.916
		},
		{
			"Commerce",
			1463.9,
			-1577.59,
			-89.084,
			1667.96,
			-1430.87,
			110.916
		},
		{
			"Market",
			787.461,
			-1416.25,
			-89.084,
			1072.66,
			-1310.21,
			110.916
		},
		{
			"Rockshore West",
			2377.39,
			596.349,
			-89.084,
			2537.39,
			788.894,
			110.916
		},
		{
			"Julius Thruway North",
			2237.4,
			2542.55,
			-89.084,
			2498.21,
			2663.17,
			110.916
		},
		{
			"East Beach",
			2632.83,
			-1668.13,
			-89.084,
			2747.74,
			-1393.42,
			110.916
		},
		{
			"Fallow Bridge",
			434.341,
			366.572,
			0,
			603.035,
			555.68,
			200
		},
		{
			"Willowfield",
			2089,
			-1989.9,
			-89.084,
			2324,
			-1852.87,
			110.916
		},
		{
			"Chinatown",
			-2274.17,
			578.396,
			-7.6,
			-2078.67,
			744.17,
			200
		},
		{
			"El Castillo del Diablo",
			-208.57,
			2337.18,
			0,
			8.43,
			2487.18,
			200
		},
		{
			"Ocean Docks",
			2324,
			-2145.1,
			-89.084,
			2703.58,
			-2059.23,
			110.916
		},
		{
			"Easter Bay Chemicals",
			-1132.82,
			-768.027,
			0,
			-956.476,
			-578.118,
			200
		},
		{
			"The Visage",
			1817.39,
			1703.23,
			-89.084,
			2027.4,
			1863.23,
			110.916
		},
		{
			"Ocean Flats",
			-2994.49,
			-430.276,
			-1.2,
			-2831.89,
			-222.589,
			200
		},
		{
			"Richman",
			321.356,
			-860.619,
			-89.084,
			687.802,
			-768.027,
			110.916
		},
		{
			"Green Palms",
			176.581,
			1305.45,
			-3,
			338.658,
			1520.72,
			200
		},
		{
			"Richman",
			321.356,
			-768.027,
			-89.084,
			700.794,
			-674.885,
			110.916
		},
		{
			"Starfish Casino",
			2162.39,
			1883.23,
			-89.084,
			2437.39,
			2012.18,
			110.916
		},
		{
			"East Beach",
			2747.74,
			-1668.13,
			-89.084,
			2959.35,
			-1498.62,
			110.916
		},
		{
			"Jefferson",
			2056.86,
			-1372.04,
			-89.084,
			2281.45,
			-1210.74,
			110.916
		},
		{
			"Downtown Los Santos",
			1463.9,
			-1290.87,
			-89.084,
			1724.76,
			-1150.87,
			110.916
		},
		{
			"Downtown Los Santos",
			1463.9,
			-1430.87,
			-89.084,
			1724.76,
			-1290.87,
			110.916
		},
		{
			"Garver Bridge",
			-1499.89,
			696.442,
			-179.615,
			-1339.89,
			925.353,
			20.385
		},
		{
			"Julius Thruway South",
			1457.39,
			823.228,
			-89.084,
			2377.39,
			863.229,
			110.916
		},
		{
			"East Los Santos",
			2421.03,
			-1628.53,
			-89.084,
			2632.83,
			-1454.35,
			110.916
		},
		{
			"Greenglass College",
			964.391,
			1044.69,
			-89.084,
			1197.39,
			1203.22,
			110.916
		},
		{
			"Las Colinas",
			2747.74,
			-1120.04,
			-89.084,
			2959.35,
			-945.035,
			110.916
		},
		{
			"Mulholland",
			737.573,
			-768.027,
			-89.084,
			1142.29,
			-674.885,
			110.916
		},
		{
			"Ocean Docks",
			2201.82,
			-2730.88,
			-89.084,
			2324,
			-2418.33,
			110.916
		},
		{
			"East Los Santos",
			2462.13,
			-1454.35,
			-89.084,
			2581.73,
			-1135.04,
			110.916
		},
		{
			"Ganton",
			2222.56,
			-1722.33,
			-89.084,
			2632.83,
			-1628.53,
			110.916
		},
		{
			"Avispa Country Club",
			-2831.89,
			-430.276,
			-6.1,
			-2646.4,
			-222.589,
			200
		},
		{
			"Willowfield",
			1970.62,
			-2179.25,
			-89.084,
			2089,
			-1852.87,
			110.916
		},
		{
			"Esplanade North",
			-1982.32,
			1274.26,
			-4.5,
			-1524.24,
			1358.9,
			200
		},
		{
			"The High Roller",
			1817.39,
			1283.23,
			-89.084,
			2027.39,
			1469.23,
			110.916
		},
		{
			"Ocean Docks",
			2201.82,
			-2418.33,
			-89.084,
			2324,
			-2095,
			110.916
		},
		{
			"Last Dime Motel",
			1823.08,
			596.349,
			-89.084,
			1997.22,
			823.228,
			110.916
		},
		{
			"Bayside Marina",
			-2353.17,
			2275.79,
			0,
			-2153.17,
			2475.79,
			200
		},
		{
			"King's",
			-2329.31,
			458.411,
			-7.6,
			-1993.28,
			578.396,
			200
		},
		{
			"El Corona",
			1692.62,
			-2179.25,
			-89.084,
			1812.62,
			-1842.27,
			110.916
		},
		{
			"Blackfield Chapel",
			1375.6,
			596.349,
			-89.084,
			1558.09,
			823.228,
			110.916
		},
		{
			"The Pink Swan",
			1817.39,
			1083.23,
			-89.084,
			2027.39,
			1283.23,
			110.916
		},
		{
			"Julius Thruway West",
			1197.39,
			1163.39,
			-89.084,
			1236.63,
			2243.23,
			110.916
		},
		{
			"Los Flores",
			2581.73,
			-1393.42,
			-89.084,
			2747.74,
			-1135.04,
			110.916
		},
		{
			"The Visage",
			1817.39,
			1863.23,
			-89.084,
			2106.7,
			2011.83,
			110.916
		},
		{
			"Prickle Pine",
			1938.8,
			2624.23,
			-89.084,
			2121.4,
			2861.55,
			110.916
		},
		{
			"Verona Beach",
			851.449,
			-1804.21,
			-89.084,
			1046.15,
			-1577.59,
			110.916
		},
		{
			"Robada Intersection",
			-1119.01,
			1178.93,
			-89.084,
			-862.025,
			1351.45,
			110.916
		},
		{
			"Linden Side",
			2749.9,
			943.235,
			-89.084,
			2923.39,
			1198.99,
			110.916
		},
		{
			"Ocean Docks",
			2703.58,
			-2302.33,
			-89.084,
			2959.35,
			-2126.9,
			110.916
		},
		{
			"Willowfield",
			2324,
			-2059.23,
			-89.084,
			2541.7,
			-1852.87,
			110.916
		},
		{
			"King's",
			-2411.22,
			265.243,
			-9.1,
			-1993.28,
			373.539,
			200
		},
		{
			"Commerce",
			1323.9,
			-1842.27,
			-89.084,
			1701.9,
			-1722.26,
			110.916
		},
		{
			"Mulholland",
			1269.13,
			-768.027,
			-89.084,
			1414.07,
			-452.425,
			110.916
		},
		{
			"Marina",
			647.712,
			-1804.21,
			-89.084,
			851.449,
			-1577.59,
			110.916
		},
		{
			"Battery Point",
			-2741.07,
			1268.41,
			-4.5,
			-2533.04,
			1490.47,
			200
		},
		{
			"The Four Dragons Casino",
			1817.39,
			863.232,
			-89.084,
			2027.39,
			1083.23,
			110.916
		},
		{
			"Blackfield",
			964.391,
			1203.22,
			-89.084,
			1197.39,
			1403.22,
			110.916
		},
		{
			"Julius Thruway North",
			1534.56,
			2433.23,
			-89.084,
			1848.4,
			2583.23,
			110.916
		},
		{
			"Yellow Bell Gol Course",
			1117.4,
			2723.23,
			-89.084,
			1457.46,
			2863.23,
			110.916
		},
		{
			"Idlewood",
			1812.62,
			-1602.31,
			-89.084,
			2124.66,
			-1449.67,
			110.916
		},
		{
			"Redsands West",
			1297.47,
			2142.86,
			-89.084,
			1777.39,
			2243.23,
			110.916
		},
		{
			"Doherty",
			-2270.04,
			-324.114,
			-1.2,
			-1794.92,
			-222.589,
			200
		},
		{
			"Hilltop Farm",
			967.383,
			-450.39,
			-3,
			1176.78,
			-217.9,
			200
		},
		{
			"Las Barrancas",
			-926.13,
			1398.73,
			-3,
			-719.234,
			1634.69,
			200
		},
		{
			"Pirates in Men's Pants",
			1817.39,
			1469.23,
			-89.084,
			2027.4,
			1703.23,
			110.916
		},
		{
			"City Hall",
			-2867.85,
			277.411,
			-9.1,
			-2593.44,
			458.411,
			200
		},
		{
			"Avispa Country Club",
			-2646.4,
			-355.493,
			0,
			-2270.04,
			-222.589,
			200
		},
		{
			"The Strip",
			2027.4,
			863.229,
			-89.084,
			2087.39,
			1703.23,
			110.916
		},
		{
			"Hashbury",
			-2593.44,
			-222.589,
			-1,
			-2411.22,
			54.722,
			200
		},
		{
			"Los Santos International",
			1852,
			-2394.33,
			-89.084,
			2089,
			-2179.25,
			110.916
		},
		{
			"Whitewood Estates",
			1098.31,
			1726.22,
			-89.084,
			1197.39,
			2243.23,
			110.916
		},
		{
			"Sherman Reservoir",
			-789.737,
			1659.68,
			-89.084,
			-599.505,
			1929.41,
			110.916
		},
		{
			"El Corona",
			1812.62,
			-2179.25,
			-89.084,
			1970.62,
			-1852.87,
			110.916
		},
		{
			"Downtown",
			-1700.01,
			744.267,
			-6.1,
			-1580.01,
			1176.52,
			200
		},
		{
			"Foster Valley",
			-2178.69,
			-1250.97,
			0,
			-1794.92,
			-1115.58,
			200
		},
		{
			"Las Payasadas",
			-354.332,
			2580.36,
			2,
			-133.625,
			2816.82,
			200
		},
		{
			"Valle Ocultado",
			-936.668,
			2611.44,
			2,
			-715.961,
			2847.9,
			200
		},
		{
			"Blackfield Intersection",
			1166.53,
			795.01,
			-89.084,
			1375.6,
			1044.69,
			110.916
		},
		{
			"Ganton",
			2222.56,
			-1852.87,
			-89.084,
			2632.83,
			-1722.33,
			110.916
		},
		{
			"Easter Bay Airport",
			-1213.91,
			-730.118,
			0,
			-1132.82,
			-50.096,
			200
		},
		{
			"Redsands East",
			1817.39,
			2011.83,
			-89.084,
			2106.7,
			2202.76,
			110.916
		},
		{
			"Esplanade East",
			-1499.89,
			578.396,
			-79.615,
			-1339.89,
			1274.26,
			20.385
		},
		{
			"Caligula's Palace",
			2087.39,
			1543.23,
			-89.084,
			2437.39,
			1703.23,
			110.916
		},
		{
			"Royal Casino",
			2087.39,
			1383.23,
			-89.084,
			2437.39,
			1543.23,
			110.916
		},
		{
			"Richman",
			72.648,
			-1235.07,
			-89.084,
			321.356,
			-1008.15,
			110.916
		},
		{
			"Starfish Casino",
			2437.39,
			1783.23,
			-89.084,
			2685.16,
			2012.18,
			110.916
		},
		{
			"Mulholland",
			1281.13,
			-452.425,
			-89.084,
			1641.13,
			-290.913,
			110.916
		},
		{
			"Downtown",
			-1982.32,
			744.17,
			-6.1,
			-1871.72,
			1274.26,
			200
		},
		{
			"Hankypanky Point",
			2576.92,
			62.158,
			0,
			2759.25,
			385.503,
			200
		},
		{
			"K.A.C.C. Military Fuels",
			2498.21,
			2626.55,
			-89.084,
			2749.9,
			2861.55,
			110.916
		},
		{
			"Harry Gold Parkway",
			1777.39,
			863.232,
			-89.084,
			1817.39,
			2342.83,
			110.916
		},
		{
			"Bayside Tunnel",
			-2290.19,
			2548.29,
			-89.084,
			-1950.19,
			2723.29,
			110.916
		},
		{
			"Ocean Docks",
			2324,
			-2302.33,
			-89.084,
			2703.58,
			-2145.1,
			110.916
		},
		{
			"Richman",
			321.356,
			-1044.07,
			-89.084,
			647.557,
			-860.619,
			110.916
		},
		{
			"Randolph Industrial Estate",
			1558.09,
			596.349,
			-89.084,
			1823.08,
			823.235,
			110.916
		},
		{
			"East Beach",
			2632.83,
			-1852.87,
			-89.084,
			2959.35,
			-1668.13,
			110.916
		},
		{
			"Flint Water",
			-314.426,
			-753.874,
			-89.084,
			-106.339,
			-463.073,
			110.916
		},
		{
			"Blueberry",
			19.607,
			-404.136,
			3.8,
			349.607,
			-220.137,
			200
		},
		{
			"Linden Station",
			2749.9,
			1198.99,
			-89.084,
			2923.39,
			1548.99,
			110.916
		},
		{
			"Glen Park",
			1812.62,
			-1350.72,
			-89.084,
			2056.86,
			-1100.82,
			110.916
		},
		{
			"Downtown",
			-1993.28,
			265.243,
			-9.1,
			-1794.92,
			578.396,
			200
		},
		{
			"Redsands West",
			1377.39,
			2243.23,
			-89.084,
			1704.59,
			2433.23,
			110.916
		},
		{
			"Richman",
			321.356,
			-1235.07,
			-89.084,
			647.522,
			-1044.07,
			110.916
		},
		{
			"Gant Bridge",
			-2741.45,
			1659.68,
			-6.1,
			-2616.4,
			2175.15,
			200
		},
		{
			"Lil' Probe Inn",
			-90.218,
			1286.85,
			-3,
			153.859,
			1554.12,
			200
		},
		{
			"Flint Intersection",
			-187.7,
			-1596.76,
			-89.084,
			17.063,
			-1276.6,
			110.916
		},
		{
			"Las Colinas",
			2281.45,
			-1135.04,
			-89.084,
			2632.74,
			-945.035,
			110.916
		},
		{
			"Sobell Rail Yards",
			2749.9,
			1548.99,
			-89.084,
			2923.39,
			1937.25,
			110.916
		},
		{
			"The Emerald Isle",
			2011.94,
			2202.76,
			-89.084,
			2237.4,
			2508.23,
			110.916
		},
		{
			"El Castillo del Diablo",
			-208.57,
			2123.01,
			-7.6,
			114.033,
			2337.18,
			200
		},
		{
			"Santa Flora",
			-2741.07,
			458.411,
			-7.6,
			-2533.04,
			793.411,
			200
		},
		{
			"Playa del Seville",
			2703.58,
			-2126.9,
			-89.084,
			2959.35,
			-1852.87,
			110.916
		},
		{
			"Market",
			926.922,
			-1577.59,
			-89.084,
			1370.85,
			-1416.25,
			110.916
		},
		{
			"Queens",
			-2593.44,
			54.722,
			0,
			-2411.22,
			458.411,
			200
		},
		{
			"Pilson Intersection",
			1098.39,
			2243.23,
			-89.084,
			1377.39,
			2507.23,
			110.916
		},
		{
			"Spinybed",
			2121.4,
			2663.17,
			-89.084,
			2498.21,
			2861.55,
			110.916
		},
		{
			"Pilgrim",
			2437.39,
			1383.23,
			-89.084,
			2624.4,
			1783.23,
			110.916
		},
		{
			"Blackfield",
			964.391,
			1403.22,
			-89.084,
			1197.39,
			1726.22,
			110.916
		},
		{
			"'The Big Ear'",
			-410.02,
			1403.34,
			-3,
			-137.969,
			1681.23,
			200
		},
		{
			"Dillimore",
			580.794,
			-674.885,
			-9.5,
			861.085,
			-404.79,
			200
		},
		{
			"El Quebrados",
			-1645.23,
			2498.52,
			0,
			-1372.14,
			2777.85,
			200
		},
		{
			"Esplanade North",
			-2533.04,
			1358.9,
			-4.5,
			-1996.66,
			1501.21,
			200
		},
		{
			"Easter Bay Airport",
			-1499.89,
			-50.096,
			-1,
			-1242.98,
			249.904,
			200
		},
		{
			"Fisher's Lagoon",
			1916.99,
			-233.323,
			-100,
			2131.72,
			13.8,
			200
		},
		{
			"Mulholland",
			1414.07,
			-768.027,
			-89.084,
			1667.61,
			-452.425,
			110.916
		},
		{
			"East Beach",
			2747.74,
			-1498.62,
			-89.084,
			2959.35,
			-1120.04,
			110.916
		},
		{
			"San Andreas Sound",
			2450.39,
			385.503,
			-100,
			2759.25,
			562.349,
			200
		},
		{
			"Shady Creeks",
			-2030.12,
			-2174.89,
			-6.1,
			-1820.64,
			-1771.66,
			200
		},
		{
			"Market",
			1072.66,
			-1416.25,
			-89.084,
			1370.85,
			-1130.85,
			110.916
		},
		{
			"Rockshore West",
			1997.22,
			596.349,
			-89.084,
			2377.39,
			823.228,
			110.916
		},
		{
			"Prickle Pine",
			1534.56,
			2583.23,
			-89.084,
			1848.4,
			2863.23,
			110.916
		},
		{
			"Easter Basin",
			-1794.92,
			-50.096,
			-1.04,
			-1499.89,
			249.904,
			200
		},
		{
			"Leafy Hollow",
			-1166.97,
			-1856.03,
			0,
			-815.624,
			-1602.07,
			200
		},
		{
			"LVA Freight Depot",
			1457.39,
			863.229,
			-89.084,
			1777.4,
			1143.21,
			110.916
		},
		{
			"Prickle Pine",
			1117.4,
			2507.23,
			-89.084,
			1534.56,
			2723.23,
			110.916
		},
		{
			"Blueberry",
			104.534,
			-220.137,
			2.3,
			349.607,
			152.236,
			200
		},
		{
			"El Castillo del Diablo",
			-464.515,
			2217.68,
			0,
			-208.57,
			2580.36,
			200
		},
		{
			"Downtown",
			-2078.67,
			578.396,
			-7.6,
			-1499.89,
			744.267,
			200
		},
		{
			"Rockshore East",
			2537.39,
			676.549,
			-89.084,
			2902.35,
			943.235,
			110.916
		},
		{
			"San Fierro Bay",
			-2616.4,
			1501.21,
			-3,
			-1996.66,
			1659.68,
			200
		},
		{
			"Paradiso",
			-2741.07,
			793.411,
			-6.1,
			-2533.04,
			1268.41,
			200
		},
		{
			"The Camel's Toe",
			2087.39,
			1203.23,
			-89.084,
			2640.4,
			1383.23,
			110.916
		},
		{
			"Old Venturas Strip",
			2162.39,
			2012.18,
			-89.084,
			2685.16,
			2202.76,
			110.916
		},
		{
			"Juniper Hill",
			-2533.04,
			578.396,
			-7.6,
			-2274.17,
			968.369,
			200
		},
		{
			"Juniper Hollow",
			-2533.04,
			968.369,
			-6.1,
			-2274.17,
			1358.9,
			200
		},
		{
			"Roca Escalante",
			2237.4,
			2202.76,
			-89.084,
			2536.43,
			2542.55,
			110.916
		},
		{
			"Julius Thruway East",
			2685.16,
			1055.96,
			-89.084,
			2749.9,
			2626.55,
			110.916
		},
		{
			"Verona Beach",
			647.712,
			-2173.29,
			-89.084,
			930.221,
			-1804.21,
			110.916
		},
		{
			"Foster Valley",
			-2178.69,
			-599.884,
			-1.2,
			-1794.92,
			-324.114,
			200
		},
		{
			"Arco del Oeste",
			-901.129,
			2221.86,
			0,
			-592.09,
			2571.97,
			200
		},
		{
			"Fallen Tree",
			-792.254,
			-698.555,
			-5.3,
			-452.404,
			-380.043,
			200
		},
		{
			"The Farm",
			-1209.67,
			-1317.1,
			114.981,
			-908.161,
			-787.391,
			251.981
		},
		{
			"The Sherman Dam",
			-968.772,
			1929.41,
			-3,
			-481.126,
			2155.26,
			200
		},
		{
			"Esplanade North",
			-1996.66,
			1358.9,
			-4.5,
			-1524.24,
			1592.51,
			200
		},
		{
			"Financial",
			-1871.72,
			744.17,
			-6.1,
			-1701.3,
			1176.42,
			300
		},
		{
			"Garcia",
			-2411.22,
			-222.589,
			-1.14,
			-2173.04,
			265.243,
			200
		},
		{
			"Montgomery",
			1119.51,
			119.526,
			-3,
			1451.4,
			493.323,
			200
		},
		{
			"Creek",
			2749.9,
			1937.25,
			-89.084,
			2921.62,
			2669.79,
			110.916
		},
		{
			"Los Santos International",
			1249.62,
			-2394.33,
			-89.084,
			1852,
			-2179.25,
			110.916
		},
		{
			"Santa Maria Beach",
			72.648,
			-2173.29,
			-89.084,
			342.648,
			-1684.65,
			110.916
		},
		{
			"Mulholland Intersection",
			1463.9,
			-1150.87,
			-89.084,
			1812.62,
			-768.027,
			110.916
		},
		{
			"Angel Pine",
			-2324.94,
			-2584.29,
			-6.1,
			-1964.22,
			-2212.11,
			200
		},
		{
			"Verdant Meadows",
			37.032,
			2337.18,
			-3,
			435.988,
			2677.9,
			200
		},
		{
			"Octane Springs",
			338.658,
			1228.51,
			0,
			664.308,
			1655.05,
			200
		},
		{
			"Come-A-Lot",
			2087.39,
			943.235,
			-89.084,
			2623.18,
			1203.23,
			110.916
		},
		{
			"Redsands West",
			1236.63,
			1883.11,
			-89.084,
			1777.39,
			2142.86,
			110.916
		},
		{
			"Santa Maria Beach",
			342.648,
			-2173.29,
			-89.084,
			647.712,
			-1684.65,
			110.916
		},
		{
			"Verdant Bluffs",
			1249.62,
			-2179.25,
			-89.084,
			1692.62,
			-1842.27,
			110.916
		},
		{
			"Las Venturas Airport",
			1236.63,
			1203.28,
			-89.084,
			1457.37,
			1883.11,
			110.916
		},
		{
			"Flint Range",
			-594.191,
			-1648.55,
			0,
			-187.7,
			-1276.6,
			200
		},
		{
			"Verdant Bluffs",
			930.221,
			-2488.42,
			-89.084,
			1249.62,
			-2006.78,
			110.916
		},
		{
			"Palomino Creek",
			2160.22,
			-149.004,
			0,
			2576.92,
			228.322,
			200
		},
		{
			"Ocean Docks",
			2373.77,
			-2697.09,
			-89.084,
			2809.22,
			-2330.46,
			110.916
		},
		{
			"Easter Bay Airport",
			-1213.91,
			-50.096,
			-4.5,
			-947.98,
			578.396,
			200
		},
		{
			"Whitewood Estates",
			883.308,
			1726.22,
			-89.084,
			1098.31,
			2507.23,
			110.916
		},
		{
			"Calton Heights",
			-2274.17,
			744.17,
			-6.1,
			-1982.32,
			1358.9,
			200
		},
		{
			"Easter Basin",
			-1794.92,
			249.904,
			-9.1,
			-1242.98,
			578.396,
			200
		},
		{
			"Los Santos Inlet",
			-321.744,
			-2224.43,
			-89.084,
			44.615,
			-1724.43,
			110.916
		},
		{
			"Doherty",
			-2173.04,
			-222.589,
			-1,
			-1794.92,
			265.243,
			200
		},
		{
			"Mount Chiliad",
			-2178.69,
			-2189.91,
			-47.917,
			-2030.12,
			-1771.66,
			576.083
		},
		{
			"Fort Carson",
			-376.233,
			826.326,
			-3,
			123.717,
			1220.44,
			200
		},
		{
			"Foster Valley",
			-2178.69,
			-1115.58,
			0,
			-1794.92,
			-599.884,
			200
		},
		{
			"Ocean Flats",
			-2994.49,
			-222.589,
			-1,
			-2593.44,
			277.411,
			200
		},
		{
			"Fern Ridge",
			508.189,
			-139.259,
			0,
			1306.66,
			119.526,
			200
		},
		{
			"Bayside",
			-2741.07,
			2175.15,
			0,
			-2353.17,
			2722.79,
			200
		},
		{
			"Las Venturas Airport",
			1457.37,
			1203.28,
			-89.084,
			1777.39,
			1883.11,
			110.916
		},
		{
			"Blueberry Acres",
			-319.676,
			-220.137,
			0,
			104.534,
			293.324,
			200
		},
		{
			"Palisades",
			-2994.49,
			458.411,
			-6.1,
			-2741.07,
			1339.61,
			200
		},
		{
			"North Rock",
			2285.37,
			-768.027,
			0,
			2770.59,
			-269.74,
			200
		},
		{
			"Hunter Quarry",
			337.244,
			710.84,
			-115.239,
			860.554,
			1031.71,
			203.761
		},
		{
			"Los Santos International",
			1382.73,
			-2730.88,
			-89.084,
			2201.82,
			-2394.33,
			110.916
		},
		{
			"Missionary Hill",
			-2994.49,
			-811.276,
			0,
			-2178.69,
			-430.276,
			200
		},
		{
			"San Fierro Bay",
			-2616.4,
			1659.68,
			-3,
			-1996.66,
			2175.15,
			200
		},
		{
			"Restricted Area",
			-91.586,
			1655.05,
			-50,
			421.234,
			2123.01,
			250
		},
		{
			"Mount Chiliad",
			-2997.47,
			-1115.58,
			-47.917,
			-2178.69,
			-971.913,
			576.083
		},
		{
			"Mount Chiliad",
			-2178.69,
			-1771.66,
			-47.917,
			-1936.12,
			-1250.97,
			576.083
		},
		{
			"Easter Bay Airport",
			-1794.92,
			-730.118,
			-3,
			-1213.91,
			-50.096,
			200
		},
		{
			"The Panopticon",
			-947.98,
			-304.32,
			-1.1,
			-319.676,
			327.071,
			200
		},
		{
			"Shady Creeks",
			-1820.64,
			-2643.68,
			-8,
			-1226.78,
			-1771.66,
			200
		},
		{
			"Back o Beyond",
			-1166.97,
			-2641.19,
			0,
			-321.744,
			-1856.03,
			200
		},
		{
			"Mount Chiliad",
			-2994.49,
			-2189.91,
			-47.917,
			-2178.69,
			-1115.58,
			576.083
		},
		{
			"Tierra Robada",
			-1213.91,
			596.349,
			-242.99,
			-480.539,
			1659.68,
			900
		},
		{
			"Flint County",
			-1213.91,
			-2892.97,
			-242.99,
			44.615,
			-768.027,
			900
		},
		{
			"Whetstone",
			-2997.47,
			-2892.97,
			-242.99,
			-1213.91,
			-1115.58,
			900
		},
		{
			"Bone County",
			-480.539,
			596.349,
			-242.99,
			869.461,
			2993.87,
			900
		},
		{
			"Tierra Robada",
			-2997.47,
			1659.68,
			-242.99,
			-480.539,
			2993.87,
			900
		},
		{
			"San Fierro",
			-2997.47,
			-1115.58,
			-242.99,
			-1213.91,
			1659.68,
			900
		},
		{
			"Las Venturas",
			869.461,
			596.349,
			-242.99,
			2997.06,
			2993.87,
			900
		},
		{
			"Red County",
			-1213.91,
			-768.027,
			-242.99,
			2997.06,
			596.349,
			900
		},
		{
			"Los Santos",
			44.615,
			-2892.97,
			-242.99,
			2997.06,
			-768.027,
			900
		}
	}

	for iter_535_0, iter_535_1 in ipairs(var_535_0) do
		if arg_535_0 >= iter_535_1[2] and arg_535_1 >= iter_535_1[3] and arg_535_2 >= iter_535_1[4] and arg_535_0 <= iter_535_1[5] and arg_535_1 <= iter_535_1[6] and arg_535_2 <= iter_535_1[7] then
			return iter_535_1[1]
		end
	end

	return "No signal"
end

function massi()
	for iter_536_0 = 0, 100 do
		wait(0)

		mass[iter_536_0] = true
	end
end

function alns()
	for iter_537_0 = 0, 20 do
		wait(0)

		aln[iter_537_0] = true
	end
end

setGxtEntry("LANDSTK", "Landstalker")
setGxtEntry("BRAVURA", "Bravura")
setGxtEntry("BUFFALO", "Buffalo")
setGxtEntry("LINERUN", "Linerunner")
setGxtEntry("PEREN", "Perenial")
setGxtEntry("SENTINL", "Sentinel")
setGxtEntry("DUMPER", "Dumper")
setGxtEntry("FIRETRK", "Fire truck")
setGxtEntry("TRASHM", "Trashmaster")
setGxtEntry("STRETCH", "Stretch")
setGxtEntry("MANANA", "Manana")
setGxtEntry("INFERNU", "Infernus")
setGxtEntry("VOODOO", "Voodoo")
setGxtEntry("PONY", "Pony")
setGxtEntry("MULE", "Mule")
setGxtEntry("CHEETAH", "Cheetah")
setGxtEntry("AMBULAN", "Ambulance")
setGxtEntry("LEVIATH", "Leviathan")
setGxtEntry("MOONBM", "Moonbeam")
setGxtEntry("ESPERAN", "Esperanto")
setGxtEntry("TAXI", "Taxi")
setGxtEntry("WASHING", "Washington")
setGxtEntry("BOBCAT", "Bobcat")
setGxtEntry("WHOOPEE", "Mr.Whoopee")
setGxtEntry("BFINJC", "BF Injection")
setGxtEntry("HUNTER", "Hunter")
setGxtEntry("PREMIER", "Premier")
setGxtEntry("ENFORCR", "Enforcer")
setGxtEntry("SECURI", "Securicar")
setGxtEntry("BANSHEE", "Banshee")
setGxtEntry("PREDATR", "Predator")
setGxtEntry("BUS", "Bus")
setGxtEntry("RHINO", "Rhino")
setGxtEntry("BARRCKS", "Barracks")
setGxtEntry("HOTKNIF", "Hotknife")
setGxtEntry("ARTICT1", "Artict1")
setGxtEntry("PREVION", "Previon")
setGxtEntry("COACH", "Coach")
setGxtEntry("CABBIE", "Cabbie")
setGxtEntry("STALION", "Stallion")
setGxtEntry("RUMPO", "Rumpo")
setGxtEntry("RCBANDT", "RC Bandit")
setGxtEntry("ROMERO", "Romero")
setGxtEntry("PACKER", "Packer")
setGxtEntry("MONSTER", "Monster")
setGxtEntry("ADMIRAL", "Admiral")
setGxtEntry("SQUALO", "Squalo")
setGxtEntry("SEASPAR", "Seasparrow")
setGxtEntry("PIZZABO", "Pizzaboy")
setGxtEntry("TRAM", "Tram")
setGxtEntry("ARTICT2", "Artict2")
setGxtEntry("TURISMO", "Turismo")
setGxtEntry("SPEEDER", "Speeder")
setGxtEntry("REEFER", "Reefer")
setGxtEntry("TROPIC", "Tropic")
setGxtEntry("FLATBED", "Flatbed")
setGxtEntry("YANKEE", "Yankee")
setGxtEntry("CADDY", "Caddy")
setGxtEntry("SOLAIR", "Solair")
setGxtEntry("TOPFUN", "Berkley's RC Van")
setGxtEntry("SKIMMER", "Skimmer")
setGxtEntry("PCJ600", "PCJ-600")
setGxtEntry("FAGGIO", "Faggio")
setGxtEntry("FREEWAY", "Freeway")
setGxtEntry("RCBARON", "RC Baron")
setGxtEntry("RCRAIDE", "RC Raider")
setGxtEntry("GLENDAL", "Glendale")
setGxtEntry("OCEANIC", "Oceanic")
setGxtEntry("SANCHEZ", "Sanchez")
setGxtEntry("SPARROW", "Sparrow")
setGxtEntry("PATRIOT", "Patriot")
setGxtEntry("QUAD", "Quadbike")
setGxtEntry("COASTG", "Coastguard")
setGxtEntry("DINGHY", "Dinghy")
setGxtEntry("HERMES", "Hermes")
setGxtEntry("SABRE", "Sabre")
setGxtEntry("RUSTLER", "Rustler")
setGxtEntry("ZR350", "ZR-350")
setGxtEntry("WALTON", "Walton")
setGxtEntry("REGINA", "Regina")
setGxtEntry("COMET", "Comet")
setGxtEntry("BMX", "Bmx")
setGxtEntry("BURRITO", "Burrito")
setGxtEntry("CAMPER", "Camper")
setGxtEntry("MARQUIS", "Marquis")
setGxtEntry("BAGGAGE", "Baggage")
setGxtEntry("DOZER", "Dozer")
setGxtEntry("MAVERIC", "Maverick")
setGxtEntry("SANMAV", "News chopper")
setGxtEntry("RANCHER", "Rancher")
setGxtEntry("FBIRANC", "FBI Rancher")
setGxtEntry("VIRGO", "Virgo")
setGxtEntry("GREENWO", "Greenwood")
setGxtEntry("JETMAX", "Jetmax")
setGxtEntry("HOTRING", "Hotring Racer")
setGxtEntry("SANDKIN", "Sandking")
setGxtEntry("BLISTAC", "Blista Compact")
setGxtEntry("POLMAV", "Police Maverick")
setGxtEntry("BOXVILL", "Boxville")
setGxtEntry("BENSON", "Benson")
setGxtEntry("MESAA", "Mesa")
setGxtEntry("RCGOBLI", "RC Goblin")
setGxtEntry("HOTRINA", "Hotring Racer")
setGxtEntry("HOTRINB", "Hotring Racer")
setGxtEntry("BLOODRA", "Bloodring Banger")
setGxtEntry("RANCHER", "Rancher")
setGxtEntry("SUPERGT", "Super GT")
setGxtEntry("ELEGANT", "Elegant")
setGxtEntry("JOURNEY", "Journey")
setGxtEntry("BIKE", "Bike")
setGxtEntry("MTBIKE", "Mountain Bike")
setGxtEntry("BEAGLE", "Beagle")
setGxtEntry("CROPDST", "Cropduster")
setGxtEntry("STUNT", "Stuntplane")
setGxtEntry("PETROL", "Tanker")
setGxtEntry("RDTRAIN", "Roadtrain")
setGxtEntry("NEBULA", "Nebula")
setGxtEntry("MAJESTC", "Majestic")
setGxtEntry("BUCCANE", "Buccaneer")
setGxtEntry("SHAMAL", "Shamal")
setGxtEntry("HYDRA", "Hydra")
setGxtEntry("FCR900", "FCR-900")
setGxtEntry("NRG500", "NRG-500")
setGxtEntry("HPV1000", "HPV1000")
setGxtEntry("CEMENT", "Cement Truck")
setGxtEntry("TOWTRUK", "Towtruck")
setGxtEntry("FORTUNE", "Fortune")
setGxtEntry("CADRONA", "Cadrona")
setGxtEntry("FBITRUK", "FBI Truck")
setGxtEntry("WILLARD", "Willard")
setGxtEntry("FORKLFT", "Forklift")
setGxtEntry("TRACTOR", "Tractor")
setGxtEntry("COMBINE", "Combine Harvester")
setGxtEntry("FELTZER", "Feltzer")
setGxtEntry("REMING", "Remington")
setGxtEntry("SLAMVAN", "Slamvan")
setGxtEntry("BLADE", "Blade")
setGxtEntry("FREIGHT", "Freight")
setGxtEntry("STREAK", "Brown Streak")
setGxtEntry("VORTEX", "Vortex")
setGxtEntry("VINCENT", "Vincent")
setGxtEntry("BULLET", "Bullet")
setGxtEntry("CLOVER", "Clover")
setGxtEntry("SADLER", "Sadler")
setGxtEntry("FIRELA", "Fire Truck")
setGxtEntry("HUSTLER", "Hustler")
setGxtEntry("INTRUDR", "Intruder")
setGxtEntry("PRIMO", "Primo")
setGxtEntry("CARGOBB", "Cargobob")
setGxtEntry("TAMPA", "Tampa")
setGxtEntry("SUNRISE", "Sunrise")
setGxtEntry("MERIT", "Merit")
setGxtEntry("UTILITY", "Utillity Van")
setGxtEntry("NEVADA", "Nevada")
setGxtEntry("YOSEMIT", "Yosemite")
setGxtEntry("WINDSOR", "Windsor")
setGxtEntry("MONSTA", "Monster")
setGxtEntry("MONSTB", "Monster")
setGxtEntry("URANUS", "Uranus")
setGxtEntry("JESTER", "Jester")
setGxtEntry("SULTAN", "Sultan")
setGxtEntry("STRATUM", "Stratum")
setGxtEntry("ELEGY", "Elegy")
setGxtEntry("RAINDNC", "Raindance")
setGxtEntry("RCTIGER", "RC Tiger")
setGxtEntry("FLASH", "Flash")
setGxtEntry("TAHOMA", "Tahoma")
setGxtEntry("SAVANNA", "Savanna")
setGxtEntry("BANDITO", "Bandito")
setGxtEntry("FRFLAT", "Frightflat")
setGxtEntry("STREAKC", "Streak")
setGxtEntry("KART", "Kart")
setGxtEntry("MOWER", "Mower")
setGxtEntry("DUNE", "Dune")
setGxtEntry("SWEEPER", "Sweeper")
setGxtEntry("BROADWY", "Broadway")
setGxtEntry("TORNADO", "Tornado")
setGxtEntry("AT400", "AT-400")
setGxtEntry("DFT30", "DFT-30")
setGxtEntry("HUNTLEY", "Huntley")
setGxtEntry("STAFFRD", "Stafford")
setGxtEntry("BF400", "BF-400")
setGxtEntry("NEWSVAN", "Newsvan")
setGxtEntry("TUG", "Tug")
setGxtEntry("PETROTR", "Petrol Trailer")
setGxtEntry("EMPEROR", "Emperor")
setGxtEntry("WAYFARE", "Wayfarer")
setGxtEntry("EUROS", "Euros")
setGxtEntry("HOTDOG", "Hotdog")
setGxtEntry("CLUB", "Club")
setGxtEntry("FRBOX", "Frightbox")
setGxtEntry("ARTICT3", "Artict3")
setGxtEntry("ANDROM", "Andromada")
setGxtEntry("DODO", "Dodo")
setGxtEntry("RCCAM", "RC Cam")
setGxtEntry("LAUNCH", "Launch")
setGxtEntry("POLICAR", "Police Car")
setGxtEntry("POLICAR", "Police Car")
setGxtEntry("POLICAR", "Police Car")
setGxtEntry("RANGER", "Ranger")
setGxtEntry("PICADOR", "Picador")
setGxtEntry("SWATVAN", "S.W.A.T")
setGxtEntry("ALPHA", "Alpha")
setGxtEntry("PHOENIX", "Phoenix")
setGxtEntry("GLENSHI", "Glenshit")
setGxtEntry("SADLSHI", "Sadlshit")
setGxtEntry("BAGBOXA", "Bagbox")
setGxtEntry("BAGBOXB", "Bagbox")
setGxtEntry("TUGSTAI", "Tugstair")
setGxtEntry("BOXBURG", "Boxburg")
setGxtEntry("FARMTR1", "Farmtrailer")
setGxtEntry("UTILTR1", "Utilltytrailer")

function update()
	update = false
end

allkeys = {
	["Numpad 2"] = "������� \"Numpad 2\" � ���������� Numpad",
	["Right Button"] = "������ ������ ����",
	["Num -"] = "������� \"Numpad -\" � ���������� Numpad",
	["Arrow Up"] = "������� �����",
	["X Button 1"] = "���.������ �� �����",
	["Page Down"] = "������� Page Down",
	["Numpad 6"] = "������� \"Numpad 6\" � ���������� Numpad",
	["Print Screen"] = "������� Print Screen",
	["Arrow Right"] = "������� ������",
	Pause = "������� Pause",
	Ctrl = "������� Ctrl",
	["Page Up"] = "������� Page Up",
	Backspace = "������� Backspace",
	Enter = "������� Enter",
	["Left Button"] = "����� ������ ����",
	["Numpad ."] = "������� \"Numpad .\" � ���������� Numpad",
	Insert = "������� Insert",
	Esc = "������� Escape",
	["Numpad 0"] = "������� \"Numpad 0\" � ���������� Numpad",
	["Numpad 3"] = "������� \"Numpad 3\" � ���������� Numpad",
	["Numpad 5"] = "������� \"Numpad 5\" � ���������� Numpad",
	Shift = "������� Shift",
	["Arrow Left"] = "������� �����",
	["Numpad 8"] = "������� \"Numpad 8\" � ���������� Numpad",
	["Middle Button"] = "������� ������ �� �����",
	["Right Win"] = "������ ������� Windows",
	["Numpad 9"] = "������� \"Numpad 9\" � ���������� Numpad",
	["Left Win"] = "����� ������� Windows",
	["Numpad 7"] = "������� \"Numpad 7\" � ���������� Numpad",
	Alt = "������� Alt",
	Tab = "������� Tab",
	["Right Alt"] = "������ ������� Alt",
	["Left Ctrl"] = "����� ������� Ctrl",
	End = "������� End",
	["Left Shift"] = "����� ������� Shift",
	["Left Alt"] = "����� ������� Alt",
	["Numpad /"] = "������� \"Numpad /\" � ���������� Numpad",
	["X Button 2"] = "���.������ �� �����",
	["Numpad *"] = "������� \"Numpad *\" � ���������� Numpad",
	["Numpad 1"] = "������� \"Numpad 1\" � ���������� Numpad",
	["Arrow Down"] = "������� ����",
	["Num Lock"] = "������� Num Lock",
	Home = "������� Home",
	["Numpad 4"] = "������� \"Numpad 4\" � ���������� Numpad",
	["Caps Lock"] = "������� Caps Lock",
	Delete = "������� Delete",
	["Right Shift"] = "������ ������� Shift",
	["Scrol Lock"] = "������� Scrol Lock",
	Space = "������",
	["Numpad +"] = "������� \"Numpad +\" � ���������� Numpad",
	["Right Ctrl"] = "������ ������� Ctrl",
	Break = "������� Break"
}

function fastmap_viewer()
	while true do
		wait(0)

		x, y = getCharCoordinates(playerPed)

		while not se.main.fastmap do
			wait(100)
		end

		if isKeyJustPressed(var_0_6.name_to_id(se.keys.fastmap)) and not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() then
			as.fastmap.checked = true

			if not as.fastmap.fastmap_state then
				for iter_543_0, iter_543_1 in pairs(var_0_20) do
					if not doesFileExist("moonloader/PD-Project/resource/fastmap/" .. iter_543_0) then
						as.fastmap.checked = false
					end
				end
			end

			if not as.fastmap.checked then
				chat("����������� ����� �����. ������������� ������ ��� �������� - /pdreload.")
			else
				as.fastmap.fastmap_state = not as.fastmap.fastmap_state
			end
		end

		if as.fastmap.fastmap_state and letsGame then
			fastmap()
		end

		if as.fastmap.fastmap_state and isKeyJustPressed(VK_RBUTTON) then
			if as.fastmap.cursor then
				showCursor(false, false)

				as.fastmap.cursor = false
			else
				showCursor(true, false)

				as.fastmap.cursor = true
			end
		end

		if not as.fastmap.fastmap_state and as.fastmap.cursor then
			showCursor(false, false)

			as.fastmap.cursor = false
		end

		if as.fastmap.cursor and isKeyJustPressed(VK_LBUTTON) then
			local var_543_0, var_543_1 = getCursorPos()

			cursorPosToCoord(var_543_0, var_543_1)
		end

		if as.fastmap.cursor and isKeyDown(VK_MBUTTON) then
			local var_543_2, var_543_3 = getCursorPos()

			if var_543_2 >= as.fastmap.m1x1 and var_543_2 <= as.fastmap.m1x4 and var_543_3 >= as.fastmap.m1y1 and var_543_3 <= as.fastmap.m1y4 then
				as.fastmap.modX, as.fastmap.modY = 1, 1
			elseif var_543_2 >= as.fastmap.m2x1 and var_543_2 <= as.fastmap.m2x4 and var_543_3 >= as.fastmap.m2y1 and var_543_3 <= as.fastmap.m2y4 then
				as.fastmap.modX, as.fastmap.modY = 1, 2
			elseif var_543_2 >= as.fastmap.m3x1 and var_543_2 <= as.fastmap.m3x4 and var_543_3 >= as.fastmap.m3y1 and var_543_3 <= as.fastmap.m3y4 then
				as.fastmap.modX, as.fastmap.modY = 1, 3
			elseif var_543_2 >= as.fastmap.m4x1 and var_543_2 <= as.fastmap.m4x4 and var_543_3 >= as.fastmap.m4y1 and var_543_3 <= as.fastmap.m4y4 then
				as.fastmap.modX, as.fastmap.modY = 2, 1
			elseif var_543_2 >= as.fastmap.m5x1 and var_543_2 <= as.fastmap.m5x4 and var_543_3 >= as.fastmap.m5y1 and var_543_3 <= as.fastmap.m5y4 then
				as.fastmap.modX, as.fastmap.modY = 2, 2
			elseif var_543_2 >= as.fastmap.m6x1 and var_543_2 <= as.fastmap.m6x4 and var_543_3 >= as.fastmap.m6y1 and var_543_3 <= as.fastmap.m6y4 then
				as.fastmap.modX, as.fastmap.modY = 2, 3
			elseif var_543_2 >= as.fastmap.m7x1 and var_543_2 <= as.fastmap.m7x4 and var_543_3 >= as.fastmap.m7y1 and var_543_3 <= as.fastmap.m7y4 then
				as.fastmap.modX, as.fastmap.modY = 3, 1
			elseif var_543_2 >= as.fastmap.m8x1 and var_543_2 <= as.fastmap.m8x4 and var_543_3 >= as.fastmap.m8y1 and var_543_3 <= as.fastmap.m8y4 then
				as.fastmap.modX, as.fastmap.modY = 3, 2
			elseif var_543_2 >= as.fastmap.m9x1 and var_543_2 <= as.fastmap.m9x4 and var_543_3 >= as.fastmap.m9y1 and var_543_3 <= as.fastmap.m9y4 then
				as.fastmap.modX, as.fastmap.modY = 3, 3
			end
		end
	end
end

function getX(arg_544_0)
	if as.fastmap.mapmode == 0 then
		arg_544_0 = math.floor(arg_544_0 + 3000)

		return as.fastmap.bX + arg_544_0 * (as.fastmap.size / 6000) - as.fastmap.iconsize / 2
	end

	if as.fastmap.mapmode == 3 or as.fastmap.mapmode == 9 or as.fastmap.mapmode == 6 then
		return as.fastmap.bX - as.fastmap.iconsize / 2 + math.floor(arg_544_0) * (as.fastmap.size / 3000)
	end

	if as.fastmap.mapmode == 1 or as.fastmap.mapmode == 7 or as.fastmap.mapmode == 4 then
		return as.fastmap.bX - as.fastmap.iconsize / 2 + math.floor(arg_544_0 + 3000) * (as.fastmap.size / 3000)
	end

	if as.fastmap.mapmode == 2 or as.fastmap.mapmode == 8 or as.fastmap.mapmode == 5 then
		return as.fastmap.bX - as.fastmap.iconsize / 2 + math.floor(arg_544_0 + 1500) * (as.fastmap.size / 3000)
	end
end

function getY(arg_545_0)
	if as.fastmap.mapmode == 0 then
		arg_545_0 = math.floor(arg_545_0 * -1 + 3000)

		return as.fastmap.bY + arg_545_0 * (as.fastmap.size / 6000) - as.fastmap.iconsize / 2
	end

	if as.fastmap.mapmode == 7 or as.fastmap.mapmode == 9 or as.fastmap.mapmode == 8 then
		return as.fastmap.bY + as.fastmap.size - as.fastmap.iconsize / 2 -
		math.floor(arg_545_0) * (as.fastmap.size / 3000)
	end

	if as.fastmap.mapmode == 1 or as.fastmap.mapmode == 3 or as.fastmap.mapmode == 2 then
		return as.fastmap.bY + as.fastmap.size - as.fastmap.iconsize / 2 -
		math.floor(arg_545_0 + 3000) * (as.fastmap.size / 3000)
	end

	if as.fastmap.mapmode == 4 or as.fastmap.mapmode == 5 or as.fastmap.mapmode == 6 then
		return as.fastmap.bY + as.fastmap.size - as.fastmap.iconsize / 2 -
		math.floor(arg_545_0 + 1500) * (as.fastmap.size / 3000)
	end
end

function var_0_3.onSetRaceCheckpoint(arg_546_0, arg_546_1)
	as.fastmap.race_checkout = arg_546_1
end

function var_0_3.onDisableRaceCheckpoint()
	as.fastmap.race_checkout = nil
end

function fastmap_init()
	resX, resY = getScreenResolution()
	as.fastmap.player = renderLoadTextureFromFile(getGameDirectory() .. "/moonloader/PD-Project/resource/fastmap/me.png")
	as.fastmap.player1 = renderLoadTextureFromFile(getGameDirectory() ..
	"/moonloader/PD-Project/resource/fastmap/player.png")
	as.fastmap.source = renderLoadTextureFromFile(getGameDirectory() ..
	"/moonloader/PD-Project/resource/fastmap/Icon_56.png")
	as.fastmap.waypoint = renderLoadTextureFromFile(getGameDirectory() ..
	"/moonloader/PD-Project/resource/fastmap/waypoint.png")
	as.fastmap.race_checkpoint = renderLoadTextureFromFile(getGameDirectory() ..
	"/moonloader/PD-Project/resource/fastmap/race_checkpoint.png")
	as.fastmap.police_car = renderLoadTextureFromFile(getGameDirectory() ..
	"/moonloader/PD-Project/resource/fastmap/police_car.png")
	as.fastmap.car = renderLoadTextureFromFile(getGameDirectory() .. "/moonloader/PD-Project/resource/fastmap/car.png")
	as.fastmap.fbi_car = renderLoadTextureFromFile(getGameDirectory() ..
	"/moonloader/PD-Project/resource/fastmap/fbi_car.png")
	as.fastmap.heli = renderLoadTextureFromFile(getGameDirectory() .. "/moonloader/PD-Project/resource/fastmap/heli.png")
	as.fastmap.boat = renderLoadTextureFromFile(getGameDirectory() .. "/moonloader/PD-Project/resource/fastmap/boat.png")
	as.fastmap.umarker = renderLoadTextureFromFile(getGameDirectory() ..
	"/moonloader/PD-Project/resource/fastmap/user_marker.png")
	as.fastmap.font = renderCreateFont("Comic Sans MS", 10, 4)
	as.fastmap.font_mark = renderCreateFont("Comic Sans MS", 7, 4)
	as.fastmap.font_marker = renderCreateFont("Comic Sans MS", 8, 9)
	as.fastmap.m1k = renderLoadTextureFromFile(getGameDirectory() .. "/moonloader/PD-Project/resource/fastmap/1k.png")
	as.fastmap.m2k = renderLoadTextureFromFile(getGameDirectory() .. "/moonloader/PD-Project/resource/fastmap/2k.png")
	as.fastmap.m3k = renderLoadTextureFromFile(getGameDirectory() .. "/moonloader/PD-Project/resource/fastmap/3k.png")
	as.fastmap.m4k = renderLoadTextureFromFile(getGameDirectory() .. "/moonloader/PD-Project/resource/fastmap/4k.png")
	as.fastmap.m5k = renderLoadTextureFromFile(getGameDirectory() .. "/moonloader/PD-Project/resource/fastmap/5k.png")
	as.fastmap.m6k = renderLoadTextureFromFile(getGameDirectory() .. "/moonloader/PD-Project/resource/fastmap/6k.png")
	as.fastmap.m7k = renderLoadTextureFromFile(getGameDirectory() .. "/moonloader/PD-Project/resource/fastmap/7k.png")
	as.fastmap.m8k = renderLoadTextureFromFile(getGameDirectory() .. "/moonloader/PD-Project/resource/fastmap/8k.png")
	as.fastmap.m9k = renderLoadTextureFromFile(getGameDirectory() .. "/moonloader/PD-Project/resource/fastmap/9k.png")
	as.fastmap.m10k = renderLoadTextureFromFile(getGameDirectory() .. "/moonloader/PD-Project/resource/fastmap/10k.png")
	as.fastmap.m11k = renderLoadTextureFromFile(getGameDirectory() .. "/moonloader/PD-Project/resource/fastmap/11k.png")
	as.fastmap.m12k = renderLoadTextureFromFile(getGameDirectory() .. "/moonloader/PD-Project/resource/fastmap/12k.png")
	as.fastmap.m13k = renderLoadTextureFromFile(getGameDirectory() .. "/moonloader/PD-Project/resource/fastmap/13k.png")
	as.fastmap.m14k = renderLoadTextureFromFile(getGameDirectory() .. "/moonloader/PD-Project/resource/fastmap/14k.png")
	as.fastmap.m15k = renderLoadTextureFromFile(getGameDirectory() .. "/moonloader/PD-Project/resource/fastmap/15k.png")
	as.fastmap.m16k = renderLoadTextureFromFile(getGameDirectory() .. "/moonloader/PD-Project/resource/fastmap/16k.png")

	if resX > 1024 and resY >= 1024 then
		as.fastmap.bX = (resX - 1024) / 2
		as.fastmap.bY = (resY - 1024) / 2
		as.fastmap.size = 1024
	elseif resX > 720 and resY >= 720 then
		as.fastmap.bX = (resX - 720) / 2
		as.fastmap.bY = (resY - 720) / 2
		as.fastmap.size = 720
	else
		as.fastmap.bX = (resX - 512) / 2
		as.fastmap.bY = (resY - 512) / 2
		as.fastmap.size = 512
	end
end

function getQ(arg_549_0, arg_549_1, arg_549_2)
	if arg_549_2 == 1 and arg_549_0 <= 0 and arg_549_1 <= 0 then
		return true
	end

	if arg_549_2 == 2 and arg_549_0 >= -1500 and arg_549_0 <= 1500 and arg_549_1 <= 0 then
		return true
	end

	if arg_549_2 == 3 and arg_549_0 >= 0 and arg_549_1 <= 0 then
		return true
	end

	if arg_549_2 == 4 and arg_549_0 <= 0 and arg_549_1 >= -1500 and arg_549_1 <= 1500 then
		return true
	end

	if arg_549_2 == 5 and arg_549_0 >= -1500 and arg_549_0 <= 1500 and arg_549_1 >= -1500 and arg_549_1 <= 1500 then
		return true
	end

	if arg_549_2 == 6 and arg_549_0 >= 0 and arg_549_1 >= -1500 and arg_549_1 <= 1500 then
		return true
	end

	if arg_549_2 == 7 and arg_549_0 <= 0 and arg_549_1 >= 0 then
		return true
	end

	if arg_549_2 == 8 and arg_549_0 >= -1500 and arg_549_0 <= 1500 and arg_549_1 >= 0 then
		return true
	end

	if arg_549_2 == 9 and arg_549_0 >= 0 and arg_549_1 >= 0 then
		return true
	end

	return false
end

function getMode(arg_550_0, arg_550_1)
	if arg_550_0 == 1 then
		if arg_550_1 == 1 then
			return 1
		end

		if arg_550_1 == 2 then
			return 2
		end

		if arg_550_1 == 3 then
			return 3
		end
	end

	if arg_550_0 == 2 then
		if arg_550_1 == 1 then
			return 4
		end

		if arg_550_1 == 2 then
			return 5
		end

		if arg_550_1 == 3 then
			return 6
		end
	end

	if arg_550_0 == 3 then
		if arg_550_1 == 1 then
			return 7
		end

		if arg_550_1 == 2 then
			return 8
		end

		if arg_550_1 == 3 then
			return 9
		end
	end
end

function cursorPosToCoord(arg_551_0, arg_551_1)
	if as.fastmap.mapmode == 0 then
		if as.fastmap.size == 1024 then
			local var_551_0 = as.fastmap.bX
			local var_551_1 = as.fastmap.bY
			local var_551_2 = as.fastmap.bX + 3 * (as.fastmap.size / 4) + as.fastmap.size / 4
			local var_551_3 = as.fastmap.bY + 3 * (as.fastmap.size / 4) + as.fastmap.size / 4
			local var_551_4 = (arg_551_0 - var_551_0) * 5.87 - 3000
			local var_551_5 = ((arg_551_1 - var_551_1) * 5.87 - 3000) * -1

			if var_551_0 <= arg_551_0 and arg_551_0 <= var_551_2 and var_551_1 <= arg_551_1 and arg_551_1 <= var_551_3 then
				local var_551_6, var_551_7, var_551_8, var_551_9 = getTargetBlipCoordinates()

				if var_551_6 then
					removeWaypoint()
				else
					removeWaypoint()
					placeWaypoint(var_551_4, var_551_5, 10)
				end

				if var_551_4 == as.fastmap.cx and var_551_5 == as.fastmap.cy then
					as.fastmap.count = as.fastmap.count + 1
				else
					as.fastmap.count = 0
				end

				if as.fastmap.count >= 2 then
					as.other.mapClicked.x, as.other.mapClicked.y, as.other.mapClicked.kv = var_551_4, var_551_5,
						kvadUliXY(var_551_4, var_551_5)
					im.windows.markermanage.v = true

					removeWaypoint()
				end

				as.fastmap.cx, as.fastmap.cy = var_551_4, var_551_5

				return true
			end
		elseif as.fastmap.size == 720 then
			local var_551_10 = as.fastmap.bX
			local var_551_11 = as.fastmap.bY
			local var_551_12 = as.fastmap.bX + 3 * (as.fastmap.size / 4) + as.fastmap.size / 4
			local var_551_13 = as.fastmap.bY + 3 * (as.fastmap.size / 4) + as.fastmap.size / 4
			local var_551_14 = (arg_551_0 - var_551_10) * 8.35 - 3000
			local var_551_15 = ((arg_551_1 - var_551_11) * 8.35 - 3000) * -1

			if var_551_10 <= arg_551_0 and arg_551_0 <= var_551_12 and var_551_11 <= arg_551_1 and arg_551_1 <= var_551_13 then
				local var_551_16, var_551_17, var_551_18, var_551_19 = getTargetBlipCoordinates()

				if var_551_16 then
					removeWaypoint()
				else
					removeWaypoint()
					placeWaypoint(var_551_14, var_551_15, 10)
				end

				if var_551_14 == as.fastmap.cx and var_551_15 == as.fastmap.cy then
					as.fastmap.count = as.fastmap.count + 1
				else
					as.fastmap.count = 0
				end

				if as.fastmap.count >= 2 then
					as.other.mapClicked.x, as.other.mapClicked.y, as.other.mapClicked.kv = var_551_14, var_551_15,
						kvadUliXY(var_551_14, var_551_15)
					im.windows.markermanage.v = true

					removeWaypoint()
				end

				as.fastmap.cx, as.fastmap.cy = var_551_14, var_551_15

				return true
			end
		elseif as.fastmap.size == 512 then
			local var_551_20 = as.fastmap.bX
			local var_551_21 = as.fastmap.bY
			local var_551_22 = as.fastmap.bX + 3 * (as.fastmap.size / 4) + as.fastmap.size / 4
			local var_551_23 = as.fastmap.bY + 3 * (as.fastmap.size / 4) + as.fastmap.size / 4
			local var_551_24 = (arg_551_0 - var_551_20) * 11.69 - 3000
			local var_551_25 = ((arg_551_1 - var_551_21) * 11.69 - 3000) * -1

			if var_551_20 <= arg_551_0 and arg_551_0 <= var_551_22 and var_551_21 <= arg_551_1 and arg_551_1 <= var_551_23 then
				local var_551_26, var_551_27, var_551_28, var_551_29 = getTargetBlipCoordinates()

				if var_551_26 then
					removeWaypoint()
				else
					removeWaypoint()
					placeWaypoint(var_551_24, var_551_25, 10)
				end

				if var_551_24 == as.fastmap.cx and var_551_25 == as.fastmap.cy then
					as.fastmap.count = as.fastmap.count + 1
				else
					as.fastmap.count = 0
				end

				if as.fastmap.count >= 2 then
					as.other.mapClicked.x, as.other.mapClicked.y, as.other.mapClicked.kv = var_551_24, var_551_25,
						kvadUliXY(var_551_24, var_551_25)
					im.windows.markermanage.v = true

					removeWaypoint()
				end

				as.fastmap.cx, as.fastmap.cy = var_551_24, var_551_25

				return true
			end
		end
	else
		am("������ ��������������� ������ �� ������ ������ �����.")
	end
end

function updateGGColor(arg_552_0)
	if active then
		local var_552_0 = var_0_10.cast("struct stGangzonePool*", sampGetGangzonePoolPtr())

		if var_552_0.iIsListed[tonumber(arg_552_0)] ~= 0 and var_552_0.pGangzone[tonumber(arg_552_0)] ~= nil and gg.gz[tonumber(arg_552_0)] ~= nil then
			gg.gz[tonumber(arg_552_0)].color = getGGColor(var_552_0.pGangzone[i].dwColor)
		end
	end
end

function getGGColor(arg_553_0)
	local var_553_0 = {
		[-1761670701] = "0x66FF00CD",
		[-1442840332] = "0x66FF0000",
		[-1772377129] = "0x66F8FFA2",
		[-142698880] = "0x665478FF",
		[-1766081792] = "0x666CF9F9",
		[2516630300] = "0x66119F00",
		[-1778336996] = "0x66119F00",
		[2522590167] = "0x66F8FFA2",
		[2516635366] = "0x66FFED3D",
		[2533296595] = "0x66FF00CD",
		[2868868416] = "0x665478FF",
		[2866272215] = "0x66FFFFFF",
		[-1778331930] = "0x66FFED3D",
		[-1428695081] = "0x66FFFFFF",
		[2528885504] = "0x666CF9F9"
	}

	if var_553_0[arg_553_0] then
		return var_553_0[arg_553_0]
	end

	if tonumber(arg_553_0) < 0 then
		arg_553_0 = tonumber(arg_553_0) * -1
	end

	return string.format("0x%08X", arg_553_0)
end

function fastmap()
	if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() then
		if as.fastmap.first_start == true then
			am(
			"���������: ��������������� ����� ��������� �� �������� ���� ��� '+' � '-'.\n����������� ����� ���������� � ������� ������� ������� ������ ���� ��� �� ���������� ��������� ������� �����, ������, ����, �����.\n������ �� ������ ������ ����. ���� ������� ����� ������� ���� �� ����� - ��������� ������. ��� ���� ������ �� ���� ����� �� ����� - ��������� ����� ��������� ������������� SQUAD.",
				10)

			as.fastmap.first_start = false
		end

		if isKeyJustPressed(VK_OEM_MINUS) then
			as.fastmap.mapmode = 0
		elseif isKeyJustPressed(VK_OEM_PLUS) or as.fastmap.mapmode ~= 0 then
			as.fastmap.mapmode = getMode(as.fastmap.modX, as.fastmap.modY)

			if wasKeyPressed(37) then
				if as.fastmap.modY > 1 then
					as.fastmap.modY = as.fastmap.modY - 1
				end
			elseif wasKeyPressed(39) then
				if as.fastmap.modY < 3 then
					as.fastmap.modY = as.fastmap.modY + 1
				end
			elseif wasKeyPressed(38) then
				if as.fastmap.modX < 3 then
					as.fastmap.modX = as.fastmap.modX + 1
				end
			elseif wasKeyPressed(40) and as.fastmap.modX > 1 then
				as.fastmap.modX = as.fastmap.modX - 1
			end
		end

		as.fastmap.m1x1, as.fastmap.m1y1 = as.fastmap.bX, as.fastmap.bY + 2 * (as.fastmap.size / 4)
		as.fastmap.m1x2, as.fastmap.m1y2 = as.fastmap.bX + as.fastmap.size / 4, as.fastmap.bY + 2 * (as.fastmap.size / 4)
		as.fastmap.m1x3, as.fastmap.m1y3 = as.fastmap.bX, as.fastmap.bY + 3 * (as.fastmap.size / 4)
		as.fastmap.m1x4, as.fastmap.m1y4 = as.fastmap.bX + as.fastmap.size / 4, as.fastmap.bY + 3 * (as.fastmap.size / 4)
		as.fastmap.m2x1, as.fastmap.m2y1 = as.fastmap.bX + as.fastmap.size / 4, as.fastmap.bY + 2 * (as.fastmap.size / 4)
		as.fastmap.m2x2, as.fastmap.m2y2 = as.fastmap.bX + 2 * (as.fastmap.size / 4),
			as.fastmap.bY + 2 * (as.fastmap.size / 4)
		as.fastmap.m2x3, as.fastmap.m2y3 = as.fastmap.bX + as.fastmap.size / 4, as.fastmap.bY + 3 * (as.fastmap.size / 4)
		as.fastmap.m2x4, as.fastmap.m2y4 = as.fastmap.bX + 2 * (as.fastmap.size / 4),
			as.fastmap.bY + 3 * (as.fastmap.size / 4)
		as.fastmap.m3x1, as.fastmap.m3y1 = as.fastmap.bX + 2 * (as.fastmap.size / 4),
			as.fastmap.bY + 2 * (as.fastmap.size / 4)
		as.fastmap.m3x2, as.fastmap.m3y2 = as.fastmap.bX + 3 * (as.fastmap.size / 4),
			as.fastmap.bY + 2 * (as.fastmap.size / 4)
		as.fastmap.m3x3, as.fastmap.m3y3 = as.fastmap.bX + 2 * (as.fastmap.size / 4),
			as.fastmap.bY + 3 * (as.fastmap.size / 4)
		as.fastmap.m3x4, as.fastmap.m3y4 = as.fastmap.bX + 3 * (as.fastmap.size / 4),
			as.fastmap.bY + 3 * (as.fastmap.size / 4)
		as.fastmap.m4x1, as.fastmap.m4y1 = as.fastmap.bX, as.fastmap.bY + as.fastmap.size / 4
		as.fastmap.m4x2, as.fastmap.m4y2 = as.fastmap.bX + as.fastmap.size / 4, as.fastmap.bY + as.fastmap.size / 4
		as.fastmap.m4x3, as.fastmap.m4y3 = as.fastmap.bX, as.fastmap.bY + 2 * (as.fastmap.size / 4)
		as.fastmap.m4x4, as.fastmap.m4y4 = as.fastmap.bX + as.fastmap.size / 4, as.fastmap.bY + 2 * (as.fastmap.size / 4)
		as.fastmap.m5x1, as.fastmap.m5y1 = as.fastmap.bX + as.fastmap.size / 4, as.fastmap.bY + as.fastmap.size / 4
		as.fastmap.m5x2, as.fastmap.m5y2 = as.fastmap.bX + 2 * (as.fastmap.size / 4), as.fastmap.bY + as.fastmap.size / 4
		as.fastmap.m5x3, as.fastmap.m5y3 = as.fastmap.bX + as.fastmap.size / 4, as.fastmap.bY + 2 * (as.fastmap.size / 4)
		as.fastmap.m5x4, as.fastmap.m5y4 = as.fastmap.bX + 2 * (as.fastmap.size / 4),
			as.fastmap.bY + 2 * (as.fastmap.size / 4)
		as.fastmap.m6x1, as.fastmap.m6y1 = as.fastmap.bX + 2 * (as.fastmap.size / 4), as.fastmap.bY + as.fastmap.size / 4
		as.fastmap.m6x2, as.fastmap.m6y2 = as.fastmap.bX + 3 * (as.fastmap.size / 4), as.fastmap.bY + as.fastmap.size / 4
		as.fastmap.m6x3, as.fastmap.m6y3 = as.fastmap.bX + 2 * (as.fastmap.size / 4),
			as.fastmap.bY + 2 * (as.fastmap.size / 4)
		as.fastmap.m6x4, as.fastmap.m6y4 = as.fastmap.bX + 3 * (as.fastmap.size / 4),
			as.fastmap.bY + 2 * (as.fastmap.size / 4)
		as.fastmap.m7x1, as.fastmap.m7y1 = as.fastmap.bX, as.fastmap.bY
		as.fastmap.m7x2, as.fastmap.m7y2 = as.fastmap.bX + as.fastmap.size / 4, as.fastmap.bY
		as.fastmap.m7x3, as.fastmap.m7y3 = as.fastmap.bX, as.fastmap.bY + as.fastmap.size / 4
		as.fastmap.m7x4, as.fastmap.m7y4 = as.fastmap.bX + as.fastmap.size / 4, as.fastmap.bY + as.fastmap.size / 4
		as.fastmap.m8x1, as.fastmap.m8y1 = as.fastmap.bX + as.fastmap.size / 4, as.fastmap.bY
		as.fastmap.m8x2, as.fastmap.m8y2 = as.fastmap.bX + 2 * (as.fastmap.size / 4), as.fastmap.bY
		as.fastmap.m8x3, as.fastmap.m8y3 = as.fastmap.bX + as.fastmap.size / 4, as.fastmap.bY + as.fastmap.size / 4
		as.fastmap.m8x4, as.fastmap.m8y4 = as.fastmap.bX + 2 * (as.fastmap.size / 4), as.fastmap.bY + as.fastmap.size / 4
		as.fastmap.m9x1, as.fastmap.m9y1 = as.fastmap.bX + 2 * (as.fastmap.size / 4), as.fastmap.bY
		as.fastmap.m9x2, as.fastmap.m9y2 = as.fastmap.bX + 3 * (as.fastmap.size / 4), as.fastmap.bY
		as.fastmap.m9x3, as.fastmap.m9y3 = as.fastmap.bX + 2 * (as.fastmap.size / 4), as.fastmap.bY + as.fastmap.size / 4
		as.fastmap.m9x4, as.fastmap.m9y4 = as.fastmap.bX + 3 * (as.fastmap.size / 4), as.fastmap.bY + as.fastmap.size / 4

		if as.fastmap.mapmode == 0 or as.fastmap.mapmode == -1 then
			renderDrawTexture(as.fastmap.m1k, as.fastmap.bX, as.fastmap.bY, as.fastmap.size / 4, as.fastmap.size / 4, 0,
				4294967295)
			renderDrawTexture(as.fastmap.m2k, as.fastmap.bX + as.fastmap.size / 4, as.fastmap.bY, as.fastmap.size / 4,
				as.fastmap.size / 4, 0, 4294967295)
			renderDrawTexture(as.fastmap.m3k, as.fastmap.bX + 2 * (as.fastmap.size / 4), as.fastmap.bY,
				as.fastmap.size / 4, as.fastmap.size / 4, 0, 4294967295)
			renderDrawTexture(as.fastmap.m4k, as.fastmap.bX + 3 * (as.fastmap.size / 4), as.fastmap.bY,
				as.fastmap.size / 4, as.fastmap.size / 4, 0, 4294967295)
			renderDrawTexture(as.fastmap.m5k, as.fastmap.bX, as.fastmap.bY + as.fastmap.size / 4, as.fastmap.size / 4,
				as.fastmap.size / 4, 0, 4294967295)
			renderDrawTexture(as.fastmap.m6k, as.fastmap.bX + as.fastmap.size / 4, as.fastmap.bY + as.fastmap.size / 4,
				as.fastmap.size / 4, as.fastmap.size / 4, 0, 4294967295)
			renderDrawTexture(as.fastmap.m7k, as.fastmap.bX + 2 * (as.fastmap.size / 4),
				as.fastmap.bY + as.fastmap.size / 4, as.fastmap.size / 4, as.fastmap.size / 4, 0, 4294967295)
			renderDrawTexture(as.fastmap.m8k, as.fastmap.bX + 3 * (as.fastmap.size / 4),
				as.fastmap.bY + as.fastmap.size / 4, as.fastmap.size / 4, as.fastmap.size / 4, 0, 4294967295)
			renderDrawTexture(as.fastmap.m9k, as.fastmap.bX, as.fastmap.bY + 2 * (as.fastmap.size / 4),
				as.fastmap.size / 4, as.fastmap.size / 4, 0, 4294967295)
			renderDrawTexture(as.fastmap.m10k, as.fastmap.bX + as.fastmap.size / 4,
				as.fastmap.bY + 2 * (as.fastmap.size / 4), as.fastmap.size / 4, as.fastmap.size / 4, 0, 4294967295)
			renderDrawTexture(as.fastmap.m11k, as.fastmap.bX + 2 * (as.fastmap.size / 4),
				as.fastmap.bY + 2 * (as.fastmap.size / 4), as.fastmap.size / 4, as.fastmap.size / 4, 0, 4294967295)
			renderDrawTexture(as.fastmap.m12k, as.fastmap.bX + 3 * (as.fastmap.size / 4),
				as.fastmap.bY + 2 * (as.fastmap.size / 4), as.fastmap.size / 4, as.fastmap.size / 4, 0, 4294967295)
			renderDrawTexture(as.fastmap.m13k, as.fastmap.bX, as.fastmap.bY + 3 * (as.fastmap.size / 4),
				as.fastmap.size / 4, as.fastmap.size / 4, 0, 4294967295)
			renderDrawTexture(as.fastmap.m14k, as.fastmap.bX + as.fastmap.size / 4,
				as.fastmap.bY + 3 * (as.fastmap.size / 4), as.fastmap.size / 4, as.fastmap.size / 4, 0, 4294967295)
			renderDrawTexture(as.fastmap.m15k, as.fastmap.bX + 2 * (as.fastmap.size / 4),
				as.fastmap.bY + 3 * (as.fastmap.size / 4), as.fastmap.size / 4, as.fastmap.size / 4, 0, 4294967295)
			renderDrawTexture(as.fastmap.m16k, as.fastmap.bX + 3 * (as.fastmap.size / 4),
				as.fastmap.bY + 3 * (as.fastmap.size / 4), as.fastmap.size / 4, as.fastmap.size / 4, 0, 4294967295)

			if as.fastmap.size == 1024 then
				as.fastmap.iconsize = 16
			end

			if as.fastmap.size == 720 then
				as.fastmap.iconsize = 12
			end

			if as.fastmap.size == 512 then
				as.fastmap.iconsize = 10
			end
		else
			if as.fastmap.size == 1024 then
				as.fastmap.iconsize = 32
			end

			if as.fastmap.size == 720 then
				as.fastmap.iconsize = 24
			end

			if as.fastmap.size == 512 then
				as.fastmap.iconsize = 16
			end
		end

		if as.fastmap.mapmode == 1 then
			renderDrawTexture(as.fastmap.m9k, as.fastmap.bX, as.fastmap.bY, as.fastmap.size / 2, as.fastmap.size / 2, 0,
				4294967295)
			renderDrawTexture(as.fastmap.m10k, as.fastmap.bX + as.fastmap.size / 2, as.fastmap.bY, as.fastmap.size / 2,
				as.fastmap.size / 2, 0, 4294967295)
			renderDrawTexture(as.fastmap.m13k, as.fastmap.bX, as.fastmap.bY + as.fastmap.size / 2, as.fastmap.size / 2,
				as.fastmap.size / 2, 0, 4294967295)
			renderDrawTexture(as.fastmap.m14k, as.fastmap.bX + as.fastmap.size / 2, as.fastmap.bY + as.fastmap.size / 2,
				as.fastmap.size / 2, as.fastmap.size / 2, 0, 4294967295)
		end

		if as.fastmap.mapmode == 2 then
			renderDrawTexture(as.fastmap.m10k, as.fastmap.bX, as.fastmap.bY, as.fastmap.size / 2, as.fastmap.size / 2, 0,
				4294967295)
			renderDrawTexture(as.fastmap.m11k, as.fastmap.bX + as.fastmap.size / 2, as.fastmap.bY, as.fastmap.size / 2,
				as.fastmap.size / 2, 0, 4294967295)
			renderDrawTexture(as.fastmap.m14k, as.fastmap.bX, as.fastmap.bY + as.fastmap.size / 2, as.fastmap.size / 2,
				as.fastmap.size / 2, 0, 4294967295)
			renderDrawTexture(as.fastmap.m15k, as.fastmap.bX + as.fastmap.size / 2, as.fastmap.bY + as.fastmap.size / 2,
				as.fastmap.size / 2, as.fastmap.size / 2, 0, 4294967295)
		end

		if as.fastmap.mapmode == 3 then
			renderDrawTexture(as.fastmap.m11k, as.fastmap.bX, as.fastmap.bY, as.fastmap.size / 2, as.fastmap.size / 2, 0,
				4294967295)
			renderDrawTexture(as.fastmap.m12k, as.fastmap.bX + as.fastmap.size / 2, as.fastmap.bY, as.fastmap.size / 2,
				as.fastmap.size / 2, 0, 4294967295)
			renderDrawTexture(as.fastmap.m15k, as.fastmap.bX, as.fastmap.bY + as.fastmap.size / 2, as.fastmap.size / 2,
				as.fastmap.size / 2, 0, 4294967295)
			renderDrawTexture(as.fastmap.m16k, as.fastmap.bX + as.fastmap.size / 2, as.fastmap.bY + as.fastmap.size / 2,
				as.fastmap.size / 2, as.fastmap.size / 2, 0, 4294967295)
		end

		if as.fastmap.mapmode == 4 then
			renderDrawTexture(as.fastmap.m5k, as.fastmap.bX, as.fastmap.bY, as.fastmap.size / 2, as.fastmap.size / 2, 0,
				4294967295)
			renderDrawTexture(as.fastmap.m6k, as.fastmap.bX + as.fastmap.size / 2, as.fastmap.bY, as.fastmap.size / 2,
				as.fastmap.size / 2, 0, 4294967295)
			renderDrawTexture(as.fastmap.m9k, as.fastmap.bX, as.fastmap.bY + as.fastmap.size / 2, as.fastmap.size / 2,
				as.fastmap.size / 2, 0, 4294967295)
			renderDrawTexture(as.fastmap.m10k, as.fastmap.bX + as.fastmap.size / 2, as.fastmap.bY + as.fastmap.size / 2,
				as.fastmap.size / 2, as.fastmap.size / 2, 0, 4294967295)
		end

		if as.fastmap.mapmode == 5 then
			renderDrawTexture(as.fastmap.m6k, as.fastmap.bX, as.fastmap.bY, as.fastmap.size / 2, as.fastmap.size / 2, 0,
				4294967295)
			renderDrawTexture(as.fastmap.m7k, as.fastmap.bX + as.fastmap.size / 2, as.fastmap.bY, as.fastmap.size / 2,
				as.fastmap.size / 2, 0, 4294967295)
			renderDrawTexture(as.fastmap.m10k, as.fastmap.bX, as.fastmap.bY + as.fastmap.size / 2, as.fastmap.size / 2,
				as.fastmap.size / 2, 0, 4294967295)
			renderDrawTexture(as.fastmap.m11k, as.fastmap.bX + as.fastmap.size / 2, as.fastmap.bY + as.fastmap.size / 2,
				as.fastmap.size / 2, as.fastmap.size / 2, 0, 4294967295)
		end

		if as.fastmap.mapmode == 6 then
			renderDrawTexture(as.fastmap.m7k, as.fastmap.bX, as.fastmap.bY, as.fastmap.size / 2, as.fastmap.size / 2, 0,
				4294967295)
			renderDrawTexture(as.fastmap.m8k, as.fastmap.bX + as.fastmap.size / 2, as.fastmap.bY, as.fastmap.size / 2,
				as.fastmap.size / 2, 0, 4294967295)
			renderDrawTexture(as.fastmap.m11k, as.fastmap.bX, as.fastmap.bY + as.fastmap.size / 2, as.fastmap.size / 2,
				as.fastmap.size / 2, 0, 4294967295)
			renderDrawTexture(as.fastmap.m12k, as.fastmap.bX + as.fastmap.size / 2, as.fastmap.bY + as.fastmap.size / 2,
				as.fastmap.size / 2, as.fastmap.size / 2, 0, 4294967295)
		end

		if as.fastmap.mapmode == 7 then
			renderDrawTexture(as.fastmap.m1k, as.fastmap.bX, as.fastmap.bY, as.fastmap.size / 2, as.fastmap.size / 2, 0,
				4294967295)
			renderDrawTexture(as.fastmap.m2k, as.fastmap.bX + as.fastmap.size / 2, as.fastmap.bY, as.fastmap.size / 2,
				as.fastmap.size / 2, 0, 4294967295)
			renderDrawTexture(as.fastmap.m5k, as.fastmap.bX, as.fastmap.bY + as.fastmap.size / 2, as.fastmap.size / 2,
				as.fastmap.size / 2, 0, 4294967295)
			renderDrawTexture(as.fastmap.m6k, as.fastmap.bX + as.fastmap.size / 2, as.fastmap.bY + as.fastmap.size / 2,
				as.fastmap.size / 2, as.fastmap.size / 2, 0, 4294967295)
		end

		if as.fastmap.mapmode == 8 then
			renderDrawTexture(as.fastmap.m2k, as.fastmap.bX, as.fastmap.bY, as.fastmap.size / 2, as.fastmap.size / 2, 0,
				4294967295)
			renderDrawTexture(as.fastmap.m3k, as.fastmap.bX + as.fastmap.size / 2, as.fastmap.bY, as.fastmap.size / 2,
				as.fastmap.size / 2, 0, 4294967295)
			renderDrawTexture(as.fastmap.m6k, as.fastmap.bX, as.fastmap.bY + as.fastmap.size / 2, as.fastmap.size / 2,
				as.fastmap.size / 2, 0, 4294967295)
			renderDrawTexture(as.fastmap.m7k, as.fastmap.bX + as.fastmap.size / 2, as.fastmap.bY + as.fastmap.size / 2,
				as.fastmap.size / 2, as.fastmap.size / 2, 0, 4294967295)
		end

		if as.fastmap.mapmode == 9 then
			renderDrawTexture(as.fastmap.m3k, as.fastmap.bX, as.fastmap.bY, as.fastmap.size / 2, as.fastmap.size / 2, 0,
				4294967295)
			renderDrawTexture(as.fastmap.m4k, as.fastmap.bX + as.fastmap.size / 2, as.fastmap.bY, as.fastmap.size / 2,
				as.fastmap.size / 2, 0, 4294967295)
			renderDrawTexture(as.fastmap.m7k, as.fastmap.bX, as.fastmap.bY + as.fastmap.size / 2, as.fastmap.size / 2,
				as.fastmap.size / 2, 0, 4294967295)
			renderDrawTexture(as.fastmap.m8k, as.fastmap.bX + as.fastmap.size / 2, as.fastmap.bY + as.fastmap.size / 2,
				as.fastmap.size / 2, as.fastmap.size / 2, 0, 4294967295)
		end

		if gg.gz and #gg.gz > 0 then
			for iter_554_0, iter_554_1 in pairs(gg.gz) do
				if getQ(tonumber(iter_554_1.x1), tonumber(iter_554_1.y1), as.fastmap.mapmode) and getQ(tonumber(iter_554_1.x2), tonumber(iter_554_1.y2), as.fastmap.mapmode) or as.fastmap.mapmode == 0 then
					local var_554_0 = getX(math.floor(tonumber(iter_554_1.x1)))
					local var_554_1 = getY(math.floor(tonumber(iter_554_1.y1)))
					local var_554_2 = var_554_0 - getX(math.floor(tonumber(iter_554_1.x2)))
					local var_554_3 = var_554_1 - getY(math.floor(tonumber(iter_554_1.y2)))

					if var_554_2 < 0 then
						var_554_2 = var_554_2 * -1
					end

					if var_554_3 < 0 then
						var_554_3 = var_554_3 * -1
					end

					local var_554_4 = var_554_1 - var_554_3

					if gg.gz_flash[iter_554_0] ~= nil then
						if gg.gz_flash[iter_554_0].m - os.time() >= 0.3 then
							renderDrawBox(var_554_0, var_554_4, var_554_2, var_554_3, iter_554_1.color)

							gg.gz_flash[iter_554_0].f = os.time() + 1
						elseif gg.gz_flash[iter_554_0].f - os.time() >= 0 then
							renderDrawBox(var_554_0, var_554_4, var_554_2, var_554_3, gg.gz_flash[iter_554_0].color)
						else
							renderDrawBox(var_554_0, var_554_4, var_554_2, var_554_3, iter_554_1.color)

							gg.gz_flash[iter_554_0].m = os.time() + 1
						end
					else
						renderDrawBox(var_554_0, var_554_4, var_554_2, var_554_3, iter_554_1.color)
					end
				end
			end
		end

		if as.textdraw.squaders ~= nil then
			for iter_554_2, iter_554_3 in pairs(as.textdraw.squaders) do
				if iter_554_2 ~= myName then
					if iter_554_3.posx == nil or iter_554_3.posy == nil or iter_554_3.heading == nil or iter_554_3.vehicle == nil then
						-- block empty
					elseif getQ(tonumber(iter_554_3.posx), tonumber(iter_554_3.posy), as.fastmap.mapmode) or as.fastmap.mapmode == 0 then
						if se.fastmap.showNick then
							if se.fastmap.showNickFull then
								renderFontDrawText(as.fastmap.font, iter_554_2,
									getX(iter_554_3.posx) - string.len(iter_554_2) * 8.35, getY(iter_554_3.posy),
									4294967040)
							else
								local var_554_5, var_554_6 = iter_554_2:match("(%u).+%_(%u).+")

								if var_554_5 and var_554_6 then
									renderFontDrawText(as.fastmap.font, var_554_5 .. "." .. var_554_6 .. ".",
										getX(iter_554_3.posx) - string.len(var_554_5 .. "." .. var_554_6 .. ".") * 8.35,
										getY(iter_554_3.posy), 4294967040)
								end
							end
						end

						if se.fastmap.showMark and iter_554_3.mark and iter_554_3.mark ~= "" then
							renderFontDrawText(as.fastmap.font_mark, iter_554_3.mark,
								getX(iter_554_3.posx) + as.fastmap.iconsize * 0.7,
								getY(iter_554_3.posy) + as.fastmap.iconsize, 4282416090)
						end

						local var_554_7 = getCarModelType(iter_554_3.vehicle)

						if var_554_7 == "car" then
							renderDrawTexture(as.fastmap.car, getX(iter_554_3.posx),
								getY(iter_554_3.posy + as.fastmap.iconsize), as.fastmap.iconsize, as.fastmap.iconsize * 2,
								-iter_554_3.heading, -1)
						elseif var_554_7 == "police" then
							renderDrawTexture(as.fastmap.police_car, getX(iter_554_3.posx),
								getY(iter_554_3.posy + as.fastmap.iconsize), as.fastmap.iconsize, as.fastmap.iconsize * 2,
								-iter_554_3.heading, -1)
						elseif var_554_7 == "fbi" then
							renderDrawTexture(as.fastmap.police_car, getX(iter_554_3.posx),
								getY(iter_554_3.posy + as.fastmap.iconsize), as.fastmap.iconsize, as.fastmap.iconsize * 2,
								-iter_554_3.heading, -1)
						elseif var_554_7 == "heli" then
							renderDrawTexture(as.fastmap.heli, getX(iter_554_3.posx), getY(iter_554_3.posy),
								as.fastmap.iconsize * 2, as.fastmap.iconsize * 2 * 1.5, -iter_554_3.heading, -1)
						elseif var_554_7 == "boat" then
							renderDrawTexture(as.fastmap.boat, getX(iter_554_3.posx), getY(iter_554_3.posy),
								as.fastmap.iconsize * 1.3, as.fastmap.iconsize * 1.3 * 2.125, -iter_554_3.heading, -1)
						elseif var_554_7 == "moto" then
							renderDrawTexture(as.fastmap.car, getX(iter_554_3.posx),
								getY(iter_554_3.posy + as.fastmap.iconsize), as.fastmap.iconsize, as.fastmap.iconsize * 2,
								-iter_554_3.heading, -1)
						else
							renderDrawTexture(as.fastmap.player1, getX(iter_554_3.posx), getY(iter_554_3.posy),
								as.fastmap.iconsize, as.fastmap.iconsize, -iter_554_3.heading, -1)
						end
					end

					if iter_554_3.marker ~= nil and iter_554_3.marker.x ~= nil and iter_554_3.marker.y ~= nil and iter_554_3.marker.x ~= 0 and iter_554_3.marker.y ~= 0 and (getQ(tonumber(iter_554_3.marker.x), tonumber(iter_554_3.marker.y), as.fastmap.mapmode) or as.fastmap.mapmode == 0) then
						local var_554_8, var_554_9 = string.match(iter_554_2, "(.).+_(.).+")

						if var_554_8 and var_554_9 then
							renderFontDrawText(as.fastmap.font, "[" .. var_554_8 .. var_554_9 .. "]",
								getX(iter_554_3.marker.x), getY(iter_554_3.marker.y) + as.fastmap.iconsize, 4278255360)
							renderDrawTexture(as.fastmap.umarker, getX(iter_554_3.marker.x) - as.fastmap.iconsize / 2,
								getY(iter_554_3.marker.y) - as.fastmap.iconsize / 2, as.fastmap.iconsize,
								as.fastmap.iconsize * 1.3, 0, 4294901760)
						else
							renderFontDrawText(as.fastmap.font, "[" .. iter_554_2 .. "]", getX(iter_554_3.marker.x),
								getY(iter_554_3.marker.y) + as.fastmap.iconsize, 4278255360)
							renderDrawTexture(as.fastmap.umarker, getX(iter_554_3.marker.x) - as.fastmap.iconsize / 2,
								getY(iter_554_3.marker.y) - as.fastmap.iconsize / 2, as.fastmap.iconsize,
								as.fastmap.iconsize * 1.3, 0, 4294901760)
						end
					end

					if iter_554_3.markers ~= nil then
						for iter_554_4, iter_554_5 in pairs(iter_554_3.markers) do
							if iter_554_5.x ~= nil and iter_554_5.y ~= nil and iter_554_5.x ~= 0 and iter_554_5.y ~= 0 then
								local var_554_10, var_554_11 = string.match(iter_554_2, "(.).+_(.).+")

								if var_554_10 and var_554_11 then
									if iter_554_5.title ~= nil and iter_554_5.title ~= "" then
										renderFontDrawText(as.fastmap.font_marker,
											"[" .. u8:decode(iter_554_5.title) .. "]: " .. u8:decode(iter_554_5.kv),
											getX(iter_554_5.x), getY(iter_554_5.y) - as.fastmap.iconsize * 2, 4291677645)
									end

									renderFontDrawText(as.fastmap.font, "[" .. var_554_10 .. var_554_11 .. "]",
										getX(iter_554_5.x), getY(iter_554_5.y) + as.fastmap.iconsize, 4278255360)
									renderDrawTexture(as.fastmap.umarker, getX(iter_554_5.x) - as.fastmap.iconsize / 2,
										getY(iter_554_5.y) - as.fastmap.iconsize / 2, as.fastmap.iconsize,
										as.fastmap.iconsize * 1.3, 0, 4294901760)
								else
									if iter_554_5.title ~= nil and iter_554_5.title ~= "" then
										renderFontDrawText(as.fastmap.font_marker,
											"[" .. u8:decode(iter_554_5.title) .. "]", getX(iter_554_5.x),
											getY(iter_554_5.y) - as.fastmap.iconsize * 2, 4291677645)
									end

									renderFontDrawText(as.fastmap.font, "[" .. iter_554_2 .. "]", getX(iter_554_5.x),
										getY(iter_554_5.y) + as.fastmap.iconsize, 4278255360)
									renderDrawTexture(as.fastmap.umarker, getX(iter_554_5.x) - as.fastmap.iconsize / 2,
										getY(iter_554_5.y) - as.fastmap.iconsize / 2, as.fastmap.iconsize,
										as.fastmap.iconsize * 1.3, 0, 4294901760)
								end
							end
						end
					end
				end
			end
		end

		if as.fastmap.c2x ~= nil and as.fastmap.c2y ~= nil and as.fastmap.c2x ~= 0 and as.fastmap.c2y ~= 0 and (getQ(tonumber(as.fastmap.c2x), tonumber(as.fastmap.c2y), as.fastmap.mapmode) or as.fastmap.mapmode == 0) then
			local var_554_12, var_554_13 = string.match(
			sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))), "(.).+_(.).+")

			if var_554_12 and var_554_13 then
				renderFontDrawText(as.fastmap.font, "[" .. var_554_12 .. var_554_13 .. "]", getX(as.fastmap.c2x),
					getY(as.fastmap.c2y) + as.fastmap.iconsize, 4278255360)
				renderDrawTexture(as.fastmap.umarker, getX(as.fastmap.c2x) - as.fastmap.iconsize / 2,
					getY(as.fastmap.c2y) - as.fastmap.iconsize / 2, as.fastmap.iconsize, as.fastmap.iconsize * 1.3, 0,
					4294901760)
			else
				renderFontDrawText(as.fastmap.font, "[" .. k .. "]", getX(as.fastmap.c2x),
					getY(as.fastmap.c2y) + as.fastmap.iconsize, 4278255360)
				renderDrawTexture(as.fastmap.umarker, getX(as.fastmap.c2x) - as.fastmap.iconsize / 2,
					getY(as.fastmap.c2y) - as.fastmap.iconsize / 2, as.fastmap.iconsize, as.fastmap.iconsize * 1.3, 0,
					4294901760)
			end
		end

		if as.textdraw.squaders[myName] and as.textdraw.squaders[myName].markers ~= nil then
			for iter_554_6, iter_554_7 in pairs(as.textdraw.squaders[myName].markers) do
				if iter_554_7.x ~= nil and iter_554_7.y ~= nil and iter_554_7.x ~= 0 and iter_554_7.y ~= 0 then
					local var_554_14, var_554_15 = string.match(myName, "(.).+_(.).+")

					if var_554_14 and var_554_15 then
						if iter_554_7.title ~= nil and iter_554_7.title ~= "" then
							renderFontDrawText(as.fastmap.font_marker,
								"[" .. u8:decode(iter_554_7.title) .. "]: " .. u8:decode(iter_554_7.kv),
								getX(iter_554_7.x), getY(iter_554_7.y) - as.fastmap.iconsize * 2, 4291677645)
						end

						renderFontDrawText(as.fastmap.font, "[" .. var_554_14 .. var_554_15 .. "]", getX(iter_554_7.x),
							getY(iter_554_7.y) + as.fastmap.iconsize, 4278255360)
						renderDrawTexture(as.fastmap.umarker, getX(iter_554_7.x) - as.fastmap.iconsize / 2,
							getY(iter_554_7.y) - as.fastmap.iconsize / 2, as.fastmap.iconsize, as.fastmap.iconsize * 1.3,
							0, 4294901760)
					else
						if iter_554_7.title ~= nil and iter_554_7.title ~= "" then
							renderFontDrawText(as.fastmap.font_marker, "[" .. u8(iter_554_7.title) .. "]",
								getX(iter_554_7.x), getY(iter_554_7.y) - as.fastmap.iconsize * 2, 4291677645)
						end

						renderFontDrawText(as.fastmap.font, "[" .. k .. "]", getX(iter_554_7.x),
							getY(iter_554_7.y) + as.fastmap.iconsize, 4278255360)
						renderDrawTexture(as.fastmap.umarker, getX(iter_554_7.x) - as.fastmap.iconsize / 2,
							getY(iter_554_7.y) - as.fastmap.iconsize / 2, as.fastmap.iconsize, as.fastmap.iconsize * 1.3,
							0, 4294901760)
					end
				end
			end
		end

		local var_554_16, var_554_17, var_554_18, var_554_19 = getTargetBlipCoordinates()

		if var_554_16 and (getQ(var_554_17, var_554_18, as.fastmap.mapmode) or as.fastmap.mapmode == 0) then
			renderDrawTexture(as.fastmap.waypoint, getX(var_554_17), getY(var_554_18), as.fastmap.iconsize,
				as.fastmap.iconsize, 0, 4294901760)
		end

		if as.fastmap.race_checkout ~= nil and (getQ(as.fastmap.race_checkout.x, as.fastmap.race_checkout.y, as.fastmap.mapmode) or as.fastmap.mapmode == 0) then
			renderDrawTexture(as.fastmap.race_checkpoint, getX(as.fastmap.race_checkout.x),
				getY(as.fastmap.race_checkout.y), as.fastmap.iconsize, as.fastmap.iconsize, 0, 4294967295)
		end

		if x and y and (getQ(x, y, as.fastmap.mapmode) or as.fastmap.mapmode == 0) then
			renderDrawTexture(as.fastmap.player, getX(x), getY(y), as.fastmap.iconsize, as.fastmap.iconsize,
				-getCharHeading(playerPed), -1)
		end
	end
end

function onWindowMessage(arg_555_0, arg_555_1, arg_555_2)
	if as and as.fastmap.fastmap_state and not im.windows.markermanage.v then
		if arg_555_0 == 522 and arg_555_1 == 7864320 then
			as.fastmap.mapmode = getMode(as.fastmap.modX, as.fastmap.modY)
		elseif arg_555_0 == 522 and arg_555_1 == 4287102976 then
			as.fastmap.mapmode = 0
		end
	end
end

function var_0_3.onSendBulletSync(arg_556_0)
	if active and tazer_state == "ON" and tonumber(arg_556_0.targetId) ~= 65535 and sampIsPlayerConnected(tonumber(arg_556_0.targetId)) and arg_556_0.weaponId == 24 then
		as.other.taser_timer = os.time() + 10
	end
end

function isCharLinesClear(arg_557_0, arg_557_1)
	if not doesCharExist(arg_557_0) and not doesCharExist(arg_557_1) then
		return false
	end

	local var_557_0, var_557_1, var_557_2 = getCharCoordinates(arg_557_0)
	local var_557_3, var_557_4, var_557_5 = getCharCoordinates(arg_557_1)

	if var_557_0 and var_557_1 and var_557_5 and var_557_3 and var_557_4 and z2 then
		return isLineOfSightClear(var_557_0, var_557_1, var_557_5, var_557_3, var_557_4, z2, true, false, false, true,
			false)
	end

	return false
end

function getTargetFov(arg_558_0)
	local var_558_0 = getCurrentCharWeapon(playerPed)
	local var_558_1 = 30

	if as.other.gunsfovdist[var_558_0] == nil then
		for iter_558_0, iter_558_1 in pairs(as.other.gunsfovdist[24]) do
			if arg_558_0 <= iter_558_0 then
				var_558_1 = iter_558_1
			end
		end

		return var_558_1
	end

	for iter_558_2, iter_558_3 in pairs(as.other.gunsfovdist[var_558_0]) do
		if arg_558_0 <= iter_558_2 then
			var_558_1 = iter_558_3
		end
	end

	return var_558_1
end

function getTargetDistanceFov(arg_559_0)
	local var_559_0 = false
	local var_559_1 = false
	local var_559_2 = false
	local var_559_3 = true
	local var_559_4 = arg_559_0
	local var_559_5, var_559_6 = convertGameScreenCoordsToWindowScreenCoords(339.1, 179.1)
	local var_559_7, var_559_8, var_559_9 = getCharCoordinates(playerPed)

	for iter_559_0, iter_559_1 in ipairs(getAllChars()) do
		if iter_559_1 ~= playerPed then
			local var_559_10, var_559_11 = sampGetPlayerIdByCharHandle(iter_559_1)
			local var_559_12, var_559_13, var_559_14 = getCharCoordinates(iter_559_1)
			local var_559_15, var_559_16 = convert3DCoordsToScreen(var_559_12, var_559_13, var_559_14)
			local var_559_17 = math.sqrt((var_559_15 - var_559_5) ^ 2 + (var_559_16 - var_559_6) ^ 2)
			local var_559_18 = isLineOfSightClear(var_559_7 + 0.2, var_559_8, var_559_9 + 0.7, var_559_12, var_559_13,
				var_559_14, true, true, false, true, false)
			local var_559_19 = math.floor(getDistanceBetweenCoords3d(var_559_7, var_559_8, var_559_9, var_559_12,
				var_559_13, var_559_14))

			if var_559_3 then
				arg_559_0 = getTargetFov(var_559_19)
				var_559_4 = arg_559_0
			end

			if var_559_19 <= 150 and var_559_17 < tonumber(arg_559_0) and var_559_18 then
				arg_559_0, var_559_0, var_559_1, var_559_2, var_559_3 = var_559_17, var_559_11, iter_559_1, var_559_19,
					false
			end
		end
	end

	return var_559_0, var_559_1, var_559_2, var_559_4
end

function GetClosestToSight(arg_560_0)
	local var_560_0 = false
	local var_560_1 = false
	local var_560_2 = false
	local var_560_3, var_560_4 = convertGameScreenCoordsToWindowScreenCoords(339.1, 179.1)
	local var_560_5, var_560_6, var_560_7 = getCharCoordinates(playerPed)

	for iter_560_0, iter_560_1 in ipairs(getAllChars()) do
		if iter_560_1 ~= playerPed and isCharInCarDriver(iter_560_1) then
			local var_560_8 = getGxtText(getNameOfVehicleModel(getCarModel(storeCarCharIsInNoSave(iter_560_1))))
			local var_560_9, var_560_10 = sampGetPlayerIdByCharHandle(iter_560_1)
			local var_560_11, var_560_12, var_560_13 = getCharCoordinates(iter_560_1)
			local var_560_14, var_560_15 = convert3DCoordsToScreen(var_560_11, var_560_12, var_560_13)
			local var_560_16 = math.sqrt((var_560_14 - var_560_3) ^ 2 + (var_560_15 - var_560_4) ^ 2)
			local var_560_17 = isLineOfSightClear(var_560_5, var_560_6, var_560_7, var_560_11, var_560_12, var_560_13,
				true, false, false, true, false)
			local var_560_18 = isLineOfSightClear(var_560_5, var_560_6, var_560_7 + 2, var_560_11, var_560_12, var_560_13,
				true, false, false, true, false)

			if var_560_16 < arg_560_0 and (var_560_17 or var_560_18) then
				arg_560_0, var_560_0, var_560_1, var_560_2 = var_560_16, var_560_10, iter_560_1, var_560_8
			end
		end
	end

	return var_560_0, var_560_1, var_560_2
end

function removeBadWords(arg_561_0)
	if arg_561_0 and as.other.badWordsVariations then
		for iter_561_0 = 1, 3 do
			for iter_561_1, iter_561_2 in pairs(as.other.badWordsVariations) do
				local var_561_0 = iter_561_2:nlower()
				local var_561_1, var_561_2 = arg_561_0:nlower():find(var_561_0)

				if var_561_1 then
					arg_561_0 = arg_561_0:sub(1, var_561_1 - 1) ..
					string.rep("*", #var_561_0) .. arg_561_0:sub(var_561_2 + 1)
				end
			end
		end
	end

	return arg_561_0
end

function var_0_3.onVehicleStreamIn(arg_562_0, arg_562_1)
	if as then
		if arg_562_1.addSiren == 1 then
			as.other.sirens[arg_562_0] = true
		end

		if arg_562_1.health <= 1000 then
			as.other.arm[arg_562_0] = 0
		elseif arg_562_1.health > 1000 then
			as.other.arm[arg_562_0] = math.ceil((arg_562_1.health - 1000) / 500)
		end
	end
end

function generateVariations(arg_563_0)
	local var_563_0 = {}
	local var_563_1 = {}
	local var_563_2 = {
		[string.byte("�")] = {
			"a"
		},
		[string.byte("�")] = {
			"b"
		},
		[string.byte("�")] = {
			"b"
		},
		[string.byte("�")] = {
			"r"
		},
		[string.byte("�")] = {
			"a"
		},
		[string.byte("�")] = {
			"e"
		},
		[string.byte("�")] = {
			"e"
		},
		[string.byte("�")] = {
			"x"
		},
		[string.byte("�")] = {
			"3"
		},
		[string.byte("�")] = {
			"u"
		},
		[string.byte("�")] = {
			"u"
		},
		[string.byte("�")] = {
			"k"
		},
		[string.byte("�")] = {
			"j"
		},
		[string.byte("�")] = {
			"m"
		},
		[string.byte("�")] = {
			"h"
		},
		[string.byte("�")] = {
			"o"
		},
		[string.byte("�")] = {
			"n"
		},
		[string.byte("�")] = {
			"p"
		},
		[string.byte("�")] = {
			"c"
		},
		[string.byte("�")] = {
			"t"
		},
		[string.byte("�")] = {
			"y"
		},
		[string.byte("�")] = {
			"f"
		},
		[string.byte("�")] = {
			"x"
		},
		[string.byte("�")] = {
			"u"
		},
		[string.byte("�")] = {
			"4"
		},
		[string.byte("�")] = {
			"w"
		},
		[string.byte("�")] = {
			"w"
		},
		[string.byte("�")] = {
			"b"
		},
		[string.byte("�")] = {
			"bl"
		},
		[string.byte("�")] = {
			"b"
		},
		[string.byte("�")] = {
			"3"
		},
		[string.byte("�")] = {
			"io"
		},
		[string.byte("�")] = {
			"r"
		}
	}

	local function var_563_3(arg_564_0, arg_564_1)
		local var_564_0 = arg_564_0

		for iter_564_0, iter_564_1 in ipairs(arg_564_1) do
			local var_564_1 = arg_564_0:sub(iter_564_1, iter_564_1)
			local var_564_2 = var_563_2[string.byte(var_564_1)]

			if var_564_2 then
				local var_564_3 = var_564_2[math.random(#var_564_2)]

				var_564_0 = var_564_0:sub(1, iter_564_1 - 1) .. var_564_3 .. var_564_0:sub(iter_564_1 + 1)
			end
		end

		if not var_563_1[var_564_0] then
			table.insert(var_563_0, var_564_0)

			var_563_1[var_564_0] = true
		end
	end

	for iter_563_0, iter_563_1 in ipairs(arg_563_0) do
		table.insert(var_563_0, iter_563_1)

		var_563_1[iter_563_1] = true

		local var_563_4 = {}

		for iter_563_2 = 1, #iter_563_1 do
			table.insert(var_563_4, iter_563_2)
		end

		for iter_563_3, iter_563_4 in ipairs(var_563_4) do
			var_563_3(iter_563_1, {
				iter_563_4
			})
		end

		for iter_563_5 = 2, #var_563_4 do
			local var_563_5 = {}

			local function var_563_6(arg_565_0, arg_565_1, arg_565_2)
				if arg_565_1 == 0 then
					table.insert(var_563_5, arg_565_0)

					return
				end

				for iter_565_0 = arg_565_2, #var_563_4 do
					var_563_6(arg_565_0 .. var_563_4[iter_565_0], arg_565_1 - 1, iter_565_0 + 1)
				end
			end

			var_563_6("", iter_563_5, 1)

			for iter_563_6, iter_563_7 in ipairs(var_563_5) do
				local var_563_7 = {}

				for iter_563_8 = 1, #iter_563_7 do
					table.insert(var_563_7, tonumber(iter_563_7:sub(iter_563_8, iter_563_8)))
				end

				var_563_3(iter_563_1, var_563_7)
			end
		end
	end

	return var_563_0
end

function reconnect()
	lua_thread.create(function()
		chat("��������� � �������, ��������..")
		printStringNow("~y~CONNECTING! WAIT..", 7000)

		local var_567_0, var_567_1 = sampGetCurrentServerAddress()

		sampSetGamestate(5)
		sampSetGamestate(0)
		wait(6000)
		sampConnectToServer(var_567_0, var_567_1)
	end)
end

function drawCircleIn3d(arg_568_0, arg_568_1, arg_568_2, arg_568_3, arg_568_4, arg_568_5, arg_568_6)
	local var_568_0 = math.floor(360 / (arg_568_6 or 36))
	local var_568_1
	local var_568_2

	for iter_568_0 = 0, 360, var_568_0 do
		local var_568_3, var_568_4, var_568_5, var_568_6, var_568_7, var_568_8 = convert3DCoordsToScreenEx(
		arg_568_3 * math.cos(math.rad(iter_568_0)) + arg_568_0, arg_568_3 * math.sin(math.rad(iter_568_0)) + arg_568_1,
			arg_568_2)

		if var_568_6 > 1 then
			if var_568_1 and var_568_2 then
				renderDrawLine(var_568_4, var_568_5, var_568_1, var_568_2, arg_568_5, arg_568_4)
			end

			var_568_1, var_568_2 = var_568_4, var_568_5
		end
	end
end

function onKeyPress(arg_569_0)
	return
end

function onScriptKeyPress(arg_570_0)
	onKeyPress(string.char(arg_570_0))
end

function setCursorPos(arg_571_0, arg_571_1)
	var_0_10.C.SetCursorPos(arg_571_0, arg_571_1)
end

local settings_default = decodeJson('{"elda":"elda"}')