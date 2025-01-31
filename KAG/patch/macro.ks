[macro name=initscene]
[clearlayers]
[stopquake]
@stopbgm        cond=!mp.nostopbgm
@stopse buf=all cond=!mp.nostopse
[stopvideo]
[sysmovie state=end]
[history enabled=true]
[sysrclick]
[cancelnowaitmode]
[noeffect  enabled=true]
[clickskip enabled=true]
[init nostopbgm=%nostopbgm]
[linemode mode=free]
[craftername mode=true]
[erafterpage mode=true]
;[autoindent mode=true]
[current layer=message0]
[msgchange name="default"]
[endmacro]

; ムービー再生のsflagはパースモード時のみ有効
[macro name=movieflag][endmacro]

[macro name="シーン回想終了"][set name='&"sf."+mp.flag' value=1][exit storage="sceneplayer.ks" target="*endrecollection" eval="kag.isRecollection"][endmacro]

; parsemacro.ks から呼ばれるポイント
*common_macro

[macro name="エンディングクレジット"][exit storage=start.ks target=%target][endmacro]


;◆ムービー
	[macro name=movie]
	[quickmenu fadeout wait]
	[stopallvoice]
	[allse stop]
	[sysmovie *]
	[sysupdate]
	[quickmenu fadein]
	[endmacro]

;◆エンドロール
	@macro name=staffroll
	@cancelskip
;	@cancelautomode
	@clickskip enabled=false
	;
	@msgoff
	@bgm play=bgm_25 loop=false start=start
	@begintrans
	@allimage hide delete
	@ev file=bg_c_white
	@endtrans superlong sync
	;
	; BGMラベル待ち
	@wbl name=begin
	;
	; ロール初期化
	@rollinit flag='&@"${mp.rolltype}_rollflag"'
	;
	; ロール画像／スライドショー開始
	@newlay name=mask file=staffroll_mask level=5 notrans cond=!mp.subroute
	@newlay name=roll exroll='&"staffroll"+(mp.subroute?"2":"")+".tjs"' rolltime=label:begin:end rollendwait=5000 rollend=*stop level=6
	@rollimage file='&@"staffroll_${mp.rolltype}.ks"' label=cut cond=!mp.subroute
	;
	; ロール終了待ち
	@rollwait
	@delaycancel
	@rclickrollcancel enabled=false
	@set name='&@"sf.${mp.rolltype}_rollflag"' value="1"
	;
	; フェードアウト
	@bgm stop=3000
	@begintrans
	@allimage hide delete
	@endtrans normal
	;
	; 後始末
	@clickskip enabled=true
	@rollinit
	;
	@endmacro


;◆メッセージ窓枠変更
	[macro name=msgchange]
	[msgoff]
	[meswinload_switch page=both name=%name]
	[er]
	[endmacro]
	;
	[macro name=msgtype_normal][msgchange name="default"][endmacro]
	[macro name=msgtype_event ][msgchange name="event"  ][endmacro]

;◆好感度上昇演出
	[macro name=好感度上昇：エルシア＋１][eval exp="f.elsia_fav += 1"][koukando_up value=1 popup="popup_shia" ][endmacro]
	[macro name=好感度上昇：真奈＋１    ][eval exp="f.mana_fav  += 1"][koukando_up value=1 popup="popup_mana" ][endmacro]
	[macro name=好感度上昇：明莉＋１    ][eval exp="f.akari_fav += 1"][koukando_up value=1 popup="popup_akari"][endmacro]
	[macro name=好感度上昇：由宇＋１    ][eval exp="f.yuu_fav   += 1"][koukando_up value=1 popup="popup_yuu"  ][endmacro]

	[macro name=好感度上昇：エルシア＋２][eval exp="f.elsia_fav += 2"][koukando_up value=2 popup="popup_shia" ][endmacro]
	[macro name=好感度上昇：真奈＋２    ][eval exp="f.mana_fav  += 2"][koukando_up value=2 popup="popup_mana" ][endmacro]
	[macro name=好感度上昇：明莉＋２    ][eval exp="f.akari_fav += 2"][koukando_up value=2 popup="popup_akari"][endmacro]
	[macro name=好感度上昇：由宇＋２    ][eval exp="f.yuu_fav   += 2"][koukando_up value=2 popup="popup_yuu"  ][endmacro]


;■画面を暗転する共通処理
	[macro name=暗転共通]
	[ev resetcolor]
	[env resetcolor]
	[allimage hide]
	[endmacro]

;■画面を暗転する。キャラを消して画面が黒くなりますが、メッセージ窓や音は変化無し
	[macro name=暗転]
	[begintrans][暗転共通][endtrans trans=%trans|normal transwait=%transwait=|500]
	[autolabel][sysupdate]
	[endmacro]

;■暗転のメッセージ窓同時フェード版。スピード感ある演出用
	[macro name=暗転quick]
	[begintrans][暗転共通][endtrans trans=%trans|quickfade transwait=%transwait=|200]
	[autolabel][sysupdate]
	[endmacro]

;■暗転のユニバーサルトランジション版。音は変化無し
	[macro name=暗転univ]
	[begintrans][暗転共通][endtrans univ rule=%rule|map18 vague=%vague|100 time=%time|1000 transwait=%transwait=|500]
	[autolabel][sysupdate]
	[endmacro]

;■メッセージ窓と画面を暗転する。音は変化無し
	[macro name=窓消暗転]
	[begintrans][暗転共通][endtrans trans=%trans|normal transwait=%transwait=|500 msgoff]
	[autolabel][sysupdate]
	[endmacro]

;■窓消暗転のメッセージ窓同時フェード版。ほぼ瞬時に切り替わる演出用に特設
	[macro name=窓消暗転sq]
	[begintrans][暗転共通][msgoff][endtrans trans=%trans|superquick transwait=%transwait=|0]
	[endmacro]

;■窓消暗転のメッセージ窓同時フェード版。スピード感ある演出用に特設
	[macro name=窓消暗転quick]
	[begintrans][暗転共通][msgoff][endtrans trans=%trans|quickfade transwait=%transwait=|200]
	[endmacro]

;■窓消暗転のmidfade版。音は変化無し
	[macro name=窓消暗転mid]
	[begintrans][暗転共通][endtrans trans=%trans|midfade transwait=%transwait|1000 msgoff]
	[autolabel][sysupdate]
	[endmacro]

;■窓消暗転のlongfade版。音は変化無し
	[macro name=窓消暗転long]
	[begintrans][暗転共通][endtrans trans=%trans|longfade transwait=%transwait|1000 msgoff]
	[autolabel][sysupdate]
	[endmacro]

;■窓消暗転のユニバーサルトランジション版。音は変化無し
	[macro name=窓消暗転univ]
	[begintrans][暗転共通][endtrans univ rule=%rule|map18 time=%time|1000 vague=%vague|100 transwait=%transwait|500 msgoff]
	[autolabel][sysupdate]
	[endmacro]



;■画面を白転する共通処理
	[macro name=白転共通]
	[ev resetcolor]
	[env resetcolor]
	[allimage hide]
	[白]
	[endmacro]

;■画面を白転する。キャラを消して画面が黒くなりますが、メッセージ窓や音は変化無し
	[macro name=白転]
	[begintrans][白転共通][endtrans trans=%trans|normal transwait=%transwait=|500]
	[autolabel][sysupdate]
	[endmacro]

;■白転のメッセージ窓同時フェード版。スピード感ある演出用
	[macro name=白転quick]
	[begintrans][白転共通][endtrans trans=%trans|quickfade transwait=%transwait=|200]
	[autolabel][sysupdate]
	[endmacro]

;■白転のユニバーサルトランジション版。音は変化無し
	[macro name=白転univ]
	[begintrans][白転共通][endtrans univ rule=%rule|map18 vague=%vague|100 time=%time|1000 transwait=%transwait=|500]
	[autolabel][sysupdate]
	[endmacro]

;■メッセージ窓と画面を白転する。音は変化無し
	[macro name=窓消白転]
	[begintrans][白転共通][endtrans trans=%trans|normal transwait=%transwait=|500 msgoff]
	[autolabel][sysupdate]
	[endmacro]

;■窓消白転のメッセージ窓同時フェード版。ほぼ瞬時に切り替わる演出用に特設
	[macro name=窓消白転sq]
	[begintrans][白転共通][msgoff][endtrans trans=%trans|superquick transwait=%transwait=|0]
	[endmacro]

;■窓消白転のメッセージ窓同時フェード版。スピード感ある演出用に特設
	[macro name=窓消白転quick]
	[begintrans][白転共通][msgoff][endtrans trans=%trans|quickfade transwait=%transwait=|200]
	[endmacro]

;■窓消白転のmidfade版。音は変化無し
	[macro name=窓消白転mid]
	[begintrans][白転共通][endtrans trans=%trans|midfade transwait=%transwait|1000 msgoff]
	[autolabel][sysupdate]
	[endmacro]

;■窓消白転のlongfade版。音は変化無し
	[macro name=窓消白転long]
	[begintrans][白転共通][endtrans trans=%trans|longfade transwait=%transwait|1000 msgoff]
	[autolabel][sysupdate]
	[endmacro]

;■窓消白転のユニバーサルトランジション版。音は変化無し
	[macro name=窓消白転univ]
	[begintrans][白転共通][endtrans univ rule=%rule|map18 time=%time|1000 vague=%vague|100 transwait=%transwait|500 msgoff]
	[autolabel][sysupdate]
	[endmacro]





;■グラフィック、音、メッセージ窓をすべてフェードアウト。主に各スクリプトの最後やゆっくりとした場面転換に使用
;※一時的にclearstandcacheをコメントアウト（mngw 3/22）

	[macro name=終端]
	[msgoff normal]
	[bgm stop time=4000]
	[allse stop time=4000]
	[begintrans]
	[暗転共通]
	[endtrans trans=%trans|longfade transwait=%transwait|2000]
	[bgm wait]
	[allse stop fade=100]
	[autolabel][sysupdate]
	[endmacro]

	[macro name=終端quick]
	[msgoff normal]
	[bgm stop time=3000]
	[allse stop time=3000]
	[begintrans]
	[暗転共通]
	[endtrans trans=%trans|midfade transwait=%transwait|1000]
	[bgm wait]
	[allse stop fade=100]
	[autolabel][sysupdate]
	[endmacro]

	[macro name=終端最速]
	[msgoff normal]
	[bgm stop time=2000]
	[allse stop time=2000]
	[begintrans]
	[暗転共通]
	[endtrans trans=%trans|midfade transwait=%transwait|1000]
	[bgm wait]
	[allse stop fade=100]
	[autolabel][sysupdate]
	[endmacro]

	[macro name=瞬間終端]
	[bgm stop time=0]
	[allse stop time=0]
	[begintrans]
	[msgoff]
	[暗転共通]
	[endtrans notrans]
	[bgm wait]
	[allse stop fade=100]
	[autolabel][sysupdate]
	[endmacro]

	[macro name=白終端]
	[msgoff normal]
	[bgm stop time=4000]
	[allse stop time=4000]
	[begintrans]
	[白転共通]
	[endtrans trans=%trans|longfade transwait=%transwait|2000]
	[bgm wait]
	[allse stop fade=100]
	[autolabel][sysupdate]
	[endmacro]

	[macro name=白終端quick]
	[msgoff normal]
	[bgm stop time=3000]
	[allse stop time=3000]
	[begintrans]
	[白転共通]
	[endtrans trans=%trans|midfade transwait=%transwait|1000]
	[bgm wait]
	[allse stop fade=100]
	[autolabel][sysupdate]
	[endmacro]


	[macro name=ルートエンド]

	[clickskip enabled=false]
	[quickmenu fadeout]

	[allse stop time=8000]
	[newlay name=backcolor file=%file|bg_c_white xpos=0 ypos=0 show level=6 opacity=0 notrans]
	[backcolor opacity=255 time=5000 accel=acdec nowait]
	[wait time=2000]
	[bgm stop time=14000 ]
	[wait time=4000]
	[stopaction]
	[newlay name=fin file=fin_logo xpos=-20 ypos=10 show level=7 notrans opacity=0 zoom=105]
	[fin opacity=255 time=4000 nowait]
	[fin xpos=0 ypos=0 zoom=100 time=4000 accel=acdec sync]
	[stopaction]
	[wait time=3000]

	[fin opacity=0 time=4000 nowait]
	[wait time=2500]

	[begintrans]
	[暗転共通]
	[endtrans trans=superlong]
	[wait time=4000]
	[bgm wait]

	[clickskip enabled=true]

	[allse stop fade=100]
	[dellay name=backcolor]
	[dellay name=fin]
	[autolabel][sysupdate]
	[clearstandcache]
	[wait time=1000]
	[endmacro]


;■瞬間真っ白
	[macro name=瞬間白]
	[begintrans]
	[msgoff]
	[白転共通]
	[endtrans notrans]
	[endmacro]

;■瞬間真っ黒
	[macro name=瞬間黒]
	[begintrans]
	[msgoff]
	[暗転共通]
	[黒色]
	[endtrans notrans]
	[endmacro]

;■瞬間真っ赤
	[macro name=瞬間赤]
	[begintrans]
	[msgoff]
	[暗転共通]
	[赤]
	[endtrans notrans]
	[endmacro]

	[macro name=瞬間赤２]
	[begintrans]
	[msgoff]
	[暗転共通]
	[赤２]
	[endtrans notrans]
	[endmacro]


