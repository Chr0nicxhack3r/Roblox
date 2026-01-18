local obf_stringchar = string.char;
local obf_stringbyte = string.byte;
local obf_stringsub = string.sub;
local obf_bitlib = bit32 or bit;
local obf_XOR = obf_bitlib.bxor;
local obf_tableconcat = table.concat;
local obf_tableinsert = table.insert;
local function LUAOBFUSACTOR_DECRYPT_STR_0(LUAOBFUSACTOR_STR, LUAOBFUSACTOR_KEY)
	local result = {};
	for i = 1, #LUAOBFUSACTOR_STR do
		obf_tableinsert(result, obf_stringchar(obf_XOR(obf_stringbyte(obf_stringsub(LUAOBFUSACTOR_STR, i, i + 1)), obf_stringbyte(obf_stringsub(LUAOBFUSACTOR_KEY, 1 + (i % #LUAOBFUSACTOR_KEY), 1 + (i % #LUAOBFUSACTOR_KEY) + 1))) % 256));
	end
	return obf_tableconcat(result);
end
print(LUAOBFUSACTOR_DECRYPT_STR_0("\130\0\44\128\186\106\241\3\38\150\182\104\165\80\41\139\190\124\180\20", "\24\209\112\69\228\223"));
local v0 = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\191\30\211\15\155\1\192\7\141", "\100\232\113\161"));
local v1 = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\47\11\210\175\121\221\243", "\180\127\103\179\214\28\175\128"));
local v2 = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\109\83\234\114\221\221\186\12\92\67", "\101\63\38\132\33\184\175\204"));
local v3 = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\113\165\238\60\45\73\220\4\80\133\238\60\18\78\207\20", "\113\36\214\139\78\100\39\172"));
local v4 = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\1\36\168\125\210\6\54\191\110\213\54\54", "\188\85\83\205\24"));
local v5 = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\96\52\225\205\217\168\112\135", "\224\44\93\134\165\173\193\30"));
local v6 = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\247\203\40\218\167\87\6\219\207\210\47\218\159\87\4\243\198\199\40", "\146\161\162\90\174\210\54\106"));
local v7 = v1['LocalPlayer'];
local v8 = v7['Character'] or v7['CharacterAdded']:Wait();
local v9 = v8:WaitForChild(LUAOBFUSACTOR_DECRYPT_STR_0("\88\248\77\89\46\65\121\233\114\87\47\90\64\236\82\76", "\46\16\141\32\56\64"));
local v10 = v8:WaitForChild(LUAOBFUSACTOR_DECRYPT_STR_0("\114\193\141\253\84\219\137\248", "\156\58\180\224"));
local v11 = v0['CurrentCamera'];
local v12 = {};
local v13 = false;
local v14 = true;
local v15 = true;
local v16 = false;
local v17 = false;
local v18 = false;
local v19 = true;
local v20 = 4 + 12;
local v21 = nil;
local v22 = v20;
local v23 = 1227 - (322 + 905);
local v24 = 612 - (602 + 9);
local v25 = 1239 - (449 + 740);
local v26 = nil;
local v27 = nil;
local v28 = v25;
local v29 = 875 - (826 + 46);
local v30 = -v29;
local v31;
local function v32(v58)
	if v12[v58] then
		local v118 = 947 - (245 + 702);
		while true do
			if (v118 == (0 - 0)) then
				v12[v58]:Disconnect();
				v12[v58] = nil;
				break;
			end
		end
	end
end
local function v33()
	local v59 = 0 + 0;
	while true do
		if (v59 == (1898 - (260 + 1638))) then
			if not v10 then
				return;
			end
			if v17 then
				v10['WalkSpeed'] = v22;
			else
				v10['WalkSpeed'] = v21 or v20;
			end
			break;
		end
	end
end
local function v34()
	local v60 = 440 - (382 + 58);
	while true do
		if (v60 == (0 - 0)) then
			if not v10 then
				return;
			end
			v32(LUAOBFUSACTOR_DECRYPT_STR_0("\210\87\86\195\214\70\95\205\225\117\82\201\235\81\95\204", "\168\133\54\58"));
			v60 = 1 + 0;
		end
		if (v60 == (1 - 0)) then
			v12[LUAOBFUSACTOR_DECRYPT_STR_0("\60\88\90\64\206\147\14\92\82\104\245\130\5\94\83\79", "\227\107\57\54\43\157")] = v10:GetPropertyChangedSignal(LUAOBFUSACTOR_DECRYPT_STR_0("\176\251\195\141\180\234\202\131\131", "\230\231\154\175")):Connect(function()
				local v125 = 0 - 0;
				local v126;
				while true do
					if (v125 == (1205 - (902 + 303))) then
						if not v17 then
							return;
						end
						v126 = v10['WalkSpeed'];
						v125 = 1 - 0;
					end
					if (v125 == (2 - 1)) then
						if (v126 ~= v22) then
							local v148 = 0 + 0;
							local v149;
							while true do
								if ((1691 - (1121 + 569)) == v148) then
									if ((v149 - v23) >= v24) then
										local v152 = 214 - (22 + 192);
										while true do
											if (v152 == (683 - (483 + 200))) then
												v23 = v149;
												print(LUAOBFUSACTOR_DECRYPT_STR_0("\42\194\184\208\197\75\155\20\240\189\156\237\116\138\28\229\132", "\235\113\149\217\188\174\24"), LUAOBFUSACTOR_DECRYPT_STR_0("\166\77\238\124\239\128\88\247\124\162\145\88\230\125\245", "\207\225\44\131\25"), v126, "→ Forced:", v22);
												break;
											end
										end
									end
									break;
								end
								if (v148 == (1463 - (1404 + 59))) then
									v10['WalkSpeed'] = v22;
									v149 = os.clock();
									v148 = 2 - 1;
								end
							end
						end
						break;
					end
				end
			end);
			break;
		end
	end
end
local function v35()
	local v61 = 0 - 0;
	while true do
		if (v61 == (765 - (468 + 297))) then
			if not v10 then
				return;
			end
			if v18 then
				if v10['UseJumpPower'] then
					v10['JumpPower'] = v28;
				else
					v10['JumpHeight'] = v28 / (569 - (334 + 228));
				end
			elseif v10['UseJumpPower'] then
				v10['JumpPower'] = v26 or v25;
			else
				v10['JumpHeight'] = v27 or (23 - 16);
			end
			break;
		end
	end
end
local function v36(v62)
	local v63 = 0 - 0;
	while true do
		if (v63 == (2 - 0)) then
			v26 = v10['JumpPower'];
			v27 = v10['JumpHeight'];
			v63 = 1 + 2;
		end
		if ((237 - (141 + 95)) == v63) then
			v10 = v62:WaitForChild(LUAOBFUSACTOR_DECRYPT_STR_0("\99\198\181\77\21\114\66\215", "\29\43\179\216\44\123"));
			v21 = v10['WalkSpeed'];
			v63 = 2 + 0;
		end
		if (v63 == (0 - 0)) then
			v8 = v62;
			v9 = v62:WaitForChild(LUAOBFUSACTOR_DECRYPT_STR_0("\149\204\45\77\179\214\41\72\143\214\47\88\141\216\50\88", "\44\221\185\64"));
			v63 = 2 - 1;
		end
		if (v63 == (1 + 3)) then
			v35();
			break;
		end
		if (v63 == (8 - 5)) then
			v33();
			v34();
			v63 = 3 + 1;
		end
	end
end
local function v37(v64, v65, v66)
	if (v14 and v31 and v31['Notify']) then
		v31:Notify(v64, v65, v66 or (2 + 1));
	end
end
local function v38(...)
	if v13 then
		print(...);
	end
end
if v7['Character'] then
	v36(v7.Character);
end
v32(LUAOBFUSACTOR_DECRYPT_STR_0("\34\239\73\77\114\2\243\77\77\82\5\227\77\91", "\19\97\135\40\63"));
v12[LUAOBFUSACTOR_DECRYPT_STR_0("\141\84\50\41\46\50\186\89\33\26\43\53\171\88", "\81\206\60\83\91\79")] = v7['CharacterAdded']:Connect(function(v67)
	local v68 = 0 - 0;
	while true do
		if (v68 == (0 + 0)) then
			v36(v67);
			v38(LUAOBFUSACTOR_DECRYPT_STR_0("\109\163\209\96\46\192\89\161\92\235\194\119\45\204\88\170\74\241", "\196\46\203\176\18\79\163\45"), v67);
			break;
		end
	end
end);
function getPlayerPOS()
	local v69 = 163 - (92 + 71);
	while true do
		if (v69 == (0 + 0)) then
			if (v8 and v9) then
				return v9['Position'];
			end
			return nil;
		end
	end
end
function telePlayerPOS(v70)
	local v71 = 0 - 0;
	local v72;
	local v73;
	local v74;
	while true do
		if (v71 == (765 - (574 + 191))) then
			if not (v8 and v9) then
				return;
			end
			if not v15 then
				local v133 = 0 + 0;
				while true do
					if (v133 == (0 - 0)) then
						v9['CFrame'] = v70;
						return;
					end
				end
			end
			v71 = 1 + 0;
		end
		if (v71 == (851 - (254 + 595))) then
			v74 = v4:Create(v9, TweenInfo.new(v73, Enum['EasingStyle'].Quad, Enum['EasingDirection'].Out), {[LUAOBFUSACTOR_DECRYPT_STR_0("\155\4\108\31\41\254", "\143\216\66\30\126\68\155")]=v70});
			v74:Play();
			break;
		end
		if (v71 == (127 - (55 + 71))) then
			v72 = (v9['Position'] - v70['Position'])['Magnitude'];
			v73 = math.clamp(v72 / (158 - 38), 1790.15 - (573 + 1217), 0.6 - 0);
			v71 = 1 + 1;
		end
	end
end
v12[LUAOBFUSACTOR_DECRYPT_STR_0("\142\193\31\206\198\183\222\238\164\201\1\255\192\175\210\241\165\218\25", "\129\202\168\109\171\165\195\183")] = v3['InputBegan']:Connect(function(v75, v76)
	local v77 = 0 - 0;
	while true do
		if (v77 == (939 - (714 + 225))) then
			if v76 then
				return;
			end
			if (v75['KeyCode'] == Enum['KeyCode']['T']) then
				local v134 = 0 - 0;
				local v135;
				while true do
					if (v134 == (1 - 0)) then
						v135 = v9['CFrame'] * CFrame.new(0 + 0, 0 - 0, v30);
						telePlayerPOS(v135);
						v134 = 808 - (118 + 688);
					end
					if (v134 == (48 - (25 + 23))) then
						if not v16 then
							local v150 = 0 + 0;
							while true do
								if (v150 == (1886 - (927 + 959))) then
									v37(LUAOBFUSACTOR_DECRYPT_STR_0("\6\81\36\217\220\24\227\38", "\134\66\56\87\184\190\116"), LUAOBFUSACTOR_DECRYPT_STR_0("\24\56\27\190\26\255\40\58\50\48\5\251\13\238\45\48\44\62\27\175\89\226\50\117\51\55\15", "\85\92\81\105\219\121\139\65"), 10 - 7);
									return;
								end
							end
						end
						if not (v8 and v9) then
							return;
						end
						v134 = 733 - (16 + 716);
					end
					if (v134 == (3 - 1)) then
						v38(LUAOBFUSACTOR_DECRYPT_STR_0("\211\166\84\66\121\219\188", "\191\157\211\48\37\28"));
						break;
					end
				end
			end
			break;
		end
	end
end);
local v41 = nil;
local v42 = nil;
local function v43()
	local v78 = 97 - (11 + 86);
	while true do
		if (v78 == (0 - 0)) then
			if (not v41 or not v41['Parent']) then
				v41 = v0:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\246\11\241\17\41", "\90\191\127\148\124"));
			end
			if (not v42 or not v42['Parent']) then
				v42 = v0:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\85\134\62\71\41\184\13\22\122\142\32", "\119\24\231\78"));
			end
			break;
		end
	end
end
task.spawn(function()
	while v19 do
		local v117 = 285 - (175 + 110);
		while true do
			if (v117 == (0 - 0)) then
				v43();
				task.wait(4 - 3);
				break;
			end
		end
	end
end);
local v44 = {[LUAOBFUSACTOR_DECRYPT_STR_0("\160\33\176\79\156\107\20\155", "\113\226\77\197\42\188\32")]=function()
	local v79 = 1796 - (503 + 1293);
	local v80;
	while true do
		if ((0 - 0) == v79) then
			v80 = v41 and v41:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\24\26\225\176\122\61\241\172", "\213\90\118\148"));
			return v80 and v80:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\115\39\160\84\66\67", "\45\59\78\212\54"));
		end
	end
end,[LUAOBFUSACTOR_DECRYPT_STR_0("\55\68\134\142\136\110\134\245\9", "\144\112\54\227\235\230\78\205")]=function()
	local v81 = 0 + 0;
	local v82;
	while true do
		if ((1061 - (810 + 251)) == v81) then
			v82 = v41 and v41:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\148\58\10\249\222\27\152\45\22", "\59\211\72\111\156\176"));
			return v82 and v82:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\102\142\247\47\65\159", "\77\46\231\131"));
		end
	end
end,[LUAOBFUSACTOR_DECRYPT_STR_0("\149\70\183\78\189\81\246\107\191\77", "\32\218\52\214")]=function()
	local v83 = 0 + 0;
	local v84;
	while true do
		if (v83 == (0 + 0)) then
			v84 = v41 and v41:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\97\5\48\166\246\181\5\113\75\14", "\58\46\119\81\200\145\208\37"));
			return v84 and v84:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\3\133\36\174\166\165", "\86\75\236\80\204\201\221"));
		end
	end
end,[LUAOBFUSACTOR_DECRYPT_STR_0("\64\68\115\197\213\142\107", "\235\18\33\23\229\158")]=function()
	local v85 = 0 + 0;
	local v86;
	while true do
		if (v85 == (533 - (43 + 490))) then
			v86 = v41 and v41:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\98\191\197\251\123\191\216", "\219\48\218\161"));
			return v86 and v86:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\204\120\104\75\212\87", "\128\132\17\28\41\187\47"));
		end
	end
end,[LUAOBFUSACTOR_DECRYPT_STR_0("\56\55\10\54\82\22\114\45\63\68", "\61\97\82\102\90")]=function()
	local v87 = 733 - (711 + 22);
	local v88;
	while true do
		if (v87 == (0 - 0)) then
			v88 = v41 and v41:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\149\43\167\71\200\64\94\34\169\55", "\105\204\78\203\43\167\55\126"));
			return v88 and v88:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\141\163\55\28\28\28", "\49\197\202\67\126\115\100\167"));
		end
	end
end,[LUAOBFUSACTOR_DECRYPT_STR_0("\7\78\205\57\140\83\30\28\94\198", "\62\87\59\191\73\224\54")]=function()
	local v89 = 859 - (240 + 619);
	local v90;
	while true do
		if (v89 == (0 + 0)) then
			v90 = v41 and v41:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\215\23\232\217\235\7\186\226\226\27", "\169\135\98\154"));
			return v90 and v90:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\227\126\48\86\242\43", "\168\171\23\68\52\157\83"));
		end
	end
end,[LUAOBFUSACTOR_DECRYPT_STR_0("\199\112\243\168\101\30\151\251\101", "\231\148\17\149\205\69\77")]=function()
	local v91 = 0 - 0;
	local v92;
	while true do
		if (v91 == (1 + 0)) then
			return v92['CFrame'] * CFrame.new(1744 - (1344 + 400), 410 - (255 + 150), 0 + 0);
		end
		if (v91 == (0 + 0)) then
			v92 = v42 and v42:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\140\168\203\235\91\254\148\162", "\159\224\199\167\155\55"));
			if not v92 then
				return nil;
			end
			v91 = 4 - 3;
		end
	end
end};
local v45 = {};
for v93 in pairs(v44) do
	table.insert(v45, v93);
end
table.sort(v45);
local v46 = nil;
v31 = loadstring(game:HttpGet(LUAOBFUSACTOR_DECRYPT_STR_0("\255\231\40\194\228\169\115\157\229\242\43\156\240\250\40\218\226\241\41\193\242\225\63\221\249\231\57\220\227\189\63\221\250\188\31\218\229\163\50\219\244\235\52\211\244\248\111\192\184\193\51\208\251\252\36\157\229\246\58\193\184\251\57\211\243\224\115\223\246\250\50\157\244\251\46\130\249\250\63\202\226\250\115\241\255\225\108\220\254\240\36\244\229\242\49\215\224\252\46\217\185\255\41\211", "\178\151\147\92")))();
local v47 = v31.CreateLib(LUAOBFUSACTOR_DECRYPT_STR_0("\175\245\94\98\28\69\121\148\213\77\49\25\31\104\204\176\12\1\2\69\126\137\239\12\1\17\94\115\156\233", "\26\236\157\44\82\114\44"), LUAOBFUSACTOR_DECRYPT_STR_0("\14\47\199\80\30\38\208\86\47", "\59\74\78\181"));
v31.OnGuiDestroyed = function(v94)
	v38(LUAOBFUSACTOR_DECRYPT_STR_0("\30\242\82\72\227\43\216\89\66\134\12\236\26\105\176\55\212\95\84\148\48\216\26\94\182\54\197\72\85\170\32\213\0", "\211\69\177\58\58"), v94.Name);
end;
v32(LUAOBFUSACTOR_DECRYPT_STR_0("\131\234\126\242\229\206\130\204\82\240\240\201\190\235\125", "\171\215\133\25\149\137"));
v12[LUAOBFUSACTOR_DECRYPT_STR_0("\213\199\53\253\227\53\201\107\202\205\43\248\230\62\248", "\34\129\168\82\154\143\80\156")] = v3['InputBegan']:Connect(function(v95, v96)
	local v97 = 0 - 0;
	while true do
		if (v97 == (1739 - (404 + 1335))) then
			if v96 then
				return;
			end
			if (v95['KeyCode'] == Enum['KeyCode']['LeftControl']) then
				v31:ToggleUI();
			end
			break;
		end
	end
end);
local v50 = v47:NewTab(LUAOBFUSACTOR_DECRYPT_STR_0("\181\190\50\18\77\92", "\233\229\210\83\107\40\46"));
local v51 = v50:NewSection(LUAOBFUSACTOR_DECRYPT_STR_0("\241\78\51\207\0\211\2\22\215\17\192", "\101\161\34\82\182"));
v51:NewToggle(LUAOBFUSACTOR_DECRYPT_STR_0("\205\3\88\252\215\231\194\29\248\8\92\250", "\78\136\109\57\158\187\130\226"), LUAOBFUSACTOR_DECRYPT_STR_0("\27\49\248\243\50\58\185\242\43\44\237\254\51\127\238\240\50\52\185\226\46\58\252\245", "\145\94\95\153"), function(v98)
	local v99 = 406 - (183 + 223);
	while true do
		if (v99 == (1 - 0)) then
			v37((v98 and LUAOBFUSACTOR_DECRYPT_STR_0("\216\195\21\215\66\178\249", "\215\157\173\116\181\46")) or LUAOBFUSACTOR_DECRYPT_STR_0("\17\189\152\243\216\57\177\143", "\186\85\212\235\146"), (v98 and LUAOBFUSACTOR_DECRYPT_STR_0("\241\145\19\251\61\174\81\209\193\19\240\56\236\84\199\133", "\56\162\225\118\158\89\142")) or LUAOBFUSACTOR_DECRYPT_STR_0("\111\21\197\170\38\152\85\22\128\171\43\203\93\7\204\170\38", "\184\60\101\160\207\66"), 2 + 1);
			v38((v98 and LUAOBFUSACTOR_DECRYPT_STR_0("\2\146\121\185\53\194\121\178\48\128\112\185\53", "\220\81\226\28")) or LUAOBFUSACTOR_DECRYPT_STR_0("\32\197\135\254\238\135\23\220\145\250\232\203\22\209", "\167\115\181\226\155\138"));
			break;
		end
		if (v99 == (0 + 0)) then
			v17 = v98;
			v33();
			v99 = 338 - (10 + 327);
		end
	end
end);
v51:NewSlider(LUAOBFUSACTOR_DECRYPT_STR_0("\210\46\230\69\126\99\134\209\50\226\89\127", "\166\130\66\135\60\27\17"), LUAOBFUSACTOR_DECRYPT_STR_0("\108\69\217\53\54\69\89\218\53\36\76\79\142\101\60\69\83\203\103\112\73\69\216\112\35", "\80\36\42\174\21"), 70 + 30, 339 - (118 + 220), v20, function(v100)
	local v101 = 0 + 0;
	while true do
		if (v101 == (450 - (108 + 341))) then
			v38(LUAOBFUSACTOR_DECRYPT_STR_0("\126\28\54\99\75\2\119\105\94\21\50\126\14\3\50\110\14\4\56", "\26\46\112\87"), v100);
			break;
		end
		if (v101 == (0 + 0)) then
			v22 = v100;
			v33();
			v101 = 4 - 3;
		end
	end
end);
v51:NewToggle(LUAOBFUSACTOR_DECRYPT_STR_0("\156\45\170\118\179\186\5\158\172\46\187", "\212\217\67\203\20\223\223\37"), LUAOBFUSACTOR_DECRYPT_STR_0("\159\131\169\208\182\136\232\209\175\158\188\221\183\205\162\199\183\157\232\194\181\154\173\192", "\178\218\237\200"), function(v102)
	local v103 = 1493 - (711 + 782);
	while true do
		if (v103 == (1 - 0)) then
			v37((v102 and LUAOBFUSACTOR_DECRYPT_STR_0("\147\187\231\210\186\176\226", "\176\214\213\134")) or LUAOBFUSACTOR_DECRYPT_STR_0("\208\164\165\213\170\90\92\240", "\57\148\205\214\180\200\54"), (v102 and LUAOBFUSACTOR_DECRYPT_STR_0("\56\232\56\36\54\2\242\34\49\100\82\248\59\53\116\30\248\49", "\22\114\157\85\84")) or LUAOBFUSACTOR_DECRYPT_STR_0("\238\222\30\212\29\230\167\211\206\1\132\89\255\187\197\201\31\193\89", "\200\164\171\115\164\61\150"), 472 - (270 + 199));
			v38((v102 and LUAOBFUSACTOR_DECRYPT_STR_0("\148\225\14\85\195\174\251\20\64\145\254\241\13\68\129\178\241\7", "\227\222\148\99\37")) or LUAOBFUSACTOR_DECRYPT_STR_0("\25\71\95\230\185\35\93\69\243\235\115\86\91\229\248\49\94\87\242", "\153\83\50\50\150"));
			break;
		end
		if (v103 == (0 + 0)) then
			v18 = v102;
			v35();
			v103 = 1820 - (580 + 1239);
		end
	end
end);
v51:NewSlider(LUAOBFUSACTOR_DECRYPT_STR_0("\119\99\126\12\51\155\66\74\115\97", "\45\61\22\19\124\19\203"), LUAOBFUSACTOR_DECRYPT_STR_0("\233\29\26\181\10\121\190\201\82\25\253\7\48\169\205\19\20\240\16\48\179\212\31\29\230", "\217\161\114\109\149\98\16"), 535 - 355, 10 + 0, v25, function(v104)
	local v105 = 0 + 0;
	while true do
		if (v105 == (0 + 0)) then
			v28 = v104;
			v35();
			break;
		end
	end
end);
local v52 = v47:NewTab(LUAOBFUSACTOR_DECRYPT_STR_0("\38\37\52\121\172\123\0\52\43", "\20\114\64\88\28\220"));
local v53 = v52:NewSection(LUAOBFUSACTOR_DECRYPT_STR_0("\5\4\222\177\232\223\175\37\8\220\179", "\221\81\97\178\212\152\176"));
v53:NewDropdown(LUAOBFUSACTOR_DECRYPT_STR_0("\249\226\17\254\10\194\245\9\187\54\194\228\28\239\19\194\233", "\122\173\135\125\155"), LUAOBFUSACTOR_DECRYPT_STR_0("\167\201\15\182\44\52\136\147\201\5\171\58\113\220\139\129\20\188\51\52\216\139\211\20", "\168\228\161\96\217\95\81"), v45, function(v106)
	v46 = v106;
end);
v53:NewButton(LUAOBFUSACTOR_DECRYPT_STR_0("\239\212\34\89\63\88\201\197", "\55\187\177\78\60\79"), LUAOBFUSACTOR_DECRYPT_STR_0("\25\203\83\238\86\192\146\57\142\75\228\6\220\133\33\203\92\255\67\203\192\33\193\92\234\82\198\143\35", "\224\77\174\63\139\38\175"), function()
	local v107 = 0 - 0;
	local v108;
	local v109;
	while true do
		if (v107 == (0 + 0)) then
			if not v46 then
				local v136 = 1167 - (645 + 522);
				while true do
					if (v136 == (1790 - (1010 + 780))) then
						v37(LUAOBFUSACTOR_DECRYPT_STR_0("\170\78\24\29\129\77\93\45\144\72\87\32", "\78\228\33\56"), LUAOBFUSACTOR_DECRYPT_STR_0("\254\114\183\2\150\203\62\177\11\138\193\109\183\67\132\142\106\183\15\128\222\113\160\23\197\194\113\177\2\145\199\113\188\67\131\199\108\161\23", "\229\174\30\210\99"), 3 + 0);
						v38(LUAOBFUSACTOR_DECRYPT_STR_0("\47\232\138\84\253\50\43\15\173\132\93\226\62\50\30\233\220\17\227\50\121\23\226\133\80\249\52\54\21\173\149\84\225\56\58\15\232\130", "\89\123\141\230\49\141\93"));
						v136 = 4 - 3;
					end
					if (v136 == (2 - 1)) then
						return;
					end
				end
			end
			v108 = v44[v46];
			v107 = 1837 - (1045 + 791);
		end
		if (v107 == (2 - 1)) then
			if not v108 then
				local v137 = 0 - 0;
				while true do
					if (v137 == (505 - (351 + 154))) then
						v37(LUAOBFUSACTOR_DECRYPT_STR_0("\214\99\228\3\2", "\42\147\17\150\108\112"), LUAOBFUSACTOR_DECRYPT_STR_0("\38\168\59\126\235\225\11\230\57\122\235\237\31\169\63\107\167\251\10\170\40\124\243\225\0\168", "\136\111\198\77\31\135"), 1577 - (1281 + 293));
						return;
					end
				end
			end
			v109 = v108();
			v107 = 268 - (28 + 238);
		end
		if ((6 - 3) == v107) then
			v37(LUAOBFUSACTOR_DECRYPT_STR_0("\54\12\171\83\173\235\5\189\7\13", "\201\98\105\199\54\221\132\119"), LUAOBFUSACTOR_DECRYPT_STR_0("\141\9\143\36\18\58\190\173\9\135\97\22\58\236", "\204\217\108\227\65\98\85") .. v46, 1562 - (1381 + 178));
			break;
		end
		if (v107 == (2 + 0)) then
			if not v109 then
				local v138 = 0 + 0;
				while true do
					if (v138 == (0 + 0)) then
						v37(LUAOBFUSACTOR_DECRYPT_STR_0("\106\198\249\224\60\207\76\215\181\195\45\201\82\198\241", "\160\62\163\149\133\76"), v46 .. LUAOBFUSACTOR_DECRYPT_STR_0("\150\174\2\59\131\208\175\24\33\199", "\163\182\192\109\79"), 10 - 7);
						return;
					end
				end
			end
			telePlayerPOS(((typeof(v109) == LUAOBFUSACTOR_DECRYPT_STR_0("\23\0\18\193\248\49", "\149\84\70\96\160")) and v109) or v109['CFrame']);
			v107 = 2 + 1;
		end
	end
end);
v53:NewToggle(LUAOBFUSACTOR_DECRYPT_STR_0("\28\15\31\232\59\18\4\226\54\7\1\173\12\3\1\232\40\9\31\249", "\141\88\102\109"), LUAOBFUSACTOR_DECRYPT_STR_0("\135\86\198\117\10\50\71\213\160\19\211\127\15\125\92\207\243\87\195\98\31\62\65\200\188\93\138\105\21\40\21\192\161\86\138\118\27\62\92\207\180", "\161\211\51\170\16\122\93\53"), function(v110)
	local v111 = 470 - (381 + 89);
	while true do
		if (v111 == (1 + 0)) then
			v38((v110 and LUAOBFUSACTOR_DECRYPT_STR_0("\223\167\160\45\248\186\187\39\245\175\190\104\239\171\190\45\235\161\160\60\187\171\188\41\249\162\183\44", "\72\155\206\210")) or LUAOBFUSACTOR_DECRYPT_STR_0("\98\115\70\11\48\82\115\91\0\50\74\58\64\11\63\67\106\91\28\39\6\126\93\29\50\68\118\81\10", "\83\38\26\52\110"));
			break;
		end
		if (v111 == (0 + 0)) then
			v16 = v110;
			v37((v110 and LUAOBFUSACTOR_DECRYPT_STR_0("\125\25\38\68\84\18\35", "\38\56\119\71")) or LUAOBFUSACTOR_DECRYPT_STR_0("\215\230\75\215\39\90\246\235", "\54\147\143\56\182\69"), (v110 and LUAOBFUSACTOR_DECRYPT_STR_0("\242\136\237\76\220\194\136\240\71\222\218\193\235\76\211\211\145\240\91\203\150\136\236\9\208\216", "\191\182\225\159\41")) or LUAOBFUSACTOR_DECRYPT_STR_0("\15\27\58\80\136\147\203\36\28\41\89\203\147\199\39\23\56\90\153\147\130\34\1\104\90\141\129", "\162\75\114\72\53\235\231"), 4 - 1);
			v111 = 1157 - (1074 + 82);
		end
	end
end);
v53:NewSlider(LUAOBFUSACTOR_DECRYPT_STR_0("\184\57\72\231\19\38\133\47\80\227\93\1\137", "\98\236\92\36\130\51"), LUAOBFUSACTOR_DECRYPT_STR_0("\140\22\27\250\67\169\167\112\162\22\30\173\68\186\177\112\236\16\2\250\86\188\160\52\183\80\76\174\77\173\245\36\161\21\9\170\74\186\161\112\169\22\26\191\86\232\172\63\177", "\80\196\121\108\218\37\200\213"), 65 - 35, 1785 - (214 + 1570), v29, function(v112)
	local v113 = 1455 - (990 + 465);
	while true do
		if (v113 == (0 + 0)) then
			v30 = -v112;
			v38(LUAOBFUSACTOR_DECRYPT_STR_0("\36\122\16\122\72\26\131\15\125\3\115\11\10\131\19\103\3\113\72\11\202\19\118\22\63\95\1", "\234\96\19\98\31\43\110"), v112);
			break;
		end
	end
end);
local v54 = v47:NewTab(LUAOBFUSACTOR_DECRYPT_STR_0("\53\26\70\211\165\124\140\21", "\235\102\127\50\167\204\18"));
local v55 = v54:NewSection(LUAOBFUSACTOR_DECRYPT_STR_0("\100\169\240\46\65", "\78\48\193\149\67\36"));
v55:NewDropdown(LUAOBFUSACTOR_DECRYPT_STR_0("\0\23\131\19\1\41\17\149\10\1\36\22\133\21\68", "\33\80\126\224\120"), LUAOBFUSACTOR_DECRYPT_STR_0("\223\173\15\193\95\248\232\23\204\89\225\173\67\194\83\254\232\23\204\89\172\143\54\237", "\60\140\200\99\164"), v31.GetThemes(), function(v114)
	local v115 = 0 + 0;
	while true do
		if (v115 == (0 + 0)) then
			v31:SetTheme(v114);
			task.defer(function()
				local v127 = 0 - 0;
				while true do
					if (v127 == (1726 - (1668 + 58))) then
						v37(LUAOBFUSACTOR_DECRYPT_STR_0("\179\252\1\43\167\199\215\12\39\172\128\241\0", "\194\231\148\100\70"), v114 .. LUAOBFUSACTOR_DECRYPT_STR_0("\6\77\209\179\250\193\67\72", "\168\38\44\161\195\150"), 629 - (512 + 114));
						v38(LUAOBFUSACTOR_DECRYPT_STR_0("\180\244\135\123\53\168\181\30\129\242\133\115\52\168\162\25", "\118\224\156\226\22\80\136\214"), v114);
						break;
					end
				end
			end);
			break;
		end
	end
end);
v31:Notify(LUAOBFUSACTOR_DECRYPT_STR_0("\113\251\90\131\71\253\74", "\224\34\142\57"), LUAOBFUSACTOR_DECRYPT_STR_0("\253\175\215\141\125\248\94\22\253\175\192\220\103\177\78\27\221\164\192\206\96\247\72\2\210\190\133\209\124\240\89\11\218\230", "\110\190\199\165\189\19\145\61"), 7 - 4);
v38(LUAOBFUSACTOR_DECRYPT_STR_0("\233\232\101\225\155\211\154\231\120\233\143\194\222\171\100\253\136\196\223\248\100\238\158\203\214\242\57", "\167\186\139\23\136\235"));
local function v56()
	local v116 = 0 - 0;
	while true do
		if ((0 - 0) == v116) then
			v19 = false;
			v16 = false;
			v17 = false;
			v18 = false;
			v116 = 1 + 0;
		end
		if (v116 == (1 + 0)) then
			if (v10 and v21) then
				v10['WalkSpeed'] = v21;
			end
			if (v10 and v26) then
				v10['JumpPower'] = v26;
			end
			if (v10 and v27) then
				v10['JumpHeight'] = v27;
			end
			for v128, v129 in pairs(v12) do
				if v129 then
					v129:Disconnect();
				end
			end
			v116 = 2 + 0;
		end
		if (v116 == (6 - 4)) then
			table.clear(v12);
			if (v31 and v31['Notify'] and v14) then
				v31:Notify(LUAOBFUSACTOR_DECRYPT_STR_0("\47\187\132\2\27\177\141\9", "\109\122\213\232"), LUAOBFUSACTOR_DECRYPT_STR_0("\221\244\176\57\254\227\226\35\230\226\182\112\234\248\181\62\174\244\174\53\239\249\174\41", "\80\142\151\194"), 1997 - (109 + 1885));
			end
			if (v31 and v31['_Shutdown']) then
				v31:_Shutdown();
			end
			v38(LUAOBFUSACTOR_DECRYPT_STR_0("\48\197\101\69\19\210\55\89\13\202\120\77\7\195\115\12\0\202\114\77\13\202\110\2", "\44\99\166\23"));
			break;
		end
	end
end
v31['OnUnload'] = v56;