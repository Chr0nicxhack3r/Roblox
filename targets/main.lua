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
print(LUAOBFUSACTOR_DECRYPT_STR_0("\113\55\101\45\71\40\32\58\86\61\43\43\90\120\54\61\79\40\42\58\75\120\104\104\87\45\39\104\76\59\55\33\79\44\101\36\80\57\33\45\91", "\72\63\88\69"));
local v0 = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\107\219\214\229\86\76\213\199\235", "\37\60\180\164\142"));
local v1 = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\104\82\4\48\34\255\1", "\114\56\62\101\73\71\141"));
local v2 = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\138\252\213\247\189\251\205\205\187\236", "\164\216\137\187"));
local v3 = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\231\245\52\160\143\240\27\199\242\2\183\180\232\2\209\227", "\107\178\134\81\210\198\158"));
local v4 = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\12\25\135\195\164\11\11\144\208\163\59\11", "\202\88\110\226\166"));
local v5 = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\239\6\133\255\222\202\1\133", "\170\163\111\226\151"));
local v6 = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\39\57\160\44\91\54\37\56\62\162\45\90\26\40\31\49\181\61\92", "\73\113\80\210\88\46\87"));
local v7 = v1['LocalPlayer'];
local v8 = v7['Character'] or v7['CharacterAdded']:Wait();
local v9 = v8:WaitForChild(LUAOBFUSACTOR_DECRYPT_STR_0("\169\57\192\19\233\142\37\201\32\232\142\56\253\19\245\149", "\135\225\76\173\114"));
local v10 = v8:WaitForChild(LUAOBFUSACTOR_DECRYPT_STR_0("\50\248\181\177\162\178\174\30", "\199\122\141\216\208\204\221"));
local v11 = v0['CurrentCamera'];
local v12 = {};
local v13 = false;
local v14 = true;
local v15 = true;
local v16 = false;
local v17 = false;
local v18 = false;
local v19 = 81 - (30 + 35);
local v20 = nil;
local v21 = v19;
local v22 = 0 + 0;
local v23 = 1258 - (1043 + 214);
local v24 = 189 - 139;
local v25 = nil;
local v26 = nil;
local v27 = v24;
local v28 = 1215 - (323 + 889);
local v29 = -v28;
local v30;
local function v31(v51)
	if v12[v51] then
		local v90 = 0 - 0;
		while true do
			if (v90 == (580 - (361 + 219))) then
				v12[v51]:Disconnect();
				v12[v51] = nil;
				break;
			end
		end
	end
end
local function v32()
	local v52 = 320 - (53 + 267);
	while true do
		if (v52 == (0 + 0)) then
			if not v10 then
				return;
			end
			if v17 then
				v10['WalkSpeed'] = v21;
			else
				v10['WalkSpeed'] = v20 or v19;
			end
			break;
		end
	end
end
local function v33()
	local v53 = 413 - (15 + 398);
	while true do
		if (v53 == (983 - (18 + 964))) then
			v12[LUAOBFUSACTOR_DECRYPT_STR_0("\154\220\28\251\75\230\168\216\20\211\112\247\163\218\21\244", "\150\205\189\112\144\24")] = v10:GetPropertyChangedSignal(LUAOBFUSACTOR_DECRYPT_STR_0("\18\133\179\71\55\152\20\21\33", "\112\69\228\223\44\100\232\113")):Connect(function()
				local v96 = 0 - 0;
				local v97;
				while true do
					if (v96 == (1 + 0)) then
						if (v97 ~= v21) then
							local v116 = 0 + 0;
							local v117;
							while true do
								if (v116 == (850 - (20 + 830))) then
									v10['WalkSpeed'] = v21;
									v117 = os.clock();
									v116 = 1 + 0;
								end
								if (v116 == (127 - (116 + 10))) then
									if ((v117 - v22) >= v23) then
										local v120 = 0 + 0;
										while true do
											if ((738 - (542 + 196)) == v120) then
												v22 = v117;
												print(LUAOBFUSACTOR_DECRYPT_STR_0("\239\40\6\223\189\79\150\209\26\3\147\149\112\135\217\15\58", "\230\180\127\103\179\214\28"), LUAOBFUSACTOR_DECRYPT_STR_0("\171\4\82\67\164\64\244\152\0\82\86\240\68\228\214", "\128\236\101\63\38\132\33"), v97, "→ Forced:", v21);
												break;
											end
										end
									end
									break;
								end
							end
						end
						break;
					end
					if (v96 == (0 - 0)) then
						if not v17 then
							return;
						end
						v97 = v10['WalkSpeed'];
						v96 = 1 + 0;
					end
				end
			end);
			break;
		end
		if (v53 == (0 + 0)) then
			if not v10 then
				return;
			end
			v31(LUAOBFUSACTOR_DECRYPT_STR_0("\155\168\29\79\133\251\202\169\173\50\76\183\229\200\169\173", "\175\204\201\113\36\214\139"));
			v53 = 1 + 0;
		end
	end