;■ネガポジ反転（ソラリゼーション）

;出現
	[macro name=ネガポジ]
	[newlay name=negaposi file=bg_c_white level=%level|6 type=ltPsDifference]
	[endmacro]

;戻し
	[macro name=ネガポジ戻し]
	[negaposi time=%time|200 accel=%accel|1 opacity=%opacity|0 sync]
	[dellay name=negaposi]
	[endmacro]


;■イベントCG用のスパーク演出（射精とか）
	[macro name=スパーク演出イベント]
;	[newlay name=f_white file=%file|bg_c_white hide level=7 front]
	[f_white file=%file|bg_c_white hide level=7 front]
	[msgoff time=0]
	[beginskip]
	[f_white show]
	[wait time=50]
	[f_white hide]
	[wait time=50]
	[f_white show]
	[wait time=50]
	[f_white hide]
	[wait time=50]
	[f_white show]
	[wait time=50]
	[f_white hide]
	[wait time=50]
	[f_white show]
	[wait time=50]
	[f_white hide]
	[wait time=50]
	[f_white show]
	[wait time=50]
	[f_white hide]
	[wait time=50]
	[endskip]
	[dellay name=f_white]
	[endmacro]


;■一回だけスパーク（フラッシュ）
	[macro name=フラッシュ]
	[begintrans]
	[msgoff]
	[endtrans notrans]
	[f_white file=bg_c_white hide level=7 front]
;	[newlay name=f_white file=bg_c_white hide level=7 front]
	[beginskip]
	[f_white show notrans sync]
	[wait time=50]
	[f_white delete normal sync]
	[endskip]
	[endmacro]

;■一回だけスパーク（フラッシュ）長いver
	[macro name=フラッシュ長]
	[begintrans]
	[msgoff]
	[endtrans notrans]
	[f_white file=bg_c_white hide level=7 front]
;	[newlay name=f_white file=bg_c_white hide level=7 front]
	[beginskip]
	[f_white show notrans sync]
	[wait time=50]
	[f_white delete longfade sync]
	[endskip]
	[endmacro]

;■一回だけスパーク（フラッシュ）短いver
	[macro name=フラッシュ短]
	[begintrans]
	[msgoff]
	[endtrans notrans]
	[f_white file=bg_c_white hide level=7 front]
;	[newlay name=f_white file=bg_c_white hide level=7 front]
	[beginskip]
	[f_white show notrans sync]
	[wait time=50]
	[f_white delete quickfade sync]
	[endskip]
	[endmacro]

;■一回だけスパーク（フラッシュ）超短いver
	[macro name=フラッシュ超短]
	[begintrans]
	[msgoff]
	[endtrans notrans]
	[f_white file=bg_c_white hide level=7 front]
;	[newlay name=f_white file=bg_c_white hide level=7 front]
	[beginskip]
	[f_white show notrans sync]
	[wait time=25]
	[f_white delete superquick sync]
	[endskip]
	[endmacro]


;■場面転換・時間経過
	[macro name=場面転換]
	[begintrans]
	[allimage hide]
	[bg stage=%stage stime=%stime xpos=%xpos|0 ypos=%ypos|0 zoom=%zoom|100 blur=%blur|0]
	[endtrans univ rule=%rule|map18 time=%time|1000 transwait=%transwait|0 vague=%vague|100 msgoff]
	[endmacro]

	[macro name=場面転換速]
	[begintrans]
	[allimage hide]
	[bg stage=%stage stime=%stime xpos=%xpos|0 ypos=%ypos|0 zoom=%zoom|100 blur=%blur|0]
	[endtrans univ rule=%rule|map504a time=%time|300 transwait=%transwait|500 vague=%vague|300 msgoff]
	[endmacro]

	[macro name=場面転換・イベント]
	[begintrans]
	[allimage hide]
	[ev file=%file xpos=%xpos|0 ypos=%ypos|0 zoom=%zoom|100 blur=%blur|0]
	[endtrans univ rule=%rule|map18 time=%time|1000 transwait=%transwait|0 vague=%vague|100 msgoff]
	[endmacro]

	[macro name=場面転換速・イベント]
	[begintrans]
	[allimage hide]
	[ev file=%file xpos=%xpos|0 ypos=%ypos|0 zoom=%zoom|100 blur=%blur|0]
	[endtrans univ rule=%rule|map504a time=%time|300 transwait=%transwait|500 vague=%vague|300 msgoff]
	[endmacro]


	[macro name=場面転換閉]
	[begintrans]
	[allimage hide]
	[endtrans univ rule=%rule|map18 time=%time|1000 transwait=%transwait|1000 vague=%vague|100 msgoff]
	[endmacro]

	[macro name=場面転換速閉]
	[begintrans]
	[allimage hide]
	[endtrans univ rule=%rule|map504a time=%time|300 transwait=%transwait|500 vague=%vague|300 msgoff]
	[endmacro]


	[macro name=時間経過]
	[begintrans]
	[allimage hide]
	[bg stage=%stage stime=%stime xpos=%xpos|0 ypos=%ypos|0 zoom=%zoom|100 blur=%blur|0]
	[endtrans univ rule=%rule|map27 time=%time|1000 transwait=%transwait|0 vague=%vague|100 msgoff]
	[endmacro]

	[macro name=時間経過・イベント]
	[begintrans]
	[allimage hide]
	[ev file=%file xpos=%xpos|0 ypos=%ypos|0 zoom=%zoom|100 blur=%blur|0]
	[endtrans univ rule=%rule|map27 time=%time|1000 transwait=%transwait|0 vague=%vague|100 msgoff]
	[endmacro]

	[macro name=時間経過閉]
	[begintrans]
	[allimage hide]
	[endtrans univ rule=%rule|map27 time=%time|1000 transwait=%transwait|1000 vague=%vague|100 msgoff]
	[endmacro]

	[macro name=場面転換暗転]
	[beginskip]
	[場面転換閉 rule=%rule|map18 time=%time|1200 vague=%vague|100]
	[wait time=%wtime|300]
	[begintrans]
	[bg stage=%stage stime=%stime xpos=%xpos|0 ypos=%ypos|0 zoom=%zoom|100 blur=%blur|0]
	[endtrans trans=univ rule=%rule|map18 time=%time|1200 transwait=%transwait|1000 vague=%vague|100 sync]
	[endskip]
	[endmacro]

	[macro name=時間経過暗転]
	[beginskip]
	[時間経過閉 rule=%rule|map27 time=%time|1200 vague=%vague|100]
	[wait time=%wtime|300]
	[begintrans]
	[bg stage=%stage stime=%stime xpos=%xpos|0 ypos=%ypos|0 zoom=%zoom|100 blur=%blur|0]
	[endtrans trans=univ rule=%rule|map27 time=%time|1200 transwait=%transwait|1000 vague=%vague|100 sync]
	[endskip]
	[endmacro]


;■汎用振動

	[macro name=振動小]
	[quake time=%time|300 hmax=%x|3 vmax=%y|3]
	[endmacro]

	[macro name=振動縦小]
	[quake time=%time|500 hmax=%x|0 vmax=%y|3]
	[endmacro]

	[macro name=振動横小]
	[quake time=%time|500 hmax=%x|3 vmax=%y|0]
	[endmacro]

	[macro name=振動]
	[quake time=%time|500 hmax=%x|5 vmax=%y|5]
	[endmacro]

	[macro name=振動縦]
	[quake time=%time|500 hmax=%x|0 vmax=%y|5]
	[endmacro]

	[macro name=振動横]
	[quake time=%time|500 hmax=%x|5 vmax=%y|0]
	[endmacro]

	[macro name=振動大]
	[quake time=%time|1000 hmax=%x|8 vmax=%y|8]
	[endmacro]

	[macro name=振動縦大]
	[quake time=%time|1000 hmax=%x|0 vmax=%y|8]
	[endmacro]
	
	[macro name=振動横大]
	[quake time=%time|1000 hmax=%x|8 vmax=%y|0]
	[endmacro]

	[macro name=振動停止]
	[stopquake]
	[endmacro]


	[macro name=爆破振動]
	[quake time=%time|1000 hmax=%x|8 vmax=%y|8]
	[bg zoom=140 notrans]
	[wait time=30]
	[bg zoom=110 notrans]
	[wait time=30]
	[bg zoom=120 notrans]
	[endmacro]


;■迫力ある一枚絵表示（イベント絵）

	[macro name=迫力表示・イベント]
	[msgoff time=0]
	[ev file=%file zoom=%zoom|400 xpos=%xpos|0 ypos=%ypos|0 time=0 superquick]
	[ev zoom=100 xpos=%xpos2|0 ypos=%ypos2|0 time=100 accel=-1 sync]
	[quake time=600 hmax=10 vmax=10]
	[ev zoom=105 time=300 accel=-1 sync]
	[wait time=100]
	[ev zoom=100 notrans]
	[endmacro]


;■迫力ある一枚絵表示（背景）
;この指定の前に[bg** notrans]を置く必要があります

	[macro name=迫力表示]
	[msgoff time=0]
	[env stage=%stage zoom=%zoom|400 xpos=%xpos|-100 ypos=%ypos|-100 time=0 superquick]
	[env zoom=100 xpos=%xpos2|0 ypos=%ypos2|0 time=100 accel=-1 sync]
	[quake time=600 hmax=10 vmax=10]
	[env zoom=105 time=300 accel=-1 sync]
	[wait time=100]
	[env zoom=100 notrans]
	[endmacro]


;■驚き演出

	[macro name=驚き演出]
	[begintrans]
	[msgoff]
	[newlay name=kakudai_img file=%file|bg_c_white xpos=%xpos|0 ypos=%ypos|0 show notrans sync level=%level|0 zoom=%zmbf|100]
	[bg stage=%stage|空 notrans zoom=%zoom|100 sync]
	[newlay name=at file=attention6 xpos=%xpos2|0 ypos=%yposat|0 show level=%levelat|6 opacity=128]
	[newlay name=at2 file=attention5 xpos=%xpos2|0 ypos=%yposat|0 show level=%levelat|6 zoom=120]
	[endtrans notrans]
	[quake time=%qtime|500]
	[at accel=-1 opacity=0 time=%time|250 ]
	[at2 accel=-1 opacity=0 time=%time|250 ]
	[kakudai_img zoom=%zmaf|200 accel=-1 opacity=0 time=%time|250 xpos=%xposaf|0 ypos=%yposaf|0 sync]
	[at hide]
	[at2 hide]
	[kakudai_img hide]
	[endmacro]

	[macro name=驚き演出・セピア]
	[begintrans]
	[msgoff]
	[newlay name=kakudai_img file=%file|bg_c_white xpos=%xpos|0 ypos=%ypos|0 show notrans sync level=%level|0 zoom=%zmbf|100 grayscale=true rgamma=1.3 ggamma=1.1]
	[bg notrans zoom=%zoom|100 sync grayscale=true rgamma=1.3 ggamma=1.1]
	[newlay name=at file=attention6 xpos=%xpos2|0 ypos=%yposat|0 show level=%levelat|6 opacity=128]
	[newlay name=at2 file=attention5 xpos=%xpos2|0 ypos=%yposat|0 show level=%levelat|6 zoom=120]
	[endtrans notrans]
	[quake time=%qtime|500]
	[at accel=-1 opacity=0 time=%time|250 ]
	[at2 accel=-1 opacity=0 time=%time|250 ]
	[kakudai_img zoom=%zmaf|200 accel=-1 opacity=0 time=%time|250 xpos=%xposaf|0 ypos=%yposaf|0 sync]
	[at hide]
	[at2 hide]
	[kakudai_img hide]
	[endmacro]

	[macro name=驚き演出・イベント]
	[begintrans]
	[msgoff]
	[ev file=%file|bg_c_white xpos=%xpos|0 ypos=%ypos|0 zoom=%zoom|100 ]
	[newlay name=kakudai_img file=%file|bg_c_white xpos=%xposbf|0 ypos=%yposbf|0 show notrans sync level=%level|9 zoom=%zmbf|100]
	[newlay name=at file=attention6 xpos=%xposat|0 ypos=%yposat|0 show level=%level2|9 opacity=128]
	[newlay name=at2 file=attention5 xpos=%xposat|0 ypos=%yposat|0 show level=%level2|9 zoom=120]
	[endtrans notrans]
	[quake time=%qtime|500]
	[at accel=-1 opacity=0 time=%time|250 ]
	[at2 accel=-1 opacity=0 time=%time|250 ]
	[kakudai_img zoom=%zmaf|200 accel=-1 opacity=0 time=%time|250 sync xpos=%xposaf|0 ypos=%yposaf|0]
	[at hide]
	[at2 hide]
	[kakudai_img hide]
	[endmacro]

	[macro name=驚き演出・イベント・セピア]
	[begintrans]
	[msgoff]
	[ev file=%file|bg_c_white xpos=%xpos|0 ypos=%ypos|0 zoom=%zoom|100 grayscale=true rgamma=1.3 ggamma=1.1]
	[newlay name=kakudai_img file=%file|bg_c_white xpos=%xposbf|0 ypos=%yposbf|0 show notrans sync level=%level|6 zoom=%zmbf|100 grayscale=true rgamma=1.3 ggamma=1.1]
	[newlay name=at file=attention6 xpos=%xposat|0 ypos=%yposat|0 show level=%level2|6 opacity=128]
	[newlay name=at2 file=attention5 xpos=%xposat|0 ypos=%yposat|0 show level=%level2|6 zoom=120]
	[endtrans notrans]
	[quake time=%qtime|500]
	[at accel=-1 opacity=0 time=%time|250 ]
	[at2 accel=-1 opacity=0 time=%time|250 ]
	[kakudai_img zoom=%zmaf|200 accel=-1 opacity=0 time=%time|250 sync xpos=%xposaf|0 ypos=%yposaf|0]
	[at hide]
	[at2 hide]
	[kakudai_img hide]
	[endmacro]


