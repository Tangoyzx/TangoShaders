Shader "Vacuum/SubsurfaceScattering" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _MainTex ("Main Texture", 2D) = "" {}
 _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
 _Shininess ("Shininess", Range(0.03,1)) = 0.078125
 _TransMap ("Translucency Map", 2D) = "white" {}
 _BumpMap ("Normalmap", 2D) = "bump" {}
 _TransDistortion ("Tranlucency Distortion", Range(0,0.5)) = 0.1
 _TransPower ("Tranlucency Power", Range(1,15)) = 4
 _TransScale ("Translucency Scale", Range(0,10)) = 2
}
SubShader { 
 LOD 300
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Opaque" }
Program "vp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Vector 22 [unity_Scale]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
Vector 25 [_TransMap_ST]
"3.0-!!ARBvp1.0
# 45 ALU
PARAM c[26] = { { 1 },
		state.matrix.mvp,
		program.local[5..25] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[22].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MOV R0.w, c[0].x;
MUL R1, R0.xyzz, R0.yzzx;
DP4 R2.z, R0, c[17];
DP4 R2.y, R0, c[16];
DP4 R2.x, R0, c[15];
MUL R0.w, R2, R2;
MAD R0.w, R0.x, R0.x, -R0;
DP4 R0.z, R1, c[20];
DP4 R0.y, R1, c[19];
DP4 R0.x, R1, c[18];
ADD R0.xyz, R2, R0;
MUL R1.xyz, R0.w, c[21];
ADD result.texcoord[3].xyz, R0, R1;
MOV R1.xyz, c[13];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[22].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[14];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP3 result.texcoord[2].y, R3, R1;
DP3 result.texcoord[4].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, R3, vertex.attrib[14];
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[24].xyxy, c[24];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[25], c[25].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 45 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_SHAr]
Vector 15 [unity_SHAg]
Vector 16 [unity_SHAb]
Vector 17 [unity_SHBr]
Vector 18 [unity_SHBg]
Vector 19 [unity_SHBb]
Vector 20 [unity_SHC]
Vector 21 [unity_Scale]
Vector 22 [_MainTex_ST]
Vector 23 [_BumpMap_ST]
Vector 24 [_TransMap_ST]
"vs_3_0
; 48 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c25, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c21.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mov r0.w, c25.x
mul r1, r0.xyzz, r0.yzzx
dp4 r2.z, r0, c16
dp4 r2.y, r0, c15
dp4 r2.x, r0, c14
mul r0.w, r2, r2
mad r0.w, r0.x, r0.x, -r0
dp4 r0.z, r1, c19
dp4 r0.y, r1, c18
dp4 r0.x, r1, c17
mul r1.xyz, r0.w, c20
add r0.xyz, r2, r0
add o4.xyz, r0, r1
mov r0.w, c25.x
mov r0.xyz, c12
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c21.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c13, r0
mov r0, c9
mov r1, c8
dp4 r4.y, c13, r0
dp4 r4.x, c13, r1
dp3 o3.y, r4, r2
dp3 o5.y, r2, r3
dp3 o3.z, v2, r4
dp3 o3.x, r4, v1
dp3 o5.z, v2, r3
dp3 o5.x, v1, r3
mad o1.zw, v3.xyxy, c23.xyxy, c23
mad o1.xy, v3, c22, c22.zwzw
mad o2.xy, v3, c24, c24.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 128
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
Vector 112 [_TransMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400
Vector 0 [_WorldSpaceLightPos0]
Vector 288 [unity_SHAr]
Vector 304 [unity_SHAg]
Vector 320 [unity_SHAb]
Vector 336 [unity_SHBr]
Vector 352 [unity_SHBg]
Vector 368 [unity_SHBb]
Vector 384 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecednhbpfhoohckbnhpmggpjnjbmdmeghemdabaaaaaacaaiaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcgmagaaaaeaaaabaajlabaaaafjaaaaae
egiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaabjaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacafaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaa
afaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
agaaaaaakgiocaaaaaaaaaaaagaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadiaaaaah
hcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaa
aaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaaj
hcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
eccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaa
acaaaaaafgafbaaaabaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaa
abaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaaacaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaabaaaaaa
egadbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaai
bcaabaaaacaaaaaaegiocaaaacaaaaaabcaaaaaaegaobaaaabaaaaaabbaaaaai
ccaabaaaacaaaaaaegiocaaaacaaaaaabdaaaaaaegaobaaaabaaaaaabbaaaaai
ecaabaaaacaaaaaaegiocaaaacaaaaaabeaaaaaaegaobaaaabaaaaaadiaaaaah
pcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaa
aeaaaaaaegiocaaaacaaaaaabfaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaa
aeaaaaaaegiocaaaacaaaaaabgaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaa
aeaaaaaaegiocaaaacaaaaaabhaaaaaaegaobaaaadaaaaaaaaaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaaaaaaaaa
bkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaa
aeaaaaaaegiccaaaacaaaaaabiaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 128
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
Vector 112 [_TransMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400
Vector 0 [_WorldSpaceLightPos0]
Vector 288 [unity_SHAr]
Vector 304 [unity_SHAg]
Vector 320 [unity_SHAb]
Vector 336 [unity_SHBr]
Vector 352 [unity_SHBg]
Vector 368 [unity_SHBb]
Vector 384 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_3
eefiecedolmhgejpfjnkjhgbpabadlmapacgelmeabaaaaaaamamaaaaaeaaaaaa
daaaaaaabiaeaaaaimakaaaafealaaaaebgpgodjoaadaaaaoaadaaaaaaacpopp
geadaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaafaa
adaaabaaaaaaaaaaabaaaeaaabaaaeaaaaaaaaaaacaaaaaaabaaafaaaaaaaaaa
acaabcaaahaaagaaaaaaaaaaadaaaaaaaeaaanaaaaaaaaaaadaaamaaadaabbaa
aaaaaaaaadaabaaaafaabeaaaaaaaaaaaaaaaaaaabacpoppfbaaaaafbjaaapka
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
aeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaaeaaaaamoaadaaeeja
acaaeekaacaaoekaaeaaaaaeabaaadoaadaaoejaadaaoekaadaaookaabaaaaac
aaaaapiaafaaoekaafaaaaadabaaahiaaaaaffiabfaaoekaaeaaaaaeabaaahia
beaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiabgaaoekaaaaakkiaabaaoeia
aeaaaaaeaaaaahiabhaaoekaaaaappiaaaaaoeiaaiaaaaadacaaaboaabaaoeja
aaaaoeiaabaaaaacabaaahiaacaaoejaafaaaaadacaaahiaabaanciaabaamjja
aeaaaaaeabaaahiaabaamjiaabaancjaacaaoeibafaaaaadabaaahiaabaaoeia
abaappjaaiaaaaadacaaacoaabaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoeja
aaaaoeiaabaaaaacaaaaahiaaeaaoekaafaaaaadacaaahiaaaaaffiabfaaoeka
aeaaaaaeaaaaaliabeaakekaaaaaaaiaacaakeiaaeaaaaaeaaaaahiabgaaoeka
aaaakkiaaaaapeiaacaaaaadaaaaahiaaaaaoeiabhaaoekaaeaaaaaeaaaaahia
aaaaoeiabiaappkaaaaaoejbaiaaaaadaeaaaboaabaaoejaaaaaoeiaaiaaaaad
aeaaacoaabaaoeiaaaaaoeiaaiaaaaadaeaaaeoaacaaoejaaaaaoeiaafaaaaad
aaaaahiaacaaoejabiaappkaafaaaaadabaaahiaaaaaffiabcaaoekaaeaaaaae
aaaaaliabbaakekaaaaaaaiaabaakeiaaeaaaaaeaaaaahiabdaaoekaaaaakkia
aaaapeiaabaaaaacaaaaaiiabjaaaakaajaaaaadabaaabiaagaaoekaaaaaoeia
ajaaaaadabaaaciaahaaoekaaaaaoeiaajaaaaadabaaaeiaaiaaoekaaaaaoeia
afaaaaadacaaapiaaaaacjiaaaaakeiaajaaaaadadaaabiaajaaoekaacaaoeia
ajaaaaadadaaaciaakaaoekaacaaoeiaajaaaaadadaaaeiaalaaoekaacaaoeia
acaaaaadabaaahiaabaaoeiaadaaoeiaafaaaaadaaaaaciaaaaaffiaaaaaffia
aeaaaaaeaaaaabiaaaaaaaiaaaaaaaiaaaaaffibaeaaaaaeadaaahoaamaaoeka
aaaaaaiaabaaoeiaafaaaaadaaaaapiaaaaaffjaaoaaoekaaeaaaaaeaaaaapia
anaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaapaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiabaaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcgmagaaaa
eaaaabaajlabaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabjaaaaaafjaaaaaeegiocaaa
adaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
afaaaaaaogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
adaaaaaaagiecaaaaaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaadcaaaaal
dccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaa
aaaaaaaaahaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaa
acaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaa
egacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaa
abaaaaaaegaibaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
aoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaaficaabaaaabaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaabcaaaaaa
egaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaabdaaaaaa
egaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaabeaaaaaa
egaobaaaabaaaaaadiaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaa
abaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaaacaaaaaabfaaaaaaegaobaaa
adaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaaacaaaaaabgaaaaaaegaobaaa
adaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaaacaaaaaabhaaaaaaegaobaaa
adaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaa
diaaaaahicaabaaaaaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaak
icaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaa
aaaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaacaaaaaabiaaaaaapgapbaaa
aaaaaaaaegacbaaaacaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
adaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaa
adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaafaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Vector 23 [unity_Scale]
Vector 24 [_MainTex_ST]
Vector 25 [_BumpMap_ST]
Vector 26 [_TransMap_ST]
"3.0-!!ARBvp1.0
# 50 ALU
PARAM c[27] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..26] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[23].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MOV R0.w, c[0].x;
MUL R1, R0.xyzz, R0.yzzx;
DP4 R2.z, R0, c[18];
DP4 R2.y, R0, c[17];
DP4 R2.x, R0, c[16];
MUL R0.w, R2, R2;
MAD R0.w, R0.x, R0.x, -R0;
DP4 R0.z, R1, c[21];
DP4 R0.y, R1, c[20];
DP4 R0.x, R1, c[19];
ADD R0.xyz, R2, R0;
MUL R1.xyz, R0.w, c[22];
ADD result.texcoord[3].xyz, R0, R1;
MOV R1.xyz, c[13];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[23].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[15];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
DP3 result.texcoord[2].y, R3, R1;
DP3 result.texcoord[4].y, R1, R2;
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, R3, vertex.attrib[14];
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
ADD result.texcoord[5].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[5].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[25].xyxy, c[25];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[24], c[24].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[26], c[26].zwzw;
END
# 50 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Vector 23 [unity_Scale]
Vector 24 [_MainTex_ST]
Vector 25 [_BumpMap_ST]
Vector 26 [_TransMap_ST]
"vs_3_0
; 53 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c27, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c23.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mov r0.w, c27.x
mul r1, r0.xyzz, r0.yzzx
dp4 r2.z, r0, c18
dp4 r2.y, r0, c17
dp4 r2.x, r0, c16
mul r0.w, r2, r2
mad r0.w, r0.x, r0.x, -r0
dp4 r0.z, r1, c21
dp4 r0.y, r1, c20
dp4 r0.x, r1, c19
mul r1.xyz, r0.w, c22
add r0.xyz, r2, r0
add o4.xyz, r0, r1
mov r0.w, c27.x
mov r0.xyz, c12
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c23.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c15, r0
mov r0, c9
dp4 r4.y, c15, r0
mov r1, c8
dp4 r4.x, c15, r1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c27.y
mul r1.y, r1, c13.x
dp3 o3.y, r4, r2
dp3 o5.y, r2, r3
dp3 o3.z, v2, r4
dp3 o3.x, r4, v1
dp3 o5.z, v2, r3
dp3 o5.x, v1, r3
mad o6.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o6.zw, r0
mad o1.zw, v3.xyxy, c25.xyxy, c25
mad o1.xy, v3, c24, c24.zwzw
mad o2.xy, v3, c26, c26.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 192
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
Vector 176 [_TransMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 400
Vector 0 [_WorldSpaceLightPos0]
Vector 288 [unity_SHAr]
Vector 304 [unity_SHAg]
Vector 320 [unity_SHAb]
Vector 336 [unity_SHBr]
Vector 352 [unity_SHBg]
Vector 368 [unity_SHBb]
Vector 384 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedofnmghaaejndpjmagepfjdoffacmpkalabaaaaaanaaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcaeahaaaaeaaaabaambabaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
bjaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaac
agaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaa
aaaaaaaaakaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaahhcaabaaaabaaaaaa
jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaa
acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaa
fgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
acaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
acaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
adaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaabaaaaaah
cccabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaa
adaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaadaaaaaa
egbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaadaaaaaafgafbaaa
acaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaacaaaaaaegiicaaa
adaaaaaaamaaaaaaagaabaaaacaaaaaaegaibaaaadaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaacaaaaaaegadbaaaacaaaaaa
dgaaaaaficaabaaaacaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaadaaaaaa
egiocaaaacaaaaaabcaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaa
egiocaaaacaaaaaabdaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaa
egiocaaaacaaaaaabeaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaaeaaaaaa
jgacbaaaacaaaaaaegakbaaaacaaaaaabbaaaaaibcaabaaaafaaaaaaegiocaaa
acaaaaaabfaaaaaaegaobaaaaeaaaaaabbaaaaaiccaabaaaafaaaaaaegiocaaa
acaaaaaabgaaaaaaegaobaaaaeaaaaaabbaaaaaiecaabaaaafaaaaaaegiocaaa
acaaaaaabhaaaaaaegaobaaaaeaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaa
adaaaaaaegacbaaaafaaaaaadiaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaa
bkaabaaaacaaaaaadcaaaaakicaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaa
acaaaaaadkaabaiaebaaaaaaabaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaa
acaaaaaabiaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaadiaaaaajhcaabaaa
acaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaa
egacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaa
egacbaaaacaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaa
egacbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahcccabaaaafaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
bccabaaaafaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaa
afaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaagaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaagaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_4LightPosX0]
Vector 16 [unity_4LightPosY0]
Vector 17 [unity_4LightPosZ0]
Vector 18 [unity_4LightAtten0]
Vector 19 [unity_LightColor0]
Vector 20 [unity_LightColor1]
Vector 21 [unity_LightColor2]
Vector 22 [unity_LightColor3]
Vector 23 [unity_SHAr]
Vector 24 [unity_SHAg]
Vector 25 [unity_SHAb]
Vector 26 [unity_SHBr]
Vector 27 [unity_SHBg]
Vector 28 [unity_SHBb]
Vector 29 [unity_SHC]
Vector 30 [unity_Scale]
Vector 31 [_MainTex_ST]
Vector 32 [_BumpMap_ST]
Vector 33 [_TransMap_ST]
"3.0-!!ARBvp1.0
# 76 ALU
PARAM c[34] = { { 1, 0 },
		state.matrix.mvp,
		program.local[5..33] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[30].w;
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[16];
DP3 R3.w, R3, c[6];
DP3 R4.x, R3, c[5];
DP3 R3.x, R3, c[7];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[15];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MAD R2, R4.x, R0, R2;
MOV R4.w, c[0].x;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[17];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[18];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[20];
MAD R1.xyz, R0.x, c[19], R1;
MAD R0.xyz, R0.z, c[21], R1;
MAD R1.xyz, R0.w, c[22], R0;
MUL R0, R4.xyzz, R4.yzzx;
MUL R1.w, R3, R3;
DP4 R3.z, R0, c[28];
DP4 R3.y, R0, c[27];
DP4 R3.x, R0, c[26];
MAD R1.w, R4.x, R4.x, -R1;
MUL R0.xyz, R1.w, c[29];
MOV R1.w, c[0].x;
DP4 R2.z, R4, c[25];
DP4 R2.y, R4, c[24];
DP4 R2.x, R4, c[23];
ADD R2.xyz, R2, R3;
ADD R0.xyz, R2, R0;
ADD result.texcoord[3].xyz, R0, R1;
MOV R1.xyz, c[13];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[30].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R1, c[14];
MUL R0.xyz, R0, vertex.attrib[14].w;
DP4 R3.z, R1, c[11];
DP4 R3.y, R1, c[10];
DP4 R3.x, R1, c[9];
DP3 result.texcoord[2].y, R3, R0;
DP3 result.texcoord[4].y, R0, R2;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, R3, vertex.attrib[14];
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[32].xyxy, c[32];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[31], c[31].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[33], c[33].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 76 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 17 [unity_4LightAtten0]
Vector 18 [unity_LightColor0]
Vector 19 [unity_LightColor1]
Vector 20 [unity_LightColor2]
Vector 21 [unity_LightColor3]
Vector 22 [unity_SHAr]
Vector 23 [unity_SHAg]
Vector 24 [unity_SHAb]
Vector 25 [unity_SHBr]
Vector 26 [unity_SHBg]
Vector 27 [unity_SHBb]
Vector 28 [unity_SHC]
Vector 29 [unity_Scale]
Vector 30 [_MainTex_ST]
Vector 31 [_BumpMap_ST]
Vector 32 [_TransMap_ST]
"vs_3_0
; 79 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c33, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c29.w
dp4 r0.x, v0, c5
add r1, -r0.x, c15
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c14
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c33.x
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c16
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c17
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c33.x
dp4 r2.z, r4, c24
dp4 r2.y, r4, c23
dp4 r2.x, r4, c22
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c33.y
mul r0, r0, r1
mul r1.xyz, r0.y, c19
mad r1.xyz, r0.x, c18, r1
mad r0.xyz, r0.z, c20, r1
mad r1.xyz, r0.w, c21, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r3.z, r0, c27
dp4 r3.y, r0, c26
dp4 r3.x, r0, c25
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c28
add r2.xyz, r2, r3
add r0.xyz, r2, r0
add o4.xyz, r0, r1
mov r1.w, c33.x
mov r1.xyz, c12
dp4 r0.z, r1, c10
dp4 r0.y, r1, c9
dp4 r0.x, r1, c8
mad r3.xyz, r0, c29.w, -v0
mov r1.xyz, v1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r1.yzxw
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c13, r0
mov r1, c9
mov r0, c8
dp4 r4.y, c13, r1
dp4 r4.x, c13, r0
dp3 o3.y, r4, r2
dp3 o5.y, r2, r3
dp3 o3.z, v2, r4
dp3 o3.x, r4, v1
dp3 o5.z, v2, r3
dp3 o5.x, v1, r3
mad o1.zw, v3.xyxy, c31.xyxy, c31
mad o1.xy, v3, c30, c30.zwzw
mad o2.xy, v3, c32, c32.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 128
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
Vector 112 [_TransMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400
Vector 0 [_WorldSpaceLightPos0]
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 288 [unity_SHAr]
Vector 304 [unity_SHAg]
Vector 320 [unity_SHAb]
Vector 336 [unity_SHBr]
Vector 352 [unity_SHBg]
Vector 368 [unity_SHBb]
Vector 384 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedoamfgdjkeocogmfgpjkemmoplcmmcegoabaaaaaahaalaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefclmajaaaaeaaaabaagpacaaaafjaaaaae
egiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaabjaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacahaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaa
afaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
agaaaaaakgiocaaaaaaaaaaaagaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadiaaaaah
hcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaa
aaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaaj
hcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
eccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadgaaaaaficaabaaa
abaaaaaaabeaaaaaaaaaiadpdiaaaaaihcaabaaaacaaaaaaegbcbaaaacaaaaaa
pgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaadaaaaaafgafbaaaacaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaacaaaaaaegiicaaaadaaaaaa
amaaaaaaagaabaaaacaaaaaaegaibaaaadaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaaoaaaaaakgakbaaaacaaaaaaegadbaaaacaaaaaabbaaaaai
bcaabaaaacaaaaaaegiocaaaacaaaaaabcaaaaaaegaobaaaabaaaaaabbaaaaai
ccaabaaaacaaaaaaegiocaaaacaaaaaabdaaaaaaegaobaaaabaaaaaabbaaaaai
ecaabaaaacaaaaaaegiocaaaacaaaaaabeaaaaaaegaobaaaabaaaaaadiaaaaah
pcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaa
aeaaaaaaegiocaaaacaaaaaabfaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaa
aeaaaaaaegiocaaaacaaaaaabgaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaa
aeaaaaaaegiocaaaacaaaaaabhaaaaaaegaobaaaadaaaaaaaaaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaaaaaaaaa
bkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaacaaaaaabiaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaa
diaaaaaihcaabaaaadaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaadaaaaaaaaaaaaajpcaabaaa
aeaaaaaafgafbaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaadaaaaaadiaaaaah
pcaabaaaafaaaaaafgafbaaaabaaaaaaegaobaaaaeaaaaaadiaaaaahpcaabaaa
aeaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaaaaaaaaajpcaabaaaagaaaaaa
agaabaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaajpcaabaaa
adaaaaaakgakbaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaaeaaaaaadcaaaaaj
pcaabaaaafaaaaaaegaobaaaagaaaaaaagaabaaaabaaaaaaegaobaaaafaaaaaa
dcaaaaajpcaabaaaabaaaaaaegaobaaaadaaaaaakgakbaaaabaaaaaaegaobaaa
afaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaagaaaaaaegaobaaaagaaaaaa
egaobaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaa
adaaaaaaegaobaaaaeaaaaaaeeaaaaafpcaabaaaaeaaaaaaegaobaaaadaaaaaa
dcaaaaanpcaabaaaadaaaaaaegaobaaaadaaaaaaegiocaaaacaaaaaaafaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaadaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaadaaaaaadiaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaaeaaaaaadeaaaaakpcaabaaa
abaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaadaaaaaaegaobaaaabaaaaaadiaaaaai
hcaabaaaadaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaaahaaaaaadcaaaaak
hcaabaaaadaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaaabaaaaaaegacbaaa
adaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaiaaaaaakgakbaaa
abaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
ajaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahhccabaaaaeaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaa
afaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaafaaaaaa
egbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaaegbcbaaa
acaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 128
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
Vector 112 [_TransMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400
Vector 0 [_WorldSpaceLightPos0]
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 288 [unity_SHAr]
Vector 304 [unity_SHAg]
Vector 320 [unity_SHAb]
Vector 336 [unity_SHBr]
Vector 352 [unity_SHBg]
Vector 368 [unity_SHBb]
Vector 384 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_3
eefiecedjckacpckndbccjnlncgfbgmcppnncchfabaaaaaafebbaaaaaeaaaaaa
daaaaaaabaagaaaaneapaaaajmbaaaaaebgpgodjniafaaaaniafaaaaaaacpopp
fmafaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaafaa
adaaabaaaaaaaaaaabaaaeaaabaaaeaaaaaaaaaaacaaaaaaabaaafaaaaaaaaaa
acaaacaaaiaaagaaaaaaaaaaacaabcaaahaaaoaaaaaaaaaaadaaaaaaaeaabfaa
aaaaaaaaadaaamaaajaabjaaaaaaaaaaaaaaaaaaabacpoppfbaaaaafccaaapka
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
aeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaaeaaaaamoaadaaeeja
acaaeekaacaaoekaaeaaaaaeabaaadoaadaaoejaadaaoekaadaaookaabaaaaac
aaaaapiaafaaoekaafaaaaadabaaahiaaaaaffiaboaaoekaaeaaaaaeabaaahia
bnaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiabpaaoekaaaaakkiaabaaoeia
aeaaaaaeaaaaahiacaaaoekaaaaappiaaaaaoeiaaiaaaaadacaaaboaabaaoeja
aaaaoeiaabaaaaacabaaahiaacaaoejaafaaaaadacaaahiaabaanciaabaamjja
aeaaaaaeabaaahiaabaamjiaabaancjaacaaoeibafaaaaadabaaahiaabaaoeia
abaappjaaiaaaaadacaaacoaabaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoeja
aaaaoeiaabaaaaacaaaaahiaaeaaoekaafaaaaadacaaahiaaaaaffiaboaaoeka
aeaaaaaeaaaaaliabnaakekaaaaaaaiaacaakeiaaeaaaaaeaaaaahiabpaaoeka
aaaakkiaaaaapeiaacaaaaadaaaaahiaaaaaoeiacaaaoekaaeaaaaaeaaaaahia
aaaaoeiacbaappkaaaaaoejbaiaaaaadaeaaaboaabaaoejaaaaaoeiaaiaaaaad
aeaaacoaabaaoeiaaaaaoeiaaiaaaaadaeaaaeoaacaaoejaaaaaoeiaafaaaaad
aaaaahiaaaaaffjabkaaoekaaeaaaaaeaaaaahiabjaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaahiablaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiabmaaoeka
aaaappjaaaaaoeiaacaaaaadabaaapiaaaaakkibaiaaoekaacaaaaadacaaapia
aaaaaaibagaaoekaacaaaaadaaaaapiaaaaaffibahaaoekaafaaaaadadaaahia
acaaoejacbaappkaafaaaaadaeaaahiaadaaffiabkaaoekaaeaaaaaeadaaalia
bjaakekaadaaaaiaaeaakeiaaeaaaaaeadaaahiablaaoekaadaakkiaadaapeia
afaaaaadaeaaapiaaaaaoeiaadaaffiaafaaaaadaaaaapiaaaaaoeiaaaaaoeia
aeaaaaaeaaaaapiaacaaoeiaacaaoeiaaaaaoeiaaeaaaaaeacaaapiaacaaoeia
adaaaaiaaeaaoeiaaeaaaaaeacaaapiaabaaoeiaadaakkiaacaaoeiaaeaaaaae
aaaaapiaabaaoeiaabaaoeiaaaaaoeiaahaaaaacabaaabiaaaaaaaiaahaaaaac
abaaaciaaaaaffiaahaaaaacabaaaeiaaaaakkiaahaaaaacabaaaiiaaaaappia
abaaaaacaeaaabiaccaaaakaaeaaaaaeaaaaapiaaaaaoeiaajaaoekaaeaaaaia
afaaaaadabaaapiaabaaoeiaacaaoeiaalaaaaadabaaapiaabaaoeiaccaaffka
agaaaaacacaaabiaaaaaaaiaagaaaaacacaaaciaaaaaffiaagaaaaacacaaaeia
aaaakkiaagaaaaacacaaaiiaaaaappiaafaaaaadaaaaapiaabaaoeiaacaaoeia
afaaaaadabaaahiaaaaaffiaalaaoekaaeaaaaaeabaaahiaakaaoekaaaaaaaia
abaaoeiaaeaaaaaeaaaaahiaamaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahia
anaaoekaaaaappiaaaaaoeiaabaaaaacadaaaiiaccaaaakaajaaaaadabaaabia
aoaaoekaadaaoeiaajaaaaadabaaaciaapaaoekaadaaoeiaajaaaaadabaaaeia
baaaoekaadaaoeiaafaaaaadacaaapiaadaacjiaadaakeiaajaaaaadaeaaabia
bbaaoekaacaaoeiaajaaaaadaeaaaciabcaaoekaacaaoeiaajaaaaadaeaaaeia
bdaaoekaacaaoeiaacaaaaadabaaahiaabaaoeiaaeaaoeiaafaaaaadaaaaaiia
adaaffiaadaaffiaaeaaaaaeaaaaaiiaadaaaaiaadaaaaiaaaaappibaeaaaaae
abaaahiabeaaoekaaaaappiaabaaoeiaacaaaaadadaaahoaaaaaoeiaabaaoeia
afaaaaadaaaaapiaaaaaffjabgaaoekaaeaaaaaeaaaaapiabfaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiabhaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
biaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiappppaaaafdeieefclmajaaaaeaaaabaagpacaaaa
fjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaabjaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
ahaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaa
aaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaa
diaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadgaaaaaf
icaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaihcaabaaaacaaaaaaegbcbaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaadaaaaaafgafbaaa
acaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaacaaaaaaegiicaaa
adaaaaaaamaaaaaaagaabaaaacaaaaaaegaibaaaadaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaacaaaaaaegadbaaaacaaaaaa
bbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaabcaaaaaaegaobaaaabaaaaaa
bbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaabdaaaaaaegaobaaaabaaaaaa
bbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaabeaaaaaaegaobaaaabaaaaaa
diaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaai
bcaabaaaaeaaaaaaegiocaaaacaaaaaabfaaaaaaegaobaaaadaaaaaabbaaaaai
ccaabaaaaeaaaaaaegiocaaaacaaaaaabgaaaaaaegaobaaaadaaaaaabbaaaaai
ecaabaaaaeaaaaaaegiocaaaacaaaaaabhaaaaaaegaobaaaadaaaaaaaaaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaa
aaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaacaaaaaabiaaaaaapgapbaaaaaaaaaaaegacbaaa
acaaaaaadiaaaaaihcaabaaaadaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaadaaaaaaaaaaaaaj
pcaabaaaaeaaaaaafgafbaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaadaaaaaa
diaaaaahpcaabaaaafaaaaaafgafbaaaabaaaaaaegaobaaaaeaaaaaadiaaaaah
pcaabaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaaaaaaaaajpcaabaaa
agaaaaaaagaabaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaaj
pcaabaaaadaaaaaakgakbaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaaeaaaaaa
dcaaaaajpcaabaaaafaaaaaaegaobaaaagaaaaaaagaabaaaabaaaaaaegaobaaa
afaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaaadaaaaaakgakbaaaabaaaaaa
egaobaaaafaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaagaaaaaaegaobaaa
agaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaadaaaaaa
egaobaaaadaaaaaaegaobaaaaeaaaaaaeeaaaaafpcaabaaaaeaaaaaaegaobaaa
adaaaaaadcaaaaanpcaabaaaadaaaaaaegaobaaaadaaaaaaegiocaaaacaaaaaa
afaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaa
adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaadaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaaeaaaaaadeaaaaak
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaadaaaaaaegaobaaaabaaaaaa
diaaaaaihcaabaaaadaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaaahaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaaabaaaaaa
egacbaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaiaaaaaa
kgakbaaaabaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaajaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahhccabaaa
aeaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaa
abaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
cccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
afaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeo
ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 19 [unity_4LightAtten0]
Vector 20 [unity_LightColor0]
Vector 21 [unity_LightColor1]
Vector 22 [unity_LightColor2]
Vector 23 [unity_LightColor3]
Vector 24 [unity_SHAr]
Vector 25 [unity_SHAg]
Vector 26 [unity_SHAb]
Vector 27 [unity_SHBr]
Vector 28 [unity_SHBg]
Vector 29 [unity_SHBb]
Vector 30 [unity_SHC]
Vector 31 [unity_Scale]
Vector 32 [_MainTex_ST]
Vector 33 [_BumpMap_ST]
Vector 34 [_TransMap_ST]
"3.0-!!ARBvp1.0
# 81 ALU
PARAM c[35] = { { 1, 0, 0.5 },
		state.matrix.mvp,
		program.local[5..34] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[31].w;
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[17];
DP3 R3.w, R3, c[6];
DP3 R4.x, R3, c[5];
DP3 R3.x, R3, c[7];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[16];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MAD R2, R4.x, R0, R2;
MOV R4.w, c[0].x;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[18];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[19];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[21];
MAD R1.xyz, R0.x, c[20], R1;
MAD R0.xyz, R0.z, c[22], R1;
MAD R1.xyz, R0.w, c[23], R0;
MUL R0, R4.xyzz, R4.yzzx;
MUL R1.w, R3, R3;
DP4 R3.z, R0, c[29];
DP4 R3.y, R0, c[28];
DP4 R3.x, R0, c[27];
MAD R1.w, R4.x, R4.x, -R1;
MUL R0.xyz, R1.w, c[30];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R4, c[26];
DP4 R2.y, R4, c[25];
DP4 R2.x, R4, c[24];
ADD R2.xyz, R2, R3;
ADD R0.xyz, R2, R0;
ADD result.texcoord[3].xyz, R0, R1;
MOV R1.xyz, c[13];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[31].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R1, c[15];
MUL R0.xyz, R0, vertex.attrib[14].w;
DP4 R3.z, R1, c[11];
DP4 R3.y, R1, c[10];
DP4 R3.x, R1, c[9];
DP3 result.texcoord[2].y, R3, R0;
DP3 result.texcoord[4].y, R0, R2;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].z;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, R3, vertex.attrib[14];
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
ADD result.texcoord[5].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[5].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[33].xyxy, c[33];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[32], c[32].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[34], c[34].zwzw;
END
# 81 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 19 [unity_4LightAtten0]
Vector 20 [unity_LightColor0]
Vector 21 [unity_LightColor1]
Vector 22 [unity_LightColor2]
Vector 23 [unity_LightColor3]
Vector 24 [unity_SHAr]
Vector 25 [unity_SHAg]
Vector 26 [unity_SHAb]
Vector 27 [unity_SHBr]
Vector 28 [unity_SHBg]
Vector 29 [unity_SHBb]
Vector 30 [unity_SHC]
Vector 31 [unity_Scale]
Vector 32 [_MainTex_ST]
Vector 33 [_BumpMap_ST]
Vector 34 [_TransMap_ST]
"vs_3_0
; 84 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c35, 1.00000000, 0.00000000, 0.50000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c31.w
dp4 r0.x, v0, c5
add r1, -r0.x, c17
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c16
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c35.x
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c18
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c19
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c35.x
dp4 r2.z, r4, c26
dp4 r2.y, r4, c25
dp4 r2.x, r4, c24
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c35.y
mul r0, r0, r1
mul r1.xyz, r0.y, c21
mad r1.xyz, r0.x, c20, r1
mad r0.xyz, r0.z, c22, r1
mad r1.xyz, r0.w, c23, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r3.z, r0, c29
dp4 r3.y, r0, c28
dp4 r3.x, r0, c27
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c30
add r2.xyz, r2, r3
add r0.xyz, r2, r0
add o4.xyz, r0, r1
mov r1.w, c35.x
mov r1.xyz, c12
dp4 r0.z, r1, c10
dp4 r0.y, r1, c9
dp4 r0.x, r1, c8
mad r3.xyz, r0, c31.w, -v0
mov r1.xyz, v1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r1.yzxw
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c15, r0
mov r0, c8
dp4 r4.x, c15, r0
mov r1, c9
dp4 r4.y, c15, r1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c35.z
mul r1.y, r1, c13.x
dp3 o3.y, r4, r2
dp3 o5.y, r2, r3
dp3 o3.z, v2, r4
dp3 o3.x, r4, v1
dp3 o5.z, v2, r3
dp3 o5.x, v1, r3
mad o6.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o6.zw, r0
mad o1.zw, v3.xyxy, c33.xyxy, c33
mad o1.xy, v3, c32, c32.zwzw
mad o2.xy, v3, c34, c34.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 192
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
Vector 176 [_TransMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 400
Vector 0 [_WorldSpaceLightPos0]
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 288 [unity_SHAr]
Vector 304 [unity_SHAg]
Vector 320 [unity_SHAb]
Vector 336 [unity_SHBr]
Vector 352 [unity_SHBg]
Vector 368 [unity_SHBb]
Vector 384 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefieceddnpmicbbkbhogjbccmcglcimnlpcgkfnabaaaaaacaamaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcfeakaaaaeaaaabaajfacaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
bjaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaac
aiaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaa
aaaaaaaaakaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaahhcaabaaaabaaaaaa
jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaa
acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaa
fgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
acaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
acaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
adaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaabaaaaaah
cccabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaa
adaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaadaaaaaa
egbcbaaaacaaaaaaegacbaaaacaaaaaadgaaaaaficaabaaaacaaaaaaabeaaaaa
aaaaiadpdiaaaaaihcaabaaaadaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaadiaaaaaihcaabaaaaeaaaaaafgafbaaaadaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaaklcaabaaaadaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaa
adaaaaaaegaibaaaaeaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaa
aoaaaaaakgakbaaaadaaaaaaegadbaaaadaaaaaabbaaaaaibcaabaaaadaaaaaa
egiocaaaacaaaaaabcaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaa
egiocaaaacaaaaaabdaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaa
egiocaaaacaaaaaabeaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaaeaaaaaa
jgacbaaaacaaaaaaegakbaaaacaaaaaabbaaaaaibcaabaaaafaaaaaaegiocaaa
acaaaaaabfaaaaaaegaobaaaaeaaaaaabbaaaaaiccaabaaaafaaaaaaegiocaaa
acaaaaaabgaaaaaaegaobaaaaeaaaaaabbaaaaaiecaabaaaafaaaaaaegiocaaa
acaaaaaabhaaaaaaegaobaaaaeaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaa
adaaaaaaegacbaaaafaaaaaadiaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaa
bkaabaaaacaaaaaadcaaaaakicaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaa
acaaaaaadkaabaiaebaaaaaaabaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaa
acaaaaaabiaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaadiaaaaaihcaabaaa
aeaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
aeaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaeaaaaaa
dcaaaaakhcaabaaaaeaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaeaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaeaaaaaaaaaaaaajpcaabaaaafaaaaaafgafbaia
ebaaaaaaaeaaaaaaegiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaaagaaaaaa
fgafbaaaacaaaaaaegaobaaaafaaaaaadiaaaaahpcaabaaaafaaaaaaegaobaaa
afaaaaaaegaobaaaafaaaaaaaaaaaaajpcaabaaaahaaaaaaagaabaiaebaaaaaa
aeaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaajpcaabaaaaeaaaaaakgakbaia
ebaaaaaaaeaaaaaaegiocaaaacaaaaaaaeaaaaaadcaaaaajpcaabaaaagaaaaaa
egaobaaaahaaaaaaagaabaaaacaaaaaaegaobaaaagaaaaaadcaaaaajpcaabaaa
acaaaaaaegaobaaaaeaaaaaakgakbaaaacaaaaaaegaobaaaagaaaaaadcaaaaaj
pcaabaaaafaaaaaaegaobaaaahaaaaaaegaobaaaahaaaaaaegaobaaaafaaaaaa
dcaaaaajpcaabaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaa
afaaaaaaeeaaaaafpcaabaaaafaaaaaaegaobaaaaeaaaaaadcaaaaanpcaabaaa
aeaaaaaaegaobaaaaeaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaaeaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegaobaaaaeaaaaaadiaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaafaaaaaadeaaaaakpcaabaaaacaaaaaaegaobaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaa
acaaaaaaegaobaaaaeaaaaaaegaobaaaacaaaaaadiaaaaaihcaabaaaaeaaaaaa
fgafbaaaacaaaaaaegiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaaaeaaaaaa
egiccaaaacaaaaaaagaaaaaaagaabaaaacaaaaaaegacbaaaaeaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaacaaaaaaaiaaaaaakgakbaaaacaaaaaaegacbaaa
aeaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaajaaaaaapgapbaaa
acaaaaaaegacbaaaacaaaaaaaaaaaaahhccabaaaaeaaaaaaegacbaaaacaaaaaa
egacbaaaadaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaabaaaaaaaeaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaa
acaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
acaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaadaaaaaa
bdaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaaabaaaaaa
egacbaaaacaaaaaabaaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaaegacbaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaagaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaagaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_TransDistortion]
Float 5 [_TransPower]
Float 6 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 44 ALU, 3 TEX
PARAM c[8] = { program.local[0..6],
		{ 2, 1, 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R2.xy, R0.wyzw, c[7].x, -c[7].y;
MUL R0.x, R2.y, R2.y;
MAD R0.x, -R2, R2, -R0;
DP3 R0.y, fragment.texcoord[4], fragment.texcoord[4];
RSQ R0.y, R0.y;
MUL R1.xyz, R0.y, fragment.texcoord[4];
ADD R3.xyz, fragment.texcoord[2], R1;
DP3 R0.w, R3, R3;
RSQ R0.w, R0.w;
ADD R0.x, R0, c[7].y;
RSQ R0.x, R0.x;
RCP R2.z, R0.x;
MAD R0.xyz, R2, c[4].x, fragment.texcoord[2];
DP3_SAT R0.x, R1, -R0;
MOV R1.xy, c[7].xwzw;
DP3 R2.w, R2, fragment.texcoord[2];
MUL R3.xyz, R0.w, R3;
POW R1.z, R0.x, c[5].x;
DP3 R0.x, R2, R3;
MAX R1.w, R0.x, c[7].z;
MOV R0, c[1];
MUL R1.y, R1, c[3].x;
POW R1.w, R1.w, R1.y;
MUL R1.y, R1.z, c[6].x;
ADD R3.xyz, R1.y, c[2];
MUL R0.xyz, R0, c[0];
MUL R0.xyz, R0, R1.w;
MUL R4.xyz, R0, c[7].x;
MUL R1.xyz, R1.x, c[0];
MUL R0.w, R0, c[0];
TEX R0.xyz, fragment.texcoord[1], texture[2], 2D;
MUL R1.xyz, R1, R3;
MUL R1.xyz, R1, R0;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[2];
MUL R2.xyz, R0, R1;
MAX R2.w, R2, c[7].z;
MUL R1.xyz, R0, c[0];
MUL R1.xyz, R1, R2.w;
MAD R1.xyz, R1, c[7].x, R2;
ADD R1.xyz, R1, R4;
MAD result.color.xyz, R0, fragment.texcoord[3], R1;
MAD result.color.w, R1, R0, c[2];
END
# 44 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_TransDistortion]
Float 5 [_TransPower]
Float 6 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
"ps_3_0
; 49 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c7, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c8, 128.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c7.x, c7.y
mul_pp r0.x, r1.y, r1.y
mad_pp r0.x, -r1, r1, -r0
add_pp r0.x, r0, c7.z
rsq_pp r0.x, r0.x
rcp_pp r1.z, r0.x
dp3_pp r0.y, v4, v4
rsq_pp r0.x, r0.y
mad r2.xyz, r1, c4.x, v2
mul_pp r0.xyz, r0.x, v4
dp3_pp_sat r1.w, r0, -r2
add_pp r2.xyz, v2, r0
pow r0, r1.w, c5.x
dp3_pp r0.y, r2, r2
mov r1.w, r0.x
rsq_pp r0.y, r0.y
mul_pp r0.xyz, r0.y, r2
dp3_pp r0.x, r1, r0
mov_pp r0.w, c3.x
mul_pp r2.y, c8.x, r0.w
max_pp r2.x, r0, c7.w
pow r0, r2.x, r2.y
mul r0.y, r1.w, c6.x
dp3_pp r1.x, r1, v2
mov_pp r2.xyz, c0
mov r0.w, r0.x
mul_pp r2.xyz, c1, r2
mul r4.xyz, r2, r0.w
add r3.xyz, r0.y, c2
mov_pp r2.xyz, c0
mul_pp r2.xyz, c7.x, r2
max_pp r1.w, r1.x, c7
texld r0.xyz, v1, s2
mul r2.xyz, r2, r3
mul r2.xyz, r2, r0
texld r0.xyz, v0, s0
mul r0.xyz, r0, c2
mul_pp r1.xyz, r0, c0
mul_pp r1.xyz, r1, r1.w
mul_pp r2.xyz, r0, r2
mad_pp r1.xyz, r1, c7.x, r2
mul r2.xyz, r4, c7.x
mov_pp r1.w, c0
add_pp r1.xyz, r1, r2
mul_pp r1.w, c1, r1
mad_pp oC0.xyz, r0, v3, r1
mad oC0.w, r0, r1, c2
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_TransMap] 2D 1
ConstBuffer "$Globals" 128
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 64 [_Shininess]
Float 68 [_TransDistortion]
Float 72 [_TransPower]
Float 76 [_TransScale]
BindCB  "$Globals" 0
"ps_4_0
eefiecedhkpndmokgconeijochedfindmocelodjabaaaaaaomagaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmmafaaaa
eaaaaaaahdabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaaagaabaaaaaaaaaaa
agbjbaaaafaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaafaaaaaaagaabaaa
aaaaaaaaegbcbaaaadaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaa
acaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaiaebaaaaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaakbcaabaaaaaaaaaaa
bkaabaiaebaaaaaaacaaaaaabkaabaaaacaaaaaaakaabaaaaaaaaaaaelaaaaaf
ecaabaaaacaaaaaaakaabaaaaaaaaaaadcaaaaakhcaabaaaadaaaaaaegacbaaa
acaaaaaafgifcaaaaaaaaaaaaeaaaaaaegbcbaaaadaaaaaabacaaaaibcaabaaa
aaaaaaaajgahbaaaaaaaaaaaegacbaiaebaaaaaaadaaaaaacpaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckiacaaaaaaaaaaaaeaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaalhcaabaaaaaaaaaaaagaabaaaaaaaaaaapgipcaaaaaaaaaaaaeaaaaaa
egiccaaaaaaaaaaaadaaaaaaaaaaaaajhcaabaaaadaaaaaaegiccaaaaaaaaaaa
abaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaa
egbcbaaaadaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaaegiccaaa
aaaaaaaaadaaaaaadiaaaaaihcaabaaaaeaaaaaaegacbaaaadaaaaaaegiccaaa
aaaaaaaaabaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaaaaaaaaaaegacbaaa
aeaaaaaaaaaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaaegacbaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
bcaabaaaabaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaajpcaabaaaabaaaaaaegiocaaaaaaaaaaa
abaaaaaaegiocaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakiccabaaaaaaaaaaadkaabaaaabaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaadcaaaaamhcaabaaaaaaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaa
aaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaadaaaaaaegbcbaaaaeaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_TransMap] 2D 1
ConstBuffer "$Globals" 128
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 64 [_Shininess]
Float 68 [_TransDistortion]
Float 72 [_TransPower]
Float 76 [_TransScale]
BindCB  "$Globals" 0
"ps_4_0_level_9_3
eefiecedaagpeikdjbbiolniabdjnkcfbeepcdnnabaaaaaagaakaaaaaeaaaaaa
daaaaaaakaadaaaaheajaaaacmakaaaaebgpgodjgiadaaaagiadaaaaaaacpppp
cmadaaaadmaaaaaaabaadaaaaaaadmaaaaaadmaaadaaceaaaaaadmaaaaaaaaaa
acababaaabacacaaaaaaabaaaeaaaaaaaaaaaaaaabacppppfbaaaaafaeaaapka
aaaaaaeaaaaaialpaaaaiadpaaaaaaaafbaaaaafafaaapkaaaaaaaedaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaadla
bpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaia
aeaachlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
aaaaaajaacaiapkaaiaaaaadaaaaciiaaeaaoelaaeaaoelaahaaaaacaaaacbia
aaaappiaafaaaaadaaaacoiaaaaaaaiaaeaajalaabaaaaacabaaahiaaeaaoela
aeaaaaaeabaachiaabaaoeiaaaaaaaiaacaaoelaceaaaaacacaachiaabaaoeia
abaaaaacabaaadiaaaaaoolaecaaaaadadaacpiaabaaoelaabaioekaecaaaaad
abaacpiaabaaoeiaacaioekaaeaaaaaeabaacdiaabaaohiaaeaaaakaaeaaffka
aeaaaaaeabaaciiaabaaaaiaabaaaaibaeaakkkaaeaaaaaeabaaciiaabaaffia
abaaffibabaappiaahaaaaacabaaciiaabaappiaagaaaaacabaaceiaabaappia
aeaaaaaeaeaachiaabaaoeiaadaaffkaacaaoelaaiaaaaadabaabiiaaaaapjia
aeaaoeibcaaaaaadacaaaiiaabaappiaadaakkkaabaaaaacaaaaajiaadaaoeka
aeaaaaaeaaaaaoiaacaappiaaaaappiaacaajakaacaaaaadaeaachiaaaaaoeka
aaaaoekaafaaaaadaaaaaoiaaaaaoeiaaeaajaiaafaaaaadaaaacoiaadaajaia
aaaaoeiaaiaaaaadabaaciiaabaaoeiaacaaoelaaiaaaaadabaacbiaabaaoeia
acaaoeiaalaaaaadacaaabiaabaaaaiaaeaappkaalaaaaadacaacciaabaappia
aeaappkaecaaaaadabaaapiaaaaaoelaaaaioekaafaaaaadabaachiaabaaoeia
acaaoekaafaaaaadadaachiaabaaoeiaaaaaoekaafaaaaadacaacoiaacaaffia
adaajaiaacaaaaadacaacoiaacaaoeiaacaaoeiaaeaaaaaeaaaacoiaabaajaia
aaaaoeiaacaaoeiaafaaaaadabaaaiiaaaaaaaiaafaaaakacaaaaaadaaaaabia
acaaaaiaabaappiaabaaaaacacaaapiaaaaaoekaafaaaaadacaaapiaacaaoeia
abaaoekaafaaaaadacaaahiaaaaaaaiaacaaoeiaaeaaaaaeadaaciiaacaappia
aaaaaaiaacaappkaaeaaaaaeaaaachiaacaaoeiaaeaaaakaaaaapjiaaeaaaaae
adaachiaabaaoeiaadaaoelaaaaaoeiaabaaaaacaaaicpiaadaaoeiappppaaaa
fdeieefcmmafaaaaeaaaaaaahdabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
afaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaa
agaabaaaaaaaaaaaagbjbaaaafaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaa
afaaaaaaagaabaaaaaaaaaaaegbcbaaaadaaaaaaefaaaaajpcaabaaaacaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaa
acaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
akaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaak
bcaabaaaaaaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaaacaaaaaaakaabaaa
aaaaaaaaelaaaaafecaabaaaacaaaaaaakaabaaaaaaaaaaadcaaaaakhcaabaaa
adaaaaaaegacbaaaacaaaaaafgifcaaaaaaaaaaaaeaaaaaaegbcbaaaadaaaaaa
bacaaaaibcaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaiaebaaaaaaadaaaaaa
cpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaackiacaaaaaaaaaaaaeaaaaaabjaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaagaabaaaaaaaaaaapgipcaaa
aaaaaaaaaeaaaaaaegiccaaaaaaaaaaaadaaaaaaaaaaaaajhcaabaaaadaaaaaa
egiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaadaaaaaa
egbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaacaaaaaaegbcbaaaadaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaadaaaaaaegacbaaa
adaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaaihcaabaaaaeaaaaaaegacbaaa
adaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaa
aaaaaaaaegacbaaaaeaaaaaaaaaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaa
egacbaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaa
aaaaaaaaegacbaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaibcaabaaaabaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaa
aaaaaaeddiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaajpcaabaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakiccabaaaaaaaaaaa
dkaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaadcaaaaam
hcaabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaegacbaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaadaaaaaa
egbcbaaaaeaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahahaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_TransDistortion]
Float 5 [_TransPower]
Float 6 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_ShadowMapTexture] 2D 3
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 47 ALU, 4 TEX
PARAM c[8] = { program.local[0..6],
		{ 2, 1, 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R0.wyzw, c[7].x, -c[7].y;
MUL R0.y, R1, R1;
MAD R0.y, -R1.x, R1.x, -R0;
ADD R0.w, R0.y, c[7].y;
RSQ R0.w, R0.w;
RCP R1.z, R0.w;
DP3 R0.x, fragment.texcoord[4], fragment.texcoord[4];
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[4];
ADD R2.xyz, fragment.texcoord[2], R0;
DP3 R0.w, R2, R2;
MAD R3.xyz, R1, c[4].x, fragment.texcoord[2];
DP3_SAT R1.w, R0, -R3;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R2;
DP3 R0.x, R1, R0;
POW R2.w, R1.w, c[5].x;
MOV R0.y, c[7].w;
MAX R2.x, R0, c[7].z;
MUL R1.w, R0.y, c[3].x;
MOV R0, c[1];
MUL R0.xyz, R0, c[0];
POW R1.w, R2.x, R1.w;
MUL R2.xyz, R0, R1.w;
MUL R0.x, R2.w, c[6];
TXP R3.x, fragment.texcoord[5], texture[3], 2D;
MUL R2.w, R3.x, c[7].x;
ADD R4.xyz, R0.x, c[2];
MUL R3.yzw, R2.w, c[0].xxyz;
MUL R4.xyz, R3.yzww, R4;
TEX R0.xyz, fragment.texcoord[1], texture[2], 2D;
MUL R4.xyz, R4, R0;
DP3 R3.y, R1, fragment.texcoord[2];
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[2];
MUL R1.xyz, R0, R4;
MUL R0.w, R0, c[0];
MUL R0.w, R1, R0;
MAX R3.y, R3, c[7].z;
MUL R4.xyz, R0, c[0];
MUL R4.xyz, R4, R3.y;
MAD R1.xyz, R4, R2.w, R1;
MUL R2.xyz, R2.w, R2;
ADD R1.xyz, R1, R2;
MAD result.color.xyz, R0, fragment.texcoord[3], R1;
MAD result.color.w, R3.x, R0, c[2];
END
# 47 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_TransDistortion]
Float 5 [_TransPower]
Float 6 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_ShadowMapTexture] 2D 3
"ps_3_0
; 50 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c7, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c8, 128.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5
texld r0.yw, v0.zwzw, s1
mad_pp r2.xy, r0.wyzw, c7.x, c7.y
mul_pp r0.x, r2.y, r2.y
mad_pp r0.x, -r2, r2, -r0
add_pp r0.x, r0, c7.z
rsq_pp r0.y, r0.x
rcp_pp r2.z, r0.y
dp3_pp r0.x, v4, v4
rsq_pp r0.x, r0.x
mad r1.xyz, r2, c4.x, v2
mul_pp r0.xyz, r0.x, v4
dp3_pp_sat r1.w, r0, -r1
add_pp r1.xyz, v2, r0
pow r0, r1.w, c5.x
dp3_pp r0.y, r1, r1
rsq_pp r0.y, r0.y
mul_pp r1.xyz, r0.y, r1
dp3_pp r0.y, r2, r1
mov r1.w, r0.x
mov_pp r0.x, c3
mul_pp r1.x, c8, r0
max_pp r1.y, r0, c7.w
pow r0, r1.y, r1.x
mul r0.y, r1.w, c6.x
texldp r1.x, v5, s3
mul_pp r1.y, r1.x, c7.x
add r4.xyz, r0.y, c2
mul_pp r0.yzw, r1.y, c0.xxyz
mul r4.xyz, r0.yzww, r4
dp3_pp r0.y, r2, v2
max_pp r0.y, r0, c7.w
texld r3.xyz, v1, s2
mul r3.xyz, r4, r3
texld r4.xyz, v0, s0
mul r2.xyz, r4, c2
mul_pp r4.xyz, r2, c0
mul_pp r4.xyz, r4, r0.y
mul_pp r3.xyz, r2, r3
mad_pp r3.xyz, r4, r1.y, r3
mov r0.w, r0.x
mov_pp r4.xyz, c0
mul_pp r0.xyz, c1, r4
mul r0.xyz, r0, r0.w
mul r0.xyz, r1.y, r0
mov_pp r1.z, c0.w
mul_pp r1.y, c1.w, r1.z
add_pp r0.xyz, r3, r0
mul r0.w, r0, r1.y
mad_pp oC0.xyz, r2, v3, r0
mad oC0.w, r1.x, r0, c2
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 3
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 132 [_TransDistortion]
Float 136 [_TransPower]
Float 140 [_TransScale]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmbafflioieadbglkfkednfnhekflhpnnabaaaaaahiahaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceaagaaaaeaaaaaaajaabaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaad
lcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaaagaabaaaaaaaaaaa
agbjbaaaafaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaafaaaaaaagaabaaa
aaaaaaaaegbcbaaaadaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaa
acaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaiaebaaaaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaakbcaabaaaaaaaaaaa
bkaabaiaebaaaaaaacaaaaaabkaabaaaacaaaaaaakaabaaaaaaaaaaaelaaaaaf
ecaabaaaacaaaaaaakaabaaaaaaaaaaadcaaaaakhcaabaaaadaaaaaaegacbaaa
acaaaaaafgifcaaaaaaaaaaaaiaaaaaaegbcbaaaadaaaaaabacaaaaibcaabaaa
aaaaaaaajgahbaaaaaaaaaaaegacbaiaebaaaaaaadaaaaaacpaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckiacaaaaaaaaaaaaiaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaalhcaabaaaaaaaaaaaagaabaaaaaaaaaaapgipcaaaaaaaaaaaaiaaaaaa
egiccaaaaaaaaaaaahaaaaaaaoaaaaahdcaabaaaadaaaaaaegbabaaaagaaaaaa
pgbpbaaaagaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaa
adaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakaabaaaadaaaaaa
akaabaaaadaaaaaadiaaaaaiocaabaaaadaaaaaapgapbaaaaaaaaaaaagijcaaa
aaaaaaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaajgahbaaa
adaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aeaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadiaaaaaiocaabaaaadaaaaaaagajbaaaaeaaaaaaagijcaaa
aaaaaaaaahaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaajgahbaaa
adaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaaegbcbaaaadaaaaaa
deaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaai
hcaabaaaaeaaaaaajgahbaaaadaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaah
hcaabaaaaeaaaaaapgapbaaaabaaaaaaegacbaaaaeaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaaeaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
cpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaa
akiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaajpcaabaaaacaaaaaaegiocaaaaaaaaaaaabaaaaaaegiocaaa
aaaaaaaaacaaaaaadiaaaaahpcaabaaaabaaaaaaagaabaaaabaaaaaaegaobaaa
acaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakiccabaaaaaaaaaaadkaabaaaabaaaaaaakaabaaa
adaaaaaadkiacaaaaaaaaaaaahaaaaaadcaaaaajhccabaaaaaaaaaaajgahbaaa
adaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "RenderType"="Opaque" }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend One One
Program "vp" {
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
Vector 22 [_TransMap_ST]
"3.0-!!ARBvp1.0
# 35 ALU
PARAM c[23] = { { 1 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[19].w, -vertex.position;
DP3 result.texcoord[2].y, R0, R1;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
DP4 result.texcoord[4].z, R0, c[15];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[22], c[22].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 35 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
Vector 21 [_TransMap_ST]
"vs_3_0
; 38 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c22.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c18.w, -v0
dp3 o3.y, r0, r2
dp3 o3.z, v2, r0
dp3 o3.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o4.y, r2, r3
dp3 o4.z, v2, r3
dp3 o4.x, v1, r3
dp4 o5.z, r0, c14
dp4 o5.y, r0, c13
dp4 o5.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
mad o2.xy, v3, c21, c21.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 192
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
Vector 176 [_TransMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedmdcaldeihdhplgeiejockkenheidpjhgabaaaaaaheahaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcmaafaaaaeaaaabaahaabaaaafjaaaaae
egiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaa
ajaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
akaaaaaakgiocaaaaaaaaaaaakaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaah
hcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaa
aaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaaj
hcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaaaaaaaaaagaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 192
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
Vector 176 [_TransMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_3
eefiecedmfahapmbcagcmipgafbhbbpobpcdpkamabaaaaaanmakaaaaaeaaaaaa
daaaaaaajeadaaaafmajaaaaceakaaaaebgpgodjfmadaaaafmadaaaaaaacpopp
omacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
aeaaabaaaaaaaaaaaaaaajaaadaaafaaaaaaaaaaabaaaeaaabaaaiaaaaaaaaaa
acaaaaaaabaaajaaaaaaaaaaadaaaaaaaeaaakaaaaaaaaaaadaaamaaajaaaoaa
aaaaaaaaaaaaaaaaabacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
aaaaadoaadaaoejaafaaoekaafaaookaaeaaaaaeaaaaamoaadaaeejaagaaeeka
agaaoekaaeaaaaaeabaaadoaadaaoejaahaaoekaahaaookaabaaaaacaaaaapia
ajaaoekaafaaaaadabaaahiaaaaaffiabdaaoekaaeaaaaaeabaaahiabcaaoeka
aaaaaaiaabaaoeiaaeaaaaaeaaaaahiabeaaoekaaaaakkiaabaaoeiaaeaaaaae
aaaaahiabfaaoekaaaaappiaaaaaoeiaaeaaaaaeaaaaahiaaaaaoeiabgaappka
aaaaoejbaiaaaaadacaaaboaabaaoejaaaaaoeiaabaaaaacabaaahiaabaaoeja
afaaaaadacaaahiaabaamjiaacaancjaaeaaaaaeabaaahiaacaamjjaabaancia
acaaoeibafaaaaadabaaahiaabaaoeiaabaappjaaiaaaaadacaaacoaabaaoeia
aaaaoeiaaiaaaaadacaaaeoaacaaoejaaaaaoeiaabaaaaacaaaaahiaaiaaoeka
afaaaaadacaaahiaaaaaffiabdaaoekaaeaaaaaeaaaaaliabcaakekaaaaaaaia
acaakeiaaeaaaaaeaaaaahiabeaaoekaaaaakkiaaaaapeiaacaaaaadaaaaahia
aaaaoeiabfaaoekaaeaaaaaeaaaaahiaaaaaoeiabgaappkaaaaaoejbaiaaaaad
adaaaboaabaaoejaaaaaoeiaaiaaaaadadaaacoaabaaoeiaaaaaoeiaaiaaaaad
adaaaeoaacaaoejaaaaaoeiaafaaaaadaaaaapiaaaaaffjaapaaoekaaeaaaaae
aaaaapiaaoaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabaaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiabbaaoekaaaaappjaaaaaoeiaafaaaaadabaaahia
aaaaffiaacaaoekaaeaaaaaeabaaahiaabaaoekaaaaaaaiaabaaoeiaaeaaaaae
aaaaahiaadaaoekaaaaakkiaabaaoeiaaeaaaaaeaeaaahoaaeaaoekaaaaappia
aaaaoeiaafaaaaadaaaaapiaaaaaffjaalaaoekaaeaaaaaeaaaaapiaakaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaanaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcmaafaaaaeaaaabaa
haabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaa
ogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadcaaaaaldccabaaa
acaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaa
alaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaa
abaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaa
adaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaa
egbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
adaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaa
adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaa
aaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_World2Object]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_WorldSpaceLightPos0]
Vector 11 [unity_Scale]
Vector 12 [_MainTex_ST]
Vector 13 [_BumpMap_ST]
Vector 14 [_TransMap_ST]
"3.0-!!ARBvp1.0
# 27 ALU
PARAM c[15] = { { 1 },
		state.matrix.mvp,
		program.local[5..14] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[9];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[7];
DP4 R2.y, R1, c[6];
DP4 R2.x, R1, c[5];
MAD R2.xyz, R2, c[11].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[10];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[7];
DP4 R3.y, R0, c[6];
DP4 R3.x, R0, c[5];
DP3 result.texcoord[2].y, R3, R1;
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, R3, vertex.attrib[14];
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[13].xyxy, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[12], c[12].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[14], c[14].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 27 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_WorldSpaceLightPos0]
Vector 10 [unity_Scale]
Vector 11 [_MainTex_ST]
Vector 12 [_BumpMap_ST]
Vector 13 [_TransMap_ST]
"vs_3_0
; 30 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c14, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c14.x
mov r0.xyz, c8
dp4 r1.z, r0, c6
dp4 r1.y, r0, c5
dp4 r1.x, r0, c4
mad r3.xyz, r1, c10.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c6
dp4 r4.z, c9, r0
mov r0, c5
mov r1, c4
dp4 r4.y, c9, r0
dp4 r4.x, c9, r1
dp3 o3.y, r4, r2
dp3 o4.y, r2, r3
dp3 o3.z, v2, r4
dp3 o3.x, r4, v1
dp3 o4.z, v2, r3
dp3 o4.x, v1, r3
mad o1.zw, v3.xyxy, c12.xyxy, c12
mad o1.xy, v3, c11, c11.zwzw
mad o2.xy, v3, c13, c13.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 128
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
Vector 112 [_TransMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedlokphmbopceajlajicfdnellidiomkaoabaaaaaapeafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcfiaeaaaaeaaaabaa
bgabaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaa
kgiocaaaaaaaaaaaagaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaa
aaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
bccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
adaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaa
abaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
cccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
aeaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaaeaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 128
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
Vector 112 [_TransMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_3
eefiecedbccjlllofheganbmnmgfbmpbmafnlfepabaaaaaakeaiaaaaaeaaaaaa
daaaaaaanmacaaaadmahaaaaaeaiaaaaebgpgodjkeacaaaakeacaaaaaaacpopp
eaacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaafaa
adaaabaaaaaaaaaaabaaaeaaabaaaeaaaaaaaaaaacaaaaaaabaaafaaaaaaaaaa
adaaaaaaaeaaagaaaaaaaaaaadaabaaaafaaakaaaaaaaaaaaaaaaaaaabacpopp
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoeka
abaaookaaeaaaaaeaaaaamoaadaaeejaacaaeekaacaaoekaaeaaaaaeabaaadoa
adaaoejaadaaoekaadaaookaabaaaaacaaaaapiaafaaoekaafaaaaadabaaahia
aaaaffiaalaaoekaaeaaaaaeabaaahiaakaaoekaaaaaaaiaabaaoeiaaeaaaaae
aaaaahiaamaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahiaanaaoekaaaaappia
aaaaoeiaaiaaaaadacaaaboaabaaoejaaaaaoeiaabaaaaacabaaahiaabaaoeja
afaaaaadacaaahiaabaamjiaacaancjaaeaaaaaeabaaahiaacaamjjaabaancia
acaaoeibafaaaaadabaaahiaabaaoeiaabaappjaaiaaaaadacaaacoaabaaoeia
aaaaoeiaaiaaaaadacaaaeoaacaaoejaaaaaoeiaabaaaaacaaaaahiaaeaaoeka
afaaaaadacaaahiaaaaaffiaalaaoekaaeaaaaaeaaaaaliaakaakekaaaaaaaia
acaakeiaaeaaaaaeaaaaahiaamaaoekaaaaakkiaaaaapeiaacaaaaadaaaaahia
aaaaoeiaanaaoekaaeaaaaaeaaaaahiaaaaaoeiaaoaappkaaaaaoejbaiaaaaad
adaaaboaabaaoejaaaaaoeiaaiaaaaadadaaacoaabaaoeiaaaaaoeiaaiaaaaad
adaaaeoaacaaoejaaaaaoeiaafaaaaadaaaaapiaaaaaffjaahaaoekaaeaaaaae
aaaaapiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaajaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefc
fiaeaaaaeaaaabaabgabaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaa
aaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaa
diaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaj
hcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaa
aeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaa
abaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaa
aaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
eccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
Vector 22 [_TransMap_ST]
"3.0-!!ARBvp1.0
# 36 ALU
PARAM c[23] = { { 1 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[19].w, -vertex.position;
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[2].y, R0, R1;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
DP4 result.texcoord[4].w, R0, c[16];
DP4 result.texcoord[4].z, R0, c[15];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[22], c[22].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 36 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
Vector 21 [_TransMap_ST]
"vs_3_0
; 39 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c22.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c18.w, -v0
dp4 r0.w, v0, c7
dp3 o3.y, r0, r2
dp3 o3.z, v2, r0
dp3 o3.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o4.y, r2, r3
dp3 o4.z, v2, r3
dp3 o4.x, v1, r3
dp4 o5.w, r0, c15
dp4 o5.z, r0, c14
dp4 o5.y, r0, c13
dp4 o5.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
mad o2.xy, v3, c21, c21.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 192
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
Vector 176 [_TransMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedbhbdoemfpoiccfmkhffgcojhlcafeaieabaaaaaaheahaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcmaafaaaaeaaaabaahaabaaaafjaaaaae
egiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaa
ajaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
akaaaaaakgiocaaaaaaaaaaaakaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaah
hcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaa
aaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaaj
hcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaaaeaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpccabaaaafaaaaaaegiocaaaaaaaaaaaagaaaaaa
pgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 192
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
Vector 176 [_TransMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_3
eefiecedeacbmeceplgjiegjpmglnllaldlbbilcabaaaaaanmakaaaaaeaaaaaa
daaaaaaajeadaaaafmajaaaaceakaaaaebgpgodjfmadaaaafmadaaaaaaacpopp
omacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
aeaaabaaaaaaaaaaaaaaajaaadaaafaaaaaaaaaaabaaaeaaabaaaiaaaaaaaaaa
acaaaaaaabaaajaaaaaaaaaaadaaaaaaaeaaakaaaaaaaaaaadaaamaaajaaaoaa
aaaaaaaaaaaaaaaaabacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
aaaaadoaadaaoejaafaaoekaafaaookaaeaaaaaeaaaaamoaadaaeejaagaaeeka
agaaoekaaeaaaaaeabaaadoaadaaoejaahaaoekaahaaookaabaaaaacaaaaapia
ajaaoekaafaaaaadabaaahiaaaaaffiabdaaoekaaeaaaaaeabaaahiabcaaoeka
aaaaaaiaabaaoeiaaeaaaaaeaaaaahiabeaaoekaaaaakkiaabaaoeiaaeaaaaae
aaaaahiabfaaoekaaaaappiaaaaaoeiaaeaaaaaeaaaaahiaaaaaoeiabgaappka
aaaaoejbaiaaaaadacaaaboaabaaoejaaaaaoeiaabaaaaacabaaahiaabaaoeja
afaaaaadacaaahiaabaamjiaacaancjaaeaaaaaeabaaahiaacaamjjaabaancia
acaaoeibafaaaaadabaaahiaabaaoeiaabaappjaaiaaaaadacaaacoaabaaoeia
aaaaoeiaaiaaaaadacaaaeoaacaaoejaaaaaoeiaabaaaaacaaaaahiaaiaaoeka
afaaaaadacaaahiaaaaaffiabdaaoekaaeaaaaaeaaaaaliabcaakekaaaaaaaia
acaakeiaaeaaaaaeaaaaahiabeaaoekaaaaakkiaaaaapeiaacaaaaadaaaaahia
aaaaoeiabfaaoekaaeaaaaaeaaaaahiaaaaaoeiabgaappkaaaaaoejbaiaaaaad
adaaaboaabaaoejaaaaaoeiaaiaaaaadadaaacoaabaaoeiaaaaaoeiaaiaaaaad
adaaaeoaacaaoejaaaaaoeiaafaaaaadaaaaapiaaaaaffjaapaaoekaaeaaaaae
aaaaapiaaoaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabaaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiabbaaoekaaaaappjaaaaaoeiaafaaaaadabaaapia
aaaaffiaacaaoekaaeaaaaaeabaaapiaabaaoekaaaaaaaiaabaaoeiaaeaaaaae
abaaapiaadaaoekaaaaakkiaabaaoeiaaeaaaaaeaeaaapoaaeaaoekaaaaappia
abaaoeiaafaaaaadaaaaapiaaaaaffjaalaaoekaaeaaaaaeaaaaapiaakaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaanaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcmaafaaaaeaaaabaa
haabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaa
ogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadcaaaaaldccabaaa
acaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaa
alaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaa
abaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaa
adaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaa
egbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
adaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaa
adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaaaeaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaafaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaafaaaaaaegiocaaa
aaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
Vector 22 [_TransMap_ST]
"3.0-!!ARBvp1.0
# 35 ALU
PARAM c[23] = { { 1 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[19].w, -vertex.position;
DP3 result.texcoord[2].y, R0, R1;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
DP4 result.texcoord[4].z, R0, c[15];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[22], c[22].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 35 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
Vector 21 [_TransMap_ST]
"vs_3_0
; 38 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c22.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c18.w, -v0
dp3 o3.y, r0, r2
dp3 o3.z, v2, r0
dp3 o3.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o4.y, r2, r3
dp3 o4.z, v2, r3
dp3 o4.x, v1, r3
dp4 o5.z, r0, c14
dp4 o5.y, r0, c13
dp4 o5.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
mad o2.xy, v3, c21, c21.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 192
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
Vector 176 [_TransMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedmdcaldeihdhplgeiejockkenheidpjhgabaaaaaaheahaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcmaafaaaaeaaaabaahaabaaaafjaaaaae
egiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaa
ajaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
akaaaaaakgiocaaaaaaaaaaaakaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaah
hcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaa
aaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaaj
hcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaaaaaaaaaagaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 192
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
Vector 176 [_TransMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_3
eefiecedmfahapmbcagcmipgafbhbbpobpcdpkamabaaaaaanmakaaaaaeaaaaaa
daaaaaaajeadaaaafmajaaaaceakaaaaebgpgodjfmadaaaafmadaaaaaaacpopp
omacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
aeaaabaaaaaaaaaaaaaaajaaadaaafaaaaaaaaaaabaaaeaaabaaaiaaaaaaaaaa
acaaaaaaabaaajaaaaaaaaaaadaaaaaaaeaaakaaaaaaaaaaadaaamaaajaaaoaa
aaaaaaaaaaaaaaaaabacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
aaaaadoaadaaoejaafaaoekaafaaookaaeaaaaaeaaaaamoaadaaeejaagaaeeka
agaaoekaaeaaaaaeabaaadoaadaaoejaahaaoekaahaaookaabaaaaacaaaaapia
ajaaoekaafaaaaadabaaahiaaaaaffiabdaaoekaaeaaaaaeabaaahiabcaaoeka
aaaaaaiaabaaoeiaaeaaaaaeaaaaahiabeaaoekaaaaakkiaabaaoeiaaeaaaaae
aaaaahiabfaaoekaaaaappiaaaaaoeiaaeaaaaaeaaaaahiaaaaaoeiabgaappka
aaaaoejbaiaaaaadacaaaboaabaaoejaaaaaoeiaabaaaaacabaaahiaabaaoeja
afaaaaadacaaahiaabaamjiaacaancjaaeaaaaaeabaaahiaacaamjjaabaancia
acaaoeibafaaaaadabaaahiaabaaoeiaabaappjaaiaaaaadacaaacoaabaaoeia
aaaaoeiaaiaaaaadacaaaeoaacaaoejaaaaaoeiaabaaaaacaaaaahiaaiaaoeka
afaaaaadacaaahiaaaaaffiabdaaoekaaeaaaaaeaaaaaliabcaakekaaaaaaaia
acaakeiaaeaaaaaeaaaaahiabeaaoekaaaaakkiaaaaapeiaacaaaaadaaaaahia
aaaaoeiabfaaoekaaeaaaaaeaaaaahiaaaaaoeiabgaappkaaaaaoejbaiaaaaad
adaaaboaabaaoejaaaaaoeiaaiaaaaadadaaacoaabaaoeiaaaaaoeiaaiaaaaad
adaaaeoaacaaoejaaaaaoeiaafaaaaadaaaaapiaaaaaffjaapaaoekaaeaaaaae
aaaaapiaaoaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabaaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiabbaaoekaaaaappjaaaaaoeiaafaaaaadabaaahia
aaaaffiaacaaoekaaeaaaaaeabaaahiaabaaoekaaaaaaaiaabaaoeiaaeaaaaae
aaaaahiaadaaoekaaaaakkiaabaaoeiaaeaaaaaeaeaaahoaaeaaoekaaaaappia
aaaaoeiaafaaaaadaaaaapiaaaaaffjaalaaoekaaeaaaaaeaaaaapiaakaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaanaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcmaafaaaaeaaaabaa
haabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaa
ogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadcaaaaaldccabaaa
acaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaa
alaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaa
abaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaa
adaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaa
egbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
adaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaa
adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaa
aaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
Vector 22 [_TransMap_ST]
"3.0-!!ARBvp1.0
# 33 ALU
PARAM c[23] = { { 1 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R3, R1;
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, R3, vertex.attrib[14];
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[22], c[22].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 33 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
Vector 21 [_TransMap_ST]
"vs_3_0
; 36 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c22.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o3.y, r4, r2
dp3 o4.y, r2, r3
dp3 o3.z, v2, r4
dp3 o3.x, r4, v1
dp3 o4.z, v2, r3
dp3 o4.x, v1, r3
dp4 o5.y, r0, c13
dp4 o5.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
mad o2.xy, v3, c21, c21.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 192
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
Vector 176 [_TransMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedkpinajehnffppcdepeogkmpgjbfglfoaabaaaaaaeiahaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaa
amadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcjeafaaaaeaaaabaagfabaaaafjaaaaae
egiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaa
ajaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
akaaaaaakgiocaaaaaaaaaaaakaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaidcaabaaaabaaaaaafgafbaaaaaaaaaaaegiacaaa
aaaaaaaaaeaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaakmccabaaa
acaaaaaaagiecaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaagaebaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaa
ogikcaaaaaaaaaaaalaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaadaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaa
bdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 192
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
Vector 176 [_TransMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_3
eefiecedmpbhiiopeifbapaagdglblelhconadihabaaaaaajmakaaaaaeaaaaaa
daaaaaaaiaadaaaabmajaaaaoeajaaaaebgpgodjeiadaaaaeiadaaaaaaacpopp
niacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
aeaaabaaaaaaaaaaaaaaajaaadaaafaaaaaaaaaaabaaaeaaabaaaiaaaaaaaaaa
acaaaaaaabaaajaaaaaaaaaaadaaaaaaaeaaakaaaaaaaaaaadaaamaaajaaaoaa
aaaaaaaaaaaaaaaaabacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
aaaaadoaadaaoejaafaaoekaafaaookaaeaaaaaeaaaaamoaadaaeejaagaaeeka
agaaoekaaeaaaaaeabaaadoaadaaoejaahaaoekaahaaookaabaaaaacaaaaapia
ajaaoekaafaaaaadabaaahiaaaaaffiabdaaoekaaeaaaaaeabaaahiabcaaoeka
aaaaaaiaabaaoeiaaeaaaaaeaaaaahiabeaaoekaaaaakkiaabaaoeiaaeaaaaae
aaaaahiabfaaoekaaaaappiaaaaaoeiaaiaaaaadacaaaboaabaaoejaaaaaoeia
abaaaaacabaaahiaabaaoejaafaaaaadacaaahiaabaamjiaacaancjaaeaaaaae
abaaahiaacaamjjaabaanciaacaaoeibafaaaaadabaaahiaabaaoeiaabaappja
aiaaaaadacaaacoaabaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoejaaaaaoeia
abaaaaacaaaaahiaaiaaoekaafaaaaadacaaahiaaaaaffiabdaaoekaaeaaaaae
aaaaaliabcaakekaaaaaaaiaacaakeiaaeaaaaaeaaaaahiabeaaoekaaaaakkia
aaaapeiaacaaaaadaaaaahiaaaaaoeiabfaaoekaaeaaaaaeaaaaahiaaaaaoeia
bgaappkaaaaaoejbaiaaaaadadaaaboaabaaoejaaaaaoeiaaiaaaaadadaaacoa
abaaoeiaaaaaoeiaaiaaaaadadaaaeoaacaaoejaaaaaoeiaafaaaaadaaaaapia
aaaaffjaapaaoekaaeaaaaaeaaaaapiaaoaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiabaaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabbaaoekaaaaappja
aaaaoeiaafaaaaadabaaadiaaaaaffiaacaaobkaaeaaaaaeaaaaadiaabaaobka
aaaaaaiaabaaoeiaaeaaaaaeaaaaadiaadaaobkaaaaakkiaaaaaoeiaaeaaaaae
abaaamoaaeaabekaaaaappiaaaaaeeiaafaaaaadaaaaapiaaaaaffjaalaaoeka
aeaaaaaeaaaaapiaakaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaamaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaanaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaa
fdeieefcjeafaaaaeaaaabaagfabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaa
akaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
dcaabaaaabaaaaaafgafbaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaak
dcaabaaaaaaaaaaaegiacaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaabaaa
abaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaafaaaaaakgakbaaa
aaaaaaaaegaabaaaaaaaaaaadcaaaaakmccabaaaacaaaaaaagiecaaaaaaaaaaa
agaaaaaapgapbaaaaaaaaaaaagaebaaaaaaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
diaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaj
hcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaa
aeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaa
abaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaa
aaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
eccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaacaaaaaaamadaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [unity_World2Shadow0]
Matrix 9 [_Object2World]
Matrix 13 [_World2Object]
Matrix 17 [_LightMatrix0]
Vector 21 [_WorldSpaceCameraPos]
Vector 22 [_WorldSpaceLightPos0]
Vector 23 [unity_Scale]
Vector 24 [_MainTex_ST]
Vector 25 [_BumpMap_ST]
Vector 26 [_TransMap_ST]
"3.0-!!ARBvp1.0
# 40 ALU
PARAM c[27] = { { 1 },
		state.matrix.mvp,
		program.local[5..26] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[21];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[15];
DP4 R2.y, R1, c[14];
DP4 R2.x, R1, c[13];
MAD R2.xyz, R2, c[23].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[22];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[15];
DP4 R3.x, R0, c[13];
DP4 R3.y, R0, c[14];
MAD R0.xyz, R3, c[23].w, -vertex.position;
DP4 R0.w, vertex.position, c[12];
DP3 result.texcoord[2].y, R0, R1;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[11];
DP4 R0.x, vertex.position, c[9];
DP4 R0.y, vertex.position, c[10];
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
DP4 result.texcoord[4].w, R0, c[20];
DP4 result.texcoord[4].z, R0, c[19];
DP4 result.texcoord[4].y, R0, c[18];
DP4 result.texcoord[4].x, R0, c[17];
DP4 result.texcoord[5].w, R0, c[8];
DP4 result.texcoord[5].z, R0, c[7];
DP4 result.texcoord[5].y, R0, c[6];
DP4 result.texcoord[5].x, R0, c[5];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[25].xyxy, c[25];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[24], c[24].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[26], c[26].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 40 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [unity_World2Shadow0]
Matrix 8 [_Object2World]
Matrix 12 [_World2Object]
Matrix 16 [_LightMatrix0]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_WorldSpaceLightPos0]
Vector 22 [unity_Scale]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
Vector 25 [_TransMap_ST]
"vs_3_0
; 43 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c26, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c26.x
mov r0.xyz, c20
dp4 r1.z, r0, c14
dp4 r1.y, r0, c13
dp4 r1.x, r0, c12
mad r3.xyz, r1, c22.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c14
dp4 r4.z, c21, r0
mov r0, c13
dp4 r4.y, c21, r0
mov r1, c12
dp4 r4.x, c21, r1
mad r0.xyz, r4, c22.w, -v0
dp4 r0.w, v0, c11
dp3 o3.y, r0, r2
dp3 o3.z, v2, r0
dp3 o3.x, r0, v1
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp3 o4.y, r2, r3
dp3 o4.z, v2, r3
dp3 o4.x, v1, r3
dp4 o5.w, r0, c19
dp4 o5.z, r0, c18
dp4 o5.y, r0, c17
dp4 o5.x, r0, c16
dp4 o6.w, r0, c7
dp4 o6.z, r0, c6
dp4 o6.y, r0, c5
dp4 o6.x, r0, c4
mad o1.zw, v3.xyxy, c24.xyxy, c24
mad o1.xy, v3, c23, c23.zwzw
mad o2.xy, v3, c25, c25.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 192
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
Vector 176 [_TransMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityShadows" 3
BindCB  "UnityPerDraw" 4
"vs_4_0
eefiecedpgpblcnnomngbdcgngfcnecphimhcmnpabaaaaaaeaaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcheagaaaaeaaaabaajnabaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaaamaaaaaafjaaaaaeegiocaaaaeaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
gfaaaaadpccabaaaagaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaeaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaeaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaeaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaa
akaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
alaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaa
abaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaa
cgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
acaaaaaaaaaaaaaaegiccaaaaeaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaaeaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaaeaaaaaabcaaaaaakgikcaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaaeaaaaaa
bdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegacbaaaabaaaaaapgipcaaaaeaaaaaabeaaaaaaegbcbaiaebaaaaaa
aaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
eccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaaeaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaaeaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaaeaaaaaabcaaaaaa
kgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaeaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaa
egacbaaaabaaaaaapgipcaaaaeaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
bccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
aeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaeaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaeaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaeaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiocaaaaaaaaaaaaeaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaa
adaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pccabaaaafaaaaaaegiocaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaobaaa
abaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaa
ajaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaiaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
akaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaagaaaaaa
egiocaaaadaaaaaaalaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [unity_World2Shadow0]
Matrix 8 [_Object2World]
Matrix 12 [_World2Object]
Matrix 16 [_LightMatrix0]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_WorldSpaceLightPos0]
Vector 22 [unity_Scale]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
Vector 25 [_TransMap_ST]
"vs_3_0
; 43 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c26, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c26.x
mov r0.xyz, c20
dp4 r1.z, r0, c14
dp4 r1.y, r0, c13
dp4 r1.x, r0, c12
mad r3.xyz, r1, c22.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c14
dp4 r4.z, c21, r0
mov r0, c13
dp4 r4.y, c21, r0
mov r1, c12
dp4 r4.x, c21, r1
mad r0.xyz, r4, c22.w, -v0
dp4 r0.w, v0, c11
dp3 o3.y, r0, r2
dp3 o3.z, v2, r0
dp3 o3.x, r0, v1
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp3 o4.y, r2, r3
dp3 o4.z, v2, r3
dp3 o4.x, v1, r3
dp4 o5.w, r0, c19
dp4 o5.z, r0, c18
dp4 o5.y, r0, c17
dp4 o5.x, r0, c16
dp4 o6.w, r0, c7
dp4 o6.z, r0, c6
dp4 o6.y, r0, c5
dp4 o6.x, r0, c4
mad o1.zw, v3.xyxy, c24.xyxy, c24
mad o1.xy, v3, c23, c23.zwzw
mad o2.xy, v3, c25, c25.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 192
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
Vector 176 [_TransMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityShadows" 3
BindCB  "UnityPerDraw" 4
"vs_4_0
eefiecedpgpblcnnomngbdcgngfcnecphimhcmnpabaaaaaaeaaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcheagaaaaeaaaabaajnabaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaaamaaaaaafjaaaaaeegiocaaaaeaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
gfaaaaadpccabaaaagaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaeaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaeaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaeaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaa
akaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
alaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaa
abaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaa
cgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
acaaaaaaaaaaaaaaegiccaaaaeaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaaeaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaaeaaaaaabcaaaaaakgikcaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaaeaaaaaa
bdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegacbaaaabaaaaaapgipcaaaaeaaaaaabeaaaaaaegbcbaiaebaaaaaa
aaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
eccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaaeaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaaeaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaaeaaaaaabcaaaaaa
kgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaeaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaa
egacbaaaabaaaaaapgipcaaaaeaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
bccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
aeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaeaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaeaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaeaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiocaaaaaaaaaaaaeaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaa
adaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pccabaaaafaaaaaaegiocaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaobaaa
abaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaa
ajaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaiaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
akaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaagaaaaaa
egiocaaaadaaaaaaalaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_World2Object]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ProjectionParams]
Vector 11 [_WorldSpaceLightPos0]
Vector 12 [unity_Scale]
Vector 13 [_MainTex_ST]
Vector 14 [_BumpMap_ST]
Vector 15 [_TransMap_ST]
"3.0-!!ARBvp1.0
# 32 ALU
PARAM c[16] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..15] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[9];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[7];
DP4 R2.y, R1, c[6];
DP4 R2.x, R1, c[5];
MAD R2.xyz, R2, c[12].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[11];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[7];
DP4 R3.y, R0, c[6];
DP4 R3.x, R0, c[5];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
DP3 result.texcoord[2].y, R3, R1;
DP3 result.texcoord[3].y, R1, R2;
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[10].x;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, R3, vertex.attrib[14];
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[14].xyxy, c[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[13], c[13].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[15], c[15].zwzw;
END
# 32 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 11 [_WorldSpaceLightPos0]
Vector 12 [unity_Scale]
Vector 13 [_MainTex_ST]
Vector 14 [_BumpMap_ST]
Vector 15 [_TransMap_ST]
"vs_3_0
; 35 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c16, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c16.x
mov r0.xyz, c8
dp4 r1.z, r0, c6
dp4 r1.y, r0, c5
dp4 r1.x, r0, c4
mad r3.xyz, r1, c12.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c6
dp4 r4.z, c11, r0
mov r0, c5
dp4 r4.y, c11, r0
mov r1, c4
dp4 r4.x, c11, r1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c16.y
mul r1.y, r1, c9.x
dp3 o3.y, r4, r2
dp3 o4.y, r2, r3
dp3 o3.z, v2, r4
dp3 o3.x, r4, v1
dp3 o4.z, v2, r3
dp3 o4.x, v1, r3
mad o5.xy, r1.z, c10.zwzw, r1
mov o0, r0
mov o5.zw, r0
mad o1.zw, v3.xyxy, c14.xyxy, c14
mad o1.xy, v3, c13, c13.zwzw
mad o2.xy, v3, c15, c15.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 192
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
Vector 176 [_TransMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 400
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedbfeokpjpgjjjnikcgahcdbchelfkmogeabaaaaaakeagaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcpaaeaaaaeaaaabaadmabaaaafjaaaaae
egiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacadaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaa
akaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
alaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaa
abaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaa
cgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaa
acaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaa
aaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaa
bdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaabaaaaaahcccabaaa
adaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaadaaaaaa
egbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaa
acaaaaaaegacbaaaacaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaadcaaaaal
hcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaa
adaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaaacaaaaaapgipcaaa
adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaa
egacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_ProjectionParams]
Vector 19 [_WorldSpaceLightPos0]
Vector 20 [unity_Scale]
Vector 21 [_MainTex_ST]
Vector 22 [_BumpMap_ST]
Vector 23 [_TransMap_ST]
"3.0-!!ARBvp1.0
# 38 ALU
PARAM c[24] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..23] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.w, c[0].x;
MOV R1.xyz, c[17];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[20].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
DP4 R1.w, vertex.position, c[8];
DP3 result.texcoord[2].y, R3, R1;
DP3 result.texcoord[3].y, R1, R2;
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[18].x;
ADD result.texcoord[5].xy, R1, R1.z;
DP4 R1.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, R3, vertex.attrib[14];
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
MOV result.position, R0;
DP4 result.texcoord[4].y, R1, c[14];
DP4 result.texcoord[4].x, R1, c[13];
MOV result.texcoord[5].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[22].xyxy, c[22];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[21], c[21].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[23], c[23].zwzw;
END
# 38 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Vector 19 [_WorldSpaceLightPos0]
Vector 20 [unity_Scale]
Vector 21 [_MainTex_ST]
Vector 22 [_BumpMap_ST]
Vector 23 [_TransMap_ST]
"vs_3_0
; 41 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c24, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c24.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c20.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r1, c8
dp4 r4.x, c19, r1
mov r0, c10
dp4 r4.z, c19, r0
mov r0, c9
dp4 r4.y, c19, r0
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c24.y
mul r1.y, r1, c17.x
mad o6.xy, r1.z, c18.zwzw, r1
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
dp3 o3.y, r4, r2
dp3 o4.y, r2, r3
dp3 o3.z, v2, r4
dp3 o3.x, r4, v1
dp3 o4.z, v2, r3
dp3 o4.x, v1, r3
mov o0, r0
dp4 o5.y, r1, c13
dp4 o5.x, r1, c12
mov o6.zw, r0
mad o1.zw, v3.xyxy, c22.xyxy, c22
mad o1.xy, v3, c21, c21.zwzw
mad o2.xy, v3, c23, c23.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 256
Matrix 112 [_LightMatrix0]
Vector 208 [_MainTex_ST]
Vector 224 [_BumpMap_ST]
Vector 240 [_TransMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 400
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedckgpochdbcmobgimgkjepcdempjdllopabaaaaaapiahaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaa
amadaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefccmagaaaaeaaaabaailabaaaafjaaaaaeegiocaaaaaaaaaaa
baaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaac
adaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaaoaaaaaakgiocaaa
aaaaaaaaaoaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaaidcaabaaaacaaaaaafgafbaaaabaaaaaaegiacaaaaaaaaaaaaiaaaaaa
dcaaaaakdcaabaaaabaaaaaaegiacaaaaaaaaaaaahaaaaaaagaabaaaabaaaaaa
egaabaaaacaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaaaaaaaaaajaaaaaa
kgakbaaaabaaaaaaegaabaaaabaaaaaadcaaaaakmccabaaaacaaaaaaagiecaaa
aaaaaaaaakaaaaaapgapbaaaabaaaaaaagaebaaaabaaaaaadcaaaaaldccabaaa
acaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaapaaaaaaogikcaaaaaaaaaaa
apaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgbpbaaa
abaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaa
aaaaaaaaegacbaaaacaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaa
acaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaa
diaaaaajhcaabaaaacaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaaaaaaaaai
hcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
hcaabaaaacaaaaaaegacbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
afaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [_LightPositionRange]
Vector 20 [unity_Scale]
Vector 21 [_MainTex_ST]
Vector 22 [_BumpMap_ST]
Vector 23 [_TransMap_ST]
"3.0-!!ARBvp1.0
# 36 ALU
PARAM c[24] = { { 1 },
		state.matrix.mvp,
		program.local[5..23] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[20].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[20].w, -vertex.position;
DP3 result.texcoord[2].y, R0, R1;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
DP4 result.texcoord[4].z, R0, c[15];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
ADD result.texcoord[5].xyz, R0, -c[19];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[22].xyxy, c[22];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[21], c[21].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[23], c[23].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 36 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [_LightPositionRange]
Vector 19 [unity_Scale]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
Vector 22 [_TransMap_ST]
"vs_3_0
; 39 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c23, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c23.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c19.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c19.w, -v0
dp3 o3.y, r0, r2
dp3 o3.z, v2, r0
dp3 o3.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp3 o4.y, r2, r3
dp3 o4.z, v2, r3
dp3 o4.x, v1, r3
dp4 o5.z, r0, c14
dp4 o5.y, r0, c13
dp4 o5.x, r0, c12
add o6.xyz, r0, -c18
mad o1.zw, v3.xyxy, c21.xyxy, c21
mad o1.xy, v3, c20, c20.zwzw
mad o2.xy, v3, c22, c22.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 192
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
Vector 176 [_TransMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecediflnfbjpcahigdbhblhilbcnbmcfigboabaaaaaalmahaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcpaafaaaaeaaaabaahmabaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
acaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaa
aaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
diaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaa
adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaa
bdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaaaaaaaaa
agaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhccabaaaagaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [_LightPositionRange]
Vector 20 [unity_Scale]
Vector 21 [_MainTex_ST]
Vector 22 [_BumpMap_ST]
Vector 23 [_TransMap_ST]
"3.0-!!ARBvp1.0
# 36 ALU
PARAM c[24] = { { 1 },
		state.matrix.mvp,
		program.local[5..23] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[20].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[20].w, -vertex.position;
DP3 result.texcoord[2].y, R0, R1;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
DP4 result.texcoord[4].z, R0, c[15];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
ADD result.texcoord[5].xyz, R0, -c[19];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[22].xyxy, c[22];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[21], c[21].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[23], c[23].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 36 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [_LightPositionRange]
Vector 19 [unity_Scale]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
Vector 22 [_TransMap_ST]
"vs_3_0
; 39 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c23, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c23.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c19.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c19.w, -v0
dp3 o3.y, r0, r2
dp3 o3.z, v2, r0
dp3 o3.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp3 o4.y, r2, r3
dp3 o4.z, v2, r3
dp3 o4.x, v1, r3
dp4 o5.z, r0, c14
dp4 o5.y, r0, c13
dp4 o5.x, r0, c12
add o6.xyz, r0, -c18
mad o1.zw, v3.xyxy, c21.xyxy, c21
mad o1.xy, v3, c20, c20.zwzw
mad o2.xy, v3, c22, c22.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 192
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
Vector 176 [_TransMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecediflnfbjpcahigdbhblhilbcnbmcfigboabaaaaaalmahaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcpaafaaaaeaaaabaahmabaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
acaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaa
aaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
diaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaa
adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaa
bdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaaaaaaaaa
agaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhccabaaaagaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [unity_World2Shadow0]
Matrix 9 [_Object2World]
Matrix 13 [_World2Object]
Matrix 17 [_LightMatrix0]
Vector 21 [_WorldSpaceCameraPos]
Vector 22 [_WorldSpaceLightPos0]
Vector 23 [unity_Scale]
Vector 24 [_MainTex_ST]
Vector 25 [_BumpMap_ST]
Vector 26 [_TransMap_ST]
"3.0-!!ARBvp1.0
# 40 ALU
PARAM c[27] = { { 1 },
		state.matrix.mvp,
		program.local[5..26] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[21];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[15];
DP4 R2.y, R1, c[14];
DP4 R2.x, R1, c[13];
MAD R2.xyz, R2, c[23].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[22];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[15];
DP4 R3.x, R0, c[13];
DP4 R3.y, R0, c[14];
MAD R0.xyz, R3, c[23].w, -vertex.position;
DP4 R0.w, vertex.position, c[12];
DP3 result.texcoord[2].y, R0, R1;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[11];
DP4 R0.x, vertex.position, c[9];
DP4 R0.y, vertex.position, c[10];
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
DP4 result.texcoord[4].w, R0, c[20];
DP4 result.texcoord[4].z, R0, c[19];
DP4 result.texcoord[4].y, R0, c[18];
DP4 result.texcoord[4].x, R0, c[17];
DP4 result.texcoord[5].w, R0, c[8];
DP4 result.texcoord[5].z, R0, c[7];
DP4 result.texcoord[5].y, R0, c[6];
DP4 result.texcoord[5].x, R0, c[5];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[25].xyxy, c[25];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[24], c[24].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[26], c[26].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 40 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [unity_World2Shadow0]
Matrix 8 [_Object2World]
Matrix 12 [_World2Object]
Matrix 16 [_LightMatrix0]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_WorldSpaceLightPos0]
Vector 22 [unity_Scale]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
Vector 25 [_TransMap_ST]
"vs_3_0
; 43 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c26, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c26.x
mov r0.xyz, c20
dp4 r1.z, r0, c14
dp4 r1.y, r0, c13
dp4 r1.x, r0, c12
mad r3.xyz, r1, c22.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c14
dp4 r4.z, c21, r0
mov r0, c13
dp4 r4.y, c21, r0
mov r1, c12
dp4 r4.x, c21, r1
mad r0.xyz, r4, c22.w, -v0
dp4 r0.w, v0, c11
dp3 o3.y, r0, r2
dp3 o3.z, v2, r0
dp3 o3.x, r0, v1
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp3 o4.y, r2, r3
dp3 o4.z, v2, r3
dp3 o4.x, v1, r3
dp4 o5.w, r0, c19
dp4 o5.z, r0, c18
dp4 o5.y, r0, c17
dp4 o5.x, r0, c16
dp4 o6.w, r0, c7
dp4 o6.z, r0, c6
dp4 o6.y, r0, c5
dp4 o6.x, r0, c4
mad o1.zw, v3.xyxy, c24.xyxy, c24
mad o1.xy, v3, c23, c23.zwzw
mad o2.xy, v3, c25, c25.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 256
Matrix 112 [_LightMatrix0]
Vector 208 [_MainTex_ST]
Vector 224 [_BumpMap_ST]
Vector 240 [_TransMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityShadows" 3
BindCB  "UnityPerDraw" 4
"vs_4_0
eefiecedmlgemdkhaamnojkffpcemjkkfffpfgloabaaaaaaeaaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcheagaaaaeaaaabaajnabaaaafjaaaaaeegiocaaaaaaaaaaa
baaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaaamaaaaaafjaaaaaeegiocaaaaeaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
gfaaaaadpccabaaaagaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaeaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaeaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaeaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaaoaaaaaakgiocaaaaaaaaaaa
aoaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
apaaaaaaogikcaaaaaaaaaaaapaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaa
abaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaa
cgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
acaaaaaaaaaaaaaaegiccaaaaeaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaaeaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaaeaaaaaabcaaaaaakgikcaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaaeaaaaaa
bdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegacbaaaabaaaaaapgipcaaaaeaaaaaabeaaaaaaegbcbaiaebaaaaaa
aaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
eccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaaeaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaaeaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaaeaaaaaabcaaaaaa
kgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaeaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaa
egacbaaaabaaaaaapgipcaaaaeaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
bccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
aeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaeaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaeaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaeaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiocaaaaaaaaaaaaiaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaa
ahaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaajaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pccabaaaafaaaaaaegiocaaaaaaaaaaaakaaaaaapgapbaaaaaaaaaaaegaobaaa
abaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaa
ajaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaiaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
akaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaagaaaaaa
egiocaaaadaaaaaaalaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [unity_World2Shadow0]
Matrix 8 [_Object2World]
Matrix 12 [_World2Object]
Matrix 16 [_LightMatrix0]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_WorldSpaceLightPos0]
Vector 22 [unity_Scale]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
Vector 25 [_TransMap_ST]
"vs_3_0
; 43 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c26, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c26.x
mov r0.xyz, c20
dp4 r1.z, r0, c14
dp4 r1.y, r0, c13
dp4 r1.x, r0, c12
mad r3.xyz, r1, c22.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c14
dp4 r4.z, c21, r0
mov r0, c13
dp4 r4.y, c21, r0
mov r1, c12
dp4 r4.x, c21, r1
mad r0.xyz, r4, c22.w, -v0
dp4 r0.w, v0, c11
dp3 o3.y, r0, r2
dp3 o3.z, v2, r0
dp3 o3.x, r0, v1
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp3 o4.y, r2, r3
dp3 o4.z, v2, r3
dp3 o4.x, v1, r3
dp4 o5.w, r0, c19
dp4 o5.z, r0, c18
dp4 o5.y, r0, c17
dp4 o5.x, r0, c16
dp4 o6.w, r0, c7
dp4 o6.z, r0, c6
dp4 o6.y, r0, c5
dp4 o6.x, r0, c4
mad o1.zw, v3.xyxy, c24.xyxy, c24
mad o1.xy, v3, c23, c23.zwzw
mad o2.xy, v3, c25, c25.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 256
Matrix 112 [_LightMatrix0]
Vector 208 [_MainTex_ST]
Vector 224 [_BumpMap_ST]
Vector 240 [_TransMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityShadows" 3
BindCB  "UnityPerDraw" 4
"vs_4_0
eefiecedmlgemdkhaamnojkffpcemjkkfffpfgloabaaaaaaeaaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcheagaaaaeaaaabaajnabaaaafjaaaaaeegiocaaaaaaaaaaa
baaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaaamaaaaaafjaaaaaeegiocaaaaeaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
gfaaaaadpccabaaaagaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaeaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaeaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaeaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaaoaaaaaakgiocaaaaaaaaaaa
aoaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
apaaaaaaogikcaaaaaaaaaaaapaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaa
abaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaa
cgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
acaaaaaaaaaaaaaaegiccaaaaeaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaaeaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaaeaaaaaabcaaaaaakgikcaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaaeaaaaaa
bdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegacbaaaabaaaaaapgipcaaaaeaaaaaabeaaaaaaegbcbaiaebaaaaaa
aaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
eccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaaeaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaaeaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaaeaaaaaabcaaaaaa
kgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaeaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaa
egacbaaaabaaaaaapgipcaaaaeaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
bccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
aeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaeaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaeaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaeaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiocaaaaaaaaaaaaiaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaa
ahaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaajaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pccabaaaafaaaaaaegiocaaaaaaaaaaaakaaaaaapgapbaaaaaaaaaaaegaobaaa
abaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaa
ajaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaiaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
akaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaagaaaaaa
egiocaaaadaaaaaaalaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [_LightPositionRange]
Vector 20 [unity_Scale]
Vector 21 [_MainTex_ST]
Vector 22 [_BumpMap_ST]
Vector 23 [_TransMap_ST]
"3.0-!!ARBvp1.0
# 36 ALU
PARAM c[24] = { { 1 },
		state.matrix.mvp,
		program.local[5..23] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[20].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[20].w, -vertex.position;
DP3 result.texcoord[2].y, R0, R1;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
DP4 result.texcoord[4].z, R0, c[15];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
ADD result.texcoord[5].xyz, R0, -c[19];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[22].xyxy, c[22];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[21], c[21].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[23], c[23].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 36 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [_LightPositionRange]
Vector 19 [unity_Scale]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
Vector 22 [_TransMap_ST]
"vs_3_0
; 39 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c23, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c23.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c19.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c19.w, -v0
dp3 o3.y, r0, r2
dp3 o3.z, v2, r0
dp3 o3.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp3 o4.y, r2, r3
dp3 o4.z, v2, r3
dp3 o4.x, v1, r3
dp4 o5.z, r0, c14
dp4 o5.y, r0, c13
dp4 o5.x, r0, c12
add o6.xyz, r0, -c18
mad o1.zw, v3.xyxy, c21.xyxy, c21
mad o1.xy, v3, c20, c20.zwzw
mad o2.xy, v3, c22, c22.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 192
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
Vector 176 [_TransMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecediflnfbjpcahigdbhblhilbcnbmcfigboabaaaaaalmahaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcpaafaaaaeaaaabaahmabaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
acaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaa
aaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
diaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaa
adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaa
bdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaaaaaaaaa
agaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhccabaaaagaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [_LightPositionRange]
Vector 20 [unity_Scale]
Vector 21 [_MainTex_ST]
Vector 22 [_BumpMap_ST]
Vector 23 [_TransMap_ST]
"3.0-!!ARBvp1.0
# 36 ALU
PARAM c[24] = { { 1 },
		state.matrix.mvp,
		program.local[5..23] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[20].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[20].w, -vertex.position;
DP3 result.texcoord[2].y, R0, R1;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
DP4 result.texcoord[4].z, R0, c[15];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
ADD result.texcoord[5].xyz, R0, -c[19];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[22].xyxy, c[22];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[21], c[21].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[23], c[23].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 36 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [_LightPositionRange]
Vector 19 [unity_Scale]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
Vector 22 [_TransMap_ST]
"vs_3_0
; 39 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c23, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c23.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c19.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c19.w, -v0
dp3 o3.y, r0, r2
dp3 o3.z, v2, r0
dp3 o3.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp3 o4.y, r2, r3
dp3 o4.z, v2, r3
dp3 o4.x, v1, r3
dp4 o5.z, r0, c14
dp4 o5.y, r0, c13
dp4 o5.x, r0, c12
add o6.xyz, r0, -c18
mad o1.zw, v3.xyxy, c21.xyxy, c21
mad o1.xy, v3, c20, c20.zwzw
mad o2.xy, v3, c22, c22.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 192
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
Vector 176 [_TransMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400
Vector 0 [_WorldSpaceLightPos0]
Vector 16 [_LightPositionRange]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecediflnfbjpcahigdbhblhilbcnbmcfigboabaaaaaalmahaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcpaafaaaaeaaaabaahmabaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
acaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaa
aaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
diaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaa
adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaa
bdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaaaaaaaaa
agaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhccabaaaagaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaabaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_TransDistortion]
Float 5 [_TransPower]
Float 6 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 48 ALU, 4 TEX
PARAM c[8] = { program.local[0..6],
		{ 0, 2, 1, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
MUL R1.xyz, R0.x, fragment.texcoord[2];
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.z, R0.x;
MUL R2.xyz, R0.z, fragment.texcoord[3];
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R0.xy, R0.wyzw, c[7].y, -c[7].z;
ADD R3.xyz, R1, R2;
MUL R0.z, R0.y, R0.y;
MAD R0.z, -R0.x, R0.x, -R0;
DP3 R0.w, R3, R3;
RSQ R0.w, R0.w;
MUL R3.xyz, R0.w, R3;
ADD R0.z, R0, c[7];
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
DP3 R1.w, R0, R3;
MOV R0.w, c[7];
MOV R3.xyz, c[1];
MAX R1.w, R1, c[7].x;
MUL R0.w, R0, c[3].x;
POW R0.w, R1.w, R0.w;
MUL R3.xyz, R3, c[0];
MUL R4.xyz, R3, R0.w;
MAD R3.xyz, R0, c[4].x, R1;
DP3_SAT R1.w, R2, -R3;
POW R1.w, R1.w, c[5].x;
MUL R2.w, R1, c[6].x;
DP3 R1.w, R0, R1;
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
TEX R0.w, R0.w, texture[3], 2D;
MUL R0.w, R0, c[7].y;
ADD R1.xyz, R2.w, c[2];
MUL R0.xyz, R0.w, c[0];
MUL R3.xyz, R0, R1;
TEX R1.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[2];
MUL R1.xyz, R3, R1;
MUL R1.xyz, R0, R1;
MUL R2.xyz, R0.w, R4;
MAX R1.w, R1, c[7].x;
MUL R0.xyz, R0, c[0];
MUL R0.xyz, R0, R1.w;
MAD R0.xyz, R0, R0.w, R1;
ADD result.color.xyz, R0, R2;
MOV result.color.w, c[7].x;
END
# 48 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_TransDistortion]
Float 5 [_TransPower]
Float 6 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
"ps_3_0
; 50 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c7, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c8, 128.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c7.x, c7.y
mul_pp r0.w, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v2
dp3_pp r0.x, v3, v3
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v3
add_pp r0.xyz, r2, r3
dp3_pp r1.z, r0, r0
rsq_pp r1.z, r1.z
add_pp r0.w, r0, c7.z
mul_pp r0.xyz, r1.z, r0
rsq_pp r0.w, r0.w
rcp_pp r1.z, r0.w
dp3_pp r0.x, r1, r0
mov_pp r0.w, c3.x
mad r4.xyz, r1, c4.x, r2
mul_pp r2.w, c8.x, r0
max_pp r1.w, r0.x, c7
pow r0, r1.w, r2.w
dp3_pp_sat r0.w, r3, -r4
mov r1.w, r0.x
pow r3, r0.w, c5.x
mov_pp r0.xyz, c0
mul_pp r0.xyz, c1, r0
mul r4.xyz, r0, r1.w
mov r1.w, r3.x
mul r2.w, r1, c6.x
dp3_pp r1.w, r1, r2
dp3 r0.x, v4, v4
texld r0.x, r0.x, s3
mul_pp r0.w, r0.x, c7.x
add r2.xyz, r2.w, c2
mul_pp r1.xyz, r0.w, c0
mul r3.xyz, r1, r2
texld r2.xyz, v1, s2
texld r1.xyz, v0, s0
mul r1.xyz, r1, c2
mul r2.xyz, r3, r2
mul_pp r2.xyz, r1, r2
mul r0.xyz, r0.w, r4
max_pp r1.w, r1, c7
mul_pp r1.xyz, r1, c0
mul_pp r1.xyz, r1, r1.w
mad_pp r1.xyz, r1, r0.w, r2
add_pp oC0.xyz, r1, r0
mov_pp oC0.w, c7
"
}
SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 3
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 132 [_TransDistortion]
Float 136 [_TransPower]
Float 140 [_TransScale]
BindCB  "$Globals" 0
"ps_4_0
eefiecediamijalaakaboobdalkoammlejdpaddnabaaaaaagiahaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceiagaaaa
eaaaaaaajcabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegbcbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegbcbaaa
adaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaa
adaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaa
akaabaiaebaaaaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaiadpdcaaaaak
icaabaaaaaaaaaaabkaabaiaebaaaaaaadaaaaaabkaabaaaadaaaaaadkaabaaa
aaaaaaaaelaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaa
aeaaaaaaegacbaaaadaaaaaafgifcaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaadeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaabacaaaaibcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaaeaaaaaacpaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckiacaaaaaaaaaaaaiaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaalhcaabaaaaaaaaaaaagaabaaaaaaaaaaapgipcaaaaaaaaaaaaiaaaaaa
egiccaaaaaaaaaaaahaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaafaaaaaa
egbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaaeghobaaa
adaaaaaaaagabaaaaaaaaaaaaaaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaaiocaabaaaabaaaaaaagaabaaaabaaaaaaagijcaaa
aaaaaaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaajgahbaaa
abaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aeaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadiaaaaaiocaabaaaabaaaaaaagajbaaaaeaaaaaaagijcaaa
aaaaaaaaahaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaajgahbaaa
abaaaaaadiaaaaaiocaabaaaabaaaaaafgaobaaaabaaaaaaagijcaaaaaaaaaaa
abaaaaaadiaaaaahocaabaaaabaaaaaapgapbaaaaaaaaaaafgaobaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaajgahbaaaabaaaaaaagaabaaaabaaaaaaegacbaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahocaabaaaabaaaaaa
pgapbaaaaaaaaaaaagajbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
adaaaaaajgahbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
ccaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaabjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaajocaabaaaabaaaaaaagijcaaaaaaaaaaa
abaaaaaaagijcaaaaaaaaaaaacaaaaaadiaaaaahocaabaaaabaaaaaapgapbaaa
aaaaaaaafgaobaaaabaaaaaadcaaaaajhccabaaaaaaaaaaajgahbaaaabaaaaaa
agaabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 3
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 132 [_TransDistortion]
Float 136 [_TransPower]
Float 140 [_TransScale]
BindCB  "$Globals" 0
"ps_4_0_level_9_3
eefiecedceeddbbnbhfkcdfmddhfhflpcmfmhieoabaaaaaabialaaaaaeaaaaaa
daaaaaaanmadaaaacmakaaaaoeakaaaaebgpgodjkeadaaaakeadaaaaaaacpppp
fiadaaaaemaaaaaaacaadeaaaaaaemaaaaaaemaaaeaaceaaaaaaemaaadaaaaaa
aaababaaacacacaaabadadaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaaacaaacaa
aaaaaaaaabacppppfbaaaaafaeaaapkaaaaaaaeaaaaaialpaaaaiadpaaaaaaaa
fbaaaaafafaaapkaaaaaaaedaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaaplabpaaaaacaaaaaaiaabaaadlabpaaaaacaaaaaaiaacaachlabpaaaaac
aaaaaaiaadaachlabpaaaaacaaaaaaiaaeaaahlabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaaja
adaiapkaaiaaaaadaaaaaiiaaeaaoelaaeaaoelaabaaaaacaaaaadiaaaaappia
abaaaaacabaaadiaaaaaoolaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaad
abaacpiaabaaoeiaadaioekaacaaaaadaaaacbiaaaaaaaiaaaaaaaiaafaaaaad
aaaacoiaaaaaaaiaaaaajakaaeaaaaaeabaacdiaabaaohiaaeaaaakaaeaaffka
aeaaaaaeabaaciiaabaaaaiaabaaaaibaeaakkkaaeaaaaaeabaaciiaabaaffia
abaaffibabaappiaahaaaaacabaaciiaabaappiaagaaaaacabaaceiaabaappia
aiaaaaadabaaciiaacaaoelaacaaoelaahaaaaacabaaciiaabaappiaafaaaaad
acaachiaabaappiaacaaoelaaeaaaaaeadaachiaabaaoeiaadaaffkaacaaoeia
aiaaaaadadaaciiaabaaoeiaacaaoeiaalaaaaadacaacbiaadaappiaaeaappka
ceaaaaacaeaachiaadaaoelaaiaaaaadaeaabiiaaeaaoeiaadaaoeibaeaaaaae
acaacoiaacaajalaabaappiaaeaajaiaceaaaaacadaachiaacaapjiaaiaaaaad
abaacbiaabaaoeiaadaaoeiaalaaaaadacaaaciaabaaaaiaaeaappkacaaaaaad
abaaabiaaeaappiaadaakkkaabaaaaacadaaajiaadaaoekaaeaaaaaeabaaahia
abaaaaiaadaappiaacaaoekaafaaaaadaaaaaoiaaaaaoeiaabaajaiaecaaaaad
abaaapiaaaaaoelaabaioekaecaaaaadaeaacpiaabaaoelaacaioekaafaaaaad
aaaacoiaaaaaoeiaaeaajaiaafaaaaadabaachiaabaaoeiaacaaoekaafaaaaad
aaaacoiaaaaaoeiaabaajaiaafaaaaadabaachiaabaaoeiaaaaaoekaafaaaaad
abaachiaacaaaaiaabaaoeiaaeaaaaaeaaaacoiaabaajaiaaaaaaaiaaaaaoeia
afaaaaadabaaabiaadaaaaiaafaaaakacaaaaaadadaaabiaacaaffiaabaaaaia
abaaaaacabaaahiaaaaaoekaafaaaaadabaaahiaabaaoeiaabaaoekaafaaaaad
abaaahiaadaaaaiaabaaoeiaaeaaaaaeaaaachiaabaaoeiaaaaaaaiaaaaapjia
abaaaaacaaaaciiaaeaappkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
eiagaaaaeaaaaaaajcabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egbcbaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaa
adaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegbcbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaa
egbcbaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
adaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaap
dcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadcaaaaakicaabaaa
aaaaaaaaakaabaiaebaaaaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaiadp
dcaaaaakicaabaaaaaaaaaaabkaabaiaebaaaaaaadaaaaaabkaabaaaadaaaaaa
dkaabaaaaaaaaaaaelaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaadcaaaaak
hcaabaaaaeaaaaaaegacbaaaadaaaaaafgifcaaaaaaaaaaaaiaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaabacaaaai
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaaeaaaaaacpaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaackiacaaaaaaaaaaaaiaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaalhcaabaaaaaaaaaaaagaabaaaaaaaaaaapgipcaaaaaaaaaaa
aiaaaaaaegiccaaaaaaaaaaaahaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaa
eghobaaaadaaaaaaaagabaaaaaaaaaaaaaaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaaiocaabaaaabaaaaaaagaabaaaabaaaaaa
agijcaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
jgahbaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaeaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadiaaaaaiocaabaaaabaaaaaaagajbaaaaeaaaaaa
agijcaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
jgahbaaaabaaaaaadiaaaaaiocaabaaaabaaaaaafgaobaaaabaaaaaaagijcaaa
aaaaaaaaabaaaaaadiaaaaahocaabaaaabaaaaaapgapbaaaaaaaaaaafgaobaaa
abaaaaaadcaaaaajhcaabaaaaaaaaaaajgahbaaaabaaaaaaagaabaaaabaaaaaa
egacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahocaabaaa
abaaaaaapgapbaaaaaaaaaaaagajbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaadaaaaaajgahbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaiccaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaed
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaabjaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaajocaabaaaabaaaaaaagijcaaa
aaaaaaaaabaaaaaaagijcaaaaaaaaaaaacaaaaaadiaaaaahocaabaaaabaaaaaa
pgapbaaaaaaaaaaafgaobaaaabaaaaaadcaaaaajhccabaaaaaaaaaaajgahbaaa
abaaaaaaagaabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_TransDistortion]
Float 5 [_TransPower]
Float 6 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 42 ALU, 3 TEX
PARAM c[8] = { program.local[0..6],
		{ 0, 2, 1, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R0.wyzw, c[7].y, -c[7].z;
MUL R0.x, R1.y, R1.y;
MAD R0.x, -R1, R1, -R0;
ADD R0.w, R0.x, c[7].z;
RSQ R0.w, R0.w;
RCP R1.z, R0.w;
DP3 R0.y, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.y, R0.y;
MUL R0.xyz, R0.y, fragment.texcoord[3];
ADD R3.xyz, fragment.texcoord[2], R0;
MAD R2.xyz, R1, c[4].x, fragment.texcoord[2];
DP3 R0.w, R3, R3;
DP3_SAT R0.x, R0, -R2;
RSQ R0.w, R0.w;
MUL R2.xyz, R0.w, R3;
POW R0.w, R0.x, c[5].x;
DP3 R0.x, R1, R2;
MOV R2.xy, c[7].ywzw;
MAX R1.w, R0.x, c[7].x;
MUL R2.y, R2, c[3].x;
POW R1.w, R1.w, R2.y;
MUL R0.w, R0, c[6].x;
ADD R3.xyz, R0.w, c[2];
DP3 R0.w, R1, fragment.texcoord[2];
MOV R0.xyz, c[1];
MUL R0.xyz, R0, c[0];
MUL R0.xyz, R0, R1.w;
MUL R4.xyz, R0, c[7].y;
MUL R2.xyz, R2.x, c[0];
TEX R0.xyz, fragment.texcoord[1], texture[2], 2D;
MUL R2.xyz, R2, R3;
MUL R2.xyz, R2, R0;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[2];
MUL R1.xyz, R0, R2;
MAX R0.w, R0, c[7].x;
MUL R0.xyz, R0, c[0];
MUL R0.xyz, R0, R0.w;
MAD R0.xyz, R0, c[7].y, R1;
ADD result.color.xyz, R0, R4;
MOV result.color.w, c[7].x;
END
# 42 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_TransDistortion]
Float 5 [_TransPower]
Float 6 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
"ps_3_0
; 46 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c7, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c8, 128.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c7.x, c7.y
mul_pp r0.x, r1.y, r1.y
mad_pp r0.x, -r1, r1, -r0
add_pp r0.x, r0, c7.z
rsq_pp r0.x, r0.x
rcp_pp r1.z, r0.x
dp3_pp r0.y, v3, v3
rsq_pp r0.y, r0.y
mul_pp r0.xyz, r0.y, v3
mad r3.xyz, r1, c4.x, v2
add_pp r2.xyz, v2, r0
dp3_pp_sat r1.w, r0, -r3
pow r0, r1.w, c5.x
dp3_pp r2.w, r2, r2
rsq_pp r0.y, r2.w
mul_pp r2.xyz, r0.y, r2
dp3_pp r0.y, r1, r2
mov_pp r0.z, c3.x
mov r0.w, r0.x
mul_pp r0.z, c8.x, r0
max_pp r0.y, r0, c7.w
pow r2, r0.y, r0.z
mov_pp r0.xyz, c0
mul_pp r0.xyz, c1, r0
mov r1.w, r2.x
mul r2.xyz, r0, r1.w
mul r0.x, r0.w, c6
mul r4.xyz, r2, c7.x
add r3.xyz, r0.x, c2
dp3_pp r0.w, r1, v2
mov_pp r2.xyz, c0
mul_pp r2.xyz, c7.x, r2
texld r0.xyz, v1, s2
mul r2.xyz, r2, r3
mul r2.xyz, r2, r0
texld r0.xyz, v0, s0
mul r0.xyz, r0, c2
mul_pp r1.xyz, r0, r2
max_pp r0.w, r0, c7
mul_pp r0.xyz, r0, c0
mul_pp r0.xyz, r0, r0.w
mad_pp r0.xyz, r0, c7.x, r1
add_pp oC0.xyz, r0, r4
mov_pp oC0.w, c7
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_TransMap] 2D 1
ConstBuffer "$Globals" 128
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 64 [_Shininess]
Float 68 [_TransDistortion]
Float 72 [_TransPower]
Float 76 [_TransScale]
BindCB  "$Globals" 0
"ps_4_0
eefiecedgijgmpmalehoiffjgblchllcpjdlaepbabaaaaaajaagaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefciiafaaaaeaaaaaaagcabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaaagaabaaaaaaaaaaaagbjbaaa
aeaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaaeaaaaaaagaabaaaaaaaaaaa
egbcbaaaadaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaa
akaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaakbcaabaaaaaaaaaaabkaabaia
ebaaaaaaacaaaaaabkaabaaaacaaaaaaakaabaaaaaaaaaaaelaaaaafecaabaaa
acaaaaaaakaabaaaaaaaaaaadcaaaaakhcaabaaaadaaaaaaegacbaaaacaaaaaa
fgifcaaaaaaaaaaaaeaaaaaaegbcbaaaadaaaaaabacaaaaibcaabaaaaaaaaaaa
jgahbaaaaaaaaaaaegacbaiaebaaaaaaadaaaaaacpaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaa
aaaaaaaaaeaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaagaabaaaaaaaaaaapgipcaaaaaaaaaaaaeaaaaaaegiccaaa
aaaaaaaaadaaaaaaaaaaaaajhcaabaaaadaaaaaaegiccaaaaaaaaaaaabaaaaaa
egiccaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaadaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegbcbaaa
adaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
efaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaaegiccaaaaaaaaaaa
adaaaaaadiaaaaaihcaabaaaaeaaaaaaegacbaaaadaaaaaaegiccaaaaaaaaaaa
abaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaaaaaaaaaaegacbaaaaeaaaaaa
aaaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaibcaabaaa
abaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaa
egiccaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaamhccabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_TransMap] 2D 1
ConstBuffer "$Globals" 128
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 64 [_Shininess]
Float 68 [_TransDistortion]
Float 72 [_TransPower]
Float 76 [_TransScale]
BindCB  "$Globals" 0
"ps_4_0_level_9_3
eefiecedhcpfloahgphlbnhjdgcnoloilbadphpbabaaaaaanmajaaaaaeaaaaaa
daaaaaaahiadaaaaaiajaaaakiajaaaaebgpgodjeaadaaaaeaadaaaaaaacpppp
aeadaaaadmaaaaaaabaadaaaaaaadmaaaaaadmaaadaaceaaaaaadmaaaaaaaaaa
acababaaabacacaaaaaaabaaaeaaaaaaaaaaaaaaabacppppfbaaaaafaeaaapka
aaaaaaeaaaaaialpaaaaiadpaaaaaaaafbaaaaafafaaapkaaaaaaaedaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaadla
bpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaaiaaaaad
aaaaciiaadaaoelaadaaoelaahaaaaacaaaacbiaaaaappiaafaaaaadaaaacoia
aaaaaaiaadaajalaabaaaaacabaaahiaadaaoelaaeaaaaaeabaachiaabaaoeia
aaaaaaiaacaaoelaceaaaaacacaachiaabaaoeiaabaaaaacabaaadiaaaaaoola
ecaaaaadadaacpiaabaaoelaabaioekaecaaaaadabaacpiaabaaoeiaacaioeka
aeaaaaaeabaacdiaabaaohiaaeaaaakaaeaaffkaaeaaaaaeabaaciiaabaaaaia
abaaaaibaeaakkkaaeaaaaaeabaaciiaabaaffiaabaaffibabaappiaahaaaaac
abaaciiaabaappiaagaaaaacabaaceiaabaappiaaeaaaaaeaeaachiaabaaoeia
adaaffkaacaaoelaaiaaaaadabaabiiaaaaapjiaaeaaoeibcaaaaaadacaaaiia
abaappiaadaakkkaabaaaaacaaaaajiaadaaoekaaeaaaaaeaaaaaoiaacaappia
aaaappiaacaajakaacaaaaadaeaachiaaaaaoekaaaaaoekaafaaaaadaaaaaoia
aaaaoeiaaeaajaiaafaaaaadaaaacoiaadaajaiaaaaaoeiaaiaaaaadabaaciia
abaaoeiaacaaoelaaiaaaaadabaacbiaabaaoeiaacaaoeiaalaaaaadacaaabia
abaaaaiaaeaappkaalaaaaadacaacciaabaappiaaeaappkaecaaaaadabaaapia
aaaaoelaaaaioekaafaaaaadabaachiaabaaoeiaacaaoekaafaaaaadadaachia
abaaoeiaaaaaoekaafaaaaadacaacoiaacaaffiaadaajaiaacaaaaadacaacoia
acaaoeiaacaaoeiaaeaaaaaeaaaacoiaabaajaiaaaaaoeiaacaaoeiaafaaaaad
aaaaabiaaaaaaaiaafaaaakacaaaaaadabaaabiaacaaaaiaaaaaaaiaabaaaaac
acaaahiaaaaaoekaafaaaaadabaaaoiaacaajaiaabaajakaafaaaaadabaaahia
abaaaaiaabaapjiaaeaaaaaeaaaachiaabaaoeiaaeaaaakaaaaapjiaabaaaaac
aaaaaiiaaeaappkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefciiafaaaa
eaaaaaaagcabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacafaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaa
aeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahocaabaaaaaaaaaaaagaabaaaaaaaaaaaagbjbaaaaeaaaaaadcaaaaaj
hcaabaaaabaaaaaaegbcbaaaaeaaaaaaagaabaaaaaaaaaaaegbcbaaaadaaaaaa
efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaa
abeaaaaaaaaaiadpdcaaaaakbcaabaaaaaaaaaaabkaabaiaebaaaaaaacaaaaaa
bkaabaaaacaaaaaaakaabaaaaaaaaaaaelaaaaafecaabaaaacaaaaaaakaabaaa
aaaaaaaadcaaaaakhcaabaaaadaaaaaaegacbaaaacaaaaaafgifcaaaaaaaaaaa
aeaaaaaaegbcbaaaadaaaaaabacaaaaibcaabaaaaaaaaaaajgahbaaaaaaaaaaa
egacbaiaebaaaaaaadaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaaeaaaaaa
bjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaa
agaabaaaaaaaaaaapgipcaaaaaaaaaaaaeaaaaaaegiccaaaaaaaaaaaadaaaaaa
aaaaaaajhcaabaaaadaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaa
efaaaaajpcaabaaaadaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegbcbaaaadaaaaaadeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaa
adaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaai
hcaabaaaadaaaaaaegacbaaaadaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaai
hcaabaaaaeaaaaaaegacbaaaadaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaah
hcaabaaaaeaaaaaapgapbaaaaaaaaaaaegacbaaaaeaaaaaaaaaaaaahhcaabaaa
aeaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaaakiacaaa
aaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaa
acaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaamhccabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
imaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_TransDistortion]
Float 5 [_TransPower]
Float 6 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
SetTexture 4 [_LightTextureB0] 2D 4
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 54 ALU, 5 TEX
PARAM c[9] = { program.local[0..6],
		{ 0, 2, 1, 0.5 },
		{ 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.w, R0.w;
MAD R1.xy, R1.wyzw, c[7].y, -c[7].z;
MUL R3.xyz, R0.w, fragment.texcoord[3];
MUL R0.xyz, R0.x, fragment.texcoord[2];
ADD R2.xyz, R0, R3;
MUL R0.w, R1.y, R1.y;
MAD R0.w, -R1.x, R1.x, -R0;
DP3 R1.z, R2, R2;
RSQ R1.z, R1.z;
ADD R0.w, R0, c[7].z;
MUL R2.xyz, R1.z, R2;
RSQ R0.w, R0.w;
RCP R1.z, R0.w;
DP3 R1.w, R1, R2;
MAD R4.xyz, R1, c[4].x, R0;
MOV R0.w, c[8].x;
MOV R2.xyz, c[1];
DP3_SAT R2.w, R3, -R4;
MAX R1.w, R1, c[7].x;
MUL R0.w, R0, c[3].x;
POW R0.w, R1.w, R0.w;
MUL R2.xyz, R2, c[0];
MUL R2.xyz, R2, R0.w;
RCP R0.w, fragment.texcoord[4].w;
MAD R3.xy, fragment.texcoord[4], R0.w, c[7].w;
TEX R0.w, R3, texture[3], 2D;
SLT R3.x, c[7], fragment.texcoord[4].z;
DP3 R1.w, fragment.texcoord[4], fragment.texcoord[4];
TEX R1.w, R1.w, texture[4], 2D;
MUL R0.w, R3.x, R0;
MUL R0.w, R0, R1;
POW R1.w, R2.w, c[5].x;
MUL R0.w, R0, c[7].y;
MUL R2.w, R1, c[6].x;
DP3 R1.w, R1, R0;
ADD R1.xyz, R2.w, c[2];
MUL R0.xyz, R0.w, c[0];
MUL R3.xyz, R0, R1;
TEX R1.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[2];
MUL R1.xyz, R3, R1;
MUL R1.xyz, R0, R1;
MUL R2.xyz, R0.w, R2;
MAX R1.w, R1, c[7].x;
MUL R0.xyz, R0, c[0];
MUL R0.xyz, R0, R1.w;
MAD R0.xyz, R0, R0.w, R1;
ADD result.color.xyz, R0, R2;
MOV result.color.w, c[7].x;
END
# 54 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_TransDistortion]
Float 5 [_TransPower]
Float 6 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
SetTexture 4 [_LightTextureB0] 2D 4
"ps_3_0
; 55 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c7, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c8, 0.50000000, 128.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c7.x, c7.y
mul_pp r0.w, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v2
dp3_pp r0.x, v3, v3
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v3
add_pp r0.xyz, r3, r2
dp3_pp r1.z, r0, r0
rsq_pp r1.z, r1.z
add_pp r0.w, r0, c7.z
mul_pp r0.xyz, r1.z, r0
rsq_pp r0.w, r0.w
rcp_pp r1.z, r0.w
dp3_pp r0.x, r1, r0
mov_pp r0.w, c3.x
mad r4.xyz, r1, c4.x, r3
mul_pp r2.w, c8.y, r0
max_pp r1.w, r0.x, c7
pow r0, r1.w, r2.w
dp3_pp_sat r0.w, r2, -r4
mov r1.w, r0.x
pow r2, r0.w, c5.x
mov_pp r0.xyz, c0
mul_pp r0.xyz, c1, r0
mul r4.xyz, r0, r1.w
mov r1.w, r2.x
mul r2.x, r1.w, c6
dp3_pp r1.w, r1, r3
rcp r0.x, v4.w
mad r5.xy, v4, r0.x, c8.x
dp3 r0.x, v4, v4
texld r0.w, r5, s3
cmp r0.y, -v4.z, c7.w, c7.z
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s4
mul_pp r0.x, r0.y, r0
mul_pp r0.w, r0.x, c7.x
add r2.xyz, r2.x, c2
mul_pp r1.xyz, r0.w, c0
mul r3.xyz, r1, r2
texld r2.xyz, v1, s2
texld r1.xyz, v0, s0
mul r1.xyz, r1, c2
mul r2.xyz, r3, r2
mul_pp r2.xyz, r1, r2
mul r0.xyz, r0.w, r4
max_pp r1.w, r1, c7
mul_pp r1.xyz, r1, c0
mul_pp r1.xyz, r1, r1.w
mad_pp r1.xyz, r1, r0.w, r2
add_pp oC0.xyz, r1, r0
mov_pp oC0.w, c7
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpMap] 2D 4
SetTexture 2 [_TransMap] 2D 3
SetTexture 3 [_LightTexture0] 2D 0
SetTexture 4 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 132 [_TransDistortion]
Float 136 [_TransPower]
Float 140 [_TransScale]
BindCB  "$Globals" 0
"ps_4_0
eefiecedpjcimfjgadapfljaglfkoelklkphnffaabaaaaaaeaaiaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefccaahaaaa
eaaaaaaamiabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaafaaaaaapgbpbaaaafaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaadbaaaaah
bcaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaafaaaaaaabaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaa
eghobaaaaeaaaaaaaagabaaaabaaaaaaapaaaaahbcaabaaaaaaaaaaaagaabaaa
aaaaaaaaagaabaaaabaaaaaadiaaaaaiocaabaaaaaaaaaaaagaabaaaaaaaaaaa
agijcaaaaaaaaaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaa
egbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaaeaaaaaabaaaaaahicaabaaa
abaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegbcbaaa
adaaaaaadcaaaaajhcaabaaaadaaaaaaegbcbaaaadaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaaeaaaaaadcaaaaapdcaabaaaaeaaaaaahgapbaaaaeaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaadcaaaaakicaabaaaabaaaaaaakaabaiaebaaaaaaaeaaaaaa
akaabaaaaeaaaaaaabeaaaaaaaaaiadpdcaaaaakicaabaaaabaaaaaabkaabaia
ebaaaaaaaeaaaaaabkaabaaaaeaaaaaadkaabaaaabaaaaaaelaaaaafecaabaaa
aeaaaaaadkaabaaaabaaaaaadcaaaaakhcaabaaaafaaaaaaegacbaaaaeaaaaaa
fgifcaaaaaaaaaaaaiaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaaeaaaaaaegacbaaaacaaaaaadeaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaaabacaaaaibcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaiaebaaaaaaafaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackiacaaaaaaaaaaaaiaaaaaa
bjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
agaabaaaabaaaaaapgipcaaaaaaaaaaaaiaaaaaaegiccaaaaaaaaaaaahaaaaaa
diaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaa
diaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaahaaaaaa
diaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadcaaaaajocaabaaa
aaaaaaaaagajbaaaabaaaaaaagaabaaaaaaaaaaafgaobaaaaaaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaa
egacbaaaadaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaa
abaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
cpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaa
akiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaajocaabaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaa
aaaaaaaaacaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaajgahbaaa
abaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaa
jgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "SPOT" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpMap] 2D 4
SetTexture 2 [_TransMap] 2D 3
SetTexture 3 [_LightTexture0] 2D 0
SetTexture 4 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 132 [_TransDistortion]
Float 136 [_TransPower]
Float 140 [_TransScale]
BindCB  "$Globals" 0
"ps_4_0_level_9_3
eefiecedhigocfdeaibminnnlkbcgilfjoghjpiiabaaaaaafeamaaaaaeaaaaaa
daaaaaaaeaaeaaaagialaaaacaamaaaaebgpgodjaiaeaaaaaiaeaaaaaaacpppp
liadaaaafaaaaaaaacaadiaaaaaafaaaaaaafaaaafaaceaaaaaafaaaadaaaaaa
aeababaaaaacacaaacadadaaabaeaeaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaa
acaaacaaaaaaaaaaabacppppfbaaaaafaeaaapkaaaaaaaeaaaaaialpaaaaiadp
aaaaaadpfbaaaaafafaaapkaaaaaaaaaaaaaaaedaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaadlabpaaaaacaaaaaaiaacaachla
bpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaaaplabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaac
aaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapkaagaaaaacaaaaaiiaaeaappla
aeaaaaaeaaaaadiaaeaaoelaaaaappiaaeaappkaaiaaaaadabaaaiiaaeaaoela
aeaaoelaabaaaaacabaaadiaabaappiaecaaaaadaaaacpiaaaaaoeiaaaaioeka
ecaaaaadabaacpiaabaaoeiaabaioekaafaaaaadaaaacbiaaaaappiaabaaaaia
fiaaaaaeaaaacbiaaeaakklbafaaaakaaaaaaaiaacaaaaadaaaacbiaaaaaaaia
aaaaaaiaafaaaaadaaaacoiaaaaaaaiaaaaajakaabaaaaacabaaadiaaaaaoola
ecaaaaadacaacpiaabaaoelaadaioekaecaaaaadabaacpiaabaaoeiaaeaioeka
aeaaaaaeabaacdiaabaaohiaaeaaaakaaeaaffkaaeaaaaaeabaaciiaabaaaaia
abaaaaibaeaakkkaaeaaaaaeabaaciiaabaaffiaabaaffibabaappiaahaaaaac
abaaciiaabaappiaagaaaaacabaaceiaabaappiaaiaaaaadabaaciiaacaaoela
acaaoelaahaaaaacabaaciiaabaappiaafaaaaadadaachiaabaappiaacaaoela
aeaaaaaeaeaachiaabaaoeiaadaaffkaadaaoeiaaiaaaaadacaaciiaabaaoeia
adaaoeiaalaaaaadaeaaciiaacaappiaafaaaakaceaaaaacadaachiaadaaoela
aiaaaaadacaabiiaadaaoeiaaeaaoeibaeaaaaaeadaachiaacaaoelaabaappia
adaaoeiaceaaaaacaeaachiaadaaoeiaaiaaaaadabaacbiaabaaoeiaaeaaoeia
alaaaaadadaaabiaabaaaaiaafaaaakacaaaaaadabaaabiaacaappiaadaakkka
abaaaaacafaaajiaadaaoekaaeaaaaaeabaaahiaabaaaaiaafaappiaacaaoeka
afaaaaadaaaaaoiaaaaaoeiaabaajaiaafaaaaadaaaacoiaacaajaiaaaaaoeia
ecaaaaadabaaapiaaaaaoelaacaioekaafaaaaadabaachiaabaaoeiaacaaoeka
afaaaaadaaaacoiaaaaaoeiaabaajaiaafaaaaadabaachiaabaaoeiaaaaaoeka
afaaaaadabaachiaaeaappiaabaaoeiaaeaaaaaeaaaacoiaabaajaiaaaaaaaia
aaaaoeiaafaaaaadabaaabiaafaaaaiaafaaffkacaaaaaadacaaabiaadaaaaia
abaaaaiaabaaaaacabaaahiaaaaaoekaafaaaaadabaaahiaabaaoeiaabaaoeka
afaaaaadabaaahiaacaaaaiaabaaoeiaaeaaaaaeaaaachiaabaaoeiaaaaaaaia
aaaapjiaabaaaaacaaaaaiiaafaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefccaahaaaaeaaaaaaamiabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
aahabaaaaeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
pcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaaaaaaaaakdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaadaaaaaaaagabaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaafaaaaaa
abaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
bcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaa
aaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaa
fgafbaaaaaaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaaapaaaaahbcaabaaa
aaaaaaaaagaabaaaaaaaaaaaagaabaaaabaaaaaadiaaaaaiocaabaaaaaaaaaaa
agaabaaaaaaaaaaaagijcaaaaaaaaaaaabaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaaeaaaaaa
baaaaaahicaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
abaaaaaaegbcbaaaadaaaaaadcaaaaajhcaabaaaadaaaaaaegbcbaaaadaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaogbkbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaeaaaaaadcaaaaapdcaabaaaaeaaaaaa
hgapbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaadcaaaaakicaabaaaabaaaaaaakaabaia
ebaaaaaaaeaaaaaaakaabaaaaeaaaaaaabeaaaaaaaaaiadpdcaaaaakicaabaaa
abaaaaaabkaabaiaebaaaaaaaeaaaaaabkaabaaaaeaaaaaadkaabaaaabaaaaaa
elaaaaafecaabaaaaeaaaaaadkaabaaaabaaaaaadcaaaaakhcaabaaaafaaaaaa
egacbaaaaeaaaaaafgifcaaaaaaaaaaaaiaaaaaaegacbaaaacaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaadeaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaabacaaaaibcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaiaebaaaaaaafaaaaaacpaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackiacaaa
aaaaaaaaaiaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaagaabaaaabaaaaaapgipcaaaaaaaaaaaaiaaaaaaegiccaaa
aaaaaaaaahaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaadaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaacaaaaaaegiccaaa
aaaaaaaaahaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dcaaaaajocaabaaaaaaaaaaaagajbaaaabaaaaaaagaabaaaaaaaaaaafgaobaaa
aaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaa
eeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
agaabaaaabaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
aeaaaaaaegacbaaaabaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaai
ccaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaajocaabaaaabaaaaaaagijcaaaaaaaaaaa
abaaaaaaagijcaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaa
abaaaaaajgahbaaaabaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_TransDistortion]
Float 5 [_TransPower]
Float 6 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_LightTextureB0] 2D 3
SetTexture 4 [_LightTexture0] CUBE 4
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 50 ALU, 5 TEX
PARAM c[8] = { program.local[0..6],
		{ 0, 2, 1, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
MUL R1.xyz, R0.x, fragment.texcoord[2];
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.z, R0.x;
MUL R3.xyz, R0.z, fragment.texcoord[3];
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R0.xy, R0.wyzw, c[7].y, -c[7].z;
ADD R2.xyz, R1, R3;
MUL R0.z, R0.y, R0.y;
MAD R0.z, -R0.x, R0.x, -R0;
DP3 R0.w, R2, R2;
RSQ R0.w, R0.w;
MUL R2.xyz, R0.w, R2;
ADD R0.z, R0, c[7];
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
MAD R4.xyz, R0, c[4].x, R1;
DP3 R1.w, R0, R2;
MOV R0.w, c[7];
MUL R2.x, R0.w, c[3];
MAX R0.w, R1, c[7].x;
POW R0.w, R0.w, R2.x;
MOV R2.xyz, c[1];
MUL R2.xyz, R2, c[0];
MUL R2.xyz, R2, R0.w;
DP3 R1.w, fragment.texcoord[4], fragment.texcoord[4];
DP3_SAT R2.w, R3, -R4;
TEX R1.w, R1.w, texture[3], 2D;
TEX R0.w, fragment.texcoord[4], texture[4], CUBE;
MUL R0.w, R1, R0;
POW R1.w, R2.w, c[5].x;
MUL R0.w, R0, c[7].y;
MUL R2.w, R1, c[6].x;
DP3 R1.w, R0, R1;
ADD R1.xyz, R2.w, c[2];
MUL R0.xyz, R0.w, c[0];
MUL R3.xyz, R0, R1;
TEX R1.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[2];
MUL R1.xyz, R3, R1;
MUL R1.xyz, R0, R1;
MUL R2.xyz, R0.w, R2;
MAX R1.w, R1, c[7].x;
MUL R0.xyz, R0, c[0];
MUL R0.xyz, R0, R1.w;
MAD R0.xyz, R0, R0.w, R1;
ADD result.color.xyz, R0, R2;
MOV result.color.w, c[7].x;
END
# 50 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_TransDistortion]
Float 5 [_TransPower]
Float 6 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_LightTextureB0] 2D 3
SetTexture 4 [_LightTexture0] CUBE 4
"ps_3_0
; 51 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
def c7, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c8, 128.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c7.x, c7.y
mul_pp r0.w, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v2
dp3_pp r0.x, v3, v3
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v3
add_pp r0.xyz, r3, r2
dp3_pp r1.z, r0, r0
rsq_pp r1.z, r1.z
add_pp r0.w, r0, c7.z
mul_pp r0.xyz, r1.z, r0
rsq_pp r0.w, r0.w
rcp_pp r1.z, r0.w
dp3_pp r0.x, r1, r0
mov_pp r0.w, c3.x
mul_pp r2.w, c8.x, r0
max_pp r1.w, r0.x, c7
pow r0, r1.w, r2.w
mad r0.yzw, r1.xxyz, c4.x, r3.xxyz
dp3_pp_sat r0.w, r2, -r0.yzww
mov r1.w, r0.x
pow r2, r0.w, c5.x
mov_pp r0.xyz, c0
mul_pp r0.xyz, c1, r0
mul r2.yzw, r0.xxyz, r1.w
mov r1.w, r2.x
mul r2.x, r1.w, c6
dp3_pp r1.w, r1, r3
dp3 r0.x, v4, v4
texld r0.w, v4, s4
texld r0.x, r0.x, s3
mul r0.x, r0, r0.w
mul_pp r0.w, r0.x, c7.x
mul r0.xyz, r0.w, r2.yzww
add r2.xyz, r2.x, c2
mul_pp r1.xyz, r0.w, c0
mul r3.xyz, r1, r2
texld r2.xyz, v1, s2
texld r1.xyz, v0, s0
mul r1.xyz, r1, c2
mul r2.xyz, r3, r2
mul_pp r2.xyz, r1, r2
max_pp r1.w, r1, c7
mul_pp r1.xyz, r1, c0
mul_pp r1.xyz, r1, r1.w
mad_pp r1.xyz, r1, r0.w, r2
add_pp oC0.xyz, r1, r0
mov_pp oC0.w, c7
"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpMap] 2D 4
SetTexture 2 [_TransMap] 2D 3
SetTexture 3 [_LightTextureB0] 2D 1
SetTexture 4 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 132 [_TransDistortion]
Float 136 [_TransPower]
Float 140 [_TransScale]
BindCB  "$Globals" 0
"ps_4_0
eefiecedfdgpmiocjflbmoaphfmlccmhaahmaifiabaaaaaakiahaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefciiagaaaa
eaaaaaaakcabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafidaaaaeaahabaaaaeaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegbcbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegbcbaaaadaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogbkbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaeaaaaaadcaaaaapdcaabaaaadaaaaaa
hgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaia
ebaaaaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaiadpdcaaaaakicaabaaa
aaaaaaaabkaabaiaebaaaaaaadaaaaaabkaabaaaadaaaaaadkaabaaaaaaaaaaa
elaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaaaeaaaaaa
egacbaaaadaaaaaafgifcaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaabacaaaaibcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaaeaaaaaacpaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaa
aaaaaaaaaiaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaagaabaaaaaaaaaaapgipcaaaaaaaaaaaaiaaaaaaegiccaaa
aaaaaaaaahaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaa
afaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaaeghobaaaadaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaegbcbaaaafaaaaaaeghobaaa
aeaaaaaaaagabaaaaaaaaaaaapaaaaahbcaabaaaabaaaaaaagaabaaaabaaaaaa
pgapbaaaaeaaaaaadiaaaaaiocaabaaaabaaaaaaagaabaaaabaaaaaaagijcaaa
aaaaaaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaajgahbaaa
abaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaadaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aeaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaadiaaaaaiocaabaaaabaaaaaaagajbaaaaeaaaaaaagijcaaa
aaaaaaaaahaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaajgahbaaa
abaaaaaadiaaaaaiocaabaaaabaaaaaafgaobaaaabaaaaaaagijcaaaaaaaaaaa
abaaaaaadiaaaaahocaabaaaabaaaaaapgapbaaaaaaaaaaafgaobaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaajgahbaaaabaaaaaaagaabaaaabaaaaaaegacbaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahocaabaaaabaaaaaa
pgapbaaaaaaaaaaaagajbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
adaaaaaajgahbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
ccaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaabjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaajocaabaaaabaaaaaaagijcaaaaaaaaaaa
abaaaaaaagijcaaaaaaaaaaaacaaaaaadiaaaaahocaabaaaabaaaaaapgapbaaa
aaaaaaaafgaobaaaabaaaaaadcaaaaajhccabaaaaaaaaaaajgahbaaaabaaaaaa
agaabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpMap] 2D 4
SetTexture 2 [_TransMap] 2D 3
SetTexture 3 [_LightTextureB0] 2D 1
SetTexture 4 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 132 [_TransDistortion]
Float 136 [_TransPower]
Float 140 [_TransScale]
BindCB  "$Globals" 0
"ps_4_0_level_9_3
eefiecedaogojjbadbhhlpnjanjehdhofaboleopabaaaaaahmalaaaaaeaaaaaa
daaaaaaaaaaeaaaajaakaaaaeialaaaaebgpgodjmiadaaaamiadaaaaaaacpppp
hiadaaaafaaaaaaaacaadiaaaaaafaaaaaaafaaaafaaceaaaaaafaaaaeaaaaaa
adababaaaaacacaaacadadaaabaeaeaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaa
acaaacaaaaaaaaaaabacppppfbaaaaafaeaaapkaaaaaaaeaaaaaialpaaaaiadp
aaaaaaaafbaaaaafafaaapkaaaaaaaedaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaadlabpaaaaacaaaaaaiaacaachla
bpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaaahlabpaaaaacaaaaaaji
aaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaac
aaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapkaaiaaaaadaaaaaiiaaeaaoela
aeaaoelaabaaaaacaaaaadiaaaaappiaecaaaaadabaaapiaaeaaoelaaaaioeka
ecaaaaadaaaaapiaaaaaoeiaabaioekafkaaaaaeaaaacbiaaaaaaaiaabaappia
aeaappkaafaaaaadaaaacoiaaaaaaaiaaaaajakaabaaaaacabaaadiaaaaaoola
ecaaaaadacaacpiaabaaoelaadaioekaecaaaaadabaacpiaabaaoeiaaeaioeka
aeaaaaaeabaacdiaabaaohiaaeaaaakaaeaaffkaaeaaaaaeabaaciiaabaaaaia
abaaaaibaeaakkkaaeaaaaaeabaaciiaabaaffiaabaaffibabaappiaahaaaaac
abaaciiaabaappiaagaaaaacabaaceiaabaappiaaiaaaaadabaaciiaacaaoela
acaaoelaahaaaaacabaaciiaabaappiaafaaaaadadaachiaabaappiaacaaoela
aeaaaaaeaeaachiaabaaoeiaadaaffkaadaaoeiaaiaaaaadacaaciiaabaaoeia
adaaoeiaalaaaaadaeaaciiaacaappiaaeaappkaceaaaaacadaachiaadaaoela
aiaaaaadacaabiiaadaaoeiaaeaaoeibaeaaaaaeadaachiaacaaoelaabaappia
adaaoeiaceaaaaacaeaachiaadaaoeiaaiaaaaadabaacbiaabaaoeiaaeaaoeia
alaaaaadadaaabiaabaaaaiaaeaappkacaaaaaadabaaabiaacaappiaadaakkka
abaaaaacafaaajiaadaaoekaaeaaaaaeabaaahiaabaaaaiaafaappiaacaaoeka
afaaaaadaaaaaoiaaaaaoeiaabaajaiaafaaaaadaaaacoiaacaajaiaaaaaoeia
ecaaaaadabaaapiaaaaaoelaacaioekaafaaaaadabaachiaabaaoeiaacaaoeka
afaaaaadaaaacoiaaaaaoeiaabaajaiaafaaaaadabaachiaabaaoeiaaaaaoeka
afaaaaadabaachiaaeaappiaabaaoeiaaeaaaaaeaaaacoiaabaajaiaaaaaaaia
aaaaoeiaafaaaaadabaaabiaafaaaaiaafaaaakacaaaaaadacaaabiaadaaaaia
abaaaaiaabaaaaacabaaahiaaaaaoekaafaaaaadabaaahiaabaaoeiaabaaoeka
afaaaaadabaaahiaacaaaaiaabaaoeiaaeaaaaaeaaaachiaabaaoeiaaaaaaaia
aaaapjiaabaaaaacaaaaciiaaeaappkaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefciiagaaaaeaaaaaaakcabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafidaaaae
aahabaaaaeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egbcbaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaa
adaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegbcbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaa
egbcbaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
adaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaeaaaaaadcaaaaap
dcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadcaaaaakicaabaaa
aaaaaaaaakaabaiaebaaaaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaiadp
dcaaaaakicaabaaaaaaaaaaabkaabaiaebaaaaaaadaaaaaabkaabaaaadaaaaaa
dkaabaaaaaaaaaaaelaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaadcaaaaak
hcaabaaaaeaaaaaaegacbaaaadaaaaaafgifcaaaaaaaaaaaaiaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaabacaaaai
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaaeaaaaaacpaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaackiacaaaaaaaaaaaaiaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaalhcaabaaaaaaaaaaaagaabaaaaaaaaaaapgipcaaaaaaaaaaa
aiaaaaaaegiccaaaaaaaaaaaahaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaa
eghobaaaadaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaegbcbaaa
afaaaaaaeghobaaaaeaaaaaaaagabaaaaaaaaaaaapaaaaahbcaabaaaabaaaaaa
agaabaaaabaaaaaapgapbaaaaeaaaaaadiaaaaaiocaabaaaabaaaaaaagaabaaa
abaaaaaaagijcaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaajgahbaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaadaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaeaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaaiocaabaaaabaaaaaaagajbaaa
aeaaaaaaagijcaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaajgahbaaaabaaaaaadiaaaaaiocaabaaaabaaaaaafgaobaaaabaaaaaa
agijcaaaaaaaaaaaabaaaaaadiaaaaahocaabaaaabaaaaaapgapbaaaaaaaaaaa
fgaobaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaajgahbaaaabaaaaaaagaabaaa
abaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
ocaabaaaabaaaaaapgapbaaaaaaaaaaaagajbaaaacaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaadaaaaaajgahbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaiccaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaa
aaaaaaeddiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaa
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaajocaabaaaabaaaaaa
agijcaaaaaaaaaaaabaaaaaaagijcaaaaaaaaaaaacaaaaaadiaaaaahocaabaaa
abaaaaaapgapbaaaaaaaaaaafgaobaaaabaaaaaadcaaaaajhccabaaaaaaaaaaa
jgahbaaaabaaaaaaagaabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaa
keaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_TransDistortion]
Float 5 [_TransPower]
Float 6 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 44 ALU, 4 TEX
PARAM c[8] = { program.local[0..6],
		{ 0, 2, 1, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R0.wyzw, c[7].y, -c[7].z;
MUL R0.x, R1.y, R1.y;
MAD R0.x, -R1, R1, -R0;
ADD R0.x, R0, c[7].z;
RSQ R0.w, R0.x;
RCP R1.z, R0.w;
DP3 R0.y, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.y, R0.y;
MUL R0.xyz, R0.y, fragment.texcoord[3];
ADD R3.xyz, fragment.texcoord[2], R0;
MAD R2.xyz, R1, c[4].x, fragment.texcoord[2];
DP3_SAT R0.x, R0, -R2;
DP3 R0.w, R3, R3;
RSQ R0.y, R0.w;
MUL R2.xyz, R0.y, R3;
DP3 R0.y, R1, R2;
POW R0.x, R0.x, c[5].x;
MUL R1.w, R0.x, c[6].x;
MOV R0.x, c[7].w;
ADD R3.xyz, R1.w, c[2];
DP3 R1.w, R1, fragment.texcoord[2];
MAX R0.w, R0.y, c[7].x;
MUL R2.x, R0, c[3];
POW R2.x, R0.w, R2.x;
MOV R0.xyz, c[1];
MUL R0.xyz, R0, c[0];
TEX R0.w, fragment.texcoord[4], texture[3], 2D;
MUL R0.xyz, R0, R2.x;
MUL R0.w, R0, c[7].y;
MUL R4.xyz, R0.w, R0;
MUL R2.xyz, R0.w, c[0];
TEX R0.xyz, fragment.texcoord[1], texture[2], 2D;
MUL R2.xyz, R2, R3;
MUL R2.xyz, R2, R0;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[2];
MUL R1.xyz, R0, R2;
MAX R1.w, R1, c[7].x;
MUL R0.xyz, R0, c[0];
MUL R0.xyz, R0, R1.w;
MAD R0.xyz, R0, R0.w, R1;
ADD result.color.xyz, R0, R4;
MOV result.color.w, c[7].x;
END
# 44 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_TransDistortion]
Float 5 [_TransPower]
Float 6 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
"ps_3_0
; 46 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c7, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c8, 128.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xy
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c7.x, c7.y
mul_pp r0.x, r1.y, r1.y
mad_pp r0.x, -r1, r1, -r0
add_pp r0.x, r0, c7.z
rsq_pp r0.x, r0.x
rcp_pp r1.z, r0.x
dp3_pp r0.y, v3, v3
rsq_pp r0.x, r0.y
mad r2.xyz, r1, c4.x, v2
mul_pp r0.xyz, r0.x, v3
dp3_pp_sat r1.w, r0, -r2
add_pp r2.xyz, v2, r0
pow r0, r1.w, c5.x
dp3_pp r0.y, r2, r2
mov r1.w, r0.x
mul r1.w, r1, c6.x
add r3.xyz, r1.w, c2
dp3_pp r1.w, r1, v2
rsq_pp r0.y, r0.y
mul_pp r0.xyz, r0.y, r2
dp3_pp r0.x, r1, r0
mov_pp r0.w, c3.x
mul_pp r2.y, c8.x, r0.w
max_pp r2.x, r0, c7.w
pow r0, r2.x, r2.y
texld r0.w, v4, s3
mul_pp r0.w, r0, c7.x
mov_pp r2.xyz, c0
mov r2.w, r0.x
mul_pp r0.xyz, c1, r2
mul r0.xyz, r0, r2.w
mul r4.xyz, r0.w, r0
mul_pp r2.xyz, r0.w, c0
texld r0.xyz, v1, s2
mul r2.xyz, r2, r3
mul r2.xyz, r2, r0
texld r0.xyz, v0, s0
mul r0.xyz, r0, c2
mul_pp r1.xyz, r0, r2
max_pp r1.w, r1, c7
mul_pp r0.xyz, r0, c0
mul_pp r0.xyz, r0, r1.w
mad_pp r0.xyz, r0, r0.w, r1
add_pp oC0.xyz, r0, r4
mov_pp oC0.w, c7
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 3
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 132 [_TransDistortion]
Float 136 [_TransPower]
Float 140 [_TransScale]
BindCB  "$Globals" 0
"ps_4_0
eefiecedndfjodfblpoogcdboncfingakneilkfnabaaaaaaaaahaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoaafaaaa
eaaaaaaahiabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadmcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaaagaabaaaaaaaaaaaagbjbaaa
aeaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaaeaaaaaaagaabaaaaaaaaaaa
egbcbaaaadaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaa
akaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaakbcaabaaaaaaaaaaabkaabaia
ebaaaaaaacaaaaaabkaabaaaacaaaaaaakaabaaaaaaaaaaaelaaaaafecaabaaa
acaaaaaaakaabaaaaaaaaaaadcaaaaakhcaabaaaadaaaaaaegacbaaaacaaaaaa
fgifcaaaaaaaaaaaaiaaaaaaegbcbaaaadaaaaaabacaaaaibcaabaaaaaaaaaaa
jgahbaaaaaaaaaaaegacbaiaebaaaaaaadaaaaaacpaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaa
aaaaaaaaaiaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaagaabaaaaaaaaaaapgipcaaaaaaaaaaaaiaaaaaaegiccaaa
aaaaaaaaahaaaaaaefaaaaajpcaabaaaadaaaaaaogbkbaaaacaaaaaaeghobaaa
adaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaadaaaaaa
dkaabaaaadaaaaaadiaaaaaihcaabaaaadaaaaaapgapbaaaaaaaaaaaegiccaaa
aaaaaaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
adaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
adaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadiaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaaegiccaaa
aaaaaaaaahaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
adaaaaaadiaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaaegiccaaaaaaaaaaa
abaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaaegbcbaaaadaaaaaa
deaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaah
hcaabaaaadaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
cpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaa
akiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaajocaabaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaa
aaaaaaaaacaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaajgahbaaa
abaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 3
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 132 [_TransDistortion]
Float 136 [_TransPower]
Float 140 [_TransScale]
BindCB  "$Globals" 0
"ps_4_0_level_9_3
eefiecedbbemfbappibcnolomcfgjdemhopijmkeabaaaaaajeakaaaaaeaaaaaa
daaaaaaamaadaaaakiajaaaagaakaaaaebgpgodjiiadaaaaiiadaaaaaaacpppp
dmadaaaaemaaaaaaacaadeaaaaaaemaaaaaaemaaaeaaceaaaaaaemaaadaaaaaa
aaababaaacacacaaabadadaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaaacaaacaa
aaaaaaaaabacppppfbaaaaafaeaaapkaaaaaaaeaaaaaialpaaaaiadpaaaaaaaa
fbaaaaafafaaapkaaaaaaaedaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaiaacaachlabpaaaaac
aaaaaaiaadaachlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
bpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkaaiaaaaadaaaaciia
adaaoelaadaaoelaahaaaaacaaaacbiaaaaappiaafaaaaadaaaacoiaaaaaaaia
adaajalaabaaaaacabaaahiaadaaoelaaeaaaaaeabaachiaabaaoeiaaaaaaaia
acaaoelaceaaaaacacaachiaabaaoeiaabaaaaacabaaadiaaaaaoolaabaaaaac
adaaadiaabaaollaecaaaaadabaacpiaabaaoeiaadaioekaecaaaaadadaacpia
adaaoeiaaaaioekaaeaaaaaeabaacdiaabaaohiaaeaaaakaaeaaffkaaeaaaaae
abaaciiaabaaaaiaabaaaaibaeaakkkaaeaaaaaeabaaciiaabaaffiaabaaffib
abaappiaahaaaaacabaaciiaabaappiaagaaaaacabaaceiaabaappiaaeaaaaae
adaachiaabaaoeiaadaaffkaacaaoelaaiaaaaadabaabiiaaaaapjiaadaaoeib
caaaaaadacaaaiiaabaappiaadaakkkaabaaaaacaaaaajiaadaaoekaaeaaaaae
aaaaaoiaacaappiaaaaappiaacaajakaacaaaaadabaaciiaadaappiaadaappia
afaaaaadadaachiaabaappiaaaaaoekaafaaaaadaaaaaoiaaaaaoeiaadaajaia
ecaaaaadadaaapiaaaaaoelaabaioekaecaaaaadaeaacpiaabaaoelaacaioeka
afaaaaadaaaacoiaaaaaoeiaaeaajaiaafaaaaadadaachiaadaaoeiaacaaoeka
afaaaaadaaaacoiaaaaaoeiaadaajaiaafaaaaadadaachiaadaaoeiaaaaaoeka
aiaaaaadacaaciiaabaaoeiaacaaoelaaiaaaaadadaaciiaabaaoeiaacaaoeia
alaaaaadabaaabiaadaappiaaeaappkaalaaaaadadaaciiaacaappiaaeaappka
afaaaaadacaachiaadaappiaadaaoeiaaeaaaaaeaaaacoiaacaajaiaabaappia
aaaaoeiaafaaaaadaaaaabiaaaaaaaiaafaaaakacaaaaaadacaaabiaabaaaaia
aaaaaaiaabaaaaacabaaahiaaaaaoekaafaaaaadabaaahiaabaaoeiaabaaoeka
afaaaaadabaaahiaacaaaaiaabaaoeiaaeaaaaaeaaaachiaabaaoeiaabaappia
aaaapjiaabaaaaacaaaaciiaaeaappkaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcoaafaaaaeaaaaaaahiabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaaagaabaaa
aaaaaaaaagbjbaaaaeaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaaeaaaaaa
agaabaaaaaaaaaaaegbcbaaaadaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaaacaaaaaa
hgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaia
ebaaaaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaakbcaabaaa
aaaaaaaabkaabaiaebaaaaaaacaaaaaabkaabaaaacaaaaaaakaabaaaaaaaaaaa
elaaaaafecaabaaaacaaaaaaakaabaaaaaaaaaaadcaaaaakhcaabaaaadaaaaaa
egacbaaaacaaaaaafgifcaaaaaaaaaaaaiaaaaaaegbcbaaaadaaaaaabacaaaai
bcaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaiaebaaaaaaadaaaaaacpaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaackiacaaaaaaaaaaaaiaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaalhcaabaaaaaaaaaaaagaabaaaaaaaaaaapgipcaaaaaaaaaaa
aiaaaaaaegiccaaaaaaaaaaaahaaaaaaefaaaaajpcaabaaaadaaaaaaogbkbaaa
acaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaadaaaaaadkaabaaaadaaaaaadiaaaaaihcaabaaaadaaaaaapgapbaaa
aaaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaaihcaabaaaadaaaaaaegacbaaa
adaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaadaaaaaadiaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaa
egiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaa
egbcbaaaadaaaaaadeaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaadaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaai
ccaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaajocaabaaaabaaaaaaagijcaaaaaaaaaaa
abaaaaaaagijcaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaa
abaaaaaajgahbaaaabaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
keaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Vector 0 [_LightShadowData]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_TransDistortion]
Float 6 [_TransPower]
Float 7 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
SetTexture 4 [_LightTextureB0] 2D 4
SetTexture 5 [_ShadowMapTexture] 2D 5
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 60 ALU, 6 TEX
PARAM c[10] = { program.local[0..7],
		{ 0, 2, 1, 0.5 },
		{ 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R0.wyzw, c[8].y, -c[8].z;
MUL R0.w, R1.y, R1.y;
MAD R0.w, -R1.x, R1.x, -R0;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
MUL R2.xyz, R0.x, fragment.texcoord[2];
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[3];
ADD R3.xyz, R2, R0;
DP3 R1.z, R3, R3;
RSQ R1.z, R1.z;
ADD R0.w, R0, c[8].z;
MUL R3.xyz, R1.z, R3;
RSQ R0.w, R0.w;
RCP R1.z, R0.w;
DP3 R1.w, R1, R3;
MAD R4.xyz, R1, c[5].x, R2;
DP3_SAT R0.z, R0, -R4;
MOV R0.w, c[9].x;
MUL R2.w, R0, c[4].x;
MAX R0.w, R1, c[8].x;
MOV R3.xyz, c[2];
DP3 R1.w, fragment.texcoord[4], fragment.texcoord[4];
POW R0.w, R0.w, R2.w;
MUL R3.xyz, R3, c[1];
MUL R3.xyz, R3, R0.w;
TXP R0.x, fragment.texcoord[5], texture[5], 2D;
RCP R0.y, fragment.texcoord[5].w;
MAD R0.w, -fragment.texcoord[5].z, R0.y, R0.x;
MOV R0.x, c[8].z;
CMP R2.w, R0, c[0].x, R0.x;
RCP R0.y, fragment.texcoord[4].w;
MAD R0.xy, fragment.texcoord[4], R0.y, c[8].w;
TEX R0.w, R0, texture[3], 2D;
SLT R0.x, c[8], fragment.texcoord[4].z;
MUL R0.x, R0, R0.w;
TEX R1.w, R1.w, texture[4], 2D;
MUL R0.x, R0, R1.w;
MUL R0.x, R0, R2.w;
POW R1.w, R0.z, c[6].x;
MUL R0.w, R0.x, c[8].y;
MUL R2.w, R1, c[7].x;
DP3 R1.w, R1, R2;
MUL R0.xyz, R0.w, R3;
ADD R2.xyz, R2.w, c[3];
MUL R1.xyz, R0.w, c[1];
MUL R3.xyz, R1, R2;
TEX R2.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R1.xyz, R1, c[3];
MUL R2.xyz, R3, R2;
MUL R2.xyz, R1, R2;
MAX R1.w, R1, c[8].x;
MUL R1.xyz, R1, c[1];
MUL R1.xyz, R1, R1.w;
MAD R1.xyz, R1, R0.w, R2;
ADD result.color.xyz, R1, R0;
MOV result.color.w, c[8].x;
END
# 60 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Vector 0 [_LightShadowData]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_TransDistortion]
Float 6 [_TransPower]
Float 7 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
SetTexture 4 [_LightTextureB0] 2D 4
SetTexture 5 [_ShadowMapTexture] 2D 5
"ps_3_0
; 60 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c8, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c9, 0.50000000, 128.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
dcl_texcoord5 v5
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c8.x, c8.y
mul_pp r0.w, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v2
dp3_pp r0.x, v3, v3
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v3
add_pp r0.xyz, r2, r3
dp3_pp r1.z, r0, r0
rsq_pp r1.z, r1.z
add_pp r0.w, r0, c8.z
mul_pp r0.xyz, r1.z, r0
rsq_pp r0.w, r0.w
rcp_pp r1.z, r0.w
dp3_pp r0.x, r1, r0
mov_pp r0.w, c4.x
mul_pp r2.w, c9.y, r0
max_pp r1.w, r0.x, c8
pow r0, r1.w, r2.w
mad r0.yzw, r1.xxyz, c5.x, r2.xxyz
dp3_pp_sat r0.w, r3, -r0.yzww
mov r1.w, r0.x
mov_pp r0.xyz, c1
mul_pp r0.xyz, c2, r0
pow r3, r0.w, c6.x
mul r3.yzw, r0.xxyz, r1.w
mov r1.w, r3.x
mul r2.w, r1, c7.x
dp3_pp r1.w, r1, r2
texldp r0.x, v5, s5
rcp r0.y, v5.w
mad r0.y, -v5.z, r0, r0.x
mov r0.z, c0.x
cmp r0.y, r0, c8.z, r0.z
rcp r0.x, v4.w
mad r4.xy, v4, r0.x, c9.x
dp3 r0.x, v4, v4
texld r0.w, r4, s3
cmp r0.z, -v4, c8.w, c8
mul_pp r0.z, r0, r0.w
texld r0.x, r0.x, s4
mul_pp r0.x, r0.z, r0
mul_pp r0.x, r0, r0.y
mul_pp r0.w, r0.x, c8.x
mul r0.xyz, r0.w, r3.yzww
add r2.xyz, r2.w, c3
mul_pp r1.xyz, r0.w, c1
mul r3.xyz, r1, r2
texld r2.xyz, v1, s2
texld r1.xyz, v0, s0
mul r1.xyz, r1, c3
mul r2.xyz, r3, r2
mul_pp r2.xyz, r1, r2
max_pp r1.w, r1, c8
mul_pp r1.xyz, r1, c1
mul_pp r1.xyz, r1, r1.w
mad_pp r1.xyz, r1, r0.w, r2
add_pp oC0.xyz, r1, r0
mov_pp oC0.w, c8
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
SetTexture 0 [_MainTex] 2D 3
SetTexture 1 [_BumpMap] 2D 5
SetTexture 2 [_TransMap] 2D 4
SetTexture 3 [_LightTexture0] 2D 1
SetTexture 4 [_LightTextureB0] 2D 2
SetTexture 5 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 132 [_TransDistortion]
Float 136 [_TransPower]
Float 140 [_TransScale]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityShadows" 1
"ps_4_0
eefiecedobdnccfcfmpalmhibhpjjkagdlhlndphabaaaaaadaajaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpiahaaaaeaaaaaaapoabaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaabjaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaad
aagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaa
afaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadpcbabaaa
afaaaaaagcbaaaadpcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
agaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaa
aaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
adaaaaaaaagabaaaabaaaaaadbaaaaahbcaabaaaaaaaaaaaabeaaaaaaaaaaaaa
ckbabaaaafaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaa
baaaaaahccaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaefaaaaaj
pcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaaaeaaaaaaaagabaaaacaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaaaoaaaaah
ocaabaaaaaaaaaaaagbjbaaaagaaaaaapgbpbaaaagaaaaaaefaaaaajpcaabaaa
abaaaaaajgafbaaaaaaaaaaaeghobaaaafaaaaaaaagabaaaaaaaaaaadbaaaaah
ccaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaadhaaaaakccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaabiaaaaaaabeaaaaaaaaaiadp
apaaaaahbcaabaaaaaaaaaaaagaabaaaaaaaaaaafgafbaaaaaaaaaaadiaaaaai
ocaabaaaaaaaaaaaagaabaaaaaaaaaaaagijcaaaaaaaaaaaabaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaa
egbcbaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaaa
adaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaabaaaaaaegbcbaaaadaaaaaadcaaaaajhcaabaaaadaaaaaa
egbcbaaaadaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
aeaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaafaaaaaadcaaaaap
dcaabaaaaeaaaaaahgapbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadcaaaaakicaabaaa
abaaaaaaakaabaiaebaaaaaaaeaaaaaaakaabaaaaeaaaaaaabeaaaaaaaaaiadp
dcaaaaakicaabaaaabaaaaaabkaabaiaebaaaaaaaeaaaaaabkaabaaaaeaaaaaa
dkaabaaaabaaaaaaelaaaaafecaabaaaaeaaaaaadkaabaaaabaaaaaadcaaaaak
hcaabaaaafaaaaaaegacbaaaaeaaaaaafgifcaaaaaaaaaaaaiaaaaaaegacbaaa
acaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaa
deaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaabacaaaai
bcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaafaaaaaacpaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaa
abaaaaaackiacaaaaaaaaaaaaiaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaagaabaaaabaaaaaapgipcaaaaaaaaaaa
aiaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaa
aaaaaaaaagajbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaaeaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaa
aaaaaaaaagajbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
acaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaa
aaaaaaaaagajbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaabaaaaaaagaabaaa
aaaaaaaafgaobaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaa
egacbaaaadaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaa
abaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaadeaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaaiccaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaa
aaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
bjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaajocaabaaaabaaaaaa
agijcaaaaaaaaaaaabaaaaaaagijcaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaa
abaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Vector 0 [_LightShadowData]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_TransDistortion]
Float 6 [_TransPower]
Float 7 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
SetTexture 4 [_LightTextureB0] 2D 4
SetTexture 5 [_ShadowMapTexture] 2D 5
"ps_3_0
; 59 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c8, 2.00000000, -1.00000000, 0.00000000, 1.00000000
def c9, 0.50000000, 128.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
dcl_texcoord5 v5
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c8.x, c8.y
mul_pp r0.w, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v2
dp3_pp r0.x, v3, v3
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v3
add_pp r0.xyz, r2, r3
dp3_pp r1.z, r0, r0
rsq_pp r1.z, r1.z
add_pp r0.w, r0, c8
mul_pp r0.xyz, r1.z, r0
rsq_pp r0.w, r0.w
rcp_pp r1.z, r0.w
dp3_pp r0.x, r1, r0
mov_pp r0.w, c4.x
mul_pp r2.w, c9.y, r0
max_pp r1.w, r0.x, c8.z
pow r0, r1.w, r2.w
mad r0.yzw, r1.xxyz, c5.x, r2.xxyz
dp3_pp_sat r0.w, r3, -r0.yzww
mov r1.w, r0.x
mov_pp r0.xyz, c1
mul_pp r0.xyz, c2, r0
pow r3, r0.w, c6.x
mul r3.yzw, r0.xxyz, r1.w
mov r1.w, r3.x
mov r0.x, c0
rcp r0.z, v4.w
mad r4.xy, v4, r0.z, c9.x
add r0.y, c8.w, -r0.x
texldp r0.x, v5, s5
mad r0.y, r0.x, r0, c0.x
mul r2.w, r1, c7.x
dp3_pp r1.w, r1, r2
dp3 r0.x, v4, v4
texld r0.w, r4, s3
cmp r0.z, -v4, c8, c8.w
mul_pp r0.z, r0, r0.w
texld r0.x, r0.x, s4
mul_pp r0.x, r0.z, r0
mul_pp r0.x, r0, r0.y
mul_pp r0.w, r0.x, c8.x
mul r0.xyz, r0.w, r3.yzww
add r2.xyz, r2.w, c3
mul_pp r1.xyz, r0.w, c1
mul r3.xyz, r1, r2
texld r2.xyz, v1, s2
texld r1.xyz, v0, s0
mul r1.xyz, r1, c3
mul r2.xyz, r3, r2
mul_pp r2.xyz, r1, r2
max_pp r1.w, r1, c8.z
mul_pp r1.xyz, r1, c1
mul_pp r1.xyz, r1, r1.w
mad_pp r1.xyz, r1, r0.w, r2
add_pp oC0.xyz, r1, r0
mov_pp oC0.w, c8.z
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
SetTexture 0 [_MainTex] 2D 3
SetTexture 1 [_BumpMap] 2D 5
SetTexture 2 [_TransMap] 2D 4
SetTexture 3 [_LightTexture0] 2D 1
SetTexture 4 [_LightTextureB0] 2D 2
SetTexture 5 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 132 [_TransDistortion]
Float 136 [_TransPower]
Float 140 [_TransScale]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityShadows" 1
"ps_4_0
eefiecedbkcognickkfppamnhjhfpfjkeikglgnhabaaaaaaeaajaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaiaiaaaaeaaaaaaaacacaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaabjaaaaaa
fkaiaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaad
aagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaa
afaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadpcbabaaa
afaaaaaagcbaaaadpcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
agaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaa
aaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
adaaaaaaaagabaaaabaaaaaadbaaaaahbcaabaaaaaaaaaaaabeaaaaaaaaaaaaa
ckbabaaaafaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaa
baaaaaahccaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaefaaaaaj
pcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaaaeaaaaaaaagabaaaacaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaaaoaaaaah
ocaabaaaaaaaaaaaagbjbaaaagaaaaaapgbpbaaaagaaaaaaehaaaaalccaabaaa
aaaaaaaajgafbaaaaaaaaaaaaghabaaaafaaaaaaaagabaaaaaaaaaaadkaabaaa
aaaaaaaaaaaaaaajecaabaaaaaaaaaaaakiacaiaebaaaaaaabaaaaaabiaaaaaa
abeaaaaaaaaaiadpdcaaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaaakiacaaaabaaaaaabiaaaaaaapaaaaahbcaabaaaaaaaaaaaagaabaaa
aaaaaaaafgafbaaaaaaaaaaadiaaaaaiocaabaaaaaaaaaaaagaabaaaaaaaaaaa
agijcaaaaaaaaaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaa
egbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaaeaaaaaabaaaaaahicaabaaa
abaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegbcbaaa
adaaaaaadcaaaaajhcaabaaaadaaaaaaegbcbaaaadaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaafaaaaaadcaaaaapdcaabaaaaeaaaaaahgapbaaaaeaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaadcaaaaakicaabaaaabaaaaaaakaabaiaebaaaaaaaeaaaaaa
akaabaaaaeaaaaaaabeaaaaaaaaaiadpdcaaaaakicaabaaaabaaaaaabkaabaia
ebaaaaaaaeaaaaaabkaabaaaaeaaaaaadkaabaaaabaaaaaaelaaaaafecaabaaa
aeaaaaaadkaabaaaabaaaaaadcaaaaakhcaabaaaafaaaaaaegacbaaaaeaaaaaa
fgifcaaaaaaaaaaaaiaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaaeaaaaaaegacbaaaacaaaaaadeaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaaabacaaaaibcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaiaebaaaaaaafaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackiacaaaaaaaaaaaaiaaaaaa
bjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
agaabaaaabaaaaaapgipcaaaaaaaaaaaaiaaaaaaegiccaaaaaaaaaaaahaaaaaa
diaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaeaaaaaa
diaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaadaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaahaaaaaa
diaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadcaaaaajocaabaaa
aaaaaaaaagajbaaaabaaaaaaagaabaaaaaaaaaaafgaobaaaaaaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaa
egacbaaaadaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaa
abaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
cpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaa
akiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaajocaabaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaa
aaaaaaaaacaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaajgahbaaa
abaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaa
jgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_TransDistortion]
Float 5 [_TransPower]
Float 6 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_ShadowMapTexture] 2D 3
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 44 ALU, 4 TEX
PARAM c[8] = { program.local[0..6],
		{ 0, 2, 1, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R0.wyzw, c[7].y, -c[7].z;
MUL R0.x, R1.y, R1.y;
MAD R0.x, -R1, R1, -R0;
ADD R0.x, R0, c[7].z;
RSQ R0.w, R0.x;
RCP R1.z, R0.w;
DP3 R1.w, R1, fragment.texcoord[2];
DP3 R0.y, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.y, R0.y;
MUL R0.xyz, R0.y, fragment.texcoord[3];
ADD R3.xyz, fragment.texcoord[2], R0;
MAD R2.xyz, R1, c[4].x, fragment.texcoord[2];
DP3_SAT R0.x, R0, -R2;
DP3 R0.w, R3, R3;
RSQ R0.y, R0.w;
MUL R2.xyz, R0.y, R3;
DP3 R0.z, R1, R2;
POW R0.x, R0.x, c[5].x;
MUL R0.y, R0.x, c[6].x;
MOV R0.x, c[7].w;
MOV R2.xyz, c[1];
MUL R0.x, R0, c[3];
MAX R0.z, R0, c[7].x;
POW R0.z, R0.z, R0.x;
TXP R0.x, fragment.texcoord[4], texture[3], 2D;
MUL R2.xyz, R2, c[0];
MUL R2.xyz, R2, R0.z;
MUL R0.w, R0.x, c[7].y;
MUL R4.xyz, R0.w, R2;
ADD R3.xyz, R0.y, c[2];
MUL R2.xyz, R0.w, c[0];
TEX R0.xyz, fragment.texcoord[1], texture[2], 2D;
MUL R2.xyz, R2, R3;
MUL R2.xyz, R2, R0;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[2];
MUL R1.xyz, R0, R2;
MAX R1.w, R1, c[7].x;
MUL R0.xyz, R0, c[0];
MUL R0.xyz, R0, R1.w;
MAD R0.xyz, R0, R0.w, R1;
ADD result.color.xyz, R0, R4;
MOV result.color.w, c[7].x;
END
# 44 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_TransDistortion]
Float 5 [_TransPower]
Float 6 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_ShadowMapTexture] 2D 3
"ps_3_0
; 46 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c7, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c8, 128.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c7.x, c7.y
mul_pp r0.x, r1.y, r1.y
mad_pp r0.x, -r1, r1, -r0
add_pp r0.x, r0, c7.z
rsq_pp r0.x, r0.x
rcp_pp r1.z, r0.x
dp3_pp r0.y, v3, v3
rsq_pp r0.x, r0.y
mad r2.xyz, r1, c4.x, v2
mul_pp r0.xyz, r0.x, v3
dp3_pp_sat r1.w, r0, -r2
add_pp r2.xyz, v2, r0
pow r0, r1.w, c5.x
dp3_pp r0.y, r2, r2
mov r1.w, r0.x
rsq_pp r0.y, r0.y
mul_pp r0.xyz, r0.y, r2
dp3_pp r0.x, r1, r0
mov_pp r0.w, c3.x
mul_pp r2.y, c8.x, r0.w
max_pp r2.x, r0, c7.w
pow r0, r2.x, r2.y
mul r0.y, r1.w, c6.x
mov r0.z, r0.x
texldp r0.x, v4, s3
dp3_pp r1.w, r1, v2
mov_pp r2.xyz, c0
mul_pp r2.xyz, c1, r2
mul r2.xyz, r2, r0.z
mul_pp r0.w, r0.x, c7.x
mul r4.xyz, r0.w, r2
add r3.xyz, r0.y, c2
mul_pp r2.xyz, r0.w, c0
texld r0.xyz, v1, s2
mul r2.xyz, r2, r3
mul r2.xyz, r2, r0
texld r0.xyz, v0, s0
mul r0.xyz, r0, c2
mul_pp r1.xyz, r0, r2
max_pp r1.w, r1, c7
mul_pp r0.xyz, r0, c0
mul_pp r0.xyz, r0, r1.w
mad_pp r0.xyz, r0, r0.w, r1
add_pp oC0.xyz, r0, r4
mov_pp oC0.w, c7
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 3
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 132 [_TransDistortion]
Float 136 [_TransPower]
Float 140 [_TransScale]
BindCB  "$Globals" 0
"ps_4_0
eefieceddkifhfbipnippanndnogimddigmlobdpabaaaaaabmahaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpmafaaaa
eaaaaaaahpabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaaagaabaaaaaaaaaaaagbjbaaa
aeaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaaeaaaaaaagaabaaaaaaaaaaa
egbcbaaaadaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaa
akaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaakbcaabaaaaaaaaaaabkaabaia
ebaaaaaaacaaaaaabkaabaaaacaaaaaaakaabaaaaaaaaaaaelaaaaafecaabaaa
acaaaaaaakaabaaaaaaaaaaadcaaaaakhcaabaaaadaaaaaaegacbaaaacaaaaaa
fgifcaaaaaaaaaaaaiaaaaaaegbcbaaaadaaaaaabacaaaaibcaabaaaaaaaaaaa
jgahbaaaaaaaaaaaegacbaiaebaaaaaaadaaaaaacpaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaa
aaaaaaaaaiaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaagaabaaaaaaaaaaapgipcaaaaaaaaaaaaiaaaaaaegiccaaa
aaaaaaaaahaaaaaaaoaaaaahdcaabaaaadaaaaaaegbabaaaafaaaaaapgbpbaaa
afaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaadaaaaaa
aagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakaabaaaadaaaaaaakaabaaa
adaaaaaadiaaaaaihcaabaaaadaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaa
efaaaaajpcaabaaaadaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaa
efaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadiaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaaegiccaaaaaaaaaaa
ahaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaa
diaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaaegiccaaaaaaaaaaaabaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaaegbcbaaaadaaaaaadeaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaahhcaabaaa
adaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
deaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaacpaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaaakiacaaa
aaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaabkaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaajocaabaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaaaaaaaaaa
acaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaa
dcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_TransDistortion]
Float 5 [_TransPower]
Float 6 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_ShadowMapTexture] 2D 3
SetTexture 4 [_LightTexture0] 2D 4
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 46 ALU, 5 TEX
PARAM c[8] = { program.local[0..6],
		{ 0, 2, 1, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R0.wyzw, c[7].y, -c[7].z;
MUL R0.x, R1.y, R1.y;
MAD R0.x, -R1, R1, -R0;
ADD R0.x, R0, c[7].z;
RSQ R0.w, R0.x;
RCP R1.z, R0.w;
DP3 R1.w, R1, fragment.texcoord[2];
DP3 R0.y, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.y, R0.y;
MUL R0.xyz, R0.y, fragment.texcoord[3];
ADD R3.xyz, fragment.texcoord[2], R0;
MAD R2.xyz, R1, c[4].x, fragment.texcoord[2];
DP3_SAT R0.x, R0, -R2;
DP3 R0.w, R3, R3;
RSQ R0.y, R0.w;
MUL R2.xyz, R0.y, R3;
DP3 R0.z, R1, R2;
POW R0.x, R0.x, c[5].x;
MUL R0.y, R0.x, c[6].x;
MOV R0.x, c[7].w;
MOV R2.xyz, c[1];
MUL R0.x, R0, c[3];
MAX R0.z, R0, c[7].x;
POW R0.z, R0.z, R0.x;
MUL R2.xyz, R2, c[0];
MUL R2.xyz, R2, R0.z;
TEX R0.w, fragment.texcoord[4], texture[4], 2D;
TXP R0.x, fragment.texcoord[5], texture[3], 2D;
MUL R0.x, R0.w, R0;
MUL R0.w, R0.x, c[7].y;
MUL R4.xyz, R0.w, R2;
ADD R3.xyz, R0.y, c[2];
MUL R2.xyz, R0.w, c[0];
TEX R0.xyz, fragment.texcoord[1], texture[2], 2D;
MUL R2.xyz, R2, R3;
MUL R2.xyz, R2, R0;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[2];
MUL R1.xyz, R0, R2;
MAX R1.w, R1, c[7].x;
MUL R0.xyz, R0, c[0];
MUL R0.xyz, R0, R1.w;
MAD R0.xyz, R0, R0.w, R1;
ADD result.color.xyz, R0, R4;
MOV result.color.w, c[7].x;
END
# 46 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_TransDistortion]
Float 5 [_TransPower]
Float 6 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_ShadowMapTexture] 2D 3
SetTexture 4 [_LightTexture0] 2D 4
"ps_3_0
; 47 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c7, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c8, 128.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xy
dcl_texcoord5 v5
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c7.x, c7.y
mul_pp r0.x, r1.y, r1.y
mad_pp r0.x, -r1, r1, -r0
add_pp r0.x, r0, c7.z
rsq_pp r0.x, r0.x
rcp_pp r1.z, r0.x
dp3_pp r0.y, v3, v3
rsq_pp r0.x, r0.y
mad r2.xyz, r1, c4.x, v2
mul_pp r0.xyz, r0.x, v3
dp3_pp_sat r1.w, r0, -r2
add_pp r2.xyz, v2, r0
pow r0, r1.w, c5.x
dp3_pp r0.y, r2, r2
mov r1.w, r0.x
rsq_pp r0.y, r0.y
mul_pp r0.xyz, r0.y, r2
dp3_pp r0.x, r1, r0
mov_pp r0.w, c3.x
mul_pp r2.y, c8.x, r0.w
max_pp r2.x, r0, c7.w
pow r0, r2.x, r2.y
mul r0.y, r1.w, c6.x
mov r0.z, r0.x
dp3_pp r1.w, r1, v2
mov_pp r2.xyz, c0
mul_pp r2.xyz, c1, r2
mul r2.xyz, r2, r0.z
texld r0.w, v4, s4
texldp r0.x, v5, s3
mul r0.x, r0.w, r0
mul_pp r0.w, r0.x, c7.x
mul r4.xyz, r0.w, r2
add r3.xyz, r0.y, c2
mul_pp r2.xyz, r0.w, c0
texld r0.xyz, v1, s2
mul r2.xyz, r2, r3
mul r2.xyz, r2, r0
texld r0.xyz, v0, s0
mul r0.xyz, r0, c2
mul_pp r1.xyz, r0, r2
max_pp r1.w, r1, c7
mul_pp r0.xyz, r0, c0
mul_pp r0.xyz, r0, r1.w
mad_pp r0.xyz, r0, r0.w, r1
add_pp oC0.xyz, r0, r4
mov_pp oC0.w, c7
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpMap] 2D 4
SetTexture 2 [_TransMap] 2D 3
SetTexture 3 [_LightTexture0] 2D 1
SetTexture 4 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 256
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 176 [_Color]
Float 192 [_Shininess]
Float 196 [_TransDistortion]
Float 200 [_TransPower]
Float 204 [_TransScale]
BindCB  "$Globals" 0
"ps_4_0
eefiecedfkgfdmefhiihjjfpnifkgdpbpeigfgkoabaaaaaaiaahaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceiagaaaaeaaaaaaajcabaaaa
fjaaaaaeegiocaaaaaaaaaaaanaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaaagaabaaaaaaaaaaaagbjbaaa
aeaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaaeaaaaaaagaabaaaaaaaaaaa
egbcbaaaadaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaaeaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaa
akaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaakbcaabaaaaaaaaaaabkaabaia
ebaaaaaaacaaaaaabkaabaaaacaaaaaaakaabaaaaaaaaaaaelaaaaafecaabaaa
acaaaaaaakaabaaaaaaaaaaadcaaaaakhcaabaaaadaaaaaaegacbaaaacaaaaaa
fgifcaaaaaaaaaaaamaaaaaaegbcbaaaadaaaaaabacaaaaibcaabaaaaaaaaaaa
jgahbaaaaaaaaaaaegacbaiaebaaaaaaadaaaaaacpaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaa
aaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaagaabaaaaaaaaaaapgipcaaaaaaaaaaaamaaaaaaegiccaaa
aaaaaaaaalaaaaaaaoaaaaahdcaabaaaadaaaaaaegbabaaaafaaaaaapgbpbaaa
afaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaaeaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogbkbaaaacaaaaaaeghobaaa
adaaaaaaaagabaaaabaaaaaaapaaaaahicaabaaaaaaaaaaapgapbaaaaeaaaaaa
agaabaaaadaaaaaadiaaaaaihcaabaaaadaaaaaapgapbaaaaaaaaaaaegiccaaa
aaaaaaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
adaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaadaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
adaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaadiaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaaegiccaaa
aaaaaaaaalaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
adaaaaaadiaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaaegiccaaaaaaaaaaa
abaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaaegbcbaaaadaaaaaa
deaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaah
hcaabaaaadaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
cpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaa
akiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaajocaabaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaa
aaaaaaaaacaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaajgahbaaa
abaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightShadowData]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_TransDistortion]
Float 7 [_TransPower]
Float 8 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_ShadowMapTexture] CUBE 3
SetTexture 4 [_LightTexture0] 2D 4
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 58 ALU, 5 TEX
PARAM c[12] = { program.local[0..8],
		{ 0, 2, 1, 0.97000003 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 },
		{ 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R2.xy, R0.wyzw, c[9].y, -c[9].z;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
MUL R1.xyz, R0.x, fragment.texcoord[2];
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[3];
ADD R3.xyz, R1, R0;
DP3 R1.w, R3, R3;
RSQ R1.w, R1.w;
MUL R0.w, R2.y, R2.y;
MAD R0.w, -R2.x, R2.x, -R0;
ADD R0.w, R0, c[9].z;
RSQ R0.w, R0.w;
RCP R2.z, R0.w;
MUL R3.xyz, R1.w, R3;
DP3 R1.w, R2, R3;
MAD R4.xyz, R2, c[6].x, R1;
DP3_SAT R0.y, R0, -R4;
MOV R0.w, c[11].x;
MUL R2.w, R0, c[5].x;
MAX R0.w, R1, c[9].x;
MOV R3.xyz, c[3];
POW R0.w, R0.w, R2.w;
DP3 R0.x, fragment.texcoord[5], fragment.texcoord[5];
RSQ R2.w, R0.x;
MUL R3.xyz, R3, c[2];
MUL R3.xyz, R3, R0.w;
POW R1.w, R0.y, c[7].x;
TEX R0, fragment.texcoord[5], texture[3], CUBE;
DP4 R0.y, R0, c[10];
RCP R2.w, R2.w;
MUL R0.x, R2.w, c[0].w;
MAD R0.z, -R0.x, c[9].w, R0.y;
DP3 R0.y, fragment.texcoord[4], fragment.texcoord[4];
TEX R0.w, R0.y, texture[4], 2D;
MUL R0.y, R1.w, c[8].x;
DP3 R1.w, R2, R1;
MOV R0.x, c[9].z;
CMP R0.x, R0.z, c[1], R0;
MUL R0.x, R0.w, R0;
MUL R0.w, R0.x, c[9].y;
MUL R5.xyz, R0.w, R3;
ADD R4.xyz, R0.y, c[4];
MUL R3.xyz, R0.w, c[2];
TEX R0.xyz, fragment.texcoord[1], texture[2], 2D;
MUL R3.xyz, R3, R4;
MUL R3.xyz, R3, R0;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[4];
MUL R1.xyz, R0, R3;
MAX R1.w, R1, c[9].x;
MUL R0.xyz, R0, c[2];
MUL R0.xyz, R0, R1.w;
MAD R0.xyz, R0, R0.w, R1;
ADD result.color.xyz, R0, R5;
MOV result.color.w, c[9].x;
END
# 58 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightShadowData]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_TransDistortion]
Float 7 [_TransPower]
Float 8 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_ShadowMapTexture] CUBE 3
SetTexture 4 [_LightTexture0] 2D 4
"ps_3_0
; 59 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s4
def c9, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c10, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c11, 0.97000003, 128.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
texld r0.yw, v0.zwzw, s1
mad_pp r2.xy, r0.wyzw, c9.x, c9.y
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, v2
dp3_pp r0.x, v3, v3
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v3
add_pp r0.xyz, r1, r3
dp3_pp r1.w, r0, r0
rsq_pp r1.w, r1.w
mul_pp r0.w, r2.y, r2.y
mad_pp r0.w, -r2.x, r2.x, -r0
add_pp r0.w, r0, c9.z
rsq_pp r0.w, r0.w
rcp_pp r2.z, r0.w
mul_pp r0.xyz, r1.w, r0
mov_pp r0.w, c5.x
dp3_pp r0.x, r2, r0
mul_pp r2.w, c11.y, r0
max_pp r1.w, r0.x, c9
pow r0, r1.w, r2.w
mad r4.xyz, r2, c6.x, r1
dp3_pp_sat r2.w, r3, -r4
mov r1.w, r0.x
pow r0, r2.w, c7.x
dp3 r0.y, v5, v5
rsq r2.w, r0.y
mov_pp r3.xyz, c2
mul_pp r3.xyz, c3, r3
mul r3.xyz, r3, r1.w
mov r1.w, r0.x
texld r0, v5, s3
dp4 r0.y, r0, c10
rcp r2.w, r2.w
mul r0.x, r2.w, c0.w
mad r0.y, -r0.x, c11.x, r0
mov r0.z, c1.x
dp3 r0.x, v4, v4
cmp r0.y, r0, c9.z, r0.z
texld r0.x, r0.x, s4
mul r0.x, r0, r0.y
mul r0.y, r1.w, c8.x
mul_pp r0.w, r0.x, c9.x
mul r5.xyz, r0.w, r3
add r4.xyz, r0.y, c4
dp3_pp r1.w, r2, r1
mul_pp r3.xyz, r0.w, c2
texld r0.xyz, v1, s2
mul r3.xyz, r3, r4
mul r3.xyz, r3, r0
texld r0.xyz, v0, s0
mul r0.xyz, r0, c4
mul_pp r1.xyz, r0, r3
max_pp r1.w, r1, c9
mul_pp r0.xyz, r0, c2
mul_pp r0.xyz, r0, r1.w
mad_pp r0.xyz, r0, r0.w, r1
add_pp oC0.xyz, r0, r5
mov_pp oC0.w, c9
"
}
SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpMap] 2D 4
SetTexture 2 [_TransMap] 2D 3
SetTexture 3 [_LightTexture0] 2D 1
SetTexture 4 [_ShadowMapTexture] CUBE 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 132 [_TransDistortion]
Float 136 [_TransPower]
Float 140 [_TransScale]
ConstBuffer "UnityLighting" 400
Vector 16 [_LightPositionRange]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
"ps_4_0
eefiecedjocmimbadgkcbkpdnfjlbhheaahfognhabaaaaaameaiaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcimahaaaaeaaaaaaaodabaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaa
fjaaaaaeegiocaaaacaaaaaabjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafidaaaaeaahabaaaaeaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaa
agaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaaelaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaa
abaaaaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
omfbhidpefaaaaajpcaabaaaabaaaaaaegbcbaaaagaaaaaaeghobaaaaeaaaaaa
aagabaaaaaaaaaaabbaaaaakccaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaa
aaaaiadpibiaiadlicabibdhimpinfdbdbaaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaacaaaaaabiaaaaaaabeaaaaaaaaaiadpbaaaaaahccaabaaaaaaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaa
aaaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaaapaaaaahbcaabaaaaaaaaaaa
agaabaaaabaaaaaaagaabaaaaaaaaaaadiaaaaaiocaabaaaaaaaaaaaagaabaaa
aaaaaaaaagijcaaaaaaaaaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
aeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaaeaaaaaabaaaaaah
icaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaa
egbcbaaaadaaaaaadcaaaaajhcaabaaaadaaaaaaegbcbaaaadaaaaaapgapbaaa
abaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaeaaaaaadcaaaaapdcaabaaaaeaaaaaahgapbaaa
aeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaadcaaaaakicaabaaaabaaaaaaakaabaiaebaaaaaa
aeaaaaaaakaabaaaaeaaaaaaabeaaaaaaaaaiadpdcaaaaakicaabaaaabaaaaaa
bkaabaiaebaaaaaaaeaaaaaabkaabaaaaeaaaaaadkaabaaaabaaaaaaelaaaaaf
ecaabaaaaeaaaaaadkaabaaaabaaaaaadcaaaaakhcaabaaaafaaaaaaegacbaaa
aeaaaaaafgifcaaaaaaaaaaaaiaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaadeaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaaabacaaaaibcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaiaebaaaaaaafaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackiacaaaaaaaaaaa
aiaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaagaabaaaabaaaaaapgipcaaaaaaaaaaaaiaaaaaaegiccaaaaaaaaaaa
ahaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
adaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
ahaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadcaaaaaj
ocaabaaaaaaaaaaaagajbaaaabaaaaaaagaabaaaaaaaaaaafgaobaaaaaaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaa
abaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaaeaaaaaa
egacbaaaabaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiccaabaaa
abaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaajocaabaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaa
agijcaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaa
jgahbaaaabaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaa
aaaaaaaajgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightShadowData]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_TransDistortion]
Float 7 [_TransPower]
Float 8 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_ShadowMapTexture] CUBE 3
SetTexture 4 [_LightTextureB0] 2D 4
SetTexture 5 [_LightTexture0] CUBE 5
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 60 ALU, 6 TEX
PARAM c[12] = { program.local[0..8],
		{ 0, 2, 1, 0.97000003 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 },
		{ 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.w, R0.w;
MAD R1.xy, R1.wyzw, c[9].y, -c[9].z;
MUL R2.xyz, R0.w, fragment.texcoord[3];
MUL R0.xyz, R0.x, fragment.texcoord[2];
ADD R3.xyz, R0, R2;
MUL R0.w, R1.y, R1.y;
MAD R0.w, -R1.x, R1.x, -R0;
DP3 R1.z, R3, R3;
RSQ R1.z, R1.z;
ADD R0.w, R0, c[9].z;
MUL R3.xyz, R1.z, R3;
RSQ R0.w, R0.w;
RCP R1.z, R0.w;
DP3 R1.w, R1, R3;
MOV R0.w, c[11].x;
MUL R2.w, R0, c[5].x;
MAX R0.w, R1, c[9].x;
POW R1.w, R0.w, R2.w;
MAD R3.xyz, R1, c[6].x, R0;
DP3_SAT R0.w, R2, -R3;
MOV R4.xyz, c[3];
MUL R2.xyz, R4, c[2];
MUL R3.xyz, R2, R1.w;
POW R3.w, R0.w, c[7].x;
TEX R2, fragment.texcoord[5], texture[3], CUBE;
DP3 R0.w, fragment.texcoord[5], fragment.texcoord[5];
RSQ R0.w, R0.w;
RCP R1.w, R0.w;
DP4 R2.x, R2, c[10];
MUL R1.w, R1, c[0];
MAD R1.w, -R1, c[9], R2.x;
MOV R0.w, c[9].z;
CMP R2.x, R1.w, c[1], R0.w;
DP3 R1.w, fragment.texcoord[4], fragment.texcoord[4];
TEX R1.w, R1.w, texture[4], 2D;
TEX R0.w, fragment.texcoord[4], texture[5], CUBE;
MUL R0.w, R1, R0;
MUL R0.w, R0, R2.x;
MUL R0.w, R0, c[9].y;
MUL R1.w, R3, c[8].x;
MUL R5.xyz, R0.w, R3;
ADD R4.xyz, R1.w, c[4];
DP3 R1.w, R1, R0;
MUL R3.xyz, R0.w, c[2];
TEX R2.xyz, fragment.texcoord[1], texture[2], 2D;
MUL R3.xyz, R3, R4;
MUL R3.xyz, R3, R2;
TEX R2.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R2, c[4];
MUL R1.xyz, R0, R3;
MAX R1.w, R1, c[9].x;
MUL R0.xyz, R0, c[2];
MUL R0.xyz, R0, R1.w;
MAD R0.xyz, R0, R0.w, R1;
ADD result.color.xyz, R0, R5;
MOV result.color.w, c[9].x;
END
# 60 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightShadowData]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_TransDistortion]
Float 7 [_TransPower]
Float 8 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_ShadowMapTexture] CUBE 3
SetTexture 4 [_LightTextureB0] 2D 4
SetTexture 5 [_LightTexture0] CUBE 5
"ps_3_0
; 60 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s4
dcl_cube s5
def c9, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c10, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c11, 0.97000003, 128.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
texld r1.yw, v0.zwzw, s1
mad_pp r1.xy, r1.wyzw, c9.x, c9.y
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
dp3_pp r0.w, v3, v3
rsq_pp r0.w, r0.w
mul_pp r3.xyz, r0.w, v3
mul_pp r0.xyz, r0.x, v2
add_pp r2.xyz, r0, r3
mul_pp r0.w, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0
dp3_pp r1.z, r2, r2
rsq_pp r1.z, r1.z
add_pp r0.w, r0, c9.z
mov_pp r1.w, c5.x
mul_pp r2.xyz, r1.z, r2
rsq_pp r0.w, r0.w
rcp_pp r1.z, r0.w
dp3_pp r0.w, r1, r2
mad r4.xyz, r1, c6.x, r0
mul_pp r1.w, c11.y, r1
max_pp r0.w, r0, c9
pow r2, r0.w, r1.w
dp3_pp_sat r0.w, r3, -r4
mov r1.w, r2.x
pow r2, r0.w, c7.x
mov_pp r3.xyz, c2
mul_pp r3.xyz, c3, r3
dp3 r0.w, v5, v5
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r3.xyz, r3, r1.w
mov r1.w, r2.x
texld r2, v5, s3
dp4 r2.x, r2, c10
mul r1.w, r1, c8.x
add r4.xyz, r1.w, c4
dp3_pp r1.w, r1, r0
mul r0.w, r0, c0
mad r0.w, -r0, c11.x, r2.x
mov r2.y, c1.x
cmp r2.y, r0.w, c9.z, r2
dp3 r2.x, v4, v4
texld r2.x, r2.x, s4
texld r0.w, v4, s5
mul r0.w, r2.x, r0
mul r0.w, r0, r2.y
mul_pp r0.w, r0, c9.x
mul r5.xyz, r0.w, r3
mul_pp r3.xyz, r0.w, c2
texld r2.xyz, v1, s2
mul r3.xyz, r3, r4
mul r3.xyz, r3, r2
texld r2.xyz, v0, s0
mul r0.xyz, r2, c4
mul_pp r1.xyz, r0, r3
max_pp r1.w, r1, c9
mul_pp r0.xyz, r0, c2
mul_pp r0.xyz, r0, r1.w
mad_pp r0.xyz, r0, r0.w, r1
add_pp oC0.xyz, r0, r5
mov_pp oC0.w, c9
"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
SetTexture 0 [_MainTex] 2D 3
SetTexture 1 [_BumpMap] 2D 5
SetTexture 2 [_TransMap] 2D 4
SetTexture 3 [_LightTextureB0] 2D 2
SetTexture 4 [_LightTexture0] CUBE 1
SetTexture 5 [_ShadowMapTexture] CUBE 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 132 [_TransDistortion]
Float 136 [_TransPower]
Float 140 [_TransScale]
ConstBuffer "UnityLighting" 400
Vector 16 [_LightPositionRange]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
"ps_4_0
eefiecedeadfhncgkheoagccpnlndjnoheppbchoabaaaaaacaajaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoiahaaaaeaaaaaaapkabaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaa
fjaaaaaeegiocaaaacaaaaaabjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafidaaaaeaahabaaa
aeaaaaaaffffaaaafidaaaaeaahabaaaafaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaagaaaaaaegbcbaaaagaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaa
abaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaomfbhidp
efaaaaajpcaabaaaabaaaaaaegbcbaaaagaaaaaaeghobaaaafaaaaaaaagabaaa
aaaaaaaabbaaaaakccaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaiadp
ibiaiadlicabibdhimpinfdbdbaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
acaaaaaabiaaaaaaabeaaaaaaaaaiadpbaaaaaahccaabaaaaaaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaa
eghobaaaadaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbcbaaa
afaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaa
akaabaaaabaaaaaadkaabaaaacaaaaaaapaaaaahbcaabaaaaaaaaaaafgafbaaa
aaaaaaaaagaabaaaaaaaaaaadiaaaaaiocaabaaaaaaaaaaaagaabaaaaaaaaaaa
agijcaaaaaaaaaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaa
egbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaaeaaaaaabaaaaaahicaabaaa
abaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegbcbaaa
adaaaaaadcaaaaajhcaabaaaadaaaaaaegbcbaaaadaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaafaaaaaadcaaaaapdcaabaaaaeaaaaaahgapbaaaaeaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaadcaaaaakicaabaaaabaaaaaaakaabaiaebaaaaaaaeaaaaaa
akaabaaaaeaaaaaaabeaaaaaaaaaiadpdcaaaaakicaabaaaabaaaaaabkaabaia
ebaaaaaaaeaaaaaabkaabaaaaeaaaaaadkaabaaaabaaaaaaelaaaaafecaabaaa
aeaaaaaadkaabaaaabaaaaaadcaaaaakhcaabaaaafaaaaaaegacbaaaaeaaaaaa
fgifcaaaaaaaaaaaaiaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaaeaaaaaaegacbaaaacaaaaaadeaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaaabacaaaaibcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaiaebaaaaaaafaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackiacaaaaaaaaaaaaiaaaaaa
bjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
agaabaaaabaaaaaapgipcaaaaaaaaaaaaiaaaaaaegiccaaaaaaaaaaaahaaaaaa
diaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaeaaaaaa
diaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaadaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaahaaaaaa
diaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadcaaaaajocaabaaa
aaaaaaaaagajbaaaabaaaaaaagaabaaaaaaaaaaafgaobaaaaaaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaa
egacbaaaadaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaa
abaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
cpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaa
akiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaajocaabaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaa
aaaaaaaaacaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaajgahbaaa
abaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaa
jgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Vector 0 [_LightShadowData]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_ShadowOffsets0]
Vector 4 [_ShadowOffsets1]
Vector 5 [_ShadowOffsets2]
Vector 6 [_ShadowOffsets3]
Vector 7 [_Color]
Float 8 [_Shininess]
Float 9 [_TransDistortion]
Float 10 [_TransPower]
Float 11 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
SetTexture 4 [_LightTextureB0] 2D 4
SetTexture 5 [_ShadowMapTexture] 2D 5
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 71 ALU, 9 TEX
PARAM c[14] = { program.local[0..11],
		{ 0, 2, 1, 0.5 },
		{ 0.25, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R0.wyzw, c[12].y, -c[12].z;
MUL R0.w, R1.y, R1.y;
MAD R0.w, -R1.x, R1.x, -R0;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
MUL R2.xyz, R0.x, fragment.texcoord[2];
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[3];
ADD R3.xyz, R2, R0;
DP3 R1.z, R3, R3;
RSQ R1.z, R1.z;
ADD R0.w, R0, c[12].z;
MUL R3.xyz, R1.z, R3;
RSQ R0.w, R0.w;
RCP R1.z, R0.w;
DP3 R1.w, R1, R3;
MAD R4.xyz, R1, c[9].x, R2;
DP3_SAT R0.z, R0, -R4;
MOV R0.w, c[13].y;
MOV R3.xyz, c[2];
MAX R1.w, R1, c[12].x;
MUL R0.w, R0, c[8].x;
POW R0.w, R1.w, R0.w;
RCP R1.w, fragment.texcoord[5].w;
MAD R0.xy, fragment.texcoord[5], R1.w, c[6];
MUL R3.xyz, R3, c[1];
MUL R3.xyz, R3, R0.w;
TEX R0.x, R0, texture[5], 2D;
MAD R4.xy, fragment.texcoord[5], R1.w, c[5];
MOV R0.w, R0.x;
TEX R0.x, R4, texture[5], 2D;
POW R2.w, R0.z, c[10].x;
MAD R4.xy, fragment.texcoord[5], R1.w, c[4];
MOV R0.z, R0.x;
TEX R0.x, R4, texture[5], 2D;
MAD R4.xy, fragment.texcoord[5], R1.w, c[3];
MOV R0.y, R0.x;
TEX R0.x, R4, texture[5], 2D;
MAD R0, -fragment.texcoord[5].z, R1.w, R0;
MOV R3.w, c[12].z;
CMP R0, R0, c[0].x, R3.w;
DP4 R3.w, R0, c[13].x;
RCP R1.w, fragment.texcoord[4].w;
MAD R0.xy, fragment.texcoord[4], R1.w, c[12].w;
TEX R0.w, R0, texture[3], 2D;
DP3 R0.z, fragment.texcoord[4], fragment.texcoord[4];
MUL R0.y, R2.w, c[11].x;
SLT R0.x, c[12], fragment.texcoord[4].z;
TEX R1.w, R0.z, texture[4], 2D;
MUL R0.x, R0, R0.w;
MUL R0.x, R0, R1.w;
MUL R0.x, R0, R3.w;
MUL R0.w, R0.x, c[12].y;
MUL R5.xyz, R0.w, R3;
ADD R4.xyz, R0.y, c[7];
DP3 R1.w, R1, R2;
MUL R3.xyz, R0.w, c[1];
TEX R0.xyz, fragment.texcoord[1], texture[2], 2D;
MUL R3.xyz, R3, R4;
MUL R3.xyz, R3, R0;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[7];
MUL R1.xyz, R0, R3;
MAX R1.w, R1, c[12].x;
MUL R0.xyz, R0, c[1];
MUL R0.xyz, R0, R1.w;
MAD R0.xyz, R0, R0.w, R1;
ADD result.color.xyz, R0, R5;
MOV result.color.w, c[12].x;
END
# 71 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Vector 0 [_LightShadowData]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_ShadowOffsets0]
Vector 4 [_ShadowOffsets1]
Vector 5 [_ShadowOffsets2]
Vector 6 [_ShadowOffsets3]
Vector 7 [_Color]
Float 8 [_Shininess]
Float 9 [_TransDistortion]
Float 10 [_TransPower]
Float 11 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
SetTexture 4 [_LightTextureB0] 2D 4
SetTexture 5 [_ShadowMapTexture] 2D 5
"ps_3_0
; 68 ALU, 9 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c12, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c13, 0.50000000, 0.25000000, 128.00000000, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
dcl_texcoord5 v5
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c12.x, c12.y
mul_pp r0.w, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v2
dp3_pp r0.x, v3, v3
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v3
add_pp r0.xyz, r2, r3
dp3_pp r1.z, r0, r0
rsq_pp r1.z, r1.z
add_pp r0.w, r0, c12.z
mul_pp r0.xyz, r1.z, r0
rsq_pp r0.w, r0.w
rcp_pp r1.z, r0.w
dp3_pp r0.x, r1, r0
mov_pp r0.w, c8.x
mad r4.xyz, r1, c9.x, r2
mul_pp r2.w, c13.z, r0
max_pp r1.w, r0.x, c12
pow r0, r1.w, r2.w
mov r0.w, r0.x
mov_pp r0.xyz, c1
rcp r2.w, v5.w
dp3_pp_sat r1.w, r3, -r4
mul_pp r0.xyz, c2, r0
mul r3.xyz, r0, r0.w
pow r0, r1.w, c10.x
mad r4.xy, v5, r2.w, c6
mov r1.w, r0.x
texld r0.x, r4, s5
mad r4.xy, v5, r2.w, c5
mov r0.w, r0.x
texld r0.x, r4, s5
mad r4.xy, v5, r2.w, c4
mov r0.z, r0.x
texld r0.x, r4, s5
mad r4.xy, v5, r2.w, c3
mov r0.y, r0.x
texld r0.x, r4, s5
mad r0, -v5.z, r2.w, r0
mov r3.w, c0.x
cmp r0, r0, c12.z, r3.w
dp4_pp r0.z, r0, c13.y
rcp r2.w, v4.w
mad r4.xy, v4, r2.w, c13.x
dp3 r0.x, v4, v4
texld r0.w, r4, s3
cmp r0.y, -v4.z, c12.w, c12.z
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s4
mul_pp r0.x, r0.y, r0
mul r0.y, r1.w, c11.x
mul_pp r0.x, r0, r0.z
mul_pp r0.w, r0.x, c12.x
mul r5.xyz, r0.w, r3
add r4.xyz, r0.y, c7
dp3_pp r1.w, r1, r2
mul_pp r3.xyz, r0.w, c1
texld r0.xyz, v1, s2
mul r3.xyz, r3, r4
mul r3.xyz, r3, r0
texld r0.xyz, v0, s0
mul r0.xyz, r0, c7
mul_pp r1.xyz, r0, r3
max_pp r1.w, r1, c12
mul_pp r0.xyz, r0, c1
mul_pp r0.xyz, r0, r1.w
mad_pp r0.xyz, r0, r0.w, r1
add_pp oC0.xyz, r0, r5
mov_pp oC0.w, c12
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
SetTexture 0 [_MainTex] 2D 3
SetTexture 1 [_BumpMap] 2D 5
SetTexture 2 [_TransMap] 2D 4
SetTexture 3 [_LightTexture0] 2D 1
SetTexture 4 [_LightTextureB0] 2D 2
SetTexture 5 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 256
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 48 [_ShadowOffsets0]
Vector 64 [_ShadowOffsets1]
Vector 80 [_ShadowOffsets2]
Vector 96 [_ShadowOffsets3]
Vector 176 [_Color]
Float 192 [_Shininess]
Float 196 [_TransDistortion]
Float 200 [_TransPower]
Float 204 [_TransScale]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityShadows" 1
"ps_4_0
eefiecedlohbdcmgekmhgigmeppagmfaegchaglmabaaaaaaimakaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfeajaaaaeaaaaaaaffacaaaa
fjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaabjaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaad
aagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaa
afaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadpcbabaaa
afaaaaaagcbaaaadpcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
agaaaaaaaoaaaaahhcaabaaaaaaaaaaaegbcbaaaagaaaaaapgbpbaaaagaaaaaa
aaaaaaaidcaabaaaabaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaadaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaafaaaaaaaagabaaa
aaaaaaaaaaaaaaaidcaabaaaacaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaa
aeaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaafaaaaaa
aagabaaaaaaaaaaadgaaaaafccaabaaaabaaaaaaakaabaaaacaaaaaaaaaaaaai
dcaabaaaacaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaafaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaafaaaaaaaagabaaaaaaaaaaa
dgaaaaafecaabaaaabaaaaaaakaabaaaacaaaaaaaaaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaaaaaaaaaeghobaaaafaaaaaaaagabaaaaaaaaaaadgaaaaaficaabaaa
abaaaaaaakaabaaaacaaaaaadbaaaaahpcaabaaaaaaaaaaaegaobaaaabaaaaaa
kgakbaaaaaaaaaaadhaaaaanpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaa
abaaaaaabiaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbbaaaaak
bcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadoaaaaiadoaaaaiado
aaaaiadoaoaaaaahgcaabaaaaaaaaaaaagbbbaaaafaaaaaapgbpbaaaafaaaaaa
aaaaaaakgcaabaaaaaaaaaaafgagbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaadp
aaaaaadpaaaaaaaaefaaaaajpcaabaaaabaaaaaajgafbaaaaaaaaaaaeghobaaa
adaaaaaaaagabaaaabaaaaaadbaaaaahccaabaaaaaaaaaaaabeaaaaaaaaaaaaa
ckbabaaaafaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahccaabaaaaaaaaaaadkaabaaaabaaaaaabkaabaaaaaaaaaaa
baaaaaahecaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaefaaaaaj
pcaabaaaabaaaaaakgakbaaaaaaaaaaaeghobaaaaeaaaaaaaagabaaaacaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaabaaaaaaapaaaaah
bcaabaaaaaaaaaaafgafbaaaaaaaaaaaagaabaaaaaaaaaaadiaaaaaiocaabaaa
aaaaaaaaagaabaaaaaaaaaaaagijcaaaaaaaaaaaabaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaa
aeaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaa
eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaabaaaaaaegbcbaaaadaaaaaadcaaaaajhcaabaaaadaaaaaaegbcbaaa
adaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaafaaaaaadcaaaaapdcaabaaa
aeaaaaaahgapbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadcaaaaakicaabaaaabaaaaaa
akaabaiaebaaaaaaaeaaaaaaakaabaaaaeaaaaaaabeaaaaaaaaaiadpdcaaaaak
icaabaaaabaaaaaabkaabaiaebaaaaaaaeaaaaaabkaabaaaaeaaaaaadkaabaaa
abaaaaaaelaaaaafecaabaaaaeaaaaaadkaabaaaabaaaaaadcaaaaakhcaabaaa
afaaaaaaegacbaaaaeaaaaaafgifcaaaaaaaaaaaamaaaaaaegacbaaaacaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaadeaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaabacaaaaibcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaafaaaaaacpaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaa
ckiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaagaabaaaabaaaaaapgipcaaaaaaaaaaaamaaaaaa
egiccaaaaaaaaaaaalaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaa
agajbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaaeaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaa
agajbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaacaaaaaa
egiccaaaaaaaaaaaalaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaa
agajbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaabaaaaaaagaabaaaaaaaaaaa
fgaobaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaa
adaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaabaaaaaa
egacbaaaaeaaaaaaegacbaaaabaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaaiccaabaaaabaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaaed
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaajocaabaaaabaaaaaaagijcaaa
aaaaaaaaabaaaaaaagijcaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaabaaaaaa
agaabaaaabaaaaaajgahbaaaabaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
abaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Vector 0 [_LightShadowData]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_ShadowOffsets0]
Vector 4 [_ShadowOffsets1]
Vector 5 [_ShadowOffsets2]
Vector 6 [_ShadowOffsets3]
Vector 7 [_Color]
Float 8 [_Shininess]
Float 9 [_TransDistortion]
Float 10 [_TransPower]
Float 11 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
SetTexture 4 [_LightTextureB0] 2D 4
SetTexture 5 [_ShadowMapTexture] 2D 5
"ps_3_0
; 67 ALU, 9 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c12, 2.00000000, -1.00000000, 0.00000000, 1.00000000
def c13, 0.50000000, 0.25000000, 128.00000000, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
dcl_texcoord5 v5
texld r0.yw, v0.zwzw, s1
mad_pp r2.xy, r0.wyzw, c12.x, c12.y
mul_pp r0.x, r2.y, r2.y
mad_pp r0.x, -r2, r2, -r0
add_pp r0.x, r0, c12.w
rsq_pp r0.x, r0.x
rcp_pp r2.z, r0.x
dp3_pp r0.x, v2, v2
rsq_pp r0.w, r0.x
mul_pp r3.xyz, r0.w, v2
dp3_pp r0.y, v3, v3
rsq_pp r0.y, r0.y
mul_pp r0.xyz, r0.y, v3
add_pp r4.xyz, r3, r0
mad r1.xyz, r2, c9.x, r3
dp3_pp_sat r0.x, r0, -r1
pow r1, r0.x, c10.x
rcp r3.w, v5.w
mad r0.xyz, v5, r3.w, c6
mov r1.w, r1.x
mad r1.xyz, v5, r3.w, c4
texld r0.x, r0, s5
mov_pp r0.w, r0.x
mad r0.xyz, v5, r3.w, c5
texld r0.x, r0, s5
texld r1.x, r1, s5
mov_pp r0.z, r0.x
mov_pp r0.y, r1.x
mad r1.xyz, v5, r3.w, c3
mov r0.x, c0
add r3.w, c12, -r0.x
texld r0.x, r1, s5
mad r0, r0, r3.w, c0.x
dp4_pp r0.y, r0, c13.y
rcp r1.x, v4.w
mad r1.xy, v4, r1.x, c13.x
dp3 r0.x, v4, v4
dp3_pp r2.w, r4, r4
texld r0.w, r1, s3
cmp r0.z, -v4, c12, c12.w
mul_pp r0.z, r0, r0.w
rsq_pp r0.w, r2.w
texld r0.x, r0.x, s4
mul_pp r0.x, r0.z, r0
mul_pp r0.x, r0, r0.y
mul r0.y, r1.w, c11.x
mul_pp r1.w, r0.x, c12.x
add r1.xyz, r0.y, c7
mul_pp r0.xyz, r1.w, c1
mul r1.xyz, r0, r1
texld r0.xyz, v1, s2
mul r1.xyz, r1, r0
mul_pp r4.xyz, r0.w, r4
dp3_pp r0.x, r2, r4
mov_pp r0.y, c8.x
texld r4.xyz, v0, s0
mul r4.xyz, r4, c7
max_pp r2.w, r0.x, c12.z
mul_pp r3.w, c13.z, r0.y
pow r0, r2.w, r3.w
mul_pp r0.yzw, r4.xxyz, r1.xxyz
mov_pp r1.xyz, c1
mul_pp r1.xyz, c2, r1
mul r1.xyz, r1, r0.x
dp3_pp r0.x, r2, r3
max_pp r0.x, r0, c12.z
mul_pp r2.xyz, r4, c1
mul_pp r2.xyz, r2, r0.x
mul r1.xyz, r1.w, r1
mad_pp r0.xyz, r2, r1.w, r0.yzww
add_pp oC0.xyz, r0, r1
mov_pp oC0.w, c12.z
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
SetTexture 0 [_MainTex] 2D 3
SetTexture 1 [_BumpMap] 2D 5
SetTexture 2 [_TransMap] 2D 4
SetTexture 3 [_LightTexture0] 2D 1
SetTexture 4 [_LightTextureB0] 2D 2
SetTexture 5 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 256
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 48 [_ShadowOffsets0]
Vector 64 [_ShadowOffsets1]
Vector 80 [_ShadowOffsets2]
Vector 96 [_ShadowOffsets3]
Vector 176 [_Color]
Float 192 [_Shininess]
Float 196 [_TransDistortion]
Float 200 [_TransPower]
Float 204 [_TransScale]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityShadows" 1
"ps_4_0
eefiecedfbgkclbgaikhgpicchljnlcmaakjioifabaaaaaagmakaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdeajaaaaeaaaaaaaenacaaaa
fjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaabjaaaaaa
fkaiaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaad
aagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaa
afaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadpcbabaaa
afaaaaaagcbaaaadpcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
agaaaaaaaaaaaaajbcaabaaaaaaaaaaaakiacaiaebaaaaaaabaaaaaabiaaaaaa
abeaaaaaaaaaiadpaoaaaaahocaabaaaaaaaaaaaagbjbaaaagaaaaaapgbpbaaa
agaaaaaaaaaaaaaihcaabaaaabaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaa
adaaaaaaehaaaaalbcaabaaaabaaaaaaegaabaaaabaaaaaaaghabaaaafaaaaaa
aagabaaaaaaaaaaackaabaaaabaaaaaaaaaaaaaihcaabaaaacaaaaaajgahbaaa
aaaaaaaaegiccaaaaaaaaaaaaeaaaaaaehaaaaalccaabaaaabaaaaaaegaabaaa
acaaaaaaaghabaaaafaaaaaaaagabaaaaaaaaaaackaabaaaacaaaaaaaaaaaaai
hcaabaaaacaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaaaaaaaaai
ocaabaaaaaaaaaaafgaobaaaaaaaaaaaagijcaaaaaaaaaaaagaaaaaaehaaaaal
icaabaaaabaaaaaajgafbaaaaaaaaaaaaghabaaaafaaaaaaaagabaaaaaaaaaaa
dkaabaaaaaaaaaaaehaaaaalecaabaaaabaaaaaaegaabaaaacaaaaaaaghabaaa
afaaaaaaaagabaaaaaaaaaaackaabaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaaagaabaaaaaaaaaaaagiacaaaabaaaaaabiaaaaaabbaaaaak
bcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadoaaaaiadoaaaaiado
aaaaiadoaoaaaaahgcaabaaaaaaaaaaaagbbbaaaafaaaaaapgbpbaaaafaaaaaa
aaaaaaakgcaabaaaaaaaaaaafgagbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaadp
aaaaaadpaaaaaaaaefaaaaajpcaabaaaabaaaaaajgafbaaaaaaaaaaaeghobaaa
adaaaaaaaagabaaaabaaaaaadbaaaaahccaabaaaaaaaaaaaabeaaaaaaaaaaaaa
ckbabaaaafaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahccaabaaaaaaaaaaadkaabaaaabaaaaaabkaabaaaaaaaaaaa
baaaaaahecaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaefaaaaaj
pcaabaaaabaaaaaakgakbaaaaaaaaaaaeghobaaaaeaaaaaaaagabaaaacaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaabaaaaaaapaaaaah
bcaabaaaaaaaaaaafgafbaaaaaaaaaaaagaabaaaaaaaaaaadiaaaaaiocaabaaa
aaaaaaaaagaabaaaaaaaaaaaagijcaaaaaaaaaaaabaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaa
aeaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaa
eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaabaaaaaaegbcbaaaadaaaaaadcaaaaajhcaabaaaadaaaaaaegbcbaaa
adaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaafaaaaaadcaaaaapdcaabaaa
aeaaaaaahgapbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadcaaaaakicaabaaaabaaaaaa
akaabaiaebaaaaaaaeaaaaaaakaabaaaaeaaaaaaabeaaaaaaaaaiadpdcaaaaak
icaabaaaabaaaaaabkaabaiaebaaaaaaaeaaaaaabkaabaaaaeaaaaaadkaabaaa
abaaaaaaelaaaaafecaabaaaaeaaaaaadkaabaaaabaaaaaadcaaaaakhcaabaaa
afaaaaaaegacbaaaaeaaaaaafgifcaaaaaaaaaaaamaaaaaaegacbaaaacaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaadeaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaabacaaaaibcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaafaaaaaacpaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaa
ckiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaagaabaaaabaaaaaapgipcaaaaaaaaaaaamaaaaaa
egiccaaaaaaaaaaaalaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaa
agajbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaaeaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaa
agajbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaacaaaaaa
egiccaaaaaaaaaaaalaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaa
agajbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaabaaaaaaagaabaaaaaaaaaaa
fgaobaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaa
adaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaabaaaaaa
egacbaaaaeaaaaaaegacbaaaabaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaaiccaabaaaabaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaaed
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaajocaabaaaabaaaaaaagijcaaa
aaaaaaaaabaaaaaaagijcaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaabaaaaaa
agaabaaaabaaaaaajgahbaaaabaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
abaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightShadowData]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_TransDistortion]
Float 7 [_TransPower]
Float 8 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_ShadowMapTexture] CUBE 3
SetTexture 4 [_LightTexture0] 2D 4
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 69 ALU, 8 TEX
PARAM c[12] = { program.local[0..8],
		{ 0, 2, 1, 0.97000003 },
		{ 0.0078125, -0.0078125, 0.25, 128 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
ADD R0.xyz, fragment.texcoord[5], c[10].xyyw;
TEX R0, R0, texture[3], CUBE;
ADD R1.xyz, fragment.texcoord[5], c[10].yxyw;
DP4 R1.w, R0, c[11];
TEX R0, R1, texture[3], CUBE;
DP4 R1.z, R0, c[11];
ADD R2.xyz, fragment.texcoord[5], c[10].yyxw;
TEX R0, R2, texture[3], CUBE;
ADD R2.xyz, fragment.texcoord[5], c[10].x;
DP4 R1.y, R0, c[11];
TEX R0, R2, texture[3], CUBE;
DP4 R1.x, R0, c[11];
DP3 R2.x, fragment.texcoord[5], fragment.texcoord[5];
RSQ R0.x, R2.x;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
RCP R0.x, R0.x;
MAD R2.xy, R0.wyzw, c[9].y, -c[9].z;
MUL R0.x, R0, c[0].w;
MAD R0, -R0.x, c[9].w, R1;
MOV R1.x, c[9].z;
CMP R3, R0, c[1].x, R1.x;
MUL R1.y, R2, R2;
MAD R1.y, -R2.x, R2.x, -R1;
ADD R0.x, R1.y, c[9].z;
RSQ R0.x, R0.x;
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
RCP R2.z, R0.x;
DP3 R0.y, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.y;
MUL R1.xyz, R0.x, fragment.texcoord[2];
DP4 R1.w, R3, c[10].z;
DP3 R0.y, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.x, R0.y;
TEX R0.w, R0.w, texture[4], 2D;
MUL R0.w, R0, R1;
MAD R3.xyz, R2, c[6].x, R1;
MUL R0.xyz, R0.x, fragment.texcoord[3];
DP3_SAT R2.w, R0, -R3;
MUL R0.w, R0, c[9].y;
POW R2.w, R2.w, c[7].x;
MUL R1.w, R2, c[8].x;
ADD R4.xyz, R1.w, c[4];
MUL R3.xyz, R0.w, c[2];
MUL R3.xyz, R3, R4;
ADD R4.xyz, R1, R0;
TEX R0.xyz, fragment.texcoord[1], texture[2], 2D;
MUL R3.xyz, R3, R0;
DP3 R1.w, R4, R4;
RSQ R1.w, R1.w;
MUL R4.xyz, R1.w, R4;
DP3 R2.w, R2, R4;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[4];
MUL R3.xyz, R0, R3;
MOV R1.w, c[10];
MOV R4.xyz, c[3];
MAX R2.w, R2, c[9].x;
MUL R1.w, R1, c[5].x;
POW R1.w, R2.w, R1.w;
MUL R4.xyz, R4, c[2];
MUL R4.xyz, R4, R1.w;
DP3 R1.w, R2, R1;
MUL R1.xyz, R0.w, R4;
MAX R1.w, R1, c[9].x;
MUL R0.xyz, R0, c[2];
MUL R0.xyz, R0, R1.w;
MAD R0.xyz, R0, R0.w, R3;
ADD result.color.xyz, R0, R1;
MOV result.color.w, c[9].x;
END
# 69 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightShadowData]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_TransDistortion]
Float 7 [_TransPower]
Float 8 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_ShadowMapTexture] CUBE 3
SetTexture 4 [_LightTexture0] 2D 4
"ps_3_0
; 66 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s4
def c9, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c10, 0.00781250, -0.00781250, 0.97000003, 0.25000000
def c11, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c12, 128.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
add r0.xyz, v5, c10.xyyw
texld r1, r0, s3
dp4 r2.w, r1, c11
add r0.xyz, v5, c10.yxyw
texld r1, r0, s3
dp4 r2.z, r1, c11
add r0.xyz, v5, c10.yyxw
texld r0, r0, s3
add r1.xyz, v5, c10.x
dp4 r2.y, r0, c11
texld r0, r1, s3
dp4 r2.x, r0, c11
dp3 r1.x, v5, v5
rsq r0.x, r1.x
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c9.x, c9.y
mul_pp r1.z, r1.y, r1.y
rcp r0.x, r0.x
mul r0.x, r0, c0.w
mad r0, -r0.x, c10.z, r2
mov r1.w, c1.x
cmp r2, r0, c9.z, r1.w
mad_pp r1.z, -r1.x, r1.x, -r1
add_pp r0.x, r1.z, c9.z
rsq_pp r0.x, r0.x
rcp_pp r1.z, r0.x
dp3_pp r0.y, v2, v2
rsq_pp r0.x, r0.y
dp4_pp r0.w, r2, c10.w
dp3_pp r0.y, v3, v3
rsq_pp r1.w, r0.y
mul_pp r2.xyz, r0.x, v2
mad r0.xyz, r1, c6.x, r2
mul_pp r4.xyz, r1.w, v3
dp3_pp_sat r0.y, r4, -r0
pow r3, r0.y, c7.x
dp3 r0.x, v4, v4
texld r0.x, r0.x, s4
mul r0.x, r0, r0.w
mul_pp r1.w, r0.x, c9.x
mov r0.x, r3
mul r0.w, r0.x, c8.x
add_pp r0.xyz, r2, r4
add r4.xyz, r0.w, c4
mul_pp r3.xyz, r1.w, c2
dp3_pp r0.w, r0, r0
mul r4.xyz, r3, r4
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
dp3_pp r0.x, r1, r0
texld r3.xyz, v1, s2
mul r4.xyz, r4, r3
mov_pp r0.y, c5.x
texld r3.xyz, v0, s0
mul r3.xyz, r3, c4
max_pp r2.w, r0.x, c9
mul_pp r3.w, c12.x, r0.y
pow r0, r2.w, r3.w
mul_pp r0.yzw, r3.xxyz, r4.xxyz
mov_pp r4.xyz, c2
mul_pp r4.xyz, c3, r4
mul r4.xyz, r4, r0.x
dp3_pp r0.x, r1, r2
max_pp r0.x, r0, c9.w
mul_pp r2.xyz, r3, c2
mul_pp r2.xyz, r2, r0.x
mul r1.xyz, r1.w, r4
mad_pp r0.xyz, r2, r1.w, r0.yzww
add_pp oC0.xyz, r0, r1
mov_pp oC0.w, c9
"
}
SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpMap] 2D 4
SetTexture 2 [_TransMap] 2D 3
SetTexture 3 [_LightTexture0] 2D 1
SetTexture 4 [_ShadowMapTexture] CUBE 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 132 [_TransDistortion]
Float 136 [_TransPower]
Float 140 [_TransScale]
ConstBuffer "UnityLighting" 400
Vector 16 [_LightPositionRange]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
"ps_4_0
eefiecednockebjgmnkkkhapiehjkabcgjfnpkpdabaaaaaahmakaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceeajaaaaeaaaaaaafbacaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaa
fjaaaaaeegiocaaaacaaaaaabjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafidaaaaeaahabaaaaeaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaa
agaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaaelaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaa
abaaaaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
omfbhidpaaaaaaakocaabaaaaaaaaaaaagbjbaaaagaaaaaaaceaaaaaaaaaaaaa
aaaaaadmaaaaaadmaaaaaadmefaaaaajpcaabaaaabaaaaaajgahbaaaaaaaaaaa
eghobaaaaeaaaaaaaagabaaaaaaaaaaabbaaaaakbcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaaaaaaiadpibiaiadlicabibdhimpinfdbaaaaaaakocaabaaa
aaaaaaaaagbjbaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaalmaaaaaalmaaaaaadm
efaaaaajpcaabaaaacaaaaaajgahbaaaaaaaaaaaeghobaaaaeaaaaaaaagabaaa
aaaaaaaabbaaaaakccaabaaaabaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaiadp
ibiaiadlicabibdhimpinfdbaaaaaaakocaabaaaaaaaaaaaagbjbaaaagaaaaaa
aceaaaaaaaaaaaaaaaaaaalmaaaaaadmaaaaaalmefaaaaajpcaabaaaacaaaaaa
jgahbaaaaaaaaaaaeghobaaaaeaaaaaaaagabaaaaaaaaaaabbaaaaakecaabaaa
abaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaiadpibiaiadlicabibdhimpinfdb
aaaaaaakocaabaaaaaaaaaaaagbjbaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaadm
aaaaaalmaaaaaalmefaaaaajpcaabaaaacaaaaaajgahbaaaaaaaaaaaeghobaaa
aeaaaaaaaagabaaaaaaaaaaabbaaaaakicaabaaaabaaaaaaegaobaaaacaaaaaa
aceaaaaaaaaaiadpibiaiadlicabibdhimpinfdbdbaaaaahpcaabaaaaaaaaaaa
egaobaaaabaaaaaaagaabaaaaaaaaaaadhaaaaanpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaagiacaaaacaaaaaabiaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpbbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiado
aaaaiadoaaaaiadoaaaaiadobaaaaaahccaabaaaaaaaaaaaegbcbaaaafaaaaaa
egbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaa
adaaaaaaaagabaaaabaaaaaaapaaaaahbcaabaaaaaaaaaaaagaabaaaabaaaaaa
agaabaaaaaaaaaaadiaaaaaiocaabaaaaaaaaaaaagaabaaaaaaaaaaaagijcaaa
aaaaaaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaaegbcbaaa
aeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaaagaabaaaabaaaaaaegbcbaaaaeaaaaaabaaaaaahicaabaaaabaaaaaa
egbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegbcbaaaadaaaaaa
dcaaaaajhcaabaaaadaaaaaaegbcbaaaadaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaaefaaaaajpcaabaaaaeaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaaeaaaaaadcaaaaapdcaabaaaaeaaaaaahgapbaaaaeaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaadcaaaaakicaabaaaabaaaaaaakaabaiaebaaaaaaaeaaaaaaakaabaaa
aeaaaaaaabeaaaaaaaaaiadpdcaaaaakicaabaaaabaaaaaabkaabaiaebaaaaaa
aeaaaaaabkaabaaaaeaaaaaadkaabaaaabaaaaaaelaaaaafecaabaaaaeaaaaaa
dkaabaaaabaaaaaadcaaaaakhcaabaaaafaaaaaaegacbaaaaeaaaaaafgifcaaa
aaaaaaaaaiaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
aeaaaaaaegacbaaaacaaaaaadeaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaaaabacaaaaibcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaia
ebaaaaaaafaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaackiacaaaaaaaaaaaaiaaaaaabjaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaagaabaaa
abaaaaaapgipcaaaaaaaaaaaaiaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaah
ocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaadiaaaaah
ocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaah
ocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadcaaaaajocaabaaaaaaaaaaa
agajbaaaabaaaaaaagaabaaaaaaaaaaafgaobaaaaaaaaaaabaaaaaahbcaabaaa
abaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegacbaaa
adaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaa
deaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaacpaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaaakiacaaa
aaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaabkaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaajocaabaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaaaaaaaaaa
acaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaa
dcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightShadowData]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_TransDistortion]
Float 7 [_TransPower]
Float 8 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_ShadowMapTexture] CUBE 3
SetTexture 4 [_LightTextureB0] 2D 4
SetTexture 5 [_LightTexture0] CUBE 5
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 71 ALU, 9 TEX
PARAM c[12] = { program.local[0..8],
		{ 0, 2, 1, 0.97000003 },
		{ 0.0078125, -0.0078125, 0.25, 128 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
ADD R0.xyz, fragment.texcoord[5], c[10].xyyw;
TEX R0, R0, texture[3], CUBE;
ADD R1.xyz, fragment.texcoord[5], c[10].yxyw;
ADD R2.xyz, fragment.texcoord[5], c[10].yyxw;
TEX R1, R1, texture[3], CUBE;
DP4 R0.w, R0, c[11];
DP4 R0.z, R1, c[11];
TEX R2, R2, texture[3], CUBE;
ADD R1.xyz, fragment.texcoord[5], c[10].x;
TEX R1, R1, texture[3], CUBE;
DP4 R0.x, R1, c[11];
DP3 R1.x, fragment.texcoord[5], fragment.texcoord[5];
RSQ R1.z, R1.x;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R1.wyzw, c[9].y, -c[9].z;
RCP R1.w, R1.z;
MUL R1.z, R1.y, R1.y;
DP4 R0.y, R2, c[11];
MUL R1.w, R1, c[0];
MAD R0, -R1.w, c[9].w, R0;
MAD R1.w, -R1.x, R1.x, -R1.z;
MOV R1.z, c[9];
CMP R2, R0, c[1].x, R1.z;
ADD R1.w, R1, c[9].z;
RSQ R0.x, R1.w;
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.w, R0.w;
DP3 R1.w, fragment.texcoord[4], fragment.texcoord[4];
RCP R1.z, R0.x;
DP3 R0.y, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.y;
MUL R0.xyz, R0.x, fragment.texcoord[2];
MAD R4.xyz, R1, c[6].x, R0;
MUL R3.xyz, R0.w, fragment.texcoord[3];
DP4 R2.x, R2, c[10].z;
DP3_SAT R0.w, R3, -R4;
POW R2.y, R0.w, c[7].x;
TEX R1.w, R1.w, texture[4], 2D;
TEX R0.w, fragment.texcoord[4], texture[5], CUBE;
MUL R0.w, R1, R0;
MUL R0.w, R0, R2.x;
MUL R1.w, R2.y, c[8].x;
MUL R0.w, R0, c[9].y;
ADD R4.xyz, R1.w, c[4];
MUL R2.xyz, R0.w, c[2];
MUL R2.xyz, R2, R4;
ADD R4.xyz, R0, R3;
DP3 R1.w, R4, R4;
RSQ R1.w, R1.w;
MUL R4.xyz, R1.w, R4;
DP3 R2.w, R1, R4;
TEX R3.xyz, fragment.texcoord[1], texture[2], 2D;
MUL R3.xyz, R2, R3;
TEX R2.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R2.xyz, R2, c[4];
MOV R1.w, c[10];
MOV R4.xyz, c[3];
DP3 R1.x, R1, R0;
MUL R3.xyz, R2, R3;
MAX R2.w, R2, c[9].x;
MUL R1.w, R1, c[5].x;
POW R1.w, R2.w, R1.w;
MUL R4.xyz, R4, c[2];
MUL R4.xyz, R4, R1.w;
MAX R1.w, R1.x, c[9].x;
MUL R1.xyz, R2, c[2];
MUL R1.xyz, R1, R1.w;
MUL R0.xyz, R0.w, R4;
MAD R1.xyz, R1, R0.w, R3;
ADD result.color.xyz, R1, R0;
MOV result.color.w, c[9].x;
END
# 71 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightShadowData]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_TransDistortion]
Float 7 [_TransPower]
Float 8 [_TransScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_TransMap] 2D 2
SetTexture 3 [_ShadowMapTexture] CUBE 3
SetTexture 4 [_LightTextureB0] 2D 4
SetTexture 5 [_LightTexture0] CUBE 5
"ps_3_0
; 67 ALU, 9 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s4
dcl_cube s5
def c9, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c10, 0.00781250, -0.00781250, 0.97000003, 0.25000000
def c11, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c12, 128.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
add r0.xyz, v5, c10.xyyw
texld r0, r0, s3
add r1.xyz, v5, c10.yxyw
add r2.xyz, v5, c10.yyxw
texld r2, r2, s3
dp4 r0.w, r0, c11
texld r1, r1, s3
dp4 r0.y, r2, c11
dp4 r0.z, r1, c11
add r1.xyz, v5, c10.x
texld r1, r1, s3
dp4 r0.x, r1, c11
dp3 r1.x, v5, v5
rsq r1.z, r1.x
texld r1.yw, v0.zwzw, s1
mad_pp r1.xy, r1.wyzw, c9.x, c9.y
rcp r1.w, r1.z
mul_pp r1.z, r1.y, r1.y
mul r1.w, r1, c0
mad r0, -r1.w, c10.z, r0
mad_pp r1.z, -r1.x, r1.x, -r1
mov r1.w, c1.x
cmp r0, r0, c9.z, r1.w
dp4_pp r0.y, r0, c10.w
add_pp r1.z, r1, c9
rsq_pp r1.z, r1.z
dp3_pp r1.w, v2, v2
rsq_pp r1.w, r1.w
dp3 r0.x, v4, v4
rcp_pp r1.z, r1.z
mul_pp r3.xyz, r1.w, v2
dp3_pp r2.x, v3, v3
rsq_pp r1.w, r2.x
mul_pp r4.xyz, r1.w, v3
mad r2.xyz, r1, c6.x, r3
dp3_pp_sat r1.w, r4, -r2
pow r2, r1.w, c7.x
texld r0.w, v4, s5
texld r0.x, r0.x, s4
mul r0.x, r0, r0.w
mul r0.x, r0, r0.y
mul_pp r1.w, r0.x, c9.x
mov r0.x, r2
mul r0.w, r0.x, c8.x
add_pp r0.xyz, r3, r4
add r4.xyz, r0.w, c4
mul_pp r2.xyz, r1.w, c2
dp3_pp r0.w, r0, r0
mul r4.xyz, r2, r4
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
dp3_pp r0.x, r1, r0
texld r2.xyz, v1, s2
mul r4.xyz, r4, r2
mov_pp r0.y, c5.x
texld r2.xyz, v0, s0
mul r2.xyz, r2, c4
max_pp r2.w, r0.x, c9
mul_pp r3.w, c12.x, r0.y
pow r0, r2.w, r3.w
mul_pp r0.yzw, r2.xxyz, r4.xxyz
mov_pp r4.xyz, c2
mul_pp r4.xyz, c3, r4
mul r4.xyz, r4, r0.x
dp3_pp r0.x, r1, r3
max_pp r0.x, r0, c9.w
mul_pp r2.xyz, r2, c2
mul_pp r2.xyz, r2, r0.x
mul r1.xyz, r1.w, r4
mad_pp r0.xyz, r2, r1.w, r0.yzww
add_pp oC0.xyz, r0, r1
mov_pp oC0.w, c9
"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
SetTexture 0 [_MainTex] 2D 3
SetTexture 1 [_BumpMap] 2D 5
SetTexture 2 [_TransMap] 2D 4
SetTexture 3 [_LightTextureB0] 2D 2
SetTexture 4 [_LightTexture0] CUBE 1
SetTexture 5 [_ShadowMapTexture] CUBE 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 132 [_TransDistortion]
Float 136 [_TransPower]
Float 140 [_TransScale]
ConstBuffer "UnityLighting" 400
Vector 16 [_LightPositionRange]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
"ps_4_0
eefiecedindiiiclpmdlfggibkjdmggjhieagplcabaaaaaaniakaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckaajaaaaeaaaaaaagiacaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaa
fjaaaaaeegiocaaaacaaaaaabjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafidaaaaeaahabaaa
aeaaaaaaffffaaaafidaaaaeaahabaaaafaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaagaaaaaaegbcbaaaagaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaa
abaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaomfbhidp
aaaaaaakocaabaaaaaaaaaaaagbjbaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaadm
aaaaaadmaaaaaadmefaaaaajpcaabaaaabaaaaaajgahbaaaaaaaaaaaeghobaaa
afaaaaaaaagabaaaaaaaaaaabbaaaaakbcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaaaaaaiadpibiaiadlicabibdhimpinfdbaaaaaaakocaabaaaaaaaaaaa
agbjbaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaalmaaaaaalmaaaaaadmefaaaaaj
pcaabaaaacaaaaaajgahbaaaaaaaaaaaeghobaaaafaaaaaaaagabaaaaaaaaaaa
bbaaaaakccaabaaaabaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaiadpibiaiadl
icabibdhimpinfdbaaaaaaakocaabaaaaaaaaaaaagbjbaaaagaaaaaaaceaaaaa
aaaaaaaaaaaaaalmaaaaaadmaaaaaalmefaaaaajpcaabaaaacaaaaaajgahbaaa
aaaaaaaaeghobaaaafaaaaaaaagabaaaaaaaaaaabbaaaaakecaabaaaabaaaaaa
egaobaaaacaaaaaaaceaaaaaaaaaiadpibiaiadlicabibdhimpinfdbaaaaaaak
ocaabaaaaaaaaaaaagbjbaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaadmaaaaaalm
aaaaaalmefaaaaajpcaabaaaacaaaaaajgahbaaaaaaaaaaaeghobaaaafaaaaaa
aagabaaaaaaaaaaabbaaaaakicaabaaaabaaaaaaegaobaaaacaaaaaaaceaaaaa
aaaaiadpibiaiadlicabibdhimpinfdbdbaaaaahpcaabaaaaaaaaaaaegaobaaa
abaaaaaaagaabaaaaaaaaaaadhaaaaanpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
agiacaaaacaaaaaabiaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
bbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadoaaaaiado
aaaaiadoaaaaiadobaaaaaahccaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaa
afaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaaadaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbcbaaaafaaaaaaeghobaaa
aeaaaaaaaagabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaaabaaaaaa
dkaabaaaacaaaaaaapaaaaahbcaabaaaaaaaaaaafgafbaaaaaaaaaaaagaabaaa
aaaaaaaadiaaaaaiocaabaaaaaaaaaaaagaabaaaaaaaaaaaagijcaaaaaaaaaaa
abaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaa
eeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
agaabaaaabaaaaaaegbcbaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaa
adaaaaaaegbcbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegbcbaaaadaaaaaadcaaaaaj
hcaabaaaadaaaaaaegbcbaaaadaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
afaaaaaadcaaaaapdcaabaaaaeaaaaaahgapbaaaaeaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
dcaaaaakicaabaaaabaaaaaaakaabaiaebaaaaaaaeaaaaaaakaabaaaaeaaaaaa
abeaaaaaaaaaiadpdcaaaaakicaabaaaabaaaaaabkaabaiaebaaaaaaaeaaaaaa
bkaabaaaaeaaaaaadkaabaaaabaaaaaaelaaaaafecaabaaaaeaaaaaadkaabaaa
abaaaaaadcaaaaakhcaabaaaafaaaaaaegacbaaaaeaaaaaafgifcaaaaaaaaaaa
aiaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaaeaaaaaa
egacbaaaacaaaaaadeaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaaaabacaaaaibcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaa
afaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaackiacaaaaaaaaaaaaiaaaaaabjaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaagaabaaaabaaaaaa
pgipcaaaaaaaaaaaaiaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahocaabaaa
aaaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaeaaaaaadiaaaaahocaabaaa
aaaaaaaafgaobaaaaaaaaaaaagajbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaadaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahocaabaaa
aaaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaa
abaaaaaaagaabaaaaaaaaaaafgaobaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaadeaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaaakiacaaaaaaaaaaa
aiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaj
ocaabaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaaaaaaaaaaacaaaaaa
diaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
}
 }
 Pass {
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE"="SHADOWCASTER" "RenderType"="Opaque" }
  Cull Off
  Fog { Mode Off }
  Offset 1, 1
Program "vp" {
SubProgram "opengl " {
Keywords { "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Vector 5 [unity_LightShadowBias]
"3.0-!!ARBvp1.0
# 9 ALU
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
TEMP R0;
DP4 R0.x, vertex.position, c[4];
DP4 R0.y, vertex.position, c[3];
ADD R0.y, R0, c[5].x;
MAX R0.z, R0.y, -R0.x;
ADD R0.z, R0, -R0.y;
MAD result.position.z, R0, c[5].y, R0.y;
MOV result.position.w, R0.x;
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 9 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 4 [unity_LightShadowBias]
"vs_3_0
; 10 ALU
dcl_position o0
dcl_texcoord0 o1
def c5, 0.00000000, 0, 0, 0
dcl_position0 v0
dp4 r0.x, v0, c2
add r0.x, r0, c4
max r0.y, r0.x, c5.x
add r0.y, r0, -r0.x
mad r0.z, r0.y, c4.y, r0.x
dp4 r0.w, v0, c3
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov o0, r0
mov o1, r0
"
}
SubProgram "d3d11 " {
Keywords { "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityShadows" 416
Vector 80 [unity_LightShadowBias]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityShadows" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedcffnjigljhonkfclihhebgpmijnlamffabaaaaaalaacaaaaadaaaaaa
cmaaaaaapeaaaaaaciabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaaaaaaaiecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaadgaaaaaflccabaaaaaaaaaaa
egambaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaaaaaaaaaaaibcaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakeccabaaaaaaaaaaabkiacaaaaaaaaaaaafaaaaaaakaabaaa
aaaaaaaackaabaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "SHADOWS_CUBE" }
Bind "vertex" Vertex
Matrix 5 [_Object2World]
Vector 9 [_LightPositionRange]
"3.0-!!ARBvp1.0
# 8 ALU
PARAM c[10] = { program.local[0],
		state.matrix.mvp,
		program.local[5..9] };
TEMP R0;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
ADD result.texcoord[0].xyz, R0, -c[9];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_CUBE" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_LightPositionRange]
"vs_3_0
; 8 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
add o1.xyz, r0, -c8
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityLighting" 400
Vector 16 [_LightPositionRange]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityLighting" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgcagkiclfmkecgpmclokfajjeedfnbaeabaaaaaaaeadaaaaadaaaaaa
cmaaaaaapeaaaaaaemabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefclaabaaaaeaaaabaagmaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hccabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaabaaaaaa
doaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "SHADOWS_DEPTH" }
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 1 ALU, 0 TEX
PARAM c[1] = { { 0 } };
MOV result.color, c[0].x;
END
# 1 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_DEPTH" }
"ps_3_0
; 2 ALU
dcl_texcoord0 v0.xyzw
rcp r0.x, v0.w
mul oC0, v0.z, r0.x
"
}
SubProgram "d3d11 " {
Keywords { "SHADOWS_DEPTH" }
"ps_4_0
eefiecedcbejcgfjfchfioiockkbgpdagbgpkifoabaaaaaaneaaaaaaadaaaaaa
cmaaaaaagaaaaaaajeaaaaaaejfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdiaaaaaaeaaaaaaa
aoaaaaaagfaaaaadpccabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 7 ALU, 0 TEX
PARAM c[3] = { program.local[0],
		{ 1, 255, 65025, 1.6058138e+008 },
		{ 0.0039215689 } };
TEMP R0;
DP3 R0.x, fragment.texcoord[0], fragment.texcoord[0];
RSQ R0.x, R0.x;
RCP R0.x, R0.x;
MUL R0.x, R0, c[0].w;
MUL R0, R0.x, c[1];
FRC R0, R0;
MAD result.color, -R0.yzww, c[2].x, R0;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
"ps_3_0
; 7 ALU
def c1, 1.00000000, 255.00000000, 65025.00000000, 160581376.00000000
def c2, 0.00392157, 0, 0, 0
dcl_texcoord0 v0.xyz
dp3 r0.x, v0, v0
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.x, r0, c0.w
mul r0, r0.x, c1
frc r0, r0
mad oC0, -r0.yzww, c2.x, r0
"
}
SubProgram "d3d11 " {
Keywords { "SHADOWS_CUBE" }
ConstBuffer "UnityLighting" 400
Vector 16 [_LightPositionRange]
BindCB  "UnityLighting" 0
"ps_4_0
eefiecedmchagffclofcanmpjcagbnaijadpkihlabaaaaaalmabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpmaaaaaa
eaaaaaaadpaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaagcbaaaadhcbabaaa
abaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaaelaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaa
aaaaaaaaabaaaaaadiaaaaakpcaabaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaahpedaaabhoehhacebjenbkaaaaafpcaabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaanpccabaaaaaaaaaaajgapbaiaebaaaaaaaaaaaaaaaceaaaaa
ibiaiadlibiaiadlibiaiadlibiaiadlegaobaaaaaaaaaaadoaaaaab"
}
}
 }
 Pass {
  Name "SHADOWCOLLECTOR"
  Tags { "LIGHTMODE"="SHADOWCOLLECTOR" "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Keywords { "SHADOWS_NONATIVE" }
Bind "vertex" Vertex
Matrix 9 [unity_World2Shadow0]
Matrix 13 [unity_World2Shadow1]
Matrix 17 [unity_World2Shadow2]
Matrix 21 [unity_World2Shadow3]
Matrix 25 [_Object2World]
"3.0-!!ARBvp1.0
# 24 ALU
PARAM c[29] = { program.local[0],
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..28] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[3];
DP4 R1.w, vertex.position, c[28];
DP4 R0.z, vertex.position, c[27];
DP4 R0.x, vertex.position, c[25];
DP4 R0.y, vertex.position, c[26];
MOV R1.xyz, R0;
MOV R0.w, -R0;
DP4 result.texcoord[0].z, R1, c[11];
DP4 result.texcoord[0].y, R1, c[10];
DP4 result.texcoord[0].x, R1, c[9];
DP4 result.texcoord[1].z, R1, c[15];
DP4 result.texcoord[1].y, R1, c[14];
DP4 result.texcoord[1].x, R1, c[13];
DP4 result.texcoord[2].z, R1, c[19];
DP4 result.texcoord[2].y, R1, c[18];
DP4 result.texcoord[2].x, R1, c[17];
DP4 result.texcoord[3].z, R1, c[23];
DP4 result.texcoord[3].y, R1, c[22];
DP4 result.texcoord[3].x, R1, c[21];
MOV result.texcoord[4], R0;
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
END
# 24 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_NONATIVE" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [unity_World2Shadow1]
Matrix 16 [unity_World2Shadow2]
Matrix 20 [unity_World2Shadow3]
Matrix 24 [_Object2World]
"vs_3_0
; 24 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_position0 v0
dp4 r0.w, v0, c2
dp4 r1.w, v0, c27
dp4 r0.z, v0, c26
dp4 r0.x, v0, c24
dp4 r0.y, v0, c25
mov r1.xyz, r0
mov r0.w, -r0
dp4 o1.z, r1, c10
dp4 o1.y, r1, c9
dp4 o1.x, r1, c8
dp4 o2.z, r1, c14
dp4 o2.y, r1, c13
dp4 o2.x, r1, c12
dp4 o3.z, r1, c18
dp4 o3.y, r1, c17
dp4 o3.x, r1, c16
dp4 o4.z, r1, c22
dp4 o4.y, r1, c21
dp4 o4.x, r1, c20
mov o5, r0
dp4 o0.w, v0, c7
dp4 o0.z, v0, c6
dp4 o0.y, v0, c5
dp4 o0.x, v0, c4
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [unity_World2Shadow1]
Matrix 16 [unity_World2Shadow2]
Matrix 20 [unity_World2Shadow3]
Matrix 24 [_Object2World]
"vs_3_0
; 24 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_position0 v0
dp4 r0.w, v0, c2
dp4 r1.w, v0, c27
dp4 r0.z, v0, c26
dp4 r0.x, v0, c24
dp4 r0.y, v0, c25
mov r1.xyz, r0
mov r0.w, -r0
dp4 o1.z, r1, c10
dp4 o1.y, r1, c9
dp4 o1.x, r1, c8
dp4 o2.z, r1, c14
dp4 o2.y, r1, c13
dp4 o2.x, r1, c12
dp4 o3.z, r1, c18
dp4 o3.y, r1, c17
dp4 o3.x, r1, c16
dp4 o4.z, r1, c22
dp4 o4.y, r1, c21
dp4 o4.x, r1, c20
mov o5, r0
dp4 o0.w, v0, c7
dp4 o0.z, v0, c6
dp4 o0.y, v0, c5
dp4 o0.x, v0, c4
"
}
SubProgram "d3d11 " {
Keywords { "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "UnityShadows" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpocngpfpkhdpdddeacpdmamldkmifdnfabaaaaaajeagaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcoaaeaaaaeaaaabaadiabaaaafjaaaaae
egiocaaaaaaaaaaabiaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaaaaaaaaaajaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
aiaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaakaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hccabaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaamaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaa
egiccaaaaaaaaaaaapaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaabbaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaabaaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaabcaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaaaaaaaaa
bdaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaaaaaaaaabfaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaabeaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaabgaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaaaaaaaaabhaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaagiccabaaa
afaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NONATIVE" }
Bind "vertex" Vertex
Matrix 9 [unity_World2Shadow0]
Matrix 13 [unity_World2Shadow1]
Matrix 17 [unity_World2Shadow2]
Matrix 21 [unity_World2Shadow3]
Matrix 25 [_Object2World]
"3.0-!!ARBvp1.0
# 24 ALU
PARAM c[29] = { program.local[0],
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..28] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[3];
DP4 R1.w, vertex.position, c[28];
DP4 R0.z, vertex.position, c[27];
DP4 R0.x, vertex.position, c[25];
DP4 R0.y, vertex.position, c[26];
MOV R1.xyz, R0;
MOV R0.w, -R0;
DP4 result.texcoord[0].z, R1, c[11];
DP4 result.texcoord[0].y, R1, c[10];
DP4 result.texcoord[0].x, R1, c[9];
DP4 result.texcoord[1].z, R1, c[15];
DP4 result.texcoord[1].y, R1, c[14];
DP4 result.texcoord[1].x, R1, c[13];
DP4 result.texcoord[2].z, R1, c[19];
DP4 result.texcoord[2].y, R1, c[18];
DP4 result.texcoord[2].x, R1, c[17];
DP4 result.texcoord[3].z, R1, c[23];
DP4 result.texcoord[3].y, R1, c[22];
DP4 result.texcoord[3].x, R1, c[21];
MOV result.texcoord[4], R0;
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
END
# 24 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NONATIVE" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [unity_World2Shadow1]
Matrix 16 [unity_World2Shadow2]
Matrix 20 [unity_World2Shadow3]
Matrix 24 [_Object2World]
"vs_3_0
; 24 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_position0 v0
dp4 r0.w, v0, c2
dp4 r1.w, v0, c27
dp4 r0.z, v0, c26
dp4 r0.x, v0, c24
dp4 r0.y, v0, c25
mov r1.xyz, r0
mov r0.w, -r0
dp4 o1.z, r1, c10
dp4 o1.y, r1, c9
dp4 o1.x, r1, c8
dp4 o2.z, r1, c14
dp4 o2.y, r1, c13
dp4 o2.x, r1, c12
dp4 o3.z, r1, c18
dp4 o3.y, r1, c17
dp4 o3.x, r1, c16
dp4 o4.z, r1, c22
dp4 o4.y, r1, c21
dp4 o4.x, r1, c20
mov o5, r0
dp4 o0.w, v0, c7
dp4 o0.z, v0, c6
dp4 o0.y, v0, c5
dp4 o0.x, v0, c4
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [unity_World2Shadow1]
Matrix 16 [unity_World2Shadow2]
Matrix 20 [unity_World2Shadow3]
Matrix 24 [_Object2World]
"vs_3_0
; 24 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_position0 v0
dp4 r0.w, v0, c2
dp4 r1.w, v0, c27
dp4 r0.z, v0, c26
dp4 r0.x, v0, c24
dp4 r0.y, v0, c25
mov r1.xyz, r0
mov r0.w, -r0
dp4 o1.z, r1, c10
dp4 o1.y, r1, c9
dp4 o1.x, r1, c8
dp4 o2.z, r1, c14
dp4 o2.y, r1, c13
dp4 o2.x, r1, c12
dp4 o3.z, r1, c18
dp4 o3.y, r1, c17
dp4 o3.x, r1, c16
dp4 o4.z, r1, c22
dp4 o4.y, r1, c21
dp4 o4.x, r1, c20
mov o5, r0
dp4 o0.w, v0, c7
dp4 o0.z, v0, c6
dp4 o0.y, v0, c5
dp4 o0.x, v0, c4
"
}
SubProgram "d3d11 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "UnityShadows" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpocngpfpkhdpdddeacpdmamldkmifdnfabaaaaaajeagaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcoaaeaaaaeaaaabaadiabaaaafjaaaaae
egiocaaaaaaaaaaabiaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaaaaaaaaaajaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
aiaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaakaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hccabaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaamaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaa
egiccaaaaaaaaaaaapaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaabbaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaabaaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaabcaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaaaaaaaaa
bdaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaaaaaaaaabfaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaabeaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaabgaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaaaaaaaaabhaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaagiccabaaa
afaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "SHADOWS_NONATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [_LightSplitsNear]
Vector 2 [_LightSplitsFar]
Vector 3 [_LightShadowData]
SetTexture 1 [_ShadowMapTexture] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 21 ALU, 1 TEX
PARAM c[5] = { program.local[0..3],
		{ 1, 255, 0.0039215689 } };
TEMP R0;
TEMP R1;
SLT R1, fragment.texcoord[4].w, c[2];
SGE R0, fragment.texcoord[4].w, c[1];
MUL R0, R0, R1;
MUL R1.xyz, R0.y, fragment.texcoord[1];
MAD R1.xyz, R0.x, fragment.texcoord[0], R1;
MAD R0.xyz, R0.z, fragment.texcoord[2], R1;
MAD R0.xyz, fragment.texcoord[3], R0.w, R0;
TEX R0.x, R0, texture[1], 2D;
ADD R0.z, R0.x, -R0;
MOV R0.x, c[4];
MUL R0.y, -fragment.texcoord[4].w, c[0].w;
CMP R1.x, R0.z, c[3], R0;
ADD R0.y, R0, c[4].x;
MUL R0.xy, R0.y, c[4];
FRC R0.zw, R0.xyxy;
MAD_SAT R1.y, fragment.texcoord[4].w, c[3].z, c[3].w;
MOV R0.y, R0.w;
MAD R0.x, -R0.w, c[4].z, R0.z;
ADD_SAT result.color.x, R1, R1.y;
MOV result.color.zw, R0.xyxy;
MOV result.color.y, c[4].x;
END
# 21 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_NONATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [_LightSplitsNear]
Vector 2 [_LightSplitsFar]
Vector 3 [_LightShadowData]
SetTexture 1 [_ShadowMapTexture] 2D 1
"ps_3_0
; 22 ALU, 1 TEX
dcl_2d s1
def c4, 1.00000000, 0.00000000, 255.00000000, 0.00392157
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyzw
add r1, v4.w, -c2
add r0, v4.w, -c1
cmp r1, r1, c4.y, c4.x
cmp r0, r0, c4.x, c4.y
mul r0, r0, r1
mul r1.xyz, r0.y, v1
mad r1.xyz, r0.x, v0, r1
mad r0.xyz, r0.z, v2, r1
mad r0.xyz, v3, r0.w, r0
texld r0.x, r0, s1
add r0.y, r0.x, -r0.z
mov r0.z, c3.x
mul r0.x, -v4.w, c0.w
cmp r1.x, r0.y, c4, r0.z
add r0.x, r0, c4
mul r0.xy, r0.x, c4.xzzw
frc r0.zw, r0.xyxy
mad_sat r1.y, v4.w, c3.z, c3.w
mov r0.y, r0.w
mad r0.x, -r0.w, c4.w, r0.z
add_sat oC0.x, r1, r1.y
mov oC0.zw, r0.xyxy
mov oC0.y, c4.x
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_NATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [_LightSplitsNear]
Vector 2 [_LightSplitsFar]
Vector 3 [_LightShadowData]
SetTexture 1 [_ShadowMapTexture] 2D 1
"ps_3_0
; 22 ALU, 1 TEX
dcl_2d s1
def c4, 0.00000000, 1.00000000, 255.00000000, 0.00392157
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyzw
add r1, v4.w, -c2
add r0, v4.w, -c1
cmp r1, r1, c4.x, c4.y
cmp r0, r0, c4.y, c4.x
mul r0, r0, r1
mul r1.xyz, r0.y, v1
mad r1.xyz, r0.x, v0, r1
mad r0.xyz, r0.z, v2, r1
mad r0.xyz, v3, r0.w, r0
texld r0.x, r0, s1
mov r0.z, c3.x
add r0.z, c4.y, -r0
mul r0.y, -v4.w, c0.w
mad r1.x, r0, r0.z, c3
add r0.y, r0, c4
mul r0.xy, r0.y, c4.yzzw
frc r0.zw, r0.xyxy
mad_sat r1.y, v4.w, c3.z, c3.w
mov r0.y, r0.w
mad r0.x, -r0.w, c4.w, r0.z
add_sat oC0.x, r1, r1.y
mov oC0.zw, r0.xyxy
mov oC0.y, c4
"
}
SubProgram "d3d11 " {
Keywords { "SHADOWS_NATIVE" }
SetTexture 0 [_ShadowMapTexture] 2D 0
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityShadows" 416
Vector 96 [_LightSplitsNear]
Vector 112 [_LightSplitsFar]
Vector 384 [_LightShadowData]
BindCB  "UnityPerCamera" 0
BindCB  "UnityShadows" 1
"ps_4_0
eefiecedfoicichoepiaaopfmpilgmkjgoeglgdgabaaaaaageaeaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceeadaaaa
eaaaaaaanbaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaa
abaaaaaabjaaaaaafkaiaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadicbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaabnaaaaaipcaabaaaaaaaaaaa
pgbpbaaaafaaaaaaegiocaaaabaaaaaaagaaaaaaabaaaaakpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdbaaaaai
pcaabaaaabaaaaaapgbpbaaaafaaaaaaegiocaaaabaaaaaaahaaaaaaabaaaaak
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaaj
hcaabaaaabaaaaaaegbcbaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegbcbaaaadaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaaaeaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaehaaaaalbcaabaaaaaaaaaaaegaabaaaaaaaaaaaaghabaaa
aaaaaaaaaagabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaa
akiacaiaebaaaaaaabaaaaaabiaaaaaaabeaaaaaaaaaiadpdcaaaaakbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaabiaaaaaa
dccaaaalccaabaaaaaaaaaaadkbabaaaafaaaaaackiacaaaabaaaaaabiaaaaaa
dkiacaaaabaaaaaabiaaaaaaaacaaaahbccabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaadkbabaiaebaaaaaaafaaaaaa
dkiacaaaaaaaaaaaafaaaaaaabeaaaaaaaaaiadpdiaaaaakdcaabaaaaaaaaaaa
agaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaahpedaaaaaaaaaaaaaaaabkaaaaaf
dcaabaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaakeccabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaabeaaaaaibiaiadlakaabaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaabkaabaaaaaaaaaaadgaaaaafcccabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaab"
}
SubProgram "opengl " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NONATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [unity_ShadowSplitSpheres0]
Vector 2 [unity_ShadowSplitSpheres1]
Vector 3 [unity_ShadowSplitSpheres2]
Vector 4 [unity_ShadowSplitSpheres3]
Vector 5 [unity_ShadowSplitSqRadii]
Vector 6 [_LightShadowData]
Vector 7 [unity_ShadowFadeCenterAndType]
SetTexture 1 [_ShadowMapTexture] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 32 ALU, 1 TEX
PARAM c[9] = { program.local[0..7],
		{ 1, 255, 0.0039215689 } };
TEMP R0;
TEMP R1;
TEMP R2;
ADD R0.xyz, fragment.texcoord[4], -c[1];
ADD R2.xyz, fragment.texcoord[4], -c[4];
DP3 R0.x, R0, R0;
ADD R1.xyz, fragment.texcoord[4], -c[2];
DP3 R0.y, R1, R1;
ADD R1.xyz, fragment.texcoord[4], -c[3];
DP3 R0.w, R2, R2;
DP3 R0.z, R1, R1;
SLT R2, R0, c[5];
ADD_SAT R0.xyz, R2.yzww, -R2;
MUL R1.xyz, R0.x, fragment.texcoord[1];
MAD R1.xyz, R2.x, fragment.texcoord[0], R1;
MAD R1.xyz, R0.y, fragment.texcoord[2], R1;
MAD R0.xyz, fragment.texcoord[3], R0.z, R1;
TEX R0.x, R0, texture[1], 2D;
ADD R0.y, R0.x, -R0.z;
ADD R1.xyz, -fragment.texcoord[4], c[7];
DP3 R0.z, R1, R1;
RSQ R0.z, R0.z;
MOV R0.x, c[8];
CMP R0.x, R0.y, c[6], R0;
MUL R0.y, -fragment.texcoord[4].w, c[0].w;
ADD R0.y, R0, c[8].x;
RCP R1.x, R0.z;
MUL R0.zw, R0.y, c[8].xyxy;
MAD_SAT R0.y, R1.x, c[6].z, c[6].w;
FRC R0.zw, R0;
ADD_SAT result.color.x, R0, R0.y;
MOV R0.y, R0.w;
MAD R0.x, -R0.w, c[8].z, R0.z;
MOV result.color.zw, R0.xyxy;
MOV result.color.y, c[8].x;
END
# 32 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NONATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [unity_ShadowSplitSpheres0]
Vector 2 [unity_ShadowSplitSpheres1]
Vector 3 [unity_ShadowSplitSpheres2]
Vector 4 [unity_ShadowSplitSpheres3]
Vector 5 [unity_ShadowSplitSqRadii]
Vector 6 [_LightShadowData]
Vector 7 [unity_ShadowFadeCenterAndType]
SetTexture 1 [_ShadowMapTexture] 2D 1
"ps_3_0
; 32 ALU, 1 TEX
dcl_2d s1
def c8, 1.00000000, 255.00000000, 0.00392157, 0.00000000
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
add r0.xyz, v4, -c1
add r2.xyz, v4, -c4
dp3 r0.x, r0, r0
add r1.xyz, v4, -c2
dp3 r0.y, r1, r1
add r1.xyz, v4, -c3
dp3 r0.w, r2, r2
dp3 r0.z, r1, r1
add r0, r0, -c5
cmp r2, r0, c8.w, c8.x
add_sat r0.xyz, r2.yzww, -r2
mul r1.xyz, r0.x, v1
mad r1.xyz, r2.x, v0, r1
mad r1.xyz, r0.y, v2, r1
mad r0.xyz, v3, r0.z, r1
texld r0.x, r0, s1
add r0.x, r0, -r0.z
mov r0.y, c6.x
cmp r0.x, r0, c8, r0.y
add r1.xyz, -v4, c7
dp3 r0.z, r1, r1
rsq r0.z, r0.z
mul r0.y, -v4.w, c0.w
add r0.y, r0, c8.x
rcp r1.x, r0.z
mul r0.zw, r0.y, c8.xyxy
mad_sat r0.y, r1.x, c6.z, c6.w
frc r0.zw, r0
add_sat oC0.x, r0, r0.y
mov r0.y, r0.w
mad r0.x, -r0.w, c8.z, r0.z
mov oC0.zw, r0.xyxy
mov oC0.y, c8.x
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [unity_ShadowSplitSpheres0]
Vector 2 [unity_ShadowSplitSpheres1]
Vector 3 [unity_ShadowSplitSpheres2]
Vector 4 [unity_ShadowSplitSpheres3]
Vector 5 [unity_ShadowSplitSqRadii]
Vector 6 [_LightShadowData]
Vector 7 [unity_ShadowFadeCenterAndType]
SetTexture 1 [_ShadowMapTexture] 2D 1
"ps_3_0
; 32 ALU, 1 TEX
dcl_2d s1
def c8, 0.00000000, 1.00000000, 255.00000000, 0.00392157
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
add r0.xyz, v4, -c1
add r2.xyz, v4, -c4
dp3 r0.x, r0, r0
add r1.xyz, v4, -c2
dp3 r0.y, r1, r1
add r1.xyz, v4, -c3
dp3 r0.w, r2, r2
dp3 r0.z, r1, r1
add r0, r0, -c5
cmp r2, r0, c8.x, c8.y
add_sat r0.xyz, r2.yzww, -r2
mul r1.xyz, r0.x, v1
mad r1.xyz, r2.x, v0, r1
mad r1.xyz, r0.y, v2, r1
mad r0.xyz, v3, r0.z, r1
texld r0.x, r0, s1
mov r0.w, c6.x
add r0.y, c8, -r0.w
mad r0.x, r0, r0.y, c6
add r1.xyz, -v4, c7
dp3 r0.z, r1, r1
rsq r0.z, r0.z
mul r0.y, -v4.w, c0.w
add r0.y, r0, c8
rcp r1.x, r0.z
mul r0.zw, r0.y, c8.xyyz
mad_sat r0.y, r1.x, c6.z, c6.w
frc r0.zw, r0
add_sat oC0.x, r0, r0.y
mov r0.y, r0.w
mad r0.x, -r0.w, c8.w, r0.z
mov oC0.zw, r0.xyxy
mov oC0.y, c8
"
}
SubProgram "d3d11 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
SetTexture 0 [_ShadowMapTexture] 2D 0
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityShadows" 416
Vector 0 [unity_ShadowSplitSpheres0]
Vector 16 [unity_ShadowSplitSpheres1]
Vector 32 [unity_ShadowSplitSpheres2]
Vector 48 [unity_ShadowSplitSpheres3]
Vector 64 [unity_ShadowSplitSqRadii]
Vector 384 [_LightShadowData]
Vector 400 [unity_ShadowFadeCenterAndType]
BindCB  "UnityPerCamera" 0
BindCB  "UnityShadows" 1
"ps_4_0
eefiecedehfdffddekigboeafomdgidfgeolncnbabaaaaaaneafaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleaeaaaa
eaaaaaaacnabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaa
abaaaaaabkaaaaaafkaiaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egbcbaaaafaaaaaaegiccaiaebaaaaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaa
egbcbaaaafaaaaaaegiccaiaebaaaaaaabaaaaaaabaaaaaabaaaaaahccaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaa
egbcbaaaafaaaaaaegiccaiaebaaaaaaabaaaaaaacaaaaaabaaaaaahecaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaa
egbcbaaaafaaaaaaegiccaiaebaaaaaaabaaaaaaadaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadbaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaabaaaaaaaeaaaaaadhaaaaaphcaabaaaabaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaaceaaaaa
aaaaaaiaaaaaaaiaaaaaaaiaaaaaaaaaabaaaaakpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaaaaaaahocaabaaa
aaaaaaaaagajbaaaabaaaaaafgaobaaaaaaaaaaadeaaaaakocaabaaaaaaaaaaa
fgaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaajhcaabaaa
abaaaaaaegbcbaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegbcbaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegbcbaaaaeaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaehaaaaalbcaabaaaaaaaaaaaegaabaaaaaaaaaaaaghabaaaaaaaaaaa
aagabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaaakiacaia
ebaaaaaaabaaaaaabiaaaaaaabeaaaaaaaaaiadpdcaaaaakbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaabiaaaaaaaaaaaaaj
ocaabaaaaaaaaaaaagbjbaaaafaaaaaaagijcaiaebaaaaaaabaaaaaabjaaaaaa
baaaaaahccaabaaaaaaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaelaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadccaaaalccaabaaaaaaaaaaabkaabaaa
aaaaaaaackiacaaaabaaaaaabiaaaaaadkiacaaaabaaaaaabiaaaaaaaacaaaah
bccabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaalbcaabaaa
aaaaaaaadkbabaiaebaaaaaaafaaaaaadkiacaaaaaaaaaaaafaaaaaaabeaaaaa
aaaaiadpdiaaaaakdcaabaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaahpedaaaaaaaaaaaaaaaabkaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
dcaaaaakeccabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaibiaiadl
akaabaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaaaaaaaaaadgaaaaaf
cccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
}
 }
}
Fallback "Diffuse"
}