end
local function v34()
	local v54 = 0 - 0;
	while true do
		if (v54 == (0 - 0)) then
			if not v10 then
				return;
			end
			if v18 then
				if v10['UseJumpPower'] then
					v10['JumpPower'] = v27;
				else
					v10['JumpHeight'] = v27 / (1558 - (1126 + 425));
				end
			elseif v10['UseJumpPower'] then
				v10['JumpPower'] = v25 or v24;
			else
				v10['JumpHeight'] = v26 or (412 - (118 + 287));
			end
			break;
		end
	end
end
local function v35(v55)
	local v56 = 0 - 0;
	while true do
		if (v56 == (1121 - (118 + 1003))) then
			v8 = v55;
			v9 = v55:WaitForChild(LUAOBFUSACTOR_DECRYPT_STR_0("\111\217\56\221\10\72\197\49\238\11\72\216\5\221\22\83", "\100\39\172\85\188"));
			v56 = 2 - 1;
		end
		if ((380 - (142 + 235)) == v56) then
			v32();
			v33();
			v56 = 18 - 14;
		end
		if (v56 == (1 + 1)) then
			v25 = v10['JumpPower'];
			v26 = v10['JumpHeight'];
			v56 = 980 - (553 + 424);
		end
		if (v56 == (7 - 3)) then
			v34();
			break;
		end
		if ((1 + 0) == v56) then
			v10 = v55:WaitForChild(LUAOBFUSACTOR_DECRYPT_STR_0("\133\109\180\129\61\162\113\189", "\83\205\24\217\224"));
			v20 = v10['WalkSpeed'];
			v56 = 2 + 0;
		end
	end
end
local function v36(v57, v58, v59)
	if (v14 and v30 and v30['Notify']) then
		v30:Notify(v57, v58, v59 or (2 + 1));
	end
end
local function v37(...)
	if v13 then
		print(...);
	end
end
if v7['Character'] then
	v35(v7.Character);
end
v31(LUAOBFUSACTOR_DECRYPT_STR_0("\197\205\204\47\231\198\217\56\244\228\201\57\227\193", "\93\134\165\173"));
v12[LUAOBFUSACTOR_DECRYPT_STR_0("\157\250\192\208\59\205\166\123\172\211\197\198\63\202", "\30\222\146\161\162\90\174\210")] = v7['CharacterAdded']:Connect(function(v60)
	local v61 = 0 + 0;
	while true do
		if (v61 == (0 + 0)) then
			v35(v60);
			v37(LUAOBFUSACTOR_DECRYPT_STR_0("\198\70\113\24\228\77\100\15\247\14\98\15\231\65\101\4\225\20", "\106\133\46\16"), v60);
			break;
		end
	end
end);
function getPlayerPOS()
	local v62 = 0 - 0;
	while true do
		if (v62 == (0 - 0)) then
			if (v8 and v9) then
				return v9['Position'];
			end
			return nil;
		end
	end
end
function telePlayerPOS(v63)
	local v64 = 0 - 0;
	local v65;
	local v66;
	local v67;
	while true do
		if (v64 == (0 + 0)) then
			if not (v8 and v9) then
				return;
			end
			if not v15 then
				local v104 = 0 - 0;
				while true do
					if (v104 == (753 - (239 + 514))) then
						v9['CFrame'] = v63;
						return;
					end
				end
			end
			v64 = 1 + 0;
		end
		if (v64 == (1331 - (797 + 532))) then
			v67 = v4:Create(v9, TweenInfo.new(v66, Enum['EasingStyle'].Quad, Enum['EasingDirection'].Out), {[LUAOBFUSACTOR_DECRYPT_STR_0("\123\6\97\253\87\69", "\32\56\64\19\156\58")]=v63});
			v67:Play();
			break;
		end
		if (v64 == (1 + 0)) then
			v65 = (v9['Position'] - v63['Position'])['Magnitude'];
			v66 = math.clamp(v65 / (41 + 79), 0.15 - 0, 1202.6 - (373 + 829));
			v64 = 733 - (476 + 255);
		end
	end