;■集中線
	[macro name=集中線]
;	[at1 file=attention6 xpos=%xpos|0 ypos=%ypos|0 show level=%level|6 opacity=128]
;	[at2 file=attention5 xpos=%xpos|0 ypos=%ypos|0 show level=%level|6 zoom=120]
	[newlay name=at1 file=attention6 xpos=%xpos|0 ypos=%ypos|0 show level=%level|6 opacity=128]
	[newlay name=at2 file=attention5 xpos=%xpos|0 ypos=%ypos|0 show level=%level|6 zoom=120]
	[endmacro]

	[macro name=集中線・振動]
	[newlay name=at1 file=attention6 xpos=%xpos|0 ypos=%ypos|0 show level=%level|6 opacity=128]
	[newlay name=at2 file=attention5 xpos=%xpos|0 ypos=%ypos|0 show level=%level|6 zoom=120]
	[at1 ガクガク大 time=%time|500]
	[at2 ガクガク大 time=%time|500]
	[endmacro]

	[macro name=集中線消]
	[at1 hide]
	[at2 hide]
	[endmacro]

	[macro name=集中線消opa]
	[at1 opacity=0 time=%time|500]
	[at2 opacity=0 time=%time|500]
	[endmacro]


;■シネスコ

	[macro name=シネスコ]
	;[cine file=%file|cinesco1 xpos=0 ypos=0 level=0 back show trans=univ rule=%rule|map501 time=%time|1000 vague=%vague|600 accel=%accel|1 level=%level|0 front]
	[newlay name=cine file=%file|cinesco1b xpos=0 ypos=0 level=0 back show trans=univ rule=%rule|map501 time=%time|1000 vague=%vague|600 accel=%accel|1 level=%level|0 front]
	[endmacro]

	[macro name=シネスコ４]
	;[cine file=%file|cinesco1 xpos=0 ypos=0 level=0 back show trans=univ rule=%rule|map501 time=%time|1000 vague=%vague|600 accel=%accel|1 level=%level|0 front]
	[newlay name=cine file=%file|cinesco4 xpos=0 ypos=0 level=0 back show trans=univ rule=%rule|map501 time=%time|1000 vague=%vague|600 accel=%accel|1 level=%level|0 front opacity=%opacity|255]
	[endmacro]

	[macro name=シネスコ縦]
	;[cine file=%file|cinesco3 xpos=%xpos|0 ypos=0 show level=0 back univ rule=%rule|map502 time=%time|1000 vague=%vague|600 accel=%accel|1 level=%level|0 front]
	[newlay name=cine file=%file|cinesco3 xpos=%xpos|0 ypos=0 show level=0 back univ rule=%rule|map502 time=%time|1000 vague=%vague|600 accel=%accel|1 level=%level|0 front]
	[endmacro]

	[macro name=シネスコ白]
	;[cine file=%file|cinesco1w xpos=0 ypos=0 level=%level|7 back show trans=univ rule=%rule|map501 time=%time|1000 vague=%vague|600 accel=%accel|1 opacity=%opacity|192 front]
	[newlay name=cine file=%file|cinesco1bw xpos=0 ypos=0 level=%level|7 back show trans=univ rule=%rule|map501 time=%time|1000 vague=%vague|600 accel=%accel|1 opacity=%opacity|192 front]
	[endmacro]

	[macro name=シネスコピンク]
	;[cine file=%file|cinesco1w xpos=0 ypos=0 level=%level|7 back show trans=univ rule=%rule|map501 time=%time|1000 vague=%vague|600 accel=%accel|1 opacity=%opacity|192 front]
	[newlay name=cine file=%file|cinesco1p xpos=0 ypos=0 level=%level|7 back show trans=univ rule=%rule|map501 time=%time|1000 vague=%vague|600 accel=%accel|1 opacity=%opacity|192 front]
	[endmacro]

	[macro name=シネスコ消]
	[cine hide univ rule=%rule|map501b time=%time|1000 vague=%vague|600 accel=%accel|-1]
	[endmacro]

	[macro name=シネスコ縦消]
	[cine hide univ rule=%rule|map502b time=%time|1000 vague=%vague|600 accel=%accel|-1]
	[endmacro]


;■ガクドキ
	[macro name=ガクドキ]
	[char name=%name どっきり小 time=%dtime]
	[char name=%name ガクガク time=%gtime|300]
	[endmacro]


;■飛びのけ

	[macro name=飛びのけ右]
	[char name=%name びょん速 time=%time|300]
	[char name=%name xpos=%xpos|250 time=%time|300 accel=%accel|-1]
	[endmacro]

	[macro name=飛びのけ左]
	[char name=%name びょん速 time=%time|300]
	[char name=%name xpos=%xpos|-250 time=%time|300 accel=%accel|-1]
	[endmacro]
	
	[macro name=飛びのけ左遅]
	[char name=%name びょん time=%time|300]
	[char name=%name xpos=%xpos|-250 time=%time|600 accel=%accel|-1]
	[endmacro]
	
	[macro name=飛びのけ]
	[char name=%name びょん速 time=%time|300 ]
	[char name=%name xpos=%xpos2|250 time=%time|300 accel=%accel|-1]
	[endmacro]


;■画面をセピア色に変化

	[macro name=セピア・背景]
	[bg grayscale=true rgamma=1.3 ggamma=1.1 trans=%trans|normal]
	[endmacro]

	[macro name=セピア・イベント]
	[ev grayscale=true rgamma=1.3 ggamma=1.1 trans=%trans|normal]
	[endmacro]

	[macro name=セピア・キャラ]
	[allchar grayscale=true rgamma=1.3 ggamma=1.1 trans=%trans|normal]
	[endmacro]

	[macro name=セピア]
	[env grayscale=true rgamma=1.3 ggamma=1.1 trans=%trans|normal]
	[endmacro]

	[macro name=セピア戻し]
	[begintrans]
	[env resetcolor]
	[endtrans trans=%trans|normal]
	[endmacro]


;■セピアとシネスコ一括戻し（回想シーン終了時など）

	[macro name=セピア・シネスコ戻し]
	[begintrans]
	[セピア戻し]
	[シネスコ消]
	[endtrans notrans]
	[endmacro]


	;300%ズーム汎用
	[macro name=背景ズーム３００]
	[msgoff]
	[bg zoom=300 xpos=%xpos|0 ypos=%ypos|-700 blur=%blur|0]
	[endmacro]

	[macro name=背景ズーム３００右]
	[msgoff]
	[bg zoom=300 xpos=%xpos|-1920 ypos=%ypos|-700 blur=%blur|0]
	[endmacro]

	[macro name=背景ズーム３００右奥]
	[msgoff]
	[bg zoom=300 xpos=%xpos|-3840 ypos=%ypos|-700 blur=%blur|0]
	[endmacro]

	[macro name=背景ズーム３００左]
	[msgoff]
	[bg zoom=300 xpos=%xpos|1920 ypos=%ypos|-700 blur=%blur|0]
	[endmacro]

	[macro name=背景ズーム３００左奥]
	[msgoff]
	[bg zoom=300 xpos=%xpos|3840 ypos=%ypos|-700 blur=%blur|0]
	[endmacro]


	;300%ズーム ypos=0　背の低いキャラ用（ケースバイケースで使用
	[macro name=背景ズーム３００縦０]
	[msgoff]
	[bg zoom=300 xpos=%xpos|0 ypos=%ypos|0 blur=%blur|0]
	[endmacro]

	[macro name=背景ズーム３００縦０右]
	[msgoff]
	[bg zoom=300 xpos=%xpos|-1920 ypos=%ypos|0 blur=%blur|0]
	[endmacro]

	[macro name=背景ズーム３００縦０右奥]
	[msgoff]
	[bg zoom=300 xpos=%xpos|-3840 ypos=%ypos|0 blur=%blur|0]
	[endmacro]
	
	[macro name=背景ズーム３００縦０左]
	[msgoff]
	[bg zoom=300 xpos=%xpos|1920 ypos=%ypos|0 blur=%blur|0]
	[endmacro]

	[macro name=背景ズーム３００縦０左奥]
	[msgoff]
	[bg zoom=300 xpos=%xpos|3840 ypos=%ypos|0 blur=%blur|0]
	[endmacro]


	;200%ズーム汎用　ypos=-700　男性の背丈に合わせた
	[macro name=背景ズーム２００男]
	[msgoff]
	[bg zoom=200 xpos=%xpos|0 ypos=%ypos|-900 blur=0 ]
;	[bg blur=1]
	[endmacro]

	[macro name=背景ズーム２００男右]
	[msgoff]
	[bg zoom=200 xpos=%xpos|-1280 ypos=%ypos|-900 blur=0 ]
;	[bg blur=1]
	[endmacro]

	[macro name=背景ズーム２００男右奥]
	[msgoff]
	[bg zoom=200 xpos=%xpos|-2560 ypos=%ypos|-900 blur=0 ]
;	[bg blur=1]
	[endmacro]
	
	[macro name=背景ズーム２００男左]
	[msgoff]
	[bg zoom=200 xpos=%xpos|1280 ypos=%ypos|-900 blur=0 ]
;	[bg blur=1]
	[endmacro]

	[macro name=背景ズーム２００男左奥]
	[msgoff]
	[bg zoom=200 xpos=%xpos|2560 ypos=%ypos|-900 blur=0 ]
;	[bg blur=1]
	[endmacro]


	;200%ズーム汎用　ypos=-500　背の高い女性（エルシア、真奈、佳織）の背丈に合わせた
	[macro name=背景ズーム２００高]
	[msgoff]
	[bg zoom=200 xpos=%xpos|0 ypos=%ypos|-600 blur=0 ]
;	[bg blur=1]
	[endmacro]

	[macro name=背景ズーム２００高右]
	[msgoff]
	[bg zoom=200 xpos=%xpos|-1280 ypos=%ypos|-600 blur=0 ]
;	[bg blur=1]
	[endmacro]

	[macro name=背景ズーム２００高右奥]
	[msgoff]
	[bg zoom=200 xpos=%xpos|-2560 ypos=%ypos|-600 blur=0 ]
;	[bg blur=1]
	[endmacro]

	[macro name=背景ズーム２００高左]
	[msgoff]
	[bg zoom=200 xpos=%xpos|1280 ypos=%ypos|-600 blur=0 ]
;	[bg blur=1]
	[endmacro]

	[macro name=背景ズーム２００高左奥]
	[msgoff]
	[bg zoom=200 xpos=%xpos|2560 ypos=%ypos|-600 blur=0 ]
;	[bg blur=1]
	[endmacro]


	;200%ズーム ypos=-300　女性の背丈に合わせた
	[macro name=背景ズーム２００]
	[msgoff]
	[bg zoom=200 xpos=%xpos|0 ypos=%ypos|-400 blur=0 ]
;	[bg blur=1]
	[endmacro]

	[macro name=背景ズーム２００右]
	[msgoff]
	[bg zoom=200 xpos=%xpos|-1280 ypos=%ypos|-400 blur=0 ]
;	[bg blur=1]
	[endmacro]

	[macro name=背景ズーム２００右奥]
	[msgoff]
	[bg zoom=200 xpos=%xpos|-2560 ypos=%ypos|-400 blur=0 ]
;	[bg blur=1]
	[endmacro]


	[macro name=背景ズーム２００左]
	[msgoff]
	[bg zoom=200 xpos=%xpos|1280 ypos=%ypos|-400 blur=0 ]
;	[bg blur=1]
	[endmacro]

	[macro name=背景ズーム２００左奥]
	[msgoff]
	[bg zoom=200 xpos=%xpos|2560 ypos=%ypos|-400 blur=0 ]
;	[bg blur=1]
	[endmacro]


	;200%ズーム ypos=0　背の低いキャラ用（ケースバイケースで使用
	[macro name=背景ズーム２００縦０]
	[msgoff]
	[bg zoom=200 xpos=%xpos|0 ypos=%ypos|0 blur=0 ]
;	[bg blur=1]
	[endmacro]

	[macro name=背景ズーム２００縦０右]
	[msgoff]
	[bg zoom=200 xpos=%xpos|-1280 ypos=%ypos|0 blur=0 ]
;	[bg blur=1]
	[endmacro]

	[macro name=背景ズーム２００縦０右奥]
	[msgoff]
	[bg zoom=200 xpos=%xpos|-2560 ypos=%ypos|0 blur=0 ]
;	[bg blur=1]
	[endmacro]

	[macro name=背景ズーム２００縦０左]
	[msgoff]
	[bg zoom=200 xpos=%xpos|1280 ypos=%ypos|0 blur=0 ]
;	[bg blur=1]
	[endmacro]

	[macro name=背景ズーム２００縦０左奥]
	[msgoff]
	[bg zoom=200 xpos=%xpos|2560 ypos=%ypos|0 blur=0 ]
;	[bg blur=1]
	[endmacro]

	;200%ズーム ypos=0　背の低いキャラ用（ケースバイケースで使用
	[macro name=背景ズーム２００着座]
	[msgoff]
	[bg zoom=200 xpos=%xpos|0 ypos=%ypos|500 blur=0 ]
;	[bg blur=1]
	[endmacro]

	[macro name=背景ズーム２００着座右]
	[msgoff]
	[bg zoom=200 xpos=%xpos|-1280 ypos=%ypos|500 blur=0 ]
;	[bg blur=1]
	[endmacro]

	[macro name=背景ズーム２００着座右奥]
	[msgoff]
	[bg zoom=200 xpos=%xpos|-2560 ypos=%ypos|500 blur=0 ]
;	[bg blur=1]
	[endmacro]
	
	[macro name=背景ズーム２００着座左]
	[msgoff]
	[bg zoom=200 xpos=%xpos|1280 ypos=%ypos|500 blur=0 ]
;	[bg blur=1]
	[endmacro]

	[macro name=背景ズーム２００着座左奥]
	[msgoff]
	[bg zoom=200 xpos=%xpos|2560 ypos=%ypos|500 blur=0 ]
;	[bg blur=1]
	[endmacro]


	;200%ズーム ypos=1900　地べた用
	[macro name=背景ズーム２００地面]
	[msgoff]
	[bg zoom=200 xpos=%xpos|0 ypos=%ypos|1850 blur=0 ]
;	[bg blur=1]
	[endmacro]

	[macro name=背景ズーム２００地面右]
	[msgoff]
	[bg zoom=200 xpos=%xpos|-1280 ypos=%ypos|1850 blur=0 ]
;	[bg blur=1]
	[endmacro]

	[macro name=背景ズーム２００地面右奥]
	[msgoff]
	[bg zoom=200 xpos=%xpos|-2560 ypos=%ypos|1850 blur=0 ]
;	[bg blur=1]
	[endmacro]
	
	[macro name=背景ズーム２００地面左]
	[msgoff]
	[bg zoom=200 xpos=%xpos|1280 ypos=%ypos|1850 blur=0]
;	[bg blur=1]
	[endmacro]

	[macro name=背景ズーム２００地面左奥]
	[msgoff]
	[bg zoom=200 xpos=%xpos|2560 ypos=%ypos|1850 blur=0 ]
;	[bg blur=1]
	[endmacro]


	;ズームしていた背景を戻す（座標も）
	[macro name=背景戻し]
	[msgoff]
	[env resetcolor]
	[bg zoom=100 xpos=%xpos|0 ypos=%ypos|0 ]
	[bg blur=0]
	[endmacro]

	;背景戻しまとめテンプレ
	[macro name=背景戻しまとめ]
	[begintrans]
	[allchar hide ]
	[msgoff]
	[env resetcolor]
	[bg zoom=100 xpos=%xpos|0 ypos=%ypos|0 ]
	[bg blur=0]
	[endtrans trans=%trans|quickfade transwait=%transwait|0]
	[endmacro]


;■背景zoom関係ブラー無し

	[macro name=背景ズーム２００のみ]
	[msgoff]
	[bg zoom=200 xpos=%xpos|0 ypos=%ypos|0]
	[endmacro]


;■キャラ全部消しテンプレ

	[macro name=キャラ全部消]
	[begintrans]
	[allchar hide]
	[endtrans trans=%trans|quickfade ]
	[endmacro]


;■上パン（空の背景が上にパンする専用）

	[macro name=空上パン]
	[begintrans]
	[msgoff]
	[allimage hide]
	[newlay name=white file=bg_c_white xpos=0 ypos=0 show level=7]
	[空 stime=%stime|昼 zoom=200 ypos=800 filter=0x00000000]
	[endtrans notrans]
	[white opacity=0 time=500]
	[振動 time=%qtime|2000]
	[bg ypos=-800 time=1000 accel=1 nowait]
	[wait time=500]
	[endmacro]

	[macro name=空上パン・音つき]
	[begintrans]
	[msgoff]
	[allimage hide]
	[newlay name=white file=bg_c_white xpos=0 ypos=0 show level=7]
	[空 stime=%stime|昼 zoom=200 ypos=800 filter=0x00000000]
	[endtrans notrans]
	[se_w007]
	[white opacity=0 time=500]
	[振動 time=%qtime|2000]
	[bg ypos=-800 time=1000 accel=1 nowait]
	[wait time=500]
	[endmacro]



;■キャラ背景連動移動

	[macro name=左パン]
	[bg xpos=@+400 time=%time|500 accel=%accel|acdec]
	[char name=%name xpos=%chxpos|200 time=%time|500 accel=%accel|acdec]
	[wact]
	[endmacro]

	[macro name=右パン]
	[bg xpos=@-400 time=%time|500 accel=%accel|acdec]
	[char name=%name xpos=%chxpos|-200 time=%time|500 accel=%accel|acdec]
	[wact]
	[endmacro]


;■汎用カットイン

;出現

	;※ypos=60の位置で停止（メッセージ窓を考慮）
	[macro name=カットイン]
	[msgoff]
	[newlay name=cutin00 width=1280 height=720 color=0x70000000 fade=%time|500 level=%backlevel|6 nosync]
	[newlay name=cutin01 file=%file show xpos=%xpos|0 ypos=810 time=0 level=%level|6 front opacity=%opacity|0 zoom=%zoom|100]
	[cutin01 opacity=%opacity|255 time=%opatime|500]
	[cutin01 ypos=@-780 time=%time|500 accel=1 sync]
	[cutin01 ypos=@+40 time=%time|200 accel=-1 sync]
	[cutin01 ypos=@-10 time=%time|100 accel=1 sync]
	[wact wait=%wait|0]
	[endmacro]

	[macro name=カットイン速]
	[msgoff]
	[newlay name=cutin00 width=1280 height=720 color=0x70000000 fade=%time|300 level=%backlevel|6 nosync]
	[newlay name=cutin01 file=%file show xpos=%xpos|0 ypos=%ypos|810 time=0 level=%level|6 front opacity=%opacity|0 zoom=%zoom|100]
	[cutin01 opacity=%opacity|255 time=%opatime|300]
	[cutin01 ypos=@-780 time=%time|300 accel=1 sync]
	[cutin01 ypos=@+40 time=%time|200 accel=-1 sync]
	[cutin01 ypos=@-10 time=%time|100 accel=1 sync]
	[wact wait=%wait|0]
	[endmacro]


	[macro name=カットイン横]
	[msgoff]
	[newlay name=cutin00 width=1280 height=720 color=0x70000000 fade=%time|500 level=%backlevel|6 nosync]
	[newlay name=cutin01 file=%file show xpos=%xpos|1300 ypos=%ypos|60 time=0 level=%level|6 front opacity=%opacity|0 zoom=%zoom|100]
	[cutin01 opacity=%opacity|255 time=%opatime|500]
	[cutin01 xpos=@-1350 time=%time|500 accel=1 sync]
	[cutin01 xpos=@+60 time=%time|200 accel=-1 sync]
	[cutin01 xpos=@-10 time=%time|100 accel=1 sync]
	[wact wait=%wait|0]
	[endmacro]
	
	[macro name=カットイン横速]
	[msgoff]
	[newlay name=cutin00 width=1280 height=720 color=0x70000000 fade=%time|300 level=%backlevel|6 nosync]
	[newlay name=cutin01 file=%file show xpos=%xpos|1300 ypos=%ypos|60 time=0 level=%level|6 front opacity=%opacity|0 zoom=%zoom|100]
	[cutin01 opacity=%opacity|255 time=%opatime|300]
	[cutin01 xpos=@-1350 time=%time|300 accel=1 sync]
	[cutin01 xpos=@+60 time=%time|200 accel=-1 sync]
	[cutin01 xpos=@-10 time=%time|100 accel=1 sync]
	[wact wait=%wait|0]
	[endmacro]

	[macro name=カットイン差し替え]
	[begintrans]
	[cutin01 hide ]
	[newlay name=cutin01b file=%file show xpos=%xpos|0 ypos=%ypos|60 level=%level|6 front zoom=%zoom|100]
	[endtrans trans=%trans|normal]
	[begintrans]
	[cutin01b hide delete]
	[newlay name=cutin01 file=%file show xpos=%xpos|0 ypos=%ypos|60 level=%level|6 front zoom=%zoom|100]
	[endtrans notrans]

	[endmacro]


;消去

	[macro name=カットイン消]
	[msgoff]
	[cutin01 ypos=@-10 time=%time|200 accel=%accel|acdec sync]
	[cutin00 hide fade=%time|700 nosync]
	[cutin01 time=%time|700 accel=%accel|-1 opacity=0 ]
	[cutin01 ypos=@+810 time=%time|500 accel=%accel|-1 sync]
	[カットイン削除]
	[endmacro]
	
	[macro name=カットイン消速]
	[msgoff]
	[cutin01 ypos=@-10 time=%time|200 accel=%accel|acdec sync]
	[cutin00 hide fade=%time|500 nosync]
	[cutin01 time=%time|300 accel=%accel|-1 opacity=0 ]
	[cutin01 ypos=@+810 time=%time|300 accel=%accel|-1 sync]
	[カットイン削除]
	[endmacro]

	[macro name=カットイン横消]
	[msgoff]
	[cutin01 xpos=@+50 time=%time|200 accel=%accel|acdec sync]
	[cutin00 hide fade=%time|700 nosync]
	[cutin01 time=%time|500 accel=%accel|-1 opacity=0 ]
	[cutin01 xpos=@-1350 time=%time|500 accel=%accel|-1 sync]
	[カットイン削除]
	[endmacro]

	[macro name=カットイン横消速]
	[msgoff]
	[cutin01 xpos=@+50 time=%time|200 accel=%accel|acdec sync]
	[cutin00 hide fade=%time|500 nosync]
	[cutin01 time=%time|300 accel=%accel|-1 opacity=0 ]
	[cutin01 xpos=@-1350 time=%time|300 accel=%accel|-1 sync]
	[カットイン削除]
	[endmacro]


;削除（消去共通で使用）
	[macro name=カットイン削除]
;	[cutin01 hide notrans sync]
	[dellay name=cutin00]
	[dellay name=cutin01]
	[endmacro]