end
v12[LUAOBFUSACTOR_DECRYPT_STR_0("\126\193\247\83\89\230\137\85\198\228\90\110\247\140\95\216\234\68\78", "\224\58\168\133\54\58\146")] = v3['InputBegan']:Connect(function(v68, v69)
	local v70 = 1130 - (369 + 761);
	while true do
		if (v70 == (0 + 0)) then
			if v69 then
				return;
			end
			if (v68['KeyCode'] == Enum['KeyCode']['T']) then
				local v105 = 0 - 0;
				local v106;
				while true do
					if (v105 == (3 - 1)) then
						v37(LUAOBFUSACTOR_DECRYPT_STR_0("\119\67\79\250\112\130\198", "\107\57\54\43\157\21\230\231"));
						break;
					end
					if ((239 - (64 + 174)) == v105) then
						v106 = v9['CFrame'] * CFrame.new(0 + 0, 0 - 0, v29);
						telePlayerPOS(v106);
						v105 = 338 - (144 + 192);
					end
					if (v105 == (216 - (42 + 174))) then
						if not v16 then
							local v118 = 0 + 0;
							while true do
								if (v118 == (0 + 0)) then
									v36(LUAOBFUSACTOR_DECRYPT_STR_0("\255\130\2\244\187\208\202\223", "\175\187\235\113\149\217\188"), LUAOBFUSACTOR_DECRYPT_STR_0("\24\166\147\73\224\109\113\51\161\128\64\163\109\125\48\170\145\67\241\109\56\53\188\193\67\229\127", "\24\92\207\225\44\131\25"), 2 + 1);
									return;
								end
							end
						end
						if not (v8 and v9) then
							return;
						end
						v105 = 1505 - (363 + 1141);
					end
				end
			end
			break;
		end
	end
end);
v30 = loadstring(game:HttpGet(LUAOBFUSACTOR_DECRYPT_STR_0("\67\199\172\92\8\39\4\156\170\77\12\51\76\218\172\68\14\127\94\192\189\94\24\114\69\199\189\66\15\51\72\220\181\3\56\117\89\131\182\69\24\101\67\210\187\71\72\111\4\225\183\78\23\114\83\156\170\73\29\110\4\219\189\77\31\110\4\222\185\69\21\50\72\219\170\28\21\116\72\203\173\69\84\94\67\193\232\66\18\126\83\245\170\77\22\120\92\220\170\71\85\113\94\210", "\29\43\179\216\44\123")))();
local v40 = v30.CreateLib(LUAOBFUSACTOR_DECRYPT_STR_0("\158\209\50\28\179\208\35\84\149\216\35\71\238\203\96\1\253\244\33\69\179\153\8\89\191", "\44\221\185\64"), LUAOBFUSACTOR_DECRYPT_STR_0("\37\230\90\84\71\9\226\69\90", "\19\97\135\40\63"));
v30.OnGuiDestroyed = function(v71)
	v37(LUAOBFUSACTOR_DECRYPT_STR_0("\149\127\59\41\127\63\167\95\43\14\6\12\238\111\48\41\42\52\160\123\38\50\111\53\171\79\39\41\32\40\171\88\105", "\81\206\60\83\91\79"), v71.Name);