;■斬撃

	[macro name=斬撃１]
	[瞬間白]
	[se837]
	[se826]
	[振動]
	[begintrans]
	[黒]
	[newlay name=sword1 file=sword_curve_1 xpos=0 ypos=0 show]
	[endtrans univ rule=map09b time=200 vague=500 accel=1]
	[begintrans]
	[sword1 hide ]
	[bg stage=%stage stime=%stime blur=%blur|0]
	[endtrans univ rule=map09b time=200 vague=500 accel=-1]
	[dellay name=sword1]
	[endmacro]

	[macro name=斬撃２]
	[瞬間白]
	[se835]
	[se826]
	[振動]
	[begintrans]
	[黒]
	[newlay name=sword2 file=sword_curve_2 xpos=0 ypos=0 show]
	[endtrans univ rule=map09c time=200 vague=500 accel=1]
	[begintrans]
	[sword2 hide ]
	[bg stage=%stage stime=%stime blur=%blur|0 ]
	[endtrans univ rule=map09c time=200 vague=500 accel=-1]
	[dellay name=sword2]
	[endmacro]

	[macro name=斬撃３]
	[瞬間白]
	[se835]
	[se826]
	[振動]
	[begintrans]
	[黒]
	[newlay name=sword3 file=sword_curve_3 xpos=0 ypos=0 show]
	[endtrans univ rule=map09c time=200 vague=500 accel=1]
	[begintrans]
	[sword3 hide ]
	[bg stage=%stage stime=%stime blur=%blur|0 ]
	[endtrans univ rule=map09c time=200 vague=500 accel=-1]
	[dellay name=sword3]
	[endmacro]

	[macro name=斬撃４]
	[瞬間白]
	[se837]
	[se826]
	[振動]
	[begintrans]
	[黒]
	[newlay name=sword4 file=sword_curve_4 xpos=0 ypos=0 show]
	[endtrans univ rule=map09d time=200 vague=500 accel=1]
	[begintrans]
	[sword4 hide ]
	[bg stage=%stage stime=%stime blur=%blur|0 ]
	[endtrans univ rule=map09d time=200 vague=500 accel=-1]
	[dellay name=sword4]
	[endmacro]


	;ｂは背景復帰のないバージョン
	[macro name=斬撃１ｂ]
	[瞬間白]
	[se837]
	[se826]
	[振動]
	[begintrans]
	[黒]
	[newlay name=sword1 file=sword_curve_1 xpos=0 ypos=0 show]
	[endtrans univ rule=map09b time=200 vague=500 accel=1]
	[endmacro]

	[macro name=斬撃２ｂ]
	[瞬間白]
	[se835]
	[se826]
	[振動]
	[begintrans]
	[黒]
	[newlay name=sword2 file=sword_curve_2 xpos=0 ypos=0 show]
	[endtrans univ rule=map09c time=200 vague=500 accel=1]
	[endmacro]

	[macro name=斬撃３ｂ]
	[瞬間白]
	[se835]
	[se826]
	[振動]
	[begintrans]
	[黒]
	[newlay name=sword3 file=sword_curve_3 xpos=0 ypos=0 show]
	[endtrans univ rule=map09c time=200 vague=500 accel=1]
	[endmacro]

	[macro name=斬撃４ｂ]
	[瞬間白]
	[se837]
	[se826]
	[振動]
	[begintrans]
	[黒]
	[newlay name=sword4 file=sword_curve_4 xpos=0 ypos=0 show]
	[endtrans univ rule=map09d time=200 vague=500 accel=1]
	[endmacro]



	[macro name=斬撃直線１]
	[瞬間白]
	[se837]
	[se702]
	[振動]
	[begintrans]
	[黒]
	[newlay name=sword1 file=sword_line_1 xpos=0 ypos=0 show]
	[endtrans univ rule=map09b time=150 vague=500 accel=1]
	[begintrans]
	[sword1 hide ]
	[bg stage=%stage stime=%stime blur=%blur|0 ]
	[endtrans univ rule=map09b time=150 vague=500 accel=-1]
	[dellay name=sword1]
	[endmacro]


	[macro name=斬撃直線２]
	[瞬間白]
	[se835]
	[se702]
	[振動]
	[begintrans]
	[黒]
	[newlay name=sword2 file=sword_line_2 xpos=0 ypos=0 show]
	[endtrans univ rule=map09c time=150 vague=500 accel=1]
	[begintrans]
	[sword2 hide ]
	[bg stage=%stage stime=%stime blur=%blur|0 ]
	[endtrans univ rule=map09c time=150 vague=500 accel=-1]
	[dellay name=sword2]
	[endmacro]

	[macro name=斬撃直線３]
	[瞬間白]
	[se835]
	[se703]
	[振動]
	[begintrans]
	[黒]
	[newlay name=sword3 file=sword_line_3 xpos=0 ypos=0 show]
	[endtrans univ rule=map09c time=150 vague=500 accel=1]
	[begintrans]
	[sword3 hide ]
	[bg stage=%stage stime=%stime blur=%blur|0 ]
	[endtrans univ rule=map09c time=150 vague=500 accel=-1]
	[dellay name=sword3]
	[endmacro]

	[macro name=斬撃直線４]
	[瞬間白]
	[se837]
	[se703]
	[振動]
	[begintrans]
	[黒]
	[newlay name=sword4 file=sword_line_4 xpos=0 ypos=0 show]
	[endtrans univ rule=map09d time=150 vague=500 accel=1]
	[begintrans]
	[sword4 hide ]
	[bg stage=%stage stime=%stime blur=%blur|0 ]
	[endtrans univ rule=map09d time=150 vague=500 accel=-1]
	[dellay name=sword4]
	[endmacro]


	;ｂは背景復帰のないバージョン
	[macro name=斬撃直線１ｂ]
	[瞬間白]
	[se837]
	[se702]
	[振動]
	[begintrans]
	[黒]
	[newlay name=sword1 file=sword_line_1 xpos=0 ypos=0 show]
	[endtrans univ rule=map09b time=150 vague=500 accel=1]
	[endmacro]

	[macro name=斬撃直線２ｂ]
	[瞬間白]
	[se835]
	[se702]
	[振動]
	[begintrans]
	[黒]
	[newlay name=sword2 file=sword_line_2 xpos=0 ypos=0 show]
	[endtrans univ rule=map09c time=150 vague=500 accel=1]
	[endmacro]

	[macro name=斬撃直線３ｂ]
	[瞬間白]
	[se835]
	[se703]
	[振動]
	[begintrans]
	[黒]
	[newlay name=sword3 file=sword_line_3 xpos=0 ypos=0 show]
	[endtrans univ rule=map09c time=150 vague=500 accel=1]
	[endmacro]

	[macro name=斬撃直線４ｂ]
	[瞬間白]
	[se837]
	[se703]
	[振動]
	[begintrans]
	[黒]
	[newlay name=sword4 file=sword_line_4 xpos=0 ypos=0 show]
	[endtrans univ rule=map09d time=150 vague=500 accel=1]
	[endmacro]



;■心臓鼓動

	[macro name=心臓鼓動]
	[begintrans]
	[msgoff]
	[endtrans notrans]
	[begintrans]
	[msgoff]
	[newlay name=red file=bg_c_red level=7 xpos=0 ypos=0 show ]
	[endtrans univ rule=map11 vague=500 time=100]
	[振動]
	;ＳＥ　心臓が高鳴る音、どくん
	[se073 ]
	[red hide univ rule=map10 vague=500 time=500]
	[wact]
	[dellay name=red]
	[endmacro]


;■走りアクション
	[macro name=走りアクション]
	[begintrans]
	[bg stage=%stage|空]
	[集中線]
	[bg びょん大速 ]
	[at1 びょん速－ ]
	[at2 びょん小 ]
	[endtrans univ rule=map504a time=300 transwait=500 vague=300 msgoff]
	[endmacro]


;■スクロール背景

	[macro name=スクロール背景赤左流]
	
	[newlay name=base tile=loop_scroll_red_1 action=横スライド trans=notrans opacity=0 nowait level=0]
	[base opacity=255 time=%time|300 accel=1]
	[endmacro]

	[macro name=スクロール背景赤右流]
	
	[newlay name=base tile=loop_scroll_red_1 action=横スライド逆 trans=notrans opacity=0 nowait level=0]
	[base opacity=255 time=%time|300 accel=1]
	[endmacro]

	[macro name=スクロール背景青左流]
	
	[newlay name=base tile=loop_scroll_blue_1 action=横スライド trans=notrans opacity=0 nowait level=0]
	[base opacity=255 time=%time|300 accel=1]
	[endmacro]

	[macro name=スクロール背景青右流]
	
	[newlay name=base tile=loop_scroll_blue_1 action=横スライド逆 trans=notrans opacity=0 nowait level=0]
	[base opacity=255 time=%time|300 accel=1]
	[endmacro]

	[macro name=スクロール背景赤左流速]
	
	[newlay name=base tile=loop_scroll_red_1 action=横スライド速 trans=notrans opacity=0 nowait level=0]
	[base opacity=255 time=%time|300 accel=1]
	[endmacro]

	[macro name=スクロール背景赤右流速]
	
	[newlay name=base tile=loop_scroll_red_1 action=横スライド逆速 trans=notrans opacity=0 nowait level=0]
	[base opacity=255 time=%time|300 accel=1]
	[endmacro]

	[macro name=スクロール背景青左流速]
	
	[newlay name=base tile=loop_scroll_blue_1 action=横スライド速 trans=notrans opacity=0 nowait level=0]
	[base opacity=255 time=%time|300 accel=1]
	[endmacro]

	[macro name=スクロール背景青右流速]
	
	[newlay name=base tile=loop_scroll_blue_1 action=横スライド逆速 trans=notrans opacity=0 nowait level=0]
	[base opacity=255 time=%time|300 accel=1]
	[endmacro]


	[macro name=スクロール背景透明左流]
	
	[newlay name=base tile=loop_scroll_nobase_6 action=横スライド trans=notrans opacity=0 nowait level=0]
	[base opacity=255 time=%time|300 accel=1]
	[endmacro]

	[macro name=スクロール背景透明右流]
	
	[newlay name=base tile=loop_scroll_nobase_6 action=横スライド逆 trans=notrans opacity=0 nowait level=0]
	[base opacity=255 time=%time|300 accel=1]
	[endmacro]

	[macro name=スクロール背景青左流]
	
	[newlay name=base tile=loop_scroll_blue_1 action=横スライド trans=notrans opacity=0 nowait level=0]
	[base opacity=255 time=%time|300 accel=1]
	[endmacro]

	[macro name=スクロール背景青右流]
	
	[newlay name=base tile=loop_scroll_blue_1 action=横スライド逆 trans=notrans opacity=0 nowait level=0]
	[base opacity=255 time=%time|300 accel=1]
	[endmacro]

	[macro name=スクロール背景透明左流速]
	
	[newlay name=base tile=loop_scroll_nobase_6 action=横スライド速 trans=notrans opacity=0 nowait level=0]
	[base opacity=255 time=%time|300 accel=1]
	[endmacro]

	[macro name=スクロール背景透明右流速]
	
	[newlay name=base tile=loop_scroll_nobase_6 action=横スライド逆速 trans=notrans opacity=0 nowait level=0]
	[base opacity=255 time=%time|300 accel=1]
	[endmacro]


	[macro name=スクロール背景消]
	[base hide trans=%trans|quickfade]
	[endmacro]


;■絶頂

	[macro name=絶頂]
	[msgoff]
	[newlay name=white file=bg_c_white xpos=0 ypos=0 show level=5 univ rule=map11 vague=500 time=1000 accel=accos]
	[振動小 time=%qtime|3000]
	[begintrans]
	[white hide]
	[ev file=%file zoom=%zoom|100 xpos=%xpos|0 ypos=%ypos|0]
	[endtrans univ rule=map11 vague=500 time=%time|4000 accel=acdec]
	[dellay name=white]
	[endmacro]



;■マスクカットイン

	[macro name=マスクカットイン２００]
	[begintrans]
	[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=145 show level=5]
	[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=-60 show level=5]
	[newlay name=mask_base file=%file|bg_c_white zoom=%zoom|100 clip=mask_horizontal_line_200 opacity=%opacity|96 level=%level|0 xpos=%xpos|0 ypos=%ypos|0 clipx=0 clipy=0 xpos=%xpos|0 ypos=%ypos|0 show blur=%blur|0 ]
	[endtrans univ rule=map502b time=200 vague=%vague|400]
	[endmacro]

	[macro name=マスクカットイン３００]
	[begintrans]
	[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=185 show level=5]
	[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=-120 show level=5]
	[newlay name=mask_base file=%file|bg_c_white zoom=%zoom|100 clip=mask_horizontal_line_300 opacity=%opacity|96 level=%level|0 xpos=%xpos|0 ypos=%ypos|0 clipx=0 clipy=0 xpos=%xpos|0 ypos=%ypos|0 show blur=%blur|0 ]
	[endtrans univ rule=map502b time=200 vague=%vague|400]
	[endmacro]

	[macro name=マスクカットイン４００]
	[begintrans]
	[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=240 show level=5]
	[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=-165 show level=5]
	[newlay name=mask_base file=%file|bg_c_white zoom=%zoom|100 clip=mask_horizontal_line_400 opacity=%opacity|96 level=%level|0 xpos=%xpos|0 ypos=%ypos|0 clipx=0 clipy=0 xpos=%xpos|0 ypos=%ypos|0 show blur=%blur|0 ]
	[endtrans univ rule=map502b time=200 vague=%vague|400]
	[endmacro]


	;白帯にわずかに集中線走る
	[macro name=マスクカットイン２００右流]
	[begintrans]
	[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=145 show level=5]
	[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=-60 show level=5]
	[newlay name=mask_base tile=loop_scroll_nobase_6 action=%action|横スライド逆速 clip=mask_horizontal_line_200 opacity=192 level=0 front xpos=0 ypos=0 clipx=0 clipy=0 show ]
	[newlay name=mask_base2 file=%file|bg_c_white blurx=%blurx|0 blury=%blury|0 show opacity=%opacity|96 clip=mask_horizontal_line_200 level=0 back]
	[endtrans univ rule=map502b time=200 vague=%vague|400]
	[endmacro]

	[macro name=マスクカットイン３００右流]
	[begintrans]
	[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=185 show level=5]
	[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=-120 show level=5]
	[newlay name=mask_base tile=loop_scroll_nobase_6 action=%action|横スライド逆速 clip=mask_horizontal_line_300 opacity=192 level=0 front xpos=0 ypos=0 clipx=0 clipy=0 show ]
	[newlay name=mask_base2 file=%file|bg_c_white blurx=%blurx|0 blury=%blury|0 show opacity=%opacity|96 clip=mask_horizontal_line_300 level=0 back]
	[endtrans univ rule=map502b time=200 vague=%vague|400]
	[endmacro]

	[macro name=マスクカットイン４００右流]
	[begintrans]
	[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=240 show level=5]
	[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=-165 show level=5]
	[newlay name=mask_base tile=loop_scroll_nobase_6 action=%action|横スライド逆速 clip=mask_horizontal_line_400 opacity=192 level=0 front xpos=0 ypos=0 clipx=0 clipy=0 show ]
	[newlay name=mask_base2 file=%file|bg_c_white blurx=%blurx|0 blury=%blury|0 show opacity=%opacity|96 clip=mask_horizontal_line_400 level=0 back]
	[endtrans univ rule=map502b time=200 vague=%vague|400]
	[endmacro]

	[macro name=マスクカットイン２００左流]
	[begintrans]
	[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=145 show level=5]
	[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=-60 show level=5]
	[newlay name=mask_base tile=loop_scroll_nobase_6 action=%action|横スライド速 clip=mask_horizontal_line_200 opacity=192 level=0 front xpos=0 ypos=0 clipx=0 clipy=0 show ]
	[newlay name=mask_base2 file=%file|bg_c_white blurx=%blurx|0 blury=%blury|0 show opacity=%opacity|96 clip=mask_horizontal_line_200 level=0 back]
	[endtrans univ rule=map502b time=200 vague=%vague|400]
	[endmacro]

	[macro name=マスクカットイン３００左流]
	[begintrans]
	[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=185 show level=5]
	[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=-120 show level=5]
	[newlay name=mask_base tile=loop_scroll_nobase_6 action=%action|横スライド速 clip=mask_horizontal_line_300 opacity=192 level=0 front xpos=0 ypos=0 clipx=0 clipy=0 show ]
	[newlay name=mask_base2 file=%file|bg_c_white blurx=%blurx|0 blury=%blury|0 show opacity=%opacity|96 clip=mask_horizontal_line_300 level=0 back]
	[endtrans univ rule=map502b time=200 vague=%vague|400]
	[endmacro]

	[macro name=マスクカットイン４００左流]
	[begintrans]
	[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=240 show level=5]
	[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=-165 show level=5]
	[newlay name=mask_base tile=loop_scroll_nobase_6 action=%action|横スライド速 clip=mask_horizontal_line_400 opacity=192 level=0 front xpos=0 ypos=0 clipx=0 clipy=0 show ]
	[newlay name=mask_base2 file=%file|bg_c_white blurx=%blurx|0 blury=%blury|0 show opacity=%opacity|96 clip=mask_horizontal_line_400 level=0 back]
	[endtrans univ rule=map502b time=200 vague=%vague|400]
	[endmacro]


	;赤のスクロール背景を使用
	[macro name=マスクカットイン２００右流赤]
	[begintrans]
	[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=145 show level=5]
	[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=-60 show level=5]
;	[newlay name=mask_base tile=loop_scroll_nobase_6 action=%action|横スライド逆速 clip=mask_horizontal_line_200 opacity=%opacity|192 level=0 xpos=0 ypos=0 clipx=0 clipy=0 show ]
	[newlay name=mask_base2 tile=loop_scroll_red_1 show action=%action|横スライド逆速 clip=mask_horizontal_line_200 level=0]
	[endtrans univ rule=map502b time=200 vague=%vague|400]
	[endmacro]

	[macro name=マスクカットイン３００右流赤]
	[begintrans]
	[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=185 show level=5]
	[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=-120 show level=5]
;	[newlay name=mask_base tile=loop_scroll_nobase_6 action=%action|横スライド逆速 clip=mask_horizontal_line_300 opacity=%opacity|192 level=0 xpos=0 ypos=0 clipx=0 clipy=0 show ]
	[newlay name=mask_base2 tile=loop_scroll_red_1 show action=%action|横スライド逆速 clip=mask_horizontal_line_300 level=0]
	[endtrans univ rule=map502b time=200 vague=%vague|400]
	[endmacro]

	[macro name=マスクカットイン４００右流赤]
	[begintrans]
	[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=240 show level=5]
	[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=-165 show level=5]
;	[newlay name=mask_base tile=loop_scroll_nobase_6 action=%action|横スライド逆速 clip=mask_horizontal_line_400 opacity=%opacity|192 level=0 xpos=0 ypos=0 clipx=0 clipy=0 show ]
	[newlay name=mask_base2 tile=loop_scroll_red_1 show action=%action|横スライド逆速 clip=mask_horizontal_line_400 level=0]
	[endtrans univ rule=map502b time=200 vague=%vague|400]
	[endmacro]

	[macro name=マスクカットイン２００左流赤]
	[begintrans]
	[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=145 show level=5]
	[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=-60 show level=5]
;	[newlay name=mask_base tile=loop_scroll_nobase_6 action=%action|横スライド速 clip=mask_horizontal_line_200 opacity=%opacity|192 level=0 xpos=0 ypos=0 clipx=0 clipy=0 show ]
	[newlay name=mask_base2 tile=loop_scroll_red_1 show action=%action|横スライド速 clip=mask_horizontal_line_200 level=0]
	[endtrans univ rule=map502b time=200 vague=%vague|400]
	[endmacro]

	[macro name=マスクカットイン３００左流赤]
	[begintrans]
	[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=185 show level=5]
	[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=-120 show level=5]
;	[newlay name=mask_base tile=loop_scroll_nobase_6 action=%action|横スライド速 clip=mask_horizontal_line_300 opacity=%opacity|192 level=0 xpos=0 ypos=0 clipx=0 clipy=0 show ]
	[newlay name=mask_base2 tile=loop_scroll_red_1 show action=%action|横スライド速 clip=mask_horizontal_line_300 level=0]
	[endtrans univ rule=map502b time=200 vague=%vague|400]
	[endmacro]

	[macro name=マスクカットイン４００左流赤]
	[begintrans]
	[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=240 show level=5]
	[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=-165 show level=5]
;	[newlay name=mask_base tile=loop_scroll_nobase_6 action=%action|横スライド速 clip=mask_horizontal_line_400 opacity=%opacity|192 level=0 xpos=0 ypos=0 clipx=0 clipy=0 show ]
	[newlay name=mask_base2 tile=loop_scroll_red_1 show action=%action|横スライド速 clip=mask_horizontal_line_400 level=0]
	[endtrans univ rule=map502b time=200 vague=%vague|400]
	[endmacro]


	;青のスクロール背景を使用
	[macro name=マスクカットイン２００右流青]
	[begintrans]
	[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=145 show level=5]
	[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=-60 show level=5]
;	[newlay name=mask_base tile=loop_scroll_nobase_6 action=%action|横スライド逆速 clip=mask_horizontal_line_200 opacity=%opacity|192 level=0 xpos=0 ypos=0 clipx=0 clipy=0 show ]
	[newlay name=mask_base2 tile=loop_scroll_blue_1 show action=%action|横スライド逆速 clip=mask_horizontal_line_200 level=0]
	[endtrans univ rule=map502b time=200 vague=%vague|400]
	[endmacro]

	[macro name=マスクカットイン３００右流青]
	[begintrans]
	[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=185 show level=5]
	[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=-120 show level=5]
;	[newlay name=mask_base tile=loop_scroll_nobase_6 action=%action|横スライド逆速 clip=mask_horizontal_line_300 opacity=%opacity|192 level=0 xpos=0 ypos=0 clipx=0 clipy=0 show ]
	[newlay name=mask_base2 tile=loop_scroll_blue_1 show action=%action|横スライド逆速 clip=mask_horizontal_line_300 level=0]
	[endtrans univ rule=map502b time=200 vague=%vague|400]
	[endmacro]

	[macro name=マスクカットイン４００右流青]
	[begintrans]
	[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=240 show level=5]
	[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=-165 show level=5]
;	[newlay name=mask_base tile=loop_scroll_nobase_6 action=%action|横スライド逆速 clip=mask_horizontal_line_400 opacity=%opacity|192 level=0 xpos=0 ypos=0 clipx=0 clipy=0 show ]
	[newlay name=mask_base2 tile=loop_scroll_blue_1 show action=%action|横スライド逆速 clip=mask_horizontal_line_400 level=0]
	[endtrans univ rule=map502b time=200 vague=%vague|400]
	[endmacro]

	[macro name=マスクカットイン２００左流青]
	[begintrans]
	[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=145 show level=5]
	[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=-60 show level=5]
;	[newlay name=mask_base tile=loop_scroll_nobase_6 action=%action|横スライド速 clip=mask_horizontal_line_200 opacity=%opacity|192 level=0 xpos=0 ypos=0 clipx=0 clipy=0 show ]
	[newlay name=mask_base2 tile=loop_scroll_blue_1 show action=%action|横スライド速 clip=mask_horizontal_line_200 level=0]
	[endtrans univ rule=map502b time=200 vague=%vague|400]
	[endmacro]

	[macro name=マスクカットイン３００左流青]
	[begintrans]
	[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=185 show level=5]
	[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=-120 show level=5]
;	[newlay name=mask_base tile=loop_scroll_nobase_6 action=%action|横スライド速 clip=mask_horizontal_line_300 opacity=%opacity|192 level=0 xpos=0 ypos=0 clipx=0 clipy=0 show ]
	[newlay name=mask_base2 tile=loop_scroll_blue_1 show action=%action|横スライド速 clip=mask_horizontal_line_300 level=0]
	[endtrans univ rule=map502b time=200 vague=%vague|400]
	[endmacro]

	[macro name=マスクカットイン４００左流青]
	[begintrans]
	[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=240 show level=5]
	[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=-165 show level=5]