end;
v31(LUAOBFUSACTOR_DECRYPT_STR_0("\122\164\215\117\35\198\120\141\101\174\201\112\38\205\73", "\196\46\203\176\18\79\163\45"));
v12[LUAOBFUSACTOR_DECRYPT_STR_0("\140\45\121\25\40\254\218\145\9\123\7\38\242\225\188", "\143\216\66\30\126\68\155")] = v3['InputBegan']:Connect(function(v72, v73)
	local v74 = 1580 - (1183 + 397);
	while true do
		if (v74 == (0 - 0)) then
			if v73 then
				return;
			end
			if (v72['KeyCode'] == Enum['KeyCode']['LeftControl']) then
				v30:ToggleUI();
			end
			break;
		end
	end
end);
local v43 = v40:NewTab(LUAOBFUSACTOR_DECRYPT_STR_0("\154\196\12\210\192\177", "\129\202\168\109\171\165\195\183"));
local v44 = v43:NewSection(LUAOBFUSACTOR_DECRYPT_STR_0("\18\84\54\193\219\6\166\6\89\35\217", "\134\66\56\87\184\190\116"));
v44:NewToggle(LUAOBFUSACTOR_DECRYPT_STR_0("\25\63\8\185\21\238\97\6\44\52\12\191", "\85\92\81\105\219\121\139\65"), LUAOBFUSACTOR_DECRYPT_STR_0("\216\189\81\71\112\218\189\176\69\86\104\208\240\243\71\68\112\212\189\160\64\64\121\219", "\191\157\211\48\37\28"), function(v75)
	local v76 = 0 + 0;
	while true do
		if (v76 == (1 + 0)) then
			v36((v75 and LUAOBFUSACTOR_DECRYPT_STR_0("\250\17\245\30\54\218\27", "\90\191\127\148\124")) or LUAOBFUSACTOR_DECRYPT_STR_0("\92\142\61\22\122\139\43\19", "\119\24\231\78"), (v75 and LUAOBFUSACTOR_DECRYPT_STR_0("\177\61\160\79\216\0\24\145\109\160\68\221\66\29\135\41", "\113\226\77\197\42\188\32")) or LUAOBFUSACTOR_DECRYPT_STR_0("\9\6\241\176\62\86\253\166\122\18\253\166\59\20\248\176\62", "\213\90\118\148"), 1978 - (1913 + 62));
			v37((v75 and LUAOBFUSACTOR_DECRYPT_STR_0("\104\62\177\83\73\27\43\186\87\79\87\43\176", "\45\59\78\212\54")) or LUAOBFUSACTOR_DECRYPT_STR_0("\35\70\134\142\130\110\169\249\3\87\129\135\131\42", "\144\112\54\227\235\230\78\205"));
			break;
		end
		if (v76 == (0 + 0)) then
			v17 = v75;
			v32();
			v76 = 2 - 1;
		end
	end
end);
v44:NewSlider(LUAOBFUSACTOR_DECRYPT_STR_0("\131\36\14\229\213\73\243\27\31\249\213\95", "\59\211\72\111\156\176"), LUAOBFUSACTOR_DECRYPT_STR_0("\102\136\244\109\72\134\240\57\14\147\235\40\14\151\239\44\87\130\241\109\67\136\245\40\93", "\77\46\231\131"), 2033 - (565 + 1368), 3 - 2, v19, function(v77)
	local v78 = 1661 - (1477 + 184);
	while true do
		if ((0 - 0) == v78) then
			v21 = v77;
			v32();
			v78 = 1 + 0;
		end
		if (v78 == (857 - (564 + 292))) then
			v37(LUAOBFUSACTOR_DECRYPT_STR_0("\138\88\183\89\191\70\246\83\170\81\179\68\250\71\179\84\250\64\185", "\32\218\52\214"), v77);
			break;
		end
	end
end);
v44:NewToggle(LUAOBFUSACTOR_DECRYPT_STR_0("\107\25\48\170\253\181\5\112\91\26\33", "\58\46\119\81\200\145\208\37"), LUAOBFUSACTOR_DECRYPT_STR_0("\14\130\49\174\165\184\118\40\153\35\184\166\176\118\33\153\61\188\233\173\57\60\137\34", "\86\75\236\80\204\201\221"), function(v79)
	local v80 = 0 - 0;
	while true do
		if (v80 == (0 - 0)) then
			v18 = v79;
			v34();
			v80 = 305 - (244 + 60);
		end
		if (v80 == (1 + 0)) then
			v36((v79 and LUAOBFUSACTOR_DECRYPT_STR_0("\87\79\118\135\242\142\118", "\235\18\33\23\229\158")) or LUAOBFUSACTOR_DECRYPT_STR_0("\116\179\210\186\82\182\196\191", "\219\48\218\161"), (v79 and LUAOBFUSACTOR_DECRYPT_STR_0("\206\100\113\89\155\95\239\243\116\110\9\222\65\225\230\125\121\77", "\128\132\17\28\41\187\47")) or LUAOBFUSACTOR_DECRYPT_STR_0("\43\39\11\42\29\17\61\17\63\79\65\54\15\41\92\3\62\3\62", "\61\97\82\102\90"), 479 - (41 + 435));
			v37((v79 and LUAOBFUSACTOR_DECRYPT_STR_0("\134\59\166\91\135\71\17\30\169\60\235\78\201\86\28\5\169\42", "\105\204\78\203\43\167\55\126")) or LUAOBFUSACTOR_DECRYPT_STR_0("\143\191\46\14\83\20\200\70\160\184\99\26\26\23\198\83\169\175\39", "\49\197\202\67\126\115\100\167"));
			break;
		end
	end
end);
v44:NewSlider(LUAOBFUSACTOR_DECRYPT_STR_0("\29\78\210\57\192\102\81\32\94\205", "\62\87\59\191\73\224\54"), LUAOBFUSACTOR_DECRYPT_STR_0("\207\13\237\137\239\11\253\193\167\22\242\204\167\18\246\200\254\7\232\137\237\23\247\217\244", "\169\135\98\154"), 1181 - (938 + 63), 8 + 2, v24, function(v81)
	local v82 = 1125 - (936 + 189);
	while true do
		if (v82 == (0 + 0)) then
			v27 = v81;
			v34();
			break;
		end
	end
end);
local v45 = v40:NewTab(LUAOBFUSACTOR_DECRYPT_STR_0("\255\114\40\81\237\60\218\223\100", "\168\171\23\68\52\157\83"));
local v46 = v45:NewSection(LUAOBFUSACTOR_DECRYPT_STR_0("\192\116\249\168\53\34\149\224\120\251\170", "\231\148\17\149\205\69\77"));
v46:NewToggle(LUAOBFUSACTOR_DECRYPT_STR_0("\164\174\213\254\84\235\137\168\201\250\91\191\180\162\203\254\71\240\146\179", "\159\224\199\167\155\55"), LUAOBFUSACTOR_DECRYPT_STR_0("\195\246\48\215\231\252\46\198\228\179\37\221\226\179\53\220\183\247\53\192\242\240\40\219\248\253\124\203\248\230\124\211\229\246\124\212\246\240\53\220\240", "\178\151\147\92"), function(v83)
	local v84 = 1613 - (1565 + 48);
	while true do
		if (v84 == (1 + 0)) then
			v37((v83 and LUAOBFUSACTOR_DECRYPT_STR_0("\168\244\94\55\17\88\115\131\243\77\62\82\88\127\128\248\92\61\0\88\58\137\243\77\48\30\73\126", "\26\236\157\44\82\114\44")) or LUAOBFUSACTOR_DECRYPT_STR_0("\14\39\199\94\41\58\220\84\36\47\217\27\62\43\217\94\58\33\199\79\106\42\220\72\43\44\217\94\46", "\59\74\78\181"));
			break;
		end
		if (v84 == (1138 - (782 + 356))) then
			v16 = v83;
			v36((v83 and LUAOBFUSACTOR_DECRYPT_STR_0("\0\223\91\88\191\32\213", "\211\69\177\58\58")) or LUAOBFUSACTOR_DECRYPT_STR_0("\147\236\106\244\235\199\178\225", "\171\215\133\25\149\137"), (v83 and LUAOBFUSACTOR_DECRYPT_STR_0("\197\193\32\255\236\36\245\77\239\201\62\186\251\53\240\71\241\199\32\238\175\57\239\2\238\198", "\34\129\168\82\154\143\80\156")) or LUAOBFUSACTOR_DECRYPT_STR_0("\161\187\33\14\75\90\128\138\188\50\7\8\90\140\137\183\35\4\90\90\201\140\161\115\4\78\72", "\233\229\210\83\107\40\46"), 270 - (176 + 91));
			v84 = 2 - 1;
		end
	end
end);
v46:NewSlider(LUAOBFUSACTOR_DECRYPT_STR_0("\245\71\62\211\69\229\75\33\194\4\207\65\55", "\101\161\34\82\182"), LUAOBFUSACTOR_DECRYPT_STR_0("\192\2\78\190\221\227\144\110\238\2\75\233\218\240\134\110\160\4\87\190\200\246\151\42\251\68\25\234\211\231\194\58\237\1\92\238\212\240\150\110\229\2\79\251\200\162\155\33\253", "\78\136\109\57\158\187\130\226"), 44 - 14, 1093 - (975 + 117), v28, function(v85)
	local v86 = 1875 - (157 + 1718);
	while true do
		if (v86 == (0 + 0)) then
			v29 = -v85;
			v37(LUAOBFUSACTOR_DECRYPT_STR_0("\26\54\235\244\61\43\240\254\48\62\245\177\58\54\234\229\63\49\250\244\126\44\252\229\126\43\246", "\145\94\95\153"), v85);
			break;
		end
	end
end);
local v47 = v40:NewTab(LUAOBFUSACTOR_DECRYPT_STR_0("\206\200\0\193\71\185\250\222", "\215\157\173\116\181\46"));
local v48 = v47:NewSection(LUAOBFUSACTOR_DECRYPT_STR_0("\1\188\142\255\223", "\186\85\212\235\146"));
v48:NewDropdown(LUAOBFUSACTOR_DECRYPT_STR_0("\242\136\21\245\121\247\87\215\147\86\234\49\235\85\199", "\56\162\225\118\158\89\142"), LUAOBFUSACTOR_DECRYPT_STR_0("\111\0\204\170\33\204\28\17\200\170\47\221\28\3\207\189\98\204\84\0\128\136\23\241", "\184\60\101\160\207\66"), v30.GetThemes(), function(v87)
	local v88 = 0 - 0;
	while true do
		if (v88 == (0 - 0)) then
			v30:SetTheme(v87);
			task.defer(function()
				local v98 = 1018 - (697 + 321);
				while true do
					if (v98 == (0 - 0)) then
						v36(LUAOBFUSACTOR_DECRYPT_STR_0("\5\138\121\177\52\194\95\180\48\140\123\185\53", "\220\81\226\28"), v87 .. LUAOBFUSACTOR_DECRYPT_STR_0("\83\212\146\235\230\206\22\209", "\167\115\181\226\155\138"), 5 - 2);
						v37(LUAOBFUSACTOR_DECRYPT_STR_0("\214\42\226\81\126\49\197\234\35\233\91\126\117\134\246\45", "\166\130\66\135\60\27\17"), v87);
						break;
					end
				end
			end);
			break;
		end
	end
end);
v30:Notify(LUAOBFUSACTOR_DECRYPT_STR_0("\119\95\205\118\53\87\89", "\80\36\42\174\21"), LUAOBFUSACTOR_DECRYPT_STR_0("\109\24\37\42\64\25\52\98\109\24\50\123\90\80\36\111\77\19\50\105\93\22\34\118\66\9\119\118\65\17\51\127\74\81", "\26\46\112\87"), 6 - 3);
v37(LUAOBFUSACTOR_DECRYPT_STR_0("\138\32\185\125\175\171\5\184\182\34\175\113\187\255\86\161\186\32\174\103\172\185\80\184\181\58\229", "\212\217\67\203\20\223\223\37"));
local function v49()
	local v89 = 0 + 0;
	while true do
		if (v89 == (0 - 0)) then
			v16 = false;
			v17 = false;
			v18 = false;
			if (v10 and v20) then
				v10['WalkSpeed'] = v20;
			end
			v89 = 2 - 1;
		end
		if (v89 == (1228 - (322 + 905))) then
			if (v10 and v25) then
				v10['JumpPower'] = v25;
			end
			if (v10 and v26) then
				v10['JumpHeight'] = v26;
			end
			for v99, v100 in pairs(v12) do
				if v100 then
					v100:Disconnect();
				end
			end
			table.clear(v12);
			v89 = 613 - (602 + 9);
		end
		if (v89 == (1191 - (449 + 740))) then
			if (v30 and v30['Notify'] and v14) then
				v30:Notify(LUAOBFUSACTOR_DECRYPT_STR_0("\143\131\164\221\187\137\173\214", "\178\218\237\200"), LUAOBFUSACTOR_DECRYPT_STR_0("\133\182\244\217\166\161\166\195\190\160\242\144\178\186\241\222\246\182\234\213\183\187\234\201", "\176\214\213\134"), 875 - (826 + 46));
			end
			if (v30 and v30['_Shutdown']) then
				v30:_Shutdown();
			end
			v37(LUAOBFUSACTOR_DECRYPT_STR_0("\199\174\164\221\184\66\25\225\163\186\219\169\82\92\240\237\181\216\173\87\87\248\180\248", "\57\148\205\214\180\200\54"));
			break;
		end
	end
end
v30['OnUnload'] = v49;