;	[newlay name=mask_base tile=loop_scroll_nobase_6 action=%action|横スライド速 clip=mask_horizontal_line_400 opacity=%opacity|192 level=0 xpos=0 ypos=0 clipx=0 clipy=0 show ]
	[newlay name=mask_base2 tile=loop_scroll_blue_1 show action=%action|横スライド速 clip=mask_horizontal_line_400 level=0]
	[endtrans univ rule=map502b time=200 vague=%vague|400]
	[endmacro]


	;ベタ置き系
	[macro name=マスクカットイン２００ベタ置き]
	[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=145 show level=5]
	[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=-60 show level=5]
	[newlay name=mask_base file=%file|bg_c_white zoom=%zoom|100 clip=mask_horizontal_line_200 opacity=%opacity|96 level=%level|0 xpos=%xpos|0 ypos=%ypos|0 clipx=0 clipy=0 show blur=%blur|0 ]
	[endmacro]

	[macro name=マスクカットイン３００ベタ置き]
	[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=185 show level=5]
	[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=-120 show level=5]
	[newlay name=mask_base file=%file|bg_c_white zoom=%zoom|100 clip=mask_horizontal_line_300 opacity=%opacity|96 level=%level|0 xpos=%xpos|0 ypos=%ypos|0 clipx=0 clipy=0 show blur=%blur|0 ]
	[endmacro]

	[macro name=マスクカットイン４００ベタ置き]
	[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=240 show level=5]
	[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=-165 show level=5]
	[newlay name=mask_base file=%file|bg_c_white zoom=%zoom|100 clip=mask_horizontal_line_400 opacity=%opacity|96 level=%level|0 xpos=%xpos|0 ypos=%ypos|0 clipx=0 clipy=0 show blur=%blur|0]
	[endmacro]




		;実験中のマスクカットインパターン
			[macro name=マスクカットイン２００ｂ]
			[begintrans]
			[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[endtrans univ rule=map502b time=100 vague=%vague|0]
			[flame1 ypos=145 nowait time=100]
			[flame2 ypos=-60 nowait time=100]
			[begintrans]
			[newlay name=mask_base file=%file|bg_c_white zoom=%zoom|100 clip=mask_horizontal_line_200 opacity=%opacity|96 level=%level|0 xpos=%xpos|0 ypos=%ypos|0 clipx=0 clipy=0 show ]
			[endtrans univ rule=map501d time=400 vague=%vague|0]
			[endmacro]

			[macro name=マスクカットイン３００ｂ]
			[begintrans]
			[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[endtrans univ rule=map502b time=100 vague=%vague|0]
			[flame1 ypos=185 nowait time=100]
			[flame2 ypos=-120 nowait time=100]
			[begintrans]
			[newlay name=mask_base file=%file|bg_c_white zoom=%zoom|100 clip=mask_horizontal_line_300 opacity=%opacity|96 level=%level|0 xpos=%xpos|0 ypos=%ypos|0 clipx=0 clipy=0 show ]
			[endtrans univ rule=map501d time=400 vague=%vague|0]
			[endmacro]

			[macro name=マスクカットイン４００ｂ]
			[begintrans]
			[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[endtrans univ rule=map502b time=100 vague=%vague|0]
			[flame1 ypos=240 nowait time=100]
			[flame2 ypos=-165 nowait time=100]
			[begintrans]
			[newlay name=mask_base file=%file|bg_c_white zoom=%zoom|100 clip=mask_horizontal_line_400 opacity=%opacity|96 level=%level|0 xpos=%xpos|0 ypos=%ypos|0 clipx=0 clipy=0 show ]
			[endtrans univ rule=map501d time=400 vague=%vague|0]
			[endmacro]


			;白帯にわずかに集中線走る
			[macro name=マスクカットイン２００ｂ右流]
			[begintrans]
			[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[endtrans univ rule=map502b time=100 vague=%vague|0]
			[flame1 ypos=145 nowait time=100]
			[flame2 ypos=-60 nowait time=100]
			[begintrans]
			[newlay name=mask_base tile=loop_scroll_nobase_6 action=横スライド逆速 clip=mask_horizontal_line_200 opacity=192 level=0 front xpos=0 ypos=0 clipx=0 clipy=0 show ]
			[newlay name=mask_base2 file=%file|bg_c_white blurx=%blurx|0 blury=%blury|0 show opacity=%opacity|96 clip=mask_horizontal_line_200 level=0 back]
			[endtrans univ rule=map501d time=400 vague=%vague|0]
			[endmacro]

			[macro name=マスクカットイン３００ｂ右流]
			[begintrans]
			[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[endtrans univ rule=map502b time=100 vague=%vague|0]
			[flame1 ypos=185 nowait time=100]
			[flame2 ypos=-120 nowait time=100]
			[begintrans]
			[newlay name=mask_base tile=loop_scroll_nobase_6 action=横スライド逆速 clip=mask_horizontal_line_300 opacity=192 level=0 front xpos=0 ypos=0 clipx=0 clipy=0 show ]
			[newlay name=mask_base2 file=%file|bg_c_white blurx=%blurx|0 blury=%blury|0 show opacity=%opacity|96 clip=mask_horizontal_line_300 level=0 back]
			[endtrans univ rule=map501d time=400 vague=%vague|0]
			[endmacro]

			[macro name=マスクカットイン４００ｂ右流]
			[begintrans]
			[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[endtrans univ rule=map502b time=100 vague=%vague|0]
			[flame1 ypos=240 nowait time=100]
			[flame2 ypos=-165 nowait time=100]
			[begintrans]
			[newlay name=mask_base tile=loop_scroll_nobase_6 action=横スライド逆速 clip=mask_horizontal_line_400 opacity=192 level=0 front xpos=0 ypos=0 clipx=0 clipy=0 show ]
			[newlay name=mask_base2 file=%file|bg_c_white blurx=%blurx|0 blury=%blury|0 show opacity=%opacity|96 clip=mask_horizontal_line_400 level=0 back]
			[endtrans univ rule=map501d time=400 vague=%vague|0]
			[endmacro]

			[macro name=マスクカットイン２００ｂ左流]
			[begintrans]
			[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[endtrans univ rule=map502b time=100 vague=%vague|0]
			[flame1 ypos=145 nowait time=100]
			[flame2 ypos=-60 nowait time=100]
			[begintrans]
			[newlay name=mask_base tile=loop_scroll_nobase_6 action=横スライド速 clip=mask_horizontal_line_200 opacity=192 level=0 front xpos=0 ypos=0 clipx=0 clipy=0 show ]
			[newlay name=mask_base2 file=%file|bg_c_white blurx=%blurx|0 blury=%blury|0 show opacity=%opacity|96 clip=mask_horizontal_line_200 level=0 back]
			[endtrans univ rule=map501d time=400 vague=%vague|0]
			[endmacro]

			[macro name=マスクカットイン３００ｂ左流]
			[begintrans]
			[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[endtrans univ rule=map502b time=100 vague=%vague|0]
			[flame1 ypos=185 nowait time=100]
			[flame2 ypos=-120 nowait time=100]
			[begintrans]
			[newlay name=mask_base tile=loop_scroll_nobase_6 action=横スライド速 clip=mask_horizontal_line_300 opacity=192 level=0 front xpos=0 ypos=0 clipx=0 clipy=0 show ]
			[newlay name=mask_base2 file=%file|bg_c_white blurx=%blurx|0 blury=%blury|0 show opacity=%opacity|96 clip=mask_horizontal_line_300 level=0 back]
			[endtrans univ rule=map501d time=400 vague=%vague|0]
			[endmacro]

			[macro name=マスクカットイン４００ｂ左流]
			[begintrans]
			[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[endtrans univ rule=map502b time=100 vague=%vague|0]
			[flame1 ypos=240 nowait time=100]
			[flame2 ypos=-165 nowait time=100]
			[begintrans]
			[newlay name=mask_base tile=loop_scroll_nobase_6 action=横スライド速 clip=mask_horizontal_line_400 opacity=192 level=0 front xpos=0 ypos=0 clipx=0 clipy=0 show ]
			[newlay name=mask_base2 file=%file|bg_c_white blurx=%blurx|0 blury=%blury|0 show opacity=%opacity|96 clip=mask_horizontal_line_400 level=0 back]
			[endtrans univ rule=map501d time=400 vague=%vague|0]
			[endmacro]


			;赤のスクロール背景を使用
			[macro name=マスクカットイン２００ｂ右流赤]
			[begintrans]
			[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[endtrans univ rule=map502b time=100 vague=%vague|0]
			[flame1 ypos=145 nowait time=100]
			[flame2 ypos=-60 nowait time=100]
			[begintrans]
		;	[newlay name=mask_base tile=loop_scroll_nobase_6 action=横スライド逆速 clip=mask_horizontal_line_200 opacity=%opacity|192 level=0 xpos=0 ypos=0 clipx=0 clipy=0 show ]
			[newlay name=mask_base2 tile=loop_scroll_red_1 show action=横スライド逆速 clip=mask_horizontal_line_200 level=0]
			[endtrans univ rule=map501d time=400 vague=%vague|0]
			[endmacro]

			[macro name=マスクカットイン３００ｂ右流赤]
			[begintrans]
			[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[endtrans univ rule=map502b time=100 vague=%vague|0]
			[flame1 ypos=185 nowait time=100]
			[flame2 ypos=-120 nowait time=100]
			[begintrans]
		;	[newlay name=mask_base tile=loop_scroll_nobase_6 action=横スライド逆速 clip=mask_horizontal_line_300 opacity=%opacity|192 level=0 xpos=0 ypos=0 clipx=0 clipy=0 show ]
			[newlay name=mask_base2 tile=loop_scroll_red_1 show action=横スライド逆速 clip=mask_horizontal_line_300 level=0]
			[endtrans univ rule=map501d time=400 vague=%vague|0]
			[endmacro]

			[macro name=マスクカットイン４００ｂ右流赤]
			[begintrans]
			[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[endtrans univ rule=map502b time=100 vague=%vague|0]
			[flame1 ypos=240 nowait time=100]
			[flame2 ypos=-165 nowait time=100]
			[begintrans]
		;	[newlay name=mask_base tile=loop_scroll_nobase_6 action=横スライド逆速 clip=mask_horizontal_line_400 opacity=%opacity|192 level=0 xpos=0 ypos=0 clipx=0 clipy=0 show ]
			[newlay name=mask_base2 tile=loop_scroll_red_1 show action=横スライド逆速 clip=mask_horizontal_line_400 level=0]
			[endtrans univ rule=map501d time=400 vague=%vague|0]
			[endmacro]

			[macro name=マスクカットイン２００ｂ左流赤]
			[begintrans]
			[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[endtrans univ rule=map502b time=100 vague=%vague|0]
			[flame1 ypos=145 nowait time=100]
			[flame2 ypos=-60 nowait time=100]
			[begintrans]
		;	[newlay name=mask_base tile=loop_scroll_nobase_6 action=横スライド速 clip=mask_horizontal_line_200 opacity=%opacity|192 level=0 xpos=0 ypos=0 clipx=0 clipy=0 show ]
			[newlay name=mask_base2 tile=loop_scroll_red_1 show action=横スライド速 clip=mask_horizontal_line_200 level=0]
			[endtrans univ rule=map501d time=400 vague=%vague|0]
			[endmacro]

			[macro name=マスクカットイン３００ｂ左流赤]
			[begintrans]
			[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[endtrans univ rule=map502b time=100 vague=%vague|0]
			[flame1 ypos=185 nowait time=100]
			[flame2 ypos=-120 nowait time=100]
			[begintrans]
		;	[newlay name=mask_base tile=loop_scroll_nobase_6 action=横スライド速 clip=mask_horizontal_line_300 opacity=%opacity|192 level=0 xpos=0 ypos=0 clipx=0 clipy=0 show ]
			[newlay name=mask_base2 tile=loop_scroll_red_1 show action=横スライド速 clip=mask_horizontal_line_300 level=0]
			[endtrans univ rule=map501d time=400 vague=%vague|0]
			[endmacro]

			[macro name=マスクカットイン４００ｂ左流赤]
			[begintrans]
			[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[endtrans univ rule=map502b time=100 vague=%vague|0]
			[flame1 ypos=240 nowait time=100]
			[flame2 ypos=-165 nowait time=100]
			[begintrans]
			[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=240 show level=5]
			[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=-160 show level=5]
		;	[newlay name=mask_base tile=loop_scroll_nobase_6 action=横スライド速 clip=mask_horizontal_line_400 opacity=%opacity|192 level=0 xpos=0 ypos=0 clipx=0 clipy=0 show ]
			[newlay name=mask_base2 tile=loop_scroll_red_1 show action=横スライド速 clip=mask_horizontal_line_400 level=0]
			[endtrans univ rule=map501d time=400 vague=%vague|0]
			[endmacro]


			;青のスクロール背景を使用
			[macro name=マスクカットイン２００ｂ右流青]
			[begintrans]
			[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[endtrans univ rule=map502b time=100 vague=%vague|0]
			[flame1 ypos=145 nowait time=100]
			[flame2 ypos=-60 nowait time=100]
			[begintrans]
		;	[newlay name=mask_base tile=loop_scroll_nobase_6 action=横スライド逆速 clip=mask_horizontal_line_200 opacity=%opacity|192 level=0 xpos=0 ypos=0 clipx=0 clipy=0 show ]
			[newlay name=mask_base2 tile=loop_scroll_blue_1 show action=横スライド逆速 clip=mask_horizontal_line_200 level=0]
			[endtrans univ rule=map501d time=400 vague=%vague|0]
			[endmacro]

			[macro name=マスクカットイン３００ｂ右流青]
			[begintrans]
			[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[endtrans univ rule=map502b time=100 vague=%vague|0]
			[flame1 ypos=185 nowait time=100]
			[flame2 ypos=-120 nowait time=100]
			[begintrans]
		;	[newlay name=mask_base tile=loop_scroll_nobase_6 action=横スライド逆速 clip=mask_horizontal_line_300 opacity=%opacity|192 level=0 xpos=0 ypos=0 clipx=0 clipy=0 show ]
			[newlay name=mask_base2 tile=loop_scroll_blue_1 show action=横スライド逆速 clip=mask_horizontal_line_300 level=0]
			[endtrans univ rule=map501d time=400 vague=%vague|0]
			[endmacro]

			[macro name=マスクカットイン４００ｂ右流青]
			[begintrans]
			[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[endtrans univ rule=map502b time=100 vague=%vague|0]
			[flame1 ypos=240 nowait time=100]
			[flame2 ypos=-165 nowait time=100]
			[begintrans]
		;	[newlay name=mask_base tile=loop_scroll_nobase_6 action=横スライド逆速 clip=mask_horizontal_line_400 opacity=%opacity|192 level=0 xpos=0 ypos=0 clipx=0 clipy=0 show ]
			[newlay name=mask_base2 tile=loop_scroll_blue_1 show action=横スライド逆速 clip=mask_horizontal_line_400 level=0]
			[endtrans univ rule=map501d time=400 vague=%vague|0]
			[endmacro]

			[macro name=マスクカットイン２００ｂ左流青]
			[begintrans]
			[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[endtrans univ rule=map502b time=100 vague=%vague|0]
			[flame1 ypos=145 nowait time=100]
			[flame2 ypos=-60 nowait time=100]
			[begintrans]
		;	[newlay name=mask_base tile=loop_scroll_nobase_6 action=横スライド速 clip=mask_horizontal_line_200 opacity=%opacity|192 level=0 xpos=0 ypos=0 clipx=0 clipy=0 show ]
			[newlay name=mask_base2 tile=loop_scroll_blue_1 show action=横スライド速 clip=mask_horizontal_line_200 level=0]
			[endtrans univ rule=map501d time=400 vague=%vague|0]
			[endmacro]

			[macro name=マスクカットイン３００ｂ左流青]
			[begintrans]
			[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[endtrans univ rule=map502b time=100 vague=%vague|0]
			[flame1 ypos=185 nowait time=100]
			[flame2 ypos=-120 nowait time=100]
			[begintrans]
		;	[newlay name=mask_base tile=loop_scroll_nobase_6 action=横スライド速 clip=mask_horizontal_line_300 opacity=%opacity|192 level=0 xpos=0 ypos=0 clipx=0 clipy=0 show ]
			[newlay name=mask_base2 tile=loop_scroll_blue_1 show action=横スライド速 clip=mask_horizontal_line_300 level=0]
			[endtrans univ rule=map501d time=400 vague=%vague|0]
			[endmacro]

			[macro name=マスクカットイン４００ｂ左流青]
			[begintrans]
			[newlay name=flame1 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[newlay name=flame2 file=flame_horizontal1 xpos=0 ypos=43 show level=5]
			[endtrans univ rule=map502b time=100 vague=%vague|0]
			[flame1 ypos=240 nowait time=100]
			[flame2 ypos=-165 nowait time=100]
			[begintrans]
		;	[newlay name=mask_base tile=loop_scroll_nobase_6 action=横スライド速 clip=mask_horizontal_line_400 opacity=%opacity|192 level=0 xpos=0 ypos=0 clipx=0 clipy=0 show ]
			[newlay name=mask_base2 tile=loop_scroll_blue_1 show action=横スライド速 clip=mask_horizontal_line_400 level=0]
			[endtrans univ rule=map501d time=400 vague=%vague|0]
			[endmacro]



	[macro name=マスクカットイン消]
	[begintrans]
	[mask_base hide]
	[mask_base2 hide]
	[allchar hide clip=]
	[flame1 hide]
	[flame2 hide]
	[endtrans univ rule=map502 time=%time|200 vague=%vague|400]
	[dellay name=mask_base]
	[dellay name=mask_base2]
	[dellay name=flame1]
	[dellay name=flame2]
	[endmacro]


;マスククリップ

	;こちらはベタ表示。begintransなどの中に設置して使う用
	[macro name=マスククリップ左ベタ置き]
	[newlay name=mask_left file=%file|bg_01_a clip=mask_slash01_left opacity=255 level=%level|1 xpos=%xpos|0 ypos=%ypos|0 clipx=-4 clipy=0 show zoom=%zoom|150 ]
	[newlay name=flame_left file=flame_slash1 level=%level|3 xpos=0 ypos=0 show]
	[endmacro]

	[macro name=マスククリップ右ベタ置き]
	[newlay name=mask_right file=%file|bg_01_a clip=mask_slash01_right opacity=255 level=%level|1 xpos=%xpos|0 ypos=%ypos|0 clipx=4 clipy=0 show zoom=%zoom|150]
	[newlay name=flame_right file=flame_slash1 level=%level|3 xpos=0 ypos=0 show ]
	[endmacro]

	[macro name=マスククリップ左短ベタ置き]
	[newlay name=mask_left file=%file|bg_01_a clip=mask_slash01_left opacity=255 level=%level|1 xpos=%xpos|0 ypos=%ypos|0 clipx=-224 clipy=0 show zoom=%zoom|150 ]
	[newlay name=flame_left file=flame_slash1 level=3 xpos=-220 ypos=0 show ]
	[endmacro]

	[macro name=マスククリップ右短ベタ置き]
	[newlay name=mask_right file=%file|bg_01_a clip=mask_slash01_right opacity=255 level=%level|1 xpos=%xpos|0 ypos=%ypos|0 clipx=224 clipy=0 show zoom=%zoom|150]
	[newlay name=flame_right file=flame_slash1 level=3 xpos=220 ypos=0 show ]
	[endmacro]

	[macro name=マスククリップ中ベタ置き]
	[newlay name=mask_center file=%file|bg_01_a clip=mask_slash01_center opacity=255 level=%level|1 front xpos=%xpos|0 ypos=%ypos|0 clipx=0 clipy=0 show zoom=%zoom|150 accel=1sync]
	[newlay name=flame_center1 file=flame_slash1 level=%level|3 xpos=-220 ypos=0 show ]
	[newlay name=flame_center2 file=flame_slash1 level=%level|3 xpos=220 ypos=0 show ]
	[endmacro]

	[macro name=マスククリップ左ベタ消]
	[mask_left hide]
	[flame_left hide]
	[endmacro]

	[macro name=マスククリップ右ベタ消]
	[mask_right hide]
	[flame_right hide]
	[endmacro]

	[macro name=マスククリップ中ベタ消]
	[mask_center hide]
	[flame_center1 hide]
	[flame_center2 hide]
	[endmacro]


	;こちらは枠が移動してくる表示。
	[macro name=マスククリップ左]
	[begintrans]
	[newlay name=mask_left file=%file|bg_01_a clip=mask_slash01_left opacity=255 level=%mask_level|1 xpos=%xpos|0 ypos=%ypos|0 clipx=-854 clipy=0 show zoom=%zoom|150 ]
	[newlay name=flame_left file=flame_slash1 level=%flame_level|3 xpos=-850 ypos=0 show]
	[endtrans notrans]
	[flame_left xpos=@+850 time=%time|200 accel=1 nowait]
	[mask_left clipx=@+850 time=%time|200 accel=1 sync]
	[stopaction]
	[endmacro]

	[macro name=マスククリップ右]
	[begintrans]
	[newlay name=mask_right file=%file|bg_01_a clip=mask_slash01_right opacity=255 level=%mask_level|1 xpos=%xpos|0 ypos=%ypos|0 clipx=854 clipy=0 show zoom=%zoom|150]
	[newlay name=flame_right file=flame_slash1 level=%flame_level|3 xpos=850 ypos=0 show ]
	[endtrans notrans]
	[flame_right xpos=@-850 time=%time|200 accel=1 nowait]
	[mask_right clipx=@-850 time=%time|200 accel=1 sync]
	[stopaction]
	[endmacro]

	[macro name=マスククリップ左短]
	[begintrans]
	[newlay name=mask_left file=%file|bg_01_a clip=mask_slash01_left opacity=255 level=%mask_level|1 xpos=%xpos|0 ypos=%ypos|0 clipx=-854 clipy=0 show zoom=%zoom|150 ]
	[newlay name=flame_left file=flame_slash1 level=%flame_level|3 xpos=-850 ypos=0 show ]
	[endtrans notrans]
	[flame_left xpos=@+630 time=%time|200 accel=1 nowait]
	[mask_left clipx=@+630 time=%time|200 accel=1 sync]
	[stopaction]
	[endmacro]

	[macro name=マスククリップ右短]
	[begintrans]
	[newlay name=mask_right file=%file|bg_01_a clip=mask_slash01_right opacity=255 level=%mask_level|1 xpos=%xpos|0 ypos=%ypos|0 clipx=854 clipy=0 show zoom=%zoom|150]
	[newlay name=flame_right file=flame_slash1 level=%flame_level|3 xpos=850 ypos=0 show ]
	[endtrans notrans]
	[flame_right xpos=@-630 time=%time|200 accel=1 nowait]
	[mask_right clipx=@-630 time=%time|200 accel=1 sync]
	[stopaction]
	[endmacro]

	[macro name=マスククリップ中]
	[begintrans]
	[newlay name=mask_center file=%file|bg_01_a clip=mask_slash01_center opacity=255 level=%mask_level|1 front xpos=%xpos|0 ypos=%ypos|0 clipx=0 clipy=0 show zoom=%zoom|150 accel=1sync]
	[newlay name=flame_center1 file=flame_slash1 level=%flame_level|3 xpos=-220 ypos=0 show ]
	[newlay name=flame_center2 file=flame_slash1 level=%flame_level|3 xpos=220 ypos=0 show ]
	[flame_left hide]
	[flame_right hide]
	[endtrans univ rule=map501b time=%time|200 accel=1 vague=%vague|400]
	[begintrans]
	[flame_left level=0 show]
	[flame_right level=0 show]
	[endtrans notrans]
	[stopaction]
	[endmacro]


	[macro name=マスククリップ左消]
	[flame_left xpos=@-850 time=%time|200 accel=1 nowait]
	[char name=%name clipx=@-850 time=%time|200 accel=1 nowait clip=mask_slash01_left]
	[mask_left clipx=@-850 time=%time|200 accel=1 sync]
	[stopaction]
	[dellay name=flame_left]
	[dellay name=mask_left]
	[char name=%name|エルシア hide clip=]
	[endmacro]


	[macro name=マスククリップ右消]
	[flame_right xpos=@+850 time=%time|200 accel=1 nowait]
	[char name=%name clipx=@+850 time=%time|200 accel=1 nowait]
	[mask_right clipx=@+850 time=%time|200 accel=1 sync]
	[stopaction]
	[dellay name=flame_right]
	[dellay name=mask_right]
	[char name=%name|エルシア hide clip=]
	[endmacro]

	[macro name=マスククリップ中消]
	[begintrans]
	[flame_center1 hide]
	[flame_center2 hide]
	[mask_center hide]
	[char name=%name|エルシア hide clip=]
	[flame_left level=3]
	[flame_right level=3]
	[endtrans univ rule=map501 time=%time|200 accel=1 vague=%vague|400]
	[dellay name=flame_center1]
	[dellay name=flame_center2]
	[dellay name=mask_center]
	[endmacro]


	[macro name=マスク全消]
	[mask_center hide]
	[mask_left hide]
	[mask_right hide]
	[endmacro]

	[macro name=フレーム全消]
	[flame_center1 hide]
	[flame_center2 hide]
	[flame_right hide]
	[flame_left hide]
	[endmacro]

	[macro name=マスククリップ全消]
	[マスク全消]
	[フレーム全消]
	[endmacro]


;■特殊選択肢前専用

	[macro name=ＳＰセレクト前カットイン]
	[msgoff]
	[マスクカットイン２００]
	[newlay name=tokkun_cutin file=tokkun show xpos=1300 ypos=40 time=0 level=6 front opacity=0 zoom=100]
	[tokkun_cutin opacity=255 time=500]
	[tokkun_cutin xpos=@-1350 time=%time|500 accel=1 sync]
	[tokkun_cutin xpos=@+60 time=%time|200 accel=-1 sync]
	[tokkun_cutin xpos=@-10 time=%time|100 accel=1 sync]
	[wact ]
	[wait time=1000]

;	[newlay name=white file=bg_c_white xpos=0 ypos=0 show level=7]
;	[begintrans]
;	[flame1 xpos=0 ypos=145 show level=5]
;	[flame2 xpos=0 ypos=-60 show level=5]
;	[mask_base show ]
;	[tokkun_cutin show]
;	[white hide]
;	[endtrans normal transwait=500]
	
	[tokkun_cutin xpos=@+60 time=%time|200 accel=-1 sync]
	[tokkun_cutin time=%time|500 accel=%accel|-1 opacity=0 ]
	[tokkun_cutin xpos=@-1350 time=%time|500 accel=%accel|-1 sync]
	[マスクカットイン消 time=100]
	[dellay name=tokkun_cutin]
	[dellay name=white]
	[endmacro]



;■突進汎用

	[macro name=突進]
	[bg zoom=200 xpos=%xpos|0 ypos=%ypos|0 time=100 accel=1 ]
	[振動]
	[se storage=%se|se837]
	[集中線・振動]
	[bg blur=3 superquick]
	[集中線消opa]
	[bg blur=0 quickfade ]
	[endmacro]


;■アイキャッチ

	[macro name=アイキャッチ]
	[beginskip]
	[msgoff]
	[newlay name=ec_base file=eyecatch_base xpos=0 ypos=0 show level=0 quickfade]
	[se_eye-catch-zingl]
	[begintrans]
	[newlay name=ec_mask file=%file|bg_c_red zoom=%zoom|100 clip=eyecatch_mask opacity=%opacity|255 level=%level|1 xpos=%xpos|0 ypos=%xpos|0 clipx=0 clipy=0 show ]
	[endtrans univ rule=map501b time=200 accel=1 vaguge=400]
	[newlay name=ec_char file=%name|eyecatch_01elsia xpos=300 ypos=0 show notrans opacity=0]
	[wait time=100]
	[ec_char xpos=0 accel=accos time=300 opacity=255 sync]
	[newlay name=ec_logo file=eyecatch_logo xpos=-560 ypos=-250 show opacity=0]
	[wait time=100]
	[ec_logo xpos=-360 ypos=-250 time=400 accel=accos opacity=255 sync]
	[ec_logo ３Ｄ回転 time=2000 nowait]
	[endskip]
	[wait time=2500]
	[msgoff normal]
	[bgm stop time=3000]
	[allse stop time=3000]
	[窓消暗転mid]
	[dellay name=ec_base]
	[dellay name=ec_mask]
	[dellay name=ec_char]
	[dellay name=ec_logo]
;	[wait time=1000]
	[allse stop fade=100]
	[endmacro]


;■投げナイフ


	[macro name=投げナイフ１]
	[瞬間白]
	[振動横 time=700]
	[begintrans]
	[黒 notrans]
	[newlay name=knife01 file=knife xpos=1800 ypos=650 show rotate=20 opacity=255 notrans ]
	[endtrans superquick2]
	;[se_w018_02]
	[se826]
	[knife01 xpos=-1800 ypos=-650 time=100 accel=1 sync]
	[bg stage=%stage|空 quickfade blurx=5]
	[bg quickfade blurx=0]
	[dellay name=knife01]
	[endmacro]

	[macro name=投げナイフ２]
	[瞬間白]
	[振動横 time=700]
	[begintrans]
	[黒 notrans]
	[newlay name=knife01 file=knife xpos=1800 ypos=-650 show rotate=-20 opacity=255 notrans ]
	[endtrans superquick2]
	;[se_w018_02]
	[se826]
	[knife01 xpos=-1800 ypos=650 time=100 accel=1 sync]
	[bg stage=%stage|空 quickfade blurx=5]
	[bg quickfade blurx=0]
	[dellay name=knife01]
	[endmacro]

	[macro name=投げナイフ３]
	[瞬間白]
	[振動横 time=700]
	[begintrans]
	[黒 notrans]
	[newlay name=knife01 file=knife xpos=-1800 ypos=-650 show rotate=20 opacity=255 notrans ]
	[endtrans superquick2]
	;[se_w018_02]
	[se826]
	[knife01 xpos=1800 ypos=650 time=100 accel=1 sync]
	[bg stage=%stage|空 quickfade blurx=5]
	[bg quickfade blurx=0]
	[dellay name=knife01]
	[endmacro]

	[macro name=投げナイフ４]
	[瞬間白]
	[振動横 time=700]
	[begintrans]
	[黒 notrans]
	[newlay name=knife01 file=knife xpos=-1800 ypos=650 show rotate=-20 opacity=255 notrans ]
	[endtrans superquick2]
	;[se_w018_02]
	[se826]
	[knife01 xpos=1800 ypos=-650 time=100 accel=1 sync]
	[bg stage=%stage|空 quickfade blurx=5]
	[bg quickfade blurx=0]
	[dellay name=knife01]
	[endmacro]


;■つばぜり合い

	[macro name=つばぜり合い]
	[瞬間白]
	[振動]
	;ＳＥ：ガキン
	[se storage=%se|se830]
	[bg stage=%stage|空 quickfade blurx=%blurx|5]
	[bg quickfade blurx=0]
	[endmacro]


@return
