Class AOC.Y2017 Extends AOC.Base
{

ClassMethod Day1P1(pInput As %String) As %Integer
{
		Set tLen = $Length(pInput)
		Set tSum=0
		For i=1:1:tLen {
			Set tCur=$E(pInput,i)
			Set tNextPos=i+1
			Set:tNextPos>tLen tNextPos=tNextPos-tLen
			Set tPrev=$E(pInput,tNextPos)
			If tCur=tPrev {
				Set tSum = $I(tSum,tCur)
			}
		}
		Quit tSum
}

ClassMethod Day1P2(pInput As %String) As %Integer
{
		Set tLen = $Length(pInput)
		Set tSum=0
		For i=1:1:tLen {
			Set tCur=$E(pInput,i)
			Set tNextPos=i+(tLen/2)
			Set:tNextPos>tLen tNextPos=tNextPos-tLen
			Set tPrev=$E(pInput,tNextPos)
			If tCur=tPrev {
				Set tSum = $I(tSum,tCur)
			}
		}
		Quit tSum
}

ClassMethod Day2P1(pInput) As %String
{
	set tTotal=0
	For i=1:1:$length(pInput,"@")
	{
		set tTemp=$piece(pInput,"@",i)
		set tMax=0,tMin=99999
		for j=1:1:$length(tTemp,",") {
			set tVal=$p(tTemp,",",j)
			set:tVal>tMax tMax=tVal
			set:tVal<tMin tMin=tVal
		}
		set tTotal = tTotal + (tMax-tMin)
		set pos=$O(tInput(pos))
	}
	quit tTotal
}

ClassMethod Day2P2(pInput) As %String
{
	set tTotal=0
	For i=1:1:$length(pInput,"@")
	{
		set tTemp=$piece(pInput,"@",i)
		for j=1:1:$length(tTemp,",") {
			for k=1:1:$length(tTemp,",") {
				if j=k {
					continue
				} else {
					set tVal1=$p(tTemp,",",j)
					set tVal2=$p(tTemp,",",k)
					if (tVal1/tVal2)=(tVal1\tVal2) {
						set tTotal = tTotal + (tVal1/tVal2)
					}
				}
			}
		}
	}
	quit tTotal
}

ClassMethod Day3P1(pInput) As %String
{
	set xmin=0
	set xmax=0
	set ymin=0
	set ymax=0
	set xcur=0
	set ycur=0
	for i=1:1:pInput-1 {
		if i=1 {
			set xcur=xcur+1
			set moveright=1
			continue
		}
		
		// move right
		if (xmax<xcur) && moveright{
			set xmax=xcur
			set ycur=ycur+1
			set moveup=1
			set moveright=0
			continue
		} elseif (xmax>=xcur) && moveright {
			set xcur=xcur+1
			continue
		}
		
		//move up
		if (ymax<ycur) && moveup {
			set ymax=ycur
			set xcur=xcur-1
			set moveleft=1
			set moveup=0
			continue
		} elseif (ymax>=ycur) && moveup {
			set ycur=ycur+1	
			continue
		}
		
		//move left
		if (xmin>xcur) && moveleft {
			set xmin=xcur
			set ycur=ycur-1
			set movedown=1
			set moveleft=0
			continue
		} elseif (xmin<=xcur) && moveleft {
			set xcur=xcur-1
			continue
		}
		
		// move down
		if (ymin>ycur) && movedown {
			set ymin=ycur
			set xcur=xcur+1
			set moveright=1
			set movedown=0
			continue	
		} elseif (ymin<=ycur) && movedown {
			set ycur=ycur-1
			continue
		}
	}
	
	quit $system.SQL.ABS(xcur)+$system.SQL.ABS(ycur)
}

ClassMethod Day3P2(pInput) As %String
{
	set xmin=0
	set xmax=0
	set ymin=0
	set ymax=0
	set xcur=0
	set ycur=0
	for i=1:1:pInput+1 {
		if i=1 {
			set vals(xcur,ycur)=1
			set xcur=xcur+1
			set moveright=1
			continue
		} else {
			set vals(xcur,ycur)=$g(vals(xcur,ycur))+$g(vals(xcur-1,ycur-1))
			set vals(xcur,ycur)=$g(vals(xcur,ycur))+$g(vals(xcur+1,ycur-1))
			set vals(xcur,ycur)=$g(vals(xcur,ycur))+$g(vals(xcur-1,ycur+1))
			set vals(xcur,ycur)=$g(vals(xcur,ycur))+$g(vals(xcur+1,ycur+1))
			set vals(xcur,ycur)=$g(vals(xcur,ycur))+$g(vals(xcur-1,ycur+0))
			set vals(xcur,ycur)=$g(vals(xcur,ycur))+$g(vals(xcur+1,ycur+0))
			set vals(xcur,ycur)=$g(vals(xcur,ycur))+$g(vals(xcur+0,ycur-1))
			set vals(xcur,ycur)=$g(vals(xcur,ycur))+$g(vals(xcur+0,ycur+1))
			if pInput<vals(xcur,ycur) {
				return vals(xcur,ycur)
			}
		}
		
		// move right
		if (xmax<xcur) && moveright{
			set xmax=xcur
			set ycur=ycur+1
			set moveup=1
			set moveright=0
			continue
		} elseif (xmax>=xcur) && moveright {
			set xcur=xcur+1
			continue
		}
		
		//move up
		if (ymax<ycur) && moveup {
			set ymax=ycur
			set xcur=xcur-1
			set moveleft=1
			set moveup=0
			continue
		} elseif (ymax>=ycur) && moveup {
			set ycur=ycur+1	
			continue
		}
		
		//move left
		if (xmin>xcur) && moveleft {
			set xmin=xcur
			set ycur=ycur-1
			set movedown=1
			set moveleft=0
			continue
		} elseif (xmin<=xcur) && moveleft {
			set xcur=xcur-1
			continue
		}
		
		// move down
		if (ymin>ycur) && movedown {
			set ymin=ycur
			set xcur=xcur+1
			set moveright=1
			set movedown=0
			continue	
		} elseif (ymin<=ycur) && movedown {
			set ycur=ycur-1
			continue
		}
	}
}

ClassMethod Day4P1(pInput = "") As %String
{
	set:pInput="" pInput="oaoe rxeq vssdqtu xrk cjv yaoqp loo@mveua dogbam szydvri hyzk lbega abzqw xwjn wniug kwbre@npaoy uivpxwd oynpa rcdk uixpvdw@yserir iikzcm ieuroca iuwcfov rvb giti crdpdcv mxpps@spyuhgo lucasl ucllsa bymnjig yflbv nxitmlf@xlxyhwz xla mpye fvjegwg fezlfrt inetrh vhg xpvstx ydhvq@xgue cvtmh myg ontvvyw ygm oqzrdrw@srdfsjf dli kccb kauk kauk apa doefc cdffkhh cdffkhh@msizb elqiov lqn epamk onmnlst baawab ncafwaf jrataml iyzhy svycuec@wdzqpcn dkgdumv wdzqpcn qxdmwib cjsigi bgcihgh fmua@kpvbzf kpvbzf svyq flg shwtgp@ywrynt cesjtgk hsvitr brpiul lxgvvrl cesjtgk cesjtgk xuflpfn@tik mrpht gkv unqp wypscc vmwiu ldrigk okbc wztc@zpy kyzvijv bilpf etbrgk edza vuz jzgn@yoa rgppd kzpopd cffjk murcb jmt raace iwt@aobgkja drc ztkd qskxxbv lve lev rhhoqex bmd eolf ybxjr yiiut@zhjcfms fpabnu aozp delsc mge yqi eovg pwefafe@gukf iys qztqxz xhsssz pfqq slg jdbp pfqq yabztc asow ygh@fmr ijgmjrc zbhwsmx ylgccz ycydcyx hjjset@zybsr iqisbs hffmij ikby lwufzvg gwd@ruk rku kur ydurp upmebe@baqide zdijcf ezqfe ovrldez delzrov szimd irmk busim ppv zepqk mlwpl@bxlvp dxumme byaada cgyn diz@xlxr jhili bmcke nkl vuhqsn lxzb zmyuxgk qcqr tyxe@wvth gyerrd yewrta kgri yewrta@fall jpyuusu lffybb ivmtmzx alfl yjupusu@lzvcg xwnt mjyiklh vwlz qejj mjyiklh dmcwq qejj@vgutb smc yvnsbgd bxmjd qmhia krxz luhgg emnrp@uuvhtia aiuutvh brstbr tsrbrb@howd japlq lhk qtsfdq htfufj qkyywy anxxxqw jtmryw cdtajh@pksswl jprpccl wpklss yyrbo@furp pfru bftha iekamfc bixwmr sslovex@nrqobo hyb byh hby@mugix kzlbtuq hmju ysstccs hmju btsuh@hsrlhw zilj jtvto zilj fjq@lvol xic hqqdeo gmsug yqe wue vhmrq buj juv wxexdot@lqeybb odpv mttm bxqy vqbqr ylbei wyjcxco urufsuz kyq@youbiz kvrea xsfcp zaz zybiou earvk qpf@bowsref ooobtic apiushu kplpyza@hxfhoyy ybbe ceebt recegzz ftnlv ukaf gpvx opvd lqnvk ybbe ygnwa@jpbgc aahm aahm aahm@qyvheb xyb elt oaksuj dvgpmel poiowc ykgbgpz dxpit ytg@vgsv yrjo vjss kyfvim izwo yrjo vgsv@hkk xmqx crlki dtp nuh okef okef xomktit viia nuh tplhrx@bmkjclx sbwe bwes bsbnqd nqbsbd@gfwrl vocwln hsuxkz zpclb qprrvlt bkcluvs pqy sxucrla npb fensz@adjklj nyr btmav roxv jrri vqfnis gzsab ogskmaj@bvjm fer ztgfx mtp vvhps hptzrar wpy yhvmh qklfwpf edgrdts vmhhy@lngra nrlga xokqu mgq@mksdk bkkbfsq hazlai nixee vyxh hpvebeg jujoqe wkw mzpxixm@kxrkkx qivtt xsm xsm rqvgdjl jilosjs rji@xiqga rez igqxa odiilj izoiwf xgqia@aepioo krcr aepioo jhigtx krcr qubkv jgo zybyvy wbsguz@ntyscmf duwvvb kga xvaypk sfjlg daguzm kqat otj zmnki@ggxaery jazo ggxaery zevobo zux wfnd wbyd hmhmo oaakvab jsimsw@vqdnvgy qiex yqeweds yqvdvgn iqcukgc bvrc osi@esjzak krwe ivbri hnbah iuvb begybsk ctxmlym gjqi lcscum@hyxdilx tsv evckza bdbscwj jlihiqk dciuj hamd dqsm ydihxxl@lurtwhx ygwf pwhj whxtrlu zfvywxr gcrl zvl wienpqb woto@mfaektr ocvho ukfx ukfx old daqwotk pybjtiz kumkiq tmql lqou tmql@guwy ceqsyvs svteymr nrovwz tesymrv rmsveyt@pigilsu zpyiohn zpyiohn xzl pryi zpyiohn ohdz@pziqfg hhrzdr wxl zpqigf@psnmnxz oed edo deo@tkdp tkdp auozn tfyo wmp jtp wjyskeh dag ojdvw gbptp deiqi@xkr nmsbk mreiv occcvva eca bupc gvaoopu jdhr flh ptgdumz mks@dlevn vmwzws dlevn dlevn@qwx qnuqgc rtzc yvym sft wxq fhv fts nyvrfxz ydjvcq tnwz@debkk pullndo ezaibw ldnloup nllupdo wiiw nij@hng rpd aud epq opzjh jnzge@rmtauf nwinyl nwnliy pjzahm lywnin@cgiv omva fos irse uytiqu iqjo riplx capa dhdl echbyjw cutfam@fqrqmi jfrj zllh gfhhq fqrqmi mmyqv@yoepae uabuxlz jzqy yoepae sxena jzqy@bfr jlrycal ndg xejwjdp khwg wckevqb tud xljzem ntfbazf lkr@aomdwt sji sij jsi wlsvvva kgjzqj whhf@ogorbil orlgiob iorlbog xapwiqs jxb@tnn sxgdikv ynick ynick aumwthl rwhx eqxd jdbzyk kbil pmnifp dpeips@vzeoilq son olqvh jawmny@vsifce kcighpn mubl zkgwm@ncagxs ilohd lyq oqhjf nfeij qmtvf qpru tfmtaj@pfjkcpr dqrfde efqddr edqdrf@wdyygax hscx ptmro wqko ecnfkhj ywui@gdv nrnrzdc vyq vyq vesrj vyq jwxg@oqhrr daoew zpoduh zwmoss nfkh vubf xza kju rhrpt fvsc@oqp ppyq swvin mut uacwd swivn ucdaw icfj ldcujh cejl@dar bqp ajdhuej sxwt bqp tppexrh tppexrh@sitplaj xnb ldopp mqd gwtk uhnvozu ljz dqm ylzy qltf gwtjksx@eqkvncb jdp pahwje avhrer awb zqnwfhx zohmcz fitbyab@xlnel gjzviy cndpuoj jvwxs qsd kwli quisju kyoix imzg@czqjkk evyima ixpelbv eobpd wwuxxof pbxc dgj@czsigs lbdaynp amsexn aemsxn easnmx rsitdzf@xdpc xfbp lrjwlo ntnnob sbe bse@suud fws zgn kvfimsi@wnexa diexvky oemdq uasxzhq qxa kevyixd lpw unluohs@ylruxt beqvn vbenq ogsov mvftu sovog gshtb qriaxko vthgfr jwj@gmz wcjb cqjlb hijz qwuluuf xdpu jybdf ajiv xizwb@fcxos spz idg rjb uhr ert bxia urh xfxp ixba bnvxy@uxiie eixiu wgmwbj euiix qknyd wtaojk naeqfz qmhnulk uscgwxa@qwyxd jno xelqd isdjht qxz dbwnr bfzhewu opxmkgj igfiuck@ljpphwc ijzic pfsemsc mfedoxy pad wsk beqjpbj gbjr imce xumhr@causc ogypj csacu pdokc itpgjl xfx nyt yytg srhrup bontz xbalwnj@asohjj qer pfgwo qgdw wgdq@gpzvyhh tsnx tyu kswlgb whju zkkpdm bmh hdov@unux lhrn unux lhrn rxr@epq ksew pqct jib pqebafk jib pyfjy gnu pqct@anzbbs oyhm moyh mhyo@dpk zael zael mxots zfcum@aehljyc wrj lfhife xbss ztszba vlg eljycah ihffle coypll@aoqedco bogk bogk aoqedco sanwwo@udmbz yxe dft rzolgtp nwwjpti@efu qcls rtx mestnqt pkh ciekj scrv uswd oroowx lcztvt@urnwt uapni ood lzce@zjiqxt jzqxti infgde xbmi kawilp kaipwl@lsfn kxfw zgzdfq meqwql zpqqu otert@taajsho gbeoguv bpi nxeuy@dpoyzi rqlzx rqlzx udhuwjm qnu bnuma udhuwjm gfezx cbjpfp woir@mjbv isni ixjtjue fwsk ncgwpn vqnmq pivz jbmv qoakqou argval dacvksc@xxjcn amdgdhh iup hlk xxjcn elx@gyhocay ofqosv nldfqay aqu dsrz lmekze bus lmekze gfoq lmekze vkor@xidyqq bimvxu zrkg rpcdca ymg nmxkkqu gygcmp euemr@gvd ywog ywog gvd hwjzzq@byu ggpwrl lpexjcf hgy jee febgcae valcgc tcfwicu texqi lxfjepc qeraxcs@lkjejsb eonp jtsbps pfvlos neop ikwnb avzxnk@big pjgttfb eetr jobjfae odvl jheh tuz ystrh tuz tuz ige@czubaxq czubaxq pbxgs jhuopn snmhhc qwmcka xdhxfuz jhuopn eummw@xdwduc sqcano zopaco ozbbc bczob eas cbbzo@oanpgo tiav bbssup ttzchih tpb xmfnqwa ghdx uepmz fzqbx@ahha zsbdq jggv zfcjdp dzcfpj dkew jxmelbf jgsohj oghsjj@awdy plulzw gdi jiiq lod rog mrf uihaz sebk guvb@tlhwro sapaws ovlbbfh xctruk spzpzm latyy@ligaot xfhacs jvk xbnpu yuanx yvvi gjek@nfwuug nxccj dxpfvfq pvxcvy ayss lfwz wwole ewowl xceybeb efs zfwl@lzowlql armo yrlgfg kbl vudahci yav evdi ofak ysmfjk upe@qtmmqrl gxi rrhbi pydbopp yvevlq ovwwdrt mrppov lzzs yjyrxh srzo@hytkyas wpuqvf fftiso fftiso@yutais qjdbzo kewsi opy ysl zyvyoty wkp@qtbad bxfjkwa stcdk lyre tabdq yler@friyh ivp hshy ksmanzq mzdbbub ncbx mhzki friyh vyjk hshy@ijeysr aww evn ttqvshg xkd zjy honvuqy zyj quvyohn gphcir@okft smja fkto etb@pbi zhyy kyjdho mqsuyic vegocmw gdkskg kgavjag dbqh wamfijz ktihnrg@csqix soz ingra gvslgk@ugxgzqt pdn hiynufo lpfabmi rmwj uhsqoo pmlzad ferdup guzqtxg voxd@wkixiq vck vck sylv ttqcbwv ywqta vblz mhohx frv@phns ozeghgm dfodkyv iyc psnh tedotyz xqz gqbyj ydttezo kxgju mvip@chc jdjo pyq usyn vtrbnq ohnx dsxpdzn mgbc ysun mlalmu mqemyuw@qrkosx wcwcv brvbwo nvxwg bvrwob@bovt gpb rwm gpb pitttl rwm rvfzn tbo@zczkb tmpwtj kackkx yzqkzso rsg ema ereo jptvfd jptvfd flbjfii@fcdyetv jqelvx jlevqx cfvetyd@dtyp wfh rxtpwr nolbro iozrs mnshu tkesvyk pkmkf@lvecoh ohpb brlqwx immgqe dzfac bwlrxq hng clxmpd qodfyv@sjbc dsoqk dqosk iyla lqzrsgi tjgt mfxshtd ztmc@nxveg vmxf jwnub kujji aqkonjl xtit xitt@jsft pmojruo vtvjox wimrlhj rezqi rnv hjnvdka@vnl vzgltnl mry kkqf fekwjw knsrvt nct kqy infvys@jbvm igq gvcl crry ylia nbqcq ouduen jklepay@ermsf emrsf uksuvz zrnlun@ecksf dkydasw wddasky pmfhi yltmedt bdovedg vfnyoze ufcki civrjs ohozga@hvf gfqgc adbeykt jdz zmgonhi yua kifxyoy umsza ivnbvoc whnpi gtbinze@nmy fsdu myn iiw@yrkwca jkxc yrkwca yrkwca kxqtvqh@ildxc taopx spykdz dzbpcxp wzgka cbyr xpvrzbk@qqp axdmvo cmppp shx@uldyu luyud uduly rgcmugh@woc vjdpyq cwshqq tlh fzyuz cbwgp egpy sfw@adyv cnrn bhaxvx ofdbkn yxrtir cnrn@ycz ednsydc bqsdcpx adnq bydb tqy tqy vqzpy erdcnv@mouv ouiy gld stdv gwr lxlfq gdl ldg@gtx bbvr fxytm veofwp bvbr opefvw@pcf scu ovso rawtjxs kzxgnuy ifcn tvibap@ugcbob xkjgtx ugcbob ilkkx dikca wpxyq retqhlu ugcbob ylmt tigcmmm@gmnde ool qeuwc ctux@wpajwn gooy fedmjur pxiq xkyniyp xtgi eyfpc gjx@uaivt kvfyn mpsya qxu kvnyf wvoeaz mbt fkyvn@jth awxbprn kpcodj qxegybo@sfvitld mdzczg pdptzm fmz himb eutpyi mgrde gubsta tfsldvi dfistvl@piabmr fckmhrv twnlnka jyb selqflm iwcutk pvvann@uxjfm rmleg ochuj ruiq aobxbb tpuusot uhwjojw tutopus@dzj qdyxzk oan rtpz ona qkdzyx nkunr@urjydh dfreifg tmbetd aakc vdr dkdkldw xgvtfsa ivv doadb axgvstf@fdjhr ujgbj ulkm dfzh tmhx zfdh ckt ortg@obe ywwge rgqmt cfcnyt atn fdkdrwz lmb zwpe sqfoc yllxs akdlsso@ckhbu jfqhkml abenw ckp xvjy wsyhxox jzsz hqksq@tjx zlh zgyrjpe bdorry uofh hgkzl ezixges kaxlkjw ztijupu hlgkz@belj ipbygk dxe cqoyukw jnncelh ihvom qstbowu rocqsz ifiztlf fjrf nsit@vyswalv reaqae hzoqyun lbci ibqfljz cgjflqf kos@njrzfvu nxw nxw bdsgnxp@gxlgn qrx nspbvl pzuob nggxl ipak wjr lggxn zas@xkd sooef fsayaob tfsiyl@ecldvh jugto ghfpbev xzlc@rpyattn spb ajdplq eaorgi ackirxg knrap cobdeu qca pkp zkc@bhh tczwffg bhh bhh hrjx jwyu gry kkgghnx@zsav frsakbr bvzd gafr homzjw frsakbr yasgz homzjw kqa@nbd mekhfif mekhfif keuoag nbd@mzv vzm utuxhuf uufuhtx@siy tdbii qtu yrxar ruubale yrxar lsvnr yqxq ruubale@wstykuz fxnuszr tgmkw eovvrd ohheh raf degh hzoeun tiou wpt cqnw@dzbyhrv vzlbvn ncoa xfglcye ncoa sykfps ghi@lvi ilv xalhd ztejzb@zaeu diz zaeu gtdjsz fmoxgju diz uvh@zef lmkqlcs jnhgqww qsm fuatcq ixfa@wgp gvu rpmxrjh yokepvc yokepvc lywdl bbvvbf yokepvc@etjfs gjh tvmxb agovg yihn rmmh nue jfil@zgcco slios jbfodb wpthe ydvit regizw regizw qosou slios cto jfz@kmmq lnafaha ddos hrsjtxk zjch rfynx eovks@ezeuzu jfpv oinrstv vsw naoz enrcy svw jfvp kgmfwf cfisxzo@ljtv watps equf ljtv equf@axijki zotolsi ryqujrm xmhug fhz lkgaw umzokxh ktr jsdsfat trk iosoztl@vpqvvvn ydjz tcqc asffcxr rxb fyt vyham fys@agxrcxl obcncq htod ved ozesk obcncq iwqmksk fsijtg iidyy lxu ozesk@orsyqt otqrys pnaax qtrsoy@oyisc chu ahdp abhbtry kjsqve tkpux tkpux sxzu sxzu@wquw umlbwf mxzdbvb upp fopxe aub bau eritni punrpfc esnkyg@jjlzy hozskgo jjlzy aiq jjlzy sgfyhsd@ejghc ejghc ejghc igacslu@unzmg fugzotb nxkdlds ewn hydj fbr iuly oiwwkbg scnozau sfi dsishk@xuhjduu hfloaga xhuuduj mbavfkd nrnl ral erc mntev elpoqgq@seydro onpi qjey skgkiox fbdgyt xhr rhvz dpsjcj tfzd spjdcj btqn@difyxz cdm jlzsz oycm txyssd wckqshu ihya yjyb@nmrhlif wcreso chtqfov qcftvoh lqp egd erc myep plq cjdh@hcnwgkq kkrpxxj gwe xqgea kkrpxxj nxz mumqbw kwxhlz kkrpxxj otqy@rxbioyf cszah mhu mhu mhu@qpbrf jzink ojy idt nrjykzu@omnrq kkol dex eaqdmej dnpaum ynnntw ddwewsh ztcenhc zqdrq hmi@ngmqpu owmcuz gop gdbsfc nyott cdsflq ngmqpu@srus lrexy aqgkqvm tiyjm@wxa qopky glaaekv ykopq lna gyxvpx xwa hly dbvo@vqf sqrqw phxn xiw gejyzip ugg gghhugl zyqae@ylj cyolrx giim yrchuu yrchuu ylj@rixa yfusuqn yfusuqn yfusuqn@lpm gboakz ylyv gje yxu ahokxb ixwnpu hlcka cndhbbm nkmvts xdtqbc@veul zjvz regtyp njwfpm@pdlyjbn edawa xbcmyew gme yuk yek nfknzgn ehjz@rcgun ulv ntbwnvg ptf givapv bych gmxxxf iajqpb gwh ipavvg@qvpwk grbb gptdgrh sij vunv hsb uegsmt uos vkxdd@iun aagzlj elqcq vkrk awl yyt dxfhkwq hbkeht@cgf omofuz zddgwef iyosk hmou@mvjorn zseyo wpfjlac kpxb dlh ggo zgxoso txzuy jfbmv lacjpwf vha@twrsrw pxv iklzg rtfcl kfbcjix uyvowpa kfbcjix ofnsf adqm@qvi ivr plxfrg awugjh fxbv ztlljk qvi jdkfts xyq jdkfts uqwgdr@phs eimuuf lmxq wmp@laf gmuowr rplgkh orentm whor lkrhgp mjwr zapz mdqtqyq ttkfkf@fxk wdbl fjh ojqxp yvs fkx ysv ngksb@oclyxqu tpajqun vvmj twin zclk@srcwxs xiduxd tqpfc sbqybp sdtzw gizfn bpji kaolpuy@pfkmk olmsaz uffy uyff@crpazh pcrzha lew lkhcjij stfxq@nkbb rnlo icnzg rnlo ejanu mofx ujblud@abte xnjfo boz fnxzid nqfhifm jmnmsgh@lvck nfll szdgrxc nghig szdgrxc oytahh cibk szdgrxc@sduf jgv rrt spxw fdus@gplutjv ufep fuzrnj tmko zzpj cpd mvtrzq@ycdiav qvr ycdiav tjngezs mphk oykgcei ycdiav@egbkscg ksgcbeg qmw jdbj@kbgx otnfyc agouh iai lyhqd yzihyq ouagh snzhxa xyxrgz@kdpqljx rin dlxms ukdzedc duezdkc ikgplm ffk vdmie qziajdf ftfwl@prrzhj okffaot tlrxpjd aquc dbonaef enfdoab nwbtuh@vyzf ijo cdhek bvlgxt kvldmp kvldmp vfvg@zhijgyb yfkkal utb brew vfj ztiftq@kodsuol ubnbdv iozwfum ayqxgnj qkp yiiv wbkgi psi wnfa epw@iok mecjsp lccn nrb kobca wkznctc afjjlrt@yrw yhsva hgx nxjfbb@dbdj vef xjssylt hjlld bqbmx ihfmz uhij zoh opzrmy mfq@wqhcq usyfuc wqhcq pmf aryq nhvtkh@nkviwge snpfdza nadzfsp evvdnrl qled ekqs qumle myhky@rgljws kjuk txgeein ajmph pjhdy pmvr upae yfh@vmepn wekgc qfwybl midbac vmepn ddqmbu vmepn uhfccp yuh zzz gnx@hyqv fud xdc bssziiv mwo xfrsn xqehs mwo@djhr qxhfy vdjs ueoi mbmwa lkeumzd hyxfq krbyy ywvcstf wdkum xfqyh@heprtex wgxpign lvm vlm ypswfxr ggxipwn hdszz blrv ppy@fwalim sbqj zewxcaf qjsb cjgujwr uclxro wceu wmaifl rnd@gmivd spncot jxeycn notspc nzb wie ceyjxn xlam@cfujai hfvux hhtwe hfvux oputz oam@gmwu xwthnkp xwthnkp mdxa xwthnkp@shfqzi hdq uyyqjrd wczfvy wciko hdq nuywebl@dtkq qnb uzmo ypxfja cekqe cekqe tnaibc uzmo pmtnb@apdz exdze pop pvm pce hywvftx jrjezgd jkajq jcdjli@satq czv cfhyca cshnyh cshnyh rcu cshnyh@mxp ujq fmrnzxx xqv mxp@nel whnnxak lwzlre mrxq kpo pko bsa gimtzwb@okssco iuke vcnv okssco liawwc vcnv aztl@kjvq rye eawplkw qzxt jkqv bxbfyv@bphssax ylemih wsm jnpxce jgh repsyj ieypbz asx@dwivit ptcwt qwectqk ttwcp bklpa ivditw@ies knj zemmcto mczotme yanr kjdrwr mcry ndols@dqzdpg adb ulsv ulsv qux ppmoru sjcn dpihqz@akazkk kssdguo cgigktm indfh wwh kevuhv dclpjv kgtd ehjxous@spogxy jyzhag qumd brk cbu akbpjxb spie@jgyn cxbar axtkwh hktgcm cfsla xll rpauwl cgpziuh dyc brcxa@dodey dysnjxe kzmyytw tzddd cnupwmv@nqab whxkb kvc kvc jcjhywy mbbpfwj fxozlt whxkb qwz@ihmif xhjc lmfk yjrsioo uvtd qvtqsgt dqd@uvzedxd afli hkrigd lkzkzu ncki toam hoaefui@zmvywjv jsjf nrbrgt mbs yog eexuo@ukzab euwb qnkanyt lgeqf qefgl ewub@zbol bolz ilncu ciunl@hjryu qyl ajwju rplplr skbdsl xvto@ojfotbx zvta jofxtbo ejjnhi jyeiz yzeij@ivr pvrwef ivr zgnm jscgaoq hfjuzju cea hfjuzju ehszaz@yikp gul ugbniac jehm fwqxb hqbhi hlfr iyuuf vacrao fwqxb@plsjh efu napxwe jfxfjz efacqcp sythfxc sythfxc napxwe qncqc@meuf rcjzf mhluz kbrk tzjrcn omoiprl khs oyzad yuzbz@exvzzuc ckqfivf uoyidkg mwztyf wxtg uzrls gudioyk wfihpzn tdmwhf@qoovwqm bldswvy xkb yqrcluk qyrclku cluqyrk qgakbv urclhse@rmmymgg ytpqtuq ibt tmedibz tmbsdg ytpqtuq cxbnng@qkyeo frjjht vkpt ikztq avzqon diw noqzva dvkhwdt@opz usos kdqseyb cdxvve nahjc hbr rhsfm hcjna wnczls kky@sgeml uyaoe ked utxab hxqa glems wbdo kzrjsq@isp bmebt becira ixoz yeakj fmueu@jrd qyys cik bmaief zxllza rsu swvodiv ivvdsow ikpvwaj jdr qte@gzjjre tkjhdn lrqmvw gues ositymc xhfiutm@kcnble oxoh zggvo zjz auub kunoj snil zggvo lgql@yyfmd wbwmizs vmb clba bpzzjz nlt wgukoe hedlp osxz@skic mgcr chkj eiiy kdhch gcanziz dpecug fccp@jhnejy akpwbj mhrunvm wjzwyhe lwxostl gfe niuhj iuf bewur@nuursk gehzvck szm fllr bfaq ijpjp gehzvck bfaq@ecx etrsadp lyekp lxf flx tadreps@gbo wzkner hky ggoqu@yiitvf tyvifi xpnbk iiytfv@okpjxyq mmxcha pujgv ltgfdk wpporh bfle tuupth ukyyjgv vlnwhz@phbs qtpolnh udito ukx kjqsi jbwf sgkkwgm udito mwwb wihg@mces dhc qccy sxyilmb qmki dyqnr qsh aigaemz oofdw hbifiz@yyben jjklnz whwswg tox vgytp noijcv jjsa ybney eyrvg htjl vxli@detb tus rloz zymvmg zpe@usvkehi kxgvo rna scnaljd jmowud ipfkkf rxvpie nxysvj pvquagf fjhsvef@ytosun puwdoix oyc qdufuw ysunot@htw biy htw oxot oxot@xgzi nbq lxxtmt nbq lxxtmt fnzmmno@lko bdbj kcqvc torg enbfbj sbooco afjbclm dendwq@cgih ikmfn lyhzhxd ubq ixrori tofbo@glfhfzs gihsccj yic mlci slne@wdiu lhl hdlhzo voo yhqckcy axnz yqyi fyss qhvtsbc@aotbk zfokegh uax myhehay terwus hmzic fdwojh wjuwlp@ucbiex eigq qqe ifqw sxakwl xkwsal qeq@pknvybh qkrwi povvd phairw qst inklob yrryv bcuv dolvr okwe iexrpbw@kkah qrt dihygsm nly rblqvrm sxguxj yspmre@gzhhkjt uimif bssle vdiaa wkohq nrgboi htkojiw@aeb xihgva vwcjbjh lri nlwbxun sargiey uyekrc@fnnwfbj yyccaxu fhqb nlmwhc ymbqky ooljix mfijg ryykirn womn rygezi qsdwgpw@itfs udfr sitf gml@gknztly vay ypy jpid pyy mbpfmwz pfmzbwm qqec@bbhmw uus xffgd xcjzrlk kyecv zcerxe@ncpc otqzotf godtu yhcpsyw ncpc fbs@ggoiqm ofk pryqt kqdbo ktek kklhlju iqgmgo gqoimg flscx@gsgmvy tktzj kgi ikyz pthtk hxt gik@bunvugy fefqpkk juwk aent@atm tma dzyret jmuqke xbayiit jumqke@dilfw qws ldwfi lnujld ywrogk kjh adaj khmlb hkbml@veaemc xugf udpphf mydi jbvebgp ngyhly pufdph vbgepbj@vyd tisntn qmc yzal@uxdlc piw mwjnk qiar xwpspf sxktemh jmw@qhhvar pox aed bgwq doe uyktv pox vriy ndel pzx aed@tswei dtfb yhj krxu yqio wtzpm wtzpm yqio@bjzp zzp qdzdfv tzkbl nggbfqs vquqds xiud xgrkb@ffvjfwp jbzslqo ffvjfwp pchzrqv ffvjfwp pkd nlav@czepixn yurmsw ucckih qqlnxjj exipznc@xeu llc jnmp dmz pnmj stqzao@fzvu uscqp xerkzkg roivhri fzvu yiwae xguz ajpg@qdzk uyyoi cspmnc qdzk nwknfx fnngvla cbl@acg utwrv cahupdm xgat elb aemkf wmkdzj kfmae ahlrwu yxfcj@vdumh rcd rgc hpqk qeum fpgva qkhmuji rjxpuzk ommk@ztvm ntxkav ajv avj ippodg sukg bivcslu tes gdlrbnt bdlkaye xpgslef@aygsym pwq owxmx xjw@dkhykf pfqeyo lfq saoewy qldrky sdgrrcr frdqn tkfezop doo saoewy@cwof mqlscm iqxhb nnkex nxx glgpbn@noq zikmeyx yodahj ssu qqmifa plcbv rsahsd@nvc fuwiyq myv hjn rtuoq zoyp rqnt xchlrg@dziscfa nbzsuvp rbnrban cjdprp dkj zcry ckxtm@stpm ifcbmmw dpkpzo sot ydpeydw nusp nkciqa psnr@udikjfr foqnxl whq ojuspzz ddyz emdktzb gfio mnd hyb@vchdphx zkrtky ucyifqx ryzl txdixd cip aid cip@wcz ywzwpp viswpsm qfus uzopaq mhps sidjky kipvjg@wehhc rzujn urprwzw gkwzhk rhrpph xkzzl rzujn yddlb@wlhif foh rpvylg gruiqdv daih yflhbr coe yflhbr hvluddj@hfzi ffjntj fdth crkrzdr nyel nlxm cawze bfjz neixnw uygqvmw zayf@guthfwn kcinec glhaiqv rfgbi cbrm@mvqv lszqu eyjn suq lavyjbh ujivbza aianl wik noy zth@zkn ren ncoyj fppsy dwgtgqz til@ybxepr hrzcrxs zhrscxr uvpxxl eprxby vzgg@xhi zess zet mtpcu ibz nkwq cbzb etz kjjcns@kvmu rxgw xboplw enlqcxi uxysl xboplw kvmu oqxislh xeg qwhdc spsddge@dxaao ltjjn cpsvnxe core aojgu pbss nudwi@llro yoy tixzyc beim qirnb lffcr gzm@quxetbf gfpll gqyav dckhp xbfetqu xaebz xuqfteb@fblkc hsydxqt bvmwujr rak@epeohq olrwyft cmrvov fbdyxbg@uzqk pkhizw jbrnlvx aqkq mtmjmy gpcln gaqt rinrz gwis gpcln@ttkcu ttkcu mcq xao lhnxdph djj ylet atdln xao@pmwn svqktkm isopar krrfbna knrw kbm zsohxrk xlsmm knrw cmoikq etqeggc@undrw issrttk mcoe pvufl bwjwqkx jdz undrw vje@kfzqbb djpcjv ixctsvb rqsntv fcqz@agezraf ezrfaga pftdwrk slsxu axw@ezvkn smwko utdlu nizby@ygl dwtrpsh qzz cuntrr hdrn lujcx iwc bll qvjhg@jrdrvj ledrjp noqx igodve odgiev@zonvzgy ujnzj ujnzj zonvzgy ckzd@rmg lmib fdn nfd gfobw wrc iro nsz@acgxvh sdn zcef sdn jvgnmhi xitkqgy tbascbh@ykuzk ovp mikolx xxgpylt secuf yrtilra wnoypy mty lmnagx@wwmlins mxwye kjntv sadc wnvyoov rzdawl@ali ncsrq tcbjzpu oiw iimxlbp mwi hdvdl dqnicf lxit@sql vywv vycj nprzb tdqe qwvljm myhpvxy hdixbk ywqpn xvue vrno@etncz etncz czqw moz uaxbtm axlslow fhephy moz@wsriuaj umjkx mhxau luzf wmo kyx jidl ufuoz cbk@msfrvbt bxnd msfrvbt yut qwbx@rhag vfkqf rekoz buw qffvk wxs ghra@meignx dhdu xacg hmiqkd nrijc gcxa gwap lov ybtyr vol@qoqns swib mlegyjn ojdtt tvdrrhg oetg xdret nzpq@ntc zowllt dwiyht ztdeifx velaumx jfxxsqt uefmb gwn@bgykxl bykan tvvgcpa wdcsj coonage hpocfz sqmihw pnagv uozsh@wass vve ngyd yyvxmsq rsaypsa newxyc adqmbm xqsvymy ygdn idysq@ybo vpjcf tsbpc hcdszr qrxwjqr bzz tgjhkpu hgtxkt stpbc woro@ogszrg rszt owufa cohmv msygfw fud fzi lhts sfiy dfu gxsuj@fclumcq ejuj jkbu hbsv ythmpoo xdzg dkvrdue@rbf sunzzl sokgih rngqli xndnuj rbf smiea mqzpzb fwpcx smiea@uuuxchs uuuxchs fzna qlj tcjnv oghk fzna@zuiyk tbn nqma wptoecs xndgbqm mqan wmcahvm qpir@ztexf pqsc icxqsuf tkgr itnn yorg oyvqaj yoxggqk lep@ehm hysd jfv iugyt jyvh@fenjp zjtvvhb xfe dgxoah ljn ixvdyi fenjp odnlr@uosxyy euicgp lrsc euicgp mcszotm kvxrpk jfo oxu xyeiv fhdwl wbw@tsmdp gshgm kpb tlx kfznsu gglefv pkb gcnydo eavgrc rgd lgefvg@xuq svh cmzt bxxlvfm rtblxpu imuexhl lbre hqyedxa hwkgaak@hhlfj mlrdv dlsn zgcy hciiuzw uwciihz iizhcwu gwx@ukqoj kjqou hlk nfyz lusf kebvmrw ccaj ewmicq useba@jlnnl jsmox vnw ucr ggithr usqe allzc pfumkkm jlnnl@mswpbk lffjwq icc kef zlba uolrrl fqlfwj tbc@bfmra hdgczrw dgmnod afbmr fnczx@dcqrso cgbymsg jbx ofpbp rmtygip syly@yrmn wzkt lqys tzkw sqyl fxoc@wal zgjy cwnqyaf bhz dbpft owx@xnrautk dlsyot nzbohog xmzsbh soec wyy@kde jpkvbs eyzw ukgiv ggrtzcd vikgu mxqy jyh crdtgzg ebzet@psg jsykdw drpqzl qzqbge ldqpzr wsdykj lmhbldv hbognjp nqej fmxoq guuf@ueo ncedaju ijasprn rvxb mxkddl qvgdlbx bpj bpf pxewuf chvo lvrq@zlmg eciyqi xfbeoq pupyrc bfqexo ituqab pycrpu@jsk clo vqxzl aja jfbce ldov@muss tzg iksvdej zpw fxwhrv eeye fxwhrv@kjjd dzf zkppx qdwlx irudds kjgd pdrz rgogy qdwlx egx rjxldp@szjpf aouvl ehxq exqh@nzweop qlkje welkfs jqmvqi coc@ivmjzk usk auvmc vvcnwn qubihx vkms fbt udn uyto jjt kxqy@rayw ijaklcr ywra qkj qytxeh pmnfh qffvsft tyxheq@pea cqy tkg qidvx qidvx pea skgrndq@iijm xgwq zzpskl qtjezqt yqjwy dhbq@dfuv iqw iejb bjei iwq@ogrmldp xdc dcx cqhbwlp@wzwb xrjl keciql ckky litdr bmurdk anjs nyggesn ygwt svmee@bvkkzj rcr lozrw mgpwkm lwm yecsr ykl tzny aeus jmq mchopp@rsnvaa oikce angqn rnvsaa mhc@hsiov kxqpxtc rzh vjrqlx xxtkpqc wiunol qckxtpx@aosek lhi ruqgd rmr@agqvlao pvhcgz esw kwnpefs qsrvxz hgkgrs mpx odaiqi@dvqkrzf dawioo jtaco oeutol ravp apvr frjunad@wss nahhsh pfwgcfr rvvvq uqxxmhq qax vtrkfou medfj@imdyfc sez gve kgtryl kmqklg@crmg yhkpa bsfouax kyttpa who mcrbzaj kcsktxe yfv@zpw zlab pzw pwz okb@fgqlb byhkhfn qglfb ladle ifa@skr zwwjnr iub wekt biu jnrwwz@mpvt mpvt havn ztf@odqhd uxrswp ppj eztyj nxzwm fvxyadn tostwy odo abyp meqdm ktqkvh@fgufup uabd vhxem imto imto vhxem@vrpxxhi kii zwatqg nokg wesxju xplc sumte muwjj@nsse iquhoc giuv pxaa qpqn zrfk kywjr spz kgzc lfa@cjjgarr psvwoap ivijyt nfbxu ktiuy jajrgrc goyc@yrfzf wyxda gsslsy oeyve jczghf cbuwf iwnu izyrtho dyoup toizyhr vzzrr@bwqgxsr ufy cnouypd qwxbgsr efdkfe rwsblis bhvyws oodh@piqpez yhqahjp oxu qtomld@vjvpnwy kajjaim lcxmbyd fkdy ywvvnjp xcn nbwlklo@qghq mihdp vuv ocrzsw mlmkn rgnbfcm qgufcks btlulb effsrih@psazbfo vbpr efcspj yrjl pqjrfe relxjc nzzvb yviuhc@tbbhdbm uxhawtk bmdhtbb rqxrr pspjzx krtmf pnaz srcej rsjec@owikzec glvbqy jhknyuz jkaxu ldhnlpx wdp@qvuv wteohr daynue nehs gzqu porzrsk cqokye zzsbqox rqh ogxtn pskorrz@gnm grlfoon lxid isxa@jes iixswl umgbg qfixa xnecpns asm nopsmo axaopsm qahwpqd@orr auvlruu mqq uurlvua urauuvl fjrcuo mqht tkdgps tdvnhvq iezdv@txwyzy zzwk bzi etfg gtef@qyydr lllgosq qyydr lllgosq@xqm uyl ldpowm pxhi ievvvez hmhzwmr ldpowm jaw@qlvfq efgivhr rfhhu gvw bxgsrp sgbnjh ekgbp cyof rvghph nxfekia xym@lgladv ogj cir jxx msz fshf ayheu wpmke zckng vgrlv lxgmge@fcmp aabxdp hpxbb bblpy mpcf eju pnkv jxwoy hmv fgynps pbdxaa@jcrh dgg lzyiv ojop vhk vdb uinoetv@utlzcf ziizdo njffmxe uhyjxdb cztluf yjdhbxu@ubl cgz tyg nljl@slwe qaos ybcwdoh ogazkj tqh opggnzt ffrscl opggnzt izeh@evitfwb jpivmn dpnxzuf gdkx zprogl xehb@dktt kpnkizb rreq gjmosa iekdtpj rcxk eweawk qrre olv@cmcw vmw mujx mujx ypqfz@nzxcl fzwa ftcrc immendi tmxzzi hslye eibc tmxzzi@abfc jdqvk lichxx uiomtz tlq@mnkthoj nohjktm eued izmcjj@ullh wju bxfsif icnrmmj qnufw zubcnmo yewz phovhv@ndfvd gcyt wnm badaww twm jahlat ndfdv mtw xrq bechxx dnp@ceg gcxgu gnudeib utsynwx dpg wpsnp ahbbvkt wpsnp iou@wutcg congyz erkj ibtcics@xsbq lyycse qbsx ppgutls lroo tyor@hfiwoy hclhl gcwgqox ogo hlqr ultkaz yke iwohyf oog@bcl nemims udwkmlm nokck tkwny ulkihcu knwty pngamqg yxtphkn kuihlcu@nwsr enrutc eqcfb uxmdgju rfnzhsn tzk vysc@wbtki vjmkk kvjkm ibwkt sckvbv@xjxnow tli woxldj rotrtz nfkhcz ibh mla ybxldg@cwtpkhr oxywg qpwrgfm dfjpfuc kpcopa@byczby tbfkonk ytlczzf bbyczy@khuvrne rnamlgt akjtu qlx odr git xmiazr icwsxsq@jfm bneh tkdzuad bsr oruvmqq uauw zjlp gwov hot jkjbex@jjo uvk vlpy lpxd irntb uvk ehhsqv fxhvt jjo fpa@qrwu mgnw hvflf ytspp mco ikvbqg fflvh wts cbbf"
	Set tValid=0
	for i=1:1:$length(pInput,"@") {
		k tPhrase
		set tPhrase=$p(pInput,"@",i)
		set tIsValid=1
		for j=1:1:$length(tPhrase," ") {
			set tWord=$p(tPhrase," ",j)
			w !,"tPhrase: "_tPhrase
			if $D(tPhrase(tWord)) {
				set tIsValid=0
			} else {
				set tPhrase(tWord)=1
			}
		}
		if tIsValid {
			set tValid=tValid+1
		}
	}
	q tValid
}

ClassMethod Day4P2(pInput = "") As %String
{
	set:pInput="" pInput="oaoe rxeq vssdqtu xrk cjv yaoqp loo@mveua dogbam szydvri hyzk lbega abzqw xwjn wniug kwbre@npaoy uivpxwd oynpa rcdk uixpvdw@yserir iikzcm ieuroca iuwcfov rvb giti crdpdcv mxpps@spyuhgo lucasl ucllsa bymnjig yflbv nxitmlf@xlxyhwz xla mpye fvjegwg fezlfrt inetrh vhg xpvstx ydhvq@xgue cvtmh myg ontvvyw ygm oqzrdrw@srdfsjf dli kccb kauk kauk apa doefc cdffkhh cdffkhh@msizb elqiov lqn epamk onmnlst baawab ncafwaf jrataml iyzhy svycuec@wdzqpcn dkgdumv wdzqpcn qxdmwib cjsigi bgcihgh fmua@kpvbzf kpvbzf svyq flg shwtgp@ywrynt cesjtgk hsvitr brpiul lxgvvrl cesjtgk cesjtgk xuflpfn@tik mrpht gkv unqp wypscc vmwiu ldrigk okbc wztc@zpy kyzvijv bilpf etbrgk edza vuz jzgn@yoa rgppd kzpopd cffjk murcb jmt raace iwt@aobgkja drc ztkd qskxxbv lve lev rhhoqex bmd eolf ybxjr yiiut@zhjcfms fpabnu aozp delsc mge yqi eovg pwefafe@gukf iys qztqxz xhsssz pfqq slg jdbp pfqq yabztc asow ygh@fmr ijgmjrc zbhwsmx ylgccz ycydcyx hjjset@zybsr iqisbs hffmij ikby lwufzvg gwd@ruk rku kur ydurp upmebe@baqide zdijcf ezqfe ovrldez delzrov szimd irmk busim ppv zepqk mlwpl@bxlvp dxumme byaada cgyn diz@xlxr jhili bmcke nkl vuhqsn lxzb zmyuxgk qcqr tyxe@wvth gyerrd yewrta kgri yewrta@fall jpyuusu lffybb ivmtmzx alfl yjupusu@lzvcg xwnt mjyiklh vwlz qejj mjyiklh dmcwq qejj@vgutb smc yvnsbgd bxmjd qmhia krxz luhgg emnrp@uuvhtia aiuutvh brstbr tsrbrb@howd japlq lhk qtsfdq htfufj qkyywy anxxxqw jtmryw cdtajh@pksswl jprpccl wpklss yyrbo@furp pfru bftha iekamfc bixwmr sslovex@nrqobo hyb byh hby@mugix kzlbtuq hmju ysstccs hmju btsuh@hsrlhw zilj jtvto zilj fjq@lvol xic hqqdeo gmsug yqe wue vhmrq buj juv wxexdot@lqeybb odpv mttm bxqy vqbqr ylbei wyjcxco urufsuz kyq@youbiz kvrea xsfcp zaz zybiou earvk qpf@bowsref ooobtic apiushu kplpyza@hxfhoyy ybbe ceebt recegzz ftnlv ukaf gpvx opvd lqnvk ybbe ygnwa@jpbgc aahm aahm aahm@qyvheb xyb elt oaksuj dvgpmel poiowc ykgbgpz dxpit ytg@vgsv yrjo vjss kyfvim izwo yrjo vgsv@hkk xmqx crlki dtp nuh okef okef xomktit viia nuh tplhrx@bmkjclx sbwe bwes bsbnqd nqbsbd@gfwrl vocwln hsuxkz zpclb qprrvlt bkcluvs pqy sxucrla npb fensz@adjklj nyr btmav roxv jrri vqfnis gzsab ogskmaj@bvjm fer ztgfx mtp vvhps hptzrar wpy yhvmh qklfwpf edgrdts vmhhy@lngra nrlga xokqu mgq@mksdk bkkbfsq hazlai nixee vyxh hpvebeg jujoqe wkw mzpxixm@kxrkkx qivtt xsm xsm rqvgdjl jilosjs rji@xiqga rez igqxa odiilj izoiwf xgqia@aepioo krcr aepioo jhigtx krcr qubkv jgo zybyvy wbsguz@ntyscmf duwvvb kga xvaypk sfjlg daguzm kqat otj zmnki@ggxaery jazo ggxaery zevobo zux wfnd wbyd hmhmo oaakvab jsimsw@vqdnvgy qiex yqeweds yqvdvgn iqcukgc bvrc osi@esjzak krwe ivbri hnbah iuvb begybsk ctxmlym gjqi lcscum@hyxdilx tsv evckza bdbscwj jlihiqk dciuj hamd dqsm ydihxxl@lurtwhx ygwf pwhj whxtrlu zfvywxr gcrl zvl wienpqb woto@mfaektr ocvho ukfx ukfx old daqwotk pybjtiz kumkiq tmql lqou tmql@guwy ceqsyvs svteymr nrovwz tesymrv rmsveyt@pigilsu zpyiohn zpyiohn xzl pryi zpyiohn ohdz@pziqfg hhrzdr wxl zpqigf@psnmnxz oed edo deo@tkdp tkdp auozn tfyo wmp jtp wjyskeh dag ojdvw gbptp deiqi@xkr nmsbk mreiv occcvva eca bupc gvaoopu jdhr flh ptgdumz mks@dlevn vmwzws dlevn dlevn@qwx qnuqgc rtzc yvym sft wxq fhv fts nyvrfxz ydjvcq tnwz@debkk pullndo ezaibw ldnloup nllupdo wiiw nij@hng rpd aud epq opzjh jnzge@rmtauf nwinyl nwnliy pjzahm lywnin@cgiv omva fos irse uytiqu iqjo riplx capa dhdl echbyjw cutfam@fqrqmi jfrj zllh gfhhq fqrqmi mmyqv@yoepae uabuxlz jzqy yoepae sxena jzqy@bfr jlrycal ndg xejwjdp khwg wckevqb tud xljzem ntfbazf lkr@aomdwt sji sij jsi wlsvvva kgjzqj whhf@ogorbil orlgiob iorlbog xapwiqs jxb@tnn sxgdikv ynick ynick aumwthl rwhx eqxd jdbzyk kbil pmnifp dpeips@vzeoilq son olqvh jawmny@vsifce kcighpn mubl zkgwm@ncagxs ilohd lyq oqhjf nfeij qmtvf qpru tfmtaj@pfjkcpr dqrfde efqddr edqdrf@wdyygax hscx ptmro wqko ecnfkhj ywui@gdv nrnrzdc vyq vyq vesrj vyq jwxg@oqhrr daoew zpoduh zwmoss nfkh vubf xza kju rhrpt fvsc@oqp ppyq swvin mut uacwd swivn ucdaw icfj ldcujh cejl@dar bqp ajdhuej sxwt bqp tppexrh tppexrh@sitplaj xnb ldopp mqd gwtk uhnvozu ljz dqm ylzy qltf gwtjksx@eqkvncb jdp pahwje avhrer awb zqnwfhx zohmcz fitbyab@xlnel gjzviy cndpuoj jvwxs qsd kwli quisju kyoix imzg@czqjkk evyima ixpelbv eobpd wwuxxof pbxc dgj@czsigs lbdaynp amsexn aemsxn easnmx rsitdzf@xdpc xfbp lrjwlo ntnnob sbe bse@suud fws zgn kvfimsi@wnexa diexvky oemdq uasxzhq qxa kevyixd lpw unluohs@ylruxt beqvn vbenq ogsov mvftu sovog gshtb qriaxko vthgfr jwj@gmz wcjb cqjlb hijz qwuluuf xdpu jybdf ajiv xizwb@fcxos spz idg rjb uhr ert bxia urh xfxp ixba bnvxy@uxiie eixiu wgmwbj euiix qknyd wtaojk naeqfz qmhnulk uscgwxa@qwyxd jno xelqd isdjht qxz dbwnr bfzhewu opxmkgj igfiuck@ljpphwc ijzic pfsemsc mfedoxy pad wsk beqjpbj gbjr imce xumhr@causc ogypj csacu pdokc itpgjl xfx nyt yytg srhrup bontz xbalwnj@asohjj qer pfgwo qgdw wgdq@gpzvyhh tsnx tyu kswlgb whju zkkpdm bmh hdov@unux lhrn unux lhrn rxr@epq ksew pqct jib pqebafk jib pyfjy gnu pqct@anzbbs oyhm moyh mhyo@dpk zael zael mxots zfcum@aehljyc wrj lfhife xbss ztszba vlg eljycah ihffle coypll@aoqedco bogk bogk aoqedco sanwwo@udmbz yxe dft rzolgtp nwwjpti@efu qcls rtx mestnqt pkh ciekj scrv uswd oroowx lcztvt@urnwt uapni ood lzce@zjiqxt jzqxti infgde xbmi kawilp kaipwl@lsfn kxfw zgzdfq meqwql zpqqu otert@taajsho gbeoguv bpi nxeuy@dpoyzi rqlzx rqlzx udhuwjm qnu bnuma udhuwjm gfezx cbjpfp woir@mjbv isni ixjtjue fwsk ncgwpn vqnmq pivz jbmv qoakqou argval dacvksc@xxjcn amdgdhh iup hlk xxjcn elx@gyhocay ofqosv nldfqay aqu dsrz lmekze bus lmekze gfoq lmekze vkor@xidyqq bimvxu zrkg rpcdca ymg nmxkkqu gygcmp euemr@gvd ywog ywog gvd hwjzzq@byu ggpwrl lpexjcf hgy jee febgcae valcgc tcfwicu texqi lxfjepc qeraxcs@lkjejsb eonp jtsbps pfvlos neop ikwnb avzxnk@big pjgttfb eetr jobjfae odvl jheh tuz ystrh tuz tuz ige@czubaxq czubaxq pbxgs jhuopn snmhhc qwmcka xdhxfuz jhuopn eummw@xdwduc sqcano zopaco ozbbc bczob eas cbbzo@oanpgo tiav bbssup ttzchih tpb xmfnqwa ghdx uepmz fzqbx@ahha zsbdq jggv zfcjdp dzcfpj dkew jxmelbf jgsohj oghsjj@awdy plulzw gdi jiiq lod rog mrf uihaz sebk guvb@tlhwro sapaws ovlbbfh xctruk spzpzm latyy@ligaot xfhacs jvk xbnpu yuanx yvvi gjek@nfwuug nxccj dxpfvfq pvxcvy ayss lfwz wwole ewowl xceybeb efs zfwl@lzowlql armo yrlgfg kbl vudahci yav evdi ofak ysmfjk upe@qtmmqrl gxi rrhbi pydbopp yvevlq ovwwdrt mrppov lzzs yjyrxh srzo@hytkyas wpuqvf fftiso fftiso@yutais qjdbzo kewsi opy ysl zyvyoty wkp@qtbad bxfjkwa stcdk lyre tabdq yler@friyh ivp hshy ksmanzq mzdbbub ncbx mhzki friyh vyjk hshy@ijeysr aww evn ttqvshg xkd zjy honvuqy zyj quvyohn gphcir@okft smja fkto etb@pbi zhyy kyjdho mqsuyic vegocmw gdkskg kgavjag dbqh wamfijz ktihnrg@csqix soz ingra gvslgk@ugxgzqt pdn hiynufo lpfabmi rmwj uhsqoo pmlzad ferdup guzqtxg voxd@wkixiq vck vck sylv ttqcbwv ywqta vblz mhohx frv@phns ozeghgm dfodkyv iyc psnh tedotyz xqz gqbyj ydttezo kxgju mvip@chc jdjo pyq usyn vtrbnq ohnx dsxpdzn mgbc ysun mlalmu mqemyuw@qrkosx wcwcv brvbwo nvxwg bvrwob@bovt gpb rwm gpb pitttl rwm rvfzn tbo@zczkb tmpwtj kackkx yzqkzso rsg ema ereo jptvfd jptvfd flbjfii@fcdyetv jqelvx jlevqx cfvetyd@dtyp wfh rxtpwr nolbro iozrs mnshu tkesvyk pkmkf@lvecoh ohpb brlqwx immgqe dzfac bwlrxq hng clxmpd qodfyv@sjbc dsoqk dqosk iyla lqzrsgi tjgt mfxshtd ztmc@nxveg vmxf jwnub kujji aqkonjl xtit xitt@jsft pmojruo vtvjox wimrlhj rezqi rnv hjnvdka@vnl vzgltnl mry kkqf fekwjw knsrvt nct kqy infvys@jbvm igq gvcl crry ylia nbqcq ouduen jklepay@ermsf emrsf uksuvz zrnlun@ecksf dkydasw wddasky pmfhi yltmedt bdovedg vfnyoze ufcki civrjs ohozga@hvf gfqgc adbeykt jdz zmgonhi yua kifxyoy umsza ivnbvoc whnpi gtbinze@nmy fsdu myn iiw@yrkwca jkxc yrkwca yrkwca kxqtvqh@ildxc taopx spykdz dzbpcxp wzgka cbyr xpvrzbk@qqp axdmvo cmppp shx@uldyu luyud uduly rgcmugh@woc vjdpyq cwshqq tlh fzyuz cbwgp egpy sfw@adyv cnrn bhaxvx ofdbkn yxrtir cnrn@ycz ednsydc bqsdcpx adnq bydb tqy tqy vqzpy erdcnv@mouv ouiy gld stdv gwr lxlfq gdl ldg@gtx bbvr fxytm veofwp bvbr opefvw@pcf scu ovso rawtjxs kzxgnuy ifcn tvibap@ugcbob xkjgtx ugcbob ilkkx dikca wpxyq retqhlu ugcbob ylmt tigcmmm@gmnde ool qeuwc ctux@wpajwn gooy fedmjur pxiq xkyniyp xtgi eyfpc gjx@uaivt kvfyn mpsya qxu kvnyf wvoeaz mbt fkyvn@jth awxbprn kpcodj qxegybo@sfvitld mdzczg pdptzm fmz himb eutpyi mgrde gubsta tfsldvi dfistvl@piabmr fckmhrv twnlnka jyb selqflm iwcutk pvvann@uxjfm rmleg ochuj ruiq aobxbb tpuusot uhwjojw tutopus@dzj qdyxzk oan rtpz ona qkdzyx nkunr@urjydh dfreifg tmbetd aakc vdr dkdkldw xgvtfsa ivv doadb axgvstf@fdjhr ujgbj ulkm dfzh tmhx zfdh ckt ortg@obe ywwge rgqmt cfcnyt atn fdkdrwz lmb zwpe sqfoc yllxs akdlsso@ckhbu jfqhkml abenw ckp xvjy wsyhxox jzsz hqksq@tjx zlh zgyrjpe bdorry uofh hgkzl ezixges kaxlkjw ztijupu hlgkz@belj ipbygk dxe cqoyukw jnncelh ihvom qstbowu rocqsz ifiztlf fjrf nsit@vyswalv reaqae hzoqyun lbci ibqfljz cgjflqf kos@njrzfvu nxw nxw bdsgnxp@gxlgn qrx nspbvl pzuob nggxl ipak wjr lggxn zas@xkd sooef fsayaob tfsiyl@ecldvh jugto ghfpbev xzlc@rpyattn spb ajdplq eaorgi ackirxg knrap cobdeu qca pkp zkc@bhh tczwffg bhh bhh hrjx jwyu gry kkgghnx@zsav frsakbr bvzd gafr homzjw frsakbr yasgz homzjw kqa@nbd mekhfif mekhfif keuoag nbd@mzv vzm utuxhuf uufuhtx@siy tdbii qtu yrxar ruubale yrxar lsvnr yqxq ruubale@wstykuz fxnuszr tgmkw eovvrd ohheh raf degh hzoeun tiou wpt cqnw@dzbyhrv vzlbvn ncoa xfglcye ncoa sykfps ghi@lvi ilv xalhd ztejzb@zaeu diz zaeu gtdjsz fmoxgju diz uvh@zef lmkqlcs jnhgqww qsm fuatcq ixfa@wgp gvu rpmxrjh yokepvc yokepvc lywdl bbvvbf yokepvc@etjfs gjh tvmxb agovg yihn rmmh nue jfil@zgcco slios jbfodb wpthe ydvit regizw regizw qosou slios cto jfz@kmmq lnafaha ddos hrsjtxk zjch rfynx eovks@ezeuzu jfpv oinrstv vsw naoz enrcy svw jfvp kgmfwf cfisxzo@ljtv watps equf ljtv equf@axijki zotolsi ryqujrm xmhug fhz lkgaw umzokxh ktr jsdsfat trk iosoztl@vpqvvvn ydjz tcqc asffcxr rxb fyt vyham fys@agxrcxl obcncq htod ved ozesk obcncq iwqmksk fsijtg iidyy lxu ozesk@orsyqt otqrys pnaax qtrsoy@oyisc chu ahdp abhbtry kjsqve tkpux tkpux sxzu sxzu@wquw umlbwf mxzdbvb upp fopxe aub bau eritni punrpfc esnkyg@jjlzy hozskgo jjlzy aiq jjlzy sgfyhsd@ejghc ejghc ejghc igacslu@unzmg fugzotb nxkdlds ewn hydj fbr iuly oiwwkbg scnozau sfi dsishk@xuhjduu hfloaga xhuuduj mbavfkd nrnl ral erc mntev elpoqgq@seydro onpi qjey skgkiox fbdgyt xhr rhvz dpsjcj tfzd spjdcj btqn@difyxz cdm jlzsz oycm txyssd wckqshu ihya yjyb@nmrhlif wcreso chtqfov qcftvoh lqp egd erc myep plq cjdh@hcnwgkq kkrpxxj gwe xqgea kkrpxxj nxz mumqbw kwxhlz kkrpxxj otqy@rxbioyf cszah mhu mhu mhu@qpbrf jzink ojy idt nrjykzu@omnrq kkol dex eaqdmej dnpaum ynnntw ddwewsh ztcenhc zqdrq hmi@ngmqpu owmcuz gop gdbsfc nyott cdsflq ngmqpu@srus lrexy aqgkqvm tiyjm@wxa qopky glaaekv ykopq lna gyxvpx xwa hly dbvo@vqf sqrqw phxn xiw gejyzip ugg gghhugl zyqae@ylj cyolrx giim yrchuu yrchuu ylj@rixa yfusuqn yfusuqn yfusuqn@lpm gboakz ylyv gje yxu ahokxb ixwnpu hlcka cndhbbm nkmvts xdtqbc@veul zjvz regtyp njwfpm@pdlyjbn edawa xbcmyew gme yuk yek nfknzgn ehjz@rcgun ulv ntbwnvg ptf givapv bych gmxxxf iajqpb gwh ipavvg@qvpwk grbb gptdgrh sij vunv hsb uegsmt uos vkxdd@iun aagzlj elqcq vkrk awl yyt dxfhkwq hbkeht@cgf omofuz zddgwef iyosk hmou@mvjorn zseyo wpfjlac kpxb dlh ggo zgxoso txzuy jfbmv lacjpwf vha@twrsrw pxv iklzg rtfcl kfbcjix uyvowpa kfbcjix ofnsf adqm@qvi ivr plxfrg awugjh fxbv ztlljk qvi jdkfts xyq jdkfts uqwgdr@phs eimuuf lmxq wmp@laf gmuowr rplgkh orentm whor lkrhgp mjwr zapz mdqtqyq ttkfkf@fxk wdbl fjh ojqxp yvs fkx ysv ngksb@oclyxqu tpajqun vvmj twin zclk@srcwxs xiduxd tqpfc sbqybp sdtzw gizfn bpji kaolpuy@pfkmk olmsaz uffy uyff@crpazh pcrzha lew lkhcjij stfxq@nkbb rnlo icnzg rnlo ejanu mofx ujblud@abte xnjfo boz fnxzid nqfhifm jmnmsgh@lvck nfll szdgrxc nghig szdgrxc oytahh cibk szdgrxc@sduf jgv rrt spxw fdus@gplutjv ufep fuzrnj tmko zzpj cpd mvtrzq@ycdiav qvr ycdiav tjngezs mphk oykgcei ycdiav@egbkscg ksgcbeg qmw jdbj@kbgx otnfyc agouh iai lyhqd yzihyq ouagh snzhxa xyxrgz@kdpqljx rin dlxms ukdzedc duezdkc ikgplm ffk vdmie qziajdf ftfwl@prrzhj okffaot tlrxpjd aquc dbonaef enfdoab nwbtuh@vyzf ijo cdhek bvlgxt kvldmp kvldmp vfvg@zhijgyb yfkkal utb brew vfj ztiftq@kodsuol ubnbdv iozwfum ayqxgnj qkp yiiv wbkgi psi wnfa epw@iok mecjsp lccn nrb kobca wkznctc afjjlrt@yrw yhsva hgx nxjfbb@dbdj vef xjssylt hjlld bqbmx ihfmz uhij zoh opzrmy mfq@wqhcq usyfuc wqhcq pmf aryq nhvtkh@nkviwge snpfdza nadzfsp evvdnrl qled ekqs qumle myhky@rgljws kjuk txgeein ajmph pjhdy pmvr upae yfh@vmepn wekgc qfwybl midbac vmepn ddqmbu vmepn uhfccp yuh zzz gnx@hyqv fud xdc bssziiv mwo xfrsn xqehs mwo@djhr qxhfy vdjs ueoi mbmwa lkeumzd hyxfq krbyy ywvcstf wdkum xfqyh@heprtex wgxpign lvm vlm ypswfxr ggxipwn hdszz blrv ppy@fwalim sbqj zewxcaf qjsb cjgujwr uclxro wceu wmaifl rnd@gmivd spncot jxeycn notspc nzb wie ceyjxn xlam@cfujai hfvux hhtwe hfvux oputz oam@gmwu xwthnkp xwthnkp mdxa xwthnkp@shfqzi hdq uyyqjrd wczfvy wciko hdq nuywebl@dtkq qnb uzmo ypxfja cekqe cekqe tnaibc uzmo pmtnb@apdz exdze pop pvm pce hywvftx jrjezgd jkajq jcdjli@satq czv cfhyca cshnyh cshnyh rcu cshnyh@mxp ujq fmrnzxx xqv mxp@nel whnnxak lwzlre mrxq kpo pko bsa gimtzwb@okssco iuke vcnv okssco liawwc vcnv aztl@kjvq rye eawplkw qzxt jkqv bxbfyv@bphssax ylemih wsm jnpxce jgh repsyj ieypbz asx@dwivit ptcwt qwectqk ttwcp bklpa ivditw@ies knj zemmcto mczotme yanr kjdrwr mcry ndols@dqzdpg adb ulsv ulsv qux ppmoru sjcn dpihqz@akazkk kssdguo cgigktm indfh wwh kevuhv dclpjv kgtd ehjxous@spogxy jyzhag qumd brk cbu akbpjxb spie@jgyn cxbar axtkwh hktgcm cfsla xll rpauwl cgpziuh dyc brcxa@dodey dysnjxe kzmyytw tzddd cnupwmv@nqab whxkb kvc kvc jcjhywy mbbpfwj fxozlt whxkb qwz@ihmif xhjc lmfk yjrsioo uvtd qvtqsgt dqd@uvzedxd afli hkrigd lkzkzu ncki toam hoaefui@zmvywjv jsjf nrbrgt mbs yog eexuo@ukzab euwb qnkanyt lgeqf qefgl ewub@zbol bolz ilncu ciunl@hjryu qyl ajwju rplplr skbdsl xvto@ojfotbx zvta jofxtbo ejjnhi jyeiz yzeij@ivr pvrwef ivr zgnm jscgaoq hfjuzju cea hfjuzju ehszaz@yikp gul ugbniac jehm fwqxb hqbhi hlfr iyuuf vacrao fwqxb@plsjh efu napxwe jfxfjz efacqcp sythfxc sythfxc napxwe qncqc@meuf rcjzf mhluz kbrk tzjrcn omoiprl khs oyzad yuzbz@exvzzuc ckqfivf uoyidkg mwztyf wxtg uzrls gudioyk wfihpzn tdmwhf@qoovwqm bldswvy xkb yqrcluk qyrclku cluqyrk qgakbv urclhse@rmmymgg ytpqtuq ibt tmedibz tmbsdg ytpqtuq cxbnng@qkyeo frjjht vkpt ikztq avzqon diw noqzva dvkhwdt@opz usos kdqseyb cdxvve nahjc hbr rhsfm hcjna wnczls kky@sgeml uyaoe ked utxab hxqa glems wbdo kzrjsq@isp bmebt becira ixoz yeakj fmueu@jrd qyys cik bmaief zxllza rsu swvodiv ivvdsow ikpvwaj jdr qte@gzjjre tkjhdn lrqmvw gues ositymc xhfiutm@kcnble oxoh zggvo zjz auub kunoj snil zggvo lgql@yyfmd wbwmizs vmb clba bpzzjz nlt wgukoe hedlp osxz@skic mgcr chkj eiiy kdhch gcanziz dpecug fccp@jhnejy akpwbj mhrunvm wjzwyhe lwxostl gfe niuhj iuf bewur@nuursk gehzvck szm fllr bfaq ijpjp gehzvck bfaq@ecx etrsadp lyekp lxf flx tadreps@gbo wzkner hky ggoqu@yiitvf tyvifi xpnbk iiytfv@okpjxyq mmxcha pujgv ltgfdk wpporh bfle tuupth ukyyjgv vlnwhz@phbs qtpolnh udito ukx kjqsi jbwf sgkkwgm udito mwwb wihg@mces dhc qccy sxyilmb qmki dyqnr qsh aigaemz oofdw hbifiz@yyben jjklnz whwswg tox vgytp noijcv jjsa ybney eyrvg htjl vxli@detb tus rloz zymvmg zpe@usvkehi kxgvo rna scnaljd jmowud ipfkkf rxvpie nxysvj pvquagf fjhsvef@ytosun puwdoix oyc qdufuw ysunot@htw biy htw oxot oxot@xgzi nbq lxxtmt nbq lxxtmt fnzmmno@lko bdbj kcqvc torg enbfbj sbooco afjbclm dendwq@cgih ikmfn lyhzhxd ubq ixrori tofbo@glfhfzs gihsccj yic mlci slne@wdiu lhl hdlhzo voo yhqckcy axnz yqyi fyss qhvtsbc@aotbk zfokegh uax myhehay terwus hmzic fdwojh wjuwlp@ucbiex eigq qqe ifqw sxakwl xkwsal qeq@pknvybh qkrwi povvd phairw qst inklob yrryv bcuv dolvr okwe iexrpbw@kkah qrt dihygsm nly rblqvrm sxguxj yspmre@gzhhkjt uimif bssle vdiaa wkohq nrgboi htkojiw@aeb xihgva vwcjbjh lri nlwbxun sargiey uyekrc@fnnwfbj yyccaxu fhqb nlmwhc ymbqky ooljix mfijg ryykirn womn rygezi qsdwgpw@itfs udfr sitf gml@gknztly vay ypy jpid pyy mbpfmwz pfmzbwm qqec@bbhmw uus xffgd xcjzrlk kyecv zcerxe@ncpc otqzotf godtu yhcpsyw ncpc fbs@ggoiqm ofk pryqt kqdbo ktek kklhlju iqgmgo gqoimg flscx@gsgmvy tktzj kgi ikyz pthtk hxt gik@bunvugy fefqpkk juwk aent@atm tma dzyret jmuqke xbayiit jumqke@dilfw qws ldwfi lnujld ywrogk kjh adaj khmlb hkbml@veaemc xugf udpphf mydi jbvebgp ngyhly pufdph vbgepbj@vyd tisntn qmc yzal@uxdlc piw mwjnk qiar xwpspf sxktemh jmw@qhhvar pox aed bgwq doe uyktv pox vriy ndel pzx aed@tswei dtfb yhj krxu yqio wtzpm wtzpm yqio@bjzp zzp qdzdfv tzkbl nggbfqs vquqds xiud xgrkb@ffvjfwp jbzslqo ffvjfwp pchzrqv ffvjfwp pkd nlav@czepixn yurmsw ucckih qqlnxjj exipznc@xeu llc jnmp dmz pnmj stqzao@fzvu uscqp xerkzkg roivhri fzvu yiwae xguz ajpg@qdzk uyyoi cspmnc qdzk nwknfx fnngvla cbl@acg utwrv cahupdm xgat elb aemkf wmkdzj kfmae ahlrwu yxfcj@vdumh rcd rgc hpqk qeum fpgva qkhmuji rjxpuzk ommk@ztvm ntxkav ajv avj ippodg sukg bivcslu tes gdlrbnt bdlkaye xpgslef@aygsym pwq owxmx xjw@dkhykf pfqeyo lfq saoewy qldrky sdgrrcr frdqn tkfezop doo saoewy@cwof mqlscm iqxhb nnkex nxx glgpbn@noq zikmeyx yodahj ssu qqmifa plcbv rsahsd@nvc fuwiyq myv hjn rtuoq zoyp rqnt xchlrg@dziscfa nbzsuvp rbnrban cjdprp dkj zcry ckxtm@stpm ifcbmmw dpkpzo sot ydpeydw nusp nkciqa psnr@udikjfr foqnxl whq ojuspzz ddyz emdktzb gfio mnd hyb@vchdphx zkrtky ucyifqx ryzl txdixd cip aid cip@wcz ywzwpp viswpsm qfus uzopaq mhps sidjky kipvjg@wehhc rzujn urprwzw gkwzhk rhrpph xkzzl rzujn yddlb@wlhif foh rpvylg gruiqdv daih yflhbr coe yflhbr hvluddj@hfzi ffjntj fdth crkrzdr nyel nlxm cawze bfjz neixnw uygqvmw zayf@guthfwn kcinec glhaiqv rfgbi cbrm@mvqv lszqu eyjn suq lavyjbh ujivbza aianl wik noy zth@zkn ren ncoyj fppsy dwgtgqz til@ybxepr hrzcrxs zhrscxr uvpxxl eprxby vzgg@xhi zess zet mtpcu ibz nkwq cbzb etz kjjcns@kvmu rxgw xboplw enlqcxi uxysl xboplw kvmu oqxislh xeg qwhdc spsddge@dxaao ltjjn cpsvnxe core aojgu pbss nudwi@llro yoy tixzyc beim qirnb lffcr gzm@quxetbf gfpll gqyav dckhp xbfetqu xaebz xuqfteb@fblkc hsydxqt bvmwujr rak@epeohq olrwyft cmrvov fbdyxbg@uzqk pkhizw jbrnlvx aqkq mtmjmy gpcln gaqt rinrz gwis gpcln@ttkcu ttkcu mcq xao lhnxdph djj ylet atdln xao@pmwn svqktkm isopar krrfbna knrw kbm zsohxrk xlsmm knrw cmoikq etqeggc@undrw issrttk mcoe pvufl bwjwqkx jdz undrw vje@kfzqbb djpcjv ixctsvb rqsntv fcqz@agezraf ezrfaga pftdwrk slsxu axw@ezvkn smwko utdlu nizby@ygl dwtrpsh qzz cuntrr hdrn lujcx iwc bll qvjhg@jrdrvj ledrjp noqx igodve odgiev@zonvzgy ujnzj ujnzj zonvzgy ckzd@rmg lmib fdn nfd gfobw wrc iro nsz@acgxvh sdn zcef sdn jvgnmhi xitkqgy tbascbh@ykuzk ovp mikolx xxgpylt secuf yrtilra wnoypy mty lmnagx@wwmlins mxwye kjntv sadc wnvyoov rzdawl@ali ncsrq tcbjzpu oiw iimxlbp mwi hdvdl dqnicf lxit@sql vywv vycj nprzb tdqe qwvljm myhpvxy hdixbk ywqpn xvue vrno@etncz etncz czqw moz uaxbtm axlslow fhephy moz@wsriuaj umjkx mhxau luzf wmo kyx jidl ufuoz cbk@msfrvbt bxnd msfrvbt yut qwbx@rhag vfkqf rekoz buw qffvk wxs ghra@meignx dhdu xacg hmiqkd nrijc gcxa gwap lov ybtyr vol@qoqns swib mlegyjn ojdtt tvdrrhg oetg xdret nzpq@ntc zowllt dwiyht ztdeifx velaumx jfxxsqt uefmb gwn@bgykxl bykan tvvgcpa wdcsj coonage hpocfz sqmihw pnagv uozsh@wass vve ngyd yyvxmsq rsaypsa newxyc adqmbm xqsvymy ygdn idysq@ybo vpjcf tsbpc hcdszr qrxwjqr bzz tgjhkpu hgtxkt stpbc woro@ogszrg rszt owufa cohmv msygfw fud fzi lhts sfiy dfu gxsuj@fclumcq ejuj jkbu hbsv ythmpoo xdzg dkvrdue@rbf sunzzl sokgih rngqli xndnuj rbf smiea mqzpzb fwpcx smiea@uuuxchs uuuxchs fzna qlj tcjnv oghk fzna@zuiyk tbn nqma wptoecs xndgbqm mqan wmcahvm qpir@ztexf pqsc icxqsuf tkgr itnn yorg oyvqaj yoxggqk lep@ehm hysd jfv iugyt jyvh@fenjp zjtvvhb xfe dgxoah ljn ixvdyi fenjp odnlr@uosxyy euicgp lrsc euicgp mcszotm kvxrpk jfo oxu xyeiv fhdwl wbw@tsmdp gshgm kpb tlx kfznsu gglefv pkb gcnydo eavgrc rgd lgefvg@xuq svh cmzt bxxlvfm rtblxpu imuexhl lbre hqyedxa hwkgaak@hhlfj mlrdv dlsn zgcy hciiuzw uwciihz iizhcwu gwx@ukqoj kjqou hlk nfyz lusf kebvmrw ccaj ewmicq useba@jlnnl jsmox vnw ucr ggithr usqe allzc pfumkkm jlnnl@mswpbk lffjwq icc kef zlba uolrrl fqlfwj tbc@bfmra hdgczrw dgmnod afbmr fnczx@dcqrso cgbymsg jbx ofpbp rmtygip syly@yrmn wzkt lqys tzkw sqyl fxoc@wal zgjy cwnqyaf bhz dbpft owx@xnrautk dlsyot nzbohog xmzsbh soec wyy@kde jpkvbs eyzw ukgiv ggrtzcd vikgu mxqy jyh crdtgzg ebzet@psg jsykdw drpqzl qzqbge ldqpzr wsdykj lmhbldv hbognjp nqej fmxoq guuf@ueo ncedaju ijasprn rvxb mxkddl qvgdlbx bpj bpf pxewuf chvo lvrq@zlmg eciyqi xfbeoq pupyrc bfqexo ituqab pycrpu@jsk clo vqxzl aja jfbce ldov@muss tzg iksvdej zpw fxwhrv eeye fxwhrv@kjjd dzf zkppx qdwlx irudds kjgd pdrz rgogy qdwlx egx rjxldp@szjpf aouvl ehxq exqh@nzweop qlkje welkfs jqmvqi coc@ivmjzk usk auvmc vvcnwn qubihx vkms fbt udn uyto jjt kxqy@rayw ijaklcr ywra qkj qytxeh pmnfh qffvsft tyxheq@pea cqy tkg qidvx qidvx pea skgrndq@iijm xgwq zzpskl qtjezqt yqjwy dhbq@dfuv iqw iejb bjei iwq@ogrmldp xdc dcx cqhbwlp@wzwb xrjl keciql ckky litdr bmurdk anjs nyggesn ygwt svmee@bvkkzj rcr lozrw mgpwkm lwm yecsr ykl tzny aeus jmq mchopp@rsnvaa oikce angqn rnvsaa mhc@hsiov kxqpxtc rzh vjrqlx xxtkpqc wiunol qckxtpx@aosek lhi ruqgd rmr@agqvlao pvhcgz esw kwnpefs qsrvxz hgkgrs mpx odaiqi@dvqkrzf dawioo jtaco oeutol ravp apvr frjunad@wss nahhsh pfwgcfr rvvvq uqxxmhq qax vtrkfou medfj@imdyfc sez gve kgtryl kmqklg@crmg yhkpa bsfouax kyttpa who mcrbzaj kcsktxe yfv@zpw zlab pzw pwz okb@fgqlb byhkhfn qglfb ladle ifa@skr zwwjnr iub wekt biu jnrwwz@mpvt mpvt havn ztf@odqhd uxrswp ppj eztyj nxzwm fvxyadn tostwy odo abyp meqdm ktqkvh@fgufup uabd vhxem imto imto vhxem@vrpxxhi kii zwatqg nokg wesxju xplc sumte muwjj@nsse iquhoc giuv pxaa qpqn zrfk kywjr spz kgzc lfa@cjjgarr psvwoap ivijyt nfbxu ktiuy jajrgrc goyc@yrfzf wyxda gsslsy oeyve jczghf cbuwf iwnu izyrtho dyoup toizyhr vzzrr@bwqgxsr ufy cnouypd qwxbgsr efdkfe rwsblis bhvyws oodh@piqpez yhqahjp oxu qtomld@vjvpnwy kajjaim lcxmbyd fkdy ywvvnjp xcn nbwlklo@qghq mihdp vuv ocrzsw mlmkn rgnbfcm qgufcks btlulb effsrih@psazbfo vbpr efcspj yrjl pqjrfe relxjc nzzvb yviuhc@tbbhdbm uxhawtk bmdhtbb rqxrr pspjzx krtmf pnaz srcej rsjec@owikzec glvbqy jhknyuz jkaxu ldhnlpx wdp@qvuv wteohr daynue nehs gzqu porzrsk cqokye zzsbqox rqh ogxtn pskorrz@gnm grlfoon lxid isxa@jes iixswl umgbg qfixa xnecpns asm nopsmo axaopsm qahwpqd@orr auvlruu mqq uurlvua urauuvl fjrcuo mqht tkdgps tdvnhvq iezdv@txwyzy zzwk bzi etfg gtef@qyydr lllgosq qyydr lllgosq@xqm uyl ldpowm pxhi ievvvez hmhzwmr ldpowm jaw@qlvfq efgivhr rfhhu gvw bxgsrp sgbnjh ekgbp cyof rvghph nxfekia xym@lgladv ogj cir jxx msz fshf ayheu wpmke zckng vgrlv lxgmge@fcmp aabxdp hpxbb bblpy mpcf eju pnkv jxwoy hmv fgynps pbdxaa@jcrh dgg lzyiv ojop vhk vdb uinoetv@utlzcf ziizdo njffmxe uhyjxdb cztluf yjdhbxu@ubl cgz tyg nljl@slwe qaos ybcwdoh ogazkj tqh opggnzt ffrscl opggnzt izeh@evitfwb jpivmn dpnxzuf gdkx zprogl xehb@dktt kpnkizb rreq gjmosa iekdtpj rcxk eweawk qrre olv@cmcw vmw mujx mujx ypqfz@nzxcl fzwa ftcrc immendi tmxzzi hslye eibc tmxzzi@abfc jdqvk lichxx uiomtz tlq@mnkthoj nohjktm eued izmcjj@ullh wju bxfsif icnrmmj qnufw zubcnmo yewz phovhv@ndfvd gcyt wnm badaww twm jahlat ndfdv mtw xrq bechxx dnp@ceg gcxgu gnudeib utsynwx dpg wpsnp ahbbvkt wpsnp iou@wutcg congyz erkj ibtcics@xsbq lyycse qbsx ppgutls lroo tyor@hfiwoy hclhl gcwgqox ogo hlqr ultkaz yke iwohyf oog@bcl nemims udwkmlm nokck tkwny ulkihcu knwty pngamqg yxtphkn kuihlcu@nwsr enrutc eqcfb uxmdgju rfnzhsn tzk vysc@wbtki vjmkk kvjkm ibwkt sckvbv@xjxnow tli woxldj rotrtz nfkhcz ibh mla ybxldg@cwtpkhr oxywg qpwrgfm dfjpfuc kpcopa@byczby tbfkonk ytlczzf bbyczy@khuvrne rnamlgt akjtu qlx odr git xmiazr icwsxsq@jfm bneh tkdzuad bsr oruvmqq uauw zjlp gwov hot jkjbex@jjo uvk vlpy lpxd irntb uvk ehhsqv fxhvt jjo fpa@qrwu mgnw hvflf ytspp mco ikvbqg fflvh wts cbbf"
	Set tValid=0
	for i=1:1:$length(pInput,"@") {
		k tPhrase
		set tPhrase=$p(pInput,"@",i)
		set tIsValid=1
		for j=1:1:$length(tPhrase," ") {
			set tWord=$p(tPhrase," ",j)
			for k=1:1:$length(tWord) {
				set tPhrase(j,$e(tWord,k))=$G(tPhrase(j,$e(tWord,k)))+1
			}
			for k=1:1:j-1 {
				set tIsWordValid=0
				for l=97:1:122 {
					if $G(tPhrase(j,$char(l)))'=$G(tPhrase(k,$char(l))) {
						set tIsWordValid=1
					}
				}
				If 'tIsWordValid{
					set tIsValid=0
				}
			}
		}
		if tIsValid {
			set tValid=tValid+1
		}
	}
	q tValid
}

ClassMethod Day5P1(pInput = "") As %String
{
	set:pInput="" pInput="0@0@0@1@2@-1@0@-5@-6@-5@-3@-3@-8@-3@-7@-8@-4@-9@1@-3@-17@0@-18@-14@1@-13@-4@-22@-7@-8@-25@-23@-11@-3@-9@-3@-26@-7@-24@-15@-17@2@-18@-39@-6@-28@-27@-38@-47@-17@-16@-36@-34@-3@-40@-11@-45@-11@-34@2@-27@-38@-7@-48@-14@-35@-37@-31@-42@-8@0@-39@-20@-50@-9@-7@-18@-6@-65@-44@-68@-67@-61@-19@-3@0@-66@-63@-29@-4@-29@-77@-51@-72@-91@-84@-38@-93@0@-7@-15@-78@-68@-59@-68@-47@-60@-101@-30@-69@-4@-52@-4@-60@-30@-65@-44@-108@-70@-43@-80@-102@-25@-58@-60@-13@-81@-17@-51@-32@-93@-38@-2@-16@-8@-1@-94@-55@-122@-77@-75@-25@-30@-55@-60@-23@-49@0@-119@-90@-129@-35@-8@-18@-79@-65@-16@-100@-143@-148@-39@-106@-140@-102@-126@-36@-41@-20@-23@-140@-138@-112@-49@-60@-7@-152@-162@-142@-1@-38@-15@-4@-7@-65@0@-114@-150@-160@-162@-29@-164@-32@-60@-60@-97@-130@-97@-172@-25@-185@-35@-77@-138@-188@-182@-137@-122@-133@-6@-37@-199@-108@-53@-188@-60@-30@-160@-160@-23@-176@-10@-23@-6@-116@-216@-155@-107@-66@-55@-107@-132@-91@-152@-127@-142@-90@-54@-40@-86@-151@-123@-120@-37@-84@-86@-205@-117@-179@-32@-26@-228@-232@-116@-67@-122@-125@-61@-2@2@-216@-63@-31@-147@-84@-113@-122@-39@-5@-47@-200@-129@-224@-246@-8@-112@-140@-65@-259@-110@-164@-85@-97@-129@-90@-124@-6@-228@-143@-78@-166@-150@-165@-262@-178@-6@-44@-44@2@-57@-43@-116@-197@-93@-221@-160@-96@-121@-127@-162@-181@-45@-40@-139@-194@-311@-291@-104@-217@-103@-28@-207@-21@-97@-91@-224@-257@-278@-176@-8@-93@-103@-35@-33@-320@-70@-254@-115@-59@-171@-45@-143@-250@-187@-181@-146@-210@-66@-297@-188@-79@-78@-309@-186@-272@-62@-41@-274@-323@-174@-344@-45@-146@-110@-283@-135@-24@-262@-39@-41@-112@-190@-214@-314@-224@-338@-167@-240@-95@-231@-154@-281@-52@-282@-274@-332@-311@-9@-159@-191@-80@-299@-354@-250@-232@-98@-132@-72@-61@-318@-255@-194@-282@-289@-114@-131@-267@-276@-65@-238@-335@-124@-7@-339@-295@-111@-260@-76@-82@-206@-383@-251@-230@-139@-109@-273@-222@-302@-359@-23@-326@-283@-75@-186@-270@-38@-208@-127@-63@-265@-215@-308@-350@-175@-358@-2@-166@-343@-421@-253@-34@-177@-426@-173@-127@-108@-93@-412@-102@-216@-35@-254@-85@-238@-401@-268@-212@-393@-332@-30@-374@-301@-39@-449@-59@-453@-63@-301@-251@-396@-78@-79@-279@-171@-471@-236@-56@-101@-129@-50@2@-213@-127@-107@-90@-472@-473@-435@-17@-490@-354@-122@-65@-181@-303@-319@-133@-350@-380@-60@-200@-55@-44@-482@-501@-82@-51@-361@-167@-7@-493@-68@-488@-18@-487@-250@-179@-143@-307@-85@-494@-178@-477@-453@-519@-143@-104@-523@-282@-16@-497@-358@-209@-292@-337@-500@-255@-167@-527@-184@-451@-305@-277@-453@-296@-441@-410@-521@-431@-215@-23@-53@-88@-296@-28@-454@-285@-259@-513@-526@-164@-4@-90@-22@-274@-432@-487@-372@-130@-162@-317@-401@-390@-16@-162@-409@-509@-256@-274@-371@-331@-430@-10@-562@-516@-246@-399@-122@-328@-134@-211@-443@-321@-290@-579@-101@-48@-208@-503@-138@-43@-33@-278@-8@-278@-515@-111@-164@-503@-69@-538@-450@-290@-434@-194@-477@-284@-324@-292@-582@-267@-38@-217@-489@-102@-142@-50@-511@-606@-254@-404@-319@-261@-191@-26@-376@-13@-355@-483@-133@-573@-136@-508@-70@-249@-86@-353@-280@-418@-582@-371@-652@-643@-369@-522@-33@-456@-226@-600@-621@-394@-516@-52@-542@-548@-524@-4@-202@-102@-405@-203@-101@-76@-160@-30@-314@-45@-211@-223@-35@-672@-640@-576@-198@-131@-478@-334@-44@-489@-351@-180@-242@-473@-462@-519@-651@-608@-360@-626@-262@-403@-50@-535@-284@-387@-227@-523@-152@-454@-687@-331@-201@-246@-533@-667@-71@-34@-24@-190@-227@-528@-413@-302@-687@-719@-714@-466@-432@-460@-83@-703@-401@-642@-146@-350@-128@-549@-579@-83@-747@-219@-612@-410@-694@-643@-268@-323@-684@-677@-290@-6@-78@-627@-751@-360@-76@-249@-724@-154@-106@-290@-669@-51@-290@-634@-740@-605@-645@-713@-214@-767@-752@-689@-174@-487@-386@-561@-394@-605@-4@-7@-180@-781@-75@-462@-471@-723@-709@-30@-434@-771@-652@-8@-796@-748@-87@-463@-276@-436@-477@-116@-86@-600@-476@-499@-173@-219@-85@-458@-225@-144@-405@-688@-570@-45@-65@-741@-184@-504@-265@-336@-130@-361@-95@-528@-532@-186@-461@-189@-682@-306@-223@-75@-11@-640@-313@-539@-548@-594@-203@-605@-277@-356@-822@-242@-282@-219@-441@-72@-558@-832@-322@-572@-44@-660@-736@-754@-99@-192@-482@-248@-296@-799@-418@-759@-114@-507@-10@-717@-778@-279@-775@-787@-864@-554@-525@-632@-312@-183@-267@-735@-342@-453@-152@-882@-95@-538@-227@-336@-719@-254@-481@-481@-591@-739@-783@-409@-468@-328@-429@-271@-425@-246@-476@-822@-757@-771@-2@-41@-676@-821@-288@-386@-749@-528@-777@-916@-312@-648@-699@-26@-258@-722@-513@-706@-111@-631@-745@-148@-710@-147@-470@-312@-314@-448@-530@-674@-283@-657@-404@-483@-712@-278@-154@-841@-152@-506@-537@-226@-649@-711@-808@-331@-196@-877@-432@-847@-745@-669@-71@-692@-175@-438@-83@-826@-64@-611@-528@-553@-664@-754@-678@-503@-362@-365@-710@-339@-805@-47@-298@-274@-551@-901@-581@-562@-368@-6@-559@-964@-994@-404@-148@-383@-154@-518@-350@-309@-669@-689@-780@-457@-88@-142@-522@-177@-115@-935@-893@-306@-481@-912@-745@-691@-763@-674@-246@-994@-497@-686@-474@-661@-385@-9@-310@-710@-991@-51@-361@-314@-346@-355@-872@-622@-998@-586@-631@-1023@-798@-789@-55@-166@-658@-818@-850@-590@-1035@-274@-524@-913@-183@-383@-297@-378@-186@-858@-369@-191@-815@-648@-367@-460@-879@-1052@-476@-382@-455@-892@-57@-54@-523@-824@-1030@-675@-980@-818@-629@-201@-939@-586@-913@-858"

	for i=1:1:$length(pInput,"@") {
		set tTemp(i)=$p(pInput,"@",i)
	}
	
	set tCount=0
	set tContinue=1
	set tPos=1
	while tContinue {
		set tCount=tCount+1
		
		set tOld=tPos
		
		set tPos=tPos+tTemp(tPos)
		
		set tTemp(tOld)=tTemp(tOld)+1
		
		if (tPos>$length(pInput,"@")) || (tPos<0) {
			set tContinue=0
		}
	}
	
	quit tCount
}

ClassMethod Day5P2(pInput = "") As %String
{
	set:pInput="" pInput="0@0@0@1@2@-1@0@-5@-6@-5@-3@-3@-8@-3@-7@-8@-4@-9@1@-3@-17@0@-18@-14@1@-13@-4@-22@-7@-8@-25@-23@-11@-3@-9@-3@-26@-7@-24@-15@-17@2@-18@-39@-6@-28@-27@-38@-47@-17@-16@-36@-34@-3@-40@-11@-45@-11@-34@2@-27@-38@-7@-48@-14@-35@-37@-31@-42@-8@0@-39@-20@-50@-9@-7@-18@-6@-65@-44@-68@-67@-61@-19@-3@0@-66@-63@-29@-4@-29@-77@-51@-72@-91@-84@-38@-93@0@-7@-15@-78@-68@-59@-68@-47@-60@-101@-30@-69@-4@-52@-4@-60@-30@-65@-44@-108@-70@-43@-80@-102@-25@-58@-60@-13@-81@-17@-51@-32@-93@-38@-2@-16@-8@-1@-94@-55@-122@-77@-75@-25@-30@-55@-60@-23@-49@0@-119@-90@-129@-35@-8@-18@-79@-65@-16@-100@-143@-148@-39@-106@-140@-102@-126@-36@-41@-20@-23@-140@-138@-112@-49@-60@-7@-152@-162@-142@-1@-38@-15@-4@-7@-65@0@-114@-150@-160@-162@-29@-164@-32@-60@-60@-97@-130@-97@-172@-25@-185@-35@-77@-138@-188@-182@-137@-122@-133@-6@-37@-199@-108@-53@-188@-60@-30@-160@-160@-23@-176@-10@-23@-6@-116@-216@-155@-107@-66@-55@-107@-132@-91@-152@-127@-142@-90@-54@-40@-86@-151@-123@-120@-37@-84@-86@-205@-117@-179@-32@-26@-228@-232@-116@-67@-122@-125@-61@-2@2@-216@-63@-31@-147@-84@-113@-122@-39@-5@-47@-200@-129@-224@-246@-8@-112@-140@-65@-259@-110@-164@-85@-97@-129@-90@-124@-6@-228@-143@-78@-166@-150@-165@-262@-178@-6@-44@-44@2@-57@-43@-116@-197@-93@-221@-160@-96@-121@-127@-162@-181@-45@-40@-139@-194@-311@-291@-104@-217@-103@-28@-207@-21@-97@-91@-224@-257@-278@-176@-8@-93@-103@-35@-33@-320@-70@-254@-115@-59@-171@-45@-143@-250@-187@-181@-146@-210@-66@-297@-188@-79@-78@-309@-186@-272@-62@-41@-274@-323@-174@-344@-45@-146@-110@-283@-135@-24@-262@-39@-41@-112@-190@-214@-314@-224@-338@-167@-240@-95@-231@-154@-281@-52@-282@-274@-332@-311@-9@-159@-191@-80@-299@-354@-250@-232@-98@-132@-72@-61@-318@-255@-194@-282@-289@-114@-131@-267@-276@-65@-238@-335@-124@-7@-339@-295@-111@-260@-76@-82@-206@-383@-251@-230@-139@-109@-273@-222@-302@-359@-23@-326@-283@-75@-186@-270@-38@-208@-127@-63@-265@-215@-308@-350@-175@-358@-2@-166@-343@-421@-253@-34@-177@-426@-173@-127@-108@-93@-412@-102@-216@-35@-254@-85@-238@-401@-268@-212@-393@-332@-30@-374@-301@-39@-449@-59@-453@-63@-301@-251@-396@-78@-79@-279@-171@-471@-236@-56@-101@-129@-50@2@-213@-127@-107@-90@-472@-473@-435@-17@-490@-354@-122@-65@-181@-303@-319@-133@-350@-380@-60@-200@-55@-44@-482@-501@-82@-51@-361@-167@-7@-493@-68@-488@-18@-487@-250@-179@-143@-307@-85@-494@-178@-477@-453@-519@-143@-104@-523@-282@-16@-497@-358@-209@-292@-337@-500@-255@-167@-527@-184@-451@-305@-277@-453@-296@-441@-410@-521@-431@-215@-23@-53@-88@-296@-28@-454@-285@-259@-513@-526@-164@-4@-90@-22@-274@-432@-487@-372@-130@-162@-317@-401@-390@-16@-162@-409@-509@-256@-274@-371@-331@-430@-10@-562@-516@-246@-399@-122@-328@-134@-211@-443@-321@-290@-579@-101@-48@-208@-503@-138@-43@-33@-278@-8@-278@-515@-111@-164@-503@-69@-538@-450@-290@-434@-194@-477@-284@-324@-292@-582@-267@-38@-217@-489@-102@-142@-50@-511@-606@-254@-404@-319@-261@-191@-26@-376@-13@-355@-483@-133@-573@-136@-508@-70@-249@-86@-353@-280@-418@-582@-371@-652@-643@-369@-522@-33@-456@-226@-600@-621@-394@-516@-52@-542@-548@-524@-4@-202@-102@-405@-203@-101@-76@-160@-30@-314@-45@-211@-223@-35@-672@-640@-576@-198@-131@-478@-334@-44@-489@-351@-180@-242@-473@-462@-519@-651@-608@-360@-626@-262@-403@-50@-535@-284@-387@-227@-523@-152@-454@-687@-331@-201@-246@-533@-667@-71@-34@-24@-190@-227@-528@-413@-302@-687@-719@-714@-466@-432@-460@-83@-703@-401@-642@-146@-350@-128@-549@-579@-83@-747@-219@-612@-410@-694@-643@-268@-323@-684@-677@-290@-6@-78@-627@-751@-360@-76@-249@-724@-154@-106@-290@-669@-51@-290@-634@-740@-605@-645@-713@-214@-767@-752@-689@-174@-487@-386@-561@-394@-605@-4@-7@-180@-781@-75@-462@-471@-723@-709@-30@-434@-771@-652@-8@-796@-748@-87@-463@-276@-436@-477@-116@-86@-600@-476@-499@-173@-219@-85@-458@-225@-144@-405@-688@-570@-45@-65@-741@-184@-504@-265@-336@-130@-361@-95@-528@-532@-186@-461@-189@-682@-306@-223@-75@-11@-640@-313@-539@-548@-594@-203@-605@-277@-356@-822@-242@-282@-219@-441@-72@-558@-832@-322@-572@-44@-660@-736@-754@-99@-192@-482@-248@-296@-799@-418@-759@-114@-507@-10@-717@-778@-279@-775@-787@-864@-554@-525@-632@-312@-183@-267@-735@-342@-453@-152@-882@-95@-538@-227@-336@-719@-254@-481@-481@-591@-739@-783@-409@-468@-328@-429@-271@-425@-246@-476@-822@-757@-771@-2@-41@-676@-821@-288@-386@-749@-528@-777@-916@-312@-648@-699@-26@-258@-722@-513@-706@-111@-631@-745@-148@-710@-147@-470@-312@-314@-448@-530@-674@-283@-657@-404@-483@-712@-278@-154@-841@-152@-506@-537@-226@-649@-711@-808@-331@-196@-877@-432@-847@-745@-669@-71@-692@-175@-438@-83@-826@-64@-611@-528@-553@-664@-754@-678@-503@-362@-365@-710@-339@-805@-47@-298@-274@-551@-901@-581@-562@-368@-6@-559@-964@-994@-404@-148@-383@-154@-518@-350@-309@-669@-689@-780@-457@-88@-142@-522@-177@-115@-935@-893@-306@-481@-912@-745@-691@-763@-674@-246@-994@-497@-686@-474@-661@-385@-9@-310@-710@-991@-51@-361@-314@-346@-355@-872@-622@-998@-586@-631@-1023@-798@-789@-55@-166@-658@-818@-850@-590@-1035@-274@-524@-913@-183@-383@-297@-378@-186@-858@-369@-191@-815@-648@-367@-460@-879@-1052@-476@-382@-455@-892@-57@-54@-523@-824@-1030@-675@-980@-818@-629@-201@-939@-586@-913@-858"

	for i=1:1:$length(pInput,"@") {
		set tTemp(i)=$p(pInput,"@",i)
	}
	
	set tCount=0
	set tContinue=1
	set tPos=1
	while tContinue {
		set tCount=tCount+1
		
		set tOld=tPos
		
		set tPos=tPos+tTemp(tPos)
		
		if tTemp(tOld)>=3 {
			set tTemp(tOld)=tTemp(tOld)-1
		} else {
			set tTemp(tOld)=tTemp(tOld)+1
		}
		
		if (tPos>$length(pInput,"@")) || (tPos<0) {
			set tContinue=0
		}
	}
	
	quit tCount
}

ClassMethod Day6P1(pInput = "") As %String
{
	set:pInput="" pInput=$lb(5,1,10,0,1,7,13,14,3,12,8,10,7,12,0,6)
	set tCount=0
	Set tCur=pInput
	while 1 {
		Set tCount=tCount+1
		Set tArray(tCount)=tCur
		Set tMax=0
		Set tPos=0
		for i=1:1:$listlength(tCur) {
			If $list(tCur,i)>tMax {
				Set tMax=$list(tCur,i)
				Set tPos=i
			}
		}
		
		set $list(tCur,tPos)=0
		//zw tPos
		//zw tMax
		For i=tPos+1:1:tMax+tPos {
			Set tTemp=i
			While tTemp>$listlength(tCur) {
				set tTemp=tTemp-$listlength(tCur)
			}
			set $list(tCur,tTemp)=$list(tCur,tTemp)+1
		}
		
		for i=1:1:tCount {
			if tCur=tArray(i) {
				return tCount
			}
		}	
	}
}

ClassMethod Day6P2(pInput = "") As %String
{
	set:pInput="" pInput=$lb(5,1,10,0,1,7,13,14,3,12,8,10,7,12,0,6)
	set tCount=0
	Set tCur=pInput
	set tFinal=""
	set tFinalCount=0
	while 1 {
		Set tCount=tCount+1
		Set tArray(tCount)=tCur
		Set tMax=0
		Set tPos=0
		for i=1:1:$listlength(tCur) {
			If $list(tCur,i)>tMax {
				Set tMax=$list(tCur,i)
				Set tPos=i
			}
		}
		
		set $list(tCur,tPos)=0
		//zw tPos
		//zw tMax
		For i=tPos+1:1:tMax+tPos {
			Set tTemp=i
			While tTemp>$listlength(tCur) {
				set tTemp=tTemp-$listlength(tCur)
			}
			set $list(tCur,tTemp)=$list(tCur,tTemp)+1
		}
		
		for i=tFinalCount+1:1:tCount-1 {
			if tFinal="" {
				if tCur=tArray(i) {
					set tFinal=tCur
					set tFinalCount=tCount
					k tArray
					set i=tCount+1
				}
			} else {
				if tCur=tArray(i) {
					return tCount-tFinalCount
				}
			}
		}	
	}
}

ClassMethod Day7P1(pInput = "") As %String
{
	set:pInput="" pInput="bqyqwn(68)->wscqe,cwxspl,syogw,xnxudsh@ddswb(34)@hnkvw(320)@ibqmynm(252)->oglcdgs,tkjofj,upurae,oypvhy,bzfkt,hdvcz,cfwxyl@rkerea(87)@lcmlbj(66)@vtccvv(69)@nachvlp(20)@tmkli(66)@exuyuk(82)@ojzogs(79)@egkiqcp(37)->rxjnad,psetts@xadjes(10)@fivkqxx(121)->acvzsbe,kkmax,qcmwsvm@krgtrdn(53)@mxemqqb(267)->iuuouds,qqmvd@iwwqvoa(24)@yyecrv(59)@zjpkoar(40)@ilsgqdw(37)@bmlfd(43)@nxqwag(81)@ubbwvvl(44)@khfzis(48)->ztxcc,bvejguc@gvtcy(39)@xbxxe(173)->bzjxil,amklj@qejgaf(25)@uunpyb(82)@dmidur(57)@fklfgd(65)@vcjfe(22)@rkjfx(33)@ioglbe(88)@tymkixg(36)@qbhhtw(90)@afbrhy(79)@nswcez(47)@wzjonl(16)@xviqup(95)@claolm(312)->ndmkbul,rpjfkh@qhlhfk(387)->iwwqvoa,rmshk,ftezz@vtokttx(55)@boalcdm(13)@angpy(62)->fitha,itxgz,pyiexlj,wqshh,rloxobx@gwcdf(32)@jpscxfh(46)->qsakd,exuyuk,dqdmie,kjwfeoj@qkzpcyy(96)@fifams(415)@yseezd(11)@qcmwsvm(37)@hfnhd(152)->vdcfh,ufrhi@wfgzr(82)@sjoov(6)@fonrb(7531)->xohxq,cmsqe,jefsr@pyhof(21)@pplis(9)@fosdh(90)@pjkyydd(15)@wvmtyez(46)@bzfkt(66)->rauho,xctuhbx@zyqssjb(13)->olebdv,byahs,xajzwdh@wotus(119)->dndrnc,tebkmhi,qejgaf@rusndcc(39)->xcfxvd,kvylxr,vwkegak,oiuztx@stofi(16)@mgqil(66)->noibcw,nptqxtu@qjzss(31)@hawhqex(71)@kjjee(174)->lltgjo,gwcdf@gdamb(99)@diqdy(183)->gackyrq,vcjfe,lcnsf@sfwzqk(54)->rkuzg,ewvvb@vktjns(45)@urwaex(59)@nyouzhg(17)->lofybs,baedi@mklqpn(9)@iktget(33)@gxtfu(57)@xkymbld(37)->mqgbif,ptxfk@qjeuqe(92)@benqzp(92)->wvmtyez,gmveehb@rkctaq(20)@sbwoye(50)@bujufb(148)->tduxvx,lxzvkpk,jllqymn,csrpy@cwfydbh(369)->qcmtgvr,tyvjs@cjjytkr(305)->trszl,fgzgfc@qsakd(82)@domway(2464)->kgphv,pjujovx,hrdggo@mrpji(61)@kzrgfb(92)@hocazx(818)->bmukspb,mgbwxw,gyirkcj,kgxfc@bobvssz(25)->srvqt,alhghui,wnjaw,qhlhfk,lsbvzaf,qjkfys,nnncfl@rrzyzq(76)@eaufvn(78)->dtazpb,nlajc@tduix(18)@yzcez(62)->rlxto,vkaxa@uvpuko(91)@xtnmps(95)->ptatzl,bujufb,oybbzr,zwopz,phqpwkw@ibeis(54)@ofkvpq(500)->auvuxv,stqmwk,dptekr@pmolg(166)->uuunqk,uolqt@byedxex(180)->gsaqlad,ebwubc@aicjff(67)@vtcxw(860)->ezlfnhs,aizdt,ylbftp@nzuswm(80)->ojzogs,qfopwo@hgwbg(89)@sflonq(190)->gppwsbp,mpvgy@pqiuhyp(52)->xbtjl,jykseco,aftnyad,xaden,urdgg,ijkpfv,ejekn@ccgjf(99)@devsz(38)@vmmtsr(33)@ebwubc(70)@mgcnohi(69)@klege(92)@jtlqxy(66)@ofbqk(148)@ewluica(22)@mulvwn(290)->ubbwvvl,jmuqp,dnovxt@trlcj(245)@uezwz(20)@bbtnj(170)->xvwok,rqyxzn@ndticx(54)->rbtco,bobvssz,umtxk,domway,wugia,ubvttg,ydpemw@lxwkpqh(325)->xoigv,fqsjaz@mpvgy(35)@ujgeml(94)@jkoir(6)@kemkz(98)@dtqgdc(90)@girxc(147)->zylotoh,qtxmjwm@olawkuc(79)->earmfdp,wnowypb@umrqldb(99)@oyurlfq(57)@flgpg(188)->jimltsw,xhgza@wawtrk(80)@nlajc(85)@ewqcktv(1364)->hfnhd,amqvr,ntxcpwl@dmvyuf(35)@vtdbov(50)@xnszvs(65)@mjrktxe(50)->eoxwp,jgsmitm,isrgei,rnbgz,kymbvpp,ktjdpt,mgzocpe@zicvok(81)@tkmfbk(93)->ffhsg,kynezb@vlwvot(84)@oybbzr(1007)->qstlv,nayvvrh,izxpf,habni,ckfefl,fjdlcbh,thhakxn@qiksfr(44)@wowxv(92)@fmdba(44)@zgxbjj(96)@jncjxue(66)@xquhgig(190)->rqhfxty,maftysp@habni(27)->xwknab,xukfcd,scvhl,tcbgf@iftcnc(50)@dqdmie(82)@otlvq(40)->hjsrvj,rtbcch,vpirde@mgzocpe(51)->zkwajbd,mrpji@fkzxb(89)@jlsmm(32)@igdkn(43)->dgtxjuj,jxyakll,kptdem@rftuf(43)@uolqt(9)@rtwlo(78)->wgbvle,npttye,claolm,ydffzgu,mgbgb,jwjuth,mulvwn@nrgzcge(132)->bywbrk,vazoq,eaufvn@juoaena(94)@wfsaglg(54)->nlfdps,tdkdiqe@jfsgqq(100)->crslvc,esized@mcucysr(49)@tcbgf(28)@mlalrpt(166)->jtbrjm,fyaxzl@srvqt(155)->jyftx,dtijfqc,phcqntb,uyhrcfl@xohxq(1457)->czbydf,wgdnyy@lqbmor(230)->rkjfx,vmmtsr@jjsyexg(38)@ynvesz(88)->rqaxn,afntec@ibbxb(194)->imiimt,llikz@ktasnia(49)->thkjz,cjgtra,tzngdx,cqjsqh,vtjtyp,lyzaead,xrtzs@vsjjq(30)@yjnzgl(67)@mcrhiy(6559)->mkgafux,gugxitg,tymmo@nlgymop(139)->tymkixg,crchwpb@ybosi(18)@rhqfb(179)->okurp,gpwbcg,invqsb@kzjozhi(90)@ixncawy(28)@ooczbeh(36)@ubvttg(796)->wuuvnlz,donzb,bwgimi,rywtmt,rusndcc,ceagctk@ohcoit(6)@exrud(176)->hpziqqg,abxglwt,gozhrsf,oqjqu,vhkodl@opvrgh(79)@blyms(46)@vfrylx(10)->qhkniqm,bmcwbsi@ndmkbul(55)@mohey(86)->tbmyue,ibeis@wktzh(93)@ystgyng(50)@jclntv(87)@dsjcqpn(133)->slufzy,gbbpqj,jxawk@fitha(68)->faqngn,xguqqao,athuly,fmdsfus@xyang(225)->njxrb,mfwuqb@acjedny(49)@mfwuqb(60)@ayuma(81)@qqmchoq(7)@yzjhmqq(171)->dinpz,upozls@qfopwo(79)@srypr(64)@tvwmzal(236)->cpujsn,ewluica@umtxk(2942)->jyazs,scnhwcs,fmpvv,aahqvqy@gkwyfz(49)@dodrbx(227)->uhtnl,vxnsova@sfdclf(238)@kksizqf(44)@dfofyir(236)->ddswb,grxdbx@qakiz(37)@ceagctk(255)->bwvlnlt,rkazlp,vbejzc,njhlrtm@hnjszii(284)->zkdwz,bwlit@gbbpqj(34)@bvaoy(114)->mogwbda,rodntl@vkihn(36)@symdxo(8)@nduildw(30)@nxhfgx(18)@chgfb(16)@gugaaiq(40)@euvrdg(79)@ckzaj(67)@jupzgjm(90)@llalaql(27)@qdnghwn(16)@iffluz(515)->bbbvmxo,reomle,vspqi@nvrjzg(214)->nzfko,qqmchoq@xvwok(34)@enmjipp(95)@jtbrjm(18)@rlxto(83)@xpotznx(41)@lslhph(59)@vhkodl(221)->otlvq,fioegdo,rreidgp,fivkqxx,xahvbm@mncivb(88)@hbhfdlh(89)@mkgafux(688)->admjq,tqtut,emkgc@tymmo(22)->uxjaa,nlgymop,dcvfkk,yzjhmqq,iqjqlfq,faopk@vxslvq(37)->jmvcgo,ioglbe@rxjnad(80)@ejdxula(92)->kviiza,uqmaluk,nasbs@xvzoy(35)@vukpdsr(162)->gumncu,mlzmimg,vjobpzv@xoigv(10)@iuehdsr(21)@jzgvab(9)@odxpup(89)@vwkegak(92)@bsvgagj(41)@mxwgu(310)->yeyxf,qdnghwn@jynmg(1140)->wotus,mohey,fiynyre@qftwuv(36)@veabcj(67)@zaargo(30)->ytrsmfx,jtlqxy@xfbfvuu(65)@gpwbcg(5)@elysbb(81)@engpslr(85)@tqbtvqc(31)@faqngn(98)@jykseco(166)->xawzbz,fsdoohr@nfywcyp(62)@rreidgp(168)->vfupn,xyvnk@obmcr(89)@spnllx(76)@mbbuqoi(35)@wjxgg(177)->symdxo,dsptf,yaxeloo,yxrhis@chcjswk(89)@anamgt(346)->ywwxi,rnbvid@zjwqc(26)@wxgoew(1481)->hnjszii,ygqxl,xhkwrs@dydcy(76)->drnki,uxolsws,lrcstqr@npttye(42)->wkrgvo,jhydv,enmjipp,hnyjyga@yjwvnhl(219)@fykgs(43)@vrmqym(97)->lrmnb,nvigovl@gkfdg(226)->ohcoit,jkoir@ictsk(122)->devsz,jjsyexg@gixezcy(37)@rywtmt(158)->nevrtrs,sybvdj,qcorw@pwhtvdh(40)@yapfoe(59)@xnnbqju(90)->xzsmw,petvm,xyxidwf@vxiwms(99)@htaszsq(87)@mgbwxw(52)->afbrhy,jrsfu@rdzsisf(59)@qvxanzu(262)->nxhfgx,vvzmdr,inddon,ybosi@ysbhsn(181)->wleavrv,kmvvxon@tirifqs(6489)->ofbqk,iqdiez,kspsz,kejph@rnkbli(84)@bjbndbg(169)->oqsdzpe,sbwoye,yhukqf@dndrnc(25)@oxzhz(86)->bcbftl,hjzgzoe@ufrhi(68)@gsyeaes(26)@kgbzu(180)->wzczb,bzqjb@dgtxjuj(97)@xulgx(5)@wleavrv(16)@qnhbmzp(118)->wktzh,zodwdpq@csrpy(62)->zmoxc,ccgjf,umrqldb,gdamb@ldqyt(50)@btwmd(54)@volompq(96)@qmshniw(443)@lrmnb(98)@yijwaf(32)@paoxff(98)@ulbute(95)@lyzaead(939)->jfqddfd,ucpkpfb,sbmwazv@rodntl(60)@tykcvi(9)@aftnyad(188)->rfqddq,recxxj@zdelqb(155)->jaasf,snqnh@akwcv(65)@nszqngg(44)@eavas(45)->ytsmc,mrxdp,prjpkm,nzawh@fqvbdq(96)->tzimies,jduij@mabcqcb(194)->itutdol,vtokttx@trvtkqj(49)@ynlzggk(36)@pggjo(19)@jajdx(19)@ackyirz(16)@gtiopzn(49)@idvnxqp(5)@njsjq(273)->vptdap,eteyvz@qkjdjpe(44)@dzfon(61)->wksjlix,zicvok,utiwem@nxmhned(166)->pekohn,xnszvs@pnqycz(43)->gkkit,khyca,yudzxoa@lvkeqm(192)->lneyu,uopxjn@qvrvcu(19)@hvwyae(23)@ocgbpez(114)->gjgrhw,bvtgvu@mehuxr(53)@pmdcajx(7)@ybixf(299)->xvhgvw,ooczbeh,ksbwlir,pkzwosb@inlft(36)@hshafy(65)@nzfko(7)@vcnael(95)@nxuer(13)@pulql(59)->akwcv,uijffti,ysxvzdu,xfbfvuu@hlbotz(13)@zhrdezs(28)@aqxaecv(297)@ppjapn(27)@bbbvmxo(21)->rceksnv,uhnlse,rswnjx,ogcmm@ikvzux(44)@hdvcz(156)->zisdcf,keurs,bjops@ytsmc(22)@jiwfia(13)@jthpj(44)@dtijfqc(76)@vgfhpwb(99)@sjmhuxn(11)->aceyee,iohigm,zildb,vrmqym,pxxabj,gjjfx@byahs(65)@qllime(202)->dspkk,wgtnepi@ksbwlir(36)@hzawlq(16)@kgwftu(87)@qtzelhq(62)@wabzx(209)->sfazwz,lnndami@dyazidi(219)@resoi(25)@hgwkyu(91)@urdgg(166)->srypr,fnayjx@hsfhqhe(17)@metif(68)@ifxzdfy(96)->ssnpxj,ejhojmh@jefsr(477)->fqvbdq,xsygbj,rcluk,dcero,lfgqgs@oglcdgs(140)->dmvyuf,xvzoy@jrhzmbj(45)@mlvhqpe(91)->qsstg,tnrrui,utsnke,gxtfu@iffxdk(87)@xboqv(17)@hppxlu(174)->lkjhmiq,kntwy,auhnyn@pralyx(191)->dmkfnm,xcmzg@osnkrr(53)@nhvyso(77)@mogwbda(60)@rqaxn(96)@vxnsova(5)@xsxnizc(50)@hskhxx(36)@ogcmm(57)@drnki(25)@ecjxs(197)@dnniv(16)@wnjaw(369)->brvxyyg,hsvmept,praagwp@xjcxk(24)@aahqvqy(74)@hpwaux(97)@sadyx(59)@dptekr(112)->xiqthw,ihtfo@mlmhe(4563)->uwxjkq,uqals,ofkvpq,pyxdkm@yytmc(66)@hmbuu(16)@ezzpr(94)@zpxgfq(118)->tqplqn,fysxwmd@hgkmod(75)@earmfdp(83)@mxpgmte(5)@kcfgbv(73)->fdeowqq,pbzvjg,tzrqwt@jtxjj(120)->hiuviy,sadyx@dsptf(8)@dsezlbe(54)@onzind(245)->wayzzn,ystgyng@pjndde(422)->yseezd,cseckdt@rnbgz(131)->iuehdsr,xgzluhk@yswonja(195)->gachtig,bjadb,gtiopzn@piizso(59)@msqxo(47)@jacmj(29)@hjsrvj(64)@prcxksh(20)@aceyee(219)->gixezcy,zqwqcnq@pkipy(95)@czbydf(75)@bpguivk(32)@utapoe(84)@qjdou(87)@njhlrtm(38)@pkzwosb(36)@wpphwjv(83)@teqej(66)@lneyu(64)@dicalia(44)@opzxu(46)@gasejp(15)@llikz(22)@uhtnl(5)@kntwy(25)@wzbewii(157)->myetb,dhwakp,vqtalpm@vkaxa(83)@kwnqw(49)@uhnlse(57)@zqamk(37518)->mflijpx,ikzap,wzimze,agjpn@fnnykbh(91)->nxqwag,tpcbt,elysbb,xlaqpg@ytrsmfx(66)@pyiexlj(92)->oozbxqb,kzrgfb,klege,csfjt@yaxeloo(8)@tzbmy(71)@pjecv(56)@gsaqlad(70)@gmzcjo(76)@cuscn(114)->fmdba,ikvzux@rbzmniw(52959)->tespoy,tirifqs,exrud@jzoxv(52)@egizyey(78)->metif,towuup@uxolsws(25)@twyhx(86)@nqjydpi(44)->rpgzp,nszqngg,jthpj,qiksfr@avecfoq(95)@wltax(21)@xfyqx(20)@tnrrui(57)@gmveehb(46)@kymbvpp(67)->qzvobt,osnkrr@xbccghy(66)@iqdiez(134)->wkkmvcn,nkzgse@pmopji(128)->gpcyq,qsdyww@cfwxyl(210)@khzqqwi(12)@wjrhp(992)->nyouzhg,ccxff,qmifv,oonpy,vutdji,owukmji@yvlajs(35)@hkltivy(26)@vylzag(33)@mieynp(21)@jppbvbo(929)->ynvesz,tvwmzal,mbwaxn@yxxgd(296)@utiwem(81)@ihvefep(110)->ffzzzc,ckzaj,zfyqzi@vfupn(32)@jhydv(95)@vspqi(201)->wzjonl,dnniv,pdazlob@iohigm(248)->icxzod,mclqrmw,pjkyydd@hzehjo(43)@kwhgtnk(78)@npxexv(66)@lycfbo(89)@vezhmd(47)@amqvr(274)->aditjen,xvdmeo@vbqpp(35)@upurae(33)->rdzsisf,lslhph,urwaex@uvkwg(88)@wapknj(2443)->xulgx,idvnxqp@mvgmf(105)->dicalia,qhkhuow,phnuqn@qmifv(163)->hzawlq,ackyirz@xlacmu(87)@aesiz(86)@jjiikvt(25)@prjpkm(22)@rbtco(1110)->dfofyir,qnhbmzp,dzfon,zmdkea,valby,mabcqcb,mifwbmm@greav(20)@dmkfnm(30)@ftezz(24)@iuuouds(14)@jwjuth(390)->hmbuu,oxlzlor@gzwrv(212)->efqjc,gasejp,qqooh@wgdnyy(75)@rqhfxty(53)@qhpvuzi(75)@cvxqnh(53)@stqmwk(96)->vcnael,dhobx@wuuvnlz(206)->pznkdcr,ucfipvi,jfhzgp@nnyws(190)@bbbhx(5)@qdfvw(69)->hgwkyu,uvpuko,wclnx@inddon(18)@gyirkcj(138)->inlft,vkihn@lrtzi(53)@pjlxc(62)@slufzy(34)@zkdwz(20)@tigvdj(44217)->xtnmps,ylnobx,mlmhe@vptdap(23)@aemkbp(35)->dwrtbo,rkerea,iffxdk@dpngy(17)@nzhbfc(207)->hvgozl,hsfhqhe@wayzzn(50)@myhnuu(66)@jrsfu(79)@gqeiy(257)->opvrgh,sibvtz@xgzluhk(21)@fiynyre(156)->mieqogh,zpaivc@vqtalpm(26)@thkjz(437)->insleik,ayjse,sgovqnf,wjxgg,euwab@ylbftp(82)->epcjds,gsyeaes@ndikjqv(22)@tqplqn(36)@aifpxqv(89)@hjbfr(20)@lltgjo(32)@picnycy(33)@kplvk(24)@ptatzl(314)->sfdclf,ibbxb,slzpby,kjjee,bbtnj,gkfdg,nzuswm@qtxmjwm(7)@ckudisa(78)@opskc(35)@qhkniqm(96)@rqyxzn(34)@vdcfh(68)@hpziqqg(637)->ypqkl,nmazby,hxswr@vrfme(20)@ozdnanh(34)@qcmtgvr(12)@gvdlvgg(20)@krnbkr(82)->qladcl,tefdmi,ocdpr@fyxttac(39)@hbbpp(95)@hjzgzoe(38)@hjqsj(85)@asevk(44)->hpwaux,byojhfr@fgzgfc(44)@ejtdhx(57)@ntxcpwl(36)->kerjk,nggubzz,utapoe@fqsjaz(10)@hxswr(74)->bixxpzd,htaszsq@dinpz(20)@yxxdal(44)@wozakri(251)->mgcpbp,omslcm@dhwakp(26)@kvylxr(92)@lsbvzaf(75)->ibqrz,cokvree,volompq,zgxbjj@bixxpzd(87)@xbtjl(294)@dyfzj(95)@utsnke(57)@sxjlr(91)@ckfefl(115)->khzqqwi,fzwzr@ezlfnhs(62)->qftwuv,ynlzggk@xguqqao(98)@jazqb(7378)->xadcuw,hocazx,cqvdpy@dsmjo(32)@gpcyq(55)@dhvsrt(7)@jllqymn(110)->dzwfsix,paeel,jclntv,qjdou@zkgdtp(90)@mjqkaqs(50)@nzcqte(140)->wkkdc,pwhtvdh,gugaaiq@woypnze(91)@dcriqom(79)@zppujp(34)@aqacmr(18)@rkazlp(38)@fysxwmd(36)@mzutqi(571)->qdfvw,mxwgu,yswonja@zfyqzi(67)@wqshh(460)@rztur(86)@bdlnohy(584)->dodrbx,qwotm,cbavt,mvgmf,igcmpn@qqmvd(14)@uwxge(94)@ijkpfv(218)->rxcgwd,steez@slzpby(136)->nxxlbnt,ozdnanh,zppujp@dzuqljn(7)->spnllx,fpeiss,hjzkjuw,pjoqde@dporud(50)@hrdggo(152)->agztuz,mehuxr@kigyp(65)->hjqsj,ijtis,engpslr@qcorw(83)@cmsqe(12)->njsjq,zqpxn,pulql,fkttd,wozakri@keurs(18)@pyxdkm(872)->xnnbqju,oxzhz,zaargo@pjhpwh(35)@vdlbwyo(24)@ocdpr(44)@gacseeh(89)@xzsmw(24)@liujmc(41)@myetb(26)@xawzbz(64)@qmyfg(114)->weipv,woypnze@heisrl(36)@mlzmimg(24)@ayjse(75)->veabcj,aicjff@htitjjt(203)->nswcez,msqxo@xhkwrs(324)@tdkdiqe(87)@ukgbdva(65)@qmcphv(32)@fmhfnhv(24)@nhjtvk(47)@sbmqxu(25)@ewobo(25)@hvgozl(17)@ysxvzdu(65)@sfazwz(68)@hlwesdc(24)@wgbvle(422)@ugzmeb(77)@hbptt(138)->uezwz,gbckkh,gvdlvgg@auezw(95)@lkuwf(95)@cneno(190)->uwjobru,jeadxth@wkrgvo(95)@koxzeku(79)@vehziv(67)@codkti(71)->tqbtvqc,oausk@kjwfeoj(82)@dcvfkk(111)->uahcz,xsxnizc@lcnsf(22)@zzwmn(40)@bywbrk(80)->rnkbli,vlwvot@jpmrs(94)@lfgqgs(187)->vbjpz,hlbotz,boalcdm@xbnmg(48)->aesiz,tqelui@pcvfgti(29)@ucpkpfb(181)@blkewbk(64)->jlsryou,idokb,avecfoq,ozyqew@mbwaxn(240)->nachvlp,prcxksh@wgsgaj(17)@fzwzr(12)@mgcpbp(34)@jxyakll(97)@fdeowqq(77)@zxmwy(35)@yudzxoa(84)@wwbebbr(95)@wgtnepi(66)@wkkdc(40)@xlccnkv(13)@yxrhis(8)@uwjobru(22)@csfzl(64)@dspkk(66)@xwknab(28)@fmdsfus(98)@vpirde(64)@nulax(10)@ymkgx(23)@psetts(80)@ucfipvi(67)@hsdym(340)->onjqcrh,eitdb,ycuuwxa,mxemqqb,pnqycz,wexncjl@wqojj(22)@xiiqh(98)@cqjsqh(360)->bzmqg,jpscxfh,ercxmph@wnowypb(83)@snqnh(95)@mifwbmm(114)->tfezflv,qxrspl@fcgkmq(68)->thftfut,svtqdbd@gachtig(49)@qxnvoh(214)@ihtfo(87)@qxrspl(95)@nnciip(95)@ercxmph(318)->ixncawy,zhrdezs@iqmpc(53)@rnbvid(49)@xukfcd(28)@bjadb(49)@niifkl(90)@kxrbd(20)@lrcstqr(25)@gackyrq(22)@cbavt(161)->qvrvcu,uhuees,pggjo,jajdx@mahlbe(6)@llpbev(29)@efqjc(15)@efvqwzi(7)@epqowm(45)@fjdlcbh(139)@csfjt(92)@zrnlkl(63)->dyfzj,xviqup,atrzkqf,ulbute@xsygbj(130)->vdlbwyo,ciquv,msdcz,kplvk@cdfmatu(80)@xeihyok(81)->uunpyb,wfgzr@ssnpxj(56)@wclnx(91)@nnncfl(335)->sgytd,nreuwh@cdjxwb(99)->buznuv,hkltivy@aditjen(7)@auhnyn(25)@nvigovl(98)@yeyxf(16)@uwxjkq(905)->jblwph,cdjxwb,dydcy@lkjhmiq(25)@teygd(170)->llpbev,nrxyk@jaasf(95)@dwrtbo(87)@hwgwzv(57)->qqqbf,fnslg@alhghui(279)->qbhhtw,ltytvpb@mjqzvuu(195)->hvwyae,tmzxl@wzczb(61)@ciquv(24)@gozhrsf(762)->ifxzdfy,uuxpvxf,zyqssjb@khyca(84)@atrzkqf(95)@psjec(97)@xyxidwf(24)@esized(69)@towuup(68)@trszl(44)@fkttd(141)->hbhfdlh,hgwbg@olvztw(21)@tebkmhi(25)@ltytvpb(90)@msdcz(24)@csdap(27)@vqinar(2904)->qhbrmur,nrgxdmx,angpy,gcswiam@yxbaldn(122)->vxiwms,syvza@swgjx(6)@mflijpx(75)->oxypy,rtwlo,vwnvlh@pygrhr(144)->rdorrx,pjecv@alneot(25)@wdbmakv(42933)->ktasnia,mxnaq,mcrhiy@fjticim(35)@rsfxf(123)->yjnzgl,glrmew@tyvjs(12)@gbckkh(20)@dgqfrv(35)@oozbxqb(92)@oypvhy(140)->yvlajs,pjhpwh@fnslg(52)@vhzfut(96)->obzrtar,qtzelhq@iqjqlfq(59)->gmzcjo,rrzyzq@amklj(23)@tvbgr(80)@qsrxouy(96)@rauho(72)@tzrqwt(77)@pdazlob(16)@uhuees(19)@qebqgxd(94)@ffhsg(79)@hzuyh(50)@oiuztx(92)@wjdeth(5)@bjops(18)@bwvlnlt(38)@baedi(89)@irokors(39)->xiiqh,paoxff@zvtfm(41)@aizdt(54)->zjpkoar,zzwmn@ffzzzc(67)@oxoul(12)->fkzxb,chcjswk@dcero(34)->ssvfbfs,nxbec@rloxobx(421)->jiwfia,nxuer,xfcktep@foznw(146)->dpngy,wgsgaj,xboqv@buznuv(26)@tduxvx(326)->iktget,vylzag,picnycy,lfdery@hiuviy(59)@dtazpb(85)@oxlzlor(16)@bvejguc(68)@uwjkolt(52)->tvxvtce,igdkn,rteyxil,qvxanzu,qllime@rvqopbu(67)@owukmji(195)@pbzvjg(77)@agztuz(53)@zpaivc(19)@nofpmh(290)->efvqwzi,pmdcajx@mhnnmp(8)->qbaosu,pjndde,anamgt,bcesxba,blkewbk@zfqmic(67)->lkuwf,pkipy@tespoy(5)->bdlnohy,jppbvbo,fgsmzi,sjmhuxn@qhbrmur(1450)->kcfgbv,dyomhm,nofpmh@lkdyq(57)@fuaio(16)@ccxff(53)->cgveph,tzbmy@fioegdo(140)->opzxu,blyms@bgnfpcr(75)@bmukspb(106)->jzoxv,gqvmeg@sbmwazv(39)->arrvxtj,hawhqex@xqwfgy(1496)->cywvxf,bjbndbg,mlvhqpe@jfqddfd(64)->ewgadin,fyxttac,gvtcy@empixc(142)->hlwesdc,xjcxk,fmhfnhv@zmdkea(154)->bgnfpcr,hgkmod@jeadxth(22)@ucilvib(40)->ddgnyfo,koxzeku@rteyxil(334)@clqfbvi(66)@lfdery(33)@ijtis(85)@rmshk(24)@kptdem(97)@ropdc(226)->usevjww,agthzo@talptwp(77)@bzqjb(61)@idokb(95)@kynezb(79)@tvxvtce(52)->ujgeml,jpmrs,lpsaav@athuly(98)@vazoq(248)@rxcgwd(38)@tfezflv(95)@cywvxf(279)->greav,kybtla@lfliwg(65)@qjkfys(353)->bjhxuqc,cvxqnh@vvzmdr(18)@gwuixj(31)@svtqdbd(61)@nqfqgj(22)->niifkl,fosdh@lxzvkpk(458)@gewpohj(16410)->cvqbwem,uzljl,zlhpt,vtcxw,iffluz@bggovyb(144)->supjxi,mieynp,wltax,pyhof@pbdafpz(236)->wjdeth,zacwh,mxpgmte,wjgjhc@pqrpkmd(34)@maftysp(53)@qqqbf(52)@fpeiss(76)@qsstg(57)@oqeam(128)->qjzss,gwuixj@brvxyyg(30)@oqmxlu(39)@tlpfhx(147)->heisrl,hskhxx@icush(877)->rsfxf,zfqmic,axzszf,gzwrv,cujuai@jagajrh(93)@kejph(98)->alneot,jjiikvt@acvzsbe(37)@gqvmeg(52)@olebdv(65)@tqtut(74)->ykitsi,wxvjyn@tzngdx(486)->pvyrkg,hppxlu,eovobtl,diqdy@vmsoc(61)->euvrdg,dcriqom@qiznqk(77)@kspsz(112)->tduix,aqacmr@kybtla(20)@ktjdpt(23)->tdmirp,qhpvuzi@jmvcgo(88)@hjzkjuw(76)@qinne(35)@ypqkl(64)->qjeuqe,wowxv@epcjds(26)@mrxdp(22)@pznkdcr(67)@kmvvxon(16)@xlaqpg(81)@nhtfal(23)@bxqqvue(5668)->zqbpucs,mhnnmp,ewqcktv@ipnvjje(80)@noibcw(95)@pywtg(16)@omslcm(34)@sxdngcn(6)@insleik(209)@wxvjyn(63)@ntezb(25)@klkwsa(57)@figvamv(32)@phqpwkw(1192)->egkiqcp,ecjxs,foznw,tokyi@onjqcrh(67)->lkdyq,tptqtpq,dmidur,klkwsa@igytdcp(160)->vtdbov,dporud@vrtgae(66)@bwgimi(242)->eohjrft,ankrgg,kvvkbhi@bzjxil(23)@ankrgg(55)@okurp(5)@rndvcf(39)@rkgoovn(104)->qyfsc,lytrpo@thftfut(61)@jduij(65)@invra(180)->sxdngcn,mahlbe,swgjx@wkkmvcn(7)@igcmpn(55)->bcadp,sxjlr@pgaiut(90)->vtccvv,mgcnohi@iytvm(15)->juoaena,qebqgxd,uwxge@glrmew(67)@uqmaluk(70)@qstlv(75)->qmcphv,bpguivk@gtbgp(234)->ilsgqdw,qakiz,zesfmu@rziopi(57)->flgpg,nqjydpi,xbnmg,xxdcgas,vhzfut,sfwzqk,kirnt@rdorrx(56)@oxypy(1992)->sflonq,igytdcp,nzcqte,sjbfmfa@pekohn(65)@praagwp(30)@qqooh(15)@nzawh(22)@ywwxi(49)@phnuqn(44)@ylnobx(5204)->rziopi,mzutqi,lcitl@gumncu(24)@cjgtra(900)->nfkfex,rhqfb,oyyctv@gjgrhw(94)@paeel(87)@xiqthw(87)@ogowst(176)->pdzooh,xlccnkv@mevujmj(83)@tlqjsb(994)->odxpup,znagag,obmcr@ejoxsy(38)->lxwkpqh,zdelqb,xyang,gtbgp,onzind,wabzx,kzjtb@agthzo(15)@xyvnk(32)@crchwpb(36)@pjoqde(76)@fgcajp(50)@tefdmi(44)@xctuhbx(72)@tokyi(79)->yapfoe,yyecrv@njxrb(60)@qotyaq(7)@dnbejx(70)@uhrdeol(171)->qinne,opskc,zxmwy,dgqfrv@cwxspl(12)->nnciip,hbbpp@nggubzz(84)@uuunqk(9)@lxttas(133)@xvdmeo(7)@gkkit(84)@wexncjl(295)@jgsmitm(173)@pxxabj(33)->wgupfl,lpdhdvy,lfliwg,fklfgd@ruedk(146)->kgwftu,xlacmu@ydpemw(3192)->ymkgx,nhtfal@ibqrz(96)@oyyctv(34)->ipnvjje,tvbgr@xfcktep(13)@jblwph(81)->lxexhp,vbqpp@steez(38)@xnxudsh(78)->pjlxc,nfywcyp@rxjly(133)->rftuf,hzehjo@eteyvz(23)@eohjrft(55)@wqilo(32)@tbmyue(54)@nkwwia(1405)->dsjcqpn,irokors,wzbewii@oausk(31)@rpjfkh(55)@mxnaq(3937)->glcsinj,icush,wjrhp@kviiza(70)@anggtqq(86)@uuxpvxf(114)->nhjtvk,vezhmd@yrolq(64)@tkjofj(60)->mjqkaqs,lnfjj,nakli@nasbs(70)@usevjww(15)@valby(106)->vgfhpwb,xtnvc@zxygmaq(10)@tdmirp(75)@zodwdpq(93)@uyhrcfl(76)@mqgbif(73)@oqjqu(67)->xbxxe,yjwvnhl,vmsoc,tlpfhx,rxjly,dyazidi@euwab(49)->cdfmatu,wawtrk@admjq(40)->qvaayfl,uqynzy@petvm(24)@zqpxn(196)->himyt,zvtfm,xpotznx@nxxlbnt(34)@kpbawoe(26)@zlhpt(74)->zvbqni,iytvm,htitjjt,aqxaecv@kkmax(37)@recxxj(53)@ejhojmh(56)@dnovxt(44)@crslvc(69)@fnayjx(64)@lytrpo(47)@auvuxv(242)->wqojj,ndikjqv@zesfmu(37)@cnffplo(166)->fuaio,pywtg@dfmjy(399)->isxysg,dxlpr@xcfxvd(92)@xznhz(54)@mclqrmw(15)@cqvdpy(62)->yzcez,nvrjzg,sebvkw,pgaiut,bggovyb,wfsaglg,teygd@fewgct(90)@xaden(108)->jagajrh,fucxhz@xvhgvw(36)@ejekn(98)->kemkz,souqntk@hsvmept(30)@zwopz(60)->byedxex,yxbaldn,hnkvw,lvkeqm,kigyp,ruedk@uqynzy(80)@axzszf(167)->iiuqtqw,vktjns@gugxitg(553)->trlcj,olawkuc,xeihyok@wugia(2689)->temju,xkymbld,ntlrkw@lxexhp(35)@scnhwcs(74)@yhukqf(50)@upozls(20)@qladcl(44)@wjgjhc(5)@fucxhz(93)@nayvvrh(25)->ejtdhx,oyurlfq@oonpy(15)->wyryqvy,zkgdtp@xowkw(41)@zildb(116)->umjcr,pinqp,piizso@hrrld(1802)->pqiuhyp,nkwwia,exsmez,rarkt,hsdym@lzojty(214)@uzljl(710)->pmolg,benqzp,khfzis@vyinb(154)->fzyim,vrfme,hjbfr@syogw(36)->mevujmj,wpphwjv@qyfsc(47)@wvvivob(6)@wksjlix(81)@reomle(191)->jacmj,amcixd@fzyim(20)@zfipnh(21)@uopxjn(64)@gaxdd(25)@dzwfsix(87)@nrxyk(29)@vbjpz(13)@kgxfc(30)->kzjozhi,dtqgdc@nfkfex(134)->vsjjq,nduildw@cpujsn(22)@weipv(91)@wjceo(184)->resoi,gaxdd@unkkoph(119)->myhnuu,lcmlbj@lnfjj(50)@bmmzqxb(81)@gzocw(110)->qkjdjpe,yxxdal@uxjaa(131)->coapfqs,kxrbd,rkctaq,xfyqx@jimltsw(16)@nptqxtu(95)@rpwdig(10)@xflhoc(20092)->bqyqwn,hycgb,nrgzcge@jfofam(6042)->gewpohj,ndticx,xflhoc@syvza(99)@whrinsh(34)@coapfqs(20)@souqntk(98)@rpgzp(44)@wgupfl(65)@jxawk(34)@zeolg(214)@qzvobt(53)@nmazby(120)->yijwaf,idmqvse,dsmjo,wqilo@yuiyjpc(862)->eavas,lxttas,codkti@rkuzg(83)@gdvuw(179)->vrtgae,teqej@pinqp(59)@xtnvc(99)@gppwsbp(35)@exsmez(1357)->pralyx,tkmfbk,unkkoph@ewvvb(83)@nlfdps(87)@jmuqp(44)@mieuhe(97)@donzb(407)@igbzlxl(27)@invqsb(5)@xxdcgas(30)->auezw,wwbebbr@qhkhuow(44)@sgytd(62)@ikzap(5388)->mjrktxe,tlqjsb,yuiyjpc@kvvkbhi(55)@xahvbm(222)->udgssh,bbbhx@iiuqtqw(45)@isrgei(173)@ntlrkw(36)->gkwyfz,acjedny,mcucysr@qxugs(31)->iqmpc,lrtzi,krgtrdn@sebvkw(214)->qotyaq,dhvsrt@gcswiam(1183)->vahmn,cwfydbh,cjjytkr@ncuzpin(39)@sybvdj(83)@obzrtar(62)@thhakxn(103)->pplis,tykcvi,mklqpn,jzgvab@vtjtyp(152)->dhisacj,zpxgfq,oqeam,fcgkmq,nnyws,qxugs,oxoul@icxzod(15)@nakli(50)@bzmqg(374)@dhisacj(73)->rndvcf,oqmxlu,ncuzpin@pdzooh(13)@pvyrkg(51)->yytmc,clqfbvi,tmkli@scvhl(28)@qwotm(169)->pqrpkmd,whrinsh@dcpzwz(87)->wxgoew,xqwfgy,hrjlzxr,wapknj,ejoxsy@qsdyww(55)@puvmdie(41)@umjcr(59)@himyt(41)@tptqtpq(57)@zkwajbd(61)@vutdji(31)->bsvgagj,puvmdie,liujmc,xowkw@lpsaav(94)@bmcwbsi(96)@rtbcch(64)@nadbegy(66)@jyazs(74)@xcmzg(30)@abxglwt(191)->pmopji,jtxjj,asevk,yznmd,jfsgqq@tzimies(65)@jfhzgp(67)@wyryqvy(90)@kirnt(134)->bmlfd,fykgs@xhgza(16)@xajzwdh(65)@tpcbt(81)@zmoxc(99)@bcbftl(38)@arrvxtj(71)@imiimt(22)@tqelui(86)@sibvtz(79)@pchfpqp(86)@faopk(147)->figvamv,jlsmm@wscqe(14)->ezzpr,chyun@emkgc(142)->lcrbt,pcvfgti@nreuwh(62)@vahmn(49)->twyhx,rztur,pchfpqp,anggtqq@eourjv(204)->kpbawoe,zjwqc@ssvfbfs(96)@dxlpr(8)@sgovqnf(69)->kzsoasg,dnbejx@eoxwp(133)->zxygmaq,xadjes,nulax,rpwdig@ydffzgu(380)->olvztw,zfipnh@byojhfr(97)@nlwakg(161)@ztxcc(68)@zisdcf(18)@itutdol(55)@cseckdt(11)@zqwqcnq(37)@fhqhu(188)->igbzlxl,llalaql,ppjapn,csdap@kzsoasg(70)@cvqbwem(92)->wjceo,gqqsfsr,vukpdsr,cneno,bvaoy@pjujovx(96)->ayuma,bmmzqxb@vjobpzv(24)@kerjk(84)@qvaayfl(80)@bcesxba(444)@hnyjyga(95)@gjjfx(131)->btwmd,xznhz,dsezlbe@idmqvse(32)@ygqxl(16)->nhvyso,talptwp,qiznqk,ugzmeb@ozyqew(95)@itxgz(370)->epqowm,jrhzmbj@afntec(96)@cgveph(71)@isxysg(8)@cqlvkj(65)@ykitsi(63)@bjhxuqc(53)@uahcz(50)@vbejzc(38)@cujuai(157)->ldqyt,fgcajp@kgphv(246)->wvvivob,sjoov@gqqsfsr(78)->ckudisa,kwhgtnk@dofou(44)@uijffti(65)@nkzgse(7)@xrtzs(96)->ictsk,invra,rkgoovn,gzocw,hbptt,ucilvib,cnffplo@zvbqni(105)->qkzpcyy,qsrxouy@zqbpucs(568)->dfmjy,fnnykbh,gqeiy,fifams@lnndami(68)@rcluk(156)->fjticim,mbbuqoi@zylotoh(7)@phcqntb(76)@amcixd(29)@jlsryou(95)@rceksnv(57)@vwnvlh(1534)->krnbkr,egizyey,empixc,lzojty,vyinb,zeolg,qxnvoh@chyun(94)@hrjlzxr(1124)->ybixf,qmshniw,zrnlkl@bwlit(20)@grxdbx(34)@eqgvf(9)->wdbmakv,zqamk,hvecp,rbzmniw,jfofam,tigvdj@uqals(78)->ropdc,pbdafpz,mgqil,pygrhr,eourjv@veuzidj(49)->kmhug,yrolq,csfzl@eovobtl(149)->hzuyh,iftcnc@udgssh(5)@nxbec(96)@dyomhm(40)->npxexv,xbccghy,jncjxue,nadbegy@fsdoohr(64)@lcrbt(29)@rarkt(1387)->mjqzvuu,nzhbfc,veuzidj@temju(53)->qpzszp,cqlvkj@nrgxdmx(1352)->mlalrpt,nqfqgj,cuscn,ogowst,vfrylx@tlpfggk(25)@wzimze(4005)->uwjkolt,jynmg,ibqmynm@ddgnyfo(79)@fyaxzl(18)@qpzszp(65)@eitdb(197)->trvtkqj,kwnqw@fgsmzi(525)->dzuqljn,ihvefep,uhrdeol,gdvuw@nevrtrs(83)@jyftx(76)@lcitl(1114)->nlwakg,hwgwzv,girxc@kzjtb(78)->gacseeh,lycfbo,aifpxqv@zacwh(5)@glcsinj(90)->aemkbp,yxxgd,fhqhu,xquhgig,nxmhned,lqbmor,qmyfg@rswnjx(57)@cokvree(96)@ewgadin(39)@oqsdzpe(50)@yznmd(62)->uvkwg,mncivb@lpdhdvy(65)@kmhug(64)@bvtgvu(94)@hycgb(237)->zmciyk,ysbhsn,vxslvq@ycuuwxa(161)->vehziv,rvqopbu@mieqogh(19)@xadcuw(1626)->chgfb,stofi@supjxi(21)@rfqddq(53)@qbaosu(314)->hshafy,ukgbdva@ptxfk(73)@lofybs(89)@agjpn(8265)->ocgbpez,ejdxula,kgbzu@mgbgb(334)->kksizqf,dofou@izxpf(39)->ewobo,ntezb,sbmqxu,tlpfggk@znagag(89)@zmciyk(19)->mieuhe,psjec@dhobx(95)@hvecp(90)->hrrld,jazqb,fonrb,dcpzwz,vqinar,bxqqvue@sjbfmfa(80)->fewgct,jupzgjm@fmpvv(74)@bcadp(91)@tmzxl(23)"

	for i=1:1:$length(pInput,"@") {
		set tBase=$piece($piece($piece(pInput,"@",i),"->",1),"(",1)
		for j=1:1:$length($piece($piece(pInput,"@",i),"->",2),",") {
			set tTemp=$piece($piece($piece(pInput,"@",i),"->",2),",",j)
			continue:tTemp=""
			w j,!
			w $piece($piece(pInput,"@",i),"->",2),!
			set tArray(tBase,tTemp)=1
		}
	}
	
	set tNode=$O(tArray(""))
	set tBase=tNode
	while tNode'="" {
		set tSkip=0
		set tSubNode=$O(tArray(tNode,""))
		while tSubNode'="" {
			if tSubNode=tBase {
				set tBase=tNode
				set tNode=$O(tArray(""))
				set tSkip=1
			} else {
				set tSubNode=$O(tArray(tNode,tSubNode))
			}
		}
		set:'tSkip tNode=$o(tArray(tNode))
	}
	
	quit tBase
}

ClassMethod Day7P2(pInput = "") As %String
{
	set:pInput="" pInput="bqyqwn(68)->wscqe,cwxspl,syogw,xnxudsh@ddswb(34)@hnkvw(320)@ibqmynm(252)->oglcdgs,tkjofj,upurae,oypvhy,bzfkt,hdvcz,cfwxyl@rkerea(87)@lcmlbj(66)@vtccvv(69)@nachvlp(20)@tmkli(66)@exuyuk(82)@ojzogs(79)@egkiqcp(37)->rxjnad,psetts@xadjes(10)@fivkqxx(121)->acvzsbe,kkmax,qcmwsvm@krgtrdn(53)@mxemqqb(267)->iuuouds,qqmvd@iwwqvoa(24)@yyecrv(59)@zjpkoar(40)@ilsgqdw(37)@bmlfd(43)@nxqwag(81)@ubbwvvl(44)@khfzis(48)->ztxcc,bvejguc@gvtcy(39)@xbxxe(173)->bzjxil,amklj@qejgaf(25)@uunpyb(82)@dmidur(57)@fklfgd(65)@vcjfe(22)@rkjfx(33)@ioglbe(88)@tymkixg(36)@qbhhtw(90)@afbrhy(79)@nswcez(47)@wzjonl(16)@xviqup(95)@claolm(312)->ndmkbul,rpjfkh@qhlhfk(387)->iwwqvoa,rmshk,ftezz@vtokttx(55)@boalcdm(13)@angpy(62)->fitha,itxgz,pyiexlj,wqshh,rloxobx@gwcdf(32)@jpscxfh(46)->qsakd,exuyuk,dqdmie,kjwfeoj@qkzpcyy(96)@fifams(415)@yseezd(11)@qcmwsvm(37)@hfnhd(152)->vdcfh,ufrhi@wfgzr(82)@sjoov(6)@fonrb(7531)->xohxq,cmsqe,jefsr@pyhof(21)@pplis(9)@fosdh(90)@pjkyydd(15)@wvmtyez(46)@bzfkt(66)->rauho,xctuhbx@zyqssjb(13)->olebdv,byahs,xajzwdh@wotus(119)->dndrnc,tebkmhi,qejgaf@rusndcc(39)->xcfxvd,kvylxr,vwkegak,oiuztx@stofi(16)@mgqil(66)->noibcw,nptqxtu@qjzss(31)@hawhqex(71)@kjjee(174)->lltgjo,gwcdf@gdamb(99)@diqdy(183)->gackyrq,vcjfe,lcnsf@sfwzqk(54)->rkuzg,ewvvb@vktjns(45)@urwaex(59)@nyouzhg(17)->lofybs,baedi@mklqpn(9)@iktget(33)@gxtfu(57)@xkymbld(37)->mqgbif,ptxfk@qjeuqe(92)@benqzp(92)->wvmtyez,gmveehb@rkctaq(20)@sbwoye(50)@bujufb(148)->tduxvx,lxzvkpk,jllqymn,csrpy@cwfydbh(369)->qcmtgvr,tyvjs@cjjytkr(305)->trszl,fgzgfc@qsakd(82)@domway(2464)->kgphv,pjujovx,hrdggo@mrpji(61)@kzrgfb(92)@hocazx(818)->bmukspb,mgbwxw,gyirkcj,kgxfc@bobvssz(25)->srvqt,alhghui,wnjaw,qhlhfk,lsbvzaf,qjkfys,nnncfl@rrzyzq(76)@eaufvn(78)->dtazpb,nlajc@tduix(18)@yzcez(62)->rlxto,vkaxa@uvpuko(91)@xtnmps(95)->ptatzl,bujufb,oybbzr,zwopz,phqpwkw@ibeis(54)@ofkvpq(500)->auvuxv,stqmwk,dptekr@pmolg(166)->uuunqk,uolqt@byedxex(180)->gsaqlad,ebwubc@aicjff(67)@vtcxw(860)->ezlfnhs,aizdt,ylbftp@nzuswm(80)->ojzogs,qfopwo@hgwbg(89)@sflonq(190)->gppwsbp,mpvgy@pqiuhyp(52)->xbtjl,jykseco,aftnyad,xaden,urdgg,ijkpfv,ejekn@ccgjf(99)@devsz(38)@vmmtsr(33)@ebwubc(70)@mgcnohi(69)@klege(92)@jtlqxy(66)@ofbqk(148)@ewluica(22)@mulvwn(290)->ubbwvvl,jmuqp,dnovxt@trlcj(245)@uezwz(20)@bbtnj(170)->xvwok,rqyxzn@ndticx(54)->rbtco,bobvssz,umtxk,domway,wugia,ubvttg,ydpemw@lxwkpqh(325)->xoigv,fqsjaz@mpvgy(35)@ujgeml(94)@jkoir(6)@kemkz(98)@dtqgdc(90)@girxc(147)->zylotoh,qtxmjwm@olawkuc(79)->earmfdp,wnowypb@umrqldb(99)@oyurlfq(57)@flgpg(188)->jimltsw,xhgza@wawtrk(80)@nlajc(85)@ewqcktv(1364)->hfnhd,amqvr,ntxcpwl@dmvyuf(35)@vtdbov(50)@xnszvs(65)@mjrktxe(50)->eoxwp,jgsmitm,isrgei,rnbgz,kymbvpp,ktjdpt,mgzocpe@zicvok(81)@tkmfbk(93)->ffhsg,kynezb@vlwvot(84)@oybbzr(1007)->qstlv,nayvvrh,izxpf,habni,ckfefl,fjdlcbh,thhakxn@qiksfr(44)@wowxv(92)@fmdba(44)@zgxbjj(96)@jncjxue(66)@xquhgig(190)->rqhfxty,maftysp@habni(27)->xwknab,xukfcd,scvhl,tcbgf@iftcnc(50)@dqdmie(82)@otlvq(40)->hjsrvj,rtbcch,vpirde@mgzocpe(51)->zkwajbd,mrpji@fkzxb(89)@jlsmm(32)@igdkn(43)->dgtxjuj,jxyakll,kptdem@rftuf(43)@uolqt(9)@rtwlo(78)->wgbvle,npttye,claolm,ydffzgu,mgbgb,jwjuth,mulvwn@nrgzcge(132)->bywbrk,vazoq,eaufvn@juoaena(94)@wfsaglg(54)->nlfdps,tdkdiqe@jfsgqq(100)->crslvc,esized@mcucysr(49)@tcbgf(28)@mlalrpt(166)->jtbrjm,fyaxzl@srvqt(155)->jyftx,dtijfqc,phcqntb,uyhrcfl@xohxq(1457)->czbydf,wgdnyy@lqbmor(230)->rkjfx,vmmtsr@jjsyexg(38)@ynvesz(88)->rqaxn,afntec@ibbxb(194)->imiimt,llikz@ktasnia(49)->thkjz,cjgtra,tzngdx,cqjsqh,vtjtyp,lyzaead,xrtzs@vsjjq(30)@yjnzgl(67)@mcrhiy(6559)->mkgafux,gugxitg,tymmo@nlgymop(139)->tymkixg,crchwpb@ybosi(18)@rhqfb(179)->okurp,gpwbcg,invqsb@kzjozhi(90)@ixncawy(28)@ooczbeh(36)@ubvttg(796)->wuuvnlz,donzb,bwgimi,rywtmt,rusndcc,ceagctk@ohcoit(6)@exrud(176)->hpziqqg,abxglwt,gozhrsf,oqjqu,vhkodl@opvrgh(79)@blyms(46)@vfrylx(10)->qhkniqm,bmcwbsi@ndmkbul(55)@mohey(86)->tbmyue,ibeis@wktzh(93)@ystgyng(50)@jclntv(87)@dsjcqpn(133)->slufzy,gbbpqj,jxawk@fitha(68)->faqngn,xguqqao,athuly,fmdsfus@xyang(225)->njxrb,mfwuqb@acjedny(49)@mfwuqb(60)@ayuma(81)@qqmchoq(7)@yzjhmqq(171)->dinpz,upozls@qfopwo(79)@srypr(64)@tvwmzal(236)->cpujsn,ewluica@umtxk(2942)->jyazs,scnhwcs,fmpvv,aahqvqy@gkwyfz(49)@dodrbx(227)->uhtnl,vxnsova@sfdclf(238)@kksizqf(44)@dfofyir(236)->ddswb,grxdbx@qakiz(37)@ceagctk(255)->bwvlnlt,rkazlp,vbejzc,njhlrtm@hnjszii(284)->zkdwz,bwlit@gbbpqj(34)@bvaoy(114)->mogwbda,rodntl@vkihn(36)@symdxo(8)@nduildw(30)@nxhfgx(18)@chgfb(16)@gugaaiq(40)@euvrdg(79)@ckzaj(67)@jupzgjm(90)@llalaql(27)@qdnghwn(16)@iffluz(515)->bbbvmxo,reomle,vspqi@nvrjzg(214)->nzfko,qqmchoq@xvwok(34)@enmjipp(95)@jtbrjm(18)@rlxto(83)@xpotznx(41)@lslhph(59)@vhkodl(221)->otlvq,fioegdo,rreidgp,fivkqxx,xahvbm@mncivb(88)@hbhfdlh(89)@mkgafux(688)->admjq,tqtut,emkgc@tymmo(22)->uxjaa,nlgymop,dcvfkk,yzjhmqq,iqjqlfq,faopk@vxslvq(37)->jmvcgo,ioglbe@rxjnad(80)@ejdxula(92)->kviiza,uqmaluk,nasbs@xvzoy(35)@vukpdsr(162)->gumncu,mlzmimg,vjobpzv@xoigv(10)@iuehdsr(21)@jzgvab(9)@odxpup(89)@vwkegak(92)@bsvgagj(41)@mxwgu(310)->yeyxf,qdnghwn@jynmg(1140)->wotus,mohey,fiynyre@qftwuv(36)@veabcj(67)@zaargo(30)->ytrsmfx,jtlqxy@xfbfvuu(65)@gpwbcg(5)@elysbb(81)@engpslr(85)@tqbtvqc(31)@faqngn(98)@jykseco(166)->xawzbz,fsdoohr@nfywcyp(62)@rreidgp(168)->vfupn,xyvnk@obmcr(89)@spnllx(76)@mbbuqoi(35)@wjxgg(177)->symdxo,dsptf,yaxeloo,yxrhis@chcjswk(89)@anamgt(346)->ywwxi,rnbvid@zjwqc(26)@wxgoew(1481)->hnjszii,ygqxl,xhkwrs@dydcy(76)->drnki,uxolsws,lrcstqr@npttye(42)->wkrgvo,jhydv,enmjipp,hnyjyga@yjwvnhl(219)@fykgs(43)@vrmqym(97)->lrmnb,nvigovl@gkfdg(226)->ohcoit,jkoir@ictsk(122)->devsz,jjsyexg@gixezcy(37)@rywtmt(158)->nevrtrs,sybvdj,qcorw@pwhtvdh(40)@yapfoe(59)@xnnbqju(90)->xzsmw,petvm,xyxidwf@vxiwms(99)@htaszsq(87)@mgbwxw(52)->afbrhy,jrsfu@rdzsisf(59)@qvxanzu(262)->nxhfgx,vvzmdr,inddon,ybosi@ysbhsn(181)->wleavrv,kmvvxon@tirifqs(6489)->ofbqk,iqdiez,kspsz,kejph@rnkbli(84)@bjbndbg(169)->oqsdzpe,sbwoye,yhukqf@dndrnc(25)@oxzhz(86)->bcbftl,hjzgzoe@ufrhi(68)@gsyeaes(26)@kgbzu(180)->wzczb,bzqjb@dgtxjuj(97)@xulgx(5)@wleavrv(16)@qnhbmzp(118)->wktzh,zodwdpq@csrpy(62)->zmoxc,ccgjf,umrqldb,gdamb@ldqyt(50)@btwmd(54)@volompq(96)@qmshniw(443)@lrmnb(98)@yijwaf(32)@paoxff(98)@ulbute(95)@lyzaead(939)->jfqddfd,ucpkpfb,sbmwazv@rodntl(60)@tykcvi(9)@aftnyad(188)->rfqddq,recxxj@zdelqb(155)->jaasf,snqnh@akwcv(65)@nszqngg(44)@eavas(45)->ytsmc,mrxdp,prjpkm,nzawh@fqvbdq(96)->tzimies,jduij@mabcqcb(194)->itutdol,vtokttx@trvtkqj(49)@ynlzggk(36)@pggjo(19)@jajdx(19)@ackyirz(16)@gtiopzn(49)@idvnxqp(5)@njsjq(273)->vptdap,eteyvz@qkjdjpe(44)@dzfon(61)->wksjlix,zicvok,utiwem@nxmhned(166)->pekohn,xnszvs@pnqycz(43)->gkkit,khyca,yudzxoa@lvkeqm(192)->lneyu,uopxjn@qvrvcu(19)@hvwyae(23)@ocgbpez(114)->gjgrhw,bvtgvu@mehuxr(53)@pmdcajx(7)@ybixf(299)->xvhgvw,ooczbeh,ksbwlir,pkzwosb@inlft(36)@hshafy(65)@nzfko(7)@vcnael(95)@nxuer(13)@pulql(59)->akwcv,uijffti,ysxvzdu,xfbfvuu@hlbotz(13)@zhrdezs(28)@aqxaecv(297)@ppjapn(27)@bbbvmxo(21)->rceksnv,uhnlse,rswnjx,ogcmm@ikvzux(44)@hdvcz(156)->zisdcf,keurs,bjops@ytsmc(22)@jiwfia(13)@jthpj(44)@dtijfqc(76)@vgfhpwb(99)@sjmhuxn(11)->aceyee,iohigm,zildb,vrmqym,pxxabj,gjjfx@byahs(65)@qllime(202)->dspkk,wgtnepi@ksbwlir(36)@hzawlq(16)@kgwftu(87)@qtzelhq(62)@wabzx(209)->sfazwz,lnndami@dyazidi(219)@resoi(25)@hgwkyu(91)@urdgg(166)->srypr,fnayjx@hsfhqhe(17)@metif(68)@ifxzdfy(96)->ssnpxj,ejhojmh@jefsr(477)->fqvbdq,xsygbj,rcluk,dcero,lfgqgs@oglcdgs(140)->dmvyuf,xvzoy@jrhzmbj(45)@mlvhqpe(91)->qsstg,tnrrui,utsnke,gxtfu@iffxdk(87)@xboqv(17)@hppxlu(174)->lkjhmiq,kntwy,auhnyn@pralyx(191)->dmkfnm,xcmzg@osnkrr(53)@nhvyso(77)@mogwbda(60)@rqaxn(96)@vxnsova(5)@xsxnizc(50)@hskhxx(36)@ogcmm(57)@drnki(25)@ecjxs(197)@dnniv(16)@wnjaw(369)->brvxyyg,hsvmept,praagwp@xjcxk(24)@aahqvqy(74)@hpwaux(97)@sadyx(59)@dptekr(112)->xiqthw,ihtfo@mlmhe(4563)->uwxjkq,uqals,ofkvpq,pyxdkm@yytmc(66)@hmbuu(16)@ezzpr(94)@zpxgfq(118)->tqplqn,fysxwmd@hgkmod(75)@earmfdp(83)@mxpgmte(5)@kcfgbv(73)->fdeowqq,pbzvjg,tzrqwt@jtxjj(120)->hiuviy,sadyx@dsptf(8)@dsezlbe(54)@onzind(245)->wayzzn,ystgyng@pjndde(422)->yseezd,cseckdt@rnbgz(131)->iuehdsr,xgzluhk@yswonja(195)->gachtig,bjadb,gtiopzn@piizso(59)@msqxo(47)@jacmj(29)@hjsrvj(64)@prcxksh(20)@aceyee(219)->gixezcy,zqwqcnq@pkipy(95)@czbydf(75)@bpguivk(32)@utapoe(84)@qjdou(87)@njhlrtm(38)@pkzwosb(36)@wpphwjv(83)@teqej(66)@lneyu(64)@dicalia(44)@opzxu(46)@gasejp(15)@llikz(22)@uhtnl(5)@kntwy(25)@wzbewii(157)->myetb,dhwakp,vqtalpm@vkaxa(83)@kwnqw(49)@uhnlse(57)@zqamk(37518)->mflijpx,ikzap,wzimze,agjpn@fnnykbh(91)->nxqwag,tpcbt,elysbb,xlaqpg@ytrsmfx(66)@pyiexlj(92)->oozbxqb,kzrgfb,klege,csfjt@yaxeloo(8)@tzbmy(71)@pjecv(56)@gsaqlad(70)@gmzcjo(76)@cuscn(114)->fmdba,ikvzux@rbzmniw(52959)->tespoy,tirifqs,exrud@jzoxv(52)@egizyey(78)->metif,towuup@uxolsws(25)@twyhx(86)@nqjydpi(44)->rpgzp,nszqngg,jthpj,qiksfr@avecfoq(95)@wltax(21)@xfyqx(20)@tnrrui(57)@gmveehb(46)@kymbvpp(67)->qzvobt,osnkrr@xbccghy(66)@iqdiez(134)->wkkmvcn,nkzgse@pmopji(128)->gpcyq,qsdyww@cfwxyl(210)@khzqqwi(12)@wjrhp(992)->nyouzhg,ccxff,qmifv,oonpy,vutdji,owukmji@yvlajs(35)@hkltivy(26)@vylzag(33)@mieynp(21)@jppbvbo(929)->ynvesz,tvwmzal,mbwaxn@yxxgd(296)@utiwem(81)@ihvefep(110)->ffzzzc,ckzaj,zfyqzi@vfupn(32)@jhydv(95)@vspqi(201)->wzjonl,dnniv,pdazlob@iohigm(248)->icxzod,mclqrmw,pjkyydd@hzehjo(43)@kwhgtnk(78)@npxexv(66)@lycfbo(89)@vezhmd(47)@amqvr(274)->aditjen,xvdmeo@vbqpp(35)@upurae(33)->rdzsisf,lslhph,urwaex@uvkwg(88)@wapknj(2443)->xulgx,idvnxqp@mvgmf(105)->dicalia,qhkhuow,phnuqn@qmifv(163)->hzawlq,ackyirz@xlacmu(87)@aesiz(86)@jjiikvt(25)@prjpkm(22)@rbtco(1110)->dfofyir,qnhbmzp,dzfon,zmdkea,valby,mabcqcb,mifwbmm@greav(20)@dmkfnm(30)@ftezz(24)@iuuouds(14)@jwjuth(390)->hmbuu,oxlzlor@gzwrv(212)->efqjc,gasejp,qqooh@wgdnyy(75)@rqhfxty(53)@qhpvuzi(75)@cvxqnh(53)@stqmwk(96)->vcnael,dhobx@wuuvnlz(206)->pznkdcr,ucfipvi,jfhzgp@nnyws(190)@bbbhx(5)@qdfvw(69)->hgwkyu,uvpuko,wclnx@inddon(18)@gyirkcj(138)->inlft,vkihn@lrtzi(53)@pjlxc(62)@slufzy(34)@zkdwz(20)@tigvdj(44217)->xtnmps,ylnobx,mlmhe@vptdap(23)@aemkbp(35)->dwrtbo,rkerea,iffxdk@dpngy(17)@nzhbfc(207)->hvgozl,hsfhqhe@wayzzn(50)@myhnuu(66)@jrsfu(79)@gqeiy(257)->opvrgh,sibvtz@xgzluhk(21)@fiynyre(156)->mieqogh,zpaivc@vqtalpm(26)@thkjz(437)->insleik,ayjse,sgovqnf,wjxgg,euwab@ylbftp(82)->epcjds,gsyeaes@ndikjqv(22)@tqplqn(36)@aifpxqv(89)@hjbfr(20)@lltgjo(32)@picnycy(33)@kplvk(24)@ptatzl(314)->sfdclf,ibbxb,slzpby,kjjee,bbtnj,gkfdg,nzuswm@qtxmjwm(7)@ckudisa(78)@opskc(35)@qhkniqm(96)@rqyxzn(34)@vdcfh(68)@hpziqqg(637)->ypqkl,nmazby,hxswr@vrfme(20)@ozdnanh(34)@qcmtgvr(12)@gvdlvgg(20)@krnbkr(82)->qladcl,tefdmi,ocdpr@fyxttac(39)@hbbpp(95)@hjzgzoe(38)@hjqsj(85)@asevk(44)->hpwaux,byojhfr@fgzgfc(44)@ejtdhx(57)@ntxcpwl(36)->kerjk,nggubzz,utapoe@fqsjaz(10)@hxswr(74)->bixxpzd,htaszsq@dinpz(20)@yxxdal(44)@wozakri(251)->mgcpbp,omslcm@dhwakp(26)@kvylxr(92)@lsbvzaf(75)->ibqrz,cokvree,volompq,zgxbjj@bixxpzd(87)@xbtjl(294)@dyfzj(95)@utsnke(57)@sxjlr(91)@ckfefl(115)->khzqqwi,fzwzr@ezlfnhs(62)->qftwuv,ynlzggk@xguqqao(98)@jazqb(7378)->xadcuw,hocazx,cqvdpy@dsmjo(32)@gpcyq(55)@dhvsrt(7)@jllqymn(110)->dzwfsix,paeel,jclntv,qjdou@zkgdtp(90)@mjqkaqs(50)@nzcqte(140)->wkkdc,pwhtvdh,gugaaiq@woypnze(91)@dcriqom(79)@zppujp(34)@aqacmr(18)@rkazlp(38)@fysxwmd(36)@mzutqi(571)->qdfvw,mxwgu,yswonja@zfyqzi(67)@wqshh(460)@rztur(86)@bdlnohy(584)->dodrbx,qwotm,cbavt,mvgmf,igcmpn@qqmvd(14)@uwxge(94)@ijkpfv(218)->rxcgwd,steez@slzpby(136)->nxxlbnt,ozdnanh,zppujp@dzuqljn(7)->spnllx,fpeiss,hjzkjuw,pjoqde@dporud(50)@hrdggo(152)->agztuz,mehuxr@kigyp(65)->hjqsj,ijtis,engpslr@qcorw(83)@cmsqe(12)->njsjq,zqpxn,pulql,fkttd,wozakri@keurs(18)@pyxdkm(872)->xnnbqju,oxzhz,zaargo@pjhpwh(35)@vdlbwyo(24)@ocdpr(44)@gacseeh(89)@xzsmw(24)@liujmc(41)@myetb(26)@xawzbz(64)@qmyfg(114)->weipv,woypnze@heisrl(36)@mlzmimg(24)@ayjse(75)->veabcj,aicjff@htitjjt(203)->nswcez,msqxo@xhkwrs(324)@tdkdiqe(87)@ukgbdva(65)@qmcphv(32)@fmhfnhv(24)@nhjtvk(47)@sbmqxu(25)@ewobo(25)@hvgozl(17)@ysxvzdu(65)@sfazwz(68)@hlwesdc(24)@wgbvle(422)@ugzmeb(77)@hbptt(138)->uezwz,gbckkh,gvdlvgg@auezw(95)@lkuwf(95)@cneno(190)->uwjobru,jeadxth@wkrgvo(95)@koxzeku(79)@vehziv(67)@codkti(71)->tqbtvqc,oausk@kjwfeoj(82)@dcvfkk(111)->uahcz,xsxnizc@lcnsf(22)@zzwmn(40)@bywbrk(80)->rnkbli,vlwvot@jpmrs(94)@lfgqgs(187)->vbjpz,hlbotz,boalcdm@xbnmg(48)->aesiz,tqelui@pcvfgti(29)@ucpkpfb(181)@blkewbk(64)->jlsryou,idokb,avecfoq,ozyqew@mbwaxn(240)->nachvlp,prcxksh@wgsgaj(17)@fzwzr(12)@mgcpbp(34)@jxyakll(97)@fdeowqq(77)@zxmwy(35)@yudzxoa(84)@wwbebbr(95)@wgtnepi(66)@wkkdc(40)@xlccnkv(13)@yxrhis(8)@uwjobru(22)@csfzl(64)@dspkk(66)@xwknab(28)@fmdsfus(98)@vpirde(64)@nulax(10)@ymkgx(23)@psetts(80)@ucfipvi(67)@hsdym(340)->onjqcrh,eitdb,ycuuwxa,mxemqqb,pnqycz,wexncjl@wqojj(22)@xiiqh(98)@cqjsqh(360)->bzmqg,jpscxfh,ercxmph@wnowypb(83)@snqnh(95)@mifwbmm(114)->tfezflv,qxrspl@fcgkmq(68)->thftfut,svtqdbd@gachtig(49)@qxnvoh(214)@ihtfo(87)@qxrspl(95)@nnciip(95)@ercxmph(318)->ixncawy,zhrdezs@iqmpc(53)@rnbvid(49)@xukfcd(28)@bjadb(49)@niifkl(90)@kxrbd(20)@lrcstqr(25)@gackyrq(22)@cbavt(161)->qvrvcu,uhuees,pggjo,jajdx@mahlbe(6)@llpbev(29)@efqjc(15)@efvqwzi(7)@epqowm(45)@fjdlcbh(139)@csfjt(92)@zrnlkl(63)->dyfzj,xviqup,atrzkqf,ulbute@xsygbj(130)->vdlbwyo,ciquv,msdcz,kplvk@cdfmatu(80)@xeihyok(81)->uunpyb,wfgzr@ssnpxj(56)@wclnx(91)@nnncfl(335)->sgytd,nreuwh@cdjxwb(99)->buznuv,hkltivy@aditjen(7)@auhnyn(25)@nvigovl(98)@yeyxf(16)@uwxjkq(905)->jblwph,cdjxwb,dydcy@lkjhmiq(25)@teygd(170)->llpbev,nrxyk@jaasf(95)@dwrtbo(87)@hwgwzv(57)->qqqbf,fnslg@alhghui(279)->qbhhtw,ltytvpb@mjqzvuu(195)->hvwyae,tmzxl@wzczb(61)@ciquv(24)@gozhrsf(762)->ifxzdfy,uuxpvxf,zyqssjb@khyca(84)@atrzkqf(95)@psjec(97)@xyxidwf(24)@esized(69)@towuup(68)@trszl(44)@fkttd(141)->hbhfdlh,hgwbg@olvztw(21)@tebkmhi(25)@ltytvpb(90)@msdcz(24)@csdap(27)@vqinar(2904)->qhbrmur,nrgxdmx,angpy,gcswiam@yxbaldn(122)->vxiwms,syvza@swgjx(6)@mflijpx(75)->oxypy,rtwlo,vwnvlh@pygrhr(144)->rdorrx,pjecv@alneot(25)@wdbmakv(42933)->ktasnia,mxnaq,mcrhiy@fjticim(35)@rsfxf(123)->yjnzgl,glrmew@tyvjs(12)@gbckkh(20)@dgqfrv(35)@oozbxqb(92)@oypvhy(140)->yvlajs,pjhpwh@fnslg(52)@vhzfut(96)->obzrtar,qtzelhq@iqjqlfq(59)->gmzcjo,rrzyzq@amklj(23)@tvbgr(80)@qsrxouy(96)@rauho(72)@tzrqwt(77)@pdazlob(16)@uhuees(19)@qebqgxd(94)@ffhsg(79)@hzuyh(50)@oiuztx(92)@wjdeth(5)@bjops(18)@bwvlnlt(38)@baedi(89)@irokors(39)->xiiqh,paoxff@zvtfm(41)@aizdt(54)->zjpkoar,zzwmn@ffzzzc(67)@oxoul(12)->fkzxb,chcjswk@dcero(34)->ssvfbfs,nxbec@rloxobx(421)->jiwfia,nxuer,xfcktep@foznw(146)->dpngy,wgsgaj,xboqv@buznuv(26)@tduxvx(326)->iktget,vylzag,picnycy,lfdery@hiuviy(59)@dtazpb(85)@oxlzlor(16)@bvejguc(68)@uwjkolt(52)->tvxvtce,igdkn,rteyxil,qvxanzu,qllime@rvqopbu(67)@owukmji(195)@pbzvjg(77)@agztuz(53)@zpaivc(19)@nofpmh(290)->efvqwzi,pmdcajx@mhnnmp(8)->qbaosu,pjndde,anamgt,bcesxba,blkewbk@zfqmic(67)->lkuwf,pkipy@tespoy(5)->bdlnohy,jppbvbo,fgsmzi,sjmhuxn@qhbrmur(1450)->kcfgbv,dyomhm,nofpmh@lkdyq(57)@fuaio(16)@ccxff(53)->cgveph,tzbmy@fioegdo(140)->opzxu,blyms@bgnfpcr(75)@bmukspb(106)->jzoxv,gqvmeg@sbmwazv(39)->arrvxtj,hawhqex@xqwfgy(1496)->cywvxf,bjbndbg,mlvhqpe@jfqddfd(64)->ewgadin,fyxttac,gvtcy@empixc(142)->hlwesdc,xjcxk,fmhfnhv@zmdkea(154)->bgnfpcr,hgkmod@jeadxth(22)@ucilvib(40)->ddgnyfo,koxzeku@rteyxil(334)@clqfbvi(66)@lfdery(33)@ijtis(85)@rmshk(24)@kptdem(97)@ropdc(226)->usevjww,agthzo@talptwp(77)@bzqjb(61)@idokb(95)@kynezb(79)@tvxvtce(52)->ujgeml,jpmrs,lpsaav@athuly(98)@vazoq(248)@rxcgwd(38)@tfezflv(95)@cywvxf(279)->greav,kybtla@lfliwg(65)@qjkfys(353)->bjhxuqc,cvxqnh@vvzmdr(18)@gwuixj(31)@svtqdbd(61)@nqfqgj(22)->niifkl,fosdh@lxzvkpk(458)@gewpohj(16410)->cvqbwem,uzljl,zlhpt,vtcxw,iffluz@bggovyb(144)->supjxi,mieynp,wltax,pyhof@pbdafpz(236)->wjdeth,zacwh,mxpgmte,wjgjhc@pqrpkmd(34)@maftysp(53)@qqqbf(52)@fpeiss(76)@qsstg(57)@oqeam(128)->qjzss,gwuixj@brvxyyg(30)@oqmxlu(39)@tlpfhx(147)->heisrl,hskhxx@icush(877)->rsfxf,zfqmic,axzszf,gzwrv,cujuai@jagajrh(93)@kejph(98)->alneot,jjiikvt@acvzsbe(37)@gqvmeg(52)@olebdv(65)@tqtut(74)->ykitsi,wxvjyn@tzngdx(486)->pvyrkg,hppxlu,eovobtl,diqdy@vmsoc(61)->euvrdg,dcriqom@qiznqk(77)@kspsz(112)->tduix,aqacmr@kybtla(20)@ktjdpt(23)->tdmirp,qhpvuzi@jmvcgo(88)@hjzkjuw(76)@qinne(35)@ypqkl(64)->qjeuqe,wowxv@epcjds(26)@mrxdp(22)@pznkdcr(67)@kmvvxon(16)@xlaqpg(81)@nhtfal(23)@bxqqvue(5668)->zqbpucs,mhnnmp,ewqcktv@ipnvjje(80)@noibcw(95)@pywtg(16)@omslcm(34)@sxdngcn(6)@insleik(209)@wxvjyn(63)@ntezb(25)@klkwsa(57)@figvamv(32)@phqpwkw(1192)->egkiqcp,ecjxs,foznw,tokyi@onjqcrh(67)->lkdyq,tptqtpq,dmidur,klkwsa@igytdcp(160)->vtdbov,dporud@vrtgae(66)@bwgimi(242)->eohjrft,ankrgg,kvvkbhi@bzjxil(23)@ankrgg(55)@okurp(5)@rndvcf(39)@rkgoovn(104)->qyfsc,lytrpo@thftfut(61)@jduij(65)@invra(180)->sxdngcn,mahlbe,swgjx@wkkmvcn(7)@igcmpn(55)->bcadp,sxjlr@pgaiut(90)->vtccvv,mgcnohi@iytvm(15)->juoaena,qebqgxd,uwxge@glrmew(67)@uqmaluk(70)@qstlv(75)->qmcphv,bpguivk@gtbgp(234)->ilsgqdw,qakiz,zesfmu@rziopi(57)->flgpg,nqjydpi,xbnmg,xxdcgas,vhzfut,sfwzqk,kirnt@rdorrx(56)@oxypy(1992)->sflonq,igytdcp,nzcqte,sjbfmfa@pekohn(65)@praagwp(30)@qqooh(15)@nzawh(22)@ywwxi(49)@phnuqn(44)@ylnobx(5204)->rziopi,mzutqi,lcitl@gumncu(24)@cjgtra(900)->nfkfex,rhqfb,oyyctv@gjgrhw(94)@paeel(87)@xiqthw(87)@ogowst(176)->pdzooh,xlccnkv@mevujmj(83)@tlqjsb(994)->odxpup,znagag,obmcr@ejoxsy(38)->lxwkpqh,zdelqb,xyang,gtbgp,onzind,wabzx,kzjtb@agthzo(15)@xyvnk(32)@crchwpb(36)@pjoqde(76)@fgcajp(50)@tefdmi(44)@xctuhbx(72)@tokyi(79)->yapfoe,yyecrv@njxrb(60)@qotyaq(7)@dnbejx(70)@uhrdeol(171)->qinne,opskc,zxmwy,dgqfrv@cwxspl(12)->nnciip,hbbpp@nggubzz(84)@uuunqk(9)@lxttas(133)@xvdmeo(7)@gkkit(84)@wexncjl(295)@jgsmitm(173)@pxxabj(33)->wgupfl,lpdhdvy,lfliwg,fklfgd@ruedk(146)->kgwftu,xlacmu@ydpemw(3192)->ymkgx,nhtfal@ibqrz(96)@oyyctv(34)->ipnvjje,tvbgr@xfcktep(13)@jblwph(81)->lxexhp,vbqpp@steez(38)@xnxudsh(78)->pjlxc,nfywcyp@rxjly(133)->rftuf,hzehjo@eteyvz(23)@eohjrft(55)@wqilo(32)@tbmyue(54)@nkwwia(1405)->dsjcqpn,irokors,wzbewii@oausk(31)@rpjfkh(55)@mxnaq(3937)->glcsinj,icush,wjrhp@kviiza(70)@anggtqq(86)@uuxpvxf(114)->nhjtvk,vezhmd@yrolq(64)@tkjofj(60)->mjqkaqs,lnfjj,nakli@nasbs(70)@usevjww(15)@valby(106)->vgfhpwb,xtnvc@zxygmaq(10)@tdmirp(75)@zodwdpq(93)@uyhrcfl(76)@mqgbif(73)@oqjqu(67)->xbxxe,yjwvnhl,vmsoc,tlpfhx,rxjly,dyazidi@euwab(49)->cdfmatu,wawtrk@admjq(40)->qvaayfl,uqynzy@petvm(24)@zqpxn(196)->himyt,zvtfm,xpotznx@nxxlbnt(34)@kpbawoe(26)@zlhpt(74)->zvbqni,iytvm,htitjjt,aqxaecv@kkmax(37)@recxxj(53)@ejhojmh(56)@dnovxt(44)@crslvc(69)@fnayjx(64)@lytrpo(47)@auvuxv(242)->wqojj,ndikjqv@zesfmu(37)@cnffplo(166)->fuaio,pywtg@dfmjy(399)->isxysg,dxlpr@xcfxvd(92)@xznhz(54)@mclqrmw(15)@cqvdpy(62)->yzcez,nvrjzg,sebvkw,pgaiut,bggovyb,wfsaglg,teygd@fewgct(90)@xaden(108)->jagajrh,fucxhz@xvhgvw(36)@ejekn(98)->kemkz,souqntk@hsvmept(30)@zwopz(60)->byedxex,yxbaldn,hnkvw,lvkeqm,kigyp,ruedk@uqynzy(80)@axzszf(167)->iiuqtqw,vktjns@gugxitg(553)->trlcj,olawkuc,xeihyok@wugia(2689)->temju,xkymbld,ntlrkw@lxexhp(35)@scnhwcs(74)@yhukqf(50)@upozls(20)@qladcl(44)@wjgjhc(5)@fucxhz(93)@nayvvrh(25)->ejtdhx,oyurlfq@oonpy(15)->wyryqvy,zkgdtp@xowkw(41)@zildb(116)->umjcr,pinqp,piizso@hrrld(1802)->pqiuhyp,nkwwia,exsmez,rarkt,hsdym@lzojty(214)@uzljl(710)->pmolg,benqzp,khfzis@vyinb(154)->fzyim,vrfme,hjbfr@syogw(36)->mevujmj,wpphwjv@qyfsc(47)@wvvivob(6)@wksjlix(81)@reomle(191)->jacmj,amcixd@fzyim(20)@zfipnh(21)@uopxjn(64)@gaxdd(25)@dzwfsix(87)@nrxyk(29)@vbjpz(13)@kgxfc(30)->kzjozhi,dtqgdc@nfkfex(134)->vsjjq,nduildw@cpujsn(22)@weipv(91)@wjceo(184)->resoi,gaxdd@unkkoph(119)->myhnuu,lcmlbj@lnfjj(50)@bmmzqxb(81)@gzocw(110)->qkjdjpe,yxxdal@uxjaa(131)->coapfqs,kxrbd,rkctaq,xfyqx@jimltsw(16)@nptqxtu(95)@rpwdig(10)@xflhoc(20092)->bqyqwn,hycgb,nrgzcge@jfofam(6042)->gewpohj,ndticx,xflhoc@syvza(99)@whrinsh(34)@coapfqs(20)@souqntk(98)@rpgzp(44)@wgupfl(65)@jxawk(34)@zeolg(214)@qzvobt(53)@nmazby(120)->yijwaf,idmqvse,dsmjo,wqilo@yuiyjpc(862)->eavas,lxttas,codkti@rkuzg(83)@gdvuw(179)->vrtgae,teqej@pinqp(59)@xtnvc(99)@gppwsbp(35)@exsmez(1357)->pralyx,tkmfbk,unkkoph@ewvvb(83)@nlfdps(87)@jmuqp(44)@mieuhe(97)@donzb(407)@igbzlxl(27)@invqsb(5)@xxdcgas(30)->auezw,wwbebbr@qhkhuow(44)@sgytd(62)@ikzap(5388)->mjrktxe,tlqjsb,yuiyjpc@kvvkbhi(55)@xahvbm(222)->udgssh,bbbhx@iiuqtqw(45)@isrgei(173)@ntlrkw(36)->gkwyfz,acjedny,mcucysr@qxugs(31)->iqmpc,lrtzi,krgtrdn@sebvkw(214)->qotyaq,dhvsrt@gcswiam(1183)->vahmn,cwfydbh,cjjytkr@ncuzpin(39)@sybvdj(83)@obzrtar(62)@thhakxn(103)->pplis,tykcvi,mklqpn,jzgvab@vtjtyp(152)->dhisacj,zpxgfq,oqeam,fcgkmq,nnyws,qxugs,oxoul@icxzod(15)@nakli(50)@bzmqg(374)@dhisacj(73)->rndvcf,oqmxlu,ncuzpin@pdzooh(13)@pvyrkg(51)->yytmc,clqfbvi,tmkli@scvhl(28)@qwotm(169)->pqrpkmd,whrinsh@dcpzwz(87)->wxgoew,xqwfgy,hrjlzxr,wapknj,ejoxsy@qsdyww(55)@puvmdie(41)@umjcr(59)@himyt(41)@tptqtpq(57)@zkwajbd(61)@vutdji(31)->bsvgagj,puvmdie,liujmc,xowkw@lpsaav(94)@bmcwbsi(96)@rtbcch(64)@nadbegy(66)@jyazs(74)@xcmzg(30)@abxglwt(191)->pmopji,jtxjj,asevk,yznmd,jfsgqq@tzimies(65)@jfhzgp(67)@wyryqvy(90)@kirnt(134)->bmlfd,fykgs@xhgza(16)@xajzwdh(65)@tpcbt(81)@zmoxc(99)@bcbftl(38)@arrvxtj(71)@imiimt(22)@tqelui(86)@sibvtz(79)@pchfpqp(86)@faopk(147)->figvamv,jlsmm@wscqe(14)->ezzpr,chyun@emkgc(142)->lcrbt,pcvfgti@nreuwh(62)@vahmn(49)->twyhx,rztur,pchfpqp,anggtqq@eourjv(204)->kpbawoe,zjwqc@ssvfbfs(96)@dxlpr(8)@sgovqnf(69)->kzsoasg,dnbejx@eoxwp(133)->zxygmaq,xadjes,nulax,rpwdig@ydffzgu(380)->olvztw,zfipnh@byojhfr(97)@nlwakg(161)@ztxcc(68)@zisdcf(18)@itutdol(55)@cseckdt(11)@zqwqcnq(37)@fhqhu(188)->igbzlxl,llalaql,ppjapn,csdap@kzsoasg(70)@cvqbwem(92)->wjceo,gqqsfsr,vukpdsr,cneno,bvaoy@pjujovx(96)->ayuma,bmmzqxb@vjobpzv(24)@kerjk(84)@qvaayfl(80)@bcesxba(444)@hnyjyga(95)@gjjfx(131)->btwmd,xznhz,dsezlbe@idmqvse(32)@ygqxl(16)->nhvyso,talptwp,qiznqk,ugzmeb@ozyqew(95)@itxgz(370)->epqowm,jrhzmbj@afntec(96)@cgveph(71)@isxysg(8)@cqlvkj(65)@ykitsi(63)@bjhxuqc(53)@uahcz(50)@vbejzc(38)@cujuai(157)->ldqyt,fgcajp@kgphv(246)->wvvivob,sjoov@gqqsfsr(78)->ckudisa,kwhgtnk@dofou(44)@uijffti(65)@nkzgse(7)@xrtzs(96)->ictsk,invra,rkgoovn,gzocw,hbptt,ucilvib,cnffplo@zvbqni(105)->qkzpcyy,qsrxouy@zqbpucs(568)->dfmjy,fnnykbh,gqeiy,fifams@lnndami(68)@rcluk(156)->fjticim,mbbuqoi@zylotoh(7)@phcqntb(76)@amcixd(29)@jlsryou(95)@rceksnv(57)@vwnvlh(1534)->krnbkr,egizyey,empixc,lzojty,vyinb,zeolg,qxnvoh@chyun(94)@hrjlzxr(1124)->ybixf,qmshniw,zrnlkl@bwlit(20)@grxdbx(34)@eqgvf(9)->wdbmakv,zqamk,hvecp,rbzmniw,jfofam,tigvdj@uqals(78)->ropdc,pbdafpz,mgqil,pygrhr,eourjv@veuzidj(49)->kmhug,yrolq,csfzl@eovobtl(149)->hzuyh,iftcnc@udgssh(5)@nxbec(96)@dyomhm(40)->npxexv,xbccghy,jncjxue,nadbegy@fsdoohr(64)@lcrbt(29)@rarkt(1387)->mjqzvuu,nzhbfc,veuzidj@temju(53)->qpzszp,cqlvkj@nrgxdmx(1352)->mlalrpt,nqfqgj,cuscn,ogowst,vfrylx@tlpfggk(25)@wzimze(4005)->uwjkolt,jynmg,ibqmynm@ddgnyfo(79)@fyaxzl(18)@qpzszp(65)@eitdb(197)->trvtkqj,kwnqw@fgsmzi(525)->dzuqljn,ihvefep,uhrdeol,gdvuw@nevrtrs(83)@jyftx(76)@lcitl(1114)->nlwakg,hwgwzv,girxc@kzjtb(78)->gacseeh,lycfbo,aifpxqv@zacwh(5)@glcsinj(90)->aemkbp,yxxgd,fhqhu,xquhgig,nxmhned,lqbmor,qmyfg@rswnjx(57)@cokvree(96)@ewgadin(39)@oqsdzpe(50)@yznmd(62)->uvkwg,mncivb@lpdhdvy(65)@kmhug(64)@bvtgvu(94)@hycgb(237)->zmciyk,ysbhsn,vxslvq@ycuuwxa(161)->vehziv,rvqopbu@mieqogh(19)@xadcuw(1626)->chgfb,stofi@supjxi(21)@rfqddq(53)@qbaosu(314)->hshafy,ukgbdva@ptxfk(73)@lofybs(89)@agjpn(8265)->ocgbpez,ejdxula,kgbzu@mgbgb(334)->kksizqf,dofou@izxpf(39)->ewobo,ntezb,sbmqxu,tlpfggk@znagag(89)@zmciyk(19)->mieuhe,psjec@dhobx(95)@hvecp(90)->hrrld,jazqb,fonrb,dcpzwz,vqinar,bxqqvue@sjbfmfa(80)->fewgct,jupzgjm@fmpvv(74)@bcadp(91)@tmzxl(23)"

	for i=1:1:$length(pInput,"@") {
		set tBase=$piece($piece($piece(pInput,"@",i),"->",1),"(",1)
		set tBaseWeight=$e($piece($piece($piece(pInput,"@",i),"->",1),"(",2),1,*-1)
		for j=1:1:$length($piece($piece(pInput,"@",i),"->",2),",") {
			set tTemp=$piece($piece($piece(pInput,"@",i),"->",2),",",j)
			continue:tTemp=""
			set tArray(tBase,tTemp)=0
		}
		set tArray(tBase)=tBaseWeight
	}
	
	set tNode=$O(tArray(""))
	set tBase=tNode
	while tNode'="" {
		set tSkip=0
		set tSubNode=$O(tArray(tNode,""))
		while tSubNode'="" {
			if tSubNode=tBase {
				set tBase=tNode
				set tNode=$O(tArray(""))
				set tSkip=1
			} else {
				set tSubNode=$O(tArray(tNode,tSubNode))
			}
		}
		set:'tSkip tNode=$o(tArray(tNode))
	}
	
	d ##class(AOC.Y2017).Day7P2CalcWeight(tBase,.tArray)
	
	set tNode=tBase
	set tVal=0
	set tGoal=0
	set tContinue=1
	while tContinue {
		k tSubVals
		set tSubNode=$O(tArray(tNode,""))
		set tCount=0
		while tSubNode'="" {
			set tCount=tCount+1
			set tSubVals(tArray(tNode,tSubNode))=$G(tSubVals(tArray(tNode,tSubNode)),0)+1
			set tSubNode=$O(tArray(tNode,tSubNode))
		}
		
		set tFound=0
		set tSubNode=$O(tArray(tNode,""))
		while tSubNode'="" {
			if (tSubVals(tArray(tNode,tSubNode))'=tCount) && (tSubVals(tArray(tNode,tSubNode))=1) {
				set tFound=1
				set tNode=tSubNode
			}
			if tFound {
				set tSubNode=""
			} else {
				set tSubNode=$O(tArray(tNode,tSubNode))
			}
		}
		
		if 'tFound {
			set tTemp=$o(tSubVals(""),-1)
			set tVal=tArray(tNode)-(tTemp*tSubVals(tTemp))-(tArray(tNode)-tGoal)
			set tContinue=0
		} else {
			set tGoal=$o(tSubVals(""))
			while tSubVals(tGoal)=1 {
				set tGoal=$o(tSubVals(tGoal))
			}
		}
	}
		
	/*
	set tSubNode=$O(tArray(tBase,""))
	while tSubNode'="" {
		zw tArray(tBase,tSubNode)
		set tSubNode=$O(tArray(tBase,tSubNode))
	}
	break
	*/
	
	quit tVal
}

ClassMethod Day7P2CalcWeight(pNode = "", ByRef pArray) As %String
{
	set tSubNode=$O(pArray(pNode,""))
	set tWeight=0
	set tSubWeight=0
	set tPrevSub=tSubNode
	while tSubNode'="" {
		set tTempWeight=##class(AOC.Y2017).Day7P2CalcWeight(tSubNode,.pArray)
		set tWeight=tTempWeight+tWeight
		/*
		if tSubWeight="" {
			set tSubWeight=tTempWeight
		} elseif tSubWeight'=tTempWeight {
			if 
		}
		set tWeight=tWeight+
		*/
		set pArray(pNode,tSubNode)=pArray(tSubNode)
		set tPrevSub=tSubNode
		set tSubNode=$O(pArray(pNode,tSubNode))
	}
	set pArray(pNode)=tWeight+pArray(pNode)
	quit pArray(pNode)
}

ClassMethod Day8P1(pInput = "") As %String
{
	set:pInput="" pInput="yxr inc 119 if nev != 6@piw dec -346 if tl != 4@cli inc 165 if nev >= -5@nev dec 283 if xuu > -2@tem inc 745 if qym >= -9@xuu dec -104 if cli == 165@h dec 192 if u <= 5@ln dec -616 if ej > -7@tem dec -555 if ar > -5@tem dec 687 if tl > -8@h inc 120 if re < -8@bq dec -410 if ej > -4@re dec 476 if tem == 613@ej dec 686 if cli != 163@ar dec 676 if tl > -6@nfo inc 633 if s == 0@tl inc -471 if tem > 607@bb inc 157 if piw > 342@cli inc -830 if piw != 342@piw inc -645 if ar >= -674@bq dec 304 if piw != 356@u inc -274 if bb != 147@yxr inc -520 if ec >= 1@ec dec 631 if bb > 147@ar dec 732 if s >= 0@foz inc -617 if bb == 157@qym dec -197 if ej == -686@bb dec 111 if h <= -199@ln dec -585 if re != -476@foz dec -181 if nev < -280@foz dec 989 if xuu != 106@ec inc -930 if ec <= -626@foz dec 862 if s >= 5@tem inc 241 if xuu == 104@ar dec -460 if h >= -201@cli inc -317 if cli == -665@bb dec -483 if h > -194@tem inc -718 if tl <= -466@ln dec 362 if hb == 0@qym inc 95 if hb > 3@piw dec -463 if ln < 246@xuu inc 159 if s <= 5@ec inc -710 if cli < -977@bb inc -98 if xuu >= 260@qym inc 159 if bb >= 540@acc inc 610 if fe <= 9@ar dec 381 if ej < -695@acc dec 807 if nev > -284@foz dec 926 if h < -188@tl inc 279 if ar != -957@ec dec -39 if acc < -191@u dec -110 if piw == 346@ej dec 980 if ar == -948@ln dec -165 if hb < 2@nfo inc -370 if tem > 128@ar dec -886 if ar < -947@bb dec 624 if ej == -1666@tl inc 36 if ec > -2227@yxr dec 320 if cli <= -976@tem inc -808 if ar >= -52@cli dec 213 if h >= -198@ej inc -141 if nev < -281@bq inc -736 if yxr > -211@u dec -742 if nfo > 258@bq dec -727 if ar >= -64@u dec -248 if bq > 89@xuu inc 431 if yxr > -203@hb dec -407 if hb >= -7@ar inc 789 if acc >= -197@yxr inc -753 if piw <= 350@piw dec -973 if yxr >= -956@xuu dec 457 if ec <= -2228@bq inc -201 if bq >= 97@bq dec -923 if ar == 727@cli inc -560 if piw < 1329@ej dec -150 if ar != 733@h inc -198 if nev == -283@u inc -388 if piw == 1319@hb inc -212 if s < 8@xuu inc -988 if ej < -1653@ec inc 58 if re >= -485@hb inc -126 if xuu < -741@ar inc 534 if nev == -273@fe inc 668 if s <= 7@tem dec 25 if h >= -390@u inc -632 if tl > -198@u dec 721 if bq > 813@piw dec -299 if foz >= -2348@hb inc -407 if ej > -1663@h dec 563 if foz == -2351@bb dec 362 if fe != 670@nev inc -512 if bb != -437@fe dec -419 if yxr < -948@tl dec 576 if ej > -1665@acc dec -510 if xuu > -759@s dec -108 if u < -906@xuu dec -407 if xuu < -748@yxr dec 771 if bb > -454@u dec -879 if tem != 110@bq inc -759 if u < -27@s dec -295 if qym < 364@qym inc 807 if xuu == -344@h inc 545 if hb == -338@ej inc -896 if s != 394@s dec -961 if yxr > -1723@s dec -142 if nev != -799@s inc -692 if ln != 427@ar dec 152 if tl == -763@acc dec 304 if piw != 1328@ar inc -532 if piw != 1324@bq inc 124 if tem < 109@h inc 480 if nfo == 268@xuu dec -291 if ej >= -2556@hb inc -56 if nfo >= 257@ar dec -656 if bb > -447@tl dec -458 if ec <= -2167@xuu inc -100 if hb <= -397@nev dec 384 if foz <= -2344@acc dec -779 if acc == 9@u inc 949 if h != -416@xuu inc -865 if nev < -1182@nev dec 317 if bb < -434@foz inc -786 if bq > 51@xuu inc -901 if ej >= -2557@nev dec 750 if h != -398@qym dec 783 if re != -480@bb dec 54 if cli < -1752@tl dec -803 if yxr < -1724@s inc 690 if xuu != -954@piw inc -667 if s != -151@foz dec -946 if cli <= -1757@h dec -885 if re == -486@ar inc -765 if re < -468@h dec 340 if ec != -2170@fe dec 440 if tl > 492@re dec 398 if hb != -384@xuu inc -49 if fe > 641@s dec 623 if qym != 375@piw inc 429 if ec == -2174@ej inc 747 if hb != -394@xuu inc 761 if nfo > 255@re inc 519 if yxr != -1716@nev inc 863 if tl <= 499@qym inc -357 if foz > -3138@tl dec 186 if u < 915@s dec -442 if nev < -1373@bq inc -999 if ec == -2174@cli inc 735 if acc > 781@ar dec -983 if nev >= -1389@cli inc 285 if u < 917@xuu inc -970 if h >= -747@bq inc 716 if tl < 310@xuu dec 984 if bb > -503@h inc -881 if ej >= -2546@u inc 719 if fe >= 646@u inc 396 if hb > -393@ej inc 734 if acc != 784@fe inc 581 if re <= -350@piw dec -69 if hb < -384@ec dec 540 if acc < 798@cli dec -615 if foz <= -3130@ln inc 261 if foz <= -3130@acc dec 739 if ar > 1065@ln dec -520 if qym > 19@re inc -260 if bq != -230@ln inc -28 if h > -750@hb dec -794 if s == -325@nfo inc 79 if ln < 1176@acc inc 173 if ec == -2714@yxr inc 756 if re > -616@re inc 415 if fe >= 1219@hb dec -701 if u < 1638@xuu dec -325 if re != -200@ln dec -552 if piw != 1157@yxr inc -568 if qym >= 17@tl dec 756 if ec <= -2712@nev dec 430 if xuu <= -1219@bq dec -580 if yxr >= -1533@ej dec -357 if bb >= -493@ec inc 722 if ej >= -1822@tl dec 168 if nev == -1813@bb dec -393 if foz >= -3130@cli inc -298 if s == -328@h inc 885 if yxr != -1536@nev dec -188 if cli < -427@yxr dec 41 if cli > -416@qym inc 748 if u == 1632@re inc 457 if nfo > 339@yxr inc 781 if piw < 1153@qym inc 628 if cli != -417@bq inc -476 if piw < 1142@bb dec 547 if nfo >= 341@s dec 590 if piw == 1150@piw inc -804 if nfo != 342@ar dec -838 if xuu == -1226@ec inc 224 if h > 132@ec dec -963 if ln >= 1731@xuu inc 109 if u <= 1638@s dec -191 if fe >= 1220@ln dec -718 if h >= 133@u dec 46 if nev >= -1811@nfo inc -56 if s < -718@nev dec -346 if ar != 1905@h dec -501 if hb != 306@acc dec 651 if bb >= -1039@xuu dec 714 if ar > 1905@qym dec 304 if piw <= 1157@tl dec -62 if foz < -3138@h inc 448 if qym != 1095@hb inc 780 if tem != 112@hb dec 332 if tem <= 114@s dec -447 if acc != 226@s dec -560 if ej > -1829@nev dec -435 if piw == 1150@nev dec 259 if piw < 1155@tem inc 293 if nfo == 286@hb dec 656 if s < 284@hb inc -484 if acc < 213@ln inc 831 if s < 280@hb dec -394 if ec != -1771@nfo inc 124 if h != 628@ln dec -675 if yxr < -754@bb dec -69 if hb == 494@ln inc -139 if re <= 261@nev inc 325 if yxr >= -753@tl inc 551 if foz != -3137@bb dec -598 if nfo != 413@qym inc 771 if s >= 271@tl inc 903 if ej != -1820@fe inc -388 if re != 250@ln dec -163 if ej != -1827@nev dec -209 if re <= 261@bq inc -59 if h == 638@ej inc 793 if yxr < -749@ec inc -224 if s >= 276@ln inc 895 if foz <= -3132@acc dec -681 if ec < -1989@tem dec -161 if hb == 493@ar dec -436 if nfo >= 408@u dec -56 if re != 250@nfo inc -497 if hb < 495@ec dec -874 if acc > 911@bb dec 988 if xuu == -1838@nfo dec -257 if fe > 836@ec inc -332 if foz >= -3146@u inc 697 if u <= 1691@ej dec 777 if bb <= -440@nfo dec -99 if bq > -277@acc dec 552 if tem <= 573@fe dec 74 if ec == -2317@qym dec 829 if foz >= -3146@bq dec -149 if ec <= -2324@u dec -99 if hb == 493@yxr dec -546 if tl > 288@u inc 261 if cli >= -412@ej inc -341 if tem < 574@ec inc -83 if ar <= 2346@ec inc 847 if xuu <= -1830@re dec -364 if xuu < -1839@yxr inc -483 if ln <= 4033@tl dec 965 if tl == 286@re inc -63 if tl >= -674@cli inc 708 if acc < 352@xuu dec 494 if ej > -2154@tl inc 8 if foz > -3131@ec inc 983 if nfo == 170@bb inc 486 if cli < 292@ar dec -461 if ec >= -586@yxr dec -852 if hb < 500@u inc -874 if acc < 355@xuu inc 883 if re > 266@xuu dec 809 if ec == -577@tl dec 144 if ej > -2145@u inc -363 if fe >= 839@bb inc -194 if piw >= 1150@ln inc 780 if fe != 835@cli inc 213 if re >= 256@xuu dec -718 if hb >= 491@yxr dec -730 if u < 1251@nfo dec 1 if hb > 491@ar inc -556 if nev > -1085@ej dec -275 if bq < -128@nev dec -578 if foz != -3137@h inc -391 if h == 638@foz inc -291 if bq >= -134@bb inc -123 if fe == 840@tl dec 72 if bq == -133@qym dec -155 if yxr < 831@re inc 515 if s < 289@nfo dec -313 if ar >= 2242@cli dec 486 if tl < -904@bb dec -844 if ln >= 4810@hb inc -551 if tem == 565@ec inc -28 if yxr <= 828@cli inc -673 if h >= 241@re dec -937 if bb > 562@ec inc 214 if bb != 571@piw inc -142 if ar > 2240@ar dec 750 if tl < -898@re dec -844 if ej != -1877@bq inc -17 if qym <= 1200@acc dec -154 if foz > -3429@piw inc -13 if cli > -175@cli inc -374 if acc > 497@acc dec -751 if ln != 4821@xuu dec 821 if bq < -142@nev dec 867 if bb < 565@qym dec -883 if hb != -65@h inc -289 if ln <= 4818@hb dec 839 if s <= 282@cli dec 662 if ar > 2253@nev inc 975 if acc < 1249@foz inc -459 if nfo != 479@tem inc 721 if ar < 2244@hb dec 645 if bb >= 561@cli dec 973 if bq <= -148@qym inc 937 if piw <= 1003@bq inc -548 if tem != 561@nfo dec 98 if nev != -1082@u dec 789 if bq >= -688@u dec 389 if acc <= 1258@bq inc 818 if qym <= 3020@acc inc 224 if nfo < 492@ln inc -739 if re >= 2547@re dec -364 if fe != 843@piw dec -836 if piw > 991@foz inc 484 if cli < -1519@ln inc 869 if hb < -1533@piw dec 872 if yxr <= 834@bq inc -1 if bq >= 113@tl inc -649 if u >= 854@ec dec -447 if bb == 566@ar dec -702 if u < 861@s inc -445 if bb <= 574@xuu dec 323 if cli <= -1523@foz dec 589 if ln <= 4947@s inc -399 if nfo != 484@cli inc -704 if acc < 1481@yxr dec 712 if hb != -1534@nev dec -347 if nev <= -1087@ln dec -801 if foz > -4480@xuu dec -549 if h >= -47@re dec 127 if xuu > -2692@hb inc 96 if fe <= 845@acc dec 159 if hb >= -1451@bq inc 754 if u >= 865@u inc 23 if yxr > 106@re dec 940 if nfo <= 489@qym dec -599 if ar >= 2948@qym dec -481 if nfo == 482@nfo inc 767 if cli <= -2225@bb inc -174 if ec == 56@tem inc 615 if ec <= 55@tem inc 845 if re > 1848@hb inc 940 if tl > -1543@bq dec -892 if xuu >= -2686@bq inc 996 if bq >= 117@re dec 456 if u < 885@ln inc 879 if s < -568@s dec 605 if ar >= 2941@foz dec 585 if hb > -1449@ej inc 980 if ej <= -1866@re dec -409 if foz <= -5059@tem dec -394 if nfo != 476@yxr dec -765 if ej <= -888@ec inc -540 if fe < 843@cli dec 758 if foz != -5056@nfo inc 846 if re > 1802@re inc 800 if nev < -1078@nev dec 2 if yxr < 883@piw inc 282 if acc >= 1313@h inc -993 if ln <= 5741@ar inc 594 if tem <= 1804@h inc 502 if h >= -45@xuu inc -73 if acc <= 1326@re dec 116 if piw >= 1243@bq inc 62 if u <= 880@acc dec 166 if fe <= 846@ec dec -441 if re > 2612@re inc 214 if re != 2602@u dec 410 if s < -1160@ln dec -701 if piw <= 1244@tl inc -126 if nfo <= 1330@fe inc -861 if tl <= -1669@ar dec -998 if yxr <= 882@fe inc 629 if ln > 6445@hb dec -407 if foz <= -5071@s dec 654 if acc <= 1161@bb inc 304 if fe <= 615@xuu inc 979 if cli == -2969@cli inc -973 if fe == 607@cli inc 859 if tl <= -1665@tl dec 257 if foz > -5064@bq dec -253 if hb != -1446@s inc 82 if fe == 611@h inc -462 if xuu == -2761@nev dec 231 if bq <= 1123@fe inc -719 if re == 2817@nfo inc 553 if ec != -484@nev inc -457 if nfo != 1318@fe inc -936 if piw <= 1247@nev inc -615 if ar > 4539@fe inc -267 if ec >= -475@qym dec 336 if tem > 1802@ej inc 442 if foz > -5064@qym inc 864 if h < 0@nev inc 565 if foz >= -5057@tem inc 257 if ej <= -457@hb dec -202 if piw > 1243@bq dec -192 if ar != 4550@foz dec 374 if ln >= 6454@tem inc 381 if ej != -454@ec dec -630 if ej == -438@foz dec -821 if acc > 1161@nev dec 903 if bq != 1315@re inc -677 if ej > -448@re inc 588 if u < 473@xuu dec 114 if foz > -5062@acc inc -804 if ec > -492@nfo inc 728 if cli == -2120@xuu dec -258 if foz > -5064@tem dec -370 if ln < 6450@acc dec -717 if ej != -442@ec dec 262 if qym > 4613@nev inc 31 if u >= 468@xuu dec 84 if re == 2728@u inc 457 if xuu != -2697@acc dec 251 if acc != 1068@tem dec -745 if acc <= 1076@tl dec 581 if tem <= 3304@s dec -730 if hb <= -1444@ec dec 409 if tem < 3293@acc dec -884 if acc >= 1077@acc inc 160 if bb < 706@ar dec 110 if nfo != 2058@ej dec -349 if fe < -1038@s inc 681 if s >= -1096@cli inc -712 if fe < -1043@nfo dec 693 if u != 924@ln inc 170 if xuu != -2702@bb inc 759 if tl > -2518@ln inc 647 if tem > 3296@ej inc -35 if re >= 2734@qym inc 710 if nev < -3258@xuu inc 304 if fe == -1052@piw dec 237 if xuu >= -2707@tem dec -683 if hb <= -1441@piw inc -297 if re >= 2733@nfo dec -836 if bb == 1455@s inc 901 if u <= 921@bb inc 780 if bq == 1307@xuu dec 467 if yxr >= 878@acc dec -24 if h < 6@ec dec 412 if foz >= -5054@ec inc -990 if fe == -1047@nev dec -940 if nfo != 2208@ar dec -670 if qym == 5339@foz inc 391 if hb != -1438@yxr inc -86 if acc <= 1260@qym dec -36 if piw < 1008@nev inc -21 if yxr == 788@piw inc 581 if hb == -1446@bb inc -355 if bb != 2232@yxr dec 238 if ar < 4441@tem dec -974 if cli < -2826@xuu inc -237 if s <= -406@ej dec 51 if foz <= -4661@cli inc -416 if h < 6@fe inc 23 if s < -407@bq dec 598 if ej <= -152@cli inc -15 if piw > 1584@foz dec -781 if nfo < 2209@u inc 17 if bb < 1883@xuu dec 799 if ej >= -157@bb inc 914 if tem != 4960@foz dec 853 if fe != -1024@piw dec 628 if nfo != 2199@qym dec 303 if xuu >= -4207@bq dec 854 if yxr >= 549@hb inc -123 if xuu >= -4211@bb inc 767 if nev <= -2318@s inc 482 if nfo > 2196@yxr inc 185 if bb < 3570@yxr dec 683 if bq != 444@fe dec -316 if ec >= -1733@bb inc 368 if s < 78@tl dec 132 if yxr != 63@yxr dec 357 if bq == 453@fe inc -256 if ec > -1744@xuu inc -193 if ej <= -142@xuu dec -605 if cli != -3263@ar dec 571 if u != 945@nfo inc -430 if nfo < 2209@hb inc 236 if hb > -1564@ar dec -460 if fe < -1278@tl dec -127 if bq > 449@s inc -343 if nfo > 1764@fe inc 761 if nev < -2326@piw dec -136 if xuu != -4391@cli dec 639 if yxr >= -301@tl dec -524 if ar != 4890@ln dec -75 if ln < 7269@ln dec -376 if tem > 4956@yxr inc -317 if yxr >= -297@tem inc 593 if ej == -149@cli dec 297 if ar < 4894@ej dec -576 if xuu <= -4395@bq dec -681 if s >= -277@ec dec -404 if u >= 939@xuu dec -82 if yxr >= -292@nev inc -661 if u <= 954@yxr inc 941 if foz > -3896@ar dec 559 if ar < 4895@re inc 470 if tl <= -1981@qym inc 423 if hb <= -1564@ec inc -353 if cli >= -4208@qym inc 166 if nfo < 1770@ln inc 110 if h > -4@bb dec 459 if nfo < 1776@tem inc -466 if ej > 418@tem inc -223 if fe < -1271@bb inc 361 if qym > 5650@fe dec 698 if nfo <= 1768@h inc -761 if acc >= 1258@tl dec 307 if cli < -4195@ec dec -428 if bq == 1134@ec inc 200 if u == 945@fe dec 999 if re >= 3198@ej dec -150 if ej != 429@ar inc -19 if bb < 3822@cli inc -271 if piw == 1721@piw inc -317 if nev <= -2985@xuu dec 732 if xuu == -4393@ar dec -738 if bq != 1133@cli dec -925 if xuu >= -4400@tem dec -336 if acc == 1261@xuu dec -396 if tl < -2291@tem inc -726 if xuu < -3995@xuu inc 586 if yxr < 643@nfo inc 554 if re >= 3194@ln dec 425 if s < -276@s inc -678 if h >= -2@acc inc -669 if u == 945@nfo inc 136 if re <= 3207@nev inc -486 if fe > -2272@acc inc 146 if yxr < 650@bq inc 637 if u != 945@bq inc -562 if u < 949@fe dec -164 if tem >= 4128@ej inc -868 if ec > -1058@foz inc -646 if ej < -295@u inc 960 if bb < 3825@ln dec -6 if ln > 7826@bq dec 972 if acc > 723@piw inc 958 if fe != -2115@ln inc 179 if ln <= 7830@foz inc 206 if bb <= 3828@u inc -789 if bb > 3826@nev inc -597 if ln <= 8005@nev dec -112 if yxr <= 642@ej inc 670 if s <= -942@ec dec 623 if qym >= 5652@bb inc 35 if nev != -3470@u dec -50 if ej != 379@ar dec 952 if tl != -2306@tem inc -92 if re == 3192@yxr dec 866 if qym == 5652@nfo inc -457 if bb != 3876@tem inc 395 if fe != -2125@acc inc -37 if piw > 1711@tem dec -647 if fe <= -2113@tem dec -546 if xuu > -3422@piw dec 219 if acc < 699@ar dec -392 if piw == 1502@s inc 330 if bq > -407@bq inc -508 if nev <= -3473@ln dec -333 if cli != -3545@ln dec 42 if ec > -1683@acc inc -247 if ln <= 7966@foz inc 563 if tl <= -2287@ej inc -390 if ej <= 384@acc dec 659 if acc != 443@xuu dec -293 if ej >= -18@qym dec -169 if yxr > -217@cli inc 778 if ln >= 7960@xuu dec -179 if u != 163@nfo dec 600 if ej == -11@ar dec 261 if piw > 1492@re inc -889 if yxr > -228@h inc 37 if xuu != -2943@ln inc 148 if tem > 5731@bq dec 564 if piw == 1502@piw dec 822 if ar != 4242@xuu inc -35 if nfo != 1402@u dec -284 if cli > -2777@ar dec -521 if yxr >= -225@bb dec 412 if yxr <= -222@piw inc -199 if tem != 5715@bb inc 331 if qym < 5653@bq dec -359 if ec > -1687@acc inc 298 if bq == -605@bq inc -69 if tl < -2305@h inc -626 if h == 8@qym dec 609 if s <= -619@fe inc 165 if nev < -3456@xuu inc 690 if ej != -15@ec dec -280 if tl < -2294@qym dec 829 if bq != -610@xuu dec 888 if piw > 489@u inc 81 if acc > 80@qym dec 247 if h > -9@tl dec -558 if bq < -604@nfo dec 692 if ln == 7963@acc inc -23 if tl > -1735@xuu dec 478 if fe == -1950@s dec 551 if tl < -1736@ec inc -479 if fe == -1950@s dec -17 if foz > -3328@piw dec 351 if acc == 84@bq dec -437 if re == 2309@qym dec -808 if cli > -2774@h dec -390 if tl == -1738@foz dec 676 if ej >= -4@re dec 891 if bq != -167@bb dec -191 if re != 1418@nfo inc 380 if s == -1155@ec inc 69 if u < 531@nev dec -690 if s >= -1164@s dec 571 if bb >= 3776@re dec -224 if hb <= -1563@bq inc -252 if piw < 131@yxr dec -488 if tl == -1741@re inc 755 if re > 1638@bq inc -208 if qym != 4769@qym inc 695 if hb == -1563@fe inc -157 if piw < 121@xuu dec 579 if acc != 79@ln dec -262 if nfo > 1086@ec dec 235 if tl >= -1739@hb inc 188 if ej >= -13@s inc 124 if cli >= -2760@ec dec -643 if nfo != 1088@re dec -934 if fe > -1959@ej inc -58 if s == -1727@qym dec -558 if tl >= -1746@ln inc -555 if ec != -1402@foz inc -833 if cli != -2774@ln dec -589 if cli == -2775@tl inc -906 if re < 3334@tl inc 552 if fe < -1940@cli inc 976 if re >= 3322@bq inc -101 if xuu >= -3301@nev dec -217 if tl < -2087@ej dec 945 if u > 519@piw inc 447 if fe >= -1957@h inc 905 if piw <= 586@hb inc -995 if u == 521@acc inc 713 if tl >= -2100@ar inc -936 if ec <= -1400@tl inc 199 if u < 530@u dec 584 if ar != 3829@tl inc 787 if fe > -1954@ar inc 631 if qym >= 5325@tl inc -993 if ln < 8232@bq dec 900 if yxr > -231@u dec -226 if ln < 8235@yxr inc -966 if bq <= -1520@ar inc -83 if bq < -1520@bq dec 439 if bq == -1528@ej inc 608 if h < 1294@yxr inc 140 if nev >= -2567@qym dec 685 if nev >= -2566@re dec 957 if hb > -2378@tem dec -851 if bq <= -1966@nfo dec 421 if qym < 4649@acc inc 473 if ar == 4383@tem inc -407 if qym >= 4642@s dec -949 if tl >= -2103@h inc 549 if s >= -784@qym dec -311 if xuu >= -3308@s dec 751 if yxr > -1060@s inc -438 if ar != 4386@fe dec 734 if s <= -1965@ej inc 989 if hb == -2376@tl dec 84 if yxr > -1055@re dec 919 if ar < 4393@ec dec 314 if qym >= 4657@acc dec 572 if piw <= 579@bq dec -742 if tem >= 6166@ln inc 891 if qym < 4651@piw inc 125 if s >= -1956@nev inc 530 if piw != 577@ln inc 703 if nfo <= 670@bb inc 741 if foz >= -4155@ln inc -429 if u >= 163@ln dec -47 if nfo > 678@cli dec 217 if bq < -1222@tl dec -485 if fe >= -2690@tl dec -948 if fe == -2684@nfo inc 786 if qym != 4642@bb inc 336 if re != 1455@tl inc -8 if nfo != 1455@hb inc 173 if bq == -1225@s dec -53 if piw < 581@bq inc 905 if h == 1842@acc inc -450 if nev < -2551@ar dec 241 if s != -1914@bb inc 671 if ec <= -1400@acc inc 895 if fe <= -2691@fe dec 776 if s == -1913@foz inc -104 if nev >= -2558@nfo dec 629 if hb <= -2201@u dec 531 if ec < -1404@hb dec -37 if yxr < -1049@foz dec -586 if h <= 1848@nev inc -895 if acc == 248@qym dec 475 if bb <= 4461@piw inc 773 if fe < -3459@nfo dec -142 if cli == -2008@hb inc 103 if cli != -1999@bq inc 795 if ln == 9390@re dec 82 if nfo <= 975@u inc -275 if u != 163@xuu inc -599 if acc == 248@ln inc -642 if hb < -2069@hb dec 874 if nfo == 968@bb inc -283 if ej != 640@bq inc -999 if fe == -3460@tem dec 670 if tem != 6174@bb inc 890 if re > 1369@xuu dec 880 if foz >= -3678@ar dec -702 if ej == 641@h inc -43 if nev != -3453@tl inc -803 if qym >= 4166@ej inc 583 if foz > -3687@piw inc -517 if qym != 4173@nev dec -258 if tl >= -1552@tem inc -18 if ln >= 9398@qym inc -463 if tem == 5497@nfo inc -279 if ln >= 9392@nfo dec 627 if ln > 9388@acc inc -544 if ej >= 1219@xuu dec 201 if foz < -3667@qym inc -353 if s >= -1905@xuu inc -927 if tem <= 5506@cli dec -347 if bb != 5065@tl dec -339 if hb == -2937@s dec 503 if fe > -3470@s dec -187 if acc > -306@hb inc 77 if ej > 1214@u dec 103 if acc > -296@s dec 620 if bb < 5072@fe dec -752 if bb == 5063@u dec 930 if ec == -1410@ec inc -235 if cli != -1661@bq inc -361 if cli < -1664@xuu inc -582 if s <= -2849@re dec 812 if acc <= -292@h inc -938 if cli != -1652@ec inc -830 if re > 560@ec dec -888 if ln < 9385@cli inc -520 if tem < 5506@qym inc -224 if acc >= -302@tl inc -399 if nfo >= 342@tem dec 154 if foz == -3671@qym inc 500 if nev < -3443@tem dec 603 if acc != -295@nev inc 227 if ar == 4844@fe dec 658 if s > -2857@bb dec 327 if xuu < -6498@s inc -204 if acc <= -294@s inc 393 if s <= -3051@foz dec -71 if ec == -2232@piw inc 247 if acc != -306@tl dec 749 if cli >= -2189@bb dec -17 if qym != 3996@acc inc 890 if bq != -524@ar dec -532 if re == 561@ej dec -406 if ej >= 1224@ar dec -82 if hb < -2857@ej inc -685 if u <= 163@nfo dec -354 if yxr < -1053@ar dec -346 if yxr >= -1048@ej dec -575 if hb > -2864@bq inc 220 if bq != -521@fe dec -843 if cli <= -2185@ej inc -819 if ln > 9390@cli inc 105 if acc != -290@bb inc -828 if hb > -2866@s dec -508 if tem != 4900@re inc 153 if re <= 566@piw dec 370 if foz <= -3602@nfo inc 987 if bb >= 3922@fe inc -10 if foz > -3607@nfo inc -687 if yxr > -1060@nfo inc -580 if nev == -3226@fe inc -661 if s <= -2149@tl inc -521 if h == 896@nev dec 891 if tem > 4891@hb inc -162 if cli != -2076@yxr dec 696 if nev == -4112@tl inc 754 if s <= -2145@bq inc -457 if re >= 706@re dec -926 if acc >= -286@u inc 630 if re <= 719@ej dec -635 if u > 791@ln dec 631 if ln != 9400@qym inc 470 if re >= 722@ej dec 419 if cli == -2076@foz dec -108 if tl < -1201@fe inc -162 if cli <= -2078@ar dec 385 if yxr == -1059@ec inc 695 if hb < -2852@re dec 535 if cli > -2071@ej dec 135 if bb < 3926@ej dec 13 if hb != -2860@ec inc 967 if ec < -1540@ar dec 713 if ar >= 5453@piw inc -38 if tem >= 4887@piw inc 664 if bq == -761@ar dec 767 if hb > -2863@ej dec 908 if re > 715@nev inc 905 if acc <= -291@nev inc 395 if hb < -2854@piw inc 850 if yxr > -1050@tl dec 290 if nfo == 61@re inc -770 if xuu < -6496@fe inc 828 if ar == 3978@fe dec -295 if ar != 3980@fe dec 431 if foz >= -3506@nfo inc -433 if piw == 1853@tl dec -744 if acc > -299@s dec -609 if bb <= 3919@ar inc 390 if ec != -1547@acc inc 404 if hb == -2860@nfo inc -17 if s < -2152@u inc 338 if h != 910@s inc 921 if s >= -2159@ec inc -49 if hb > -2863@tem inc -144 if tem >= 4893@nev dec -847 if qym > 3985@yxr dec -885 if ln < 8762@cli dec 10 if u == 1131@tem dec -592 if yxr != -159@ec dec -594 if re >= -57@tem inc 66 if u == 1131@foz inc -810 if u == 1131@tem dec 880 if u > 1126@bq inc -604 if acc == 108@tem inc 344 if acc < 114@foz dec -550 if ej != 1594@ar inc 849 if s != -1233@nfo dec -903 if u == 1123@nev dec -945 if ec <= -987@re dec 715 if nev < -1019@ar dec -879 if hb == -2860@tl inc 432 if bb != 3926@s dec 474 if re <= -767@ej inc 356 if h >= 896@ec dec -229 if hb != -2863@bq inc 121 if ec <= -756@xuu inc 428 if u == 1131@ej inc 796 if xuu >= -6070@fe inc 889 if fe < -3341@cli dec 524 if acc > 102@piw dec -360 if acc != 117@fe dec 907 if h >= 907@piw dec -184 if ar != 6092@u dec 189 if hb >= -2866@nev dec -381 if nfo < -362@hb inc -568 if re == -771@hb inc -365 if xuu != -6079@nev dec 490 if qym == 3995@u dec 311 if u >= 933@hb inc 692 if yxr == -166@ej dec -524 if re > -767@ln dec 5 if h > 896@u dec 801 if u >= 628@ar dec -861 if s < -1695@nfo inc -921 if tem > 4862@ej inc -57 if bq == -1244@re dec 726 if ar == 6957@yxr dec -344 if s == -1705@ln dec -300 if foz != -3764@bb dec -372 if bq >= -1251@h inc 630 if tl <= -321@ln inc -586 if u != -161@ec dec -356 if ar != 6959@u dec -225 if piw >= 2399@ln inc -715 if tl < -321@nev inc -649 if u < -164@h inc 232 if ec != -407@bq dec 689 if piw <= 2399@bb inc 52 if xuu == -6071@foz inc 8 if s == -1705@fe inc 80 if nfo > -1299@ec inc 686 if u <= -166@foz inc 579 if bb < 4347@piw dec -551 if nev <= -1288@fe dec -271 if foz < -3743@nev dec -386 if qym <= 3993@nfo inc 791 if hb == -3101@xuu inc -206 if xuu != -6081@qym inc 53 if h > 1532@hb inc -238 if piw != 2955@h inc 947 if yxr < 181@re inc 668 if h < 2484@cli dec -989 if foz > -3754@tl inc -495 if h <= 2486@tl dec 884 if tl < -810@s inc 405 if fe >= -2107@ec dec 842 if yxr >= 174@h inc -451 if yxr < 180@yxr inc 364 if hb < -3331@nfo dec -736 if xuu < -6272@ec inc 37 if piw <= 2957@cli inc 839 if piw <= 2955@foz dec 787 if cli <= -777@ar inc 343 if hb == -3339@piw dec 939 if ej != 1892@piw inc -36 if bq != -1927@ej dec -684 if tl != -1710@acc inc 882 if h == 2030@re dec 372 if acc == 990@h inc 23 if qym <= 4041@ej dec 446 if u >= -169@foz dec 293 if yxr <= 539@tl dec -526 if fe > -2110@ar inc 35 if ec <= -521@ej dec -839 if s != -1295@bq inc -816 if ec > -534@tl dec -913 if fe >= -2108@bb dec 888 if acc >= 983@tem inc -951 if hb == -3339@ec dec -562 if qym < 4046@nfo dec -696 if h >= 2049@u dec -376 if yxr == 542@tem dec 130 if ej <= 3429@nev inc -484 if h >= 2046@nev dec -902 if yxr >= 539@qym inc 306 if nev >= -498@bq inc -306 if hb <= -3334@tl dec -807 if fe > -2113@nev inc -47 if nev <= -483@u dec -228 if xuu == -6277@hb dec 925 if s < -1297@acc dec 236 if cli > -786@h inc 684 if u >= 429@nfo dec 912 if u < 440@xuu inc 529 if bb < 3464@tl inc 143 if qym != 4354@ec dec 694 if tem == 3791@fe dec -542 if u < 441@piw dec 433 if yxr >= 540@ln dec -537 if hb > -4272@acc dec 419 if acc > 744@xuu dec 31 if fe == -1557@ej dec -297 if yxr < 533@foz inc -281 if ec <= -656@cli dec 712 if tl > 677@bq dec -871 if foz >= -4817@bb inc 381 if ln < 8294@nev inc -670 if tem > 3783@yxr inc 860 if nfo < 14@foz inc -120 if nfo > 25@ec inc 793 if fe >= -1563@qym dec -827 if qym < 4351@ar inc 687 if cli >= -1495@bq inc 975 if re < -1191@xuu inc 177 if u != 442@tem inc 363 if nev != -1207@acc inc 707 if cli < -1491@nfo dec -381 if tem > 4148@ec inc -347 if tl != 697@ej dec 995 if s > -1303@acc dec 452 if bq == -2080@u dec -851 if piw > 1539@ln inc -993 if re != -1211@nfo dec -591 if tl >= 692@s dec -410 if yxr != 549@yxr dec -54 if u >= 1288@bb dec -733 if re <= -1193@piw inc -984 if re < -1193@ln dec 133 if ec >= -211@acc dec -218 if fe < -1561@tem inc 792 if fe > -1567@bb dec 359 if yxr != 541@tem inc 273 if h != 2735@ec inc -714 if nfo < 401@hb dec -555 if bb <= 4206@nfo inc -151 if ln > 7294@hb dec -635 if yxr <= 550@acc inc -603 if u < 1282@nev inc 705 if cli >= -1488@cli inc 568 if ej < 2435@nfo dec 795 if nfo >= 246@s dec -996 if ln != 7289@u inc -530 if nfo > -550@tl dec -431 if qym >= 5171@fe inc -998 if ec < -920"

	for i=1:1:$length(pInput,"@") {
		set tTemp=$piece(pInput,"@",i)
		set tReg=$piece(tTemp," ",1)
		set tDir=$piece(tTemp," ",2)
		set tIncVal=$piece(tTemp," ",3)
		set tCondReg=$piece(tTemp," ",5)
		set tCond=$piece(tTemp," ",6)
		set tCondVal=$piece(tTemp," ",7)
		
		set tConds(tCond)=1
		
		set tRegVal=$g(tVals(tCondReg),0)
		if tCond="!=" {
			if tRegVal'=tCondVal {
				if tDir="inc" {
					set tVals(tReg)=$g(tVals(tReg),0)+tIncVal
				} else {
					set tVals(tReg)=$g(tVals(tReg),0)-tIncVal
				}
			}
		} elseif tCond=">=" {
			if tRegVal>=tCondVal {
				if tDir="inc" {
					set tVals(tReg)=$g(tVals(tReg),0)+tIncVal
				} else {
					set tVals(tReg)=$g(tVals(tReg),0)-tIncVal
				}
			}
		} elseif tCond="<=" {
			if tRegVal<=tCondVal {
				if tDir="inc" {
					set tVals(tReg)=$g(tVals(tReg),0)+tIncVal
				} else {
					set tVals(tReg)=$g(tVals(tReg),0)-tIncVal
				}
			}
		} elseif tCond="==" {
			if tRegVal=tCondVal {
				if tDir="inc" {
					set tVals(tReg)=$g(tVals(tReg),0)+tIncVal
				} else {
					set tVals(tReg)=$g(tVals(tReg),0)-tIncVal
				}
			}
		} elseif tCond="<" {
			if tRegVal<tCondVal {
				if tDir="inc" {
					set tVals(tReg)=$g(tVals(tReg),0)+tIncVal
				} else {
					set tVals(tReg)=$g(tVals(tReg),0)-tIncVal
				}
			}
		} elseif tCond=">" {
			if tRegVal>tCondVal {
				if tDir="inc" {
					set tVals(tReg)=$g(tVals(tReg),0)+tIncVal
				} else {
					set tVals(tReg)=$g(tVals(tReg),0)-tIncVal
				}
			}
		}
	}
	
	set tReg=$O(tVals(""))
	set tMax=0
	while tReg'="" {
		if tVals(tReg)>tMax {
			set tMax=tVals(tReg)
		}
		set tReg=$O(tVals(tReg))
	}
	
	quit tMax
}

ClassMethod Day8P2(pInput = "") As %String
{
	set:pInput="" pInput="yxr inc 119 if nev != 6@piw dec -346 if tl != 4@cli inc 165 if nev >= -5@nev dec 283 if xuu > -2@tem inc 745 if qym >= -9@xuu dec -104 if cli == 165@h dec 192 if u <= 5@ln dec -616 if ej > -7@tem dec -555 if ar > -5@tem dec 687 if tl > -8@h inc 120 if re < -8@bq dec -410 if ej > -4@re dec 476 if tem == 613@ej dec 686 if cli != 163@ar dec 676 if tl > -6@nfo inc 633 if s == 0@tl inc -471 if tem > 607@bb inc 157 if piw > 342@cli inc -830 if piw != 342@piw inc -645 if ar >= -674@bq dec 304 if piw != 356@u inc -274 if bb != 147@yxr inc -520 if ec >= 1@ec dec 631 if bb > 147@ar dec 732 if s >= 0@foz inc -617 if bb == 157@qym dec -197 if ej == -686@bb dec 111 if h <= -199@ln dec -585 if re != -476@foz dec -181 if nev < -280@foz dec 989 if xuu != 106@ec inc -930 if ec <= -626@foz dec 862 if s >= 5@tem inc 241 if xuu == 104@ar dec -460 if h >= -201@cli inc -317 if cli == -665@bb dec -483 if h > -194@tem inc -718 if tl <= -466@ln dec 362 if hb == 0@qym inc 95 if hb > 3@piw dec -463 if ln < 246@xuu inc 159 if s <= 5@ec inc -710 if cli < -977@bb inc -98 if xuu >= 260@qym inc 159 if bb >= 540@acc inc 610 if fe <= 9@ar dec 381 if ej < -695@acc dec 807 if nev > -284@foz dec 926 if h < -188@tl inc 279 if ar != -957@ec dec -39 if acc < -191@u dec -110 if piw == 346@ej dec 980 if ar == -948@ln dec -165 if hb < 2@nfo inc -370 if tem > 128@ar dec -886 if ar < -947@bb dec 624 if ej == -1666@tl inc 36 if ec > -2227@yxr dec 320 if cli <= -976@tem inc -808 if ar >= -52@cli dec 213 if h >= -198@ej inc -141 if nev < -281@bq inc -736 if yxr > -211@u dec -742 if nfo > 258@bq dec -727 if ar >= -64@u dec -248 if bq > 89@xuu inc 431 if yxr > -203@hb dec -407 if hb >= -7@ar inc 789 if acc >= -197@yxr inc -753 if piw <= 350@piw dec -973 if yxr >= -956@xuu dec 457 if ec <= -2228@bq inc -201 if bq >= 97@bq dec -923 if ar == 727@cli inc -560 if piw < 1329@ej dec -150 if ar != 733@h inc -198 if nev == -283@u inc -388 if piw == 1319@hb inc -212 if s < 8@xuu inc -988 if ej < -1653@ec inc 58 if re >= -485@hb inc -126 if xuu < -741@ar inc 534 if nev == -273@fe inc 668 if s <= 7@tem dec 25 if h >= -390@u inc -632 if tl > -198@u dec 721 if bq > 813@piw dec -299 if foz >= -2348@hb inc -407 if ej > -1663@h dec 563 if foz == -2351@bb dec 362 if fe != 670@nev inc -512 if bb != -437@fe dec -419 if yxr < -948@tl dec 576 if ej > -1665@acc dec -510 if xuu > -759@s dec -108 if u < -906@xuu dec -407 if xuu < -748@yxr dec 771 if bb > -454@u dec -879 if tem != 110@bq inc -759 if u < -27@s dec -295 if qym < 364@qym inc 807 if xuu == -344@h inc 545 if hb == -338@ej inc -896 if s != 394@s dec -961 if yxr > -1723@s dec -142 if nev != -799@s inc -692 if ln != 427@ar dec 152 if tl == -763@acc dec 304 if piw != 1328@ar inc -532 if piw != 1324@bq inc 124 if tem < 109@h inc 480 if nfo == 268@xuu dec -291 if ej >= -2556@hb inc -56 if nfo >= 257@ar dec -656 if bb > -447@tl dec -458 if ec <= -2167@xuu inc -100 if hb <= -397@nev dec 384 if foz <= -2344@acc dec -779 if acc == 9@u inc 949 if h != -416@xuu inc -865 if nev < -1182@nev dec 317 if bb < -434@foz inc -786 if bq > 51@xuu inc -901 if ej >= -2557@nev dec 750 if h != -398@qym dec 783 if re != -480@bb dec 54 if cli < -1752@tl dec -803 if yxr < -1724@s inc 690 if xuu != -954@piw inc -667 if s != -151@foz dec -946 if cli <= -1757@h dec -885 if re == -486@ar inc -765 if re < -468@h dec 340 if ec != -2170@fe dec 440 if tl > 492@re dec 398 if hb != -384@xuu inc -49 if fe > 641@s dec 623 if qym != 375@piw inc 429 if ec == -2174@ej inc 747 if hb != -394@xuu inc 761 if nfo > 255@re inc 519 if yxr != -1716@nev inc 863 if tl <= 499@qym inc -357 if foz > -3138@tl dec 186 if u < 915@s dec -442 if nev < -1373@bq inc -999 if ec == -2174@cli inc 735 if acc > 781@ar dec -983 if nev >= -1389@cli inc 285 if u < 917@xuu inc -970 if h >= -747@bq inc 716 if tl < 310@xuu dec 984 if bb > -503@h inc -881 if ej >= -2546@u inc 719 if fe >= 646@u inc 396 if hb > -393@ej inc 734 if acc != 784@fe inc 581 if re <= -350@piw dec -69 if hb < -384@ec dec 540 if acc < 798@cli dec -615 if foz <= -3130@ln inc 261 if foz <= -3130@acc dec 739 if ar > 1065@ln dec -520 if qym > 19@re inc -260 if bq != -230@ln inc -28 if h > -750@hb dec -794 if s == -325@nfo inc 79 if ln < 1176@acc inc 173 if ec == -2714@yxr inc 756 if re > -616@re inc 415 if fe >= 1219@hb dec -701 if u < 1638@xuu dec -325 if re != -200@ln dec -552 if piw != 1157@yxr inc -568 if qym >= 17@tl dec 756 if ec <= -2712@nev dec 430 if xuu <= -1219@bq dec -580 if yxr >= -1533@ej dec -357 if bb >= -493@ec inc 722 if ej >= -1822@tl dec 168 if nev == -1813@bb dec -393 if foz >= -3130@cli inc -298 if s == -328@h inc 885 if yxr != -1536@nev dec -188 if cli < -427@yxr dec 41 if cli > -416@qym inc 748 if u == 1632@re inc 457 if nfo > 339@yxr inc 781 if piw < 1153@qym inc 628 if cli != -417@bq inc -476 if piw < 1142@bb dec 547 if nfo >= 341@s dec 590 if piw == 1150@piw inc -804 if nfo != 342@ar dec -838 if xuu == -1226@ec inc 224 if h > 132@ec dec -963 if ln >= 1731@xuu inc 109 if u <= 1638@s dec -191 if fe >= 1220@ln dec -718 if h >= 133@u dec 46 if nev >= -1811@nfo inc -56 if s < -718@nev dec -346 if ar != 1905@h dec -501 if hb != 306@acc dec 651 if bb >= -1039@xuu dec 714 if ar > 1905@qym dec 304 if piw <= 1157@tl dec -62 if foz < -3138@h inc 448 if qym != 1095@hb inc 780 if tem != 112@hb dec 332 if tem <= 114@s dec -447 if acc != 226@s dec -560 if ej > -1829@nev dec -435 if piw == 1150@nev dec 259 if piw < 1155@tem inc 293 if nfo == 286@hb dec 656 if s < 284@hb inc -484 if acc < 213@ln inc 831 if s < 280@hb dec -394 if ec != -1771@nfo inc 124 if h != 628@ln dec -675 if yxr < -754@bb dec -69 if hb == 494@ln inc -139 if re <= 261@nev inc 325 if yxr >= -753@tl inc 551 if foz != -3137@bb dec -598 if nfo != 413@qym inc 771 if s >= 271@tl inc 903 if ej != -1820@fe inc -388 if re != 250@ln dec -163 if ej != -1827@nev dec -209 if re <= 261@bq inc -59 if h == 638@ej inc 793 if yxr < -749@ec inc -224 if s >= 276@ln inc 895 if foz <= -3132@acc dec -681 if ec < -1989@tem dec -161 if hb == 493@ar dec -436 if nfo >= 408@u dec -56 if re != 250@nfo inc -497 if hb < 495@ec dec -874 if acc > 911@bb dec 988 if xuu == -1838@nfo dec -257 if fe > 836@ec inc -332 if foz >= -3146@u inc 697 if u <= 1691@ej dec 777 if bb <= -440@nfo dec -99 if bq > -277@acc dec 552 if tem <= 573@fe dec 74 if ec == -2317@qym dec 829 if foz >= -3146@bq dec -149 if ec <= -2324@u dec -99 if hb == 493@yxr dec -546 if tl > 288@u inc 261 if cli >= -412@ej inc -341 if tem < 574@ec inc -83 if ar <= 2346@ec inc 847 if xuu <= -1830@re dec -364 if xuu < -1839@yxr inc -483 if ln <= 4033@tl dec 965 if tl == 286@re inc -63 if tl >= -674@cli inc 708 if acc < 352@xuu dec 494 if ej > -2154@tl inc 8 if foz > -3131@ec inc 983 if nfo == 170@bb inc 486 if cli < 292@ar dec -461 if ec >= -586@yxr dec -852 if hb < 500@u inc -874 if acc < 355@xuu inc 883 if re > 266@xuu dec 809 if ec == -577@tl dec 144 if ej > -2145@u inc -363 if fe >= 839@bb inc -194 if piw >= 1150@ln inc 780 if fe != 835@cli inc 213 if re >= 256@xuu dec -718 if hb >= 491@yxr dec -730 if u < 1251@nfo dec 1 if hb > 491@ar inc -556 if nev > -1085@ej dec -275 if bq < -128@nev dec -578 if foz != -3137@h inc -391 if h == 638@foz inc -291 if bq >= -134@bb inc -123 if fe == 840@tl dec 72 if bq == -133@qym dec -155 if yxr < 831@re inc 515 if s < 289@nfo dec -313 if ar >= 2242@cli dec 486 if tl < -904@bb dec -844 if ln >= 4810@hb inc -551 if tem == 565@ec inc -28 if yxr <= 828@cli inc -673 if h >= 241@re dec -937 if bb > 562@ec inc 214 if bb != 571@piw inc -142 if ar > 2240@ar dec 750 if tl < -898@re dec -844 if ej != -1877@bq inc -17 if qym <= 1200@acc dec -154 if foz > -3429@piw inc -13 if cli > -175@cli inc -374 if acc > 497@acc dec -751 if ln != 4821@xuu dec 821 if bq < -142@nev dec 867 if bb < 565@qym dec -883 if hb != -65@h inc -289 if ln <= 4818@hb dec 839 if s <= 282@cli dec 662 if ar > 2253@nev inc 975 if acc < 1249@foz inc -459 if nfo != 479@tem inc 721 if ar < 2244@hb dec 645 if bb >= 561@cli dec 973 if bq <= -148@qym inc 937 if piw <= 1003@bq inc -548 if tem != 561@nfo dec 98 if nev != -1082@u dec 789 if bq >= -688@u dec 389 if acc <= 1258@bq inc 818 if qym <= 3020@acc inc 224 if nfo < 492@ln inc -739 if re >= 2547@re dec -364 if fe != 843@piw dec -836 if piw > 991@foz inc 484 if cli < -1519@ln inc 869 if hb < -1533@piw dec 872 if yxr <= 834@bq inc -1 if bq >= 113@tl inc -649 if u >= 854@ec dec -447 if bb == 566@ar dec -702 if u < 861@s inc -445 if bb <= 574@xuu dec 323 if cli <= -1523@foz dec 589 if ln <= 4947@s inc -399 if nfo != 484@cli inc -704 if acc < 1481@yxr dec 712 if hb != -1534@nev dec -347 if nev <= -1087@ln dec -801 if foz > -4480@xuu dec -549 if h >= -47@re dec 127 if xuu > -2692@hb inc 96 if fe <= 845@acc dec 159 if hb >= -1451@bq inc 754 if u >= 865@u inc 23 if yxr > 106@re dec 940 if nfo <= 489@qym dec -599 if ar >= 2948@qym dec -481 if nfo == 482@nfo inc 767 if cli <= -2225@bb inc -174 if ec == 56@tem inc 615 if ec <= 55@tem inc 845 if re > 1848@hb inc 940 if tl > -1543@bq dec -892 if xuu >= -2686@bq inc 996 if bq >= 117@re dec 456 if u < 885@ln inc 879 if s < -568@s dec 605 if ar >= 2941@foz dec 585 if hb > -1449@ej inc 980 if ej <= -1866@re dec -409 if foz <= -5059@tem dec -394 if nfo != 476@yxr dec -765 if ej <= -888@ec inc -540 if fe < 843@cli dec 758 if foz != -5056@nfo inc 846 if re > 1802@re inc 800 if nev < -1078@nev dec 2 if yxr < 883@piw inc 282 if acc >= 1313@h inc -993 if ln <= 5741@ar inc 594 if tem <= 1804@h inc 502 if h >= -45@xuu inc -73 if acc <= 1326@re dec 116 if piw >= 1243@bq inc 62 if u <= 880@acc dec 166 if fe <= 846@ec dec -441 if re > 2612@re inc 214 if re != 2602@u dec 410 if s < -1160@ln dec -701 if piw <= 1244@tl inc -126 if nfo <= 1330@fe inc -861 if tl <= -1669@ar dec -998 if yxr <= 882@fe inc 629 if ln > 6445@hb dec -407 if foz <= -5071@s dec 654 if acc <= 1161@bb inc 304 if fe <= 615@xuu inc 979 if cli == -2969@cli inc -973 if fe == 607@cli inc 859 if tl <= -1665@tl dec 257 if foz > -5064@bq dec -253 if hb != -1446@s inc 82 if fe == 611@h inc -462 if xuu == -2761@nev dec 231 if bq <= 1123@fe inc -719 if re == 2817@nfo inc 553 if ec != -484@nev inc -457 if nfo != 1318@fe inc -936 if piw <= 1247@nev inc -615 if ar > 4539@fe inc -267 if ec >= -475@qym dec 336 if tem > 1802@ej inc 442 if foz > -5064@qym inc 864 if h < 0@nev inc 565 if foz >= -5057@tem inc 257 if ej <= -457@hb dec -202 if piw > 1243@bq dec -192 if ar != 4550@foz dec 374 if ln >= 6454@tem inc 381 if ej != -454@ec dec -630 if ej == -438@foz dec -821 if acc > 1161@nev dec 903 if bq != 1315@re inc -677 if ej > -448@re inc 588 if u < 473@xuu dec 114 if foz > -5062@acc inc -804 if ec > -492@nfo inc 728 if cli == -2120@xuu dec -258 if foz > -5064@tem dec -370 if ln < 6450@acc dec -717 if ej != -442@ec dec 262 if qym > 4613@nev inc 31 if u >= 468@xuu dec 84 if re == 2728@u inc 457 if xuu != -2697@acc dec 251 if acc != 1068@tem dec -745 if acc <= 1076@tl dec 581 if tem <= 3304@s dec -730 if hb <= -1444@ec dec 409 if tem < 3293@acc dec -884 if acc >= 1077@acc inc 160 if bb < 706@ar dec 110 if nfo != 2058@ej dec -349 if fe < -1038@s inc 681 if s >= -1096@cli inc -712 if fe < -1043@nfo dec 693 if u != 924@ln inc 170 if xuu != -2702@bb inc 759 if tl > -2518@ln inc 647 if tem > 3296@ej inc -35 if re >= 2734@qym inc 710 if nev < -3258@xuu inc 304 if fe == -1052@piw dec 237 if xuu >= -2707@tem dec -683 if hb <= -1441@piw inc -297 if re >= 2733@nfo dec -836 if bb == 1455@s inc 901 if u <= 921@bb inc 780 if bq == 1307@xuu dec 467 if yxr >= 878@acc dec -24 if h < 6@ec dec 412 if foz >= -5054@ec inc -990 if fe == -1047@nev dec -940 if nfo != 2208@ar dec -670 if qym == 5339@foz inc 391 if hb != -1438@yxr inc -86 if acc <= 1260@qym dec -36 if piw < 1008@nev inc -21 if yxr == 788@piw inc 581 if hb == -1446@bb inc -355 if bb != 2232@yxr dec 238 if ar < 4441@tem dec -974 if cli < -2826@xuu inc -237 if s <= -406@ej dec 51 if foz <= -4661@cli inc -416 if h < 6@fe inc 23 if s < -407@bq dec 598 if ej <= -152@cli inc -15 if piw > 1584@foz dec -781 if nfo < 2209@u inc 17 if bb < 1883@xuu dec 799 if ej >= -157@bb inc 914 if tem != 4960@foz dec 853 if fe != -1024@piw dec 628 if nfo != 2199@qym dec 303 if xuu >= -4207@bq dec 854 if yxr >= 549@hb inc -123 if xuu >= -4211@bb inc 767 if nev <= -2318@s inc 482 if nfo > 2196@yxr inc 185 if bb < 3570@yxr dec 683 if bq != 444@fe dec -316 if ec >= -1733@bb inc 368 if s < 78@tl dec 132 if yxr != 63@yxr dec 357 if bq == 453@fe inc -256 if ec > -1744@xuu inc -193 if ej <= -142@xuu dec -605 if cli != -3263@ar dec 571 if u != 945@nfo inc -430 if nfo < 2209@hb inc 236 if hb > -1564@ar dec -460 if fe < -1278@tl dec -127 if bq > 449@s inc -343 if nfo > 1764@fe inc 761 if nev < -2326@piw dec -136 if xuu != -4391@cli dec 639 if yxr >= -301@tl dec -524 if ar != 4890@ln dec -75 if ln < 7269@ln dec -376 if tem > 4956@yxr inc -317 if yxr >= -297@tem inc 593 if ej == -149@cli dec 297 if ar < 4894@ej dec -576 if xuu <= -4395@bq dec -681 if s >= -277@ec dec -404 if u >= 939@xuu dec -82 if yxr >= -292@nev inc -661 if u <= 954@yxr inc 941 if foz > -3896@ar dec 559 if ar < 4895@re inc 470 if tl <= -1981@qym inc 423 if hb <= -1564@ec inc -353 if cli >= -4208@qym inc 166 if nfo < 1770@ln inc 110 if h > -4@bb dec 459 if nfo < 1776@tem inc -466 if ej > 418@tem inc -223 if fe < -1271@bb inc 361 if qym > 5650@fe dec 698 if nfo <= 1768@h inc -761 if acc >= 1258@tl dec 307 if cli < -4195@ec dec -428 if bq == 1134@ec inc 200 if u == 945@fe dec 999 if re >= 3198@ej dec -150 if ej != 429@ar inc -19 if bb < 3822@cli inc -271 if piw == 1721@piw inc -317 if nev <= -2985@xuu dec 732 if xuu == -4393@ar dec -738 if bq != 1133@cli dec -925 if xuu >= -4400@tem dec -336 if acc == 1261@xuu dec -396 if tl < -2291@tem inc -726 if xuu < -3995@xuu inc 586 if yxr < 643@nfo inc 554 if re >= 3194@ln dec 425 if s < -276@s inc -678 if h >= -2@acc inc -669 if u == 945@nfo inc 136 if re <= 3207@nev inc -486 if fe > -2272@acc inc 146 if yxr < 650@bq inc 637 if u != 945@bq inc -562 if u < 949@fe dec -164 if tem >= 4128@ej inc -868 if ec > -1058@foz inc -646 if ej < -295@u inc 960 if bb < 3825@ln dec -6 if ln > 7826@bq dec 972 if acc > 723@piw inc 958 if fe != -2115@ln inc 179 if ln <= 7830@foz inc 206 if bb <= 3828@u inc -789 if bb > 3826@nev inc -597 if ln <= 8005@nev dec -112 if yxr <= 642@ej inc 670 if s <= -942@ec dec 623 if qym >= 5652@bb inc 35 if nev != -3470@u dec -50 if ej != 379@ar dec 952 if tl != -2306@tem inc -92 if re == 3192@yxr dec 866 if qym == 5652@nfo inc -457 if bb != 3876@tem inc 395 if fe != -2125@acc inc -37 if piw > 1711@tem dec -647 if fe <= -2113@tem dec -546 if xuu > -3422@piw dec 219 if acc < 699@ar dec -392 if piw == 1502@s inc 330 if bq > -407@bq inc -508 if nev <= -3473@ln dec -333 if cli != -3545@ln dec 42 if ec > -1683@acc inc -247 if ln <= 7966@foz inc 563 if tl <= -2287@ej inc -390 if ej <= 384@acc dec 659 if acc != 443@xuu dec -293 if ej >= -18@qym dec -169 if yxr > -217@cli inc 778 if ln >= 7960@xuu dec -179 if u != 163@nfo dec 600 if ej == -11@ar dec 261 if piw > 1492@re inc -889 if yxr > -228@h inc 37 if xuu != -2943@ln inc 148 if tem > 5731@bq dec 564 if piw == 1502@piw dec 822 if ar != 4242@xuu inc -35 if nfo != 1402@u dec -284 if cli > -2777@ar dec -521 if yxr >= -225@bb dec 412 if yxr <= -222@piw inc -199 if tem != 5715@bb inc 331 if qym < 5653@bq dec -359 if ec > -1687@acc inc 298 if bq == -605@bq inc -69 if tl < -2305@h inc -626 if h == 8@qym dec 609 if s <= -619@fe inc 165 if nev < -3456@xuu inc 690 if ej != -15@ec dec -280 if tl < -2294@qym dec 829 if bq != -610@xuu dec 888 if piw > 489@u inc 81 if acc > 80@qym dec 247 if h > -9@tl dec -558 if bq < -604@nfo dec 692 if ln == 7963@acc inc -23 if tl > -1735@xuu dec 478 if fe == -1950@s dec 551 if tl < -1736@ec inc -479 if fe == -1950@s dec -17 if foz > -3328@piw dec 351 if acc == 84@bq dec -437 if re == 2309@qym dec -808 if cli > -2774@h dec -390 if tl == -1738@foz dec 676 if ej >= -4@re dec 891 if bq != -167@bb dec -191 if re != 1418@nfo inc 380 if s == -1155@ec inc 69 if u < 531@nev dec -690 if s >= -1164@s dec 571 if bb >= 3776@re dec -224 if hb <= -1563@bq inc -252 if piw < 131@yxr dec -488 if tl == -1741@re inc 755 if re > 1638@bq inc -208 if qym != 4769@qym inc 695 if hb == -1563@fe inc -157 if piw < 121@xuu dec 579 if acc != 79@ln dec -262 if nfo > 1086@ec dec 235 if tl >= -1739@hb inc 188 if ej >= -13@s inc 124 if cli >= -2760@ec dec -643 if nfo != 1088@re dec -934 if fe > -1959@ej inc -58 if s == -1727@qym dec -558 if tl >= -1746@ln inc -555 if ec != -1402@foz inc -833 if cli != -2774@ln dec -589 if cli == -2775@tl inc -906 if re < 3334@tl inc 552 if fe < -1940@cli inc 976 if re >= 3322@bq inc -101 if xuu >= -3301@nev dec -217 if tl < -2087@ej dec 945 if u > 519@piw inc 447 if fe >= -1957@h inc 905 if piw <= 586@hb inc -995 if u == 521@acc inc 713 if tl >= -2100@ar inc -936 if ec <= -1400@tl inc 199 if u < 530@u dec 584 if ar != 3829@tl inc 787 if fe > -1954@ar inc 631 if qym >= 5325@tl inc -993 if ln < 8232@bq dec 900 if yxr > -231@u dec -226 if ln < 8235@yxr inc -966 if bq <= -1520@ar inc -83 if bq < -1520@bq dec 439 if bq == -1528@ej inc 608 if h < 1294@yxr inc 140 if nev >= -2567@qym dec 685 if nev >= -2566@re dec 957 if hb > -2378@tem dec -851 if bq <= -1966@nfo dec 421 if qym < 4649@acc inc 473 if ar == 4383@tem inc -407 if qym >= 4642@s dec -949 if tl >= -2103@h inc 549 if s >= -784@qym dec -311 if xuu >= -3308@s dec 751 if yxr > -1060@s inc -438 if ar != 4386@fe dec 734 if s <= -1965@ej inc 989 if hb == -2376@tl dec 84 if yxr > -1055@re dec 919 if ar < 4393@ec dec 314 if qym >= 4657@acc dec 572 if piw <= 579@bq dec -742 if tem >= 6166@ln inc 891 if qym < 4651@piw inc 125 if s >= -1956@nev inc 530 if piw != 577@ln inc 703 if nfo <= 670@bb inc 741 if foz >= -4155@ln inc -429 if u >= 163@ln dec -47 if nfo > 678@cli dec 217 if bq < -1222@tl dec -485 if fe >= -2690@tl dec -948 if fe == -2684@nfo inc 786 if qym != 4642@bb inc 336 if re != 1455@tl inc -8 if nfo != 1455@hb inc 173 if bq == -1225@s dec -53 if piw < 581@bq inc 905 if h == 1842@acc inc -450 if nev < -2551@ar dec 241 if s != -1914@bb inc 671 if ec <= -1400@acc inc 895 if fe <= -2691@fe dec 776 if s == -1913@foz inc -104 if nev >= -2558@nfo dec 629 if hb <= -2201@u dec 531 if ec < -1404@hb dec -37 if yxr < -1049@foz dec -586 if h <= 1848@nev inc -895 if acc == 248@qym dec 475 if bb <= 4461@piw inc 773 if fe < -3459@nfo dec -142 if cli == -2008@hb inc 103 if cli != -1999@bq inc 795 if ln == 9390@re dec 82 if nfo <= 975@u inc -275 if u != 163@xuu inc -599 if acc == 248@ln inc -642 if hb < -2069@hb dec 874 if nfo == 968@bb inc -283 if ej != 640@bq inc -999 if fe == -3460@tem dec 670 if tem != 6174@bb inc 890 if re > 1369@xuu dec 880 if foz >= -3678@ar dec -702 if ej == 641@h inc -43 if nev != -3453@tl inc -803 if qym >= 4166@ej inc 583 if foz > -3687@piw inc -517 if qym != 4173@nev dec -258 if tl >= -1552@tem inc -18 if ln >= 9398@qym inc -463 if tem == 5497@nfo inc -279 if ln >= 9392@nfo dec 627 if ln > 9388@acc inc -544 if ej >= 1219@xuu dec 201 if foz < -3667@qym inc -353 if s >= -1905@xuu inc -927 if tem <= 5506@cli dec -347 if bb != 5065@tl dec -339 if hb == -2937@s dec 503 if fe > -3470@s dec -187 if acc > -306@hb inc 77 if ej > 1214@u dec 103 if acc > -296@s dec 620 if bb < 5072@fe dec -752 if bb == 5063@u dec 930 if ec == -1410@ec inc -235 if cli != -1661@bq inc -361 if cli < -1664@xuu inc -582 if s <= -2849@re dec 812 if acc <= -292@h inc -938 if cli != -1652@ec inc -830 if re > 560@ec dec -888 if ln < 9385@cli inc -520 if tem < 5506@qym inc -224 if acc >= -302@tl inc -399 if nfo >= 342@tem dec 154 if foz == -3671@qym inc 500 if nev < -3443@tem dec 603 if acc != -295@nev inc 227 if ar == 4844@fe dec 658 if s > -2857@bb dec 327 if xuu < -6498@s inc -204 if acc <= -294@s inc 393 if s <= -3051@foz dec -71 if ec == -2232@piw inc 247 if acc != -306@tl dec 749 if cli >= -2189@bb dec -17 if qym != 3996@acc inc 890 if bq != -524@ar dec -532 if re == 561@ej dec -406 if ej >= 1224@ar dec -82 if hb < -2857@ej inc -685 if u <= 163@nfo dec -354 if yxr < -1053@ar dec -346 if yxr >= -1048@ej dec -575 if hb > -2864@bq inc 220 if bq != -521@fe dec -843 if cli <= -2185@ej inc -819 if ln > 9390@cli inc 105 if acc != -290@bb inc -828 if hb > -2866@s dec -508 if tem != 4900@re inc 153 if re <= 566@piw dec 370 if foz <= -3602@nfo inc 987 if bb >= 3922@fe inc -10 if foz > -3607@nfo inc -687 if yxr > -1060@nfo inc -580 if nev == -3226@fe inc -661 if s <= -2149@tl inc -521 if h == 896@nev dec 891 if tem > 4891@hb inc -162 if cli != -2076@yxr dec 696 if nev == -4112@tl inc 754 if s <= -2145@bq inc -457 if re >= 706@re dec -926 if acc >= -286@u inc 630 if re <= 719@ej dec -635 if u > 791@ln dec 631 if ln != 9400@qym inc 470 if re >= 722@ej dec 419 if cli == -2076@foz dec -108 if tl < -1201@fe inc -162 if cli <= -2078@ar dec 385 if yxr == -1059@ec inc 695 if hb < -2852@re dec 535 if cli > -2071@ej dec 135 if bb < 3926@ej dec 13 if hb != -2860@ec inc 967 if ec < -1540@ar dec 713 if ar >= 5453@piw inc -38 if tem >= 4887@piw inc 664 if bq == -761@ar dec 767 if hb > -2863@ej dec 908 if re > 715@nev inc 905 if acc <= -291@nev inc 395 if hb < -2854@piw inc 850 if yxr > -1050@tl dec 290 if nfo == 61@re inc -770 if xuu < -6496@fe inc 828 if ar == 3978@fe dec -295 if ar != 3980@fe dec 431 if foz >= -3506@nfo inc -433 if piw == 1853@tl dec -744 if acc > -299@s dec -609 if bb <= 3919@ar inc 390 if ec != -1547@acc inc 404 if hb == -2860@nfo inc -17 if s < -2152@u inc 338 if h != 910@s inc 921 if s >= -2159@ec inc -49 if hb > -2863@tem inc -144 if tem >= 4893@nev dec -847 if qym > 3985@yxr dec -885 if ln < 8762@cli dec 10 if u == 1131@tem dec -592 if yxr != -159@ec dec -594 if re >= -57@tem inc 66 if u == 1131@foz inc -810 if u == 1131@tem dec 880 if u > 1126@bq inc -604 if acc == 108@tem inc 344 if acc < 114@foz dec -550 if ej != 1594@ar inc 849 if s != -1233@nfo dec -903 if u == 1123@nev dec -945 if ec <= -987@re dec 715 if nev < -1019@ar dec -879 if hb == -2860@tl inc 432 if bb != 3926@s dec 474 if re <= -767@ej inc 356 if h >= 896@ec dec -229 if hb != -2863@bq inc 121 if ec <= -756@xuu inc 428 if u == 1131@ej inc 796 if xuu >= -6070@fe inc 889 if fe < -3341@cli dec 524 if acc > 102@piw dec -360 if acc != 117@fe dec 907 if h >= 907@piw dec -184 if ar != 6092@u dec 189 if hb >= -2866@nev dec -381 if nfo < -362@hb inc -568 if re == -771@hb inc -365 if xuu != -6079@nev dec 490 if qym == 3995@u dec 311 if u >= 933@hb inc 692 if yxr == -166@ej dec -524 if re > -767@ln dec 5 if h > 896@u dec 801 if u >= 628@ar dec -861 if s < -1695@nfo inc -921 if tem > 4862@ej inc -57 if bq == -1244@re dec 726 if ar == 6957@yxr dec -344 if s == -1705@ln dec -300 if foz != -3764@bb dec -372 if bq >= -1251@h inc 630 if tl <= -321@ln inc -586 if u != -161@ec dec -356 if ar != 6959@u dec -225 if piw >= 2399@ln inc -715 if tl < -321@nev inc -649 if u < -164@h inc 232 if ec != -407@bq dec 689 if piw <= 2399@bb inc 52 if xuu == -6071@foz inc 8 if s == -1705@fe inc 80 if nfo > -1299@ec inc 686 if u <= -166@foz inc 579 if bb < 4347@piw dec -551 if nev <= -1288@fe dec -271 if foz < -3743@nev dec -386 if qym <= 3993@nfo inc 791 if hb == -3101@xuu inc -206 if xuu != -6081@qym inc 53 if h > 1532@hb inc -238 if piw != 2955@h inc 947 if yxr < 181@re inc 668 if h < 2484@cli dec -989 if foz > -3754@tl inc -495 if h <= 2486@tl dec 884 if tl < -810@s inc 405 if fe >= -2107@ec dec 842 if yxr >= 174@h inc -451 if yxr < 180@yxr inc 364 if hb < -3331@nfo dec -736 if xuu < -6272@ec inc 37 if piw <= 2957@cli inc 839 if piw <= 2955@foz dec 787 if cli <= -777@ar inc 343 if hb == -3339@piw dec 939 if ej != 1892@piw inc -36 if bq != -1927@ej dec -684 if tl != -1710@acc inc 882 if h == 2030@re dec 372 if acc == 990@h inc 23 if qym <= 4041@ej dec 446 if u >= -169@foz dec 293 if yxr <= 539@tl dec -526 if fe > -2110@ar inc 35 if ec <= -521@ej dec -839 if s != -1295@bq inc -816 if ec > -534@tl dec -913 if fe >= -2108@bb dec 888 if acc >= 983@tem inc -951 if hb == -3339@ec dec -562 if qym < 4046@nfo dec -696 if h >= 2049@u dec -376 if yxr == 542@tem dec 130 if ej <= 3429@nev inc -484 if h >= 2046@nev dec -902 if yxr >= 539@qym inc 306 if nev >= -498@bq inc -306 if hb <= -3334@tl dec -807 if fe > -2113@nev inc -47 if nev <= -483@u dec -228 if xuu == -6277@hb dec 925 if s < -1297@acc dec 236 if cli > -786@h inc 684 if u >= 429@nfo dec 912 if u < 440@xuu inc 529 if bb < 3464@tl inc 143 if qym != 4354@ec dec 694 if tem == 3791@fe dec -542 if u < 441@piw dec 433 if yxr >= 540@ln dec -537 if hb > -4272@acc dec 419 if acc > 744@xuu dec 31 if fe == -1557@ej dec -297 if yxr < 533@foz inc -281 if ec <= -656@cli dec 712 if tl > 677@bq dec -871 if foz >= -4817@bb inc 381 if ln < 8294@nev inc -670 if tem > 3783@yxr inc 860 if nfo < 14@foz inc -120 if nfo > 25@ec inc 793 if fe >= -1563@qym dec -827 if qym < 4351@ar inc 687 if cli >= -1495@bq inc 975 if re < -1191@xuu inc 177 if u != 442@tem inc 363 if nev != -1207@acc inc 707 if cli < -1491@nfo dec -381 if tem > 4148@ec inc -347 if tl != 697@ej dec 995 if s > -1303@acc dec 452 if bq == -2080@u dec -851 if piw > 1539@ln inc -993 if re != -1211@nfo dec -591 if tl >= 692@s dec -410 if yxr != 549@yxr dec -54 if u >= 1288@bb dec -733 if re <= -1193@piw inc -984 if re < -1193@ln dec 133 if ec >= -211@acc dec -218 if fe < -1561@tem inc 792 if fe > -1567@bb dec 359 if yxr != 541@tem inc 273 if h != 2735@ec inc -714 if nfo < 401@hb dec -555 if bb <= 4206@nfo inc -151 if ln > 7294@hb dec -635 if yxr <= 550@acc inc -603 if u < 1282@nev inc 705 if cli >= -1488@cli inc 568 if ej < 2435@nfo dec 795 if nfo >= 246@s dec -996 if ln != 7289@u inc -530 if nfo > -550@tl dec -431 if qym >= 5171@fe inc -998 if ec < -920"

	set tMax=0
	for i=1:1:$length(pInput,"@") {
		set tTemp=$piece(pInput,"@",i)
		set tReg=$piece(tTemp," ",1)
		set tDir=$piece(tTemp," ",2)
		set tIncVal=$piece(tTemp," ",3)
		set tCondReg=$piece(tTemp," ",5)
		set tCond=$piece(tTemp," ",6)
		set tCondVal=$piece(tTemp," ",7)
		
		set tConds(tCond)=1
		
		set tRegVal=$g(tVals(tCondReg),0)
		if tCond="!=" {
			if tRegVal'=tCondVal {
				if tDir="inc" {
					set tVals(tReg)=$g(tVals(tReg),0)+tIncVal
				} else {
					set tVals(tReg)=$g(tVals(tReg),0)-tIncVal
				}
			}
		} elseif tCond=">=" {
			if tRegVal>=tCondVal {
				if tDir="inc" {
					set tVals(tReg)=$g(tVals(tReg),0)+tIncVal
				} else {
					set tVals(tReg)=$g(tVals(tReg),0)-tIncVal
				}
			}
		} elseif tCond="<=" {
			if tRegVal<=tCondVal {
				if tDir="inc" {
					set tVals(tReg)=$g(tVals(tReg),0)+tIncVal
				} else {
					set tVals(tReg)=$g(tVals(tReg),0)-tIncVal
				}
			}
		} elseif tCond="==" {
			if tRegVal=tCondVal {
				if tDir="inc" {
					set tVals(tReg)=$g(tVals(tReg),0)+tIncVal
				} else {
					set tVals(tReg)=$g(tVals(tReg),0)-tIncVal
				}
			}
		} elseif tCond="<" {
			if tRegVal<tCondVal {
				if tDir="inc" {
					set tVals(tReg)=$g(tVals(tReg),0)+tIncVal
				} else {
					set tVals(tReg)=$g(tVals(tReg),0)-tIncVal
				}
			}
		} elseif tCond=">" {
			if tRegVal>tCondVal {
				if tDir="inc" {
					set tVals(tReg)=$g(tVals(tReg),0)+tIncVal
				} else {
					set tVals(tReg)=$g(tVals(tReg),0)-tIncVal
				}
			}
		}
		if $g(tVals(tReg))>tMax {
			set tMax=tVals(tReg)
		}
	}
	
	quit tMax
}

ClassMethod Day9P1(pInput = "") As %String
{
	set:pInput="" pInput="{{{{{<!>,<!o,!!!>{>,{<<a!>u!>eio!>ui>}},{},{{<!!e!>>},{{<uo'<!!!>>},{<!>'!>},<e!>,<""ea!!!>!>,<>}}}},{{{{<""a"">,<!><<>}}}},{{{{{},{<{!!""!><ae<},!>!>!!!>}'!!>}},<!!a{!!!!!>!>,<!!!>,<{oiu<a!!,<>},{<>}}}},{{{{<eoa!!eeea{!,<>}},{{<!!!!,}!>!!a!!!}e!>},<!!!!!>!>i!e!>,<!u<!!{!!!>!!!>>}}}},{{{{{<!ea,uio!}""!>},<!>},<u<!!!!o!<,!>>,<!>},<"">},{}},{<ua""!>,<!!!>eouaa""o}!!!>!>,<>}},{<a}!>!!<'a!!<!u!!!!!>!!!>!!!a!>},<!>,<>}},{{{},{{{},<ua}!>!!!>i}}u!!!>},<!>!ii!!'!,>},{{<{>},{<i<!!!e}!>,<!""'a!!u!!{',>}}}},{<!>},<!!!!},o}!!}{!!!"">}}},{{{{},{<!>},<!!!!!>}}{'>}}},{{{{<},{a!>,<>}},{<>,<!i>}},{{{<""u!i{!i}a!!!>""'>}}}},{{{<<e!'!!i'!!}{!>,<u,""""!!i<ui!!!!!>!!<>},<!!!>'u!!ea!>u'!>}!!!!!>>},{{}},{<""i}u,,>}}}},{{{{{{<',!!,uo!,""<,{!i""{<<o<o>},<<a!>},<!!ee""'!!>},<>},{{},{<{!!!!,!>,<,"">}},{{}}},{{{{},<,}i!!,e!>,<!!!!<!!}!!{!>i{ou>},{{},{<!!!>a""!!!>!!!>a,!!i!>,<!<""e""i}!!i'e!!!>>}}},{{<{!>!>},<a<i!>,<uao>,{{<<>},<!!!e}a!>}>}},{{<""!""a,!!!>{}!!u'u{>}}},{{<oe!>},<'!><>},{<!!!>i!!!>!!!oa<!><oeo!>},<>},{<}!!!!""!a,!!'!!!>>,<!!!>!>},<!>>}},{{{<ei<""!"">,<io!!!!},!!<!!a<!{a,'ei>},{}},{<}!!!>,<!!!>!>},<!i}<i>,<a',!>{!>},<o!>!!!!!>""o!!!!!{}!o>}}},{{{<"">,{}},{{{<""}!i!!oi!!!>},<''>},{}},{{<u!>,<ea!>},<!!!>!!>}}}}}},{},{},{{{{{}},{<u}!>},<,{!!,!!{}oo!>,<!>,<>}},{{{{},<o!a}'!!!>""!iii!>,<{!>},<>},{<!u'}}!>},<!>,<!>{!>,<u}}a!!u,u>}}},{{<""!!!>!>},<!>},<'>,<{a!>},<uuo>},{},{{},{{<!!!>!,!>},<''!!!>,<!>{!!!>!!!>!!!>},<{,!!!!e}i!!,>},<!!!!!<<o!!!>'e!u!!!>e!>u!"""">}}},{{{<!>},<!!u>}},{{<<""!>!!!>e!>e!!!>!>,<a!!!!!!!!!'ia>,{}}}}},{{{<!>!!{}!>!>,<>},{{}}},{{<!!!>ai}>}},{{<!!}'!!}!>,<o!>},<{!>},<!!!>,<''!>,<!>},<!!!!,!>>,{<!>,<!a!!!>,<}<'!o>}}}},{{{{{<>,{{<!!!!'!>,<!>},<<oe!!!>i!!{i<!>}e>}}},{{<!!!!!!!>ao<!>},<!>,<!>a!!,!!!>!e!>u>}}},{{},{{<""{a!>}!>},<},},!>>}}},{{<!!!>,!!a!!a!!!>},<i>},{<!!!>}!>,<>}}},{<!!!>},<!>'!!!><,!<!!!>,!ua!!!>e!>},<a!>},<<>}},{{},{{{<{u{aie!!""!!!>a>}}}}},{{{},<a!>},<u>},{{{<!!}<>}},{{{}}}},{<!>!>},<!i<}>,<""!!!>!>},<!>i!!!>o}u{!!!><{>}}},{{{<!>},<<,!>,<!!{!>},<{<o!>},<""i!<'ei>,{}},{{},{<uu!!!!!!o!!ei!!""{e''!>!!!>>}}},{},{{{<e>},<ao>},{<ai!!!!!><}!>,<>,{{<!!!>o,a<!>,<'}>},<o!!{!!!!!!a!oe!!""!,<a>}},{}}}},{{{{{{<o!>!!!!>},{{<i""a!""!e<!>},<u"",oou!>ua!!!><>}},{{}}},{{{<>},<o!!!!!>,<!!!>,<a!!e!!!a""!,,!!!e}""e>},{<""!o!!{!i!!!oa!!!>!><,!>>,<e!>!!,u<u,i!!!!!>},<{'""!>e{i'>}}},{{<!>o!>!!!>!!a!e!<!!!>},<o!e}e!>},<ia"">,<!!}!!!>uaao!!!>e!ai!!!>>}}},{{{<""!u,!!!>},<!>,<!oo""!>,<!!!>!!!>}i!!!>!!!>'>,{<!!!!!>!!!a{o}<e<!!!>!>>}},{<!au""!!}{,o{!>},<!!>}},{<!>},<a!>,<""!>{'ia!>{'!!!>a!!{>},{{{<}e!>},<!!o}!>{!><!iio!!>}},{{{{<'!!i!!'o{,!e!!!>oi!>},<!!!>!!o>}},{{<,,i!!!>!a!,{{!>,<e!uo!>,<>}}},{{<!!!>},<<u,a>}}},{{}}}}},{{{<!!!>!>!>},<{i!!!!oe>,{<ui!>e!!<>}},{<!!>},{{{{{<""!>},<u!>},<!!<e>},{<o!>},<,!!u{o!e'}'!>,<!!{!>,<uo>,<!!!>>}}},{{{<!!!!!>'e>},<!>,<!e,o!!!!o>}},{}},{{}},{{<a<o>},{<!!,}}i!>,<!e!>},<!!""a!>,<!!{a>}}}},{{}},{{<!>},<!!!>uoi!}eu},!!o!>,<iu{o,>},{{},<,!!!!!!!>!>,<o"">},{<o>,{<!>},<!>},<!!a!><u!!!>}}!!!!!>uo>}}},{{},{<o!>},<ia!!!!!>!!u""!!u!>},<>}}},{{{<<{!!!!o!>,<!i<!!""e<!>,<!!}!>},<'a{!i>,<!>>},{{<!>,<!>},<""!>,<{{'>},{}}},{{{{{},{}},{{{{<u!>,!>!!!!!>!u<}iio""i'>}},{<}}<e!>},<o{!i'!!!>ioi""ua>}}},{<<}>}},{{{{}},{<!!>}},{{{{<{',!>},<!>},<aue""!!!>>}},{}},{{<!>},<!!!>!>!>},<>}}},{{{<!>},<'!!ao'!>,<{<!>},<<,aeu>},{<{>}},{<<!>},<!!""}'!>!'uoo!!o""{aii!>},<,a>},{{<a!>>},<!i!!<e!!!>},<,!<!>,<!!!>!!!>!>,<!i,e<'!!!>,<>}}},{{{<!!'!!!>o}i{!><!!""}"",e!>},<ii!!{>},{{<<{!>,<!!!>>},<"">}},{{<eo!!!>{!>,<,<!!!!i!!!>!>},<<'o>},{}}}},{{<!!!>o{}<!>,<<e>,{{<,}i!>},<!!!>},<!{>}}},{{<{ai!>,<'u,!!!>'!o!>,<i<!>,<}ai>},<ei!!a!!a}!i!!!>,<>},{<!!e!>},<{!!!>>,<!>},<!{!!!o""i!!{>}}},{{<!>},<!>},<',ia,>,{<!>,<ou!e!>'i!>,<iea}e!!o!>},<i!!e<>}}}}},{{{{{{{<e'!o'!!!>,<""!!!>!>},<iu>},{<<!!!><{>}},{<'!>!>},<>,{}}},{},{{{{{{<!!!!,a!>,<!!!>,<u>},{<!'!>},<!>},<!!{'aia!!}!>},<,<!!a!!<io>}},{{{},{{<!>,<!!,}!""}}!!!>i!!!>!>,<!!!>!!<{>,{<<!!!>},<!!e'<!!'>}}}}},{{<!!u}!{,'!>},<!!!><'>,<u""!>},<i>},{{<{!>,<!!!!a<!!!,>},<i!>ia!!!,,!i""}""!!<!>a{!!!>!!}"">},{{<}!>,<,>}}}}},{{{<!>,<!>},<,!<!!},e!!!>""""a'i!<eo<!!o>}}},{}},{{{{},{{<e<>}},{{{}}}},{{{<e!>>,<!!!>},<!>!!!>,<iu'uo!""!>},<o!o,i!!!><!!!!!!!!>}},{},{{},<!!!!'!>,<ia!!'!!!>!!!>!>u!>!!a>}}},{{}},{{{},{{<,>},<i>}},{{{<<'""oe!!o>},{<!>,<u!>""!""}{a>,<!!'!o<o,!>,<!>,<u}!>},<',!!!!u!o{!o,!""a>},{<!!uu'!!a,'!>{u{!!<!!}!!!!,!>,<>,{{<!>},<!!""}!!!>""!>},<!!!>!uue>}}}},{{<>,{{},{{<!!u'a!!!>!!!!<!!!>!>},<'>},{{<{,'!!!!!>aa!!,uui}!!!>!o!!,e>}}}}},{{<oe!!!!!>>}}},{{{}},{{<!e!ioe>},{<,>}}}}},{{<a!e'e,!>""'<!>,<!!""i}a!>!!>,<ee}iu!}}a<!!},}'!!o,!!>},{{{},{<e!!!>o,!!i'ui!!!!i,a!>},<}>}},<!>},<!>,<,""!>},<!>,<{!>},<,,,>}}},{{<!{eu!>,<ue>,<e!!""'{!>,<!>,<'!>,<aaao""oa{!!<u!>},<>}},{{{<!>!'!!eeu!>},<!>},<<!!}!>},<'u{!!o>,{{<!>},<!!!><!>""!!e!>},<!!u!>},<>}}}},{{{<!!'!!oa'!!!!,!!!>>},<e!!}!!{}'""!>},<!>,<}eue!!e>},{{<!!,!>!>},<o!>!!!>,<a'""!!!>{o!ie!!!>>},{}}}}},{{{{<i!>},<!>},<e!'u!>},<!>!>""!o<!>,<>},<""!!!!'>},{{<!!}ai{<,!!o!,e!!u!>},<<u!>,<>}},{{{{<>}},{}},{<""!>},<}!!!!<<!!}!>},<!>u,""e>}}},{{{<!!!!!>!!!>,<!!i{!>},<!!i{{>,<a>},{}},{{{}},{<i>}},{{{<uuua!>!e"">},{<!>,<!!!>}a<,!!!!,e!!!>>}},{<!!,!>},<!>},<!!o!>>,<!!!'!!!!!!!>}""eua!!!>!!!>i!!!>,<!!a!!!>!{!>},<!!>}}},{{{}},{}}}},{{{{{<!>,<ei!!i>},<!>a{o>},{<!!u!>,<i>}},{<i'""{>},{{{{<!{!!!!aa{''!>,!!'""!>,<!!!>,""a!""!>!>,<'>}},{{<!{!""u!>,<o!!!!!>e!!!!!>},<!>!""}!i>},<e'<'!>,<i""}{!>,<!>},<""!!!>"">}},{<!>!ui,e!!!>e>,<!>},<>},{}}},{},{{{<a>},<o""o!}!>,<'>},{},{{<<!!!!!>!!ao!!eei!>,<>},<eu""!!!>}<}!!<o>}},{{{},{{{<,i}aui!!}!!!>}!!{!!!>'!<'!>,<<!>},<{>},{<"">}},{<!>,>,{<!>,<!!a!>,<o>,<!""au{!!e!>!!}""}>}},{{<!!!>e!>},<o!!e!>e<ea!>!!,!u!!'i!!!',>},<!!!>},'i!>},<,!>!'!>!!""o,}!!!!!>>}},{{<!!{,oai},!!<!!!>'aaa>}}},{{<}!o!>},<>}},{{{<,""}a<o{!>i>},{{<""!!e!!,!!e!>u!!!>!!!>,ue!!o,!>ei>},{{<>},<!!!>},<a'o!!!>,<'{!!!>io<!e}!><!'>}}},{{{<>},{{},{{<!i}uee""e!!!>!!!!!,!!,!!!!!>u{!!""<>,{<'eauu!!,i!!!<a<ea>}}},{}},{{{<!>},<eeiuo!!}<""!>},<ii,<>},<o>}}},{},{<""!>{>}},{{{<<!!!{!>au!!!!!>u!>},<,!>a>}}}}}},{{{},{}},{{<!!e!>!!,!>e""!>},<<e{!>},<'!aeaoi>},<{o!!!!}ue!'<'!!!>!>!'a<!}!!u!i>}},{{{{<'<o!!}>}}},{<!>,<!>!>},<!u!>,e!>,<""!<eu'!>,<,!>i>,{<>}}}},{{{{{{},<!!!>!>},<!<o!!!>i!>!!!>,'>},{<!!!>u!ua!i>}}},{{{{<i!>},<!!<e<!!!><!""!>,<,!!>}},{{{{<!!!>o!!,}!,>}}},<!>!!""}!>i!>!!u!>,<!!!>!!o!>},<i"">}},{{{{{<!!u!>,<"">},{{}}}},{{{<!!',>},{<""',o!>},<e!!!!ee!!oi{i,>}},{{<'>}}}},{{<>,<'!>o!>},<!!,}<!>,<{{!!!!!>i!>""'!!u>},{<""!>,<<!>!u!!'u!!!>,!!aa!>},<!>!!uo""{>,{<!>},<ei!!!>},<,uu!!!!!!,!>io{!!!!>}}}}},{{{},{}},{{<!!!>,<!!!>!!,!!!>eo}u!!!!!>>,<i{!!!!!>!oi,!!e!!!>,<<!!!>!!!>,<,!>,<'!>>},{{{},<!>},<{ao!""""!>'!>,<oaei>}},{<!!!>},<!,!>,<o>,{{<!>},<oiui}""!>,<""""u!!!>}!>!!,ii!!>}}}}},{{<e!>},<o!!!>,<"",>,{<!!!>iuoa!!!>!>,<e!!!>!!,}a'!<a}!!!!,>}},{{},<!!!>!>,<!>},<!!!,'i}>},{{{},{{}}},{{{<>}}}}}},{{{{{<{!>},<}u!!!!!>!'!!!>!>},<}!!!>!>},<!>},<e,!!!>,!>,<>},<!>ea!!!!a<!!o!!i>}},{{{},{}}},{{},{<!{!>,<>,<<>}},{{{{{{<!>,<!!{!!!!}!!o!!!>}!eu!!!!!>,a""!!a!>ei<>,<!>,<!>},<""!""a>},{{{<!>}!!!>,<}a!i>,{<!>,!>},<i!!!>!!'>}}},{{<<oi!}e<""u!!""}!!!><'!!!>>},{<!!>}},{{<!!!>}'!>},<u!<!>,<{!>,<<>},<u!,!!!>iooi!>e,{<""<io}!>,<>}},{{<!>},<!>},<!>},<o!>ua!!!!<uoi!!!>!>au{,>},<!!!>""e!>uu!>,<}>}},{{{},{{}}},{<ioe{!>,<oe{!!""!!!>!!"">}},{{{<ei""!!!>!!!!!!!>,<!!,!!!!oo!!!!e!>,<'!>},<>},{<u'!!!a!!!>},<!>},<!!!<>,<,a,iu>}}}},{{{<<<a!><<!!!!!i""i!!!>,<!!!>{!>},<i!>},<},<>,<!>u{!!""!>!!},!!!!!!ii!>{!!e{aa!>},<>}},{{<>},<<!!!><!>,<i!>},<a,!,!>!>ii<!""o>}}},{{<!!'}}<e}>,{<!!!>o{!>},<!io!!{{au!!o!i''uo,!>},<>}}},{<!>,<!!>}},{{{{},{<e!>!>},<}>,<>}}},{<!ou""!!!!!>a!u!>,<!>},<<}}!!!>,<'<aa>},{<""o!ii""!>,<""}!><!>!!{!>o,!!u!!!!!>},<a{>,<<!!i>}}}},{{{<<""}'e<!>,<}!!!!!>},<,!>,<>},<{!>!>e!!!>!!ei{!>},<{{eoao""i>},{{<{!""{!!!{!!!!!>'!eoee>},<o!!>},{<a!,!!!'u>,{<!>,<!>},<i!""o,i!!!>},<>}}},{{{<ea}a!>!!!>!>!>},<!!!!!>,<e!>},<>,<"",''uooa!!'uo>},{{<!!a>},{<u<!!}!!eu!!<!"">}}},{{<!>,<u!>!>,<}!a!!!!e<uu!>oa!!!>},<e>},<<!!!>'u}!'""""!!!>},<!!iu>}},{{{<!e'"">}},{<<'}!>!!!!!>}!!!>!!!!!>i{!>,<!>ie>}}}},{}},{},{{{{<u!>!!!!!><a>,<,<'>},{{}},{<ii""!!<i<!""u!>""!},e{,<>}},{<!>!!}!>,<""a{a,i!,{!!>,<!!i'!}a!!!>},<<!!{!!!!!>},<!!}""o>},{{{{<ou!>,<a>},{<'a,u<!!<iu}i!>!,>}},{{<,!!'!>},<e>,<!>,<!>},<a!>},<,!>aou<!!!!!>!!'!!!>'{!!!ea!>,<>}},{}},{{<!!!>!!>}},{{{{{<ouu!!!i!>},<!!e!!,!!{u}'e>},{<eeea}a>,<!{e!>!!,}a!!!>>}},{<,>}}},{<a!,u'>,{<}{'!>},<u!!',,eu!uo!!!>>}},{<!!u'>,{<"",!!!!!!!>!>,<a}e}'{>}}}}},{{{{<!'!>},<!!i!!!o,u!>!!!!!!!>!!'io<!!<!>},<>,<""!!!!!!!a{!>,<>},{}},{{},<!!o!>},<!!!!!>!,!!!>,<}!u,!o!!!>!!!>>}},{{<!>,<a{'{e!,i!>},<!>,<!>,<>,<<',}!,'<!!!''!>},<!>,<,>}}},{{<!<""""e!u!""!>},<i!!!>o!!!>""!!,,!!i>,{{{<""e!!!>,<o!>},<!>a!!!a!>,<,""""!>},<>,{{<},!!!>!!<i!>,<""iu>,{<u,!>u>}},{<i!>},<!!!!!>u!>}'!>},<!!!>>}}},<e!!!>i!!i!!!>!!!!""o!!!!!!!>}ee<}!>>},{<a!>!!'>}}},{{{<!>,<!!!>'!>!>,<!>},<'!>},<!!u!>!>,<!>,<>},{}},{{{},{<',!!!>!>},<!!{<!!!!!>!!!>o!>},<a>}},{<uie!!!>>},{<{""o}u},!!!>""!!>,<!!!>!>,<!,i!!!>,<!!{""!!!>o!!!>!!u!!!!!>!!!!!>>}},{{{<'o!<!!e}!!e!>,<!}!!u!>},<!>},<ao!!""!>},<!!}!>,<>},{{},<!!,!>!>}ua!!!!>}}}},{<'!>!""!,!>,<!>},<!!!><eoiuu!!<!!!>!e!!!>>}},{{{<i!e<,!!!>!>},<,>},<<o!>,<<>},{{<>},{<!!!>iu!!!>!>!!!!!>!<!!!>a!!!>!!a!u!>>}},{<>,{{<a!>!>},<!>,<!!!>{!!i!u"">}}}}}},{{{{{<!>},<}!!!>},<{!!}eu!>},<}i<oo!o>,<{!!ae!a'!>},<!!>},{{<>},<!>},<!>},<{!!!!!!!>,<!>{!}}"">},{<{!a!>},<!!!>eu!!{'!>},<!!!i!o!!!ae}!!,>,{{<}!!!>!!<!!<<!!!>{oi{!>},<!!o<'o{>},<!>!>,<!,ea}""!!<!>},<u!}""o!><i>}}},{{<!!!>}e!!!>>}}},{{{{{<!>>}},{{<""i>}}}},{{<a>},{<u{!!!!!>!<a!!{!!}i!!{!!!>!!{{!>,<u}u>}},{{{},<!>aoa!!{!>!!e!!!>!!!>}<'!!},!!e}>}}}}},{{{{{{{{<!!!>""}>,{<a}a""!!!>,o<!!!>!>},<>}}},{{{<!!!>!!e!>!!!>>}},<!>},<a!>,<<!>,<i>},{{<!>},<""{!!!!eo!!!!!>,<"",e!><u>},{<oue!>,<""!>,<>}}},{{{}},{{<!>,<e>,{<ui!!!>u!>},<!!ee{""<!!!>!!uiu!>},<,<!>},<>}},<!!{!!,""!!!>!!!!!!!>,<!!!>},<}>},{{{}},{{<>},<!>},<!!!>!>},<{<!>,<!!>}}},{{{<>},<!!}!>""<!>>},{{{{<!>,<!!uu!>e!>e}""!!ei!!!>>}}}},{<'o>,{}}},{{<,!>,<""!!a!>e!}!!!!i!>>},{{{{<>}},{{{<>}}},{<!>!{!!{>,{}}},{{<!>},<u!>oe!>ao>}}},{{}}}},{{{},{{{<!>o,,>}},{{<u!!!>{!!'!>!<''o""{>,<!o!!!!u!!!>'""e!!'<a!!!><}!!""}!>,<>},{<,}!!<a}!""{!>,<e!!!!!>!>!>!!!>}!!!>!>,<oo>}}}},{{{{<}e}!!e!!!!!>{o!!!>!>o>}},{<!'e!!!>!!!>eo!>},<>}},{{{<!,!!{!!a>},{<!!""!!}!!ei!>,<!!u!!!!!>!!au!!!>,<u>}}}},{{{<!>},<!i!!!>,<!!>},<!a{!>,<!!a!!a,!>},<!>""'{i""!>,<!!!>!!>},{{{{<i!>""!!!!'!!>,{<a!!',!!!>>}},{}},{{{<',u!>},<!!<!>!>ueuo!}!!!!e>}},{}}}},{{<,!>},<!>'>}}},{{{<!!!,!!!>i""!ae!>,<!!!>},<e>}},{<,{i{!>},<ai!!}>}}},{{{},<!>,<!>},<<o!,o,<}>},{<a,<}!>!!e>,<}!>,<!>},<!>},<!!o!!!!!>,{""ai""u>}}}},{{{{},{{<!>,<{oi!iu{!!!>!!!>ea>},<e!>!><o!!u!!!!!>!>},<ee,""o{,'>}},{{{<u!!}!!'},!{!!!>!!!>}!>,<u!!!>o!!!!!ia,>}},{{<!>a!""!!{!!!>>,{{{{<o!>!!e'<u!i!>a,e!>,<>},<!!}>},{<{a!>,<{,u!!!>i!!!>!>,<>}},{<!>},<!!!!!>{u>}}},{{<!!<!!!>o!>!!}!>},<""o!!eiia}>,<>}}}},{{<!!!>i!>},<!>!>!""<<!>a<!>o!!!>!!{!!!>!>,<>},{<!!!!!!!>e{e,a'!>},<}""!!!>,<!>,<,}>}}},{{{{{{},{{}},{{},<!!!!eo!'!>,<>}},{{<!!,oaa!a!!!!<'u,!!!>},<{!!i!!uea!>},<!>},<>},{{{<""!>,<!a'!>,<e!>a,""a>},{{{},<>},<!>!!!!>}},{{{}}},{{{<<e,'!!e!!<'a!>},<!>uo{o,!!!>!!<!!'>}},{<iu{u""i'>,{<!!,!>,<i''{}!'eo>}},{{{},{<!!!!a}>}}}}},{{<!>!!!>!!!>'!>!!!>!!!>'!>},<!!!>,<!!!>>}}},{{<!>},<a<'!>,<!i'o'!>},<""!!i!>,<}!>},<}!!,!>!>},<>,<!>,<'u!>,<aa!>,<a!!!>a!>},<i""!!!><,>},{{<!>},<!>,o!!!>!>},<!>},<ei>},{}}}},{{{{{<!>"",!!!""iio!!<{'}}!>,<>}},{{<u!>!!{''!""!!!!!>,,>},{<!!!>uuoa'!""""!>,<!!eaa!!<!a!!!>>}},{<!a<!>,<>}},{{},{<<""!<!>},<eu!e<!>},<>}},{<""!!!>}ii<!>,<>}},{{{{<>}}},{{<!'uo{!!io!>},<i!""!!!<<',,!!!>iu!!!>>}}},{<i<<ao!!}!>!<!>},<e!!i,!>i!!!!{!"">,{<,!<!!{,!>'!!!>a!>},<u!!!>'<!>,<!!!,u!>!!e>}}},{{{{{<e{!>o"",>}}},{<!>},<a<!>},<!>,<,>,{}},{}},{{{<o>,<<!>},<!>,<!!!o!!,!,}u!!{>},{<{!>},<!!!>""'>,<!!!>,uu!!eu<!>ueii>},{{<!""e'!!u!>},<u!!!!!>{e<a<>},{{},{<>}},{{<!>',!!}""i!!!!e!>!>,<,>},{<!!!!!!,>}}}}},{{{{<!>!}!!!!ui>,{}},{{<a!!!>!>!>!!!>iea""!""!!!>!u>}}},{},{<<!!!>,<!!!"",""!!!>!!}!>,<o,}a!!!!!>!>io>,{}}},{<u>,<!!!>!!!!!>{!>},<<""e!!eu!!!""!!eu>},{{<i!>!>},<{ii!>!!!>a!!!!i<<!>},<!>,<!!!>!>>},{<!!e!>,<!!!><a'!!!>{''ie!'>}}}},{{{<!!<!>!!}}!!!!i""i!!o}!>>},{<!>},<a""!!!>i'i!!!>},<<{u>}}}},{{{<!!!>""!!e!>}u>}}},{{{{},{}},<!!,>}},{{}}},{{},{}},{{{{<o!a!!!>!>!!,>},{{<<<!<oa>},{<o}!!!>!>},<!>},<>}}}},{{{<!>i>}},{<ea>,<!{<""""<!!!>!!!>{a!i<u!>},<i!!!'!}',e>},{{<o,!!>},{{<o>}}}}}},{{<>},{<e!!!>!>},<<!!!>>,<!>},<""!<!>'{""!!!>!'<e!>o!!}!>,<>},{<""!>},<!!!>!o{a>,{}}}},{{{<u!i}'i'!!!>i!>'a>}},{{<!>,<a}}""""a,>,{<a!>,<o!!""iu!>,<'""""i!!!>!>!!}e{i>,<!>},<!>!!""!!!>""}<{!>},<}!oe!!!>'i>}}}}},{{{{{{{},{<uu!!!<,}e!!!>>}},{{{{{<a!>},<o}a!!!>>}},<'<'!>a!!o{a}!!!>"">},{{<}!>,<""!!!o{>},{<!>},<""ao!>,<!!""a!o!!!>!!!>!o!!!>a!!e,>}}},{{<>}},{<,e{>,{}}}},{{{<!!!}'u!>!e!>,<<<>},<'}o}!"">},{{<'<o!!!>a!>,<!!,""!>>},<!!!>},<!>!>},<<ue!!!!u!!!!!!ua!>},<!a>},{{{{{<!!{!>},<'!>!!!>,<!>!!!>,<!!'u!!i<o>,{<!!o!!,euua'!>,<'!>,<!!!>},<}>}},{<{!!!>!""!!{!>ao!>!>},<!!i>,{<!><""!>,<!!!>},<<o!""!!<aa!!!'}u>}},{{<!>,<{,>},{<u!,!u!>},<!!""{>}}},{{<}!!!>},<e!!!!{,!!e!!!>},<!>,<,!!',>}},{{<'i!>},<!!<ua!>},<!>,<!!!!!!!>,<''o<!!!!!>!!!e>,{{{},{{<>}}},<"",>}},{{<ie!>!>,<eu<,!!!>,<!{!!!>},<!>},<{u!!i!>,<>,<!!ai!>,<o!!!>}!!u!u{!!!>ai!>,<""'e!>},<>}},{<oe!>},<!!!>!,!!!>uau<e!!>,{<!>,<<{>}}}}},{}}},{{{<e<!>},<!o'u>}},{<o""a""""!>},<ae!!}!,!>,<>,<}<,}!u!>,<!!{!>""o,i{!!}>}},{{{<u!!!!!>,a!!!!!a<{e!!i!!<eu!>,<a>,{<!!!>>}},<>},{{<!>},<!><!!!>,<i!!}a!!<!!e{{!>},<e!!!>>},{}}}},{{{{{{<a!>},<o'!!''e""!!<!!!>!o>}},{{}}},{{}}},{},{{{<""<o>}}}},{<!>},<!>},<}}!>},<u!>},<o>,<!!!!!'i!!',}ea!<!>a!>!!>},{{<!>,<}u!>,<o!u!>,<o!>},<a!>,<!!!>,!!!><!>,<!>},<>}}},{{{<{!!ai!!<{o!!!!!!>},{{},<!>!!u{<e<!'!!!>,<e!>,<,{""e!>},<"">},{<!><i>,{}}},{{<,!>},<""e!!a<!!a!>},<!>},<""""!!!!>,{{<'u<<!>o!>,<'>},<'{i'!!""!>,<!o!!!>ue}<}a!!!!>}}}}},{},{{{{{{<e!!}i!>},<oi!>},<""!>,<!!!>eua>},<{!!!>}>}}}},{{{<!>,<,,u!!!>ue<!!!!}!>,<{{>},{}},{{}}},{{{{<'!!!!o{!>},<,'!>,<,""oe!>},<u!>},<!!o!!}!!i>}}},{{<{!>,<e<e!{'<!>,<!,o!!{!!{>,{{},{}}},{{<a,<o<!!!>!>,<!{!!!!!>!>},<<ui!!!>{{!>,<!!'>,{<!!!>ia""!!}!>,<!{>}}}},{{{},<!!ee,!!!u!!!>},<!>{!>,<a!!}!>!>!i!>},<}!>,<!!'>},{<!'>,{}},{{<!>},<!>!""""{ei!!}e!>,<!>,<!!!!""u!'!!!a!>,<!>},<<>},<'!>,<!e<'<oe!!!>a!"">}}},{{<u!!!>,!>,<!!ea>,{<""!!""e{,!>e!!!!uei!!!>!!!>!!!!!>!>,<a!!eo>}},{{{{},{{<ie!>},<!>},<oeu}!!!>i'!u!>},<>},{<,!>!>ea!<!>},<e!!{!,!>e>}}},{{{<>}},{{<!'o!>u!!e!>},<a!!!>!!u!!!>},<,!>,<,i!!!>,<!>a>}}},{{<!>},<<a<e'>}}},{}},{<u!!!>u!!!>},<!>,<!!!!!!<u!>,<!!!,!!""!!!!!>!>},<!!!>>,<{e!>{{!!!>!>i!>u!""<!!o!!!>""!>,<'u<>}}},{{{{},{}},{{{<!>,<o!!{!!!>u!!!>!>,<>,{}},{<!>!>},<a'}ou!!'!>},<!!io>}},{{<!!!><i!!!>'>},{<'!!e<{""!!}{o>}}},{{{{<!>}!>!!!}'!!}!>!>},<e,!!}!!e!o!!!!!>!ea>}},{{<u!>,<<!!!>!!!>i<>},<!!o""u{>},{<!!'>,{}}},{{{<<u!!!>!!}!!!!!>,<a!!u""!>},<!aae!e>},<'!!!>!!!>,<""oa""!>},<!!,<!!!>io}!>!!>},{{{{<!>i<!!u""!!ie!>,<,!>!!'a!>},<u!>>},{<u<ea}!>},<!,e<{e!!!>>}},{{<i!>,<!!!>,<!!!>!!!>,<!>},<'!>,<a!!!>!>,<}!>,<<>}},{{{<ou!!{!!""""{!!!>!!<!!,""eu<!''!!ei!>},<>},{<!!!>>}},{<i!!!!!><<!>,<!,!!e!>!>},<>}}},{},{{},<{!!!>iao!>e,""o!!!>!!!!!!u!>,<o!""!<,>}},{{<!!}!>,<iei!!o>,<!>,<!!!>o!!{,i!!!>!!!!a!!!>},<,!!""o>},{{{}},{<""!!!!!!'u"",!>uui!ai!!'>},{{<!,i!>,{"">},{<<>}}}}},{{{},<>},{{{<}'!>,<iu',<>,{{{<'!>},<!!,!>!!!>!!<""{!!!!""a!o<!a"">},<a{<!!>},<>}},{{<o}""'o!>},<!!{!!!>{>},{<ua!aeu!>},<}!!!>i{u!!!!!>!>!!>}}},{}}},{{{{<ee<!!!>!<!!o>}}},{{{<ie<!>,<!!i!!i}a<'i""{{'e!i>,<,!!""!>},<!!!>!>},<,!>,<,{!!!>o""<}!!<""!'>}}},{{}}}}},{{<""!u>}},{{{{<i!>!!!>!!!>!!!>>},{{<}<<!>},<!!!>!""a!!o>},{}}},{{{{<!!!>>}},<ea!>,<{u!<{!>,<""}!!!!!!!>""i!!"">},<!!!>,<>},{<!>,<a!>,<!>,<a{>,{<!>,<!o!>!!{!>},<!!!>!!u,,!',!>,<e'>}}},{{{{<>}},{{{<!!!>},<}!!!!!!!!o!><}!!!!!>,<,,!!oi!>,<!!e>}}}}},{{{<<!<!!,!>!!!>,<>},<!<i!!e!!!o!>},<a!!!!!>aoi!>,<>},{<!><>,{<!>,<ia!!{!!!!!!}!>},<oi!>!>a}}ua!>},<>}}}}},{{{{{<uu!!!!!!!>}{!!!!!>i{!>},<e!>,<a>},{<!!'<!>},<!>},<>,{}}},{<ei{}e}!!u!!!>,<}!!!><!>u,}>},{{<,!>,<<!!iiou<!>},<{>},<u!!!!!>{}!>!!!>a!>,<>}}},{{{{{{},{<!>},<""!!}io!!i}{iu!>>}},{{{{{<ee!>,<a!!!>{,""!!!!e!!uio!!!>{!!!!>},<!>{!>oe!!!e!>},<i'e!'!!i!!'u""!>,<}!i!>>},<{""{ue''{i>},{{<o>},{<!><o!>},<}!>i!>},<!!!u!>,<}!>!>},<oaoi>}}},<!!i>},{{<oa!>},<!!!>}{!>},<i!!a,}!>},<}!!!>""o!!!>>,<<!>},<!>},<!!!>'!>e}!>,<>},{{},<i!!"">}}},{{}},{{<a!!""<a>},{{<!>},<<!!!>e!><ua<,!>},<}!>},<!!!>!>,<'}>}},{<!>},<!>!,{a{!!""!!!>!!'!o<e!!!!ee""!!}<>}}}},{{{<i{,""ai!>!>},<u'i!!>,<!!!!""!!!!}o!!!>!oue}""!!!>},<{!>{!!{>}},{<!>,<{!!!>},<!!!>!>,<!!!>},<,<}!>'!a>,{<!>},<u!!a{!!!>!>},<a!'!!a!!io!>},<!>,<<>}},{{<!}e<o!>!}>}}},{{{}},{{{{}},<{'""""a!>o!!!>'!>'!>},<>}}},{{{<!!!!!>!{>}},{{{<ia!>}i<!>,<a!!}>},<!!!>u!>>}},{{<>}}}},{{},{{{},<a!>,<!>!!!>},<!!'!euu,o{!!!>!><'>},{<!ua!,oe'e!ie!>,<!!!>!>},<!!'!!!>a!>},<!e>,<!>,<!!'!>,<""}!!'ou'>}},{{<uo!!o!!""!>,<,>,{}},<u""}!!au!!!!!>o!>},<}!>,<a,}>}},{{{{},{<!>,o'u!!!>},<""i{a!>,<o>}}},{{{<,i!o}u!!!>!!!!!>}>},<{u!!'!!{e<o>}},{{<}!>,<!!!!"">}}}}},{{{{<<a!>,<!!!>"">},<""{""!!<!{a<<!!o!>,<""o!>,<ii!!o!>},<ae>},{{<a""!>!>ui,e!e!!!><{o<"">,{}}}},{{{{<i!!!>!>i<<!!!><!>!!!!!>,<ui}>}},{{},{{{<!!!>!!!!!>>}},{<e!!""!!{""<!!!>!!a!!ai!""{ou!><!!!!>}},{<{!!!>!>},<!!!!!!!!e!>u,u!!>}},{{{},{}},{{<>,{<<!!!>!!!i!>u!!!>,<>,{<!!!>a!>,<,{!!{e!!!!!>i!!!>,<!!!>,<'!'>}}}}}},{{{<<<o!>},<""iu!!ai>},{{{{<{,>}}}}},{{{{{{{<e!!a!!!>,<!u'io!!!>e!!}!!""!',!>,!>>},{<'!o'o}!>,<>}},<!!!>}!u!>,<o!!'!!u!uau,!!!>},<o!!"">},{}},{<!>,<u!>""a!>},<!e<'e<""o!>,<!""i{u>}},{{<ao!!!!u!!!>>}}},{<,u>,<e""!><!!!>'o,'o>},{{{{},{<""!>},<aa<>}},{<,u!!!!!>,<!!!>oi!uo!e!!e!>!>!!}>,<!{oea!!!!!!!>!!!>!>,<!!!>!>},<>}}}}},{{},{{<>},<!!!!!',!!"",iua{'!!!>},<!u!!!!o!o>}},{{{{{{{<{!!!>!>,<!!ao""!>,<!!!>'!>},<!'oe!!}}!>,<u>},{}},<i!!,""!>>},<>},{{<!<ua!!!>,<!'""!>o>},{<eo!!<!!!'<!!!>}a>,{<'a''ui'!a!!}}'>}}},{{<o!>,<!>>}}},{{{{<e''<!>,<!>},<!{,,>},{{<e,o{e}o,o,e,!!!!>}}}}}},{{<!!i{!!!!oa>},<au!>},<!>!>!!!>,<!>e!>,<!!!>},<o!>},<!!o>},{{<""!>},<!!a!!}<'!!o!!""!!{<{{<!!!>i>,<!!au}o!!'}o}}ou>},{<!!ei!!!>e<!>e!!!>,<a,!!oi>},{{{<!'!>!!!!!!i!!}!'!!!>},<!!!>,<!!!>i{}!!!>,<!!{!>},<a>},{{{<!!!>,!}!>i<>},{<""i,!>,<o""!!!>>}}}},{<}{o>}}}}},{},{{<}o!},}!>,<}u>,<<}<,<!!u!>,<iii>},{{},{{<o!>},<!!!>'e{!>},<"">},{<!>a!!!>{'!!{'u,>}}}}},{{{{<!!!>!>},<o!>'ii!!!!aa!!,a!>},<'!oio!!!>>},{}},{{},{}}},{{{{<""io,""'!>,<o}>},{{<!>!!,!!!>},<""!!i}!!!>,<'<i!>>},<!>},<>}},{<!!!>!,!!!>'!>},<''!>},<o{'!>""<>,<!!!ea""!!ioi!!'""}'{>}}}},{{{{},{<!!,io!>!>},<!>,!!!>!i!>,<u!!!!!}a!""!!!>,<>}},{}},{{{},{{<i!>},<oeu!>},<}!!!!""!!!>!!<!""!>},<""'!>},<>}}},{<!!u'!>},<!!ui!!!>}>,{{{},<!>!>},<>}}},{{{<!!!>'o!!!i,e}!!!!!>a,!!'>}}}}}},{{{},{{{<!!!'i!!!!!><!>!!!>e>},{<!>!!!!u>}},{{}}},{{{{<'!>'i'!>},<!""'a!!o!!!>!>,<}!>,<<!>,<!!!!!ue>}},<!>o!!!>,<a!!u""'!!""ao!,o'!!!>!,<!""'>},{},{{<!!!>},<o!},'o!!!>!!!>>}}}},{{},{{<>,{{<!u!>},<!!!>!o!>,<<,u<'oo,!>},<!!!>ea'<>},{<!!!>!!!>!!!!}!!!>},<!!!>a,o'o<!>>}}}},{{<u""!!!>>,{<!>,<!>!>!>,<u!>>}},{<{o!!'>}},{{},{{}}}}},{{{{<>},{<!>,<!!""e!!}a!>},<>},{{},<i}i!>,'}!!!!e!!u!!'!>>}},{{{<!>},<!!!!i{!>},<!!!>!!i,'oi'"">}}},{{{{<,{u!!<a',!!!>{!>}}!>},<!a,>},{<!}!><>}},{{{<!>o'!!!>,!!<!>,<!!a""}e},!>i!>,<!!!!>},{<e!!}a!>a!i""!!!!!>u!!a'>}},{{<!!!!!>},<!>u!!>,{<!!!!o>}},{}},{{{}}}},{{{<e!>},<!!i!>!!!>!>,<ae!>,<>},{{{<u!!u{!!!>},<!>'!>},<!!!>''{!>""e!>},<!!!>{<>}},<i}>}}}},{{<""!!!'o!>o<i'e>,{<!u>}},{{{{{},{}},{<i}>}},<o<}{}aa!>},<eae,!>!<e>},{<'!>,<u!!,u!!}!!<>},{<!!!>,<!!!!!!!>!!!>e<<ao!!o'a!!{{!>,<!!>,{{}}}}},{{<o}<!!a'!u!!!>!>},<e'}!!'""u''!!!>>},{{<i!>e!!!>u""}!>,<!>eou{io!!!>,<>,{}},{{<a!!<!u!>!!!!!<!>},<!!!!<{oa""!>,<!}}"">}}},{<{<}!>""<{!>,<!!!>!>!>,<!>,<}eei{""a>}}},{{{{},{<!!!>!!!><!""!!e!>},<,,>}},<u!!!>ia<i!!!>{a{!!!>u!<ae!>},<<>},{{},{{{<!>,<!!oa>,<e!!}!!i>},<!>,io!>!}!>},<!!{!>},<>},{{<'uuu<!{{>}}}},{{},{<!>,<e!e!{!u!>},<'!>u!}>}}}},{{{{{<""!>},<o'<,!e'u},""!!!>!!,>,{}},{{<{!>},<u!""!!!!!>o""!!{!!<'>},{<!>ui""!!!!!>!!iu!>},<"">}},{<o,ae!!!!}!!ii!iuueo!!"",i!ou>,<!!""!>},<aa!!!>},<o<au<!>,<ie!>},<>}},{<!!oi!>!!,!{!>,<o!!!>oe!!!>!u!!,!!aa!!}u>,<!>!>},<!!""<!>},<u'!!!>},<!!!!!>,<>},{{{},{}},{<!!!>},<i!eea'!!!>,<>}}},{{<>}}},{{{{<a!!!!u{!!!>>}},<}!!!!!>},<}{{ua!!u{<""<""!!!>>},{{<!!!>!>,!>e!!!>,<!>!!}!!!!o!!!><'!""}!>'<>,<e!>},<!!>},<{!>},<,<,!!u!oe,""!!a!!!!!!i>},{<{,!!!>""<'i,!!!!'!!,<!>,<""o!!<!!,!i"">,{}}},{{},{{},{<eue!>!{<!!e},i!>},<>,{{<ai!!!>i>},{<!,>}}}}},{{<!>},<'u>},{<!>iu'!>},<!>!!""!>,<,o!>},<'}}oe>}}}}}}"

	set pInput=$replace(pInput,"!!","")
	set tLevel=0
	set tScore=0
	set tIgnore=0
	set tGarbage=0
	for i=1:1:$length(pInput) {
		set tChar=$e(pInput,i)
		If tIgnore {
			set tIgnore=0
		} ElseIf tChar="!" {
			set tIgnore=1
		} ElseIf tGarbage {
			If tChar=">" {
				set tGarbage=0
			}
		} ElseIf tChar="<" {
			set tGarbage=1
		} ElseIf tChar="{" {
			set tLevel=tLevel+1
		} ElseIf tChar="}" {
			set tScore=tScore+tLevel
			set tLevel=tLevel-1
		}
		//zw tChar
		//zw tIgnore
		//zw tGarbage
		//zw tLevel
		//zw tScore
		//break
	}
	
	quit tScore
}

ClassMethod Day9P2(pInput = "") As %String
{
	set:pInput="" pInput="{{{{{<!>,<!o,!!!>{>,{<<a!>u!>eio!>ui>}},{},{{<!!e!>>},{{<uo'<!!!>>},{<!>'!>},<e!>,<""ea!!!>!>,<>}}}},{{{{<""a"">,<!><<>}}}},{{{{{},{<{!!""!><ae<},!>!>!!!>}'!!>}},<!!a{!!!!!>!>,<!!!>,<{oiu<a!!,<>},{<>}}}},{{{{<eoa!!eeea{!,<>}},{{<!!!!,}!>!!a!!!}e!>},<!!!!!>!>i!e!>,<!u<!!{!!!>!!!>>}}}},{{{{{<!ea,uio!}""!>},<!>},<u<!!!!o!<,!>>,<!>},<"">},{}},{<ua""!>,<!!!>eouaa""o}!!!>!>,<>}},{<a}!>!!<'a!!<!u!!!!!>!!!>!!!a!>},<!>,<>}},{{{},{{{},<ua}!>!!!>i}}u!!!>},<!>!ii!!'!,>},{{<{>},{<i<!!!e}!>,<!""'a!!u!!{',>}}}},{<!>},<!!!!},o}!!}{!!!"">}}},{{{{},{<!>},<!!!!!>}}{'>}}},{{{{<},{a!>,<>}},{<>,<!i>}},{{{<""u!i{!i}a!!!>""'>}}}},{{{<<e!'!!i'!!}{!>,<u,""""!!i<ui!!!!!>!!<>},<!!!>'u!!ea!>u'!>}!!!!!>>},{{}},{<""i}u,,>}}}},{{{{{{<',!!,uo!,""<,{!i""{<<o<o>},<<a!>},<!!ee""'!!>},<>},{{},{<{!!!!,!>,<,"">}},{{}}},{{{{},<,}i!!,e!>,<!!!!<!!}!!{!>i{ou>},{{},{<!!!>a""!!!>!!!>a,!!i!>,<!<""e""i}!!i'e!!!>>}}},{{<{!>!>},<a<i!>,<uao>,{{<<>},<!!!e}a!>}>}},{{<""!""a,!!!>{}!!u'u{>}}},{{<oe!>},<'!><>},{<!!!>i!!!>!!!oa<!><oeo!>},<>},{<}!!!!""!a,!!'!!!>>,<!!!>!>},<!>>}},{{{<ei<""!"">,<io!!!!},!!<!!a<!{a,'ei>},{}},{<}!!!>,<!!!>!>},<!i}<i>,<a',!>{!>},<o!>!!!!!>""o!!!!!{}!o>}}},{{{<"">,{}},{{{<""}!i!!oi!!!>},<''>},{}},{{<u!>,<ea!>},<!!!>!!>}}}}}},{},{},{{{{{}},{<u}!>},<,{!!,!!{}oo!>,<!>,<>}},{{{{},<o!a}'!!!>""!iii!>,<{!>},<>},{<!u'}}!>},<!>,<!>{!>,<u}}a!!u,u>}}},{{<""!!!>!>},<!>},<'>,<{a!>},<uuo>},{},{{},{{<!!!>!,!>},<''!!!>,<!>{!!!>!!!>!!!>},<{,!!!!e}i!!,>},<!!!!!<<o!!!>'e!u!!!>e!>u!"""">}}},{{{<!>},<!!u>}},{{<<""!>!!!>e!>e!!!>!>,<a!!!!!!!!!'ia>,{}}}}},{{{<!>!!{}!>!>,<>},{{}}},{{<!!!>ai}>}},{{<!!}'!!}!>,<o!>},<{!>},<!!!>,<''!>,<!>},<!!!!,!>>,{<!>,<!a!!!>,<}<'!o>}}}},{{{{{<>,{{<!!!!'!>,<!>},<<oe!!!>i!!{i<!>}e>}}},{{<!!!!!!!>ao<!>},<!>,<!>a!!,!!!>!e!>u>}}},{{},{{<""{a!>}!>},<},},!>>}}},{{<!!!>,!!a!!a!!!>},<i>},{<!!!>}!>,<>}}},{<!!!>},<!>'!!!><,!<!!!>,!ua!!!>e!>},<a!>},<<>}},{{},{{{<{u{aie!!""!!!>a>}}}}},{{{},<a!>},<u>},{{{<!!}<>}},{{{}}}},{<!>!>},<!i<}>,<""!!!>!>},<!>i!!!>o}u{!!!><{>}}},{{{<!>},<<,!>,<!!{!>},<{<o!>},<""i!<'ei>,{}},{{},{<uu!!!!!!o!!ei!!""{e''!>!!!>>}}},{},{{{<e>},<ao>},{<ai!!!!!><}!>,<>,{{<!!!>o,a<!>,<'}>},<o!!{!!!!!!a!oe!!""!,<a>}},{}}}},{{{{{{<o!>!!!!>},{{<i""a!""!e<!>},<u"",oou!>ua!!!><>}},{{}}},{{{<>},<o!!!!!>,<!!!>,<a!!e!!!a""!,,!!!e}""e>},{<""!o!!{!i!!!oa!!!>!><,!>>,<e!>!!,u<u,i!!!!!>},<{'""!>e{i'>}}},{{<!>o!>!!!>!!a!e!<!!!>},<o!e}e!>},<ia"">,<!!}!!!>uaao!!!>e!ai!!!>>}}},{{{<""!u,!!!>},<!>,<!oo""!>,<!!!>!!!>}i!!!>!!!>'>,{<!!!!!>!!!a{o}<e<!!!>!>>}},{<!au""!!}{,o{!>},<!!>}},{<!>},<a!>,<""!>{'ia!>{'!!!>a!!{>},{{{<}e!>},<!!o}!>{!><!iio!!>}},{{{{<'!!i!!'o{,!e!!!>oi!>},<!!!>!!o>}},{{<,,i!!!>!a!,{{!>,<e!uo!>,<>}}},{{<!!!>},<<u,a>}}},{{}}}}},{{{<!!!>!>!>},<{i!!!!oe>,{<ui!>e!!<>}},{<!!>},{{{{{<""!>},<u!>},<!!<e>},{<o!>},<,!!u{o!e'}'!>,<!!{!>,<uo>,<!!!>>}}},{{{<!!!!!>'e>},<!>,<!e,o!!!!o>}},{}},{{}},{{<a<o>},{<!!,}}i!>,<!e!>},<!!""a!>,<!!{a>}}}},{{}},{{<!>},<!!!>uoi!}eu},!!o!>,<iu{o,>},{{},<,!!!!!!!>!>,<o"">},{<o>,{<!>},<!>},<!!a!><u!!!>}}!!!!!>uo>}}},{{},{<o!>},<ia!!!!!>!!u""!!u!>},<>}}},{{{<<{!!!!o!>,<!i<!!""e<!>,<!!}!>},<'a{!i>,<!>>},{{<!>,<!>},<""!>,<{{'>},{}}},{{{{{},{}},{{{{<u!>,!>!!!!!>!u<}iio""i'>}},{<}}<e!>},<o{!i'!!!>ioi""ua>}}},{<<}>}},{{{{}},{<!!>}},{{{{<{',!>},<!>},<aue""!!!>>}},{}},{{<!>},<!!!>!>!>},<>}}},{{{<!>},<'!!ao'!>,<{<!>},<<,aeu>},{<{>}},{<<!>},<!!""}'!>!'uoo!!o""{aii!>},<,a>},{{<a!>>},<!i!!<e!!!>},<,!<!>,<!!!>!!!>!>,<!i,e<'!!!>,<>}}},{{{<!!'!!!>o}i{!><!!""}"",e!>},<ii!!{>},{{<<{!>,<!!!>>},<"">}},{{<eo!!!>{!>,<,<!!!!i!!!>!>},<<'o>},{}}}},{{<!!!>o{}<!>,<<e>,{{<,}i!>},<!!!>},<!{>}}},{{<{ai!>,<'u,!!!>'!o!>,<i<!>,<}ai>},<ei!!a!!a}!i!!!>,<>},{<!!e!>},<{!!!>>,<!>},<!{!!!o""i!!{>}}},{{<!>},<!>},<',ia,>,{<!>,<ou!e!>'i!>,<iea}e!!o!>},<i!!e<>}}}}},{{{{{{{<e'!o'!!!>,<""!!!>!>},<iu>},{<<!!!><{>}},{<'!>!>},<>,{}}},{},{{{{{{<!!!!,a!>,<!!!>,<u>},{<!'!>},<!>},<!!{'aia!!}!>},<,<!!a!!<io>}},{{{},{{<!>,<!!,}!""}}!!!>i!!!>!>,<!!!>!!<{>,{<<!!!>},<!!e'<!!'>}}}}},{{<!!u}!{,'!>},<!!!><'>,<u""!>},<i>},{{<{!>,<!!!!a<!!!,>},<i!>ia!!!,,!i""}""!!<!>a{!!!>!!}"">},{{<}!>,<,>}}}}},{{{<!>,<!>},<,!<!!},e!!!>""""a'i!<eo<!!o>}}},{}},{{{{},{{<e<>}},{{{}}}},{{{<e!>>,<!!!>},<!>!!!>,<iu'uo!""!>},<o!o,i!!!><!!!!!!!!>}},{},{{},<!!!!'!>,<ia!!'!!!>!!!>!>u!>!!a>}}},{{}},{{{},{{<,>},<i>}},{{{<<'""oe!!o>},{<!>,<u!>""!""}{a>,<!!'!o<o,!>,<!>,<u}!>},<',!!!!u!o{!o,!""a>},{<!!uu'!!a,'!>{u{!!<!!}!!!!,!>,<>,{{<!>},<!!""}!!!>""!>},<!!!>!uue>}}}},{{<>,{{},{{<!!u'a!!!>!!!!<!!!>!>},<'>},{{<{,'!!!!!>aa!!,uui}!!!>!o!!,e>}}}}},{{<oe!!!!!>>}}},{{{}},{{<!e!ioe>},{<,>}}}}},{{<a!e'e,!>""'<!>,<!!""i}a!>!!>,<ee}iu!}}a<!!},}'!!o,!!>},{{{},{<e!!!>o,!!i'ui!!!!i,a!>},<}>}},<!>},<!>,<,""!>},<!>,<{!>},<,,,>}}},{{<!{eu!>,<ue>,<e!!""'{!>,<!>,<'!>,<aaao""oa{!!<u!>},<>}},{{{<!>!'!!eeu!>},<!>},<<!!}!>},<'u{!!o>,{{<!>},<!!!><!>""!!e!>},<!!u!>},<>}}}},{{{<!!'!!oa'!!!!,!!!>>},<e!!}!!{}'""!>},<!>,<}eue!!e>},{{<!!,!>!>},<o!>!!!>,<a'""!!!>{o!ie!!!>>},{}}}}},{{{{<i!>},<!>},<e!'u!>},<!>!>""!o<!>,<>},<""!!!!'>},{{<!!}ai{<,!!o!,e!!u!>},<<u!>,<>}},{{{{<>}},{}},{<""!>},<}!!!!<<!!}!>},<!>u,""e>}}},{{{<!!!!!>!!!>,<!!i{!>},<!!i{{>,<a>},{}},{{{}},{<i>}},{{{<uuua!>!e"">},{<!>,<!!!>}a<,!!!!,e!!!>>}},{<!!,!>},<!>},<!!o!>>,<!!!'!!!!!!!>}""eua!!!>!!!>i!!!>,<!!a!!!>!{!>},<!!>}}},{{{}},{}}}},{{{{{<!>,<ei!!i>},<!>a{o>},{<!!u!>,<i>}},{<i'""{>},{{{{<!{!!!!aa{''!>,!!'""!>,<!!!>,""a!""!>!>,<'>}},{{<!{!""u!>,<o!!!!!>e!!!!!>},<!>!""}!i>},<e'<'!>,<i""}{!>,<!>},<""!!!>"">}},{<!>!ui,e!!!>e>,<!>},<>},{}}},{},{{{<a>},<o""o!}!>,<'>},{},{{<<!!!!!>!!ao!!eei!>,<>},<eu""!!!>}<}!!<o>}},{{{},{{{<,i}aui!!}!!!>}!!{!!!>'!<'!>,<<!>},<{>},{<"">}},{<!>,>,{<!>,<!!a!>,<o>,<!""au{!!e!>!!}""}>}},{{<!!!>e!>},<o!!e!>e<ea!>!!,!u!!'i!!!',>},<!!!>},'i!>},<,!>!'!>!!""o,}!!!!!>>}},{{<!!{,oai},!!<!!!>'aaa>}}},{{<}!o!>},<>}},{{{<,""}a<o{!>i>},{{<""!!e!!,!!e!>u!!!>!!!>,ue!!o,!>ei>},{{<>},<!!!>},<a'o!!!>,<'{!!!>io<!e}!><!'>}}},{{{<>},{{},{{<!i}uee""e!!!>!!!!!,!!,!!!!!>u{!!""<>,{<'eauu!!,i!!!<a<ea>}}},{}},{{{<!>},<eeiuo!!}<""!>},<ii,<>},<o>}}},{},{<""!>{>}},{{{<<!!!{!>au!!!!!>u!>},<,!>a>}}}}}},{{{},{}},{{<!!e!>!!,!>e""!>},<<e{!>},<'!aeaoi>},<{o!!!!}ue!'<'!!!>!>!'a<!}!!u!i>}},{{{{<'<o!!}>}}},{<!>,<!>!>},<!u!>,e!>,<""!<eu'!>,<,!>i>,{<>}}}},{{{{{{},<!!!>!>},<!<o!!!>i!>!!!>,'>},{<!!!>u!ua!i>}}},{{{{<i!>},<!!<e<!!!><!""!>,<,!!>}},{{{{<!!!>o!!,}!,>}}},<!>!!""}!>i!>!!u!>,<!!!>!!o!>},<i"">}},{{{{{<!!u!>,<"">},{{}}}},{{{<!!',>},{<""',o!>},<e!!!!ee!!oi{i,>}},{{<'>}}}},{{<>,<'!>o!>},<!!,}<!>,<{{!!!!!>i!>""'!!u>},{<""!>,<<!>!u!!'u!!!>,!!aa!>},<!>!!uo""{>,{<!>},<ei!!!>},<,uu!!!!!!,!>io{!!!!>}}}}},{{{},{}},{{<!!!>,<!!!>!!,!!!>eo}u!!!!!>>,<i{!!!!!>!oi,!!e!!!>,<<!!!>!!!>,<,!>,<'!>>},{{{},<!>},<{ao!""""!>'!>,<oaei>}},{<!!!>},<!,!>,<o>,{{<!>},<oiui}""!>,<""""u!!!>}!>!!,ii!!>}}}}},{{<e!>},<o!!!>,<"",>,{<!!!>iuoa!!!>!>,<e!!!>!!,}a'!<a}!!!!,>}},{{},<!!!>!>,<!>},<!!!,'i}>},{{{},{{}}},{{{<>}}}}}},{{{{{<{!>},<}u!!!!!>!'!!!>!>},<}!!!>!>},<!>},<e,!!!>,!>,<>},<!>ea!!!!a<!!o!!i>}},{{{},{}}},{{},{<!{!>,<>,<<>}},{{{{{{<!>,<!!{!!!!}!!o!!!>}!eu!!!!!>,a""!!a!>ei<>,<!>,<!>},<""!""a>},{{{<!>}!!!>,<}a!i>,{<!>,!>},<i!!!>!!'>}}},{{<<oi!}e<""u!!""}!!!><'!!!>>},{<!!>}},{{<!!!>}'!>},<u!<!>,<{!>,<<>},<u!,!!!>iooi!>e,{<""<io}!>,<>}},{{<!>},<!>},<!>},<o!>ua!!!!<uoi!!!>!>au{,>},<!!!>""e!>uu!>,<}>}},{{{},{{}}},{<ioe{!>,<oe{!!""!!!>!!"">}},{{{<ei""!!!>!!!!!!!>,<!!,!!!!oo!!!!e!>,<'!>},<>},{<u'!!!a!!!>},<!>},<!!!<>,<,a,iu>}}}},{{{<<<a!><<!!!!!i""i!!!>,<!!!>{!>},<i!>},<},<>,<!>u{!!""!>!!},!!!!!!ii!>{!!e{aa!>},<>}},{{<>},<<!!!><!>,<i!>},<a,!,!>!>ii<!""o>}}},{{<!!'}}<e}>,{<!!!>o{!>},<!io!!{{au!!o!i''uo,!>},<>}}},{<!>,<!!>}},{{{{},{<e!>!>},<}>,<>}}},{<!ou""!!!!!>a!u!>,<!>},<<}}!!!>,<'<aa>},{<""o!ii""!>,<""}!><!>!!{!>o,!!u!!!!!>},<a{>,<<!!i>}}}},{{{<<""}'e<!>,<}!!!!!>},<,!>,<>},<{!>!>e!!!>!!ei{!>},<{{eoao""i>},{{<{!""{!!!{!!!!!>'!eoee>},<o!!>},{<a!,!!!'u>,{<!>,<!>},<i!""o,i!!!>},<>}}},{{{<ea}a!>!!!>!>!>},<!!!!!>,<e!>},<>,<"",''uooa!!'uo>},{{<!!a>},{<u<!!}!!eu!!<!"">}}},{{<!>,<u!>!>,<}!a!!!!e<uu!>oa!!!>},<e>},<<!!!>'u}!'""""!!!>},<!!iu>}},{{{<!e'"">}},{<<'}!>!!!!!>}!!!>!!!!!>i{!>,<!>ie>}}}},{}},{},{{{{<u!>!!!!!><a>,<,<'>},{{}},{<ii""!!<i<!""u!>""!},e{,<>}},{<!>!!}!>,<""a{a,i!,{!!>,<!!i'!}a!!!>},<<!!{!!!!!>},<!!}""o>},{{{{<ou!>,<a>},{<'a,u<!!<iu}i!>!,>}},{{<,!!'!>},<e>,<!>,<!>},<a!>},<,!>aou<!!!!!>!!'!!!>'{!!!ea!>,<>}},{}},{{<!!!>!!>}},{{{{{<ouu!!!i!>},<!!e!!,!!{u}'e>},{<eeea}a>,<!{e!>!!,}a!!!>>}},{<,>}}},{<a!,u'>,{<}{'!>},<u!!',,eu!uo!!!>>}},{<!!u'>,{<"",!!!!!!!>!>,<a}e}'{>}}}}},{{{{<!'!>},<!!i!!!o,u!>!!!!!!!>!!'io<!!<!>},<>,<""!!!!!!!a{!>,<>},{}},{{},<!!o!>},<!!!!!>!,!!!>,<}!u,!o!!!>!!!>>}},{{<!>,<a{'{e!,i!>},<!>,<!>,<>,<<',}!,'<!!!''!>},<!>,<,>}}},{{<!<""""e!u!""!>},<i!!!>o!!!>""!!,,!!i>,{{{<""e!!!>,<o!>},<!>a!!!a!>,<,""""!>},<>,{{<},!!!>!!<i!>,<""iu>,{<u,!>u>}},{<i!>},<!!!!!>u!>}'!>},<!!!>>}}},<e!!!>i!!i!!!>!!!!""o!!!!!!!>}ee<}!>>},{<a!>!!'>}}},{{{<!>,<!!!>'!>!>,<!>},<'!>},<!!u!>!>,<!>,<>},{}},{{{},{<',!!!>!>},<!!{<!!!!!>!!!>o!>},<a>}},{<uie!!!>>},{<{""o}u},!!!>""!!>,<!!!>!>,<!,i!!!>,<!!{""!!!>o!!!>!!u!!!!!>!!!!!>>}},{{{<'o!<!!e}!!e!>,<!}!!u!>},<!>},<ao!!""!>},<!!}!>,<>},{{},<!!,!>!>}ua!!!!>}}}},{<'!>!""!,!>,<!>},<!!!><eoiuu!!<!!!>!e!!!>>}},{{{<i!e<,!!!>!>},<,>},<<o!>,<<>},{{<>},{<!!!>iu!!!>!>!!!!!>!<!!!>a!!!>!!a!u!>>}},{<>,{{<a!>!>},<!>,<!!!>{!!i!u"">}}}}}},{{{{{<!>},<}!!!>},<{!!}eu!>},<}i<oo!o>,<{!!ae!a'!>},<!!>},{{<>},<!>},<!>},<{!!!!!!!>,<!>{!}}"">},{<{!a!>},<!!!>eu!!{'!>},<!!!i!o!!!ae}!!,>,{{<}!!!>!!<!!<<!!!>{oi{!>},<!!o<'o{>},<!>!>,<!,ea}""!!<!>},<u!}""o!><i>}}},{{<!!!>}e!!!>>}}},{{{{{<!>>}},{{<""i>}}}},{{<a>},{<u{!!!!!>!<a!!{!!}i!!{!!!>!!{{!>,<u}u>}},{{{},<!>aoa!!{!>!!e!!!>!!!>}<'!!},!!e}>}}}}},{{{{{{{{<!!!>""}>,{<a}a""!!!>,o<!!!>!>},<>}}},{{{<!!!>!!e!>!!!>>}},<!>},<a!>,<<!>,<i>},{{<!>},<""{!!!!eo!!!!!>,<"",e!><u>},{<oue!>,<""!>,<>}}},{{{}},{{<!>,<e>,{<ui!!!>u!>},<!!ee{""<!!!>!!uiu!>},<,<!>},<>}},<!!{!!,""!!!>!!!!!!!>,<!!!>},<}>},{{{}},{{<>},<!>},<!!!>!>},<{<!>,<!!>}}},{{{<>},<!!}!>""<!>>},{{{{<!>,<!!uu!>e!>e}""!!ei!!!>>}}}},{<'o>,{}}},{{<,!>,<""!!a!>e!}!!!!i!>>},{{{{<>}},{{{<>}}},{<!>!{!!{>,{}}},{{<!>},<u!>oe!>ao>}}},{{}}}},{{{},{{{<!>o,,>}},{{<u!!!>{!!'!>!<''o""{>,<!o!!!!u!!!>'""e!!'<a!!!><}!!""}!>,<>},{<,}!!<a}!""{!>,<e!!!!!>!>!>!!!>}!!!>!>,<oo>}}}},{{{{<}e}!!e!!!!!>{o!!!>!>o>}},{<!'e!!!>!!!>eo!>},<>}},{{{<!,!!{!!a>},{<!!""!!}!!ei!>,<!!u!!!!!>!!au!!!>,<u>}}}},{{{<!>},<!i!!!>,<!!>},<!a{!>,<!!a!!a,!>},<!>""'{i""!>,<!!!>!!>},{{{{<i!>""!!!!'!!>,{<a!!',!!!>>}},{}},{{{<',u!>},<!!<!>!>ueuo!}!!!!e>}},{}}}},{{<,!>},<!>'>}}},{{{<!!!,!!!>i""!ae!>,<!!!>},<e>}},{<,{i{!>},<ai!!}>}}},{{{},<!>,<!>},<<o!,o,<}>},{<a,<}!>!!e>,<}!>,<!>},<!>},<!!o!!!!!>,{""ai""u>}}}},{{{{},{{<!>,<{oi!iu{!!!>!!!>ea>},<e!>!><o!!u!!!!!>!>},<ee,""o{,'>}},{{{<u!!}!!'},!{!!!>!!!>}!>,<u!!!>o!!!!!ia,>}},{{<!>a!""!!{!!!>>,{{{{<o!>!!e'<u!i!>a,e!>,<>},<!!}>},{<{a!>,<{,u!!!>i!!!>!>,<>}},{<!>},<!!!!!>{u>}}},{{<!!<!!!>o!>!!}!>},<""o!!eiia}>,<>}}}},{{<!!!>i!>},<!>!>!""<<!>a<!>o!!!>!!{!!!>!>,<>},{<!!!!!!!>e{e,a'!>},<}""!!!>,<!>,<,}>}}},{{{{{{},{{}},{{},<!!!!eo!'!>,<>}},{{<!!,oaa!a!!!!<'u,!!!>},<{!!i!!uea!>},<!>},<>},{{{<""!>,<!a'!>,<e!>a,""a>},{{{},<>},<!>!!!!>}},{{{}}},{{{<<e,'!!e!!<'a!>},<!>uo{o,!!!>!!<!!'>}},{<iu{u""i'>,{<!!,!>,<i''{}!'eo>}},{{{},{<!!!!a}>}}}}},{{<!>!!!>!!!>'!>!!!>!!!>'!>},<!!!>,<!!!>>}}},{{<!>},<a<'!>,<!i'o'!>},<""!!i!>,<}!>},<}!!,!>!>},<>,<!>,<'u!>,<aa!>,<a!!!>a!>},<i""!!!><,>},{{<!>},<!>,o!!!>!>},<!>},<ei>},{}}}},{{{{{<!>"",!!!""iio!!<{'}}!>,<>}},{{<u!>!!{''!""!!!!!>,,>},{<!!!>uuoa'!""""!>,<!!eaa!!<!a!!!>>}},{<!a<!>,<>}},{{},{<<""!<!>},<eu!e<!>},<>}},{<""!!!>}ii<!>,<>}},{{{{<>}}},{{<!'uo{!!io!>},<i!""!!!<<',,!!!>iu!!!>>}}},{<i<<ao!!}!>!<!>},<e!!i,!>i!!!!{!"">,{<,!<!!{,!>'!!!>a!>},<u!!!>'<!>,<!!!,u!>!!e>}}},{{{{{<e{!>o"",>}}},{<!>},<a<!>},<!>,<,>,{}},{}},{{{<o>,<<!>},<!>,<!!!o!!,!,}u!!{>},{<{!>},<!!!>""'>,<!!!>,uu!!eu<!>ueii>},{{<!""e'!!u!>},<u!!!!!>{e<a<>},{{},{<>}},{{<!>',!!}""i!!!!e!>!>,<,>},{<!!!!!!,>}}}}},{{{{<!>!}!!!!ui>,{}},{{<a!!!>!>!>!!!>iea""!""!!!>!u>}}},{},{<<!!!>,<!!!"",""!!!>!!}!>,<o,}a!!!!!>!>io>,{}}},{<u>,<!!!>!!!!!>{!>},<<""e!!eu!!!""!!eu>},{{<i!>!>},<{ii!>!!!>a!!!!i<<!>},<!>,<!!!>!>>},{<!!e!>,<!!!><a'!!!>{''ie!'>}}}},{{{<!!<!>!!}}!!!!i""i!!o}!>>},{<!>},<a""!!!>i'i!!!>},<<{u>}}}},{{{<!!!>""!!e!>}u>}}},{{{{},{}},<!!,>}},{{}}},{{},{}},{{{{<o!a!!!>!>!!,>},{{<<<!<oa>},{<o}!!!>!>},<!>},<>}}}},{{{<!>i>}},{<ea>,<!{<""""<!!!>!!!>{a!i<u!>},<i!!!'!}',e>},{{<o,!!>},{{<o>}}}}}},{{<>},{<e!!!>!>},<<!!!>>,<!>},<""!<!>'{""!!!>!'<e!>o!!}!>,<>},{<""!>},<!!!>!o{a>,{}}}},{{{<u!i}'i'!!!>i!>'a>}},{{<!>,<a}}""""a,>,{<a!>,<o!!""iu!>,<'""""i!!!>!>!!}e{i>,<!>},<!>!!""!!!>""}<{!>},<}!oe!!!>'i>}}}}},{{{{{{{},{<uu!!!<,}e!!!>>}},{{{{{<a!>},<o}a!!!>>}},<'<'!>a!!o{a}!!!>"">},{{<}!>,<""!!!o{>},{<!>},<""ao!>,<!!""a!o!!!>!!!>!o!!!>a!!e,>}}},{{<>}},{<,e{>,{}}}},{{{<!!!}'u!>!e!>,<<<>},<'}o}!"">},{{<'<o!!!>a!>,<!!,""!>>},<!!!>},<!>!>},<<ue!!!!u!!!!!!ua!>},<!a>},{{{{{<!!{!>},<'!>!!!>,<!>!!!>,<!!'u!!i<o>,{<!!o!!,euua'!>,<'!>,<!!!>},<}>}},{<{!!!>!""!!{!>ao!>!>},<!!i>,{<!><""!>,<!!!>},<<o!""!!<aa!!!'}u>}},{{<!>,<{,>},{<u!,!u!>},<!!""{>}}},{{<}!!!>},<e!!!!{,!!e!!!>},<!>,<,!!',>}},{{<'i!>},<!!<ua!>},<!>,<!!!!!!!>,<''o<!!!!!>!!!e>,{{{},{{<>}}},<"",>}},{{<ie!>!>,<eu<,!!!>,<!{!!!>},<!>},<{u!!i!>,<>,<!!ai!>,<o!!!>}!!u!u{!!!>ai!>,<""'e!>},<>}},{<oe!>},<!!!>!,!!!>uau<e!!>,{<!>,<<{>}}}}},{}}},{{{<e<!>},<!o'u>}},{<o""a""""!>},<ae!!}!,!>,<>,<}<,}!u!>,<!!{!>""o,i{!!}>}},{{{<u!!!!!>,a!!!!!a<{e!!i!!<eu!>,<a>,{<!!!>>}},<>},{{<!>},<!><!!!>,<i!!}a!!<!!e{{!>},<e!!!>>},{}}}},{{{{{{<a!>},<o'!!''e""!!<!!!>!o>}},{{}}},{{}}},{},{{{<""<o>}}}},{<!>},<!>},<}}!>},<u!>},<o>,<!!!!!'i!!',}ea!<!>a!>!!>},{{<!>,<}u!>,<o!u!>,<o!>},<a!>,<!!!>,!!!><!>,<!>},<>}}},{{{<{!!ai!!<{o!!!!!!>},{{},<!>!!u{<e<!'!!!>,<e!>,<,{""e!>},<"">},{<!><i>,{}}},{{<,!>},<""e!!a<!!a!>},<!>},<""""!!!!>,{{<'u<<!>o!>,<'>},<'{i'!!""!>,<!o!!!>ue}<}a!!!!>}}}}},{},{{{{{{<e!!}i!>},<oi!>},<""!>,<!!!>eua>},<{!!!>}>}}}},{{{<!>,<,,u!!!>ue<!!!!}!>,<{{>},{}},{{}}},{{{{<'!!!!o{!>},<,'!>,<,""oe!>},<u!>},<!!o!!}!!i>}}},{{<{!>,<e<e!{'<!>,<!,o!!{!!{>,{{},{}}},{{<a,<o<!!!>!>,<!{!!!!!>!>},<<ui!!!>{{!>,<!!'>,{<!!!>ia""!!}!>,<!{>}}}},{{{},<!!ee,!!!u!!!>},<!>{!>,<a!!}!>!>!i!>},<}!>,<!!'>},{<!'>,{}},{{<!>},<!>!""""{ei!!}e!>,<!>,<!!!!""u!'!!!a!>,<!>},<<>},<'!>,<!e<'<oe!!!>a!"">}}},{{<u!!!>,!>,<!!ea>,{<""!!""e{,!>e!!!!uei!!!>!!!>!!!!!>!>,<a!!eo>}},{{{{},{{<ie!>},<!>},<oeu}!!!>i'!u!>},<>},{<,!>!>ea!<!>},<e!!{!,!>e>}}},{{{<>}},{{<!'o!>u!!e!>},<a!!!>!!u!!!>},<,!>,<,i!!!>,<!>a>}}},{{<!>},<<a<e'>}}},{}},{<u!!!>u!!!>},<!>,<!!!!!!<u!>,<!!!,!!""!!!!!>!>},<!!!>>,<{e!>{{!!!>!>i!>u!""<!!o!!!>""!>,<'u<>}}},{{{{},{}},{{{<!>,<o!!{!!!>u!!!>!>,<>,{}},{<!>!>},<a'}ou!!'!>},<!!io>}},{{<!!!><i!!!>'>},{<'!!e<{""!!}{o>}}},{{{{<!>}!>!!!}'!!}!>!>},<e,!!}!!e!o!!!!!>!ea>}},{{<u!>,<<!!!>!!!>i<>},<!!o""u{>},{<!!'>,{}}},{{{<<u!!!>!!}!!!!!>,<a!!u""!>},<!aae!e>},<'!!!>!!!>,<""oa""!>},<!!,<!!!>io}!>!!>},{{{{<!>i<!!u""!!ie!>,<,!>!!'a!>},<u!>>},{<u<ea}!>},<!,e<{e!!!>>}},{{<i!>,<!!!>,<!!!>!!!>,<!>},<'!>,<a!!!>!>,<}!>,<<>}},{{{<ou!!{!!""""{!!!>!!<!!,""eu<!''!!ei!>},<>},{<!!!>>}},{<i!!!!!><<!>,<!,!!e!>!>},<>}}},{},{{},<{!!!>iao!>e,""o!!!>!!!!!!u!>,<o!""!<,>}},{{<!!}!>,<iei!!o>,<!>,<!!!>o!!{,i!!!>!!!!a!!!>},<,!!""o>},{{{}},{<""!!!!!!'u"",!>uui!ai!!'>},{{<!,i!>,{"">},{<<>}}}}},{{{},<>},{{{<}'!>,<iu',<>,{{{<'!>},<!!,!>!!!>!!<""{!!!!""a!o<!a"">},<a{<!!>},<>}},{{<o}""'o!>},<!!{!!!>{>},{<ua!aeu!>},<}!!!>i{u!!!!!>!>!!>}}},{}}},{{{{<ee<!!!>!<!!o>}}},{{{<ie<!>,<!!i!!i}a<'i""{{'e!i>,<,!!""!>},<!!!>!>},<,!>,<,{!!!>o""<}!!<""!'>}}},{{}}}}},{{<""!u>}},{{{{<i!>!!!>!!!>!!!>>},{{<}<<!>},<!!!>!""a!!o>},{}}},{{{{<!!!>>}},<ea!>,<{u!<{!>,<""}!!!!!!!>""i!!"">},<!!!>,<>},{<!>,<a!>,<!>,<a{>,{<!>,<!o!>!!{!>},<!!!>!!u,,!',!>,<e'>}}},{{{{<>}},{{{<!!!>},<}!!!!!!!!o!><}!!!!!>,<,,!!oi!>,<!!e>}}}}},{{{<<!<!!,!>!!!>,<>},<!<i!!e!!!o!>},<a!!!!!>aoi!>,<>},{<!><>,{<!>,<ia!!{!!!!!!}!>},<oi!>!>a}}ua!>},<>}}}}},{{{{{<uu!!!!!!!>}{!!!!!>i{!>},<e!>,<a>},{<!!'<!>},<!>},<>,{}}},{<ei{}e}!!u!!!>,<}!!!><!>u,}>},{{<,!>,<<!!iiou<!>},<{>},<u!!!!!>{}!>!!!>a!>,<>}}},{{{{{{},{<!>},<""!!}io!!i}{iu!>>}},{{{{{<ee!>,<a!!!>{,""!!!!e!!uio!!!>{!!!!>},<!>{!>oe!!!e!>},<i'e!'!!i!!'u""!>,<}!i!>>},<{""{ue''{i>},{{<o>},{<!><o!>},<}!>i!>},<!!!u!>,<}!>!>},<oaoi>}}},<!!i>},{{<oa!>},<!!!>}{!>},<i!!a,}!>},<}!!!>""o!!!>>,<<!>},<!>},<!!!>'!>e}!>,<>},{{},<i!!"">}}},{{}},{{<a!!""<a>},{{<!>},<<!!!>e!><ua<,!>},<}!>},<!!!>!>,<'}>}},{<!>},<!>!,{a{!!""!!!>!!'!o<e!!!!ee""!!}<>}}}},{{{<i{,""ai!>!>},<u'i!!>,<!!!!""!!!!}o!!!>!oue}""!!!>},<{!>{!!{>}},{<!>,<{!!!>},<!!!>!>,<!!!>},<,<}!>'!a>,{<!>},<u!!a{!!!>!>},<a!'!!a!!io!>},<!>,<<>}},{{<!}e<o!>!}>}}},{{{}},{{{{}},<{'""""a!>o!!!>'!>'!>},<>}}},{{{<!!!!!>!{>}},{{{<ia!>}i<!>,<a!!}>},<!!!>u!>>}},{{<>}}}},{{},{{{},<a!>,<!>!!!>},<!!'!euu,o{!!!>!><'>},{<!ua!,oe'e!ie!>,<!!!>!>},<!!'!!!>a!>},<!e>,<!>,<!!'!>,<""}!!'ou'>}},{{<uo!!o!!""!>,<,>,{}},<u""}!!au!!!!!>o!>},<}!>,<a,}>}},{{{{},{<!>,o'u!!!>},<""i{a!>,<o>}}},{{{<,i!o}u!!!>!!!!!>}>},<{u!!'!!{e<o>}},{{<}!>,<!!!!"">}}}}},{{{{<<a!>,<!!!>"">},<""{""!!<!{a<<!!o!>,<""o!>,<ii!!o!>},<ae>},{{<a""!>!>ui,e!e!!!><{o<"">,{}}}},{{{{<i!!!>!>i<<!!!><!>!!!!!>,<ui}>}},{{},{{{<!!!>!!!!!>>}},{<e!!""!!{""<!!!>!!a!!ai!""{ou!><!!!!>}},{<{!!!>!>},<!!!!!!!!e!>u,u!!>}},{{{},{}},{{<>,{<<!!!>!!!i!>u!!!>,<>,{<!!!>a!>,<,{!!{e!!!!!>i!!!>,<!!!>,<'!'>}}}}}},{{{<<<o!>},<""iu!!ai>},{{{{<{,>}}}}},{{{{{{{<e!!a!!!>,<!u'io!!!>e!!}!!""!',!>,!>>},{<'!o'o}!>,<>}},<!!!>}!u!>,<o!!'!!u!uau,!!!>},<o!!"">},{}},{<!>,<u!>""a!>},<!e<'e<""o!>,<!""i{u>}},{{<ao!!!!u!!!>>}}},{<,u>,<e""!><!!!>'o,'o>},{{{{},{<""!>},<aa<>}},{<,u!!!!!>,<!!!>oi!uo!e!!e!>!>!!}>,<!{oea!!!!!!!>!!!>!>,<!!!>!>},<>}}}}},{{},{{<>},<!!!!!',!!"",iua{'!!!>},<!u!!!!o!o>}},{{{{{{{<{!!!>!>,<!!ao""!>,<!!!>'!>},<!'oe!!}}!>,<u>},{}},<i!!,""!>>},<>},{{<!<ua!!!>,<!'""!>o>},{<eo!!<!!!'<!!!>}a>,{<'a''ui'!a!!}}'>}}},{{<o!>,<!>>}}},{{{{<e''<!>,<!>},<!{,,>},{{<e,o{e}o,o,e,!!!!>}}}}}},{{<!!i{!!!!oa>},<au!>},<!>!>!!!>,<!>e!>,<!!!>},<o!>},<!!o>},{{<""!>},<!!a!!}<'!!o!!""!!{<{{<!!!>i>,<!!au}o!!'}o}}ou>},{<!!ei!!!>e<!>e!!!>,<a,!!oi>},{{{<!'!>!!!!!!i!!}!'!!!>},<!!!>,<!!!>i{}!!!>,<!!{!>},<a>},{{{<!!!>,!}!>i<>},{<""i,!>,<o""!!!>>}}}},{<}{o>}}}}},{},{{<}o!},}!>,<}u>,<<}<,<!!u!>,<iii>},{{},{{<o!>},<!!!>'e{!>},<"">},{<!>a!!!>{'!!{'u,>}}}}},{{{{<!!!>!>},<o!>'ii!!!!aa!!,a!>},<'!oio!!!>>},{}},{{},{}}},{{{{<""io,""'!>,<o}>},{{<!>!!,!!!>},<""!!i}!!!>,<'<i!>>},<!>},<>}},{<!!!>!,!!!>'!>},<''!>},<o{'!>""<>,<!!!ea""!!ioi!!'""}'{>}}}},{{{{},{<!!,io!>!>},<!>,!!!>!i!>,<u!!!!!}a!""!!!>,<>}},{}},{{{},{{<i!>},<oeu!>},<}!!!!""!!!>!!<!""!>},<""'!>},<>}}},{<!!u'!>},<!!ui!!!>}>,{{{},<!>!>},<>}}},{{{<!!!>'o!!!i,e}!!!!!>a,!!'>}}}}}},{{{},{{{<!!!'i!!!!!><!>!!!>e>},{<!>!!!!u>}},{{}}},{{{{<'!>'i'!>},<!""'a!!o!!!>!>,<}!>,<<!>,<!!!!!ue>}},<!>o!!!>,<a!!u""'!!""ao!,o'!!!>!,<!""'>},{},{{<!!!>},<o!},'o!!!>!!!>>}}}},{{},{{<>,{{<!u!>},<!!!>!o!>,<<,u<'oo,!>},<!!!>ea'<>},{<!!!>!!!>!!!!}!!!>},<!!!>a,o'o<!>>}}}},{{<u""!!!>>,{<!>,<!>!>!>,<u!>>}},{<{o!!'>}},{{},{{}}}}},{{{{<>},{<!>,<!!""e!!}a!>},<>},{{},<i}i!>,'}!!!!e!!u!!'!>>}},{{{<!>},<!!!!i{!>},<!!!>!!i,'oi'"">}}},{{{{<,{u!!<a',!!!>{!>}}!>},<!a,>},{<!}!><>}},{{{<!>o'!!!>,!!<!>,<!!a""}e},!>i!>,<!!!!>},{<e!!}a!>a!i""!!!!!>u!!a'>}},{{<!!!!!>},<!>u!!>,{<!!!!o>}},{}},{{{}}}},{{{<e!>},<!!i!>!!!>!>,<ae!>,<>},{{{<u!!u{!!!>},<!>'!>},<!!!>''{!>""e!>},<!!!>{<>}},<i}>}}}},{{<""!!!'o!>o<i'e>,{<!u>}},{{{{{},{}},{<i}>}},<o<}{}aa!>},<eae,!>!<e>},{<'!>,<u!!,u!!}!!<>},{<!!!>,<!!!!!!!>!!!>e<<ao!!o'a!!{{!>,<!!>,{{}}}}},{{<o}<!!a'!u!!!>!>},<e'}!!'""u''!!!>>},{{<i!>e!!!>u""}!>,<!>eou{io!!!>,<>,{}},{{<a!!<!u!>!!!!!<!>},<!!!!<{oa""!>,<!}}"">}}},{<{<}!>""<{!>,<!!!>!>!>,<!>,<}eei{""a>}}},{{{{},{<!!!>!!!><!""!!e!>},<,,>}},<u!!!>ia<i!!!>{a{!!!>u!<ae!>},<<>},{{},{{{<!>,<!!oa>,<e!!}!!i>},<!>,io!>!}!>},<!!{!>},<>},{{<'uuu<!{{>}}}},{{},{<!>,<e!e!{!u!>},<'!>u!}>}}}},{{{{{<""!>},<o'<,!e'u},""!!!>!!,>,{}},{{<{!>},<u!""!!!!!>o""!!{!!<'>},{<!>ui""!!!!!>!!iu!>},<"">}},{<o,ae!!!!}!!ii!iuueo!!"",i!ou>,<!!""!>},<aa!!!>},<o<au<!>,<ie!>},<>}},{<!!oi!>!!,!{!>,<o!!!>oe!!!>!u!!,!!aa!!}u>,<!>!>},<!!""<!>},<u'!!!>},<!!!!!>,<>},{{{},{}},{<!!!>},<i!eea'!!!>,<>}}},{{<>}}},{{{{<a!!!!u{!!!>>}},<}!!!!!>},<}{{ua!!u{<""<""!!!>>},{{<!!!>!>,!>e!!!>,<!>!!}!!!!o!!!><'!""}!>'<>,<e!>},<!!>},<{!>},<,<,!!u!oe,""!!a!!!!!!i>},{<{,!!!>""<'i,!!!!'!!,<!>,<""o!!<!!,!i"">,{}}},{{},{{},{<eue!>!{<!!e},i!>},<>,{{<ai!!!>i>},{<!,>}}}}},{{<!>},<'u>},{<!>iu'!>},<!>!!""!>,<,o!>},<'}}oe>}}}}}}"

	set pInput=$replace(pInput,"!!","")
	set tLevel=0
	set tScore=0
	set tCount=0
	set tIgnore=0
	set tGarbage=0
	for i=1:1:$length(pInput) {
		set tChar=$e(pInput,i)
		If tIgnore {
			set tIgnore=0
		} ElseIf tChar="!" {
			set tIgnore=1
		} ElseIf tGarbage {
			If tChar=">" {
				set tGarbage=0
			} Else {
				set tCount=tCount+1
			}
		} ElseIf tChar="<" {
			set tGarbage=1
		} ElseIf tChar="{" {
			set tLevel=tLevel+1
		} ElseIf tChar="}" {
			set tScore=tScore+tLevel
			set tLevel=tLevel-1
		}
		//zw tChar
		//zw tIgnore
		//zw tGarbage
		//zw tLevel
		//zw tScore
		//break
	}
	
	quit tCount
}

ClassMethod Day10P1(pInput = "") As %String
{
	set:pInput="" pInput="120,93,0,90,5,80,129,74,1,165,204,255,254,2,50,113"
	set tList=""
	for i=1:1:256 {
		set tList=tList_$lb(i)
	}
	zw tList
	
	set tSkip=0
	set tCurrent=1
	for i=1:1:$length(pInput,",") {
		zw tCurrent
		k tTemp
		set tLength=$piece(pInput,",",i)
		for j=1:1:tLength {
			set tPos=j+tCurrent-1
			while tPos>$listlength(tList) {
				set tPos=tPos-$listlength(tList)
			}
			zw tPos
			set $list(tTemp,tLength-j+1)=$lg(tList,tPos)
		}
		zw tTemp
		for j=1:1:tLength {
			set tPos=j+tCurrent-1
			while tPos>$listlength(tList) {
				set tPos=tPos-$listlength(tList)
			}
			set $list(tList,tPos)=$lg(tTemp,j)
		}
		
		set tCurrent=tCurrent+tLength+tSkip
		if tCurrent>$listlength(tList) {
			set tCurrent=tCurrent-$listlength(tList)
		}
		set tSkip=tSkip+1
		zw tList
		//break
	}
	
	quit ($lg(tList,1)-1)*($lg(tList,2)-1)
}

ClassMethod Day10P2(pInput = "") As %String
{
	set:pInput="" pInput="120,93,0,90,5,80,129,74,1,165,204,255,254,2,50,113"
	
	set tInput=""
	for i=1:1:$length(pInput) {
		set tInput=tInput_$lb($ascii($e(pInput,i)))
	}
	set pInput=$lts(tInput)_",17,31,73,47,23"
	set tList=""
	for i=1:1:256 {
		set tList=tList_$lb(i)
	}
	
	set tSkip=0
	set tCurrent=1
	for n=1:1:64 {
		for i=1:1:$length(pInput,",") {
			k tTemp
			set tLength=$piece(pInput,",",i)
			for j=1:1:tLength {
				set tPos=j+tCurrent-1
				while tPos>$listlength(tList) {
					set tPos=tPos-$listlength(tList)
				}
				set $list(tTemp,tLength-j+1)=$lg(tList,tPos)
			}
			for j=1:1:tLength {
				set tPos=j+tCurrent-1
				while tPos>$listlength(tList) {
					set tPos=tPos-$listlength(tList)
				}
				set $list(tList,tPos)=$lg(tTemp,j)
			}
			
			set tCurrent=tCurrent+tLength+tSkip
			if tCurrent>$listlength(tList) {
				set tCurrent=tCurrent-$listlength(tList)
			}
			set tSkip=tSkip+1
			set:tSkip=256 tSkip=0
		}
	}
	
	// Calculate Dense Hash
	for i=1:1:16 {
		set tTemp=""
		for j=1:1:16 {
			set tBitString=$factor(($lg(tList,((i-1)*16)+j)-1))
			set tTemp=$bitlogic(tTemp^tBitString)
		}
		set $list(tNewList,i)=tTemp
	}
	
	set tRes=""
	for i=1:1:16 {
		set tVal=0
		for j=1:1:16 {
			if $bit($list(tNewList,i),j) {
				set tVal=tVal+(2**(j-1))
			}
		}
		set tRes=tRes_$replace($justify($zhex(tVal),2)," ",0)
	}
	
	quit $zconvert(tRes,"L")
}

ClassMethod Day11P1(pInput = "") As %String
{
	set:pInput="" pInput="sw,s,se,se,se,se,se,nw,ne,ne,ne,ne,ne,n,n,ne,n,n,n,n,n,sw,sw,n,ne,nw,n,n,nw,nw,n,nw,nw,nw,nw,nw,nw,nw,ne,sw,s,nw,sw,se,nw,sw,sw,nw,nw,nw,sw,sw,s,nw,nw,sw,sw,sw,sw,n,sw,sw,sw,sw,sw,sw,sw,sw,s,s,sw,sw,s,sw,s,sw,sw,sw,sw,ne,s,s,ne,sw,s,sw,s,s,n,ne,sw,s,sw,s,s,s,s,s,s,s,s,s,s,s,s,sw,s,s,n,s,s,s,se,se,s,s,sw,s,se,se,se,s,n,s,s,se,s,se,se,se,se,ne,s,n,sw,se,se,se,se,se,s,se,nw,nw,se,se,se,se,se,se,se,n,ne,se,s,se,se,se,ne,se,nw,se,se,s,ne,se,n,se,se,ne,sw,se,ne,se,se,se,nw,nw,ne,se,se,s,n,n,se,se,ne,se,ne,se,se,ne,se,se,ne,ne,ne,ne,ne,se,ne,se,nw,se,se,s,s,se,ne,ne,se,ne,ne,ne,ne,ne,ne,nw,ne,ne,ne,s,ne,n,ne,se,ne,n,ne,nw,n,ne,n,ne,ne,ne,ne,ne,n,nw,ne,ne,ne,ne,s,ne,ne,s,ne,ne,n,n,se,n,ne,n,ne,nw,ne,s,ne,n,ne,ne,ne,n,ne,s,s,ne,ne,ne,ne,ne,nw,ne,n,ne,ne,ne,n,ne,ne,n,ne,ne,n,n,ne,ne,ne,n,s,n,s,ne,ne,n,n,n,n,n,n,n,n,ne,n,n,sw,n,n,n,nw,n,ne,ne,sw,n,n,n,s,n,n,n,n,n,n,n,n,n,nw,se,n,s,s,n,n,n,ne,n,n,nw,n,n,nw,nw,n,n,nw,nw,n,nw,n,n,n,n,se,nw,n,nw,n,nw,nw,n,n,nw,nw,n,nw,n,n,nw,nw,n,nw,ne,n,n,n,n,nw,nw,nw,n,nw,n,nw,s,nw,n,n,n,n,nw,nw,n,n,nw,n,nw,nw,se,nw,ne,n,n,ne,n,nw,nw,n,n,n,nw,n,nw,n,n,nw,ne,nw,s,n,ne,n,nw,n,nw,nw,n,nw,n,n,nw,nw,nw,n,n,nw,nw,nw,nw,nw,n,nw,n,sw,n,n,nw,nw,nw,nw,s,nw,s,nw,nw,nw,n,nw,nw,nw,se,s,nw,nw,sw,nw,nw,n,se,ne,nw,nw,nw,sw,sw,ne,nw,nw,nw,nw,nw,nw,s,nw,nw,nw,nw,nw,sw,nw,nw,nw,s,nw,nw,se,nw,nw,nw,nw,sw,nw,ne,nw,nw,nw,nw,s,nw,nw,nw,nw,nw,n,nw,sw,sw,n,nw,nw,sw,nw,nw,sw,sw,se,nw,nw,nw,s,sw,nw,se,nw,sw,se,n,sw,sw,nw,sw,nw,nw,nw,nw,nw,ne,nw,nw,sw,nw,nw,nw,nw,sw,nw,sw,n,nw,nw,sw,nw,sw,sw,nw,sw,nw,nw,sw,sw,sw,sw,nw,ne,sw,nw,sw,sw,sw,sw,nw,sw,nw,sw,sw,sw,nw,sw,nw,nw,nw,sw,nw,sw,sw,sw,sw,sw,sw,nw,sw,n,sw,sw,sw,ne,sw,ne,sw,sw,nw,nw,sw,nw,sw,sw,sw,nw,sw,sw,s,sw,sw,ne,ne,s,sw,n,nw,sw,nw,ne,ne,se,sw,sw,sw,nw,nw,sw,nw,sw,n,sw,nw,s,sw,sw,sw,n,nw,sw,sw,ne,sw,sw,s,sw,se,s,sw,ne,s,sw,sw,sw,sw,sw,sw,sw,sw,sw,nw,n,n,sw,sw,ne,sw,sw,sw,n,sw,se,sw,sw,nw,n,sw,n,s,s,s,sw,sw,s,nw,sw,n,sw,sw,sw,sw,sw,sw,sw,sw,nw,sw,s,ne,n,sw,sw,sw,sw,sw,sw,sw,ne,sw,sw,s,sw,sw,s,sw,sw,sw,s,nw,s,sw,n,sw,sw,s,s,sw,s,sw,sw,ne,s,sw,s,sw,sw,n,n,s,sw,sw,sw,s,sw,s,s,sw,se,sw,sw,n,s,sw,sw,n,s,sw,sw,s,sw,sw,sw,s,sw,sw,se,sw,sw,sw,nw,s,sw,s,sw,sw,sw,s,sw,sw,n,s,s,s,s,ne,sw,sw,s,sw,s,s,sw,se,sw,nw,sw,sw,n,n,sw,n,s,s,se,s,sw,s,sw,s,s,ne,se,sw,s,se,sw,s,s,s,s,s,ne,se,sw,sw,sw,sw,nw,s,s,s,sw,s,s,se,sw,s,s,sw,n,sw,ne,n,s,sw,s,sw,s,s,s,s,sw,sw,se,sw,sw,s,s,s,s,sw,s,n,n,nw,nw,sw,se,s,sw,sw,sw,s,s,s,s,s,s,s,s,sw,se,s,n,n,s,s,s,s,s,s,ne,n,s,s,sw,s,s,s,s,s,sw,se,se,s,ne,sw,s,s,nw,s,sw,s,n,nw,sw,s,s,s,s,sw,s,s,sw,s,s,sw,s,s,s,s,s,s,sw,s,s,s,s,s,sw,s,s,n,s,s,ne,s,s,s,s,s,s,sw,n,s,s,s,ne,s,s,s,s,n,ne,s,s,s,s,s,s,n,sw,s,nw,s,s,s,se,s,s,s,n,s,s,sw,nw,nw,n,sw,s,s,s,s,s,s,s,s,se,s,se,n,s,se,s,nw,se,ne,s,s,s,s,s,se,s,s,nw,s,se,s,s,sw,se,s,se,s,s,n,s,s,s,s,s,s,s,se,se,se,nw,se,se,se,se,s,se,nw,s,s,s,s,ne,nw,se,s,s,n,s,s,se,ne,s,s,n,s,s,nw,se,n,nw,ne,ne,se,s,ne,se,se,s,s,ne,s,s,ne,s,s,se,n,se,se,s,s,n,se,s,se,s,se,nw,se,s,sw,s,ne,s,s,s,sw,se,s,s,se,s,s,se,se,s,se,sw,se,s,se,ne,s,sw,se,se,s,se,se,se,ne,s,n,s,n,se,ne,s,ne,s,n,s,ne,sw,ne,s,s,nw,s,sw,se,s,se,s,se,s,se,se,nw,s,se,se,n,sw,s,se,se,se,se,s,nw,n,se,s,s,s,s,s,se,se,s,se,se,se,nw,s,se,se,se,se,se,s,s,s,se,s,se,n,s,se,s,se,se,se,se,ne,s,s,se,s,s,se,s,se,s,se,nw,nw,s,se,se,s,ne,s,ne,se,nw,n,se,sw,se,s,n,se,se,s,s,se,se,se,se,s,se,ne,se,se,s,se,ne,sw,sw,nw,se,n,s,ne,se,se,se,s,se,sw,s,nw,se,se,se,se,se,nw,se,se,sw,se,se,se,sw,se,ne,se,se,ne,s,se,se,se,se,se,se,n,s,ne,se,s,s,se,se,se,se,se,se,se,se,se,se,se,se,se,se,se,se,se,s,ne,se,s,se,ne,se,se,se,s,ne,se,se,se,ne,n,s,se,se,se,se,se,se,se,s,se,se,s,se,se,ne,se,ne,ne,se,se,se,sw,se,se,ne,se,se,n,se,se,se,se,se,sw,se,se,se,nw,se,se,se,se,se,se,se,se,se,ne,se,se,se,se,se,se,se,se,se,se,se,n,se,ne,se,nw,se,ne,se,s,s,se,se,se,se,se,se,s,se,se,se,ne,se,se,nw,s,ne,se,s,ne,se,n,s,se,se,se,se,se,se,se,se,ne,se,se,se,se,se,se,se,n,ne,se,se,se,se,se,nw,se,ne,nw,se,se,se,ne,ne,se,se,nw,n,se,se,se,se,sw,se,nw,se,se,ne,se,se,se,se,sw,ne,se,n,se,se,se,se,n,se,se,se,ne,se,se,se,s,ne,se,se,sw,ne,se,se,se,ne,ne,n,n,s,se,ne,ne,sw,ne,n,se,ne,se,se,se,se,n,ne,sw,se,se,se,ne,se,n,nw,se,n,ne,ne,n,ne,ne,se,n,se,ne,s,se,ne,sw,se,s,se,ne,se,n,ne,ne,se,se,se,n,ne,sw,se,ne,sw,se,se,se,se,se,s,sw,ne,se,se,se,se,sw,se,se,se,se,sw,n,ne,n,se,se,s,ne,se,se,ne,ne,se,se,se,ne,se,ne,se,s,se,s,ne,se,n,n,se,se,nw,se,sw,se,n,s,se,se,sw,se,ne,ne,ne,s,se,se,ne,nw,se,ne,se,n,se,se,ne,ne,se,se,nw,se,ne,nw,ne,ne,ne,ne,ne,ne,ne,n,n,se,se,se,n,se,sw,se,n,se,ne,se,se,se,sw,se,ne,ne,ne,se,sw,se,se,n,se,se,ne,se,s,se,se,ne,ne,se,se,ne,se,se,ne,ne,ne,se,nw,se,se,se,ne,ne,se,se,s,nw,s,ne,se,se,se,se,ne,se,se,se,sw,ne,ne,ne,ne,ne,ne,ne,se,se,s,ne,s,se,se,nw,ne,sw,sw,ne,ne,se,ne,ne,se,se,ne,ne,ne,ne,sw,ne,ne,ne,ne,n,ne,ne,se,ne,sw,n,se,ne,ne,s,se,se,n,nw,se,ne,se,ne,ne,nw,ne,se,s,ne,ne,nw,se,ne,se,s,se,nw,ne,se,se,n,ne,se,ne,ne,se,se,sw,ne,se,ne,se,sw,se,n,ne,se,ne,se,ne,nw,ne,se,sw,ne,se,se,ne,sw,ne,ne,ne,ne,ne,ne,ne,n,ne,ne,n,ne,sw,ne,sw,ne,se,ne,ne,sw,ne,n,se,n,sw,ne,ne,s,ne,ne,ne,ne,ne,ne,ne,ne,ne,nw,se,ne,ne,ne,se,ne,s,n,ne,se,ne,ne,ne,ne,ne,ne,se,ne,ne,sw,ne,ne,se,n,ne,se,ne,ne,ne,nw,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,nw,ne,ne,ne,nw,ne,nw,sw,ne,sw,ne,se,s,ne,ne,ne,ne,ne,ne,se,ne,n,ne,ne,ne,ne,ne,sw,ne,ne,ne,ne,ne,sw,nw,se,se,ne,ne,sw,ne,n,ne,ne,ne,ne,s,ne,ne,ne,ne,ne,ne,ne,ne,s,nw,ne,n,ne,ne,ne,s,ne,nw,ne,ne,ne,ne,ne,ne,ne,ne,ne,sw,ne,ne,ne,ne,n,ne,ne,ne,nw,ne,ne,ne,ne,ne,se,ne,se,ne,ne,ne,ne,ne,ne,ne,n,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,nw,ne,n,n,ne,n,ne,s,ne,ne,ne,ne,ne,n,ne,ne,ne,se,ne,s,sw,ne,ne,ne,ne,ne,ne,ne,n,ne,ne,n,n,ne,ne,sw,n,ne,nw,n,s,n,ne,nw,nw,ne,se,nw,sw,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,se,ne,sw,n,ne,ne,n,ne,ne,ne,ne,ne,se,n,ne,s,ne,ne,ne,n,ne,ne,ne,ne,ne,s,ne,ne,nw,ne,ne,s,se,ne,ne,se,sw,s,ne,ne,ne,ne,ne,n,sw,nw,s,ne,n,ne,n,ne,ne,sw,ne,ne,ne,ne,se,n,ne,ne,ne,ne,ne,ne,ne,ne,sw,ne,n,n,s,nw,s,ne,n,n,ne,ne,sw,ne,ne,n,nw,n,nw,s,ne,se,ne,ne,n,ne,n,n,ne,ne,n,ne,sw,ne,n,n,s,ne,ne,n,nw,ne,n,ne,n,n,ne,n,ne,s,sw,n,ne,nw,n,ne,ne,ne,n,ne,nw,n,ne,ne,ne,n,ne,n,n,s,se,s,s,nw,ne,ne,ne,ne,ne,se,ne,se,ne,ne,s,n,n,ne,sw,n,ne,n,ne,ne,n,ne,ne,ne,n,ne,ne,ne,n,n,ne,n,ne,n,ne,ne,ne,n,sw,ne,n,ne,n,ne,n,ne,s,ne,n,nw,ne,ne,ne,n,ne,n,n,ne,sw,ne,ne,ne,ne,n,ne,n,s,ne,ne,n,ne,ne,n,ne,ne,n,ne,n,nw,s,ne,ne,n,n,ne,n,nw,n,s,ne,ne,n,se,n,s,n,ne,ne,ne,n,ne,ne,se,n,n,ne,ne,n,n,ne,ne,ne,ne,n,n,ne,n,n,n,s,se,n,n,n,n,ne,ne,ne,ne,ne,se,ne,n,n,s,ne,ne,n,ne,ne,s,se,ne,se,n,n,ne,ne,s,n,n,se,ne,s,ne,s,ne,sw,n,ne,n,n,s,ne,ne,ne,ne,ne,ne,n,n,ne,ne,n,ne,ne,se,s,n,ne,nw,n,ne,nw,n,ne,n,ne,n,n,ne,n,n,n,n,n,ne,n,n,ne,ne,n,n,se,sw,ne,ne,ne,nw,ne,n,sw,ne,s,ne,n,sw,ne,n,n,n,n,n,ne,ne,n,ne,ne,ne,n,n,ne,n,ne,n,ne,s,sw,n,n,ne,ne,ne,n,sw,s,ne,n,se,s,n,n,ne,n,se,n,ne,ne,sw,se,n,ne,n,ne,ne,n,n,n,ne,nw,ne,s,n,n,ne,ne,se,ne,se,nw,nw,nw,sw,n,ne,n,n,n,n,n,n,s,n,nw,n,ne,ne,n,ne,ne,n,ne,s,n,n,ne,sw,n,ne,n,n,n,ne,nw,n,ne,sw,n,n,n,ne,n,ne,n,ne,n,n,ne,n,n,s,n,ne,ne,se,ne,n,n,n,n,nw,n,n,n,n,n,s,n,n,n,n,n,n,ne,se,n,sw,n,n,n,n,ne,n,n,n,n,n,n,n,sw,n,ne,ne,s,n,n,ne,n,n,n,n,n,nw,n,sw,n,n,n,n,n,se,n,n,n,n,n,ne,n,n,n,s,n,n,ne,n,n,n,n,se,n,n,n,ne,n,n,n,n,n,n,n,ne,n,n,n,n,n,ne,s,n,se,n,n,n,n,ne,n,sw,n,n,nw,n,ne,n,se,n,ne,ne,n,n,ne,n,s,n,n,n,n,s,n,nw,n,n,n,nw,n,n,s,n,n,n,sw,n,n,n,ne,n,ne,n,s,n,n,n,n,ne,n,n,n,n,n,n,n,n,sw,n,n,n,s,n,s,nw,n,sw,n,se,se,nw,n,n,n,se,n,ne,n,n,ne,n,n,ne,n,ne,n,n,n,n,n,n,se,se,n,se,nw,s,n,n,sw,n,n,n,n,n,n,n,nw,n,nw,n,n,n,n,se,sw,n,n,n,n,n,n,s,n,n,s,n,n,n,n,n,n,n,se,n,n,n,n,n,se,n,n,n,n,ne,n,s,n,n,n,n,n,se,n,n,n,se,n,n,n,n,n,n,n,se,ne,n,n,n,n,n,n,n,n,nw,sw,n,se,n,se,n,se,nw,s,n,nw,sw,n,nw,se,n,nw,n,n,n,n,n,nw,ne,n,ne,n,n,n,n,n,sw,n,n,sw,nw,n,se,n,n,n,se,n,ne,ne,n,n,n,n,n,sw,n,n,n,n,nw,s,ne,n,sw,n,n,n,n,n,n,n,nw,n,n,nw,n,n,n,n,n,n,n,n,sw,ne,n,s,n,n,n,nw,n,nw,n,se,n,n,nw,n,n,n,n,nw,se,n,n,nw,ne,n,n,sw,sw,n,nw,n,se,n,n,se,n,n,n,n,ne,nw,nw,n,sw,nw,n,ne,ne,n,n,n,n,n,nw,n,n,n,n,nw,n,sw,sw,n,se,sw,n,nw,n,n,n,nw,nw,n,n,nw,n,nw,nw,nw,nw,n,n,n,n,n,nw,nw,nw,n,n,n,n,n,n,n,n,ne,nw,n,n,s,n,n,n,nw,nw,n,n,sw,n,n,n,n,n,n,n,n,se,ne,nw,n,nw,nw,s,s,nw,s,n,n,nw,nw,n,n,n,n,n,s,nw,n,ne,n,nw,s,n,nw,n,n,n,n,n,se,n,n,nw,n,n,nw,nw,n,n,nw,n,nw,n,nw,n,nw,nw,sw,n,nw,ne,n,n,n,n,n,n,n,sw,s,n,n,n,n,n,nw,nw,nw,nw,se,n,se,se,nw,nw,nw,nw,n,se,n,n,nw,nw,n,se,n,n,n,n,n,n,n,nw,nw,n,n,nw,s,ne,ne,n,n,n,n,s,nw,n,n,n,n,nw,sw,sw,nw,nw,nw,nw,nw,n,n,n,n,n,s,s,n,nw,n,n,n,n,n,nw,n,n,nw,nw,s,nw,n,n,nw,n,n,nw,nw,n,nw,n,nw,nw,sw,n,n,s,n,ne,n,s,n,n,n,n,nw,nw,n,n,n,n,n,nw,nw,n,nw,nw,n,nw,se,s,n,n,nw,sw,n,n,nw,nw,n,nw,n,s,nw,nw,nw,nw,ne,n,n,n,nw,n,n,s,nw,sw,sw,se,n,n,n,nw,se,nw,n,n,nw,nw,nw,n,nw,nw,ne,n,n,nw,n,n,nw,n,nw,n,ne,n,nw,se,sw,nw,nw,sw,n,n,n,n,n,n,n,n,n,n,n,n,nw,nw,se,n,nw,n,nw,nw,ne,ne,n,n,ne,nw,n,nw,nw,n,nw,n,n,nw,sw,nw,se,nw,sw,nw,nw,n,n,nw,n,nw,n,n,sw,sw,n,se,n,n,n,nw,n,n,nw,n,sw,se,sw,nw,n,sw,n,s,nw,nw,nw,n,n,nw,n,nw,nw,nw,nw,nw,nw,n,nw,nw,se,s,s,sw,n,nw,sw,nw,nw,n,n,n,nw,nw,nw,n,nw,nw,n,nw,nw,n,nw,nw,nw,nw,nw,nw,n,n,nw,nw,ne,s,nw,n,s,n,nw,nw,sw,nw,n,n,sw,nw,n,sw,ne,n,n,nw,se,sw,n,n,nw,n,ne,n,nw,se,s,s,n,nw,nw,n,nw,nw,n,n,n,n,sw,sw,nw,n,n,n,n,sw,s,se,n,nw,n,nw,nw,se,nw,n,ne,n,nw,n,ne,se,nw,nw,nw,n,sw,ne,n,n,nw,n,se,n,n,sw,nw,ne,n,nw,nw,nw,s,nw,nw,n,nw,ne,nw,nw,nw,n,se,nw,nw,n,nw,nw,nw,nw,n,nw,n,n,ne,n,sw,nw,n,n,nw,nw,nw,n,nw,s,n,nw,nw,nw,nw,se,n,n,nw,n,n,nw,s,ne,n,nw,n,s,se,nw,sw,nw,nw,nw,s,nw,nw,n,nw,n,se,s,nw,nw,nw,sw,n,nw,n,se,n,s,nw,nw,nw,n,nw,nw,n,n,sw,nw,nw,nw,n,nw,sw,nw,nw,s,se,nw,nw,nw,ne,s,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,n,n,nw,nw,nw,nw,nw,nw,n,nw,n,nw,nw,n,sw,nw,sw,nw,nw,n,n,n,nw,ne,nw,n,nw,nw,nw,n,nw,nw,nw,nw,nw,n,nw,n,nw,n,nw,n,nw,nw,nw,nw,nw,nw,nw,nw,ne,nw,nw,n,nw,sw,n,nw,nw,nw,nw,nw,nw,s,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,n,nw,nw,n,s,n,se,nw,nw,se,n,nw,ne,n,n,nw,nw,ne,nw,n,ne,nw,nw,n,n,ne,ne,sw,nw,nw,nw,n,sw,n,n,ne,nw,sw,nw,nw,nw,ne,se,sw,nw,ne,nw,nw,n,nw,nw,nw,nw,nw,ne,nw,n,s,nw,nw,nw,nw,nw,nw,ne,n,s,nw,n,nw,nw,s,n,nw,ne,s,nw,nw,nw,sw,nw,nw,nw,n,nw,nw,nw,n,n,nw,nw,nw,n,nw,n,sw,nw,nw,nw,nw,nw,n,n,nw,nw,nw,ne,s,nw,sw,nw,se,nw,nw,nw,n,nw,se,nw,ne,nw,nw,n,nw,se,nw,n,sw,sw,nw,se,nw,nw,nw,nw,n,nw,s,nw,n,nw,nw,se,nw,s,n,se,n,sw,nw,nw,nw,n,nw,ne,n,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,ne,nw,n,nw,nw,nw,s,sw,nw,nw,s,sw,nw,nw,nw,nw,nw,nw,nw,nw,n,se,nw,n,nw,nw,nw,nw,nw,nw,n,nw,nw,nw,nw,nw,sw,nw,se,nw,nw,nw,nw,nw,ne,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,s,nw,nw,nw,n,nw,nw,ne,nw,nw,nw,nw,nw,se,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,n,nw,se,nw,nw,n,s,s,nw,nw,n,nw,nw,nw,se,nw,nw,nw,ne,nw,se,nw,nw,nw,se,nw,nw,nw,s,se,n,nw,nw,nw,n,s,nw,nw,nw,nw,nw,n,nw,nw,ne,se,nw,nw,nw,nw,nw,nw,nw,nw,nw,ne,nw,ne,sw,sw,s,ne,nw,nw,nw,nw,n,nw,nw,se,nw,nw,nw,n,nw,nw,nw,nw,nw,nw,nw,s,sw,nw,nw,nw,nw,nw,n,nw,s,sw,nw,nw,nw,nw,nw,s,n,nw,nw,nw,nw,n,nw,nw,nw,nw,nw,sw,nw,sw,nw,se,sw,nw,ne,nw,sw,nw,ne,sw,nw,nw,nw,nw,nw,nw,sw,nw,nw,nw,sw,nw,sw,s,s,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,s,se,nw,nw,nw,nw,nw,n,ne,sw,nw,nw,nw,nw,nw,sw,nw,nw,ne,nw,nw,nw,nw,nw,nw,sw,nw,nw,nw,nw,sw,s,nw,nw,nw,ne,ne,nw,nw,nw,nw,nw,nw,sw,s,sw,se,nw,sw,ne,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,sw,sw,nw,nw,nw,nw,s,sw,sw,se,se,nw,nw,s,nw,nw,sw,n,sw,sw,nw,sw,nw,nw,nw,nw,n,nw,nw,ne,nw,n,nw,nw,nw,sw,nw,ne,s,sw,s,nw,nw,nw,n,sw,nw,nw,nw,nw,nw,se,nw,sw,nw,nw,se,nw,nw,ne,sw,nw,nw,sw,nw,nw,nw,nw,sw,nw,sw,s,nw,nw,nw,sw,nw,nw,nw,nw,nw,nw,ne,nw,n,nw,nw,nw,nw,nw,nw,nw,se,s,n,s,s,ne,nw,sw,nw,nw,sw,nw,nw,nw,nw,nw,nw,sw,nw,se,nw,nw,nw,nw,se,nw,n,nw,n,sw,nw,nw,sw,nw,nw,nw,nw,nw,nw,se,nw,nw,nw,nw,nw,ne,nw,nw,nw,sw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,sw,s,sw,nw,sw,nw,sw,nw,nw,nw,nw,nw,n,nw,nw,n,se,nw,sw,nw,nw,sw,se,s,nw,sw,sw,se,sw,nw,sw,sw,n,sw,nw,ne,nw,sw,nw,nw,sw,nw,sw,nw,nw,n,sw,sw,nw,nw,nw,sw,nw,sw,nw,n,nw,ne,nw,nw,nw,sw,s,nw,nw,se,n,nw,nw,nw,nw,sw,sw,ne,sw,nw,sw,nw,se,sw,nw,nw,nw,sw,n,sw,sw,sw,nw,ne,sw,sw,nw,nw,sw,se,nw,nw,se,nw,s,ne,sw,s,s,nw,nw,nw,nw,nw,nw,nw,n,nw,ne,sw,sw,sw,sw,s,sw,sw,nw,nw,nw,nw,nw,sw,ne,sw,nw,nw,ne,nw,sw,nw,nw,nw,sw,nw,nw,nw,nw,sw,nw,n,sw,nw,nw,nw,sw,s,sw,sw,nw,sw,n,nw,nw,nw,nw,nw,nw,nw,sw,nw,nw,sw,sw,nw,nw,nw,nw,s,sw,nw,s,n,nw,sw,sw,se,nw,nw,nw,nw,nw,nw,s,nw,nw,ne,nw,s,sw,sw,sw,nw,sw,sw,nw,nw,sw,se,sw,nw,nw,sw,sw,ne,nw,nw,nw,n,nw,sw,nw,nw,nw,nw,sw,sw,sw,nw,sw,sw,ne,nw,nw,nw,sw,nw,ne,sw,n,nw,nw,nw,nw,sw,nw,nw,sw,nw,nw,nw,sw,se,sw,nw,nw,nw,nw,nw,nw,sw,s,sw,sw,se,s,sw,ne,nw,ne,sw,sw,nw,nw,sw,sw,se,nw,n,nw,nw,nw,nw,sw,nw,ne,sw,n,sw,sw,sw,sw,se,se,sw,ne,sw,sw,nw,nw,sw,sw,sw,sw,nw,nw,nw,nw,sw,sw,nw,nw,sw,nw,nw,nw,nw,sw,sw,s,ne,sw,nw,sw,sw,sw,nw,n,nw,sw,nw,nw,nw,nw,sw,nw,sw,nw,nw,nw,se,sw,sw,sw,sw,s,ne,sw,sw,sw,sw,nw,sw,ne,ne,sw,nw,sw,nw,nw,se,sw,sw,nw,sw,nw,sw,n,sw,nw,nw,sw,sw,sw,sw,nw,sw,nw,sw,n,nw,s,sw,sw,sw,sw,sw,nw,se,s,sw,sw,sw,sw,sw,nw,sw,sw,nw,n,se,nw,sw,nw,nw,s,sw,nw,se,nw,sw,sw,s,s,nw,s,sw,nw,sw,nw,sw,sw,sw,sw,sw,nw,nw,nw,sw,sw,sw,n,s,se,sw,ne,s,sw,ne,sw,sw,nw,nw,sw,sw,sw,sw,sw,se,sw,nw,nw,se,sw,n,sw,s,nw,sw,sw,sw,nw,sw,se,ne,nw,sw,nw,sw,sw,sw,nw,sw,sw,sw,sw,nw,sw,sw,nw,nw,nw,n,sw,nw,nw,nw,s,nw,nw,nw,sw,s,se,sw,nw,sw,n,ne,se,nw,s,s,sw,se,s,sw,nw,sw,se,sw,sw,nw,nw,s,nw,n,nw,ne,nw,sw,sw,nw,sw,sw,n,nw,nw,s,ne,se,n,sw,n,nw,n,sw,ne,sw,nw,sw,sw,nw,ne,s,nw,nw,nw,nw,ne,sw,sw,se,nw,sw,sw,se,sw,nw,nw,sw,nw,sw,sw,nw,sw,sw,sw,sw,n,sw,nw,se,sw,s,ne,sw,sw,sw,sw,sw,se,sw,nw,ne,nw,sw,nw,ne,sw,se,sw,nw,nw,sw,nw,sw,ne,sw,ne,sw,nw,nw,nw,s,nw,n,sw,s,nw,nw,nw,nw,se,ne,sw,se,sw,sw,nw,sw,sw,nw,nw,ne,se,sw,nw,sw,se,nw,nw,nw,sw,s,sw,nw,sw,sw,nw,nw,sw,nw,nw,s,sw,sw,nw,sw,se,ne,sw,sw,se,s,nw,sw,sw,sw,nw,sw,nw,sw,sw,sw,nw,ne,nw,n,sw,se,n,sw,se,s,sw,nw,sw,sw,nw,s,sw,sw,nw,sw,sw,sw,ne,n,sw,s,ne,sw,sw,sw,sw,nw,sw,sw,sw,nw,sw,sw,sw,s,sw,sw,sw,nw,sw,sw,sw,sw,sw,nw,s,sw,nw,nw,n,sw,sw,sw,sw,nw,sw,sw,sw,sw,sw,sw,nw,nw,sw,nw,se,sw,nw,ne,nw,sw,nw,sw,sw,s,sw,nw,sw,sw,sw,nw,sw,sw,sw,nw,sw,nw,sw,ne,nw,ne,sw,nw,sw,sw,sw,nw,nw,nw,nw,sw,s,sw,nw,se,nw,sw,nw,sw,sw,sw,sw,sw,sw,sw,sw,nw,sw,s,nw,sw,sw,nw,nw,nw,sw,sw,sw,sw,sw,sw,ne,sw,se,sw,sw,nw,sw,ne,nw,sw,sw,nw,sw,n,s,nw,sw,sw,se,sw,n,nw,ne,nw,nw,sw,sw,sw,sw,sw,ne,ne,sw,sw,nw,nw,sw,nw,n,sw,sw,sw,nw,n,sw,n,sw,sw,s,nw,nw,ne,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,ne,nw,sw,s,sw,sw,s,nw,sw,sw,ne,nw,sw,sw,sw,nw,s,sw,sw,sw,sw,nw,sw,sw,sw,sw,nw,sw,sw,sw,sw,sw,sw,nw,sw,sw,nw,sw,sw,se,sw,sw,nw,sw,sw,se,se,sw,s,nw,sw,sw,nw,sw,se,sw,se,sw,s,sw,ne,nw,s,s,sw,sw,sw,sw,sw,sw,sw,nw,se,sw,s,sw,sw,sw,ne,sw,sw,nw,nw,nw,sw,nw,sw,s,sw,ne,sw,sw,sw,sw,nw,sw,sw,ne,nw,sw,nw,sw,sw,ne,sw,sw,sw,s,nw,sw,sw,nw,sw,sw,sw,sw,sw,ne,se,nw,sw,sw,s,n,ne,sw,sw,nw,sw,se,sw,sw,sw,sw,sw,ne,sw,sw,nw,sw,sw,sw,sw,sw,sw,sw,nw,sw,sw,sw,nw,sw,sw,sw,sw,nw,s,sw,se,sw,sw,sw,n,nw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,ne,sw,sw,sw,sw,sw,sw,sw,nw,nw,sw,sw,se,se,s,sw,ne,sw,sw,n,s,sw,sw,sw,sw,sw,sw,sw,sw,ne,se,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,n,nw,sw,ne,sw,nw,sw,sw,nw,sw,sw,sw,sw,n,sw,sw,sw,sw,nw,sw,sw,s,sw,sw,sw,sw,nw,sw,sw,sw,sw,sw,sw,sw,sw,nw,sw,sw,sw,sw,sw,sw,sw,s,sw,sw,sw,sw,se,sw,sw,sw,ne,sw,sw,sw,sw,se,sw,sw,s,se,sw,sw,sw,n,sw,sw,sw,sw,sw,sw,n,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,ne,sw,sw,sw,sw,ne,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,s,sw,sw,nw,sw,sw,ne,n,sw,sw,sw,sw,sw,sw,n,sw,sw,sw,sw,sw,sw,sw,sw,nw,n,nw,n,sw,nw,ne,se,se,se,s,se,s,sw,s,nw,s,s,s,s,se,se,nw,sw,sw,sw,s,s,s,sw,sw,n,se,sw,s,sw,sw,sw,sw,sw,sw,nw,sw,sw,nw,sw,nw,s,sw,s,nw,s,nw,nw,nw,s,nw,nw,nw,nw,nw,nw,n,ne,nw,sw,nw,n,sw,nw,nw,n,n,nw,n,nw,n,n,nw,n,sw,n,sw,n,ne,n,n,n,n,n,sw,n,n,n,se,n,se,n,n,ne,n,ne,se,n,ne,n,n,n,n,n,nw,s,ne,ne,n,ne,se,ne,ne,ne,ne,s,ne,n,ne,ne,se,s,ne,ne,se,ne,ne,n,n,ne,sw,s,n,ne,ne,ne,ne,ne,ne,ne,ne,ne,n,ne,ne,ne,ne,ne,sw,se,nw,se,s,ne,se,ne,se,ne,ne,ne,se,sw,ne,ne,ne,s,nw,ne,se,ne,se,ne,s,se,ne,se,se,ne,se,se,se,ne,nw,ne,se,ne,sw,se,se,ne,se,nw,se,se,se,ne,se,se,se,n,ne,ne,se,se,se,ne,se,se,se,nw,se,se,se,se,se,se,se,se,se,se,se,sw,se,se,sw,se,s,se,se,se,se,se,se,se,se,ne,se,se,se,se,nw,s,s,ne,se,se,se,sw,s,nw,s,se,s,s,s,se,s,nw,se,sw,sw,s,se,se,s,se,se,nw,se,s,se,s,se,s,s,s,s,se,se,s,s,s,s,se,se,se,sw,s,s,s,ne,ne,s,sw,sw,s,s,s,s,nw,s,nw,se,ne,s,se,s,ne,s,s,s,s,s,s,s,sw,s,s,sw,s,se,se,s,s,s,s,s,nw,s,se,s,s,sw,s,s,s,s,s,s,s,sw,s,s,s,s,s,s,s,s,se,s,nw,s,sw,s,s,sw,s,s,se,s,s,sw,s,s,sw,sw,sw,sw,s,sw,n,n,sw,ne,sw,sw,s,sw,ne,s,sw,nw,nw,s,s,sw,sw,sw,s,s,sw,s,sw,sw,sw,s,se,nw,s,s,sw,s,sw,sw,s,nw,sw,s,s,sw,sw,sw,sw,s,s,sw,sw,ne,sw,sw,s,se,sw,n,sw,se,sw,sw,s,sw,sw,sw,se,sw,sw,sw,sw,sw,s,n,s,n,sw,sw,sw,sw,nw,sw,sw,nw,sw,s,sw,sw,nw,ne,sw,sw,sw,sw,sw,sw,se,n,sw,sw,sw,nw,sw,sw,sw,sw,nw,sw,s,sw,sw,sw,sw,sw,sw,sw,se,n,nw,sw,ne,nw,ne,sw,sw,nw,nw,nw,sw,sw,sw,sw,sw,sw,sw,nw,sw,sw,n,nw,sw,sw,nw,sw,sw,sw,se,nw,s,sw,nw,s,n,nw,sw,sw,s,sw,sw,ne,sw,sw,nw,sw,n,sw,se,sw,nw,nw,nw,sw,nw,sw,sw,sw,ne,sw,nw,sw,n,nw,nw,sw,sw,sw,nw,nw,se,nw,nw,sw,se,sw,sw,nw,sw,sw,sw,nw,sw,nw,nw,sw,sw,sw,sw,sw,nw,nw,se,sw,ne,nw,sw,sw,sw,nw,n,sw,nw,sw,nw,ne,nw,nw,s,nw,nw,nw,sw,s,sw,sw,sw,nw,nw,n,nw,nw,nw,nw,nw,sw,sw,nw,n,nw,sw,sw,sw,se,sw,sw,nw,ne,nw,nw,n,nw,nw,nw,nw,nw,sw,nw,nw,nw,ne,nw,ne,nw,nw,sw,sw,nw,nw,nw,nw,nw,sw,nw,nw,nw,nw,nw,ne,nw,nw,nw,nw,nw,sw,sw,nw,se,se,sw,nw,nw,nw,nw,s,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,sw,nw,ne,nw,nw,ne,nw,sw,nw,nw,nw,nw,nw,nw,ne,nw,nw,nw,nw,nw,sw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,sw,nw,nw,nw,sw,n,nw,nw,n,nw,se,se,s,nw,nw,n,ne,nw,ne,nw,nw,n,nw,sw,nw,s,s,nw,nw,n,nw,nw,se,nw,n,n,nw,ne,n,nw,nw,n,n,n,sw,n,nw,nw,nw,nw,sw,n,se,nw,s,sw,n,nw,nw,n,nw,nw,nw,n,n,nw,ne,n,s,se,n,s,n,nw,n,se,ne,nw,sw,n,se,nw,nw,s,se,n,n,ne,sw,s,n,nw,nw,nw,sw,nw,n,nw,nw,s,nw,n,n,n,n,n,n,n,n,nw,n,s,nw,n,nw,n,n,nw,se,s,nw,n,ne,sw,nw,sw,nw,nw,nw,nw,n,n,nw,n,n,n,nw,n,n,s,n,sw,n,sw,ne,n,n,n,nw,nw,n,nw,n,nw,nw,n,nw,n,s,n,n,s,n,nw,sw,nw,sw,nw,n,se,nw,s,nw,s,n,se,n,nw,n,n,n,n,n,n,ne,n,ne,n,n,n,n,nw,nw,s,n,n,ne,n,ne,n,n,n,n,n,n,sw,nw,n,n,n,n,nw,n,n,nw,n,n,n,n,se,n,n,n,n,n,n,nw,n,n,n,ne,n,n,n,n,n,s,n,n,sw,n,n,n,se,n,n,se,n,sw,n,n,se,n,n,s,se,nw,n,n,n,n,n,n,n,n,n,n,ne,n,n,n,n,n,se,ne,n,n,n,n,n,n,n,n,ne,n,n,n,n,n,n,n,s,n,s,se,n,n,n,n,ne,ne,n,n,s,n,n,n,n,n,n,nw,n,n,ne,n,n,n,ne,n,n,sw,se,n,n,n,ne,s,n,ne,n,n,n,n,n,s,n,se,n,se,s,n,n,n,n,ne,n,n,n,n,sw,se,n,n,nw,sw,nw,ne,n,n,se,n,n,n,se,n,n,n,ne,n,n,sw,nw,n,n,ne,n,ne,ne,n,n,n,ne,n,n,n,sw,n,sw,se,n,n,ne,s,n,ne,ne,n,n,n,se,sw,n,n,ne,s,ne,ne,ne,ne,ne,n,n,n,n,n,n,nw,ne,n,n,n,ne,ne,ne,sw,n,n,n,n,n,n,ne,ne,n,n,n,n,n,n,ne,s,ne,ne,ne,n,ne,n,n,ne,ne,se,ne,n,nw,ne,ne,s,ne,ne,n,ne,n,n,ne,n,ne,n,n,ne,ne,ne,se,n,ne,ne,nw,ne,n,ne,ne,n,ne,n,ne,ne,n,se,n,n,ne,n,n,ne,ne,n,ne,n,ne,ne,nw,n,ne,ne,ne,n,ne,ne,ne,s,nw,ne,ne,n,ne,n,ne,n,ne,ne,ne,sw,s,n,ne,ne,ne,n,sw,ne,nw,se,nw,ne,ne,n,ne,n,ne,ne,ne,ne,ne,ne,sw,ne,ne,se,ne,n,ne,ne,n,n,ne,ne,ne,ne,ne,ne,n,ne,ne,n,ne,ne,ne,se,sw,sw,nw,ne,ne,n,ne,nw,ne,ne,ne,ne,ne,ne,se,nw,ne,ne,ne,ne,n,ne,ne,n,ne,ne,ne,n,sw,ne,ne,s,n,ne,nw,ne,n,ne,s,ne,ne,ne,ne,ne,ne,n,sw,ne,sw,sw,se,ne,n,ne,s,ne,ne,s,n,ne,ne,ne,ne,ne,n,ne,ne,ne,ne,ne,sw,ne,ne,ne,ne,ne,ne,sw,n,ne,ne,ne,se,n,ne,nw,ne,nw,se,ne,s,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,s,ne,ne,s,ne,ne,ne,se,ne,ne,nw,ne,sw,n,ne,ne,se,ne,sw,se,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,nw,ne,ne,ne,sw,ne,ne,ne,ne,ne,ne,ne,ne,s,ne,se,ne,ne,se,ne,ne,s,ne,ne,ne,ne,ne,ne,se,ne,ne,ne,sw,ne,ne,se,se,ne,ne,se,ne,se,nw,ne,ne,ne,ne,ne,se,ne,ne,ne,se,ne,ne,ne,ne,se,se,ne,se,ne,s,n,s,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,se,se,s,ne,n,se,ne,ne,ne,se,n,n,ne,se,nw,n,ne,ne,s,nw,ne,ne,se,ne,s,se,ne,se,ne,ne,ne,ne,ne,sw,n,ne,ne,ne,ne,ne,ne,ne,se,ne,ne,ne,s,ne,ne,ne,ne,se,se,se,ne,se,se,ne,ne,se,ne,ne,se,se,ne,ne,se,ne,s,ne,n,ne,ne,se,se,ne,n,ne,nw,se,ne,se,se,n,ne,s,se,ne,se,ne,se,se,se,se,se,se,sw,se,se,se,ne,sw,ne,ne,ne,ne,ne,nw,ne,se,s,se,ne,se,se,se,ne,sw,ne,se,ne,se,nw,se,ne,n,se,se,sw,ne,ne,se,sw,ne,se,se,se,se,ne,ne,ne,se,se,ne,se,ne,se,ne,se,se,se,se,n,n,se,se,ne,ne,se,se,se,se,ne,ne,s,s,ne,se,se,se,ne,sw,se,ne,se,sw,ne,ne,se,se,nw,se,ne,nw,ne,se,se,ne,se,se,ne,ne,se,se,sw,se,se,n,se,se,ne,se,ne,se,se,se,ne,se,n,se,se,ne,se,ne,ne,se,ne,se,se,se,se,s,se,sw,se,se,se,ne,se,ne,se,ne,ne,se,s,ne,ne,se,se,se,se,s,se,se,ne,se,ne,se,se,se,ne,se,s,ne,se,se,ne,se,ne,se,se,ne,se,se,n,se,s,ne,ne,se,se,ne,s,se,se,nw,n,ne,ne,se,ne,sw,ne,s,s,sw,sw,ne,se,se,n,nw,se,n,se,n,ne,se,ne,se,se,nw,ne,se,se,ne,nw,se,se,ne,se,sw,ne,ne,se,se,se,se,se,se,s,se,ne,se,se,se,nw,se,se,n,se,se,ne,sw,se,se,se,se,se,ne,se,nw,nw,ne,se,se,se,se,ne,s,se,se,sw,se,se,se,se,n,n,se,se,n,se,se,se,se,n,se,se,se,n,se,ne,se,ne,nw,se,n,se,ne,se,se,se,se,se,se,se,se,nw,se,se,se,n,se,se,se,se,ne,se,se,se,se,se,se,n,nw,ne,ne,se,se,ne,sw,se,sw,se,se,se,ne,se,n,n,nw,se,se,sw,n,se,s,s,se,se,se,se,se,se,nw,se,sw,ne,se,s,se,se,se,se,se,ne,se,s,se,n,se,se,se,se,se,se,ne,se,sw,se,sw,se,se,se,se,se,se,se,ne,s,se,se,n,n,se,se,se,se,se,se,se,se,se,se,nw,s,se,se,nw,se,n,se,nw,se,s,sw,se,se,se,nw,se,sw,se,se,s,ne,se,se,se,se,se,sw,se,se,se,se,se,se,se,se,ne,ne,se,nw,s,se,se,se,s,se,se,se,se,se,se,se,se,se,se,nw,s,n,se,se,se,se,nw,se,se,se,se,se,se,se,ne,se,se,se,se,s,se,se,se,sw,nw,se,se,se,n,se,ne,se,se,se,se,se,se,se,sw,n,se,se,se,se,se,se,se,se,se,se,se,se,ne,se,se,se,se,se,se,se,se,ne,se,se,se,se,se,se,se,s,ne,ne,ne,se,ne,s,se,se,se,s,se,s,se,s,se,se,se,se,se,s,se,s,nw,se,se,se,sw,ne,s,se,ne,se,se,se,s,se,se,s,s,se,s,se,se,sw,n,se,ne,s,s,se,s,se,se,nw,se,s,se,n,ne,se,se,se,se,s,se,se,s,s,s,se,se,sw,s,se,se,s,n,se,n,se,se,ne,s,ne,se,se,s,se,se,ne,s,sw,sw,s,se,s,se,nw,se,ne,se,se,se,n,se,s,nw,se,n,se,s,se,se,se,s,s,se,se,se,s,se,se,se,s,se,se,s,se,s,se,se,se,se,se,se,se,s,se,s,se,s,se,n,s,se,se,se,se,s,se,se,se,se,nw,s,n,s,se,s,se,s,se,s,se,se,se,s,se,s,s,s,se,s,se,se,se,ne,se,se,nw,se,s,se,se,se,s,s,s,se,se,s,sw,ne,se,s,s,se,se,s,se,se,s,se,nw,s,s,se,se,nw,s,se,s,se,se,se,s,se,se,nw,se,n,se,se,se,se,ne,se,se,n,se,s,s,s,s,se,se,s,s,s,s,se,n,se,s,s,se,se,s,sw,se,s,ne,n,s,se,sw,se,se,n,sw,se,ne,se,s,se,s,se,se,se,nw,ne,se,se,se,se,s,s,se,se,s,se,se,s,s,ne,nw,s,s,nw,sw,sw,s,se,sw,nw,se,se,s,se,sw,s,s,ne,se,s,s,se,se,s,se,se,sw,se,se,s,se,s,se,s,s,s,s,nw,s,s,s,se,se,s,se,se,s,s,se,se,s,s,se,s,s,s,n,s,se,se,s,n,sw,s,se,se,s,se,s,s,s,s,se,se,s,s,sw,s,se,s,sw,s,s,s,s,se,n,s,se,se,s,se,s,se,s,s,s,s,se,se,se,ne,s,s,s,s,se,s,s,s,ne,s,s,nw,s,s,s,se,se,se,s,s,s,s,s,s,s,s,se,nw,se,se,s,s,se,s,s,se,se,s,s,s,se,s,s,se,s,se,s,se,s,s,s,se,s,s,n,se,s,s,ne,s,s,s,se,s,s,s,s,n,s,se,n,sw,se,se,s,s,s,s,se,s,s,s,s,s,se,se,se,s,s,s,s,ne,ne,s,s,se,s,s,se,s,se,s,se,sw,s,s,se,s,s,se,nw,s,s,s,s,s,s,se,se,s,s,ne,s,s,s,s,s,se,s,ne,s,s,s,s,s,s,s,se,s,s,se,s,s,s,sw,nw,s,se,n,se,s,s,s,ne,ne,s,s,s,s,s,se,s,s,s,s,s,s,n,s,s,s,s,s,ne,s,n,s,se,s,s,s,se,s,s,s,sw,s,se,s,nw,s,se,se,s,sw,s,s,s,se,s,s,s,sw,nw,s,se,se,s,s,s,s,n,nw,sw,s,s,nw,sw,s,n,se,sw,se,s,ne,s,s,ne,s,s,s,s,s,s,se,s,s,sw,s,se,s,s,nw,s,s,s,s,s,s,sw,s,s,s,s,s,s,s,s,s,s,s,s"

	for i=1:1:$length(pInput,",") {
		set tDir($piece(pInput,",",i))=$G(tDir($piece(pInput,",",i)))+1
	}
	
	quit ##class(AOC.Y2017).Day11Eval(.tDir)
}

ClassMethod Day11P2(pInput = "") As %String
{
	set:pInput="" pInput="sw,s,se,se,se,se,se,nw,ne,ne,ne,ne,ne,n,n,ne,n,n,n,n,n,sw,sw,n,ne,nw,n,n,nw,nw,n,nw,nw,nw,nw,nw,nw,nw,ne,sw,s,nw,sw,se,nw,sw,sw,nw,nw,nw,sw,sw,s,nw,nw,sw,sw,sw,sw,n,sw,sw,sw,sw,sw,sw,sw,sw,s,s,sw,sw,s,sw,s,sw,sw,sw,sw,ne,s,s,ne,sw,s,sw,s,s,n,ne,sw,s,sw,s,s,s,s,s,s,s,s,s,s,s,s,sw,s,s,n,s,s,s,se,se,s,s,sw,s,se,se,se,s,n,s,s,se,s,se,se,se,se,ne,s,n,sw,se,se,se,se,se,s,se,nw,nw,se,se,se,se,se,se,se,n,ne,se,s,se,se,se,ne,se,nw,se,se,s,ne,se,n,se,se,ne,sw,se,ne,se,se,se,nw,nw,ne,se,se,s,n,n,se,se,ne,se,ne,se,se,ne,se,se,ne,ne,ne,ne,ne,se,ne,se,nw,se,se,s,s,se,ne,ne,se,ne,ne,ne,ne,ne,ne,nw,ne,ne,ne,s,ne,n,ne,se,ne,n,ne,nw,n,ne,n,ne,ne,ne,ne,ne,n,nw,ne,ne,ne,ne,s,ne,ne,s,ne,ne,n,n,se,n,ne,n,ne,nw,ne,s,ne,n,ne,ne,ne,n,ne,s,s,ne,ne,ne,ne,ne,nw,ne,n,ne,ne,ne,n,ne,ne,n,ne,ne,n,n,ne,ne,ne,n,s,n,s,ne,ne,n,n,n,n,n,n,n,n,ne,n,n,sw,n,n,n,nw,n,ne,ne,sw,n,n,n,s,n,n,n,n,n,n,n,n,n,nw,se,n,s,s,n,n,n,ne,n,n,nw,n,n,nw,nw,n,n,nw,nw,n,nw,n,n,n,n,se,nw,n,nw,n,nw,nw,n,n,nw,nw,n,nw,n,n,nw,nw,n,nw,ne,n,n,n,n,nw,nw,nw,n,nw,n,nw,s,nw,n,n,n,n,nw,nw,n,n,nw,n,nw,nw,se,nw,ne,n,n,ne,n,nw,nw,n,n,n,nw,n,nw,n,n,nw,ne,nw,s,n,ne,n,nw,n,nw,nw,n,nw,n,n,nw,nw,nw,n,n,nw,nw,nw,nw,nw,n,nw,n,sw,n,n,nw,nw,nw,nw,s,nw,s,nw,nw,nw,n,nw,nw,nw,se,s,nw,nw,sw,nw,nw,n,se,ne,nw,nw,nw,sw,sw,ne,nw,nw,nw,nw,nw,nw,s,nw,nw,nw,nw,nw,sw,nw,nw,nw,s,nw,nw,se,nw,nw,nw,nw,sw,nw,ne,nw,nw,nw,nw,s,nw,nw,nw,nw,nw,n,nw,sw,sw,n,nw,nw,sw,nw,nw,sw,sw,se,nw,nw,nw,s,sw,nw,se,nw,sw,se,n,sw,sw,nw,sw,nw,nw,nw,nw,nw,ne,nw,nw,sw,nw,nw,nw,nw,sw,nw,sw,n,nw,nw,sw,nw,sw,sw,nw,sw,nw,nw,sw,sw,sw,sw,nw,ne,sw,nw,sw,sw,sw,sw,nw,sw,nw,sw,sw,sw,nw,sw,nw,nw,nw,sw,nw,sw,sw,sw,sw,sw,sw,nw,sw,n,sw,sw,sw,ne,sw,ne,sw,sw,nw,nw,sw,nw,sw,sw,sw,nw,sw,sw,s,sw,sw,ne,ne,s,sw,n,nw,sw,nw,ne,ne,se,sw,sw,sw,nw,nw,sw,nw,sw,n,sw,nw,s,sw,sw,sw,n,nw,sw,sw,ne,sw,sw,s,sw,se,s,sw,ne,s,sw,sw,sw,sw,sw,sw,sw,sw,sw,nw,n,n,sw,sw,ne,sw,sw,sw,n,sw,se,sw,sw,nw,n,sw,n,s,s,s,sw,sw,s,nw,sw,n,sw,sw,sw,sw,sw,sw,sw,sw,nw,sw,s,ne,n,sw,sw,sw,sw,sw,sw,sw,ne,sw,sw,s,sw,sw,s,sw,sw,sw,s,nw,s,sw,n,sw,sw,s,s,sw,s,sw,sw,ne,s,sw,s,sw,sw,n,n,s,sw,sw,sw,s,sw,s,s,sw,se,sw,sw,n,s,sw,sw,n,s,sw,sw,s,sw,sw,sw,s,sw,sw,se,sw,sw,sw,nw,s,sw,s,sw,sw,sw,s,sw,sw,n,s,s,s,s,ne,sw,sw,s,sw,s,s,sw,se,sw,nw,sw,sw,n,n,sw,n,s,s,se,s,sw,s,sw,s,s,ne,se,sw,s,se,sw,s,s,s,s,s,ne,se,sw,sw,sw,sw,nw,s,s,s,sw,s,s,se,sw,s,s,sw,n,sw,ne,n,s,sw,s,sw,s,s,s,s,sw,sw,se,sw,sw,s,s,s,s,sw,s,n,n,nw,nw,sw,se,s,sw,sw,sw,s,s,s,s,s,s,s,s,sw,se,s,n,n,s,s,s,s,s,s,ne,n,s,s,sw,s,s,s,s,s,sw,se,se,s,ne,sw,s,s,nw,s,sw,s,n,nw,sw,s,s,s,s,sw,s,s,sw,s,s,sw,s,s,s,s,s,s,sw,s,s,s,s,s,sw,s,s,n,s,s,ne,s,s,s,s,s,s,sw,n,s,s,s,ne,s,s,s,s,n,ne,s,s,s,s,s,s,n,sw,s,nw,s,s,s,se,s,s,s,n,s,s,sw,nw,nw,n,sw,s,s,s,s,s,s,s,s,se,s,se,n,s,se,s,nw,se,ne,s,s,s,s,s,se,s,s,nw,s,se,s,s,sw,se,s,se,s,s,n,s,s,s,s,s,s,s,se,se,se,nw,se,se,se,se,s,se,nw,s,s,s,s,ne,nw,se,s,s,n,s,s,se,ne,s,s,n,s,s,nw,se,n,nw,ne,ne,se,s,ne,se,se,s,s,ne,s,s,ne,s,s,se,n,se,se,s,s,n,se,s,se,s,se,nw,se,s,sw,s,ne,s,s,s,sw,se,s,s,se,s,s,se,se,s,se,sw,se,s,se,ne,s,sw,se,se,s,se,se,se,ne,s,n,s,n,se,ne,s,ne,s,n,s,ne,sw,ne,s,s,nw,s,sw,se,s,se,s,se,s,se,se,nw,s,se,se,n,sw,s,se,se,se,se,s,nw,n,se,s,s,s,s,s,se,se,s,se,se,se,nw,s,se,se,se,se,se,s,s,s,se,s,se,n,s,se,s,se,se,se,se,ne,s,s,se,s,s,se,s,se,s,se,nw,nw,s,se,se,s,ne,s,ne,se,nw,n,se,sw,se,s,n,se,se,s,s,se,se,se,se,s,se,ne,se,se,s,se,ne,sw,sw,nw,se,n,s,ne,se,se,se,s,se,sw,s,nw,se,se,se,se,se,nw,se,se,sw,se,se,se,sw,se,ne,se,se,ne,s,se,se,se,se,se,se,n,s,ne,se,s,s,se,se,se,se,se,se,se,se,se,se,se,se,se,se,se,se,se,s,ne,se,s,se,ne,se,se,se,s,ne,se,se,se,ne,n,s,se,se,se,se,se,se,se,s,se,se,s,se,se,ne,se,ne,ne,se,se,se,sw,se,se,ne,se,se,n,se,se,se,se,se,sw,se,se,se,nw,se,se,se,se,se,se,se,se,se,ne,se,se,se,se,se,se,se,se,se,se,se,n,se,ne,se,nw,se,ne,se,s,s,se,se,se,se,se,se,s,se,se,se,ne,se,se,nw,s,ne,se,s,ne,se,n,s,se,se,se,se,se,se,se,se,ne,se,se,se,se,se,se,se,n,ne,se,se,se,se,se,nw,se,ne,nw,se,se,se,ne,ne,se,se,nw,n,se,se,se,se,sw,se,nw,se,se,ne,se,se,se,se,sw,ne,se,n,se,se,se,se,n,se,se,se,ne,se,se,se,s,ne,se,se,sw,ne,se,se,se,ne,ne,n,n,s,se,ne,ne,sw,ne,n,se,ne,se,se,se,se,n,ne,sw,se,se,se,ne,se,n,nw,se,n,ne,ne,n,ne,ne,se,n,se,ne,s,se,ne,sw,se,s,se,ne,se,n,ne,ne,se,se,se,n,ne,sw,se,ne,sw,se,se,se,se,se,s,sw,ne,se,se,se,se,sw,se,se,se,se,sw,n,ne,n,se,se,s,ne,se,se,ne,ne,se,se,se,ne,se,ne,se,s,se,s,ne,se,n,n,se,se,nw,se,sw,se,n,s,se,se,sw,se,ne,ne,ne,s,se,se,ne,nw,se,ne,se,n,se,se,ne,ne,se,se,nw,se,ne,nw,ne,ne,ne,ne,ne,ne,ne,n,n,se,se,se,n,se,sw,se,n,se,ne,se,se,se,sw,se,ne,ne,ne,se,sw,se,se,n,se,se,ne,se,s,se,se,ne,ne,se,se,ne,se,se,ne,ne,ne,se,nw,se,se,se,ne,ne,se,se,s,nw,s,ne,se,se,se,se,ne,se,se,se,sw,ne,ne,ne,ne,ne,ne,ne,se,se,s,ne,s,se,se,nw,ne,sw,sw,ne,ne,se,ne,ne,se,se,ne,ne,ne,ne,sw,ne,ne,ne,ne,n,ne,ne,se,ne,sw,n,se,ne,ne,s,se,se,n,nw,se,ne,se,ne,ne,nw,ne,se,s,ne,ne,nw,se,ne,se,s,se,nw,ne,se,se,n,ne,se,ne,ne,se,se,sw,ne,se,ne,se,sw,se,n,ne,se,ne,se,ne,nw,ne,se,sw,ne,se,se,ne,sw,ne,ne,ne,ne,ne,ne,ne,n,ne,ne,n,ne,sw,ne,sw,ne,se,ne,ne,sw,ne,n,se,n,sw,ne,ne,s,ne,ne,ne,ne,ne,ne,ne,ne,ne,nw,se,ne,ne,ne,se,ne,s,n,ne,se,ne,ne,ne,ne,ne,ne,se,ne,ne,sw,ne,ne,se,n,ne,se,ne,ne,ne,nw,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,nw,ne,ne,ne,nw,ne,nw,sw,ne,sw,ne,se,s,ne,ne,ne,ne,ne,ne,se,ne,n,ne,ne,ne,ne,ne,sw,ne,ne,ne,ne,ne,sw,nw,se,se,ne,ne,sw,ne,n,ne,ne,ne,ne,s,ne,ne,ne,ne,ne,ne,ne,ne,s,nw,ne,n,ne,ne,ne,s,ne,nw,ne,ne,ne,ne,ne,ne,ne,ne,ne,sw,ne,ne,ne,ne,n,ne,ne,ne,nw,ne,ne,ne,ne,ne,se,ne,se,ne,ne,ne,ne,ne,ne,ne,n,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,nw,ne,n,n,ne,n,ne,s,ne,ne,ne,ne,ne,n,ne,ne,ne,se,ne,s,sw,ne,ne,ne,ne,ne,ne,ne,n,ne,ne,n,n,ne,ne,sw,n,ne,nw,n,s,n,ne,nw,nw,ne,se,nw,sw,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,se,ne,sw,n,ne,ne,n,ne,ne,ne,ne,ne,se,n,ne,s,ne,ne,ne,n,ne,ne,ne,ne,ne,s,ne,ne,nw,ne,ne,s,se,ne,ne,se,sw,s,ne,ne,ne,ne,ne,n,sw,nw,s,ne,n,ne,n,ne,ne,sw,ne,ne,ne,ne,se,n,ne,ne,ne,ne,ne,ne,ne,ne,sw,ne,n,n,s,nw,s,ne,n,n,ne,ne,sw,ne,ne,n,nw,n,nw,s,ne,se,ne,ne,n,ne,n,n,ne,ne,n,ne,sw,ne,n,n,s,ne,ne,n,nw,ne,n,ne,n,n,ne,n,ne,s,sw,n,ne,nw,n,ne,ne,ne,n,ne,nw,n,ne,ne,ne,n,ne,n,n,s,se,s,s,nw,ne,ne,ne,ne,ne,se,ne,se,ne,ne,s,n,n,ne,sw,n,ne,n,ne,ne,n,ne,ne,ne,n,ne,ne,ne,n,n,ne,n,ne,n,ne,ne,ne,n,sw,ne,n,ne,n,ne,n,ne,s,ne,n,nw,ne,ne,ne,n,ne,n,n,ne,sw,ne,ne,ne,ne,n,ne,n,s,ne,ne,n,ne,ne,n,ne,ne,n,ne,n,nw,s,ne,ne,n,n,ne,n,nw,n,s,ne,ne,n,se,n,s,n,ne,ne,ne,n,ne,ne,se,n,n,ne,ne,n,n,ne,ne,ne,ne,n,n,ne,n,n,n,s,se,n,n,n,n,ne,ne,ne,ne,ne,se,ne,n,n,s,ne,ne,n,ne,ne,s,se,ne,se,n,n,ne,ne,s,n,n,se,ne,s,ne,s,ne,sw,n,ne,n,n,s,ne,ne,ne,ne,ne,ne,n,n,ne,ne,n,ne,ne,se,s,n,ne,nw,n,ne,nw,n,ne,n,ne,n,n,ne,n,n,n,n,n,ne,n,n,ne,ne,n,n,se,sw,ne,ne,ne,nw,ne,n,sw,ne,s,ne,n,sw,ne,n,n,n,n,n,ne,ne,n,ne,ne,ne,n,n,ne,n,ne,n,ne,s,sw,n,n,ne,ne,ne,n,sw,s,ne,n,se,s,n,n,ne,n,se,n,ne,ne,sw,se,n,ne,n,ne,ne,n,n,n,ne,nw,ne,s,n,n,ne,ne,se,ne,se,nw,nw,nw,sw,n,ne,n,n,n,n,n,n,s,n,nw,n,ne,ne,n,ne,ne,n,ne,s,n,n,ne,sw,n,ne,n,n,n,ne,nw,n,ne,sw,n,n,n,ne,n,ne,n,ne,n,n,ne,n,n,s,n,ne,ne,se,ne,n,n,n,n,nw,n,n,n,n,n,s,n,n,n,n,n,n,ne,se,n,sw,n,n,n,n,ne,n,n,n,n,n,n,n,sw,n,ne,ne,s,n,n,ne,n,n,n,n,n,nw,n,sw,n,n,n,n,n,se,n,n,n,n,n,ne,n,n,n,s,n,n,ne,n,n,n,n,se,n,n,n,ne,n,n,n,n,n,n,n,ne,n,n,n,n,n,ne,s,n,se,n,n,n,n,ne,n,sw,n,n,nw,n,ne,n,se,n,ne,ne,n,n,ne,n,s,n,n,n,n,s,n,nw,n,n,n,nw,n,n,s,n,n,n,sw,n,n,n,ne,n,ne,n,s,n,n,n,n,ne,n,n,n,n,n,n,n,n,sw,n,n,n,s,n,s,nw,n,sw,n,se,se,nw,n,n,n,se,n,ne,n,n,ne,n,n,ne,n,ne,n,n,n,n,n,n,se,se,n,se,nw,s,n,n,sw,n,n,n,n,n,n,n,nw,n,nw,n,n,n,n,se,sw,n,n,n,n,n,n,s,n,n,s,n,n,n,n,n,n,n,se,n,n,n,n,n,se,n,n,n,n,ne,n,s,n,n,n,n,n,se,n,n,n,se,n,n,n,n,n,n,n,se,ne,n,n,n,n,n,n,n,n,nw,sw,n,se,n,se,n,se,nw,s,n,nw,sw,n,nw,se,n,nw,n,n,n,n,n,nw,ne,n,ne,n,n,n,n,n,sw,n,n,sw,nw,n,se,n,n,n,se,n,ne,ne,n,n,n,n,n,sw,n,n,n,n,nw,s,ne,n,sw,n,n,n,n,n,n,n,nw,n,n,nw,n,n,n,n,n,n,n,n,sw,ne,n,s,n,n,n,nw,n,nw,n,se,n,n,nw,n,n,n,n,nw,se,n,n,nw,ne,n,n,sw,sw,n,nw,n,se,n,n,se,n,n,n,n,ne,nw,nw,n,sw,nw,n,ne,ne,n,n,n,n,n,nw,n,n,n,n,nw,n,sw,sw,n,se,sw,n,nw,n,n,n,nw,nw,n,n,nw,n,nw,nw,nw,nw,n,n,n,n,n,nw,nw,nw,n,n,n,n,n,n,n,n,ne,nw,n,n,s,n,n,n,nw,nw,n,n,sw,n,n,n,n,n,n,n,n,se,ne,nw,n,nw,nw,s,s,nw,s,n,n,nw,nw,n,n,n,n,n,s,nw,n,ne,n,nw,s,n,nw,n,n,n,n,n,se,n,n,nw,n,n,nw,nw,n,n,nw,n,nw,n,nw,n,nw,nw,sw,n,nw,ne,n,n,n,n,n,n,n,sw,s,n,n,n,n,n,nw,nw,nw,nw,se,n,se,se,nw,nw,nw,nw,n,se,n,n,nw,nw,n,se,n,n,n,n,n,n,n,nw,nw,n,n,nw,s,ne,ne,n,n,n,n,s,nw,n,n,n,n,nw,sw,sw,nw,nw,nw,nw,nw,n,n,n,n,n,s,s,n,nw,n,n,n,n,n,nw,n,n,nw,nw,s,nw,n,n,nw,n,n,nw,nw,n,nw,n,nw,nw,sw,n,n,s,n,ne,n,s,n,n,n,n,nw,nw,n,n,n,n,n,nw,nw,n,nw,nw,n,nw,se,s,n,n,nw,sw,n,n,nw,nw,n,nw,n,s,nw,nw,nw,nw,ne,n,n,n,nw,n,n,s,nw,sw,sw,se,n,n,n,nw,se,nw,n,n,nw,nw,nw,n,nw,nw,ne,n,n,nw,n,n,nw,n,nw,n,ne,n,nw,se,sw,nw,nw,sw,n,n,n,n,n,n,n,n,n,n,n,n,nw,nw,se,n,nw,n,nw,nw,ne,ne,n,n,ne,nw,n,nw,nw,n,nw,n,n,nw,sw,nw,se,nw,sw,nw,nw,n,n,nw,n,nw,n,n,sw,sw,n,se,n,n,n,nw,n,n,nw,n,sw,se,sw,nw,n,sw,n,s,nw,nw,nw,n,n,nw,n,nw,nw,nw,nw,nw,nw,n,nw,nw,se,s,s,sw,n,nw,sw,nw,nw,n,n,n,nw,nw,nw,n,nw,nw,n,nw,nw,n,nw,nw,nw,nw,nw,nw,n,n,nw,nw,ne,s,nw,n,s,n,nw,nw,sw,nw,n,n,sw,nw,n,sw,ne,n,n,nw,se,sw,n,n,nw,n,ne,n,nw,se,s,s,n,nw,nw,n,nw,nw,n,n,n,n,sw,sw,nw,n,n,n,n,sw,s,se,n,nw,n,nw,nw,se,nw,n,ne,n,nw,n,ne,se,nw,nw,nw,n,sw,ne,n,n,nw,n,se,n,n,sw,nw,ne,n,nw,nw,nw,s,nw,nw,n,nw,ne,nw,nw,nw,n,se,nw,nw,n,nw,nw,nw,nw,n,nw,n,n,ne,n,sw,nw,n,n,nw,nw,nw,n,nw,s,n,nw,nw,nw,nw,se,n,n,nw,n,n,nw,s,ne,n,nw,n,s,se,nw,sw,nw,nw,nw,s,nw,nw,n,nw,n,se,s,nw,nw,nw,sw,n,nw,n,se,n,s,nw,nw,nw,n,nw,nw,n,n,sw,nw,nw,nw,n,nw,sw,nw,nw,s,se,nw,nw,nw,ne,s,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,n,n,nw,nw,nw,nw,nw,nw,n,nw,n,nw,nw,n,sw,nw,sw,nw,nw,n,n,n,nw,ne,nw,n,nw,nw,nw,n,nw,nw,nw,nw,nw,n,nw,n,nw,n,nw,n,nw,nw,nw,nw,nw,nw,nw,nw,ne,nw,nw,n,nw,sw,n,nw,nw,nw,nw,nw,nw,s,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,n,nw,nw,n,s,n,se,nw,nw,se,n,nw,ne,n,n,nw,nw,ne,nw,n,ne,nw,nw,n,n,ne,ne,sw,nw,nw,nw,n,sw,n,n,ne,nw,sw,nw,nw,nw,ne,se,sw,nw,ne,nw,nw,n,nw,nw,nw,nw,nw,ne,nw,n,s,nw,nw,nw,nw,nw,nw,ne,n,s,nw,n,nw,nw,s,n,nw,ne,s,nw,nw,nw,sw,nw,nw,nw,n,nw,nw,nw,n,n,nw,nw,nw,n,nw,n,sw,nw,nw,nw,nw,nw,n,n,nw,nw,nw,ne,s,nw,sw,nw,se,nw,nw,nw,n,nw,se,nw,ne,nw,nw,n,nw,se,nw,n,sw,sw,nw,se,nw,nw,nw,nw,n,nw,s,nw,n,nw,nw,se,nw,s,n,se,n,sw,nw,nw,nw,n,nw,ne,n,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,ne,nw,n,nw,nw,nw,s,sw,nw,nw,s,sw,nw,nw,nw,nw,nw,nw,nw,nw,n,se,nw,n,nw,nw,nw,nw,nw,nw,n,nw,nw,nw,nw,nw,sw,nw,se,nw,nw,nw,nw,nw,ne,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,s,nw,nw,nw,n,nw,nw,ne,nw,nw,nw,nw,nw,se,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,n,nw,se,nw,nw,n,s,s,nw,nw,n,nw,nw,nw,se,nw,nw,nw,ne,nw,se,nw,nw,nw,se,nw,nw,nw,s,se,n,nw,nw,nw,n,s,nw,nw,nw,nw,nw,n,nw,nw,ne,se,nw,nw,nw,nw,nw,nw,nw,nw,nw,ne,nw,ne,sw,sw,s,ne,nw,nw,nw,nw,n,nw,nw,se,nw,nw,nw,n,nw,nw,nw,nw,nw,nw,nw,s,sw,nw,nw,nw,nw,nw,n,nw,s,sw,nw,nw,nw,nw,nw,s,n,nw,nw,nw,nw,n,nw,nw,nw,nw,nw,sw,nw,sw,nw,se,sw,nw,ne,nw,sw,nw,ne,sw,nw,nw,nw,nw,nw,nw,sw,nw,nw,nw,sw,nw,sw,s,s,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,s,se,nw,nw,nw,nw,nw,n,ne,sw,nw,nw,nw,nw,nw,sw,nw,nw,ne,nw,nw,nw,nw,nw,nw,sw,nw,nw,nw,nw,sw,s,nw,nw,nw,ne,ne,nw,nw,nw,nw,nw,nw,sw,s,sw,se,nw,sw,ne,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,sw,sw,nw,nw,nw,nw,s,sw,sw,se,se,nw,nw,s,nw,nw,sw,n,sw,sw,nw,sw,nw,nw,nw,nw,n,nw,nw,ne,nw,n,nw,nw,nw,sw,nw,ne,s,sw,s,nw,nw,nw,n,sw,nw,nw,nw,nw,nw,se,nw,sw,nw,nw,se,nw,nw,ne,sw,nw,nw,sw,nw,nw,nw,nw,sw,nw,sw,s,nw,nw,nw,sw,nw,nw,nw,nw,nw,nw,ne,nw,n,nw,nw,nw,nw,nw,nw,nw,se,s,n,s,s,ne,nw,sw,nw,nw,sw,nw,nw,nw,nw,nw,nw,sw,nw,se,nw,nw,nw,nw,se,nw,n,nw,n,sw,nw,nw,sw,nw,nw,nw,nw,nw,nw,se,nw,nw,nw,nw,nw,ne,nw,nw,nw,sw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,sw,s,sw,nw,sw,nw,sw,nw,nw,nw,nw,nw,n,nw,nw,n,se,nw,sw,nw,nw,sw,se,s,nw,sw,sw,se,sw,nw,sw,sw,n,sw,nw,ne,nw,sw,nw,nw,sw,nw,sw,nw,nw,n,sw,sw,nw,nw,nw,sw,nw,sw,nw,n,nw,ne,nw,nw,nw,sw,s,nw,nw,se,n,nw,nw,nw,nw,sw,sw,ne,sw,nw,sw,nw,se,sw,nw,nw,nw,sw,n,sw,sw,sw,nw,ne,sw,sw,nw,nw,sw,se,nw,nw,se,nw,s,ne,sw,s,s,nw,nw,nw,nw,nw,nw,nw,n,nw,ne,sw,sw,sw,sw,s,sw,sw,nw,nw,nw,nw,nw,sw,ne,sw,nw,nw,ne,nw,sw,nw,nw,nw,sw,nw,nw,nw,nw,sw,nw,n,sw,nw,nw,nw,sw,s,sw,sw,nw,sw,n,nw,nw,nw,nw,nw,nw,nw,sw,nw,nw,sw,sw,nw,nw,nw,nw,s,sw,nw,s,n,nw,sw,sw,se,nw,nw,nw,nw,nw,nw,s,nw,nw,ne,nw,s,sw,sw,sw,nw,sw,sw,nw,nw,sw,se,sw,nw,nw,sw,sw,ne,nw,nw,nw,n,nw,sw,nw,nw,nw,nw,sw,sw,sw,nw,sw,sw,ne,nw,nw,nw,sw,nw,ne,sw,n,nw,nw,nw,nw,sw,nw,nw,sw,nw,nw,nw,sw,se,sw,nw,nw,nw,nw,nw,nw,sw,s,sw,sw,se,s,sw,ne,nw,ne,sw,sw,nw,nw,sw,sw,se,nw,n,nw,nw,nw,nw,sw,nw,ne,sw,n,sw,sw,sw,sw,se,se,sw,ne,sw,sw,nw,nw,sw,sw,sw,sw,nw,nw,nw,nw,sw,sw,nw,nw,sw,nw,nw,nw,nw,sw,sw,s,ne,sw,nw,sw,sw,sw,nw,n,nw,sw,nw,nw,nw,nw,sw,nw,sw,nw,nw,nw,se,sw,sw,sw,sw,s,ne,sw,sw,sw,sw,nw,sw,ne,ne,sw,nw,sw,nw,nw,se,sw,sw,nw,sw,nw,sw,n,sw,nw,nw,sw,sw,sw,sw,nw,sw,nw,sw,n,nw,s,sw,sw,sw,sw,sw,nw,se,s,sw,sw,sw,sw,sw,nw,sw,sw,nw,n,se,nw,sw,nw,nw,s,sw,nw,se,nw,sw,sw,s,s,nw,s,sw,nw,sw,nw,sw,sw,sw,sw,sw,nw,nw,nw,sw,sw,sw,n,s,se,sw,ne,s,sw,ne,sw,sw,nw,nw,sw,sw,sw,sw,sw,se,sw,nw,nw,se,sw,n,sw,s,nw,sw,sw,sw,nw,sw,se,ne,nw,sw,nw,sw,sw,sw,nw,sw,sw,sw,sw,nw,sw,sw,nw,nw,nw,n,sw,nw,nw,nw,s,nw,nw,nw,sw,s,se,sw,nw,sw,n,ne,se,nw,s,s,sw,se,s,sw,nw,sw,se,sw,sw,nw,nw,s,nw,n,nw,ne,nw,sw,sw,nw,sw,sw,n,nw,nw,s,ne,se,n,sw,n,nw,n,sw,ne,sw,nw,sw,sw,nw,ne,s,nw,nw,nw,nw,ne,sw,sw,se,nw,sw,sw,se,sw,nw,nw,sw,nw,sw,sw,nw,sw,sw,sw,sw,n,sw,nw,se,sw,s,ne,sw,sw,sw,sw,sw,se,sw,nw,ne,nw,sw,nw,ne,sw,se,sw,nw,nw,sw,nw,sw,ne,sw,ne,sw,nw,nw,nw,s,nw,n,sw,s,nw,nw,nw,nw,se,ne,sw,se,sw,sw,nw,sw,sw,nw,nw,ne,se,sw,nw,sw,se,nw,nw,nw,sw,s,sw,nw,sw,sw,nw,nw,sw,nw,nw,s,sw,sw,nw,sw,se,ne,sw,sw,se,s,nw,sw,sw,sw,nw,sw,nw,sw,sw,sw,nw,ne,nw,n,sw,se,n,sw,se,s,sw,nw,sw,sw,nw,s,sw,sw,nw,sw,sw,sw,ne,n,sw,s,ne,sw,sw,sw,sw,nw,sw,sw,sw,nw,sw,sw,sw,s,sw,sw,sw,nw,sw,sw,sw,sw,sw,nw,s,sw,nw,nw,n,sw,sw,sw,sw,nw,sw,sw,sw,sw,sw,sw,nw,nw,sw,nw,se,sw,nw,ne,nw,sw,nw,sw,sw,s,sw,nw,sw,sw,sw,nw,sw,sw,sw,nw,sw,nw,sw,ne,nw,ne,sw,nw,sw,sw,sw,nw,nw,nw,nw,sw,s,sw,nw,se,nw,sw,nw,sw,sw,sw,sw,sw,sw,sw,sw,nw,sw,s,nw,sw,sw,nw,nw,nw,sw,sw,sw,sw,sw,sw,ne,sw,se,sw,sw,nw,sw,ne,nw,sw,sw,nw,sw,n,s,nw,sw,sw,se,sw,n,nw,ne,nw,nw,sw,sw,sw,sw,sw,ne,ne,sw,sw,nw,nw,sw,nw,n,sw,sw,sw,nw,n,sw,n,sw,sw,s,nw,nw,ne,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,ne,nw,sw,s,sw,sw,s,nw,sw,sw,ne,nw,sw,sw,sw,nw,s,sw,sw,sw,sw,nw,sw,sw,sw,sw,nw,sw,sw,sw,sw,sw,sw,nw,sw,sw,nw,sw,sw,se,sw,sw,nw,sw,sw,se,se,sw,s,nw,sw,sw,nw,sw,se,sw,se,sw,s,sw,ne,nw,s,s,sw,sw,sw,sw,sw,sw,sw,nw,se,sw,s,sw,sw,sw,ne,sw,sw,nw,nw,nw,sw,nw,sw,s,sw,ne,sw,sw,sw,sw,nw,sw,sw,ne,nw,sw,nw,sw,sw,ne,sw,sw,sw,s,nw,sw,sw,nw,sw,sw,sw,sw,sw,ne,se,nw,sw,sw,s,n,ne,sw,sw,nw,sw,se,sw,sw,sw,sw,sw,ne,sw,sw,nw,sw,sw,sw,sw,sw,sw,sw,nw,sw,sw,sw,nw,sw,sw,sw,sw,nw,s,sw,se,sw,sw,sw,n,nw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,ne,sw,sw,sw,sw,sw,sw,sw,nw,nw,sw,sw,se,se,s,sw,ne,sw,sw,n,s,sw,sw,sw,sw,sw,sw,sw,sw,ne,se,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,n,nw,sw,ne,sw,nw,sw,sw,nw,sw,sw,sw,sw,n,sw,sw,sw,sw,nw,sw,sw,s,sw,sw,sw,sw,nw,sw,sw,sw,sw,sw,sw,sw,sw,nw,sw,sw,sw,sw,sw,sw,sw,s,sw,sw,sw,sw,se,sw,sw,sw,ne,sw,sw,sw,sw,se,sw,sw,s,se,sw,sw,sw,n,sw,sw,sw,sw,sw,sw,n,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,ne,sw,sw,sw,sw,ne,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,s,sw,sw,nw,sw,sw,ne,n,sw,sw,sw,sw,sw,sw,n,sw,sw,sw,sw,sw,sw,sw,sw,nw,n,nw,n,sw,nw,ne,se,se,se,s,se,s,sw,s,nw,s,s,s,s,se,se,nw,sw,sw,sw,s,s,s,sw,sw,n,se,sw,s,sw,sw,sw,sw,sw,sw,nw,sw,sw,nw,sw,nw,s,sw,s,nw,s,nw,nw,nw,s,nw,nw,nw,nw,nw,nw,n,ne,nw,sw,nw,n,sw,nw,nw,n,n,nw,n,nw,n,n,nw,n,sw,n,sw,n,ne,n,n,n,n,n,sw,n,n,n,se,n,se,n,n,ne,n,ne,se,n,ne,n,n,n,n,n,nw,s,ne,ne,n,ne,se,ne,ne,ne,ne,s,ne,n,ne,ne,se,s,ne,ne,se,ne,ne,n,n,ne,sw,s,n,ne,ne,ne,ne,ne,ne,ne,ne,ne,n,ne,ne,ne,ne,ne,sw,se,nw,se,s,ne,se,ne,se,ne,ne,ne,se,sw,ne,ne,ne,s,nw,ne,se,ne,se,ne,s,se,ne,se,se,ne,se,se,se,ne,nw,ne,se,ne,sw,se,se,ne,se,nw,se,se,se,ne,se,se,se,n,ne,ne,se,se,se,ne,se,se,se,nw,se,se,se,se,se,se,se,se,se,se,se,sw,se,se,sw,se,s,se,se,se,se,se,se,se,se,ne,se,se,se,se,nw,s,s,ne,se,se,se,sw,s,nw,s,se,s,s,s,se,s,nw,se,sw,sw,s,se,se,s,se,se,nw,se,s,se,s,se,s,s,s,s,se,se,s,s,s,s,se,se,se,sw,s,s,s,ne,ne,s,sw,sw,s,s,s,s,nw,s,nw,se,ne,s,se,s,ne,s,s,s,s,s,s,s,sw,s,s,sw,s,se,se,s,s,s,s,s,nw,s,se,s,s,sw,s,s,s,s,s,s,s,sw,s,s,s,s,s,s,s,s,se,s,nw,s,sw,s,s,sw,s,s,se,s,s,sw,s,s,sw,sw,sw,sw,s,sw,n,n,sw,ne,sw,sw,s,sw,ne,s,sw,nw,nw,s,s,sw,sw,sw,s,s,sw,s,sw,sw,sw,s,se,nw,s,s,sw,s,sw,sw,s,nw,sw,s,s,sw,sw,sw,sw,s,s,sw,sw,ne,sw,sw,s,se,sw,n,sw,se,sw,sw,s,sw,sw,sw,se,sw,sw,sw,sw,sw,s,n,s,n,sw,sw,sw,sw,nw,sw,sw,nw,sw,s,sw,sw,nw,ne,sw,sw,sw,sw,sw,sw,se,n,sw,sw,sw,nw,sw,sw,sw,sw,nw,sw,s,sw,sw,sw,sw,sw,sw,sw,se,n,nw,sw,ne,nw,ne,sw,sw,nw,nw,nw,sw,sw,sw,sw,sw,sw,sw,nw,sw,sw,n,nw,sw,sw,nw,sw,sw,sw,se,nw,s,sw,nw,s,n,nw,sw,sw,s,sw,sw,ne,sw,sw,nw,sw,n,sw,se,sw,nw,nw,nw,sw,nw,sw,sw,sw,ne,sw,nw,sw,n,nw,nw,sw,sw,sw,nw,nw,se,nw,nw,sw,se,sw,sw,nw,sw,sw,sw,nw,sw,nw,nw,sw,sw,sw,sw,sw,nw,nw,se,sw,ne,nw,sw,sw,sw,nw,n,sw,nw,sw,nw,ne,nw,nw,s,nw,nw,nw,sw,s,sw,sw,sw,nw,nw,n,nw,nw,nw,nw,nw,sw,sw,nw,n,nw,sw,sw,sw,se,sw,sw,nw,ne,nw,nw,n,nw,nw,nw,nw,nw,sw,nw,nw,nw,ne,nw,ne,nw,nw,sw,sw,nw,nw,nw,nw,nw,sw,nw,nw,nw,nw,nw,ne,nw,nw,nw,nw,nw,sw,sw,nw,se,se,sw,nw,nw,nw,nw,s,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,sw,nw,ne,nw,nw,ne,nw,sw,nw,nw,nw,nw,nw,nw,ne,nw,nw,nw,nw,nw,sw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,sw,nw,nw,nw,sw,n,nw,nw,n,nw,se,se,s,nw,nw,n,ne,nw,ne,nw,nw,n,nw,sw,nw,s,s,nw,nw,n,nw,nw,se,nw,n,n,nw,ne,n,nw,nw,n,n,n,sw,n,nw,nw,nw,nw,sw,n,se,nw,s,sw,n,nw,nw,n,nw,nw,nw,n,n,nw,ne,n,s,se,n,s,n,nw,n,se,ne,nw,sw,n,se,nw,nw,s,se,n,n,ne,sw,s,n,nw,nw,nw,sw,nw,n,nw,nw,s,nw,n,n,n,n,n,n,n,n,nw,n,s,nw,n,nw,n,n,nw,se,s,nw,n,ne,sw,nw,sw,nw,nw,nw,nw,n,n,nw,n,n,n,nw,n,n,s,n,sw,n,sw,ne,n,n,n,nw,nw,n,nw,n,nw,nw,n,nw,n,s,n,n,s,n,nw,sw,nw,sw,nw,n,se,nw,s,nw,s,n,se,n,nw,n,n,n,n,n,n,ne,n,ne,n,n,n,n,nw,nw,s,n,n,ne,n,ne,n,n,n,n,n,n,sw,nw,n,n,n,n,nw,n,n,nw,n,n,n,n,se,n,n,n,n,n,n,nw,n,n,n,ne,n,n,n,n,n,s,n,n,sw,n,n,n,se,n,n,se,n,sw,n,n,se,n,n,s,se,nw,n,n,n,n,n,n,n,n,n,n,ne,n,n,n,n,n,se,ne,n,n,n,n,n,n,n,n,ne,n,n,n,n,n,n,n,s,n,s,se,n,n,n,n,ne,ne,n,n,s,n,n,n,n,n,n,nw,n,n,ne,n,n,n,ne,n,n,sw,se,n,n,n,ne,s,n,ne,n,n,n,n,n,s,n,se,n,se,s,n,n,n,n,ne,n,n,n,n,sw,se,n,n,nw,sw,nw,ne,n,n,se,n,n,n,se,n,n,n,ne,n,n,sw,nw,n,n,ne,n,ne,ne,n,n,n,ne,n,n,n,sw,n,sw,se,n,n,ne,s,n,ne,ne,n,n,n,se,sw,n,n,ne,s,ne,ne,ne,ne,ne,n,n,n,n,n,n,nw,ne,n,n,n,ne,ne,ne,sw,n,n,n,n,n,n,ne,ne,n,n,n,n,n,n,ne,s,ne,ne,ne,n,ne,n,n,ne,ne,se,ne,n,nw,ne,ne,s,ne,ne,n,ne,n,n,ne,n,ne,n,n,ne,ne,ne,se,n,ne,ne,nw,ne,n,ne,ne,n,ne,n,ne,ne,n,se,n,n,ne,n,n,ne,ne,n,ne,n,ne,ne,nw,n,ne,ne,ne,n,ne,ne,ne,s,nw,ne,ne,n,ne,n,ne,n,ne,ne,ne,sw,s,n,ne,ne,ne,n,sw,ne,nw,se,nw,ne,ne,n,ne,n,ne,ne,ne,ne,ne,ne,sw,ne,ne,se,ne,n,ne,ne,n,n,ne,ne,ne,ne,ne,ne,n,ne,ne,n,ne,ne,ne,se,sw,sw,nw,ne,ne,n,ne,nw,ne,ne,ne,ne,ne,ne,se,nw,ne,ne,ne,ne,n,ne,ne,n,ne,ne,ne,n,sw,ne,ne,s,n,ne,nw,ne,n,ne,s,ne,ne,ne,ne,ne,ne,n,sw,ne,sw,sw,se,ne,n,ne,s,ne,ne,s,n,ne,ne,ne,ne,ne,n,ne,ne,ne,ne,ne,sw,ne,ne,ne,ne,ne,ne,sw,n,ne,ne,ne,se,n,ne,nw,ne,nw,se,ne,s,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,s,ne,ne,s,ne,ne,ne,se,ne,ne,nw,ne,sw,n,ne,ne,se,ne,sw,se,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,nw,ne,ne,ne,sw,ne,ne,ne,ne,ne,ne,ne,ne,s,ne,se,ne,ne,se,ne,ne,s,ne,ne,ne,ne,ne,ne,se,ne,ne,ne,sw,ne,ne,se,se,ne,ne,se,ne,se,nw,ne,ne,ne,ne,ne,se,ne,ne,ne,se,ne,ne,ne,ne,se,se,ne,se,ne,s,n,s,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,se,se,s,ne,n,se,ne,ne,ne,se,n,n,ne,se,nw,n,ne,ne,s,nw,ne,ne,se,ne,s,se,ne,se,ne,ne,ne,ne,ne,sw,n,ne,ne,ne,ne,ne,ne,ne,se,ne,ne,ne,s,ne,ne,ne,ne,se,se,se,ne,se,se,ne,ne,se,ne,ne,se,se,ne,ne,se,ne,s,ne,n,ne,ne,se,se,ne,n,ne,nw,se,ne,se,se,n,ne,s,se,ne,se,ne,se,se,se,se,se,se,sw,se,se,se,ne,sw,ne,ne,ne,ne,ne,nw,ne,se,s,se,ne,se,se,se,ne,sw,ne,se,ne,se,nw,se,ne,n,se,se,sw,ne,ne,se,sw,ne,se,se,se,se,ne,ne,ne,se,se,ne,se,ne,se,ne,se,se,se,se,n,n,se,se,ne,ne,se,se,se,se,ne,ne,s,s,ne,se,se,se,ne,sw,se,ne,se,sw,ne,ne,se,se,nw,se,ne,nw,ne,se,se,ne,se,se,ne,ne,se,se,sw,se,se,n,se,se,ne,se,ne,se,se,se,ne,se,n,se,se,ne,se,ne,ne,se,ne,se,se,se,se,s,se,sw,se,se,se,ne,se,ne,se,ne,ne,se,s,ne,ne,se,se,se,se,s,se,se,ne,se,ne,se,se,se,ne,se,s,ne,se,se,ne,se,ne,se,se,ne,se,se,n,se,s,ne,ne,se,se,ne,s,se,se,nw,n,ne,ne,se,ne,sw,ne,s,s,sw,sw,ne,se,se,n,nw,se,n,se,n,ne,se,ne,se,se,nw,ne,se,se,ne,nw,se,se,ne,se,sw,ne,ne,se,se,se,se,se,se,s,se,ne,se,se,se,nw,se,se,n,se,se,ne,sw,se,se,se,se,se,ne,se,nw,nw,ne,se,se,se,se,ne,s,se,se,sw,se,se,se,se,n,n,se,se,n,se,se,se,se,n,se,se,se,n,se,ne,se,ne,nw,se,n,se,ne,se,se,se,se,se,se,se,se,nw,se,se,se,n,se,se,se,se,ne,se,se,se,se,se,se,n,nw,ne,ne,se,se,ne,sw,se,sw,se,se,se,ne,se,n,n,nw,se,se,sw,n,se,s,s,se,se,se,se,se,se,nw,se,sw,ne,se,s,se,se,se,se,se,ne,se,s,se,n,se,se,se,se,se,se,ne,se,sw,se,sw,se,se,se,se,se,se,se,ne,s,se,se,n,n,se,se,se,se,se,se,se,se,se,se,nw,s,se,se,nw,se,n,se,nw,se,s,sw,se,se,se,nw,se,sw,se,se,s,ne,se,se,se,se,se,sw,se,se,se,se,se,se,se,se,ne,ne,se,nw,s,se,se,se,s,se,se,se,se,se,se,se,se,se,se,nw,s,n,se,se,se,se,nw,se,se,se,se,se,se,se,ne,se,se,se,se,s,se,se,se,sw,nw,se,se,se,n,se,ne,se,se,se,se,se,se,se,sw,n,se,se,se,se,se,se,se,se,se,se,se,se,ne,se,se,se,se,se,se,se,se,ne,se,se,se,se,se,se,se,s,ne,ne,ne,se,ne,s,se,se,se,s,se,s,se,s,se,se,se,se,se,s,se,s,nw,se,se,se,sw,ne,s,se,ne,se,se,se,s,se,se,s,s,se,s,se,se,sw,n,se,ne,s,s,se,s,se,se,nw,se,s,se,n,ne,se,se,se,se,s,se,se,s,s,s,se,se,sw,s,se,se,s,n,se,n,se,se,ne,s,ne,se,se,s,se,se,ne,s,sw,sw,s,se,s,se,nw,se,ne,se,se,se,n,se,s,nw,se,n,se,s,se,se,se,s,s,se,se,se,s,se,se,se,s,se,se,s,se,s,se,se,se,se,se,se,se,s,se,s,se,s,se,n,s,se,se,se,se,s,se,se,se,se,nw,s,n,s,se,s,se,s,se,s,se,se,se,s,se,s,s,s,se,s,se,se,se,ne,se,se,nw,se,s,se,se,se,s,s,s,se,se,s,sw,ne,se,s,s,se,se,s,se,se,s,se,nw,s,s,se,se,nw,s,se,s,se,se,se,s,se,se,nw,se,n,se,se,se,se,ne,se,se,n,se,s,s,s,s,se,se,s,s,s,s,se,n,se,s,s,se,se,s,sw,se,s,ne,n,s,se,sw,se,se,n,sw,se,ne,se,s,se,s,se,se,se,nw,ne,se,se,se,se,s,s,se,se,s,se,se,s,s,ne,nw,s,s,nw,sw,sw,s,se,sw,nw,se,se,s,se,sw,s,s,ne,se,s,s,se,se,s,se,se,sw,se,se,s,se,s,se,s,s,s,s,nw,s,s,s,se,se,s,se,se,s,s,se,se,s,s,se,s,s,s,n,s,se,se,s,n,sw,s,se,se,s,se,s,s,s,s,se,se,s,s,sw,s,se,s,sw,s,s,s,s,se,n,s,se,se,s,se,s,se,s,s,s,s,se,se,se,ne,s,s,s,s,se,s,s,s,ne,s,s,nw,s,s,s,se,se,se,s,s,s,s,s,s,s,s,se,nw,se,se,s,s,se,s,s,se,se,s,s,s,se,s,s,se,s,se,s,se,s,s,s,se,s,s,n,se,s,s,ne,s,s,s,se,s,s,s,s,n,s,se,n,sw,se,se,s,s,s,s,se,s,s,s,s,s,se,se,se,s,s,s,s,ne,ne,s,s,se,s,s,se,s,se,s,se,sw,s,s,se,s,s,se,nw,s,s,s,s,s,s,se,se,s,s,ne,s,s,s,s,s,se,s,ne,s,s,s,s,s,s,s,se,s,s,se,s,s,s,sw,nw,s,se,n,se,s,s,s,ne,ne,s,s,s,s,s,se,s,s,s,s,s,s,n,s,s,s,s,s,ne,s,n,s,se,s,s,s,se,s,s,s,sw,s,se,s,nw,s,se,se,s,sw,s,s,s,se,s,s,s,sw,nw,s,se,se,s,s,s,s,n,nw,sw,s,s,nw,sw,s,n,se,sw,se,s,ne,s,s,ne,s,s,s,s,s,s,se,s,s,sw,s,se,s,s,nw,s,s,s,s,s,s,sw,s,s,s,s,s,s,s,s,s,s,s,s"
	set tMax=0
	set tDir("s")=0
	set tDir("n")=0
	set tDir("sw")=0
	set tDir("se")=0
	set tDir("nw")=0
	set tDir("ne")=0
	for i=1:1:$length(pInput,",") {
		set tDir($piece(pInput,",",i))=$G(tDir($piece(pInput,",",i)))+1
		set tTemp=##class(AOC.Y2017).Day11Eval(.tDir)
		If tTemp>tMax {
			set tMax=tTemp
		}
	}
	
	quit tMax
}

ClassMethod Day11Eval(ByRef pDir) As %String
{
	merge tDir=pDir
	If tDir("s")>tDir("n") {
		set tDir("s")=tDir("s")-tDir("n")
		set tDir("n")=0
	} Else {
		set tDir("n")=tDir("n")-tDir("s")
		set tDir("s")=0
	}
	
	if tDir("nw")>tDir("se") {
		set tDir("nw")=tDir("nw")-tDir("se")
		set tDir("se")=0
	} else {
		set tDir("se")=tDir("se")-tDir("nw")
		set tDir("nw")=0
	}
	
	if tDir("ne")>tDir("sw") {
		set tDir("ne")=tDir("ne")-tDir("sw")
		set tDir("sw")=0
	} else {
		set tDir("sw")=tDir("sw")-tDir("ne")
		set tDir("ne")=0	
	}
	
	if tDir("ne")>0 && tDir("nw")>0 {
		if tDir("ne")>tDir("nw") {
			set tDir("ne")=tDir("ne")-tDir("nw")
			
			If tDir("s")>tDir("n") {
				set tDir("s")=tDir("s")-tDir("nw")
			} Else {
				set tDir("n")=tDir("n")+tDir("nw")
			}
			
			set tDir("nw")=0
		} else {
			set tDir("nw")=tDir("nw")-tDir("ne")
			
			If tDir("s")>tDir("n") {
				set tDir("s")=tDir("s")-tDir("ne")
			} Else {
				set tDir("n")=tDir("n")+tDir("ne")
			}
			
			set tDir("ne")=0
		}
	} elseif tDir("se")>0 && tDir("sw")>0 {
		if tDir("se")>tDir("sw") {
			set tDir("se")=tDir("se")-tDir("sw")
			
			If tDir("s")>tDir("n") {
				set tDir("s")=tDir("s")+tDir("sw")
			} Else {
				set tDir("n")=tDir("n")-tDir("sw")
			}
			
			set tDir("sw")=0
		} else {
			set tDir("sw")=tDir("sw")-tDir("se")
			
			If tDir("s")>tDir("n") {
				set tDir("s")=tDir("s")+tDir("se")
			} Else {
				set tDir("n")=tDir("n")-tDir("se")
			}
			
			set tDir("se")=0
		}
	}
	
	if (tDir("nw")>0) && (tDir("sw")>0) {
		if tDir("nw")>tDir("sw") {
			if tDir("n")>tDir("s") {
				set tDir("n")=tDir("n")-tDir("sw")
				if tDir("n")<0 {
					set tDir("s")=$zabs(tDir("n"))
				}
			} else {
				set tDir("s")=tDir("s")+tDir("sw")
			}
			
			set tDir("nw")=tDir("nw")+tDir("sw")
			set tDir("sw")=0
		} else {
			if tDir("s")>tDir("n") {
				set tDir("s")=tDir("s")-tDir("nw")
				if tDir("s")<0 {
					set tDir("n")=$zabs(tDir("s"))
				}
			} else {
				set tDir("n")=tDir("n")+tDir("nw")
			}
			
			set tDir("sw")=tDir("sw")+tDir("nw")
			set tDir("nw")=0
		}
	}
	
	if (tDir("ne")>0) && (tDir("se")>0) {
		if tDir("ne")>tDir("se") {
			if tDir("n")>tDir("s") {
				set tDir("n")=tDir("n")-tDir("se")
				if tDir("n")<0 {
					set tDir("s")=$zabs(tDir("n"))
				}
			} else {
				set tDir("s")=tDir("s")+tDir("se")
			}
			
			set tDir("ne")=tDir("ne")+tDir("se")
			set tDir("se")=0
		} else {
			if tDir("s")>tDir("n") {
				set tDir("s")=tDir("s")-tDir("ne")
				if tDir("s")<0 {
					set tDir("n")=$zabs(tDir("s"))
				}
			} else {
				set tDir("n")=tDir("n")+tDir("ne")
			}
			
			set tDir("se")=tDir("se")+tDir("ne")
			set tDir("ne")=0
		}
	}
	
	quit $G(tDir("s"))+$G(tDir("n"))+$G(tDir("se"))+$G(tDir("nw"))+$G(tDir("sw"))+$G(tDir("ne"))
}

ClassMethod Day12P1(pInput = "") As %String
{
	set:pInput="" pInput="0<->1543@1<->66,1682@2<->1525@3<->958@4<->593,1542@5<->484@6<->297@7<->372,743,1965@8<->934@9<->1224,1489@10<->10,129,147,1394@11<->1244@12<->12,994,1954@13<->1027@14<->875,1211@15<->405@16<->1437,1476@17<->996@18<->216,777@19<->404,1524,1539,1941@20<->1365@21<->21,460,1431,1624@22<->313,530@23<->942,1125@24<->180,338@25<->771,1547,1561@26<->463,1012,1276,1760@27<->738@28<->311,1023,1461,1739,1853,1900@29<->1075@30<->355,467,1605@31<->1137,1740@32<->1125,1756@33<->658,1149,1790@34<->344,899@35<->337,716,1416,1780@36<->1641@37<->812@38<->86,1195@39<->1967@40<->1125,1550@41<->1881@42<->151@43<->222@44<->73,1075@45<->1865@46<->634,837,1143@47<->647@48<->695,901@49<->49@50<->1598,1619@51<->125,550,1161@52<->241,387,1951@53<->286,1414@54<->1231,1926@55<->437,1292,1919@56<->1108,1597@57<->1073,1205,1565@58<->555@59<->59,1410@60<->1735@61<->61@62<->149,525,1341@63<->356,1251@64<->146,1187@65<->1582@66<->1@67<->126,303,1942@68<->1135,1742@69<->1904@70<->70,371@71<->513@72<->1877@73<->44@74<->1617@75<->1495@76<->326,867@77<->420,961,1425@78<->1517@79<->1233@80<->415,1075,1354@81<->958,1089@82<->1677@83<->403@84<->85,1877@85<->84,260@86<->38,191,442@87<->969,1993@88<->610,1507@89<->151,758,1081,1521,1596@90<->474,1958@91<->950,1554,1949@92<->117,169@93<->1899@94<->819@95<->1886@96<->360,1626@97<->916,1146@98<->675,1502,1566@99<->384@100<->1905@101<->403,1387,1717@102<->196,1281@103<->947@104<->104@105<->975@106<->303,546,750@107<->380,1929@108<->108@109<->999,1059@110<->1617@111<->340@112<->112@113<->1063,1281,1758@114<->114@115<->631,1067,1904@116<->1036@117<->92,318@118<->1269@119<->898@120<->1052@121<->121@122<->1046@123<->1127@124<->717,1018@125<->51,535,639,709@126<->67,557,1060,1098,1640@127<->1286@128<->128@129<->10,1467@130<->492,1961@131<->1103,1433@132<->1191@133<->309,1049@134<->1361,1390@135<->683,1575@136<->702,1188@137<->290,302,1527@138<->656,975,1279@139<->882,1537,1542,1930@140<->1200@141<->562,680,1865@142<->1233@143<->653,1076@144<->1334@145<->145,1797@146<->64@147<->10,863,1090@148<->1138@149<->62,463@150<->1223,1228,1239@151<->42,89,404,694@152<->1389,1672@153<->1596@154<->1193@155<->980@156<->164@157<->157,1270@158<->272,1461@159<->777,1153@160<->595,1209@161<->365,686@162<->516,987@163<->546,1004,1056@164<->156,164@165<->165,1696@166<->310,370,397@167<->1446@168<->1900@169<->92,1680@170<->240,619,1088,1509@171<->186,1610@172<->1622,1698@173<->447,542,912@174<->669,1687@175<->689@176<->176,1816@177<->518,1422,1493@178<->479,731,1615,1718@179<->483@180<->24,180@181<->329,1941@182<->405,1175,1685@183<->291,466,558,891@184<->527@185<->185,868,1136@186<->171,867@187<->1622,1634@188<->211@189<->797@190<->1307,1504@191<->86,996@192<->1810@193<->315@194<->194,1198@195<->1401,1581,1904@196<->102@197<->539@198<->1996@199<->1601@200<->1617,1776@201<->294,390@202<->839,986@203<->1683@204<->546@205<->1673,1894@206<->1825@207<->207,222@208<->210,1679@209<->384,421,1249@210<->208,210,1721@211<->188,211,388,394,440,1205@212<->834,1857@213<->1102@214<->1803@215<->1033,1831@216<->18,1039@217<->1168,1983@218<->1273,1944@219<->845,1271@220<->321,640@221<->629@222<->43,207,285,1486,1508@223<->809,1371@224<->480@225<->904,1190,1378@226<->226@227<->1044,1294@228<->793,911@229<->1450,1940@230<->822@231<->321,352@232<->232@233<->491,543@234<->1880@235<->861,1349@236<->1738,1977@237<->590,1246,1805@238<->238,665@239<->577,818,877@240<->170@241<->52,241,946,1439,1441@242<->262,1226,1647,1661@243<->316,1117,1831@244<->345@245<->527,1392,1526@246<->1335@247<->1754,1842,1905@248<->1572@249<->1066,1185,1593@250<->934,1775,1821@251<->726,749@252<->252@253<->253@254<->1765@255<->753,1337@256<->411,1190@257<->1664,1731@258<->846@259<->450,1062,1975@260<->85,1097,1620@261<->662,1667@262<->242,1285,1641@263<->263@264<->1481@265<->470,1671@266<->971@267<->1002,1893@268<->393,1435@269<->413,806,1287,1525@270<->1182@271<->1377@272<->158,867@273<->273,499,568,845,1293@274<->800@275<->936@276<->925@277<->1295@278<->1085,1140@279<->873,883,989@280<->280@281<->1211@282<->445,674,1234@283<->771@284<->1874@285<->222,647,1092@286<->53,1191,1678@287<->595,1928@288<->947@289<->822,1836,1962@290<->137,1034,1735@291<->183@292<->331,1038@293<->1025@294<->201,630,1421@295<->1083,1366@296<->701,1187,1618@297<->6,990@298<->1093@299<->299@300<->846,1990@301<->1306@302<->137,1011@303<->67,106,1779@304<->1202@305<->439@306<->622,1858@307<->1379@308<->688,1631,1700@309<->133@310<->166,362@311<->28,933@312<->881@313<->22,549,678,1145@314<->1439@315<->193,650,1572@316<->243@317<->317,990,1638@318<->117,499@319<->1300,1309,1614@320<->633,1693@321<->220,231@322<->977,1722@323<->730,1372,1996@324<->755,1184@325<->1155,1857@326<->76@327<->1072,1814,1985@328<->1125,1279@329<->181@330<->936,1241@331<->292,1172@332<->1859,1882@333<->940@334<->468@335<->697,802@336<->437@337<->35,737@338<->24,1540@339<->493@340<->111,422,525@341<->1790@342<->496,1007@343<->343,1264@344<->34,344@345<->244,709@346<->553,1616@347<->909@348<->521,1660@349<->363,1294@350<->719,1782,1974@351<->405,915@352<->231,1694@353<->1140@354<->363,1339@355<->30@356<->63,771,1110@357<->1299,1347@358<->635@359<->1541@360<->96,360,1741@361<->361@362<->310@363<->349,354@364<->1827@365<->161,1734@366<->900@367<->1139,1545@368<->535@369<->1622@370<->166,1463@371<->70@372<->7,452,810,1283@373<->997,1658@374<->467,1774@375<->716,1841@376<->638,1079,1262@377<->606@378<->993@379<->379,791@380<->107@381<->475,1510@382<->780@383<->383@384<->99,209,1590@385<->1388@386<->1829@387<->52,1532,1874@388<->211,576,1281@389<->1309@390<->201,1183@391<->959,1944@392<->688,1062,1299@393<->268@394<->211,828,1701@395<->1587@396<->1082@397<->166@398<->1454,1508@399<->1007@400<->1531@401<->511,1140@402<->652,1065@403<->83,101,1585@404<->19,151@405<->15,182,351@406<->769@407<->1275,1578,1752@408<->1173@409<->409,432@410<->487,1334@411<->256@412<->412,590@413<->269@414<->1371@415<->80,1832@416<->939,1644@417<->562,1510@418<->536@419<->473@420<->77,1059,1535,1863@421<->209@422<->340,913,989@423<->854,951@424<->512@425<->1087@426<->773@427<->1121,1574@428<->745@429<->1669@430<->1018@431<->1377@432<->409@433<->1641,1999@434<->1605@435<->1412,1500@436<->879,1704@437<->55,336,548,1839,1987@438<->980,1399@439<->305,439,627,628,884,1241@440<->211@441<->677@442<->86@443<->1213@444<->592,845,1282@445<->282,1366@446<->710,797,1017,1974@447<->173,447,614@448<->1187,1511@449<->598,1000,1257@450<->259@451<->451,519@452<->372@453<->1549@454<->940@455<->926,1543,1706@456<->682,1253@457<->1694,1755@458<->549@459<->1192,1456,1613@460<->21,490@461<->1920@462<->788,1254,1695@463<->26,149@464<->945@465<->1654@466<->183@467<->30,374@468<->334,468@469<->1514@470<->265@471<->1190@472<->1911@473<->419,1230,1611,1711@474<->90,1253@475<->381,825@476<->476,503@477<->1337,1362@478<->1605@479<->178@480<->224,1810,1858@481<->871,1525@482<->1137,1457,1553@483<->179,1336@484<->5,1788@485<->1874@486<->986,1409@487<->410@488<->1911@489<->885,1867@490<->460@491<->233,1046,1880@492<->130,492@493<->339,810,1218@494<->1275@495<->1218,1396@496<->342,1445@497<->548@498<->729,1208,1590@499<->273,318,774@500<->521,673,1035@501<->504,978@502<->641@503<->476,615,1230,1374@504<->501@505<->505,1336@506<->1810@507<->1396@508<->603,1067,1794@509<->1714@510<->1441@511<->401,1497@512<->424,530@513<->71,513@514<->822,925,1603@515<->1575,1856@516<->162,1116,1634@517<->936@518<->177,1418,1862@519<->451@520<->1318,1621@521<->348,500@522<->569,674@523<->1438@524<->1181,1552@525<->62,340,1968@526<->981@527<->184,245,527,574,1767@528<->873@529<->945,1139@530<->22,512,1957@531<->531@532<->921,1071,1087,1989@533<->1845@534<->534,1929@535<->125,368@536<->418,702@537<->1442,1545@538<->552,1167@539<->197,1643@540<->1983@541<->1574@542<->173@543<->233@544<->1128@545<->903,989@546<->106,163,204@547<->1636,1916@548<->437,497,926@549<->313,458,1793@550<->51@551<->1756@552<->538,1061@553<->346,1564@554<->554@555<->58,792,1221@556<->1133,1881@557<->126,1222@558<->183@559<->1927@560<->797,1008,1048,1328,1984@561<->1294,1761@562<->141,417@563<->676,1763@564<->675,1220,1503@565<->565,1360@566<->1364@567<->618,1419@568<->273,1830@569<->522,1642@570<->778@571<->881,1353@572<->902,1699@573<->1679@574<->527,656@575<->718,1232@576<->388@577<->239@578<->1312@579<->1504,1970@580<->580@581<->1548,1893,1986,1993@582<->1228,1516,1729@583<->583,677,1178@584<->1231@585<->585@586<->1109,1646,1681@587<->1124,1237@588<->1004@589<->1756@590<->237,412@591<->591,692,1078@592<->444@593<->4,944@594<->1780,1911@595<->160,287@596<->969,1256@597<->830@598<->449@599<->1863@600<->1928@601<->1079@602<->1514@603<->508,1869@604<->848,1234@605<->605,952,1310@606<->377,638,880@607<->607,853,947,1453@608<->608,812@609<->1091,1430@610<->88@611<->1661@612<->675@613<->1409,1946@614<->447,1825,1992@615<->503@616<->616@617<->758,1813@618<->567,618,1068@619<->170@620<->1937@621<->734,1122@622<->306@623<->1340@624<->1644@625<->1926@626<->1362,1528@627<->439@628<->439@629<->221,1313@630<->294,1650@631<->115,1770,1849@632<->1958@633<->320,845,1445@634<->46,1024@635<->358,1355,1778@636<->1000,1120@637<->798,1009@638<->376,606,1244,1590@639<->125,849@640<->220@641<->502,779,1675@642<->740,1405,1473,1702@643<->930,1446@644<->801,1531,1886@645<->1062,1171,1595,1973@646<->1677,1751@647<->47,285@648<->1024,1691@649<->1743@650<->315,819,876@651<->1715,1909@652<->402,1777@653<->143@654<->868,1820@655<->875@656<->138,574@657<->725@658<->33,1038@659<->997@660<->1438,1449@661<->1359,1736@662<->261,1541@663<->896,981,1681@664<->1538,1639@665<->238,1105@666<->1036,1313@667<->920,1123@668<->668,1808@669<->174@670<->670@671<->767,1923@672<->1549,1564@673<->500@674<->282,522,1921,1953@675<->98,564,612,1260@676<->563,1838@677<->441,583@678<->313@679<->679@680<->141@681<->1850@682<->456@683<->135,1880@684<->1315@685<->1819,1966@686<->161,786,796,1801@687<->687,1557@688<->308,392@689<->175,1899@690<->952@691<->691@692<->591,1457,1662@693<->693@694<->151@695<->48,1436,1539,1702,1903@696<->696@697<->335,1130,1812,1823@698<->1064@699<->1269,1807@700<->755@701<->296@702<->136,536,702@703<->834,1333@704<->1583,1731@705<->1322@706<->991@707<->1083@708<->1382@709<->125,345,948@710<->446,1207,1770@711<->1831@712<->1663,1935@713<->1410@714<->968@715<->788@716<->35,375@717<->124,1265,1495,1639@718<->575@719<->350@720<->811@721<->1827@722<->722,1492,1650@723<->1967@724<->1059,1726@725<->657,725@726<->251@727<->1129@728<->1459@729<->498@730<->323,1617@731<->178@732<->1375@733<->953,1384@734<->621,1312,1911,1955@735<->1100,1117@736<->1180@737<->337@738<->27,738@739<->888@740<->642@741<->1132,1304,1680@742<->1615@743<->7,1766@744<->744@745<->428,857,969,1179,1180@746<->751@747<->1256@748<->1528@749<->251,912,1686@750<->106@751<->746,751@752<->1354,1498,1571@753<->255@754<->908,1066,1589@755<->324,700@756<->1013@757<->814@758<->89,617,1602@759<->1550@760<->1047@761<->970,1129@762<->1508@763<->1329@764<->765,1415@765<->764,1908@766<->1197,1595@767<->671@768<->1457@769<->406,852@770<->770,1427@771<->25,283,356@772<->1606,1823@773<->426,1836@774<->499@775<->1031,1733@776<->1035,1567@777<->18,159@778<->570,1994@779<->641@780<->382,1703,1928@781<->1647@782<->1367@783<->1454,1609,1785@784<->1243,1380@785<->1236@786<->686,1050,1413@787<->1026,1613@788<->462,715,1855@789<->789,1021,1186,1573@790<->1744@791<->379@792<->555,1041,1107@793<->228,1194@794<->864,1591,1612@795<->795,1478@796<->686,1652@797<->189,446,560@798<->637,1342@799<->799,1890@800<->274,800,1578@801<->644,1618,1732@802<->335@803<->803,1497@804<->804@805<->805@806<->269@807<->817,987@808<->1445@809<->223,1489@810<->372,493,1397@811<->720,1786@812<->37,608@813<->1410@814<->757,928,1201,1305@815<->1079,1443@816<->1563@817<->807,1614@818<->239,1135@819<->94,650@820<->820,1747@821<->827@822<->230,289,514@823<->1397@824<->899@825<->475@826<->1468,1696@827<->821,1238@828<->394,1459@829<->1372,1448@830<->597,1112@831<->831@832<->832@833<->833@834<->212,703,1913@835<->835@836<->1904@837<->46@838<->1512@839<->202,1510,1690@840<->842@841<->1430@842<->840,1397@843<->955,1303,1500,1845@844<->1221@845<->219,273,444,633,1434@846<->258,300@847<->847@848<->604,1960@849<->639,1126,1601@850<->1027,1818,1899@851<->1124,1536@852<->769,852,1551,1727@853<->607,1885@854<->423,1544@855<->1889@856<->981,1683@857<->745@858<->858,1041@859<->859,1465@860<->860,1288@861<->235,1133@862<->979,1255,1484@863<->147@864<->794@865<->865,902@866<->1033,1367@867<->76,186,272,1205@868<->185,654@869<->895@870<->1082@871<->481,1151@872<->872@873<->279,528@874<->1358,1787@875<->14,655@876<->650,1227@877<->239,1674@878<->878@879<->436,1786,1844@880<->606,1181@881<->312,571@882<->139@883<->279,1498,1746@884<->439@885<->489@886<->1592@887<->919@888<->739,1958@889<->1930@890<->1026,1326@891<->183,891@892<->1984@893<->1078@894<->1178,1329@895<->869,1863@896<->663@897<->1693@898<->119,1316@899<->34,824@900<->366,900@901<->48,1030@902<->572,865,973@903<->545@904<->225,1083@905<->1172,1274,1507@906<->1878@907<->1372@908<->754,1485,1923@909<->347,909@910<->1335,1621@911<->228,1077,1736@912<->173,749@913<->422,1688@914<->1232,1615@915<->351,1889@916<->97,1593@917<->1574@918<->1254,1829,1940@919<->887,1284,1392@920<->667,1480@921<->532,1296,1712@922<->922@923<->1194@924<->1931@925<->276,514@926<->455,548@927<->1241@928<->814@929<->1276,1645@930<->643@931<->1868@932<->1823@933<->311@934<->8,250,1416,1886@935<->1927@936<->275,330,517@937<->1692,1867@938<->1050@939<->416,1430@940<->333,454,1094,1980@941<->1698@942<->23,1642@943<->1102@944<->593,1365,1577@945<->464,529,945@946<->241,1037@947<->103,288,607,1095@948<->709,1217@949<->1960@950<->91,1862@951<->423@952<->605,690@953<->733,1894@954<->1113,1978,1988@955<->843@956<->956@957<->1122@958<->3,81@959<->391,1383,1711@960<->1280,1796@961<->77@962<->1509@963<->963,1788,1897@964<->1810@965<->1147@966<->1741@967<->1979@968<->714,968@969<->87,596,745,1082@970<->761,1495@971<->266,971@972<->972@973<->902,1398@974<->1862@975<->105,138,1118@976<->1369@977<->322,1970@978<->501,1270@979<->862,1244@980<->155,438,1072,1176@981<->526,663,856,1355@982<->1344@983<->1947@984<->1221@985<->1042@986<->202,486,1635@987<->162,807,1267@988<->988@989<->279,422,545,1128@990<->297,317,1891@991<->706,1229,1712@992<->1269@993<->378,1441@994<->12@995<->1693@996<->17,191@997<->373,659,1678@998<->1278@999<->109@1000<->449,636@1001<->1922@1002<->267@1003<->1989@1004<->163,588@1005<->1159,1247,1261@1006<->1218@1007<->342,399,1148@1008<->560@1009<->637,1129@1010<->1257@1011<->302@1012<->26,1184,1866,1937@1013<->756,1150@1014<->1014@1015<->1281@1016<->1720@1017<->446@1018<->124,430@1019<->1341@1020<->1369,1666@1021<->789@1022<->1022,1102,1675@1023<->28,1630@1024<->634,648@1025<->293,1263,1317@1026<->787,890@1027<->13,850@1028<->1334@1029<->1029,1147@1030<->901@1031<->775,1674@1032<->1720,1757,1764,1892@1033<->215,866,1189,1930@1034<->290,1988@1035<->500,776@1036<->116,666,1036,1707@1037<->946@1038<->292,658,1932@1039<->216@1040<->1867@1041<->792,858@1042<->985,1969,1998@1043<->1069@1044<->227@1045<->1045,1404@1046<->122,491,1046@1047<->760,1309@1048<->560,1316,1370@1049<->133,1936@1050<->786,938,1050@1051<->1371,1533@1052<->120,1106,1901@1053<->1489,1675@1054<->1075,1905@1055<->1543@1056<->163,1056@1057<->1525,1635,1870@1058<->1545@1059<->109,420,724,1781@1060<->126,1308@1061<->552,1065,1543,1594@1062<->259,392,645,1414@1063<->113,1520,1976@1064<->698,1254@1065<->402,1061,1496@1066<->249,754,1546@1067<->115,508@1068<->618@1069<->1043,1240,1461,1632@1070<->1266,1904@1071<->532,1514@1072<->327,980,1985@1073<->57@1074<->1833@1075<->29,44,80,1054@1076<->143,1778,1940@1077<->911@1078<->591,893,1629@1079<->376,601,815,1840@1080<->1144,1295,1330,1765@1081<->89@1082<->396,870,969,1498@1083<->295,707,904@1084<->1084@1085<->278@1086<->1659,1661@1087<->425,532@1088<->170@1089<->81,1089,1219,1913@1090<->147,1099@1091<->609,1579,1779@1092<->285@1093<->298,1520@1094<->940@1095<->947@1096<->1096@1097<->260@1098<->126,1682@1099<->1090@1100<->735@1101<->1848@1102<->213,943,1022@1103<->131@1104<->1783@1105<->665@1106<->1052,1106@1107<->792@1108<->56@1109<->586@1110<->356,1259@1111<->1133@1112<->830,1820@1113<->954@1114<->1114,1475@1115<->1115@1116<->516@1117<->243,735@1118<->975,1689@1119<->1235,1337,1474,1741,1994@1120<->636@1121<->427@1122<->621,957@1123<->667,1123@1124<->587,851,1250,1953@1125<->23,32,40,328@1126<->849,1429,1676@1127<->123,1998@1128<->544,989@1129<->727,761,1009,1691@1130<->697@1131<->1436,1719@1132<->741,1278@1133<->556,861,1111@1134<->1795,1956@1135<->68,818@1136<->185@1137<->31,482,1466@1138<->148,1953@1139<->367,529,1154@1140<->278,353,401,1608@1141<->1141@1142<->1690,1809@1143<->46,1495@1144<->1080,1580@1145<->313,1772@1146<->97@1147<->965,1029,1648@1148<->1007@1149<->33@1150<->1013,1417,1864@1151<->871,1990@1152<->1229,1572@1153<->159,1228@1154<->1139@1155<->325,1829@1156<->1650@1157<->1489@1158<->1472@1159<->1005@1160<->1467@1161<->51@1162<->1254@1163<->1331@1164<->1895@1165<->1165,1214,1345@1166<->1254@1167<->538@1168<->217,1223,1818@1169<->1169,1514,1761@1170<->1948@1171<->645@1172<->331,905@1173<->408,1535@1174<->1203,1238,1472@1175<->182,1817@1176<->980@1177<->1307,1463@1178<->583,894,1800,1971@1179<->745,1259@1180<->736,745@1181<->524,880@1182<->270,1216,1878@1183<->390@1184<->324,1012,1356@1185<->249@1186<->789@1187<->64,296,448,1377,1488@1188<->136,1320@1189<->1033,1823@1190<->225,256,471@1191<->132,286,1802@1192<->459@1193<->154,1193@1194<->793,923,1479@1195<->38,1766@1196<->1196,1470@1197<->766@1198<->194,1252@1199<->1199@1200<->140,1200@1201<->814,1802@1202<->304,1865@1203<->1174@1204<->1583@1205<->57,211,867,1331,1784,1819@1206<->1286@1207<->710@1208<->498@1209<->160,1209@1210<->1210,1599@1211<->14,281,1278@1212<->1289,1644@1213<->443,1714,1863@1214<->1165@1215<->1215@1216<->1182,1436@1217<->948,1377@1218<->493,495,1006@1219<->1089@1220<->564@1221<->555,844,984@1222<->557@1223<->150,1168@1224<->9@1225<->1323@1226<->242@1227<->876,1314@1228<->150,582,1153,1918@1229<->991,1152@1230<->473,503,1444,1945@1231<->54,584,1713@1232<->575,914,1232@1233<->79,142,1776@1234<->282,604@1235<->1119@1236<->785,1236@1237<->587,1751@1238<->827,1174,1417@1239<->150,1597,1852@1240<->1069,1769@1241<->330,439,927@1242<->1242@1243<->784,1541@1244<->11,638,979@1245<->1245@1246<->237,1330@1247<->1005,1598@1248<->1573@1249<->209,1522@1250<->1124@1251<->63@1252<->1198@1253<->456,474@1254<->462,918,1064,1162,1166@1255<->862@1256<->596,747@1257<->449,1010,1568,1837@1258<->1803@1259<->1110,1179@1260<->675@1261<->1005,1753@1262<->376,1318@1263<->1025,1887@1264<->343@1265<->717@1266<->1070@1267<->987,1368@1268<->1268@1269<->118,699,992,1939@1270<->157,978@1271<->219@1272<->1858@1273<->218@1274<->905@1275<->407,494@1276<->26,929@1277<->1919,1982@1278<->998,1132,1211@1279<->138,328,1852,1912@1280<->960@1281<->102,113,388,1015,1877@1282<->444@1283<->372,1562@1284<->919@1285<->262@1286<->127,1206,1286,1875@1287<->269@1288<->860,1736@1289<->1212,1321,1424@1290<->1319,1884,1959,1978@1291<->1291,1998@1292<->55@1293<->273,1995@1294<->227,349,561@1295<->277,1080,1570@1296<->921,1714@1297<->1297@1298<->1518,1733@1299<->357,392@1300<->319@1301<->1301@1302<->1912@1303<->843@1304<->741@1305<->814,1828@1306<->301,1610@1307<->190,1177@1308<->1060@1309<->319,389,1047@1310<->605@1311<->1463@1312<->578,734@1313<->629,666@1314<->1227,1980@1315<->684,1472@1316<->898,1048@1317<->1025@1318<->520,1262@1319<->1290@1320<->1188@1321<->1289,1737@1322<->705,1501@1323<->1225,1323@1324<->1720@1325<->1837@1326<->890@1327<->1470,1914@1328<->560@1329<->763,894@1330<->1080,1246@1331<->1163,1205@1332<->1332@1333<->703@1334<->144,410,1028,1854,1871,1925@1335<->246,910,1807@1336<->483,505@1337<->255,477,1119@1338<->1455,1810@1339<->354,1845@1340<->623,1627@1341<->62,1019,1841@1342<->798@1343<->1343@1344<->982,1344@1345<->1165,1369@1346<->1410,1643@1347<->357@1348<->1623@1349<->235,1991@1350<->1698@1351<->1669@1352<->1352@1353<->571,1519,1657@1354<->80,752@1355<->635,981@1356<->1184@1357<->1679@1358<->874,1838@1359<->661@1360<->565,1555@1361<->134@1362<->477,626@1363<->1459@1364<->566,1791@1365<->20,944,1465@1366<->295,445@1367<->782,866@1368<->1267@1369<->976,1020,1345@1370<->1048@1371<->223,414,1051@1372<->323,829,907@1373<->1373@1374<->503@1375<->732,1375@1376<->1376@1377<->271,431,1187,1217@1378<->225@1379<->307,1379,1507@1380<->784,1870@1381<->1381,1569@1382<->708,1839@1383<->959,1586@1384<->733,1716@1385<->1385@1386<->1386@1387<->101@1388<->385,1777@1389<->152@1390<->134,1669@1391<->1924@1392<->245,919@1393<->1904@1394<->10@1395<->1582@1396<->495,507,1622,1902@1397<->810,823,842@1398<->973@1399<->438,1670,1671@1400<->1400@1401<->195,1649@1402<->1402@1403<->1603@1404<->1045@1405<->642@1406<->1562,1668@1407<->1606@1408<->1408@1409<->486,613@1410<->59,713,813,1346@1411<->1666@1412<->435@1413<->786,1709@1414<->53,1062,1600@1415<->764,1558@1416<->35,934@1417<->1150,1238@1418<->518@1419<->567@1420<->1858@1421<->294@1422<->177@1423<->1668@1424<->1289@1425<->77@1426<->1870,1943@1427<->770@1428<->1428@1429<->1126@1430<->609,841,939,1826@1431<->21@1432<->1975@1433<->131@1434<->845,1487@1435<->268,1597@1436<->695,1131,1216@1437<->16,1910@1438<->523,660,1438@1439<->241,314@1440<->1714@1441<->241,510,993@1442<->537@1443<->815@1444<->1230@1445<->496,633,808@1446<->167,643,1526@1447<->1848@1448<->829,1709@1449<->660@1450<->229@1451<->1481,1527@1452<->1452@1453<->607@1454<->398,783@1455<->1338,1618@1456<->459@1457<->482,692,768,1512@1458<->1752@1459<->728,828,1363@1460<->1625@1461<->28,158,1069,1926@1462<->1462@1463<->370,1177,1311@1464<->1935@1465<->859,1365@1466<->1137@1467<->129,1160@1468<->826@1469<->1524@1470<->1196,1327@1471<->1799,1993@1472<->1158,1174,1315,1472,1502,1981@1473<->642@1474<->1119@1475<->1114,1513@1476<->16,1598@1477<->1477@1478<->795@1479<->1194@1480<->920@1481<->264,1451,1504,1952@1482<->1795@1483<->1984@1484<->862,1629@1485<->908@1486<->222@1487<->1434@1488<->1187@1489<->9,809,1053,1157,1490@1490<->1489@1491<->1872@1492<->722@1493<->177@1494<->1824@1495<->75,717,970,1143@1496<->1065@1497<->511,803@1498<->752,883,1082@1499<->1646@1500<->435,843@1501<->1322,1501,1753@1502<->98,1472@1503<->564@1504<->190,579,1481@1505<->1527@1506<->1939@1507<->88,905,1379@1508<->222,398,762@1509<->170,962,1509@1510<->381,417,839@1511<->448@1512<->838,1457@1513<->1475@1514<->469,602,1071,1169@1515<->1766@1516<->582@1517<->78,1555@1518<->1298@1519<->1353,1918@1520<->1063,1093@1521<->89@1522<->1249@1523<->1566@1524<->19,1469@1525<->2,269,481,1057@1526<->245,1446@1527<->137,1451,1505,1948@1528<->626,748,1771@1529<->1618@1530<->1530@1531<->400,644@1532<->387@1533<->1051,1725@1534<->1658,1696@1535<->420,1173,1867@1536<->851@1537<->139@1538<->664@1539<->19,695@1540<->338@1541<->359,662,1243@1542<->4,139@1543<->0,455,1055,1061,1604@1544<->854,1619@1545<->367,537,1058@1546<->1066@1547<->25@1548<->581,1917@1549<->453,672@1550<->40,759@1551<->852@1552<->524@1553<->482@1554<->91@1555<->1360,1517,1833@1556<->1869@1557<->687@1558<->1415@1559<->1559,1773@1560<->1693@1561<->25@1562<->1283,1406@1563<->816,1563,1768@1564<->553,672,1892@1565<->57,1665@1566<->98,1523,1907@1567<->776@1568<->1257,1998@1569<->1381@1570<->1295@1571<->752,1827@1572<->248,315,1152@1573<->789,1248,1772@1574<->427,541,917,1796,1882@1575<->135,515@1576<->1957@1577<->944@1578<->407,800@1579<->1091@1580<->1144@1581<->195@1582<->65,1395,1582@1583<->704,1204@1584<->1584@1585<->403,1889@1586<->1383@1587<->395,1587@1588<->1983@1589<->754@1590<->384,498,638@1591<->794@1592<->886,1608@1593<->249,916@1594<->1061@1595<->645,766@1596<->89,153@1597<->56,1239,1435@1598<->50,1247,1476@1599<->1210@1600<->1414@1601<->199,849@1602<->758@1603<->514,1403,1792@1604<->1543,1979@1605<->30,434,478,1961@1606<->772,1407@1607<->1607,1653@1608<->1140,1592@1609<->783@1610<->171,1306,1744@1611<->473@1612<->794,1859@1613<->459,787,1613@1614<->319,817,1616,1924@1615<->178,742,914@1616<->346,1614@1617<->74,110,200,730@1618<->296,801,1455,1529@1619<->50,1544@1620<->260@1621<->520,910,1748@1622<->172,187,369,1396@1623<->1348,1623@1624<->21@1625<->1460,1625,1936,1963@1626<->96@1627<->1340,1677@1628<->1628,1728@1629<->1078,1484@1630<->1023@1631<->308@1632<->1069@1633<->1669,1935@1634<->187,516@1635<->986,1057@1636<->547,1762@1637<->1637@1638<->317@1639<->664,717@1640<->126@1641<->36,262,433@1642<->569,942@1643<->539,1346,1745@1644<->416,624,1212,1931@1645<->929@1646<->586,1499,1687@1647<->242,781,1723@1648<->1147,1947@1649<->1401@1650<->630,722,1156,1869@1651<->1943@1652<->796@1653<->1607@1654<->465,1970@1655<->1987@1656<->1656@1657<->1353@1658<->373,1534@1659<->1086@1660<->348,1660@1661<->242,611,1086@1662<->692@1663<->712@1664<->257@1665<->1565@1666<->1020,1411,1887,1967@1667<->261@1668<->1406,1423@1669<->429,1351,1390,1633,1938@1670<->1399@1671<->265,1399@1672<->152,1684,1707@1673<->205@1674<->877,1031,1991@1675<->641,1022,1053,1920@1676<->1126@1677<->82,646,1627@1678<->286,997@1679<->208,573,1357@1680<->169,741@1681<->586,663,1811@1682<->1,1098@1683<->203,856,1817@1684<->1672,1927@1685<->182,1950@1686<->749@1687<->174,1646@1688<->913@1689<->1118@1690<->839,1142@1691<->648,1129@1692<->937@1693<->320,897,995,1560,1716@1694<->352,457@1695<->462@1696<->165,826,1534@1697<->1877@1698<->172,941,1350@1699<->572@1700<->308@1701<->394,1843@1702<->642,695,1861@1703<->780,1909@1704<->436@1705<->1906@1706<->455@1707<->1036,1672,1854@1708<->1708@1709<->1413,1448@1710<->1822@1711<->473,959@1712<->921,991@1713<->1231@1714<->509,1213,1296,1440,1999@1715<->651@1716<->1384,1693@1717<->101@1718<->178@1719<->1131@1720<->1016,1032,1324@1721<->210@1722<->322@1723<->1647@1724<->1724,1738@1725<->1533,1743@1726<->724@1727<->852@1728<->1628@1729<->582@1730<->1733,1935@1731<->257,704,1989@1732<->801@1733<->775,1298,1730,1762@1734<->365@1735<->60,290@1736<->661,911,1288,1749@1737<->1321@1738<->236,1724@1739<->28@1740<->31@1741<->360,966,1119@1742<->68@1743<->649,1725@1744<->790,1610@1745<->1643@1746<->883@1747<->820@1748<->1621@1749<->1736@1750<->1750@1751<->646,1237@1752<->407,1458@1753<->1261,1501@1754<->247@1755<->457,1855@1756<->32,551,589@1757<->1032@1758<->113@1759<->1848@1760<->26@1761<->561,1169@1762<->1636,1733@1763<->563@1764<->1032@1765<->254,1080@1766<->743,1195,1515@1767<->527@1768<->1563@1769<->1240@1770<->631,710@1771<->1528@1772<->1145,1573@1773<->1559@1774<->374@1775<->250@1776<->200,1233@1777<->652,1388@1778<->635,1076@1779<->303,1091@1780<->35,594@1781<->1059@1782<->350,1964@1783<->1104,1837,1879@1784<->1205@1785<->783@1786<->811,879,1786,1847@1787<->874,1829@1788<->484,963@1789<->1858@1790<->33,341@1791<->1364,1791@1792<->1603,1792,1868@1793<->549@1794<->508@1795<->1134,1482@1796<->960,1574@1797<->145@1798<->1798@1799<->1471@1800<->1178@1801<->686@1802<->1191,1201@1803<->214,1258,1819@1804<->1819@1805<->237@1806<->1973@1807<->699,1335@1808<->668,1898@1809<->1142,1987@1810<->192,480,506,964,1338@1811<->1681@1812<->697@1813<->617,1910@1814<->327@1815<->1953@1816<->176@1817<->1175,1683@1818<->850,1168@1819<->685,1205,1803,1804@1820<->654,1112@1821<->250@1822<->1710,1957@1823<->697,772,932,1189@1824<->1494,1848@1825<->206,614@1826<->1430@1827<->364,721,1571@1828<->1305@1829<->386,918,1155,1787@1830<->568@1831<->215,243,711@1832<->415,1832@1833<->1074,1555@1834<->1834@1835<->1835@1836<->289,773@1837<->1257,1325,1783@1838<->676,1358@1839<->437,1382,1872@1840<->1079@1841<->375,1341@1842<->247,1850@1843<->1701@1844<->879@1845<->533,843,1339@1846<->1870@1847<->1786,1972@1848<->1101,1447,1759,1824,1848,1873@1849<->631@1850<->681,1842@1851<->1851@1852<->1239,1279@1853<->28,1997@1854<->1334,1707@1855<->788,1755@1856<->515@1857<->212,325@1858<->306,480,1272,1420,1789@1859<->332,1612@1860<->1977@1861<->1702@1862<->518,950,974,1862@1863<->420,599,895,1213@1864<->1150@1865<->45,141,1202@1866<->1012@1867<->489,937,1040,1535@1868<->931,1792@1869<->603,1556,1650@1870<->1057,1380,1426,1846@1871<->1334@1872<->1491,1839,1959@1873<->1848@1874<->284,387,485@1875<->1286@1876<->1876,1908@1877<->72,84,1281,1697@1878<->906,1182@1879<->1783@1880<->234,491,683@1881<->41,556@1882<->332,1574,1882@1883<->1883@1884<->1290@1885<->853@1886<->95,644,934@1887<->1263,1666@1888<->1888@1889<->855,915,1585@1890<->799@1891<->990,1896@1892<->1032,1564@1893<->267,581@1894<->205,953@1895<->1164,1895@1896<->1891@1897<->963@1898<->1808,1915@1899<->93,689,850@1900<->28,168@1901<->1052@1902<->1396,1902@1903<->695@1904<->69,115,195,836,1070,1393@1905<->100,247,1054@1906<->1705,1971@1907<->1566,1934@1908<->765,1876@1909<->651,1703@1910<->1437,1813@1911<->472,488,594,734@1912<->1279,1302@1913<->834,1089@1914<->1327@1915<->1898@1916<->547@1917<->1548@1918<->1228,1519@1919<->55,1277@1920<->461,1675@1921<->674@1922<->1001,1922@1923<->671,908,1923@1924<->1391,1614,1958@1925<->1334@1926<->54,625,1461@1927<->559,935,1684@1928<->287,600,780@1929<->107,534@1930<->139,889,1033@1931<->924,1644@1932<->1038@1933<->1933@1934<->1907@1935<->712,1464,1633,1730@1936<->1049,1625@1937<->620,1012@1938<->1669,1938@1939<->1269,1506@1940<->229,918,1076@1941<->19,181@1942<->67@1943<->1426,1651@1944<->218,391@1945<->1230@1946<->613@1947<->983,1648@1948<->1170,1527@1949<->91@1950<->1685@1951<->52@1952<->1481,1952@1953<->674,1124,1138,1815@1954<->12@1955<->734@1956<->1134,1956@1957<->530,1576,1822@1958<->90,632,888,1924@1959<->1290,1872@1960<->848,949@1961<->130,1605@1962<->289@1963<->1625@1964<->1782@1965<->7@1966<->685@1967<->39,723,1666@1968<->525@1969<->1042@1970<->579,977,1654@1971<->1178,1906@1972<->1847@1973<->645,1806@1974<->350,446@1975<->259,1432@1976<->1063@1977<->236,1860@1978<->954,1290@1979<->967,1604@1980<->940,1314@1981<->1472@1982<->1277@1983<->217,540,1588@1984<->560,892,1483@1985<->327,1072@1986<->581@1987<->437,1655,1809@1988<->954,1034@1989<->532,1003,1731@1990<->300,1151@1991<->1349,1674@1992<->614@1993<->87,581,1471@1994<->778,1119@1995<->1293@1996<->198,323@1997<->1853@1998<->1042,1127,1291,1568@1999<->433,1714"

	for i=1:1:$length(pInput,"@") {
		set tBase=$piece($piece($piece(pInput,"@",i),"<->",1),"(",1)
		for j=1:1:$length($piece($piece(pInput,"@",i),"<->",2),",") {
			set tTemp=$piece($piece($piece(pInput,"@",i),"<->",2),",",j)
			continue:tTemp=""
			//w j,!
			//w $piece($piece(pInput,"@",i),"->",2),!
			set tArray(tBase,tTemp)=1
		}
	}
	
	quit ##class(AOC.Y2017).Day12P1Eval(.tArray,0)
}

ClassMethod Day12P1Eval(ByRef pArray, pBase, ByRef pVisited) As %String
{
	if $g(pVisited(pBase)) {
		quit 0
	}
	set pVisited(pBase)=1
	set tCount=0
	set tSub=$o(pArray(pBase,""))
	while tSub'="" {
		set tCount=tCount+##class(AOC.Y2017).Day12P1Eval(.pArray,tSub,.pVisited)
	set tSub=$o(pArray(pBase,tSub))
	}
	
	quit tCount+1
}

ClassMethod Day12P2(pInput = "") As %String
{
	set:pInput="" pInput="0<->1543@1<->66,1682@2<->1525@3<->958@4<->593,1542@5<->484@6<->297@7<->372,743,1965@8<->934@9<->1224,1489@10<->10,129,147,1394@11<->1244@12<->12,994,1954@13<->1027@14<->875,1211@15<->405@16<->1437,1476@17<->996@18<->216,777@19<->404,1524,1539,1941@20<->1365@21<->21,460,1431,1624@22<->313,530@23<->942,1125@24<->180,338@25<->771,1547,1561@26<->463,1012,1276,1760@27<->738@28<->311,1023,1461,1739,1853,1900@29<->1075@30<->355,467,1605@31<->1137,1740@32<->1125,1756@33<->658,1149,1790@34<->344,899@35<->337,716,1416,1780@36<->1641@37<->812@38<->86,1195@39<->1967@40<->1125,1550@41<->1881@42<->151@43<->222@44<->73,1075@45<->1865@46<->634,837,1143@47<->647@48<->695,901@49<->49@50<->1598,1619@51<->125,550,1161@52<->241,387,1951@53<->286,1414@54<->1231,1926@55<->437,1292,1919@56<->1108,1597@57<->1073,1205,1565@58<->555@59<->59,1410@60<->1735@61<->61@62<->149,525,1341@63<->356,1251@64<->146,1187@65<->1582@66<->1@67<->126,303,1942@68<->1135,1742@69<->1904@70<->70,371@71<->513@72<->1877@73<->44@74<->1617@75<->1495@76<->326,867@77<->420,961,1425@78<->1517@79<->1233@80<->415,1075,1354@81<->958,1089@82<->1677@83<->403@84<->85,1877@85<->84,260@86<->38,191,442@87<->969,1993@88<->610,1507@89<->151,758,1081,1521,1596@90<->474,1958@91<->950,1554,1949@92<->117,169@93<->1899@94<->819@95<->1886@96<->360,1626@97<->916,1146@98<->675,1502,1566@99<->384@100<->1905@101<->403,1387,1717@102<->196,1281@103<->947@104<->104@105<->975@106<->303,546,750@107<->380,1929@108<->108@109<->999,1059@110<->1617@111<->340@112<->112@113<->1063,1281,1758@114<->114@115<->631,1067,1904@116<->1036@117<->92,318@118<->1269@119<->898@120<->1052@121<->121@122<->1046@123<->1127@124<->717,1018@125<->51,535,639,709@126<->67,557,1060,1098,1640@127<->1286@128<->128@129<->10,1467@130<->492,1961@131<->1103,1433@132<->1191@133<->309,1049@134<->1361,1390@135<->683,1575@136<->702,1188@137<->290,302,1527@138<->656,975,1279@139<->882,1537,1542,1930@140<->1200@141<->562,680,1865@142<->1233@143<->653,1076@144<->1334@145<->145,1797@146<->64@147<->10,863,1090@148<->1138@149<->62,463@150<->1223,1228,1239@151<->42,89,404,694@152<->1389,1672@153<->1596@154<->1193@155<->980@156<->164@157<->157,1270@158<->272,1461@159<->777,1153@160<->595,1209@161<->365,686@162<->516,987@163<->546,1004,1056@164<->156,164@165<->165,1696@166<->310,370,397@167<->1446@168<->1900@169<->92,1680@170<->240,619,1088,1509@171<->186,1610@172<->1622,1698@173<->447,542,912@174<->669,1687@175<->689@176<->176,1816@177<->518,1422,1493@178<->479,731,1615,1718@179<->483@180<->24,180@181<->329,1941@182<->405,1175,1685@183<->291,466,558,891@184<->527@185<->185,868,1136@186<->171,867@187<->1622,1634@188<->211@189<->797@190<->1307,1504@191<->86,996@192<->1810@193<->315@194<->194,1198@195<->1401,1581,1904@196<->102@197<->539@198<->1996@199<->1601@200<->1617,1776@201<->294,390@202<->839,986@203<->1683@204<->546@205<->1673,1894@206<->1825@207<->207,222@208<->210,1679@209<->384,421,1249@210<->208,210,1721@211<->188,211,388,394,440,1205@212<->834,1857@213<->1102@214<->1803@215<->1033,1831@216<->18,1039@217<->1168,1983@218<->1273,1944@219<->845,1271@220<->321,640@221<->629@222<->43,207,285,1486,1508@223<->809,1371@224<->480@225<->904,1190,1378@226<->226@227<->1044,1294@228<->793,911@229<->1450,1940@230<->822@231<->321,352@232<->232@233<->491,543@234<->1880@235<->861,1349@236<->1738,1977@237<->590,1246,1805@238<->238,665@239<->577,818,877@240<->170@241<->52,241,946,1439,1441@242<->262,1226,1647,1661@243<->316,1117,1831@244<->345@245<->527,1392,1526@246<->1335@247<->1754,1842,1905@248<->1572@249<->1066,1185,1593@250<->934,1775,1821@251<->726,749@252<->252@253<->253@254<->1765@255<->753,1337@256<->411,1190@257<->1664,1731@258<->846@259<->450,1062,1975@260<->85,1097,1620@261<->662,1667@262<->242,1285,1641@263<->263@264<->1481@265<->470,1671@266<->971@267<->1002,1893@268<->393,1435@269<->413,806,1287,1525@270<->1182@271<->1377@272<->158,867@273<->273,499,568,845,1293@274<->800@275<->936@276<->925@277<->1295@278<->1085,1140@279<->873,883,989@280<->280@281<->1211@282<->445,674,1234@283<->771@284<->1874@285<->222,647,1092@286<->53,1191,1678@287<->595,1928@288<->947@289<->822,1836,1962@290<->137,1034,1735@291<->183@292<->331,1038@293<->1025@294<->201,630,1421@295<->1083,1366@296<->701,1187,1618@297<->6,990@298<->1093@299<->299@300<->846,1990@301<->1306@302<->137,1011@303<->67,106,1779@304<->1202@305<->439@306<->622,1858@307<->1379@308<->688,1631,1700@309<->133@310<->166,362@311<->28,933@312<->881@313<->22,549,678,1145@314<->1439@315<->193,650,1572@316<->243@317<->317,990,1638@318<->117,499@319<->1300,1309,1614@320<->633,1693@321<->220,231@322<->977,1722@323<->730,1372,1996@324<->755,1184@325<->1155,1857@326<->76@327<->1072,1814,1985@328<->1125,1279@329<->181@330<->936,1241@331<->292,1172@332<->1859,1882@333<->940@334<->468@335<->697,802@336<->437@337<->35,737@338<->24,1540@339<->493@340<->111,422,525@341<->1790@342<->496,1007@343<->343,1264@344<->34,344@345<->244,709@346<->553,1616@347<->909@348<->521,1660@349<->363,1294@350<->719,1782,1974@351<->405,915@352<->231,1694@353<->1140@354<->363,1339@355<->30@356<->63,771,1110@357<->1299,1347@358<->635@359<->1541@360<->96,360,1741@361<->361@362<->310@363<->349,354@364<->1827@365<->161,1734@366<->900@367<->1139,1545@368<->535@369<->1622@370<->166,1463@371<->70@372<->7,452,810,1283@373<->997,1658@374<->467,1774@375<->716,1841@376<->638,1079,1262@377<->606@378<->993@379<->379,791@380<->107@381<->475,1510@382<->780@383<->383@384<->99,209,1590@385<->1388@386<->1829@387<->52,1532,1874@388<->211,576,1281@389<->1309@390<->201,1183@391<->959,1944@392<->688,1062,1299@393<->268@394<->211,828,1701@395<->1587@396<->1082@397<->166@398<->1454,1508@399<->1007@400<->1531@401<->511,1140@402<->652,1065@403<->83,101,1585@404<->19,151@405<->15,182,351@406<->769@407<->1275,1578,1752@408<->1173@409<->409,432@410<->487,1334@411<->256@412<->412,590@413<->269@414<->1371@415<->80,1832@416<->939,1644@417<->562,1510@418<->536@419<->473@420<->77,1059,1535,1863@421<->209@422<->340,913,989@423<->854,951@424<->512@425<->1087@426<->773@427<->1121,1574@428<->745@429<->1669@430<->1018@431<->1377@432<->409@433<->1641,1999@434<->1605@435<->1412,1500@436<->879,1704@437<->55,336,548,1839,1987@438<->980,1399@439<->305,439,627,628,884,1241@440<->211@441<->677@442<->86@443<->1213@444<->592,845,1282@445<->282,1366@446<->710,797,1017,1974@447<->173,447,614@448<->1187,1511@449<->598,1000,1257@450<->259@451<->451,519@452<->372@453<->1549@454<->940@455<->926,1543,1706@456<->682,1253@457<->1694,1755@458<->549@459<->1192,1456,1613@460<->21,490@461<->1920@462<->788,1254,1695@463<->26,149@464<->945@465<->1654@466<->183@467<->30,374@468<->334,468@469<->1514@470<->265@471<->1190@472<->1911@473<->419,1230,1611,1711@474<->90,1253@475<->381,825@476<->476,503@477<->1337,1362@478<->1605@479<->178@480<->224,1810,1858@481<->871,1525@482<->1137,1457,1553@483<->179,1336@484<->5,1788@485<->1874@486<->986,1409@487<->410@488<->1911@489<->885,1867@490<->460@491<->233,1046,1880@492<->130,492@493<->339,810,1218@494<->1275@495<->1218,1396@496<->342,1445@497<->548@498<->729,1208,1590@499<->273,318,774@500<->521,673,1035@501<->504,978@502<->641@503<->476,615,1230,1374@504<->501@505<->505,1336@506<->1810@507<->1396@508<->603,1067,1794@509<->1714@510<->1441@511<->401,1497@512<->424,530@513<->71,513@514<->822,925,1603@515<->1575,1856@516<->162,1116,1634@517<->936@518<->177,1418,1862@519<->451@520<->1318,1621@521<->348,500@522<->569,674@523<->1438@524<->1181,1552@525<->62,340,1968@526<->981@527<->184,245,527,574,1767@528<->873@529<->945,1139@530<->22,512,1957@531<->531@532<->921,1071,1087,1989@533<->1845@534<->534,1929@535<->125,368@536<->418,702@537<->1442,1545@538<->552,1167@539<->197,1643@540<->1983@541<->1574@542<->173@543<->233@544<->1128@545<->903,989@546<->106,163,204@547<->1636,1916@548<->437,497,926@549<->313,458,1793@550<->51@551<->1756@552<->538,1061@553<->346,1564@554<->554@555<->58,792,1221@556<->1133,1881@557<->126,1222@558<->183@559<->1927@560<->797,1008,1048,1328,1984@561<->1294,1761@562<->141,417@563<->676,1763@564<->675,1220,1503@565<->565,1360@566<->1364@567<->618,1419@568<->273,1830@569<->522,1642@570<->778@571<->881,1353@572<->902,1699@573<->1679@574<->527,656@575<->718,1232@576<->388@577<->239@578<->1312@579<->1504,1970@580<->580@581<->1548,1893,1986,1993@582<->1228,1516,1729@583<->583,677,1178@584<->1231@585<->585@586<->1109,1646,1681@587<->1124,1237@588<->1004@589<->1756@590<->237,412@591<->591,692,1078@592<->444@593<->4,944@594<->1780,1911@595<->160,287@596<->969,1256@597<->830@598<->449@599<->1863@600<->1928@601<->1079@602<->1514@603<->508,1869@604<->848,1234@605<->605,952,1310@606<->377,638,880@607<->607,853,947,1453@608<->608,812@609<->1091,1430@610<->88@611<->1661@612<->675@613<->1409,1946@614<->447,1825,1992@615<->503@616<->616@617<->758,1813@618<->567,618,1068@619<->170@620<->1937@621<->734,1122@622<->306@623<->1340@624<->1644@625<->1926@626<->1362,1528@627<->439@628<->439@629<->221,1313@630<->294,1650@631<->115,1770,1849@632<->1958@633<->320,845,1445@634<->46,1024@635<->358,1355,1778@636<->1000,1120@637<->798,1009@638<->376,606,1244,1590@639<->125,849@640<->220@641<->502,779,1675@642<->740,1405,1473,1702@643<->930,1446@644<->801,1531,1886@645<->1062,1171,1595,1973@646<->1677,1751@647<->47,285@648<->1024,1691@649<->1743@650<->315,819,876@651<->1715,1909@652<->402,1777@653<->143@654<->868,1820@655<->875@656<->138,574@657<->725@658<->33,1038@659<->997@660<->1438,1449@661<->1359,1736@662<->261,1541@663<->896,981,1681@664<->1538,1639@665<->238,1105@666<->1036,1313@667<->920,1123@668<->668,1808@669<->174@670<->670@671<->767,1923@672<->1549,1564@673<->500@674<->282,522,1921,1953@675<->98,564,612,1260@676<->563,1838@677<->441,583@678<->313@679<->679@680<->141@681<->1850@682<->456@683<->135,1880@684<->1315@685<->1819,1966@686<->161,786,796,1801@687<->687,1557@688<->308,392@689<->175,1899@690<->952@691<->691@692<->591,1457,1662@693<->693@694<->151@695<->48,1436,1539,1702,1903@696<->696@697<->335,1130,1812,1823@698<->1064@699<->1269,1807@700<->755@701<->296@702<->136,536,702@703<->834,1333@704<->1583,1731@705<->1322@706<->991@707<->1083@708<->1382@709<->125,345,948@710<->446,1207,1770@711<->1831@712<->1663,1935@713<->1410@714<->968@715<->788@716<->35,375@717<->124,1265,1495,1639@718<->575@719<->350@720<->811@721<->1827@722<->722,1492,1650@723<->1967@724<->1059,1726@725<->657,725@726<->251@727<->1129@728<->1459@729<->498@730<->323,1617@731<->178@732<->1375@733<->953,1384@734<->621,1312,1911,1955@735<->1100,1117@736<->1180@737<->337@738<->27,738@739<->888@740<->642@741<->1132,1304,1680@742<->1615@743<->7,1766@744<->744@745<->428,857,969,1179,1180@746<->751@747<->1256@748<->1528@749<->251,912,1686@750<->106@751<->746,751@752<->1354,1498,1571@753<->255@754<->908,1066,1589@755<->324,700@756<->1013@757<->814@758<->89,617,1602@759<->1550@760<->1047@761<->970,1129@762<->1508@763<->1329@764<->765,1415@765<->764,1908@766<->1197,1595@767<->671@768<->1457@769<->406,852@770<->770,1427@771<->25,283,356@772<->1606,1823@773<->426,1836@774<->499@775<->1031,1733@776<->1035,1567@777<->18,159@778<->570,1994@779<->641@780<->382,1703,1928@781<->1647@782<->1367@783<->1454,1609,1785@784<->1243,1380@785<->1236@786<->686,1050,1413@787<->1026,1613@788<->462,715,1855@789<->789,1021,1186,1573@790<->1744@791<->379@792<->555,1041,1107@793<->228,1194@794<->864,1591,1612@795<->795,1478@796<->686,1652@797<->189,446,560@798<->637,1342@799<->799,1890@800<->274,800,1578@801<->644,1618,1732@802<->335@803<->803,1497@804<->804@805<->805@806<->269@807<->817,987@808<->1445@809<->223,1489@810<->372,493,1397@811<->720,1786@812<->37,608@813<->1410@814<->757,928,1201,1305@815<->1079,1443@816<->1563@817<->807,1614@818<->239,1135@819<->94,650@820<->820,1747@821<->827@822<->230,289,514@823<->1397@824<->899@825<->475@826<->1468,1696@827<->821,1238@828<->394,1459@829<->1372,1448@830<->597,1112@831<->831@832<->832@833<->833@834<->212,703,1913@835<->835@836<->1904@837<->46@838<->1512@839<->202,1510,1690@840<->842@841<->1430@842<->840,1397@843<->955,1303,1500,1845@844<->1221@845<->219,273,444,633,1434@846<->258,300@847<->847@848<->604,1960@849<->639,1126,1601@850<->1027,1818,1899@851<->1124,1536@852<->769,852,1551,1727@853<->607,1885@854<->423,1544@855<->1889@856<->981,1683@857<->745@858<->858,1041@859<->859,1465@860<->860,1288@861<->235,1133@862<->979,1255,1484@863<->147@864<->794@865<->865,902@866<->1033,1367@867<->76,186,272,1205@868<->185,654@869<->895@870<->1082@871<->481,1151@872<->872@873<->279,528@874<->1358,1787@875<->14,655@876<->650,1227@877<->239,1674@878<->878@879<->436,1786,1844@880<->606,1181@881<->312,571@882<->139@883<->279,1498,1746@884<->439@885<->489@886<->1592@887<->919@888<->739,1958@889<->1930@890<->1026,1326@891<->183,891@892<->1984@893<->1078@894<->1178,1329@895<->869,1863@896<->663@897<->1693@898<->119,1316@899<->34,824@900<->366,900@901<->48,1030@902<->572,865,973@903<->545@904<->225,1083@905<->1172,1274,1507@906<->1878@907<->1372@908<->754,1485,1923@909<->347,909@910<->1335,1621@911<->228,1077,1736@912<->173,749@913<->422,1688@914<->1232,1615@915<->351,1889@916<->97,1593@917<->1574@918<->1254,1829,1940@919<->887,1284,1392@920<->667,1480@921<->532,1296,1712@922<->922@923<->1194@924<->1931@925<->276,514@926<->455,548@927<->1241@928<->814@929<->1276,1645@930<->643@931<->1868@932<->1823@933<->311@934<->8,250,1416,1886@935<->1927@936<->275,330,517@937<->1692,1867@938<->1050@939<->416,1430@940<->333,454,1094,1980@941<->1698@942<->23,1642@943<->1102@944<->593,1365,1577@945<->464,529,945@946<->241,1037@947<->103,288,607,1095@948<->709,1217@949<->1960@950<->91,1862@951<->423@952<->605,690@953<->733,1894@954<->1113,1978,1988@955<->843@956<->956@957<->1122@958<->3,81@959<->391,1383,1711@960<->1280,1796@961<->77@962<->1509@963<->963,1788,1897@964<->1810@965<->1147@966<->1741@967<->1979@968<->714,968@969<->87,596,745,1082@970<->761,1495@971<->266,971@972<->972@973<->902,1398@974<->1862@975<->105,138,1118@976<->1369@977<->322,1970@978<->501,1270@979<->862,1244@980<->155,438,1072,1176@981<->526,663,856,1355@982<->1344@983<->1947@984<->1221@985<->1042@986<->202,486,1635@987<->162,807,1267@988<->988@989<->279,422,545,1128@990<->297,317,1891@991<->706,1229,1712@992<->1269@993<->378,1441@994<->12@995<->1693@996<->17,191@997<->373,659,1678@998<->1278@999<->109@1000<->449,636@1001<->1922@1002<->267@1003<->1989@1004<->163,588@1005<->1159,1247,1261@1006<->1218@1007<->342,399,1148@1008<->560@1009<->637,1129@1010<->1257@1011<->302@1012<->26,1184,1866,1937@1013<->756,1150@1014<->1014@1015<->1281@1016<->1720@1017<->446@1018<->124,430@1019<->1341@1020<->1369,1666@1021<->789@1022<->1022,1102,1675@1023<->28,1630@1024<->634,648@1025<->293,1263,1317@1026<->787,890@1027<->13,850@1028<->1334@1029<->1029,1147@1030<->901@1031<->775,1674@1032<->1720,1757,1764,1892@1033<->215,866,1189,1930@1034<->290,1988@1035<->500,776@1036<->116,666,1036,1707@1037<->946@1038<->292,658,1932@1039<->216@1040<->1867@1041<->792,858@1042<->985,1969,1998@1043<->1069@1044<->227@1045<->1045,1404@1046<->122,491,1046@1047<->760,1309@1048<->560,1316,1370@1049<->133,1936@1050<->786,938,1050@1051<->1371,1533@1052<->120,1106,1901@1053<->1489,1675@1054<->1075,1905@1055<->1543@1056<->163,1056@1057<->1525,1635,1870@1058<->1545@1059<->109,420,724,1781@1060<->126,1308@1061<->552,1065,1543,1594@1062<->259,392,645,1414@1063<->113,1520,1976@1064<->698,1254@1065<->402,1061,1496@1066<->249,754,1546@1067<->115,508@1068<->618@1069<->1043,1240,1461,1632@1070<->1266,1904@1071<->532,1514@1072<->327,980,1985@1073<->57@1074<->1833@1075<->29,44,80,1054@1076<->143,1778,1940@1077<->911@1078<->591,893,1629@1079<->376,601,815,1840@1080<->1144,1295,1330,1765@1081<->89@1082<->396,870,969,1498@1083<->295,707,904@1084<->1084@1085<->278@1086<->1659,1661@1087<->425,532@1088<->170@1089<->81,1089,1219,1913@1090<->147,1099@1091<->609,1579,1779@1092<->285@1093<->298,1520@1094<->940@1095<->947@1096<->1096@1097<->260@1098<->126,1682@1099<->1090@1100<->735@1101<->1848@1102<->213,943,1022@1103<->131@1104<->1783@1105<->665@1106<->1052,1106@1107<->792@1108<->56@1109<->586@1110<->356,1259@1111<->1133@1112<->830,1820@1113<->954@1114<->1114,1475@1115<->1115@1116<->516@1117<->243,735@1118<->975,1689@1119<->1235,1337,1474,1741,1994@1120<->636@1121<->427@1122<->621,957@1123<->667,1123@1124<->587,851,1250,1953@1125<->23,32,40,328@1126<->849,1429,1676@1127<->123,1998@1128<->544,989@1129<->727,761,1009,1691@1130<->697@1131<->1436,1719@1132<->741,1278@1133<->556,861,1111@1134<->1795,1956@1135<->68,818@1136<->185@1137<->31,482,1466@1138<->148,1953@1139<->367,529,1154@1140<->278,353,401,1608@1141<->1141@1142<->1690,1809@1143<->46,1495@1144<->1080,1580@1145<->313,1772@1146<->97@1147<->965,1029,1648@1148<->1007@1149<->33@1150<->1013,1417,1864@1151<->871,1990@1152<->1229,1572@1153<->159,1228@1154<->1139@1155<->325,1829@1156<->1650@1157<->1489@1158<->1472@1159<->1005@1160<->1467@1161<->51@1162<->1254@1163<->1331@1164<->1895@1165<->1165,1214,1345@1166<->1254@1167<->538@1168<->217,1223,1818@1169<->1169,1514,1761@1170<->1948@1171<->645@1172<->331,905@1173<->408,1535@1174<->1203,1238,1472@1175<->182,1817@1176<->980@1177<->1307,1463@1178<->583,894,1800,1971@1179<->745,1259@1180<->736,745@1181<->524,880@1182<->270,1216,1878@1183<->390@1184<->324,1012,1356@1185<->249@1186<->789@1187<->64,296,448,1377,1488@1188<->136,1320@1189<->1033,1823@1190<->225,256,471@1191<->132,286,1802@1192<->459@1193<->154,1193@1194<->793,923,1479@1195<->38,1766@1196<->1196,1470@1197<->766@1198<->194,1252@1199<->1199@1200<->140,1200@1201<->814,1802@1202<->304,1865@1203<->1174@1204<->1583@1205<->57,211,867,1331,1784,1819@1206<->1286@1207<->710@1208<->498@1209<->160,1209@1210<->1210,1599@1211<->14,281,1278@1212<->1289,1644@1213<->443,1714,1863@1214<->1165@1215<->1215@1216<->1182,1436@1217<->948,1377@1218<->493,495,1006@1219<->1089@1220<->564@1221<->555,844,984@1222<->557@1223<->150,1168@1224<->9@1225<->1323@1226<->242@1227<->876,1314@1228<->150,582,1153,1918@1229<->991,1152@1230<->473,503,1444,1945@1231<->54,584,1713@1232<->575,914,1232@1233<->79,142,1776@1234<->282,604@1235<->1119@1236<->785,1236@1237<->587,1751@1238<->827,1174,1417@1239<->150,1597,1852@1240<->1069,1769@1241<->330,439,927@1242<->1242@1243<->784,1541@1244<->11,638,979@1245<->1245@1246<->237,1330@1247<->1005,1598@1248<->1573@1249<->209,1522@1250<->1124@1251<->63@1252<->1198@1253<->456,474@1254<->462,918,1064,1162,1166@1255<->862@1256<->596,747@1257<->449,1010,1568,1837@1258<->1803@1259<->1110,1179@1260<->675@1261<->1005,1753@1262<->376,1318@1263<->1025,1887@1264<->343@1265<->717@1266<->1070@1267<->987,1368@1268<->1268@1269<->118,699,992,1939@1270<->157,978@1271<->219@1272<->1858@1273<->218@1274<->905@1275<->407,494@1276<->26,929@1277<->1919,1982@1278<->998,1132,1211@1279<->138,328,1852,1912@1280<->960@1281<->102,113,388,1015,1877@1282<->444@1283<->372,1562@1284<->919@1285<->262@1286<->127,1206,1286,1875@1287<->269@1288<->860,1736@1289<->1212,1321,1424@1290<->1319,1884,1959,1978@1291<->1291,1998@1292<->55@1293<->273,1995@1294<->227,349,561@1295<->277,1080,1570@1296<->921,1714@1297<->1297@1298<->1518,1733@1299<->357,392@1300<->319@1301<->1301@1302<->1912@1303<->843@1304<->741@1305<->814,1828@1306<->301,1610@1307<->190,1177@1308<->1060@1309<->319,389,1047@1310<->605@1311<->1463@1312<->578,734@1313<->629,666@1314<->1227,1980@1315<->684,1472@1316<->898,1048@1317<->1025@1318<->520,1262@1319<->1290@1320<->1188@1321<->1289,1737@1322<->705,1501@1323<->1225,1323@1324<->1720@1325<->1837@1326<->890@1327<->1470,1914@1328<->560@1329<->763,894@1330<->1080,1246@1331<->1163,1205@1332<->1332@1333<->703@1334<->144,410,1028,1854,1871,1925@1335<->246,910,1807@1336<->483,505@1337<->255,477,1119@1338<->1455,1810@1339<->354,1845@1340<->623,1627@1341<->62,1019,1841@1342<->798@1343<->1343@1344<->982,1344@1345<->1165,1369@1346<->1410,1643@1347<->357@1348<->1623@1349<->235,1991@1350<->1698@1351<->1669@1352<->1352@1353<->571,1519,1657@1354<->80,752@1355<->635,981@1356<->1184@1357<->1679@1358<->874,1838@1359<->661@1360<->565,1555@1361<->134@1362<->477,626@1363<->1459@1364<->566,1791@1365<->20,944,1465@1366<->295,445@1367<->782,866@1368<->1267@1369<->976,1020,1345@1370<->1048@1371<->223,414,1051@1372<->323,829,907@1373<->1373@1374<->503@1375<->732,1375@1376<->1376@1377<->271,431,1187,1217@1378<->225@1379<->307,1379,1507@1380<->784,1870@1381<->1381,1569@1382<->708,1839@1383<->959,1586@1384<->733,1716@1385<->1385@1386<->1386@1387<->101@1388<->385,1777@1389<->152@1390<->134,1669@1391<->1924@1392<->245,919@1393<->1904@1394<->10@1395<->1582@1396<->495,507,1622,1902@1397<->810,823,842@1398<->973@1399<->438,1670,1671@1400<->1400@1401<->195,1649@1402<->1402@1403<->1603@1404<->1045@1405<->642@1406<->1562,1668@1407<->1606@1408<->1408@1409<->486,613@1410<->59,713,813,1346@1411<->1666@1412<->435@1413<->786,1709@1414<->53,1062,1600@1415<->764,1558@1416<->35,934@1417<->1150,1238@1418<->518@1419<->567@1420<->1858@1421<->294@1422<->177@1423<->1668@1424<->1289@1425<->77@1426<->1870,1943@1427<->770@1428<->1428@1429<->1126@1430<->609,841,939,1826@1431<->21@1432<->1975@1433<->131@1434<->845,1487@1435<->268,1597@1436<->695,1131,1216@1437<->16,1910@1438<->523,660,1438@1439<->241,314@1440<->1714@1441<->241,510,993@1442<->537@1443<->815@1444<->1230@1445<->496,633,808@1446<->167,643,1526@1447<->1848@1448<->829,1709@1449<->660@1450<->229@1451<->1481,1527@1452<->1452@1453<->607@1454<->398,783@1455<->1338,1618@1456<->459@1457<->482,692,768,1512@1458<->1752@1459<->728,828,1363@1460<->1625@1461<->28,158,1069,1926@1462<->1462@1463<->370,1177,1311@1464<->1935@1465<->859,1365@1466<->1137@1467<->129,1160@1468<->826@1469<->1524@1470<->1196,1327@1471<->1799,1993@1472<->1158,1174,1315,1472,1502,1981@1473<->642@1474<->1119@1475<->1114,1513@1476<->16,1598@1477<->1477@1478<->795@1479<->1194@1480<->920@1481<->264,1451,1504,1952@1482<->1795@1483<->1984@1484<->862,1629@1485<->908@1486<->222@1487<->1434@1488<->1187@1489<->9,809,1053,1157,1490@1490<->1489@1491<->1872@1492<->722@1493<->177@1494<->1824@1495<->75,717,970,1143@1496<->1065@1497<->511,803@1498<->752,883,1082@1499<->1646@1500<->435,843@1501<->1322,1501,1753@1502<->98,1472@1503<->564@1504<->190,579,1481@1505<->1527@1506<->1939@1507<->88,905,1379@1508<->222,398,762@1509<->170,962,1509@1510<->381,417,839@1511<->448@1512<->838,1457@1513<->1475@1514<->469,602,1071,1169@1515<->1766@1516<->582@1517<->78,1555@1518<->1298@1519<->1353,1918@1520<->1063,1093@1521<->89@1522<->1249@1523<->1566@1524<->19,1469@1525<->2,269,481,1057@1526<->245,1446@1527<->137,1451,1505,1948@1528<->626,748,1771@1529<->1618@1530<->1530@1531<->400,644@1532<->387@1533<->1051,1725@1534<->1658,1696@1535<->420,1173,1867@1536<->851@1537<->139@1538<->664@1539<->19,695@1540<->338@1541<->359,662,1243@1542<->4,139@1543<->0,455,1055,1061,1604@1544<->854,1619@1545<->367,537,1058@1546<->1066@1547<->25@1548<->581,1917@1549<->453,672@1550<->40,759@1551<->852@1552<->524@1553<->482@1554<->91@1555<->1360,1517,1833@1556<->1869@1557<->687@1558<->1415@1559<->1559,1773@1560<->1693@1561<->25@1562<->1283,1406@1563<->816,1563,1768@1564<->553,672,1892@1565<->57,1665@1566<->98,1523,1907@1567<->776@1568<->1257,1998@1569<->1381@1570<->1295@1571<->752,1827@1572<->248,315,1152@1573<->789,1248,1772@1574<->427,541,917,1796,1882@1575<->135,515@1576<->1957@1577<->944@1578<->407,800@1579<->1091@1580<->1144@1581<->195@1582<->65,1395,1582@1583<->704,1204@1584<->1584@1585<->403,1889@1586<->1383@1587<->395,1587@1588<->1983@1589<->754@1590<->384,498,638@1591<->794@1592<->886,1608@1593<->249,916@1594<->1061@1595<->645,766@1596<->89,153@1597<->56,1239,1435@1598<->50,1247,1476@1599<->1210@1600<->1414@1601<->199,849@1602<->758@1603<->514,1403,1792@1604<->1543,1979@1605<->30,434,478,1961@1606<->772,1407@1607<->1607,1653@1608<->1140,1592@1609<->783@1610<->171,1306,1744@1611<->473@1612<->794,1859@1613<->459,787,1613@1614<->319,817,1616,1924@1615<->178,742,914@1616<->346,1614@1617<->74,110,200,730@1618<->296,801,1455,1529@1619<->50,1544@1620<->260@1621<->520,910,1748@1622<->172,187,369,1396@1623<->1348,1623@1624<->21@1625<->1460,1625,1936,1963@1626<->96@1627<->1340,1677@1628<->1628,1728@1629<->1078,1484@1630<->1023@1631<->308@1632<->1069@1633<->1669,1935@1634<->187,516@1635<->986,1057@1636<->547,1762@1637<->1637@1638<->317@1639<->664,717@1640<->126@1641<->36,262,433@1642<->569,942@1643<->539,1346,1745@1644<->416,624,1212,1931@1645<->929@1646<->586,1499,1687@1647<->242,781,1723@1648<->1147,1947@1649<->1401@1650<->630,722,1156,1869@1651<->1943@1652<->796@1653<->1607@1654<->465,1970@1655<->1987@1656<->1656@1657<->1353@1658<->373,1534@1659<->1086@1660<->348,1660@1661<->242,611,1086@1662<->692@1663<->712@1664<->257@1665<->1565@1666<->1020,1411,1887,1967@1667<->261@1668<->1406,1423@1669<->429,1351,1390,1633,1938@1670<->1399@1671<->265,1399@1672<->152,1684,1707@1673<->205@1674<->877,1031,1991@1675<->641,1022,1053,1920@1676<->1126@1677<->82,646,1627@1678<->286,997@1679<->208,573,1357@1680<->169,741@1681<->586,663,1811@1682<->1,1098@1683<->203,856,1817@1684<->1672,1927@1685<->182,1950@1686<->749@1687<->174,1646@1688<->913@1689<->1118@1690<->839,1142@1691<->648,1129@1692<->937@1693<->320,897,995,1560,1716@1694<->352,457@1695<->462@1696<->165,826,1534@1697<->1877@1698<->172,941,1350@1699<->572@1700<->308@1701<->394,1843@1702<->642,695,1861@1703<->780,1909@1704<->436@1705<->1906@1706<->455@1707<->1036,1672,1854@1708<->1708@1709<->1413,1448@1710<->1822@1711<->473,959@1712<->921,991@1713<->1231@1714<->509,1213,1296,1440,1999@1715<->651@1716<->1384,1693@1717<->101@1718<->178@1719<->1131@1720<->1016,1032,1324@1721<->210@1722<->322@1723<->1647@1724<->1724,1738@1725<->1533,1743@1726<->724@1727<->852@1728<->1628@1729<->582@1730<->1733,1935@1731<->257,704,1989@1732<->801@1733<->775,1298,1730,1762@1734<->365@1735<->60,290@1736<->661,911,1288,1749@1737<->1321@1738<->236,1724@1739<->28@1740<->31@1741<->360,966,1119@1742<->68@1743<->649,1725@1744<->790,1610@1745<->1643@1746<->883@1747<->820@1748<->1621@1749<->1736@1750<->1750@1751<->646,1237@1752<->407,1458@1753<->1261,1501@1754<->247@1755<->457,1855@1756<->32,551,589@1757<->1032@1758<->113@1759<->1848@1760<->26@1761<->561,1169@1762<->1636,1733@1763<->563@1764<->1032@1765<->254,1080@1766<->743,1195,1515@1767<->527@1768<->1563@1769<->1240@1770<->631,710@1771<->1528@1772<->1145,1573@1773<->1559@1774<->374@1775<->250@1776<->200,1233@1777<->652,1388@1778<->635,1076@1779<->303,1091@1780<->35,594@1781<->1059@1782<->350,1964@1783<->1104,1837,1879@1784<->1205@1785<->783@1786<->811,879,1786,1847@1787<->874,1829@1788<->484,963@1789<->1858@1790<->33,341@1791<->1364,1791@1792<->1603,1792,1868@1793<->549@1794<->508@1795<->1134,1482@1796<->960,1574@1797<->145@1798<->1798@1799<->1471@1800<->1178@1801<->686@1802<->1191,1201@1803<->214,1258,1819@1804<->1819@1805<->237@1806<->1973@1807<->699,1335@1808<->668,1898@1809<->1142,1987@1810<->192,480,506,964,1338@1811<->1681@1812<->697@1813<->617,1910@1814<->327@1815<->1953@1816<->176@1817<->1175,1683@1818<->850,1168@1819<->685,1205,1803,1804@1820<->654,1112@1821<->250@1822<->1710,1957@1823<->697,772,932,1189@1824<->1494,1848@1825<->206,614@1826<->1430@1827<->364,721,1571@1828<->1305@1829<->386,918,1155,1787@1830<->568@1831<->215,243,711@1832<->415,1832@1833<->1074,1555@1834<->1834@1835<->1835@1836<->289,773@1837<->1257,1325,1783@1838<->676,1358@1839<->437,1382,1872@1840<->1079@1841<->375,1341@1842<->247,1850@1843<->1701@1844<->879@1845<->533,843,1339@1846<->1870@1847<->1786,1972@1848<->1101,1447,1759,1824,1848,1873@1849<->631@1850<->681,1842@1851<->1851@1852<->1239,1279@1853<->28,1997@1854<->1334,1707@1855<->788,1755@1856<->515@1857<->212,325@1858<->306,480,1272,1420,1789@1859<->332,1612@1860<->1977@1861<->1702@1862<->518,950,974,1862@1863<->420,599,895,1213@1864<->1150@1865<->45,141,1202@1866<->1012@1867<->489,937,1040,1535@1868<->931,1792@1869<->603,1556,1650@1870<->1057,1380,1426,1846@1871<->1334@1872<->1491,1839,1959@1873<->1848@1874<->284,387,485@1875<->1286@1876<->1876,1908@1877<->72,84,1281,1697@1878<->906,1182@1879<->1783@1880<->234,491,683@1881<->41,556@1882<->332,1574,1882@1883<->1883@1884<->1290@1885<->853@1886<->95,644,934@1887<->1263,1666@1888<->1888@1889<->855,915,1585@1890<->799@1891<->990,1896@1892<->1032,1564@1893<->267,581@1894<->205,953@1895<->1164,1895@1896<->1891@1897<->963@1898<->1808,1915@1899<->93,689,850@1900<->28,168@1901<->1052@1902<->1396,1902@1903<->695@1904<->69,115,195,836,1070,1393@1905<->100,247,1054@1906<->1705,1971@1907<->1566,1934@1908<->765,1876@1909<->651,1703@1910<->1437,1813@1911<->472,488,594,734@1912<->1279,1302@1913<->834,1089@1914<->1327@1915<->1898@1916<->547@1917<->1548@1918<->1228,1519@1919<->55,1277@1920<->461,1675@1921<->674@1922<->1001,1922@1923<->671,908,1923@1924<->1391,1614,1958@1925<->1334@1926<->54,625,1461@1927<->559,935,1684@1928<->287,600,780@1929<->107,534@1930<->139,889,1033@1931<->924,1644@1932<->1038@1933<->1933@1934<->1907@1935<->712,1464,1633,1730@1936<->1049,1625@1937<->620,1012@1938<->1669,1938@1939<->1269,1506@1940<->229,918,1076@1941<->19,181@1942<->67@1943<->1426,1651@1944<->218,391@1945<->1230@1946<->613@1947<->983,1648@1948<->1170,1527@1949<->91@1950<->1685@1951<->52@1952<->1481,1952@1953<->674,1124,1138,1815@1954<->12@1955<->734@1956<->1134,1956@1957<->530,1576,1822@1958<->90,632,888,1924@1959<->1290,1872@1960<->848,949@1961<->130,1605@1962<->289@1963<->1625@1964<->1782@1965<->7@1966<->685@1967<->39,723,1666@1968<->525@1969<->1042@1970<->579,977,1654@1971<->1178,1906@1972<->1847@1973<->645,1806@1974<->350,446@1975<->259,1432@1976<->1063@1977<->236,1860@1978<->954,1290@1979<->967,1604@1980<->940,1314@1981<->1472@1982<->1277@1983<->217,540,1588@1984<->560,892,1483@1985<->327,1072@1986<->581@1987<->437,1655,1809@1988<->954,1034@1989<->532,1003,1731@1990<->300,1151@1991<->1349,1674@1992<->614@1993<->87,581,1471@1994<->778,1119@1995<->1293@1996<->198,323@1997<->1853@1998<->1042,1127,1291,1568@1999<->433,1714"

	for i=1:1:$length(pInput,"@") {
		set tBase=$piece($piece($piece(pInput,"@",i),"<->",1),"(",1)
		for j=1:1:$length($piece($piece(pInput,"@",i),"<->",2),",") {
			set tTemp=$piece($piece($piece(pInput,"@",i),"<->",2),",",j)
			continue:tTemp=""
			//w j,!
			//w $piece($piece(pInput,"@",i),"->",2),!
			set tArray(tBase,tTemp)=1
		}
	}
	
	set tCount=0
	set tBase=$o(tArray(""))
	while tBase'="" {
		d ##class(AOC.Y2017).Day12P2Eval(.tArray,tBase)
		set tCount=tCount+1
		set tBase=$o(tArray(""))
	}
	
	quit tCount
}

ClassMethod Day12P2Eval(ByRef pArray, pBase, ByRef pVisited) As %String
{
	if $g(pVisited(pBase)) {
		quit 0
	}
	set pVisited(pBase)=1
	set tSub=$o(pArray(pBase,""))
	while tSub'="" {
		d ##class(AOC.Y2017).Day12P2Eval(.pArray,tSub,.pVisited)
		set tSub=$o(pArray(pBase,tSub))
	}
	
	k pArray(pBase)
	
	quit ""
}

ClassMethod Day13P1(pInput = "") As %String
{
	set:pInput="" pInput="0:5@1:2@2:3@4:4@6:8@8:4@10:6@12:6@14:8@16:6@18:6@20:12@22:14@24:8@26:8@28:9@30:8@32:8@34:12@36:10@38:12@40:12@44:14@46:12@48:10@50:12@52:12@54:12@56:14@58:12@60:14@62:14@64:14@66:14@68:17@70:12@72:14@76:14@78:14@80:14@82:18@84:14@88:20"

	
	for i=1:1:$length(pInput,"@") {
		set tTemp=$piece(pInput,"@",i)
		set tArray($piece(tTemp,":",1))=$piece(tTemp,":",2)
	}
	
	set tMax=$o(tArray(""),-1)
	set tRes=0
	for i=0:1:tMax {
		if ($G(tArray(i))'="")&&((i#(($G(tArray(i))*2)-2))=0) {
			set tRes=tRes+(i*$G(tArray(i)))
		}
	}
	
	quit tRes
}

ClassMethod Day13P2(pInput = "") As %String
{
	set:pInput="" pInput="0:5@1:2@2:3@4:4@6:8@8:4@10:6@12:6@14:8@16:6@18:6@20:12@22:14@24:8@26:8@28:9@30:8@32:8@34:12@36:10@38:12@40:12@44:14@46:12@48:10@50:12@52:12@54:12@56:14@58:12@60:14@62:14@64:14@66:14@68:17@70:12@72:14@76:14@78:14@80:14@82:18@84:14@88:20"

	
	for i=1:1:$length(pInput,"@") {
		set tTemp=$piece(pInput,"@",i)
		set tArray($piece(tTemp,":",1))=$piece(tTemp,":",2)
	}
	
	set tMax=$o(tArray(""),-1)
	set tDone=0
	set tDelay=0
	while 'tDone {
		set tRes=0
		for i=0:1:tMax {
			if ($G(tArray(i))'="")&&(((i+tDelay)#(($G(tArray(i))*2)-2))=0) {
				set tRes=1
				quit
			}
		}
		if tRes=0 {
			set tDone=1
		} else {
			set tDelay=tDelay+1
		}
	}
	
	quit tDelay
}

ClassMethod Day14P1(pInput = "") As %String
{
	set:pInput="" pInput="ugkiagan"

	set tTotal=0
	for i=0:1:127 {
		set tKey=pInput_"-"_i
		set tKnotHash=##class(AOC.Y2017).Day10P2(tKey)
		
		set tBits=""
		for j=1:1:$length(tKnotHash) {
			set tTemp=$factor($zhex($e(tKnotHash,j)_""))
			for k=4:-1:1 {
				set $bit(tBits,$bitcount(tBits)+1)=$bit(tTemp,k)
			}
		}
		set tTotal=tTotal+$bitcount(tBits,1)
	}
	
	quit tTotal
}

ClassMethod Day14P2(pInput = "") As %String
{
	set:pInput="" pInput="ugkiagan"

	set tTotal=0
	for i=0:1:127 {
		set tKey=pInput_"-"_i
		set tKnotHash=##class(AOC.Y2017).Day10P2(tKey)
		
		set tBits=""
		for j=1:1:$length(tKnotHash) {
			set tTemp=$factor($zhex($e(tKnotHash,j)_""))
			for k=4:-1:1 {
				set $bit(tBits,$bitcount(tBits)+1)=$bit(tTemp,k)
			}
		}
		set tBitsArray(i)=tBits
		set tTotal=tTotal+$bitcount(tBits,1)
	}
	
	set tCount=0
	for i=0:1:127 {
		for j=1:1:128 {
			set tCount=tCount+##class(AOC.Y2017).Day14Eval(j,i,.tBitsArray)
		}
	}
	
	quit tCount
}

ClassMethod Day14Eval(pX, pY, ByRef pArray)
{
	set tRes=0
	if $bit(pArray(pY),pX) {
		set $bit(pArray(pY),pX)=0
		do ##class(AOC.Y2017).Day14Eval(pX-1,pY,.pArray)
		do ##class(AOC.Y2017).Day14Eval(pX+1,pY,.pArray)
		do ##class(AOC.Y2017).Day14Eval(pX,pY+1,.pArray)
		do ##class(AOC.Y2017).Day14Eval(pX,pY-1,.pArray)
		set tRes=1
	}
	
	quit tRes
}

ClassMethod Day15P1() As %String
{
	set tGenAFactor=16807
	set tGenBFactor=48271
	set tDivisor=2147483647
	
	set tGenA=679
	set tGenB=771
	set tTotal=0
	for i=1:1:40000000 {
		set tGenA=(tGenA*tGenAFactor)-(((tGenA*tGenAFactor)\tDivisor)*tDivisor)
		set tGenB=(tGenB*tGenBFactor)-(((tGenB*tGenBFactor)\tDivisor)*tDivisor)
		set tBinA=$factor(tGenA)
		set tBinB=$factor(tGenB)
		set tMatch=1
		for j=1:1:16 {
			if $bit(tBinA,j)'=$bit(tBinB,j) {
				set tMatch=0
				quit
			}
		}
		if tMatch {
			set tTotal=tTotal+1
		}
	}
	
	
	quit tTotal
}

ClassMethod Day15P2() As %String
{
	set tGenAFactor=16807
	set tGenBFactor=48271
	set tDivisor=2147483647
	
	set tGenA=679
	set tGenB=771
	set tTotal=0
	for i=1:1:5000000 {
		set tGenA=(tGenA*tGenAFactor)-(((tGenA*tGenAFactor)\tDivisor)*tDivisor)
		while tGenA#4'=0 {
			set tGenA=(tGenA*tGenAFactor)-(((tGenA*tGenAFactor)\tDivisor)*tDivisor)
		}
		set tGenB=(tGenB*tGenBFactor)-(((tGenB*tGenBFactor)\tDivisor)*tDivisor)
		while tGenB#8'=0 {
			set tGenB=(tGenB*tGenBFactor)-(((tGenB*tGenBFactor)\tDivisor)*tDivisor)
		}
		set tBinA=$factor(tGenA)
		set tBinB=$factor(tGenB)
		set tMatch=1
		for j=1:1:16 {
			if $bit(tBinA,j)'=$bit(tBinB,j) {
				set tMatch=0
				quit
			}
		}
		if tMatch {
			set tTotal=tTotal+1
		}
	}
	
	
	quit tTotal
}

ClassMethod Day16P1(pInput As %String) As %Integer
{
	
	set tList=$LB("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p")
	//set tList=$LB("a","b","c","d","e")
		for i=1:1:$listlength(pInput) {
			set tCommand=$lg(pInput,i)
			if $e(tCommand,1)="s" {
				set tTemp=""
				set tNum=$e(tCommand,2,*)
				for j=tNum-1:-1:0 {
					set tTemp=tTemp_$lb($list(tList,*-j))
				}
				for j=1:1:$listlength(tList)-tNum {
					set tTemp=tTemp_$lb($list(tList,j))
				}
				set tList=tTemp
			} elseif $e(tCommand,1)="x" {
				set tTemp=""
				set tPos1=$e(tCommand,2,$find(tCommand,"/")-2)+1
				set tPos2=$e(tCommand,$find(tCommand,"/"),*)+1
				set tTemp=$lg(tList,tPos1)
				set $list(tList,tPos1)=$list(tList,tPos2)
				set $list(tList,tPos2)=tTemp
			} elseif $e(tCommand,1)="p" {
				set tPos1=$listfind(tList,$e(tCommand,2))
				set tPos2=$listfind(tList,$e(tCommand,4))
				set tTemp=$lg(tList,tPos1)
				set $list(tList,tPos1)=$lg(tList,tPos2)
				set $list(tList,tPos2)=tTemp
			}
		}
	quit $lts(tList,"")
}

ClassMethod Day16P2(pInput As %String) As %Integer
{
	
	set tList=$LB("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p")
	//set tList=$LB("a","b","c","d","e")
	for n=1:1:1000000000 {
		for i=1:1:$listlength(pInput) {
			set tCommand=$lg(pInput,i)
			if $e(tCommand,1)="s" {
				set tTemp=""
				set tNum=$e(tCommand,2,*)
				for j=tNum-1:-1:0 {
					set tTemp=tTemp_$lb($list(tList,*-j))
				}
				for j=1:1:$listlength(tList)-tNum {
					set tTemp=tTemp_$lb($list(tList,j))
				}
				set tList=tTemp
			} elseif $e(tCommand,1)="x" {
				set tTemp=""
				set tPos1=$e(tCommand,2,$find(tCommand,"/")-2)+1
				set tPos2=$e(tCommand,$find(tCommand,"/"),*)+1
				set tTemp=$lg(tList,tPos1)
				set $list(tList,tPos1)=$list(tList,tPos2)
				set $list(tList,tPos2)=tTemp
			} elseif $e(tCommand,1)="p" {
				set tPos1=$listfind(tList,$e(tCommand,2))
				set tPos2=$listfind(tList,$e(tCommand,4))
				set tTemp=$lg(tList,tPos1)
				set $list(tList,tPos1)=$lg(tList,tPos2)
				set $list(tList,tPos2)=tTemp
			}
		}
		if $d(tRes($lts(tList,""))) {
			w $lts(tList,"")_" repeated at "_n,!
		}
		set tRes($lts(tList,""))=1
	}
	quit $lts(tList,"")
}

ClassMethod Day17P1(pInput) As %String
{
	set tSteps=pInput
	set tPos=1
	set tList=$lb(0)
	
	for i=1:1:2017 {
		set tTemp=tSteps+tPos
		while tTemp>$listlength(tList) {
			set tTemp=tTemp-$listlength(tList)
		}
		set tNewPos=tTemp
		//zw tNewPos
		set tTemp=""
		for j=1:1:tNewPos {
			set tTemp=tTemp_$lb($list(tList,j))
		}
		set tTemp=tTemp_$lb(i)
		for j=tNewPos+1:1:$listlength(tList) {
			set tTemp=tTemp_$lb($list(tList,j))
		}
		set tPos=tNewPos+1
		set tList=tTemp
		//zw tList
		//zw tPos
		//break
	}
	quit $lg(tList,tPos+1)
}

ClassMethod Day17P2(pInput) As %String
{
	set tSteps=pInput
	set tPos=1
	
	for i=1:1:50000000 {
		set tTemp=tSteps+tPos
		while tTemp>i {
			set tTemp=tTemp-i
		}
		set tNewPos=tTemp
		
		if tTemp=1 {
			set tNext=i
		}
		set tPos=tNewPos+1
	}
	quit tNext
}

ClassMethod Day18P1(pInput = "") As %String
{
	set:pInput="" pInput = "set i 31@set a 1@mul p 17@jgz p p@mul a 2@add i -1@jgz i -2@add a -1@set i 127@set p 464@mul p 8505@mod p a@mul p 129749@add p 12345@mod p a@set b p@mod b 10000@snd b@add i -1@jgz i -9@jgz a 3@rcv b@jgz b -1@set f 0@set i 126@rcv a@rcv b@set p a@mul p -1@add p b@jgz p 4@snd a@set a b@jgz 1 3@snd b@set f 1@add i -1@jgz i -11@snd a@jgz f -16@jgz a -19"
	
	for i=1:1:$length(pInput,"@") {
		set tCmd=$p(pInput,"@",i)
		set tReg=$piece(tCmd," ",2)
		set tVal=$piece(tCmd," ",3)
		if (tVal'="") && (tVal'=(+tVal)) {
			set tVal=$g(tArray(tVal))
		}
		if $e(tCmd,1,3)="snd" {
			set tRes=$g(tArray(tReg),0)
			set tLast(tReg)=tRes
		} elseif $e(tCmd,1,3)="set" {
			set tArray(tReg)=tVal
		} elseif $e(tCmd,1,3)="add" {
			set tArray(tReg)=$g(tArray(tReg))+tVal
		} elseif $e(tCmd,1,3)="mul" {
			set tArray(tReg)=$g(tArray(tReg))*tVal
		} elseif $e(tCmd,1,3)="mod" {
			set tArray(tReg)=$g(tArray(tReg))#tVal
		} elseif $e(tCmd,1,3)="rcv" {
			if $g(tLast(tReg))>0 {
				set tRes=tLast(tReg)
				quit
			}
		} elseif $e(tCmd,1,3)="jgz" {
			if $g(tArray(tReg))>0 {
				set i=i+tVal-1
			}
		}
	}
	quit tRes
}

ClassMethod Day18P2(pInput = "") As %String
{
	set:pInput="" pInput = "set i 31@set a 1@mul p 17@jgz p p@mul a 2@add i -1@jgz i -2@add a -1@set i 127@set p 464@mul p 8505@mod p a@mul p 129749@add p 12345@mod p a@set b p@mod b 10000@snd b@add i -1@jgz i -9@jgz a 3@rcv b@jgz b -1@set f 0@set i 126@rcv a@rcv b@set p a@mul p -1@add p b@jgz p 4@snd a@set a b@jgz 1 3@snd b@set f 1@add i -1@jgz i -11@snd a@jgz f -16@jgz a -19"
	
	set tRes=0
	set tState=1
	set tProg1=1
	set tProg2=1
	set tProg1Wait=0
	set tProg2Wait=0
	set tArray(1,"p")=0
	set tArray(2,"p")=1
	while tState'=0 {
		if tState=1 {
			set tPos=tProg1	
		} else {
			set tPos=tProg2
		}
		for i=tPos:1:$length(pInput,"@") {
			set tCmd=$p(pInput,"@",i)
			set tReg=$piece(tCmd," ",2)
			set tVal=$piece(tCmd," ",3)
			if (tVal'="") && (tVal'=(+tVal)) {
				set tVal=$g(tArray(tState,tVal))
			}
			if $e(tCmd,1,3)="snd" {
				set tTemp=tReg
				if (tReg'="") && (tReg'=(+tReg)) {
					set tTemp=$g(tArray(tState,tReg),0)
				}
				set tQueue($select(tState=1:2,1:1),$i(tQueue($select(tState=1:2,1:1))))=tTemp
				if tState=1 {
					set tProg2Wait=0
				}else {
					set tProg1Wait=0
					set tRes=tRes+1
				}
			} elseif $e(tCmd,1,3)="set" {
				set tArray(tState,tReg)=tVal
			} elseif $e(tCmd,1,3)="add" {
				set tArray(tState,tReg)=$g(tArray(tState,tReg))+tVal
			} elseif $e(tCmd,1,3)="mul" {
				set tArray(tState,tReg)=$g(tArray(tState,tReg))*tVal
			} elseif $e(tCmd,1,3)="mod" {
				set tArray(tState,tReg)=$g(tArray(tState,tReg))#tVal
			} elseif $e(tCmd,1,3)="rcv" {
				set tTemp2=$O(tQueue(tState,""),1,tTemp)
				if tTemp2="" {
					if tState=1 {
						set tProg1Wait=1	
					} else {
						set tProg2Wait=1
					}
					quit
				} else {
					if tState=1 {
						set tProg1Wait=0
					} else {
						set tProg2Wait=0
					}
				}
				kill tQueue(tState,tTemp2)
				set tArray(tState,tReg)=tTemp
			} elseif $e(tCmd,1,3)="jgz" {
				set tTemp=tReg
				if (tReg'="") && (tReg'=(+tReg)) {
					set tTemp=$g(tArray(tState,tReg),0)
				}
				if tTemp>0 {
					set i=i+tVal-1
				}
			}
		}
		if tState=1 {
			set tProg1=i
			set tState=2
		} else {
			set tProg2=i
			set tState=1
		}
		
		if tProg1Wait && tProg2Wait {
			quit
		}
	}
	quit tRes
}

ClassMethod Day19P1(pInput) As %String
{
 set pInput($i(pInput))="                                                                                                   |                                                                                                     "
 set pInput($i(pInput))=" +-------------------+               +-+ +-------+       +-------------------+                     |                                         +---+                                   +-----+       +---+ "
 set pInput($i(pInput))=" |                   |               | | |       |       |                   |                     |                                         |   |                                   |     |       |   | "
 set pInput($i(pInput))=" |         +---+     |   +---------------|-------|-----------------------+ +-----------------------------+                                   |   |                                   |     |       |   | "
 set pInput($i(pInput))=" |         |   |     |   |           | | |       |       |               | | |                     |     |                                   |   |                                   |     |       |   | "
 set pInput($i(pInput))=" |         |   +---------------------|-----------------------------------|-------------------------------------------------------------------|-----------------+           +-----------------------+   | "
 set pInput($i(pInput))=" |         |         |   |           | | |       |       |               | | |                     |     |                                   |   |             |           |         |     |           | "
 set pInput($i(pInput))=" |         |         |   +-------------|-|---------------|---------------|---|---------------------------|-------------------------+         |   |             |         +-|---------|-------------+   | "
 set pInput($i(pInput))=" |         |         |               | | |       |       |               | | |                     |     |                         |         |   |             |         | |         |     |       |   | "
 set pInput($i(pInput))=" |   +-------------------------------|-----------|-------|---------------|---|---------------------|-----|-----------------------------------|---|-------------+ +-------+ |         +-----|---+   |   | "
 set pInput($i(pInput))=" |   |     |         |               | | |       |       |               | | |                     |     |                         |         |   |               |         |               |   |   |   | "
 set pInput($i(pInput))=" |   +-+   |         |               | | |       |       |               +-+ |                     |     | +---------------------------------|---|---------------+         |               |   |   | +-+ "
 set pInput($i(pInput))=" |     |   |         |               | | |       |       |                   |                     |     | |                       |         |   |                         |               |   |   | |   "
 set pInput($i(pInput))=" |     |   |         |               | | |   +---|-------|-------------------|---------------------|-----|-|---------------------------+     | +-|-------------+           | +-----+       |   |   | |   "
 set pInput($i(pInput))=" |     |   |         |               | | |   |   |       |                   |                     |     | |                       |   |     | | |             |           | |     |       |   |   | |   "
 set pInput($i(pInput))=" | +---|-------------------------------|-|---------------|---------------+   |                   +---------------------+           +-------+ +-|-|-------------------------|-|-----|---------------|---+ "
 set pInput($i(pInput))=" | |   |   |         |               | | |   |   |       |               |   |                   | |     | |           |               |   |   | |             |           | |     |       |   |   | | | "
 set pInput($i(pInput))=" | |   +---|-------------------------|---|---|-------------------------------|-+               +-----+ +-|-----------------------------|-------|---------------|-----------|-|-----+       |   |   | | | "
 set pInput($i(pInput))=" | |       |         |               | | |   |   |       |               |   | |               | | | | | | |           |               |   |   | |             |           | |             |   |   | | | "
 set pInput($i(pInput))=" | | +---+ | +-+     |               | | |   |   |       |       +-----------|-+               | +-|-----|---------------+             |   |   | |             |           | |             |   |   | | | "
 set pInput($i(pInput))=" | | |   | | | |     |               | | |   |   |       |       |       |   |                 |   | | | | |           | |             |   |   | |             |           | |             |   |   | | | "
 set pInput($i(pInput))=" | | |   | | | |     |     +---+     | | |   |   |       |       |       |   |       +---------|---|---|-|---------------|-----------------|---|-|-------------|-------------|---------+ +-|-+ |   | | | "
 set pInput($i(pInput))=" | | |   | | | |     |     |   |     | | |   |   |       |       |       |   |       |         |   | | | | |           | |             |   |   | |             |           | |         | | | | |   | | | "
 set pInput($i(pInput))=" | | +-+ | | | |     |     |   | +-+ | | |   |   |       |       |       |   |       |         |   | | | | |           | |             |   |   | |             |           | +-----------+ | | |   | | | "
 set pInput($i(pInput))=" | |   | | | | |     |     |   | | | | | |   |   |       |       |       |   |       |         |   | | | | |           | |             |   |   | |             |           |           |   | | |   | | | "
 set pInput($i(pInput))=" | |   +-----|-|-+   |     |   | +-|-|-|-------+ |       |       | +---+ |   |       |         |   | | +-----------------------+       |   |   | |             |           |           |   | | |   | | | "
 set pInput($i(pInput))=" | |     | | | | |   |     |   |   | | | |   | | |       |       | |   | |   |       |         |   | |   | |           | |     |       |   |   | |             |           |           |   | | |   | | | "
 set pInput($i(pInput))=" | |     | | | +-|---------|---|---|-|-|-|---|---|---+   |       | |   | |   |       |         |   | |   | |           | |     |       |   |   | |             |           |           |   | | |   | | | "
 set pInput($i(pInput))=" | |     | | |   |   |     |   |   | | | |   | | |   |   |       | |   | |   |       |         |   | |   | |           | |     |       |   |   | |             |           |           |   | | |   | | | "
 set pInput($i(pInput))=" | |     | | |   |   |     |   | +-+ | | +-----|-|-------|-------------|-----|-----------------|---|-|-----|-----------|-|-----|-------|-----------------------------------|---------------|---------+ | "
 set pInput($i(pInput))=" | |     | | |   |   |     |   | |   | |     | | |   |   |       | |   | |   |       |         |   | |   | |           | |     |       |   |   | |             |           |           |   | | |   |   | "
 set pInput($i(pInput))=" | | +-----|-|---|-------------|-|-------------------|-------------|---|-|-----------|---------|---------|-----------------------------+   | +-|---------------|-+     +---------------|---|-|-------+ | "
 set pInput($i(pInput))=" | | |   | | |   |   |     |   | |   | |     | | |   |   |       | |   | |   |       |         |   | |   | |           | |     |           | | | |             | |     |   |           |   | | |   | | | "
 set pInput($i(pInput))=" | +-|-----|-|-------|-----|-----|-+ | | +-----|-|-------|---------------------------+         |   | |   | |           | |     |           | | | |             | |     |   |           +-----|-+   | | | "
 set pInput($i(pInput))=" |   |   | | |   |   |     |   | | | | | |   | | |   |   |       | |   | |   |                 |   | |   | |           | |     |           | | | |             | |     |   |               | |     | | | "
 set pInput($i(pInput))=" |   |   | | |   |   |     |   | | | | | |   | | |   |   |       | |   | |   |         +------I|---|-------|-----------|-|---------------------|---------------|-------|---|-+         +-------+   | | | "
 set pInput($i(pInput))=" |   |   | | |   |   |     |   | | | | | |   | | |   |   |       | |   | |   |         |       |   | |   | |           | |     |           | | | |             | |     |   | |         |   | | |   | | | "
 set pInput($i(pInput))=" |   |   | | |   |   |     |   +-|---|-|-|-----+ |   |   |       | |   | |   |         |       |   | |   | |       +---|-------|----Z------------|-------------|-----------|-----------|-+ | | |   | | | "
 set pInput($i(pInput))=" |   |   | | |   |   |     |     | | | | |   |   |   |   |       | |   | |   |         |       |   | |   | |       |   | |     |           | | | |             | |     |   | |         | | | | |   | | | "
 set pInput($i(pInput))=" |   |   +-|---------------|-----|---|-|-----|---+   |   |       | |   | |   |         |       |   | |   | |       |   | |     |     +-----------|-------------|-------------|-+       | | | | |   | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     |     | | | | |   |       |   |       | |   | |   |         |       |   | |   | |       |   | |     |     |     | | | |             | |     |   | | |       | | | | |   | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     |     +---|-|-----------+ | +-|-------+ |   | +-------------|-------|---|-----|---------|---|-|-------------------|-|---------------|-------|-----+ |       | | | | |   | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     |       | | | |   |     | | | |         |   |     |         |       |   | |   | |       |   | |     |     |     | | | |             | |     |   |   |       | | | | |   | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     |       | | | |   |     | | | |       +-|---|---------------|-------|---|-------|-------|---|-----------+ +---------------------------+     |   |   |     +-|---|-|-|-+ | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     |       | | | |   |     | | | |       | |   |     |         |       |   | |   | |       |   | |     |   |       | | | |             |       |   |   |     | | | | | | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     |       | | | |   |     | | | |       | |   |     |         |       |   | |   | |       |   | |     |   |       | | | |             |       |   |   |     | | | | | | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     |       | | | |   |     | | | |       | |   |     |         |       |   | |   | |       |   | |     |   |       | | | |             |       |   |   |     | | | | | | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     | +-----|---|-|---------|-|-|---------|-----------|---------|-------------|-------------------+     |   |       | | | |             |       |   |   |     | | | | | | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     | |     | | | |   |     | | | |       | |   |     |         |       |   | |   | |       |   |       |   |       | | | |             |       |   |   |     | | | | | | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     | |     | | | |   |     | | | |       | |   |     |         |       |   | |   | |       |   |       | +-|-----+ | | | |             | +-------------|-------|-|-|-+ | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     | |     | | | |   |     | | | |       | |   |     |         |       |   | |   | |       |   |       | | |     | | | | |             | |     |   |   |     | | | |   | | | | | "
 set pInput($i(pInput))=" +---------|-----|---------|-|-----|-|-|-------------------------|-|---------|---------|-----------|-|---|---------|---|-------|-------------|-|-|---------+   | |     |   |   |     | | | |   | | | | | "
 set pInput($i(pInput))="     |     | |   |   |     | |     | | | |   |     | | | |       | |   |     |         |       |   | |   | |       |   |       | | |     | | | | |         |   | |     |   |   |     | | | |   | | | | | "
 set pInput($i(pInput))="     |     | |   |   |     | |     | | | |   |     | | | |       | |   |     |         |       |   | |   | |       |   |       | | |     | | | | |         |   | |     |   |   +-+   | | | |   | | | | | "
 set pInput($i(pInput))="     |     | |   |   |     | |     | | | |   |     | | | |       | |   |     |         |       |   | |   | |       |   |       | | |     | | | | |         |   | |     |   |     |   | | | |   | | | | | "
 set pInput($i(pInput))="     |     | |   |   |     | |     | +-|-|---|-------|-----------------------|---------------------|-+   | |       |   |       | | |     | | | | |         |   | |     |   |     |   | | | |   | | | | | "
 set pInput($i(pInput))="     |     | |   |   |     | |     |   | |   |     | | | |       | |   |     |         |       |   |     | |       |   |       | M |     | | | | |         |   | |     |   |     |   | | | |   | | | | | "
 set pInput($i(pInput))=" +---|-------|---|-----------------|---|-|---|-----------|-------------------|---------------------|-----|---------|---|-------|-|-|-----------+ |         |   | |     |   |     |   | | | |   | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     | |     |   | |   |     | | | |       | |   |     |         |       |   |     | |       |   |       | | |     | | |   |         |   | |     |   |     |   | | | |   | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     | |     |   | |   |     | | | |       | |   |     |         |       |   |     | |       |   |       | | |     | | |   |         |   | |     |   |     |   | | | |   | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     | |     |   | |   |     | | | |       | |   |     |         |       |   |     | |       |   |       | | |     | | |   |         |   | |     |   |     |   | | | |   | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     | |     |   | |   |     | | | |       | |   |     |         |       |   |     | |       |   |       +-|-----+ | | |   |         |   | |     |   |     +---+ | | |   | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     | |     |   | |   |     | | | |       | |   |     |         |       |   |     | |       |   |         | |   | | | |   |         |   | |     |   |           | | |   | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     | |     |   | |   |     | | | |       | |   |     |         |       |   |     | |       |   |         | |   | | | |   |         |   | |     |   |           | | |   | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     | |     |   | |   |     | | | |       | |   |     |         |       |   |     | |       |   |         | |   | | | |   |         |   | |     |   |           | | |   | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     | |     |   | |   |     | | | +-------|---------------------|-+     |   |     | |       |   |         | |   | | | |   |         |   | +-+ +-------------------|-+   | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     | |     |   | |   |     | | |         | |   |     |         | |     |   |     | |       |   |         | |   | | | |   |         |   |   | | |   |           | |     | | | | | "
 set pInput($i(pInput))=" |   +-+   | |   |   |     | | +-----+ | |   |     | | |       +-|-----------|---------------------|-----------------------------|-------|-|-----|-------------|-------|-----------------------|-+ | | | "
 set pInput($i(pInput))=" |     |   | |   |   |     | | |   | | | |   |     | | |       | | |   |     |         | |     |   |     | |       |   |         | |   | | | |   |         |   |   | | |   |           | |     |   | | | "
 set pInput($i(pInput))=" |   +-|-----|-------|-----|---|-----|-|-----|---------|-----+ | | |   |     |   +-----|-|-----|---|-+   | |       |   |         | |   | | | |   |         |   |   | | |   |           | |     |   | | | "
 set pInput($i(pInput))=" |   | |   | |   |   |     | | |   | | | |   |     | | |     | | | |   |     |   |     | |     |   | |   | |       |   |         | |   | | | |   |         |   |   | | |   |           | |     |   | | | "
 set pInput($i(pInput))=" |   | +---+ |   |   | +---+ | |   | | | |   | +---|---------|-|---|---------|---+     | |     |   | |   | |       |   |         | |   | | | |   |         |   |   | | |   |           | |     |   | | | "
 set pInput($i(pInput))=" |   |       |   |   | |     | |   | | | |   | |   | | |     | | | |   |     |         | |     |   | |   | |       |   |         | |   | | | |   |         |   |   | | |   |           | |     |   | | | "
 set pInput($i(pInput))=" |   |       |   |   | |     | | +---|---|-----|-----|-+     | | | |   |     |         | |     |   | |   | |       |   |         | |   | | +-|---|---------|-----------------------------------|---+ | | "
 set pInput($i(pInput))=" |   |       |   |   | |     | | | | | | |   | |   | |       | | | |   |     |         | |     |   | |   | |       |   |         | |   | |   |   |         |   |   | | |   |           | |     |     | | "
 set pInput($i(pInput))=" | +-----------------|-------|-----|---------------|-|-------|---|-----------+   +-----|-+     |   | |   | |       |   |         | |   | |   |   |         |   |   | | |   |           | |     |     | | "
 set pInput($i(pInput))=" | | |       |   |   | |     | | | | | | |   | |   | |       | | | |   |         |     |       |   | |   | |       |   |         | |   | |   |   |         |   |   | | |   |           | |     |     | | "
 set pInput($i(pInput))=" | | |   +---|---+   | |     | | | | | | |   | |   | |       | | | |   |         |     |       |   | |   | |       |   |         | |   | |   |   |         |   |   | | |   |           | |     |     | | "
 set pInput($i(pInput))=" | | |   |   |       | |     | | | | | | |   | |   | |       | | | |   |         |     |       |   | |   | |       |   |         | |   | |   |   |         |   |   | | |   |           | |     |     | | "
 set pInput($i(pInput))=" | | |   | +-|-----------------|-|---|---+   | |   | |       | | | |   |         |     |       |   +-------|-------|-------------|-|-----|-------|---------|---------|-----|-----------|-----------+ | | "
 set pInput($i(pInput))=" | | |   | | |       | |     | | | | | |     | |   | |       | | | |   |         |     |       |     |   | |       |   |         | |   | |   |   |         |   |   | | |   |           | |     |   | | | "
 set pInput($i(pInput))=" | | | +-|-|-|-------|-|-----|-|-|---|-|-----------+ |       | | | |   |       +-------|-------|---------|---------|-----+       | | +-|-+   |   | +---+   |   |   | | |   |           | |     |   | | | "
 set pInput($i(pInput))=" | | | | | | |       | |     | | | | | |     | |     |       | | | |   |       | |     |       |     |   | |       |   | |       | | | |     |   | |   |   |   |   | | |   |           | |     |   | | | "
 set pInput($i(pInput))=" | | | | | | |     +-|-|-----|-----|-|-------|-------|-------------------------+ |     |       |     |   | |       |   | +---------|-----------+ | |   |   |   |   | | |   |           | |     |   | | | "
 set pInput($i(pInput))=" | | | | | | |     | | |     | | | | | |     | |     |       | | | |   |         |     |       |     |   | |       |   |         | | | |     | | | |   |   |   |   | | |   |           | |     |   | | | "
 set pInput($i(pInput))=" | | | +---|-------+ | | +-+ | | | | | |     | |     |       | | +-|-------------|-------------|---------|---------+   | +-------|---|-------|---|---------|-----------------------------|-----+   | | | "
 set pInput($i(pInput))=" | | |   | | |       | | | | | | | | | |     | |     |       | |   |   |         |     |       |     |   | |           | |       | | | |     | | | |   |   |   |   | | |   |           | |         | | | "
 set pInput($i(pInput))=" | | |   | | |       | | +-|-|-+ +-|---|-------|-----|---+   | |   | +-----------|-----|-------------|---|-|-----------------------|-|---------------------|---|-------|---------------|-|-------+ | | | "
 set pInput($i(pInput))=" | | |   | | |       | |   | |     | | |     | |     |   |   | |   | | |         |     |       |     |   | |           | |       | | | |     | | | |   |   |   |   | | |   |           | |       | | | | "
 set pInput($i(pInput))=" | | |   | | |       | | +---|-+   | | |     | |     | +-----|-|---|-|-----------|-------+     |     |   | |           | |       | | | |     | | | |   |   |   |   | | |   |           | |       | | | | "
 set pInput($i(pInput))=" | | |   | | |       | | | | | |   | | |     | |     | | |   | |   | | |         |     | |     |     |   | |           | |       | | | |     | | | |   |   |   |   | | |   |           | |       | | | | "
 set pInput($i(pInput))=" | | |   | | |       | | | | | | +-+ | |     | |     | +-----|-----|-+ |         |     | |     |     |   | |           | |     +---|-|-|-----+ | | |   +---|-------|-------|-----------|---+     | | | | "
 set pInput($i(pInput))=" | | |   | | |       | | | | | | |   | |     | |     |   |   | |   |   |         |     | |     |     |   | |           | |     | | | | |       | | |       |   |   | | |   |           | | |     | | | | "
 set pInput($i(pInput))=" | | |   | | |       | | | | | | |   | |     | |     |   |   | |   |   |         |     | |     |     |   | |           | |     | | | | |       | | |       |   |   | | |   |           | | |     | | +-+ "
 set pInput($i(pInput))=" | | |   | | |       | | | | | | |   | |     | |     |   |   | |   |   |         |     | |     |     |   | |           | |     | | | | |       | | |       |   |   | | |   |           | | |     | |     "
 set pInput($i(pInput))=" | | |   | | |       | +---|-|-|-------|-------|-------------|-|-----------------|-------------------+   | |           | |     | | | | |     +-|-|-|-------|-------------------------------------|-----+ "
 set pInput($i(pInput))=" | | |   | | |       |   | | | | |   | |     | |     |   |   | |   |   |         |     | |     |         | |           | |     | | | | |     | | | |       |   |   | | |   |           | | |     | |   | "
 set pInput($i(pInput))=" | | |   | | |     +-|-------------+ O | +---|-|---------|-+ | |   |   |         |     | |     |         | |           | |     | | | | |     | | | |     +-+   | +-|-|-----------+     | | |     | | +-+ "
 set pInput($i(pInput))=" | | |   | | |     | |   | | | | | |   | |   | |     |   | | | |   |   |         |     | |     |         | |           | |     | | | | |     | | | |     |     | | | | |   |     |     | | |     | | |   "
 set pInput($i(pInput))=" | | |   | +-|-------|---|-------|-|---|-------------|---|-|-------|-------------------|-|-----|---------+ |           | |     | | | | |     | | | |     |     | | | | |   |     |     | | |     | | |   "
 set pInput($i(pInput))=" | | |   |   |     | |   | | | | | |   | |   | |     |   | | | |   |   |         |     | |     |           |           | |     | | | | |     | | | |     |     | | | | |   |     |     | | |     | | |   "
 set pInput($i(pInput))=" | | |   | +-|-----|-----|-|---|---|---|-----+ |     |   | +-------|-+ |         |     | |     |           |   +---------|-------|-|---|-----|-|-+ |     |     | | | | |   |     |     | | |     | | |   "
 set pInput($i(pInput))=" | | |   | | |     | |   | | | | | |   | |     |     |   |   | |   | | |         |     | |     |           |   |       | |     | | | | |     | |   |     |     | | | | |   |     |     | | |     | | |   "
 set pInput($i(pInput))=" | | |   | | |     | |   | | | | | | +---+     |     |   |   +-|-----|-|---------|-------------------------------------|---------|---|-------|-----|---+ |     | | | | |   |     |     | | |     | | |   "
 set pInput($i(pInput))=" | | |   | | |     | |   | | | | | | | |       |     |   |     |   | | |         |     | |     |           |   |       | |     | | | | |     | |   |   | |     | | | | |   |     |     | | |     | | |   "
 set pInput($i(pInput))=" | | |   | | |     | | +-|-|---|---|-|-|-------------|---------------|-----------------|-|-----|-----------|---|-------|-------+ | | | |     | |   |   | |     | | | | |   |     |     | | |     | | |   "
 set pInput($i(pInput))=" | | |   | | |     | | | | | | | | | | |       |     |   |     |   | | |         |     | |     |           |   |       | |       | | | |     | |   |   | |     | | | | |   |     |     | | |     | | |   "
 set pInput($i(pInput))=" | | | +-------------|-|-----|---|-|---|-------------|---|---+ |   | | |         |     | |     |           |   +-------|-----------|-|-------|-|---|-----|-----|-+ | | |   |     |     | | |     | | |   "
 set pInput($i(pInput))=" | | | | | | |     | | | | | | | | | | |       |     |   |   | |   | | |         |     | |     |           |           | |       | | | |     | |   |   | |     |   | | |   |     |     | | |     | | |   "
 set pInput($i(pInput))=" +-|-+ | | | |     | | | | | | | | | | |       |     |   +---|-|---|-|-|---------|-----|-------|-------------------------------------|---------|---------------|-----|-|---------------|---------+ | |   "
 set pInput($i(pInput))="   |   | | | |     | | | | | | | | | | |       |     |       | |   | | |         |     | |     |           |           | |       | | | |     | |   |   | |     |   | | |   |     |     | | |       | |   "
 set pInput($i(pInput))="   |   | | | |     | | | | | | | | | | |       |   +-|-------------|-|-----------|-------------|---------------------------------|---|-|-----------------------|-----|-----------------|---+       | |   "
 set pInput($i(pInput))="   |   | | | |     | | | | | | | | | | |       |   | |       | |   | | |         |     | |     |           |           | |       | | | |     | |   |   | |     |   | | |   |     |     | |         | |   "
 set pInput($i(pInput))="   |   | | | |     | | | | | | | | +-|-|-------|---|-|-------------|-------------|-------------------------------------+ |     +-|---|-------|-----|-----------|---+ | |   |     |     | |         | |   "
 set pInput($i(pInput))="   |   | | | |     | | | | | | | |   | |       |   | |       | |   | | |         |     | |     |           |             |     | | | | |     | |   |   | |     |     | |   |     |     | |         | |   "
 set pInput($i(pInput))="   |   | | | |     | | | | | | | |   | | +-------+ | | +-----|-----+ | |         |     | |     |           |             |     | | | | |     | +--N|-----|-----|-----|---+ |     +-------|-+       | |   "
 set pInput($i(pInput))="   |   | | | |     | | | | | | | |   | | |     | | | | |     | |     | |         |     | |     |           |             |     | | | | |     |     |   | |     |     | | | |           | | |       | |   "
 set pInput($i(pInput))="   | +-+ | | |     | | +---------|-----|-|-------+ | | |     +-|---+ | |         |     +-|-----|-----------|---------------------|---|-------|-----|-----------|-----|-+ | |           | | |       | |   "
 set pInput($i(pInput))="   | |   | | |     | |   | | | | |   | | |     |   | | |       |   | | |         |       |     |           |             |     | | | | |     |     |   | |     |     |   | |           | | |       | |   "
 set pInput($i(pInput))="   | | +---|-------|-|---|-|---------|-|-------+   | | |     +-------|-|-----------------|-----|-----------|-------------|-------------|-------+   |   | |     |     |   | |           | | |       | |   "
 set pInput($i(pInput))="   | | | | | |     | |   | | | | |   | | |         | | |     | |   | | |         |       |     |           |             |     | | | | |     | |   |   | |     |     |   | |           | | |       | |   "
 set pInput($i(pInput))="   | | | | | |     | |   | +-|-------+ | |         | | |     | |   | | |         |       |     |           |             |     | | | | |     | |   |   | |     |     |   | |           | | |       | |   "
 set pInput($i(pInput))="   | | | | | |     | |   |   | | |     | |         | | |     | |   | | |         |       |     |           |             |     | | | | |     | |   |   | |     |     |   | |           | | |       | |   "
 set pInput($i(pInput))="   | | | | | |     | |   |   | | |     | |         | | |     | |   | | |         |       |     |           |             |     | | | | +-------|---|---|-|-----------|-----|-----------|---|---+   | |   "
 set pInput($i(pInput))="   | | | | | |     | |   |   | | |     | |         | | |     | |   | | |         |       |     |           |             |     | | | |       | |   |   | |     |     |   | |           | | |   |   | |   "
 set pInput($i(pInput))="   | | | | | |     | +-------|-|-------|-|-------------------|-|-------|-------------------------------------------------|-----|-|-----------|-|---|-----|-----------|---|-|-----------+ | |   |   | |   "
 set pInput($i(pInput))="   | | | | | |     |     |   | | |     | |         | | |     | |   | | |         |       |     |           |             |     | | | |       | |   |   | |     |     |   | |             | |   |   | |   "
 set pInput($i(pInput))="   | | | | | |     | +---|-------|-------------------|-|-------|---|-|-----------------+ |     |           |             | +---+ | | |       | |   |   | |     |     |   | |             | |   |   | |   "
 set pInput($i(pInput))="   | | | | | |     | |   |   | | |     | |         | | |     | |   | | |         |     | |     |           |             | |     | | |       | |   |   | |     |     |   | |             | |   |   | |   "
 set pInput($i(pInput))="   | | | | | |     | |   |   | | |     | |         | | |     | |   | | |         |     | |     |           |             | |     | | |       | |   |   | |     |     |   | |             | |   |   | |   "
 set pInput($i(pInput))="   | | | | | |     | |   |   | | |     | |         | | |     | |   | | |         |     | |     |           |             | |     | | |       | |   |   | |     |     |   | |             | |   |   | |   "
 set pInput($i(pInput))="   | | | | | |     | |   |   | | |   +---|-----+   | | |     | |   | | |         |     | |     |           |             | |     | | +-------|-|---|-----|-----------|-------------------|-----+   | |   "
 set pInput($i(pInput))="   | | | | | |     | |   |   | | |   | | |     |   | | |     | |   | | |         |     | |     |           |             | |     | |         | |   |   | |     |     |   | |             | |       | |   "
 set pInput($i(pInput))="   | | | +-|-----------------|-+ |   | | |     |   | | |     | |   | | |         |     | |     |           |             | |     | |         | |   |   | +-----|-----|-+ | |   +-+       | |       | |   "
 set pInput($i(pInput))="   | | |   | |     | |   |   |   |   | | |     |   | | |     | |   | | |         |     | |     |           |             | |     | |         | |   |   |       |     | | | |   | |       | |       | |   "
 set pInput($i(pInput))="   +-------|-|-----|-|---|---|---------|-|-----|---|---|-----|-|---|---|---------------|-------|-----------|-------------|-------------------|-----------------------|-|-|-----|---------|-|---------|-+ "
 set pInput($i(pInput))="     | |   | |     | |   |   |   |   | | |     |   | | |     | |   | | |         |     | |     |           |             | |     | |         | |   |   |       |     | | | |   | |       | |       | | | "
 set pInput($i(pInput))="     | |   | |     | |   |   |   |   | | |     |   | | |   +-|-|-----|-|---------|-------|-------------------------------|-|-----|-----------------|---------------------|-----|-+       | |       | | | "
 set pInput($i(pInput))="     | |   | |     | |   |   |   |   | | |     |   | | |   | | |   | | |         |     | |     |           |             | |     | |         | |   |   |       |     | | | |   |         | |       | | | "
 set pInput($i(pInput))="     | |   +---------------------|---|-------------|---|---|-|-|-+ +-+ |         |     | |     |           | +-------------------------------|---------|---+   |     | | | |   |         | |       | | | "
 set pInput($i(pInput))="     | |     |     | |   |   |   |   | | |     |   | | |   | | | |     |         |     | |     |           | |           | |     | |         | |   |   |   |   |     | | | |   |         | |       | | | "
 set pInput($i(pInput))="     | |     |     | |   |   |   +---|---------|-----|-|---|-+ | |     +---------|-----|---------+         | |           | |   +-|-------+   | |   |   |   |   |     | | | |   |         | |       | | | "
 set pInput($i(pInput))="     | |     J     | |   |   |       | | |     |   | | |   |   | |               |     | |     | |         | |           | |   | | |     |   | |   |   |   |   |     | | | |   |         | |       | | | "
 set pInput($i(pInput))="     +---+   |     | |   |   |       | | |     |   | | |   |   | |               |     | |     | |         +-------------------|---------|-------------|---|---------|-|-------------+   | |       | | | "
 set pInput($i(pInput))="       | |   |     | |   |   |       | | |     |   | | |   |   | |               |     | |     | |           |           | |   | | |     |   | |   |   |   |   |     | | | |   |     |   | |       | | | "
 set pInput($i(pInput))="       | |   |     | |   |   |       | | |     | +-|-|--C--------+               |     | |     | |           |           | |   | | |     |   | |   |   |   |   |     | | | |   |     |   | |       | | | "
 set pInput($i(pInput))="       | |   |     | |   |   |       | | |     | | | | |   |   |                 |     | |     | |           |           | |   | | |     |   | |   |   |   |   |     | | | |   |     |   | |       | | | "
 set pInput($i(pInput))="     +-------------------|---------------|---------|-|-|---------------------------------|-----|-|-------------------------------|-|-----|-------------|-------------|---|-----|-----|---|-----------+ | "
 set pInput($i(pInput))="     | | |   |     | |   |   |       | | |     | | | | |   |   |                 |     | |     | |           |           | |   | | |     |   | |   |   |   |   |     | | | |   |     |   | |       |   | "
 set pInput($i(pInput))="     | | | +-------------|-----------------------|-|-|-|-------|---------+       |     | +-----|-------------|-------------|---|-------------|-|-+ |   |   |   |     | | | |   |     |   | |       |   | "
 set pInput($i(pInput))="     | | | | |     | |   |   |       | | |     | | | | |   |   |         |       |     |       | |           |           | |   | | |     |   | | | |   |   |   |     | | | |   |     |   | |       |   | "
 set pInput($i(pInput))="     | | | | |     | |   |   |       | | |     | | +-------|---|---------|---+   |     |       | |           +-------------------|-|-----------|-----------|---------+ | | |   |     |   | |       |   | "
 set pInput($i(pInput))="     | | | | |     | |   |   |       | | |     | |   | |   |   |         |   |   |     |       | |                       | |   | | |     |   | | | |   |   |   |       | | |   |     |   | |       |   | "
 set pInput($i(pInput))="     | | | | |     | | +---+ |       | | |     | |   | |   |   +---+     |   +---|-----------------------------------------|-+ | | |     |   | | | |   |   |   |       | | |   | +-------|-----------+ | "
 set pInput($i(pInput))="     | | | | |     | | | | | |       | | |     | |   | |   |       |     |       |     |       | |                       | | | | | |     |   | | | |   |   |   |       | | |   | |   |   | |       | | | "
 set pInput($i(pInput))="     | | | | |     | | | | | +-+     | | |     | |   +-|---|-------|-----|-------|---------------|-----------------------|---|-+ | |     |   | | | |   |   |   |       | | |   | |   |   | |       | | | "
 set pInput($i(pInput))="     | | | | |     | | | | |   |     | | |     | |     |   |       |     |       |     |       | |                       | | |   | |     |   | | | |   |   |   |       | | |   | |   |   | |       | | | "
 set pInput($i(pInput))="     | | | | |     | | | | | +-|-----------------------------------------+       |     |       | |                       | +-|-+ | |     |   +-----+   | +-----|-----------|---------|-----+       | | | "
 set pInput($i(pInput))="     | | | | |     | | | | | | |     | | |     | |     |   |       |             |     |       | |                       |   | | | |     |     | |     | | |   |       | | |   | |   |   |         | | | "
 set pInput($i(pInput))="     | | | | |     | | | | | | |     | | |     | |     |   |   +-------------------------------|---------------+         |   +-|-----------------|-----|-----------------|-|-----|-------------------+ | "
 set pInput($i(pInput))="     | | | | |     | | | | | | |     | | |     | |     |   |   |   |             |     |       | |             |         |     | | |     |     | |     | | |   |       | | |   | |   |   |         |   | "
 set pInput($i(pInput))="   +-+ | | | +-----|-----------+     | | |     +-|-----|---|---|-----------------|-------------|-|-----------------------+ +---|---+     |     | |     | | |   |       | | |   | |   |   |         |   | "
 set pInput($i(pInput))="   |   | | |       | | | | | |       | | |       |     |   |   |   |             |     |       | |             |           |   | |       |     | |     | | |   |       | | |   | |   |   |         |   | "
 set pInput($i(pInput))="   |   | | |       | | | | | |       | | |       |     |   +-+ |   |           +-|-----------------------------|-----------------|-------------|-------|---------------|---|---+ |   |   |         |   | "
 set pInput($i(pInput))="   |   | | |       | | | | | |       | | |       |     |     | |   |           | |     |       | |             |           |   | |       |     | |     | | |   |       | | |     |   |   |         |   | "
 set pInput($i(pInput))=" +-|---------------|-|---|-|---------|---+       |   +-------|-------------------|-------+     | | +---+       |           |   | |       |     | |     | +-------------+ | |     |   |   |         |   | "
 set pInput($i(pInput))=" | |   | | |       | | | | | |       | |         |   | |     | |   |           | |     | |     | | |   |       |           |   | |       |     | |     |   |   |         | |     |   |   |         |   | "
 set pInput($i(pInput))=" +-----|---|-+     | | | | | |       | |         |   | |     | |   +-------------|-------------|---|---|-------|---------+ |   | |       |     | |     |   |   |         | |     |   |   |         |   | "
 set pInput($i(pInput))="   |   | | | |     | | | | | |       | |         |   | |     | |               | |     | |     | | |   |       |         | |   | |       |     | |     |   |   |         | |     |   |   |         |   | "
 set pInput($i(pInput))="   |   | | | |     | | | | | |       | |         |   | |     | |             +---|-------|-------|-|---|-------|-----------|---|---------------------------|---|-----------|---------|---|-----------+ | "
 set pInput($i(pInput))="   |   | | | |     | | | | | |       | |         |   | |     | |             | | |     | |     | | |   |       |         | |   | |       |     | |     |   |   |         | |     |   |   |         | | | "
 set pInput($i(pInput))="   |   | | | +-------+ | | | +-------|-|-------------|-|-----+ |             | | |     | +-----|-|-|-----------------------|---|---------|---+ | |     |   |   |         | |     |   |   |         | | | "
 set pInput($i(pInput))="   |   | | |       |   | | |         | |         |   | |       |             | | |     |       | | |   |       |         | |   | |       |   | | |     |   |   |         | |     |   |   |         | | | "
 set pInput($i(pInput))="   |   | +---------|-+ | | |       +-+ |         |   | +-------|-------------|-|-------|---------------------------------|-----|-|-+     |   | | |     |   |   |         | |     |   |   |         | | | "
 set pInput($i(pInput))="   |   |   |       | | | | |       |   |         |   |         |             | | |     |       | | |   |       |         | |   | | |     |   | | |     |   |   |         | |     |   |   |         | | | "
 set pInput($i(pInput))=" +-+ +-+ +-----------|-+ | |       |   |         |   |         |             | | +-------------|-+ |   |       |         | |   | | |     |   | | |     |   |   |     +---|-|-----|-------+         | | | "
 set pInput($i(pInput))=" |   |   | |       | |   | |       |   |         |   |         |             | |       |       |   |   |       |         | |   | | |     |   | | |     |   |   S     |   | |     |   |             | | | "
 set pInput($i(pInput))=" | +-+   | |       | |   | |       |   |         |   |         | +-----------------------------|---|-----------+         | +-------|-----|-----|-+     |   |   |     |   | |     |   |             | | | "
 set pInput($i(pInput))=" | |     | |       | |   | |       |   |         |   |         | |           | |       |       |   |   |                 |     | | |     |   | |       |   |   |     |   | |     |   |             | | | "
 set pInput($i(pInput))=" +-+     | |       | |   | |       |   |         |   |         | |           | |       +-------|-------|-----------------|-----+ | +-----|-----|-------+   |   |     |   | |     |   |     +-------|-+ | "
 set pInput($i(pInput))="         | |       | |   | |       |   |         |   |         | |           | |               |   |   |                 |       |       |   | |           |   |     |   | |     |   |     |       |   | "
 set pInput($i(pInput))="         | |       | |   | |       |   |         |   |         | |           +-----------------+   |   +-----------------|---------------------|-----------|---------|-----|-----+   |     |       |   | "
 set pInput($i(pInput))="         | |       | |   | |       |   |         |   |         | |             |                   |                     |       |       |   | |           |   |     |   | |         |     |       |   | "
 set pInput($i(pInput))="         | |       | +-------------|---|--U--------------------|-+             |     +-------------|-------------------------------------------------------|---+     |   | |         |     |       |   | "
 set pInput($i(pInput))="         | |       |     | |       |   |         |   |         |               |     |             |                     |       |       |   | |           |         |   | |         |     |       |   | "
 set pInput($i(pInput))="         | |       |     | |       |   |         |   |         |               |     +-------------|-----------------------------|-----------------------------------------|---------+     |     +-|-+ | "
 set pInput($i(pInput))="         | |       |     | |       |   |         |   |         |               |                   |                     |       |       |   | |           |         |   | |               |     | | | | "
 set pInput($i(pInput))="     +---+ +-------|-------|-------|-----------------|---------------------------------------------|-------------------------------------------|---------------------|---|-|---------------|-----+ | | | "
 set pInput($i(pInput))="     |             |     | |       |   |         |   |         |               |                   |                     |       |       |   | |           |         |   | |               |       | | | "
 set pInput($i(pInput))="     |             +-----|-+       |   +---------+   |         |               |                   |         +-----------+       |       |   | |           +---------+   | |               |       | | | "
 set pInput($i(pInput))="     |                   |         |                 |         |               |                   |         |                   |       |   | |                         | |               |       | | | "
 set pInput($i(pInput))="     |                   |         |                 +-------------------------|-------------------|---------|---------------------------|---------------------------------+               |   +-----+ | "
 set pInput($i(pInput))="     |                   |         |                           |               |                   |         |                   |       |   | |                         |                 |   |   |   | "
 set pInput($i(pInput))="     |                   |         |                           +---------------------------------------------+                   |       |   +---------------------------+                 +---+   |   | "
 set pInput($i(pInput))="     |                   |         |                                           |                   |                             |       |     |                                                   |   | "
 set pInput($i(pInput))="     +-------------------+         +----------------------------------------T------------------------------------------------------------------|-------------------------------------------------+ |   | "
 set pInput($i(pInput))="                                                                               |                   |                             |       |     |                                                 | |   | "
 set pInput($i(pInput))="                                                                               +-------------------|-------------------------------+     |     |                                                 +-|---+ "
 set pInput($i(pInput))="                                                                                                   |                             | |     |     |                                                   |     "
 set pInput($i(pInput))="                                                                                                   +-----------------------------+ +-----+     +---------------------------------------------------+     "
 set pInput($i(pInput))="                                                                                                                                                                                                         "

	set tLevel=1
	set tPos=$find(pInput(tLevel),"|")
	set tDir="d"
	set tRes=""
	set tContinue=1
	set tTurn=0
	set tPrevDir=""
	while tContinue {
		if tDir="d" {
			set tNext=$e($g(pInput(tLevel+1)),tPos)
		} elseif tDir="u" {
			set tNext=$e($g(pInput(tLevel-1)),tPos)
		} elseif tDir="l" {
			set tNext=$e(pInput(tLevel),tPos-1)
		} elseif tDir="r" {
			set tNext=$e(pInput(tLevel),tPos+1)
		}
		if (tNext=" ") || (tNext="") {
			set tTurn=tTurn+1
			if tPrevDir="" {
				set tPrevDir=tDir
			} else {
				set tDir=tPrevDir
			}
			
			if tDir="d" {
				if tTurn=1 {
					set tDir="l"
				} elseif tTurn=2 {
					set tDir="r"
				}
			} elseif tDir="u" {
				if tTurn=1 {
					set tDir="l"
				} elseif tTurn=2 {
					set tDir="r"
				}
			} elseif tDir="l" {
				if tTurn=1 {
					set tDir="d"
				} elseif tTurn=2 {
					set tDir="u"
				}
			} elseif tDir="r" {
				if tTurn=1 {
					set tDir="d"
				} elseif tTurn=2 {
					set tDir="u"
				}
			}
			if tTurn=3 {
				set tContinue=0
			}
		}
		if (tNext'=" ")&&(tNext'="") {
			set tPrevDir=""
			set tTurn=0
			if tDir="d" {
				set tLevel=tLevel+1
			} elseif tDir="u" {
				set tLevel=tLevel-1
			} elseif tDir="l" {
				set tPos=tPos-1
			} elseif tDir="r" {
				set tPos=tPos+1
			}
			
			if (tNext'="|")&&(tNext'="-")&&(tNext'="+") {
				set tRes=tRes_tNext
			}
		}
	}
	
	quit tRes
}

ClassMethod Day19P2(pInput) As %String
{
 set pInput($i(pInput))="                                                                                                   |                                                                                                     "
 set pInput($i(pInput))=" +-------------------+               +-+ +-------+       +-------------------+                     |                                         +---+                                   +-----+       +---+ "
 set pInput($i(pInput))=" |                   |               | | |       |       |                   |                     |                                         |   |                                   |     |       |   | "
 set pInput($i(pInput))=" |         +---+     |   +---------------|-------|-----------------------+ +-----------------------------+                                   |   |                                   |     |       |   | "
 set pInput($i(pInput))=" |         |   |     |   |           | | |       |       |               | | |                     |     |                                   |   |                                   |     |       |   | "
 set pInput($i(pInput))=" |         |   +---------------------|-----------------------------------|-------------------------------------------------------------------|-----------------+           +-----------------------+   | "
 set pInput($i(pInput))=" |         |         |   |           | | |       |       |               | | |                     |     |                                   |   |             |           |         |     |           | "
 set pInput($i(pInput))=" |         |         |   +-------------|-|---------------|---------------|---|---------------------------|-------------------------+         |   |             |         +-|---------|-------------+   | "
 set pInput($i(pInput))=" |         |         |               | | |       |       |               | | |                     |     |                         |         |   |             |         | |         |     |       |   | "
 set pInput($i(pInput))=" |   +-------------------------------|-----------|-------|---------------|---|---------------------|-----|-----------------------------------|---|-------------+ +-------+ |         +-----|---+   |   | "
 set pInput($i(pInput))=" |   |     |         |               | | |       |       |               | | |                     |     |                         |         |   |               |         |               |   |   |   | "
 set pInput($i(pInput))=" |   +-+   |         |               | | |       |       |               +-+ |                     |     | +---------------------------------|---|---------------+         |               |   |   | +-+ "
 set pInput($i(pInput))=" |     |   |         |               | | |       |       |                   |                     |     | |                       |         |   |                         |               |   |   | |   "
 set pInput($i(pInput))=" |     |   |         |               | | |   +---|-------|-------------------|---------------------|-----|-|---------------------------+     | +-|-------------+           | +-----+       |   |   | |   "
 set pInput($i(pInput))=" |     |   |         |               | | |   |   |       |                   |                     |     | |                       |   |     | | |             |           | |     |       |   |   | |   "
 set pInput($i(pInput))=" | +---|-------------------------------|-|---------------|---------------+   |                   +---------------------+           +-------+ +-|-|-------------------------|-|-----|---------------|---+ "
 set pInput($i(pInput))=" | |   |   |         |               | | |   |   |       |               |   |                   | |     | |           |               |   |   | |             |           | |     |       |   |   | | | "
 set pInput($i(pInput))=" | |   +---|-------------------------|---|---|-------------------------------|-+               +-----+ +-|-----------------------------|-------|---------------|-----------|-|-----+       |   |   | | | "
 set pInput($i(pInput))=" | |       |         |               | | |   |   |       |               |   | |               | | | | | | |           |               |   |   | |             |           | |             |   |   | | | "
 set pInput($i(pInput))=" | | +---+ | +-+     |               | | |   |   |       |       +-----------|-+               | +-|-----|---------------+             |   |   | |             |           | |             |   |   | | | "
 set pInput($i(pInput))=" | | |   | | | |     |               | | |   |   |       |       |       |   |                 |   | | | | |           | |             |   |   | |             |           | |             |   |   | | | "
 set pInput($i(pInput))=" | | |   | | | |     |     +---+     | | |   |   |       |       |       |   |       +---------|---|---|-|---------------|-----------------|---|-|-------------|-------------|---------+ +-|-+ |   | | | "
 set pInput($i(pInput))=" | | |   | | | |     |     |   |     | | |   |   |       |       |       |   |       |         |   | | | | |           | |             |   |   | |             |           | |         | | | | |   | | | "
 set pInput($i(pInput))=" | | +-+ | | | |     |     |   | +-+ | | |   |   |       |       |       |   |       |         |   | | | | |           | |             |   |   | |             |           | +-----------+ | | |   | | | "
 set pInput($i(pInput))=" | |   | | | | |     |     |   | | | | | |   |   |       |       |       |   |       |         |   | | | | |           | |             |   |   | |             |           |           |   | | |   | | | "
 set pInput($i(pInput))=" | |   +-----|-|-+   |     |   | +-|-|-|-------+ |       |       | +---+ |   |       |         |   | | +-----------------------+       |   |   | |             |           |           |   | | |   | | | "
 set pInput($i(pInput))=" | |     | | | | |   |     |   |   | | | |   | | |       |       | |   | |   |       |         |   | |   | |           | |     |       |   |   | |             |           |           |   | | |   | | | "
 set pInput($i(pInput))=" | |     | | | +-|---------|---|---|-|-|-|---|---|---+   |       | |   | |   |       |         |   | |   | |           | |     |       |   |   | |             |           |           |   | | |   | | | "
 set pInput($i(pInput))=" | |     | | |   |   |     |   |   | | | |   | | |   |   |       | |   | |   |       |         |   | |   | |           | |     |       |   |   | |             |           |           |   | | |   | | | "
 set pInput($i(pInput))=" | |     | | |   |   |     |   | +-+ | | +-----|-|-------|-------------|-----|-----------------|---|-|-----|-----------|-|-----|-------|-----------------------------------|---------------|---------+ | "
 set pInput($i(pInput))=" | |     | | |   |   |     |   | |   | |     | | |   |   |       | |   | |   |       |         |   | |   | |           | |     |       |   |   | |             |           |           |   | | |   |   | "
 set pInput($i(pInput))=" | | +-----|-|---|-------------|-|-------------------|-------------|---|-|-----------|---------|---------|-----------------------------+   | +-|---------------|-+     +---------------|---|-|-------+ | "
 set pInput($i(pInput))=" | | |   | | |   |   |     |   | |   | |     | | |   |   |       | |   | |   |       |         |   | |   | |           | |     |           | | | |             | |     |   |           |   | | |   | | | "
 set pInput($i(pInput))=" | +-|-----|-|-------|-----|-----|-+ | | +-----|-|-------|---------------------------+         |   | |   | |           | |     |           | | | |             | |     |   |           +-----|-+   | | | "
 set pInput($i(pInput))=" |   |   | | |   |   |     |   | | | | | |   | | |   |   |       | |   | |   |                 |   | |   | |           | |     |           | | | |             | |     |   |               | |     | | | "
 set pInput($i(pInput))=" |   |   | | |   |   |     |   | | | | | |   | | |   |   |       | |   | |   |         +------I|---|-------|-----------|-|---------------------|---------------|-------|---|-+         +-------+   | | | "
 set pInput($i(pInput))=" |   |   | | |   |   |     |   | | | | | |   | | |   |   |       | |   | |   |         |       |   | |   | |           | |     |           | | | |             | |     |   | |         |   | | |   | | | "
 set pInput($i(pInput))=" |   |   | | |   |   |     |   +-|---|-|-|-----+ |   |   |       | |   | |   |         |       |   | |   | |       +---|-------|----Z------------|-------------|-----------|-----------|-+ | | |   | | | "
 set pInput($i(pInput))=" |   |   | | |   |   |     |     | | | | |   |   |   |   |       | |   | |   |         |       |   | |   | |       |   | |     |           | | | |             | |     |   | |         | | | | |   | | | "
 set pInput($i(pInput))=" |   |   +-|---------------|-----|---|-|-----|---+   |   |       | |   | |   |         |       |   | |   | |       |   | |     |     +-----------|-------------|-------------|-+       | | | | |   | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     |     | | | | |   |       |   |       | |   | |   |         |       |   | |   | |       |   | |     |     |     | | | |             | |     |   | | |       | | | | |   | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     |     +---|-|-----------+ | +-|-------+ |   | +-------------|-------|---|-----|---------|---|-|-------------------|-|---------------|-------|-----+ |       | | | | |   | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     |       | | | |   |     | | | |         |   |     |         |       |   | |   | |       |   | |     |     |     | | | |             | |     |   |   |       | | | | |   | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     |       | | | |   |     | | | |       +-|---|---------------|-------|---|-------|-------|---|-----------+ +---------------------------+     |   |   |     +-|---|-|-|-+ | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     |       | | | |   |     | | | |       | |   |     |         |       |   | |   | |       |   | |     |   |       | | | |             |       |   |   |     | | | | | | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     |       | | | |   |     | | | |       | |   |     |         |       |   | |   | |       |   | |     |   |       | | | |             |       |   |   |     | | | | | | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     |       | | | |   |     | | | |       | |   |     |         |       |   | |   | |       |   | |     |   |       | | | |             |       |   |   |     | | | | | | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     | +-----|---|-|---------|-|-|---------|-----------|---------|-------------|-------------------+     |   |       | | | |             |       |   |   |     | | | | | | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     | |     | | | |   |     | | | |       | |   |     |         |       |   | |   | |       |   |       |   |       | | | |             |       |   |   |     | | | | | | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     | |     | | | |   |     | | | |       | |   |     |         |       |   | |   | |       |   |       | +-|-----+ | | | |             | +-------------|-------|-|-|-+ | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     | |     | | | |   |     | | | |       | |   |     |         |       |   | |   | |       |   |       | | |     | | | | |             | |     |   |   |     | | | |   | | | | | "
 set pInput($i(pInput))=" +---------|-----|---------|-|-----|-|-|-------------------------|-|---------|---------|-----------|-|---|---------|---|-------|-------------|-|-|---------+   | |     |   |   |     | | | |   | | | | | "
 set pInput($i(pInput))="     |     | |   |   |     | |     | | | |   |     | | | |       | |   |     |         |       |   | |   | |       |   |       | | |     | | | | |         |   | |     |   |   |     | | | |   | | | | | "
 set pInput($i(pInput))="     |     | |   |   |     | |     | | | |   |     | | | |       | |   |     |         |       |   | |   | |       |   |       | | |     | | | | |         |   | |     |   |   +-+   | | | |   | | | | | "
 set pInput($i(pInput))="     |     | |   |   |     | |     | | | |   |     | | | |       | |   |     |         |       |   | |   | |       |   |       | | |     | | | | |         |   | |     |   |     |   | | | |   | | | | | "
 set pInput($i(pInput))="     |     | |   |   |     | |     | +-|-|---|-------|-----------------------|---------------------|-+   | |       |   |       | | |     | | | | |         |   | |     |   |     |   | | | |   | | | | | "
 set pInput($i(pInput))="     |     | |   |   |     | |     |   | |   |     | | | |       | |   |     |         |       |   |     | |       |   |       | M |     | | | | |         |   | |     |   |     |   | | | |   | | | | | "
 set pInput($i(pInput))=" +---|-------|---|-----------------|---|-|---|-----------|-------------------|---------------------|-----|---------|---|-------|-|-|-----------+ |         |   | |     |   |     |   | | | |   | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     | |     |   | |   |     | | | |       | |   |     |         |       |   |     | |       |   |       | | |     | | |   |         |   | |     |   |     |   | | | |   | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     | |     |   | |   |     | | | |       | |   |     |         |       |   |     | |       |   |       | | |     | | |   |         |   | |     |   |     |   | | | |   | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     | |     |   | |   |     | | | |       | |   |     |         |       |   |     | |       |   |       | | |     | | |   |         |   | |     |   |     |   | | | |   | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     | |     |   | |   |     | | | |       | |   |     |         |       |   |     | |       |   |       +-|-----+ | | |   |         |   | |     |   |     +---+ | | |   | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     | |     |   | |   |     | | | |       | |   |     |         |       |   |     | |       |   |         | |   | | | |   |         |   | |     |   |           | | |   | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     | |     |   | |   |     | | | |       | |   |     |         |       |   |     | |       |   |         | |   | | | |   |         |   | |     |   |           | | |   | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     | |     |   | |   |     | | | |       | |   |     |         |       |   |     | |       |   |         | |   | | | |   |         |   | |     |   |           | | |   | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     | |     |   | |   |     | | | +-------|---------------------|-+     |   |     | |       |   |         | |   | | | |   |         |   | +-+ +-------------------|-+   | | | | | "
 set pInput($i(pInput))=" |   |     | |   |   |     | |     |   | |   |     | | |         | |   |     |         | |     |   |     | |       |   |         | |   | | | |   |         |   |   | | |   |           | |     | | | | | "
 set pInput($i(pInput))=" |   +-+   | |   |   |     | | +-----+ | |   |     | | |       +-|-----------|---------------------|-----------------------------|-------|-|-----|-------------|-------|-----------------------|-+ | | | "
 set pInput($i(pInput))=" |     |   | |   |   |     | | |   | | | |   |     | | |       | | |   |     |         | |     |   |     | |       |   |         | |   | | | |   |         |   |   | | |   |           | |     |   | | | "
 set pInput($i(pInput))=" |   +-|-----|-------|-----|---|-----|-|-----|---------|-----+ | | |   |     |   +-----|-|-----|---|-+   | |       |   |         | |   | | | |   |         |   |   | | |   |           | |     |   | | | "
 set pInput($i(pInput))=" |   | |   | |   |   |     | | |   | | | |   |     | | |     | | | |   |     |   |     | |     |   | |   | |       |   |         | |   | | | |   |         |   |   | | |   |           | |     |   | | | "
 set pInput($i(pInput))=" |   | +---+ |   |   | +---+ | |   | | | |   | +---|---------|-|---|---------|---+     | |     |   | |   | |       |   |         | |   | | | |   |         |   |   | | |   |           | |     |   | | | "
 set pInput($i(pInput))=" |   |       |   |   | |     | |   | | | |   | |   | | |     | | | |   |     |         | |     |   | |   | |       |   |         | |   | | | |   |         |   |   | | |   |           | |     |   | | | "
 set pInput($i(pInput))=" |   |       |   |   | |     | | +---|---|-----|-----|-+     | | | |   |     |         | |     |   | |   | |       |   |         | |   | | +-|---|---------|-----------------------------------|---+ | | "
 set pInput($i(pInput))=" |   |       |   |   | |     | | | | | | |   | |   | |       | | | |   |     |         | |     |   | |   | |       |   |         | |   | |   |   |         |   |   | | |   |           | |     |     | | "
 set pInput($i(pInput))=" | +-----------------|-------|-----|---------------|-|-------|---|-----------+   +-----|-+     |   | |   | |       |   |         | |   | |   |   |         |   |   | | |   |           | |     |     | | "
 set pInput($i(pInput))=" | | |       |   |   | |     | | | | | | |   | |   | |       | | | |   |         |     |       |   | |   | |       |   |         | |   | |   |   |         |   |   | | |   |           | |     |     | | "
 set pInput($i(pInput))=" | | |   +---|---+   | |     | | | | | | |   | |   | |       | | | |   |         |     |       |   | |   | |       |   |         | |   | |   |   |         |   |   | | |   |           | |     |     | | "
 set pInput($i(pInput))=" | | |   |   |       | |     | | | | | | |   | |   | |       | | | |   |         |     |       |   | |   | |       |   |         | |   | |   |   |         |   |   | | |   |           | |     |     | | "
 set pInput($i(pInput))=" | | |   | +-|-----------------|-|---|---+   | |   | |       | | | |   |         |     |       |   +-------|-------|-------------|-|-----|-------|---------|---------|-----|-----------|-----------+ | | "
 set pInput($i(pInput))=" | | |   | | |       | |     | | | | | |     | |   | |       | | | |   |         |     |       |     |   | |       |   |         | |   | |   |   |         |   |   | | |   |           | |     |   | | | "
 set pInput($i(pInput))=" | | | +-|-|-|-------|-|-----|-|-|---|-|-----------+ |       | | | |   |       +-------|-------|---------|---------|-----+       | | +-|-+   |   | +---+   |   |   | | |   |           | |     |   | | | "
 set pInput($i(pInput))=" | | | | | | |       | |     | | | | | |     | |     |       | | | |   |       | |     |       |     |   | |       |   | |       | | | |     |   | |   |   |   |   | | |   |           | |     |   | | | "
 set pInput($i(pInput))=" | | | | | | |     +-|-|-----|-----|-|-------|-------|-------------------------+ |     |       |     |   | |       |   | +---------|-----------+ | |   |   |   |   | | |   |           | |     |   | | | "
 set pInput($i(pInput))=" | | | | | | |     | | |     | | | | | |     | |     |       | | | |   |         |     |       |     |   | |       |   |         | | | |     | | | |   |   |   |   | | |   |           | |     |   | | | "
 set pInput($i(pInput))=" | | | +---|-------+ | | +-+ | | | | | |     | |     |       | | +-|-------------|-------------|---------|---------+   | +-------|---|-------|---|---------|-----------------------------|-----+   | | | "
 set pInput($i(pInput))=" | | |   | | |       | | | | | | | | | |     | |     |       | |   |   |         |     |       |     |   | |           | |       | | | |     | | | |   |   |   |   | | |   |           | |         | | | "
 set pInput($i(pInput))=" | | |   | | |       | | +-|-|-+ +-|---|-------|-----|---+   | |   | +-----------|-----|-------------|---|-|-----------------------|-|---------------------|---|-------|---------------|-|-------+ | | | "
 set pInput($i(pInput))=" | | |   | | |       | |   | |     | | |     | |     |   |   | |   | | |         |     |       |     |   | |           | |       | | | |     | | | |   |   |   |   | | |   |           | |       | | | | "
 set pInput($i(pInput))=" | | |   | | |       | | +---|-+   | | |     | |     | +-----|-|---|-|-----------|-------+     |     |   | |           | |       | | | |     | | | |   |   |   |   | | |   |           | |       | | | | "
 set pInput($i(pInput))=" | | |   | | |       | | | | | |   | | |     | |     | | |   | |   | | |         |     | |     |     |   | |           | |       | | | |     | | | |   |   |   |   | | |   |           | |       | | | | "
 set pInput($i(pInput))=" | | |   | | |       | | | | | | +-+ | |     | |     | +-----|-----|-+ |         |     | |     |     |   | |           | |     +---|-|-|-----+ | | |   +---|-------|-------|-----------|---+     | | | | "
 set pInput($i(pInput))=" | | |   | | |       | | | | | | |   | |     | |     |   |   | |   |   |         |     | |     |     |   | |           | |     | | | | |       | | |       |   |   | | |   |           | | |     | | | | "
 set pInput($i(pInput))=" | | |   | | |       | | | | | | |   | |     | |     |   |   | |   |   |         |     | |     |     |   | |           | |     | | | | |       | | |       |   |   | | |   |           | | |     | | +-+ "
 set pInput($i(pInput))=" | | |   | | |       | | | | | | |   | |     | |     |   |   | |   |   |         |     | |     |     |   | |           | |     | | | | |       | | |       |   |   | | |   |           | | |     | |     "
 set pInput($i(pInput))=" | | |   | | |       | +---|-|-|-------|-------|-------------|-|-----------------|-------------------+   | |           | |     | | | | |     +-|-|-|-------|-------------------------------------|-----+ "
 set pInput($i(pInput))=" | | |   | | |       |   | | | | |   | |     | |     |   |   | |   |   |         |     | |     |         | |           | |     | | | | |     | | | |       |   |   | | |   |           | | |     | |   | "
 set pInput($i(pInput))=" | | |   | | |     +-|-------------+ O | +---|-|---------|-+ | |   |   |         |     | |     |         | |           | |     | | | | |     | | | |     +-+   | +-|-|-----------+     | | |     | | +-+ "
 set pInput($i(pInput))=" | | |   | | |     | |   | | | | | |   | |   | |     |   | | | |   |   |         |     | |     |         | |           | |     | | | | |     | | | |     |     | | | | |   |     |     | | |     | | |   "
 set pInput($i(pInput))=" | | |   | +-|-------|---|-------|-|---|-------------|---|-|-------|-------------------|-|-----|---------+ |           | |     | | | | |     | | | |     |     | | | | |   |     |     | | |     | | |   "
 set pInput($i(pInput))=" | | |   |   |     | |   | | | | | |   | |   | |     |   | | | |   |   |         |     | |     |           |           | |     | | | | |     | | | |     |     | | | | |   |     |     | | |     | | |   "
 set pInput($i(pInput))=" | | |   | +-|-----|-----|-|---|---|---|-----+ |     |   | +-------|-+ |         |     | |     |           |   +---------|-------|-|---|-----|-|-+ |     |     | | | | |   |     |     | | |     | | |   "
 set pInput($i(pInput))=" | | |   | | |     | |   | | | | | |   | |     |     |   |   | |   | | |         |     | |     |           |   |       | |     | | | | |     | |   |     |     | | | | |   |     |     | | |     | | |   "
 set pInput($i(pInput))=" | | |   | | |     | |   | | | | | | +---+     |     |   |   +-|-----|-|---------|-------------------------------------|---------|---|-------|-----|---+ |     | | | | |   |     |     | | |     | | |   "
 set pInput($i(pInput))=" | | |   | | |     | |   | | | | | | | |       |     |   |     |   | | |         |     | |     |           |   |       | |     | | | | |     | |   |   | |     | | | | |   |     |     | | |     | | |   "
 set pInput($i(pInput))=" | | |   | | |     | | +-|-|---|---|-|-|-------------|---------------|-----------------|-|-----|-----------|---|-------|-------+ | | | |     | |   |   | |     | | | | |   |     |     | | |     | | |   "
 set pInput($i(pInput))=" | | |   | | |     | | | | | | | | | | |       |     |   |     |   | | |         |     | |     |           |   |       | |       | | | |     | |   |   | |     | | | | |   |     |     | | |     | | |   "
 set pInput($i(pInput))=" | | | +-------------|-|-----|---|-|---|-------------|---|---+ |   | | |         |     | |     |           |   +-------|-----------|-|-------|-|---|-----|-----|-+ | | |   |     |     | | |     | | |   "
 set pInput($i(pInput))=" | | | | | | |     | | | | | | | | | | |       |     |   |   | |   | | |         |     | |     |           |           | |       | | | |     | |   |   | |     |   | | |   |     |     | | |     | | |   "
 set pInput($i(pInput))=" +-|-+ | | | |     | | | | | | | | | | |       |     |   +---|-|---|-|-|---------|-----|-------|-------------------------------------|---------|---------------|-----|-|---------------|---------+ | |   "
 set pInput($i(pInput))="   |   | | | |     | | | | | | | | | | |       |     |       | |   | | |         |     | |     |           |           | |       | | | |     | |   |   | |     |   | | |   |     |     | | |       | |   "
 set pInput($i(pInput))="   |   | | | |     | | | | | | | | | | |       |   +-|-------------|-|-----------|-------------|---------------------------------|---|-|-----------------------|-----|-----------------|---+       | |   "
 set pInput($i(pInput))="   |   | | | |     | | | | | | | | | | |       |   | |       | |   | | |         |     | |     |           |           | |       | | | |     | |   |   | |     |   | | |   |     |     | |         | |   "
 set pInput($i(pInput))="   |   | | | |     | | | | | | | | +-|-|-------|---|-|-------------|-------------|-------------------------------------+ |     +-|---|-------|-----|-----------|---+ | |   |     |     | |         | |   "
 set pInput($i(pInput))="   |   | | | |     | | | | | | | |   | |       |   | |       | |   | | |         |     | |     |           |             |     | | | | |     | |   |   | |     |     | |   |     |     | |         | |   "
 set pInput($i(pInput))="   |   | | | |     | | | | | | | |   | | +-------+ | | +-----|-----+ | |         |     | |     |           |             |     | | | | |     | +--N|-----|-----|-----|---+ |     +-------|-+       | |   "
 set pInput($i(pInput))="   |   | | | |     | | | | | | | |   | | |     | | | | |     | |     | |         |     | |     |           |             |     | | | | |     |     |   | |     |     | | | |           | | |       | |   "
 set pInput($i(pInput))="   | +-+ | | |     | | +---------|-----|-|-------+ | | |     +-|---+ | |         |     +-|-----|-----------|---------------------|---|-------|-----|-----------|-----|-+ | |           | | |       | |   "
 set pInput($i(pInput))="   | |   | | |     | |   | | | | |   | | |     |   | | |       |   | | |         |       |     |           |             |     | | | | |     |     |   | |     |     |   | |           | | |       | |   "
 set pInput($i(pInput))="   | | +---|-------|-|---|-|---------|-|-------+   | | |     +-------|-|-----------------|-----|-----------|-------------|-------------|-------+   |   | |     |     |   | |           | | |       | |   "
 set pInput($i(pInput))="   | | | | | |     | |   | | | | |   | | |         | | |     | |   | | |         |       |     |           |             |     | | | | |     | |   |   | |     |     |   | |           | | |       | |   "
 set pInput($i(pInput))="   | | | | | |     | |   | +-|-------+ | |         | | |     | |   | | |         |       |     |           |             |     | | | | |     | |   |   | |     |     |   | |           | | |       | |   "
 set pInput($i(pInput))="   | | | | | |     | |   |   | | |     | |         | | |     | |   | | |         |       |     |           |             |     | | | | |     | |   |   | |     |     |   | |           | | |       | |   "
 set pInput($i(pInput))="   | | | | | |     | |   |   | | |     | |         | | |     | |   | | |         |       |     |           |             |     | | | | +-------|---|---|-|-----------|-----|-----------|---|---+   | |   "
 set pInput($i(pInput))="   | | | | | |     | |   |   | | |     | |         | | |     | |   | | |         |       |     |           |             |     | | | |       | |   |   | |     |     |   | |           | | |   |   | |   "
 set pInput($i(pInput))="   | | | | | |     | +-------|-|-------|-|-------------------|-|-------|-------------------------------------------------|-----|-|-----------|-|---|-----|-----------|---|-|-----------+ | |   |   | |   "
 set pInput($i(pInput))="   | | | | | |     |     |   | | |     | |         | | |     | |   | | |         |       |     |           |             |     | | | |       | |   |   | |     |     |   | |             | |   |   | |   "
 set pInput($i(pInput))="   | | | | | |     | +---|-------|-------------------|-|-------|---|-|-----------------+ |     |           |             | +---+ | | |       | |   |   | |     |     |   | |             | |   |   | |   "
 set pInput($i(pInput))="   | | | | | |     | |   |   | | |     | |         | | |     | |   | | |         |     | |     |           |             | |     | | |       | |   |   | |     |     |   | |             | |   |   | |   "
 set pInput($i(pInput))="   | | | | | |     | |   |   | | |     | |         | | |     | |   | | |         |     | |     |           |             | |     | | |       | |   |   | |     |     |   | |             | |   |   | |   "
 set pInput($i(pInput))="   | | | | | |     | |   |   | | |     | |         | | |     | |   | | |         |     | |     |           |             | |     | | |       | |   |   | |     |     |   | |             | |   |   | |   "
 set pInput($i(pInput))="   | | | | | |     | |   |   | | |   +---|-----+   | | |     | |   | | |         |     | |     |           |             | |     | | +-------|-|---|-----|-----------|-------------------|-----+   | |   "
 set pInput($i(pInput))="   | | | | | |     | |   |   | | |   | | |     |   | | |     | |   | | |         |     | |     |           |             | |     | |         | |   |   | |     |     |   | |             | |       | |   "
 set pInput($i(pInput))="   | | | +-|-----------------|-+ |   | | |     |   | | |     | |   | | |         |     | |     |           |             | |     | |         | |   |   | +-----|-----|-+ | |   +-+       | |       | |   "
 set pInput($i(pInput))="   | | |   | |     | |   |   |   |   | | |     |   | | |     | |   | | |         |     | |     |           |             | |     | |         | |   |   |       |     | | | |   | |       | |       | |   "
 set pInput($i(pInput))="   +-------|-|-----|-|---|---|---------|-|-----|---|---|-----|-|---|---|---------------|-------|-----------|-------------|-------------------|-----------------------|-|-|-----|---------|-|---------|-+ "
 set pInput($i(pInput))="     | |   | |     | |   |   |   |   | | |     |   | | |     | |   | | |         |     | |     |           |             | |     | |         | |   |   |       |     | | | |   | |       | |       | | | "
 set pInput($i(pInput))="     | |   | |     | |   |   |   |   | | |     |   | | |   +-|-|-----|-|---------|-------|-------------------------------|-|-----|-----------------|---------------------|-----|-+       | |       | | | "
 set pInput($i(pInput))="     | |   | |     | |   |   |   |   | | |     |   | | |   | | |   | | |         |     | |     |           |             | |     | |         | |   |   |       |     | | | |   |         | |       | | | "
 set pInput($i(pInput))="     | |   +---------------------|---|-------------|---|---|-|-|-+ +-+ |         |     | |     |           | +-------------------------------|---------|---+   |     | | | |   |         | |       | | | "
 set pInput($i(pInput))="     | |     |     | |   |   |   |   | | |     |   | | |   | | | |     |         |     | |     |           | |           | |     | |         | |   |   |   |   |     | | | |   |         | |       | | | "
 set pInput($i(pInput))="     | |     |     | |   |   |   +---|---------|-----|-|---|-+ | |     +---------|-----|---------+         | |           | |   +-|-------+   | |   |   |   |   |     | | | |   |         | |       | | | "
 set pInput($i(pInput))="     | |     J     | |   |   |       | | |     |   | | |   |   | |               |     | |     | |         | |           | |   | | |     |   | |   |   |   |   |     | | | |   |         | |       | | | "
 set pInput($i(pInput))="     +---+   |     | |   |   |       | | |     |   | | |   |   | |               |     | |     | |         +-------------------|---------|-------------|---|---------|-|-------------+   | |       | | | "
 set pInput($i(pInput))="       | |   |     | |   |   |       | | |     |   | | |   |   | |               |     | |     | |           |           | |   | | |     |   | |   |   |   |   |     | | | |   |     |   | |       | | | "
 set pInput($i(pInput))="       | |   |     | |   |   |       | | |     | +-|-|--C--------+               |     | |     | |           |           | |   | | |     |   | |   |   |   |   |     | | | |   |     |   | |       | | | "
 set pInput($i(pInput))="       | |   |     | |   |   |       | | |     | | | | |   |   |                 |     | |     | |           |           | |   | | |     |   | |   |   |   |   |     | | | |   |     |   | |       | | | "
 set pInput($i(pInput))="     +-------------------|---------------|---------|-|-|---------------------------------|-----|-|-------------------------------|-|-----|-------------|-------------|---|-----|-----|---|-----------+ | "
 set pInput($i(pInput))="     | | |   |     | |   |   |       | | |     | | | | |   |   |                 |     | |     | |           |           | |   | | |     |   | |   |   |   |   |     | | | |   |     |   | |       |   | "
 set pInput($i(pInput))="     | | | +-------------|-----------------------|-|-|-|-------|---------+       |     | +-----|-------------|-------------|---|-------------|-|-+ |   |   |   |     | | | |   |     |   | |       |   | "
 set pInput($i(pInput))="     | | | | |     | |   |   |       | | |     | | | | |   |   |         |       |     |       | |           |           | |   | | |     |   | | | |   |   |   |     | | | |   |     |   | |       |   | "
 set pInput($i(pInput))="     | | | | |     | |   |   |       | | |     | | +-------|---|---------|---+   |     |       | |           +-------------------|-|-----------|-----------|---------+ | | |   |     |   | |       |   | "
 set pInput($i(pInput))="     | | | | |     | |   |   |       | | |     | |   | |   |   |         |   |   |     |       | |                       | |   | | |     |   | | | |   |   |   |       | | |   |     |   | |       |   | "
 set pInput($i(pInput))="     | | | | |     | | +---+ |       | | |     | |   | |   |   +---+     |   +---|-----------------------------------------|-+ | | |     |   | | | |   |   |   |       | | |   | +-------|-----------+ | "
 set pInput($i(pInput))="     | | | | |     | | | | | |       | | |     | |   | |   |       |     |       |     |       | |                       | | | | | |     |   | | | |   |   |   |       | | |   | |   |   | |       | | | "
 set pInput($i(pInput))="     | | | | |     | | | | | +-+     | | |     | |   +-|---|-------|-----|-------|---------------|-----------------------|---|-+ | |     |   | | | |   |   |   |       | | |   | |   |   | |       | | | "
 set pInput($i(pInput))="     | | | | |     | | | | |   |     | | |     | |     |   |       |     |       |     |       | |                       | | |   | |     |   | | | |   |   |   |       | | |   | |   |   | |       | | | "
 set pInput($i(pInput))="     | | | | |     | | | | | +-|-----------------------------------------+       |     |       | |                       | +-|-+ | |     |   +-----+   | +-----|-----------|---------|-----+       | | | "
 set pInput($i(pInput))="     | | | | |     | | | | | | |     | | |     | |     |   |       |             |     |       | |                       |   | | | |     |     | |     | | |   |       | | |   | |   |   |         | | | "
 set pInput($i(pInput))="     | | | | |     | | | | | | |     | | |     | |     |   |   +-------------------------------|---------------+         |   +-|-----------------|-----|-----------------|-|-----|-------------------+ | "
 set pInput($i(pInput))="     | | | | |     | | | | | | |     | | |     | |     |   |   |   |             |     |       | |             |         |     | | |     |     | |     | | |   |       | | |   | |   |   |         |   | "
 set pInput($i(pInput))="   +-+ | | | +-----|-----------+     | | |     +-|-----|---|---|-----------------|-------------|-|-----------------------+ +---|---+     |     | |     | | |   |       | | |   | |   |   |         |   | "
 set pInput($i(pInput))="   |   | | |       | | | | | |       | | |       |     |   |   |   |             |     |       | |             |           |   | |       |     | |     | | |   |       | | |   | |   |   |         |   | "
 set pInput($i(pInput))="   |   | | |       | | | | | |       | | |       |     |   +-+ |   |           +-|-----------------------------|-----------------|-------------|-------|---------------|---|---+ |   |   |         |   | "
 set pInput($i(pInput))="   |   | | |       | | | | | |       | | |       |     |     | |   |           | |     |       | |             |           |   | |       |     | |     | | |   |       | | |     |   |   |         |   | "
 set pInput($i(pInput))=" +-|---------------|-|---|-|---------|---+       |   +-------|-------------------|-------+     | | +---+       |           |   | |       |     | |     | +-------------+ | |     |   |   |         |   | "
 set pInput($i(pInput))=" | |   | | |       | | | | | |       | |         |   | |     | |   |           | |     | |     | | |   |       |           |   | |       |     | |     |   |   |         | |     |   |   |         |   | "
 set pInput($i(pInput))=" +-----|---|-+     | | | | | |       | |         |   | |     | |   +-------------|-------------|---|---|-------|---------+ |   | |       |     | |     |   |   |         | |     |   |   |         |   | "
 set pInput($i(pInput))="   |   | | | |     | | | | | |       | |         |   | |     | |               | |     | |     | | |   |       |         | |   | |       |     | |     |   |   |         | |     |   |   |         |   | "
 set pInput($i(pInput))="   |   | | | |     | | | | | |       | |         |   | |     | |             +---|-------|-------|-|---|-------|-----------|---|---------------------------|---|-----------|---------|---|-----------+ | "
 set pInput($i(pInput))="   |   | | | |     | | | | | |       | |         |   | |     | |             | | |     | |     | | |   |       |         | |   | |       |     | |     |   |   |         | |     |   |   |         | | | "
 set pInput($i(pInput))="   |   | | | +-------+ | | | +-------|-|-------------|-|-----+ |             | | |     | +-----|-|-|-----------------------|---|---------|---+ | |     |   |   |         | |     |   |   |         | | | "
 set pInput($i(pInput))="   |   | | |       |   | | |         | |         |   | |       |             | | |     |       | | |   |       |         | |   | |       |   | | |     |   |   |         | |     |   |   |         | | | "
 set pInput($i(pInput))="   |   | +---------|-+ | | |       +-+ |         |   | +-------|-------------|-|-------|---------------------------------|-----|-|-+     |   | | |     |   |   |         | |     |   |   |         | | | "
 set pInput($i(pInput))="   |   |   |       | | | | |       |   |         |   |         |             | | |     |       | | |   |       |         | |   | | |     |   | | |     |   |   |         | |     |   |   |         | | | "
 set pInput($i(pInput))=" +-+ +-+ +-----------|-+ | |       |   |         |   |         |             | | +-------------|-+ |   |       |         | |   | | |     |   | | |     |   |   |     +---|-|-----|-------+         | | | "
 set pInput($i(pInput))=" |   |   | |       | |   | |       |   |         |   |         |             | |       |       |   |   |       |         | |   | | |     |   | | |     |   |   S     |   | |     |   |             | | | "
 set pInput($i(pInput))=" | +-+   | |       | |   | |       |   |         |   |         | +-----------------------------|---|-----------+         | +-------|-----|-----|-+     |   |   |     |   | |     |   |             | | | "
 set pInput($i(pInput))=" | |     | |       | |   | |       |   |         |   |         | |           | |       |       |   |   |                 |     | | |     |   | |       |   |   |     |   | |     |   |             | | | "
 set pInput($i(pInput))=" +-+     | |       | |   | |       |   |         |   |         | |           | |       +-------|-------|-----------------|-----+ | +-----|-----|-------+   |   |     |   | |     |   |     +-------|-+ | "
 set pInput($i(pInput))="         | |       | |   | |       |   |         |   |         | |           | |               |   |   |                 |       |       |   | |           |   |     |   | |     |   |     |       |   | "
 set pInput($i(pInput))="         | |       | |   | |       |   |         |   |         | |           +-----------------+   |   +-----------------|---------------------|-----------|---------|-----|-----+   |     |       |   | "
 set pInput($i(pInput))="         | |       | |   | |       |   |         |   |         | |             |                   |                     |       |       |   | |           |   |     |   | |         |     |       |   | "
 set pInput($i(pInput))="         | |       | +-------------|---|--U--------------------|-+             |     +-------------|-------------------------------------------------------|---+     |   | |         |     |       |   | "
 set pInput($i(pInput))="         | |       |     | |       |   |         |   |         |               |     |             |                     |       |       |   | |           |         |   | |         |     |       |   | "
 set pInput($i(pInput))="         | |       |     | |       |   |         |   |         |               |     +-------------|-----------------------------|-----------------------------------------|---------+     |     +-|-+ | "
 set pInput($i(pInput))="         | |       |     | |       |   |         |   |         |               |                   |                     |       |       |   | |           |         |   | |               |     | | | | "
 set pInput($i(pInput))="     +---+ +-------|-------|-------|-----------------|---------------------------------------------|-------------------------------------------|---------------------|---|-|---------------|-----+ | | | "
 set pInput($i(pInput))="     |             |     | |       |   |         |   |         |               |                   |                     |       |       |   | |           |         |   | |               |       | | | "
 set pInput($i(pInput))="     |             +-----|-+       |   +---------+   |         |               |                   |         +-----------+       |       |   | |           +---------+   | |               |       | | | "
 set pInput($i(pInput))="     |                   |         |                 |         |               |                   |         |                   |       |   | |                         | |               |       | | | "
 set pInput($i(pInput))="     |                   |         |                 +-------------------------|-------------------|---------|---------------------------|---------------------------------+               |   +-----+ | "
 set pInput($i(pInput))="     |                   |         |                           |               |                   |         |                   |       |   | |                         |                 |   |   |   | "
 set pInput($i(pInput))="     |                   |         |                           +---------------------------------------------+                   |       |   +---------------------------+                 +---+   |   | "
 set pInput($i(pInput))="     |                   |         |                                           |                   |                             |       |     |                                                   |   | "
 set pInput($i(pInput))="     +-------------------+         +----------------------------------------T------------------------------------------------------------------|-------------------------------------------------+ |   | "
 set pInput($i(pInput))="                                                                               |                   |                             |       |     |                                                 | |   | "
 set pInput($i(pInput))="                                                                               +-------------------|-------------------------------+     |     |                                                 +-|---+ "
 set pInput($i(pInput))="                                                                                                   |                             | |     |     |                                                   |     "
 set pInput($i(pInput))="                                                                                                   +-----------------------------+ +-----+     +---------------------------------------------------+     "
 set pInput($i(pInput))="                                                                                                                                                                                                         "

	set tLevel=1
	set tPos=$find(pInput(tLevel),"|")
	set tDir="d"
	set tRes=""
	set tContinue=1
	set tTurn=0
	set tPrevDir=""
	set tCount=0
	while tContinue {
		if tDir="d" {
			set tNext=$e($g(pInput(tLevel+1)),tPos)
		} elseif tDir="u" {
			set tNext=$e($g(pInput(tLevel-1)),tPos)
		} elseif tDir="l" {
			set tNext=$e(pInput(tLevel),tPos-1)
		} elseif tDir="r" {
			set tNext=$e(pInput(tLevel),tPos+1)
		}
		if (tNext=" ") || (tNext="") {
			set tTurn=tTurn+1
			if tPrevDir="" {
				set tPrevDir=tDir
			} else {
				set tDir=tPrevDir
			}
			
			if tDir="d" {
				if tTurn=1 {
					set tDir="l"
				} elseif tTurn=2 {
					set tDir="r"
				}
			} elseif tDir="u" {
				if tTurn=1 {
					set tDir="l"
				} elseif tTurn=2 {
					set tDir="r"
				}
			} elseif tDir="l" {
				if tTurn=1 {
					set tDir="d"
				} elseif tTurn=2 {
					set tDir="u"
				}
			} elseif tDir="r" {
				if tTurn=1 {
					set tDir="d"
				} elseif tTurn=2 {
					set tDir="u"
				}
			}
			if tTurn=3 {
				set tContinue=0
			}
		}
		if (tNext'=" ")&&(tNext'="") {
			set tPrevDir=""
			set tTurn=0
			set tCount=tCount+1
			if tDir="d" {
				set tLevel=tLevel+1
			} elseif tDir="u" {
				set tLevel=tLevel-1
			} elseif tDir="l" {
				set tPos=tPos-1
			} elseif tDir="r" {
				set tPos=tPos+1
			}
		}
	}
	
	quit tCount
}

ClassMethod Day20P1(pInput) As %String
{
	 set pInput($i(pInput))="p=<1199,-2918,1457>, v=<-13,115,-8>, a=<-7,8,-10>"
 set pInput($i(pInput))="p=<2551,2418,-1471>, v=<-106,-108,39>, a=<-6,-5,6>"
 set pInput($i(pInput))="p=<-73,1626,1321>, v=<58,-118,-8>, a=<-6,2,-9>"
 set pInput($i(pInput))="p=<-3297,-894,-551>, v=<183,31,-61>, a=<3,3,11>"
 set pInput($i(pInput))="p=<-1425,4298,617>, v=<32,-166,-32>, a=<7,-12,-1>"
 set pInput($i(pInput))="p=<-3718,877,1043>, v=<114,7,-20>, a=<10,-6,-4>"
 set pInput($i(pInput))="p=<-2089,-239,1142>, v=<52,12,3>, a=<7,0,-7>"
 set pInput($i(pInput))="p=<782,994,3311>, v=<16,-28,-32>, a=<-6,-3,-16>"
 set pInput($i(pInput))="p=<-937,2596,-109>, v=<-12,-117,-13>, a=<7,-3,2>"
 set pInput($i(pInput))="p=<-865,-2930,-1387>, v=<60,76,-56>, a=<-1,9,14>"
 set pInput($i(pInput))="p=<1196,-3308,2564>, v=<-26,59,0>, a=<-4,13,-15>"
 set pInput($i(pInput))="p=<-271,1957,-2944>, v=<8,-15,40>, a=<1,-10,13>"
 set pInput($i(pInput))="p=<-964,1228,1583>, v=<18,16,-12>, a=<4,-9,-8>"
 set pInput($i(pInput))="p=<-1639,1174,1970>, v=<84,-114,-138>, a=<1,5,3>"
 set pInput($i(pInput))="p=<-1840,1679,-1764>, v=<44,-20,91>, a=<8,-10,2>"
 set pInput($i(pInput))="p=<1104,-233,140>, v=<-21,-11,-28>, a=<-6,3,2>"
 set pInput($i(pInput))="p=<1136,-361,-3100>, v=<-40,14,98>, a=<-4,1,11>"
 set pInput($i(pInput))="p=<1480,-265,-1412>, v=<-36,42,18>, a=<-7,-3,8>"
 set pInput($i(pInput))="p=<144,-1217,-660>, v=<39,25,56>, a=<-6,6,-2>"
 set pInput($i(pInput))="p=<360,295,276>, v=<-51,-95,-11>, a=<3,9,-1>"
 set pInput($i(pInput))="p=<-2656,487,1228>, v=<78,12,-11>, a=<10,-5,-8>"
 set pInput($i(pInput))="p=<-1400,2295,-204>, v=<-9,-67,53>, a=<11,-9,-5>"
 set pInput($i(pInput))="p=<-1016,-769,-52>, v=<1,14,120>, a=<7,4,-14>"
 set pInput($i(pInput))="p=<1536,4167,-940>, v=<-99,-201,82>, a=<0,-7,-3>"
 set pInput($i(pInput))="p=<2398,3917,2412>, v=<-69,-51,-81>, a=<-3,-10,-2>"
 set pInput($i(pInput))="p=<-3283,536,733>, v=<46,72,-32>, a=<8,-8,0>"
 set pInput($i(pInput))="p=<-247,1180,-2901>, v=<46,-52,-18>, a=<-3,0,12>"
 set pInput($i(pInput))="p=<-2984,-499,-1475>, v=<-3,57,-8>, a=<11,-3,6>"
 set pInput($i(pInput))="p=<-431,2008,-3890>, v=<54,-40,49>, a=<-3,-4,10>"
 set pInput($i(pInput))="p=<2904,-775,-3614>, v=<5,-3,97>, a=<-11,3,5>"
 set pInput($i(pInput))="p=<2697,-1074,3401>, v=<38,70,-28>, a=<-13,-2,-10>"
 set pInput($i(pInput))="p=<-1259,1456,595>, v=<42,8,34>, a=<1,-6,-5>"
 set pInput($i(pInput))="p=<-1293,5020,-2110>, v=<-12,-199,93>, a=<7,-5,1>"
 set pInput($i(pInput))="p=<-1753,-1520,-320>, v=<-10,44,14>, a=<9,3,0>"
 set pInput($i(pInput))="p=<-2143,1040,-2220>, v=<83,-42,109>, a=<2,-1,0>"
 set pInput($i(pInput))="p=<-203,3210,-530>, v=<-56,-98,35>, a=<6,-6,-1>"
 set pInput($i(pInput))="p=<3017,-3820,290>, v=<-154,96,-6>, a=<0,9,-1>"
 set pInput($i(pInput))="p=<-1195,-180,-289>, v=<93,-30,-2>, a=<1,6,4>"
 set pInput($i(pInput))="p=<371,1368,953>, v=<-18,-16,-125>, a=<-2,-16,7>"
 set pInput($i(pInput))="p=<-1777,-426,-523>, v=<187,-16,24>, a=<-6,7,3>"
 set pInput($i(pInput))="p=<-2635,690,-1177>, v=<148,-83,59>, a=<11,3,6>"
 set pInput($i(pInput))="p=<431,-366,-1333>, v=<-62,18,124>, a=<4,1,-2>"
 set pInput($i(pInput))="p=<-2311,-750,143>, v=<147,11,-51>, a=<7,7,6>"
 set pInput($i(pInput))="p=<-151,354,-85>, v=<97,-29,-84>, a=<-13,-1,14>"
 set pInput($i(pInput))="p=<-325,-1602,779>, v=<-25,56,-13>, a=<8,11,-8>"
 set pInput($i(pInput))="p=<-385,-204,467>, v=<-7,37,0>, a=<6,-4,-6>"
 set pInput($i(pInput))="p=<665,-1272,-1195>, v=<-10,35,80>, a=<-7,10,3>"
 set pInput($i(pInput))="p=<-2525,7592,-6216>, v=<43,-14,0>, a=<1,-9,8>"
 set pInput($i(pInput))="p=<-68,4433,8721>, v=<-120,-113,-63>, a=<6,0,-8>"
 set pInput($i(pInput))="p=<-6971,-91,-561>, v=<-43,3,15>, a=<11,0,0>"
 set pInput($i(pInput))="p=<-2876,806,-8478>, v=<72,-60,58>, a=<0,2,8>"
 set pInput($i(pInput))="p=<-7907,4004,258>, v=<61,-42,-46>, a=<7,-3,2>"
 set pInput($i(pInput))="p=<-4358,6773,5523>, v=<50,-73,39>, a=<3,-5,-9>"
 set pInput($i(pInput))="p=<1941,1823,224>, v=<-102,-73,-54>, a=<1,-1,4>"
 set pInput($i(pInput))="p=<-1440,-1768,224>, v=<70,87,67>, a=<0,0,-7>"
 set pInput($i(pInput))="p=<-1776,3125,2870>, v=<20,-58,-4>, a=<6,-8,-12>"
 set pInput($i(pInput))="p=<1437,-697,-5635>, v=<-12,25,115>, a=<-5,1,14>"
 set pInput($i(pInput))="p=<-3603,-151,2366>, v=<30,-89,31>, a=<13,9,-13>"
 set pInput($i(pInput))="p=<-264,4805,3857>, v=<3,-105,-40>, a=<1,-11,-13>"
 set pInput($i(pInput))="p=<-831,-823,140>, v=<52,-35,5>, a=<-1,7,-1>"
 set pInput($i(pInput))="p=<2970,-634,1085>, v=<-52,110,-18>, a=<-8,-7,-3>"
 set pInput($i(pInput))="p=<1755,-4503,-1198>, v=<-18,102,8>, a=<-4,6,3>"
 set pInput($i(pInput))="p=<-4945,572,1727>, v=<42,-101,-5>, a=<12,6,-5>"
 set pInput($i(pInput))="p=<-70,5047,-2023>, v=<3,45,54>, a=<0,-19,2>"
 set pInput($i(pInput))="p=<-2845,4372,-2598>, v=<75,-110,116>, a=<3,-5,-1>"
 set pInput($i(pInput))="p=<-345,-228,-1898>, v=<-38,61,88>, a=<4,-4,-1>"
 set pInput($i(pInput))="p=<-2720,3622,1727>, v=<109,-2,-83>, a=<0,-11,1>"
 set pInput($i(pInput))="p=<-4045,-3228,-2448>, v=<-7,116,-7>, a=<13,1,8>"
 set pInput($i(pInput))="p=<580,3347,802>, v=<-10,48,19>, a=<-1,-14,-4>"
 set pInput($i(pInput))="p=<-1910,2875,1236>, v=<71,-54,88>, a=<-1,-1,-6>"
 set pInput($i(pInput))="p=<-2963,-6485,2406>, v=<-102,86,-42>, a=<9,4,-1>"
 set pInput($i(pInput))="p=<-18875,7633,-7890>, v=<86,-76,82>, a=<20,-6,6>"
 set pInput($i(pInput))="p=<391,9505,4980>, v=<-8,76,-108>, a=<0,-16,-1>"
 set pInput($i(pInput))="p=<-935,5800,-1533>, v=<-114,-129,59>, a=<7,-1,-1>"
 set pInput($i(pInput))="p=<-272,-7733,12858>, v=<69,18,10>, a=<-3,9,-17>"
 set pInput($i(pInput))="p=<-7292,613,12741>, v=<49,-116,-47>, a=<7,5,-14>"
 set pInput($i(pInput))="p=<3550,-518,-15339>, v=<51,33,73>, a=<-7,-1,16>"
 set pInput($i(pInput))="p=<4213,-8123,-2157>, v=<14,88,55>, a=<-6,6,0>"
 set pInput($i(pInput))="p=<-7721,418,-17250>, v=<80,69,2>, a=<6,-4,22>"
 set pInput($i(pInput))="p=<1738,-2831,-158>, v=<40,35,8>, a=<-12,10,0>"
 set pInput($i(pInput))="p=<2598,399,782>, v=<-66,10,45>, a=<-6,-3,-8>"
 set pInput($i(pInput))="p=<3068,129,-1558>, v=<-58,13,57>, a=<-9,-2,2>"
 set pInput($i(pInput))="p=<-1782,4139,-3628>, v=<-99,-93,171>, a=<18,-11,1>"
 set pInput($i(pInput))="p=<-1082,-3161,-498>, v=<55,83,67>, a=<0,7,-4>"
 set pInput($i(pInput))="p=<-5302,-1291,772>, v=<98,42,-70>, a=<16,2,3>"
 set pInput($i(pInput))="p=<808,979,232>, v=<-50,2,-1>, a=<1,-5,-1>"
 set pInput($i(pInput))="p=<-152,1479,-8>, v=<-86,61,11>, a=<9,-13,-1>"
 set pInput($i(pInput))="p=<1292,1700,-858>, v=<-72,-94,96>, a=<-4,-5,-4>"
 set pInput($i(pInput))="p=<304,-640,-455>, v=<53,-12,72>, a=<-11,9,-5>"
 set pInput($i(pInput))="p=<486,1063,-689>, v=<-52,-66,27>, a=<2,-2,4>"
 set pInput($i(pInput))="p=<993,-1823,182>, v=<-84,30,-47>, a=<1,16,5>"
 set pInput($i(pInput))="p=<-1230,-1615,-312>, v=<52,182,96>, a=<6,-8,-10>"
 set pInput($i(pInput))="p=<-268,1297,728>, v=<20,-105,-40>, a=<0,1,-2>"
 set pInput($i(pInput))="p=<1476,1697,875>, v=<5,-87,-71>, a=<-15,-5,1>"
 set pInput($i(pInput))="p=<1476,1193,-1813>, v=<-85,-51,46>, a=<-3,-5,11>"
 set pInput($i(pInput))="p=<932,-6376,-4019>, v=<-47,24,-82>, a=<1,12,14>"
 set pInput($i(pInput))="p=<-12763,29,8401>, v=<177,-19,-62>, a=<16,1,-14>"
 set pInput($i(pInput))="p=<5087,6059,1936>, v=<-139,-65,76>, a=<-2,-9,-9>"
 set pInput($i(pInput))="p=<-853,-721,-4889>, v=<28,6,40>, a=<0,1,8>"
 set pInput($i(pInput))="p=<-1288,329,-11219>, v=<58,33,96>, a=<-1,-3,18>"
 set pInput($i(pInput))="p=<1352,-286,4051>, v=<-61,38,-10>, a=<1,-2,-8>"
 set pInput($i(pInput))="p=<2477,-271,-4649>, v=<41,-40,32>, a=<-8,3,8>"
 set pInput($i(pInput))="p=<-1783,-376,-6944>, v=<59,41,155>, a=<0,-2,5>"
 set pInput($i(pInput))="p=<-8728,2204,-1514>, v=<27,48,-26>, a=<17,-8,5>"
 set pInput($i(pInput))="p=<2987,-7276,-1829>, v=<-100,54,-31>, a=<0,12,6>"
 set pInput($i(pInput))="p=<-86,2277,1643>, v=<48,-108,-103>, a=<-4,0,2>"
 set pInput($i(pInput))="p=<-1640,-726,3722>, v=<45,24,-48>, a=<3,1,-12>"
 set pInput($i(pInput))="p=<334,-4947,761>, v=<-82,71,-28>, a=<6,15,-1>"
 set pInput($i(pInput))="p=<2686,1290,572>, v=<-106,16,-41>, a=<-2,-7,1>"
 set pInput($i(pInput))="p=<1153,3663,152>, v=<-110,35,45>, a=<5,-19,-5>"
 set pInput($i(pInput))="p=<-3257,-957,-2620>, v=<45,35,-32>, a=<10,1,14>"
 set pInput($i(pInput))="p=<-4958,4524,-2179>, v=<16,-127,13>, a=<20,-8,8>"
 set pInput($i(pInput))="p=<-1913,2844,-898>, v=<47,-135,40>, a=<4,0,0>"
 set pInput($i(pInput))="p=<-3826,-5200,5502>, v=<-27,-24,31>, a=<8,10,-11>"
 set pInput($i(pInput))="p=<50,-7529,4380>, v=<34,27,-6>, a=<-2,11,-7>"
 set pInput($i(pInput))="p=<-362,3,273>, v=<20,20,-5>, a=<3,-4,-4>"
 set pInput($i(pInput))="p=<-927,-577,-887>, v=<82,89,56>, a=<2,-6,6>"
 set pInput($i(pInput))="p=<-942,-727,1133>, v=<78,-6,-102>, a=<3,14,-2>"
 set pInput($i(pInput))="p=<-92,-817,-222>, v=<-73,80,17>, a=<15,0,1>"
 set pInput($i(pInput))="p=<-1062,-87,-642>, v=<68,7,59>, a=<7,0,1>"
 set pInput($i(pInput))="p=<-532,-1332,-537>, v=<4,27,65>, a=<9,19,-2>"
 set pInput($i(pInput))="p=<8,888,968>, v=<-17,-19,-58>, a=<3,-13,-7>"
 set pInput($i(pInput))="p=<-1188,-1222,249>, v=<-13,12,39>, a=<5,3,-4>"
 set pInput($i(pInput))="p=<-672,-814,1713>, v=<28,45,3>, a=<0,-1,-6>"
 set pInput($i(pInput))="p=<612,-4354,3273>, v=<87,30,-87>, a=<-9,12,-4>"
 set pInput($i(pInput))="p=<3048,-2098,-3435>, v=<-27,86,80>, a=<-8,0,5>"
 set pInput($i(pInput))="p=<2556,3434,1137>, v=<31,-32,2>, a=<-11,-9,-4>"
 set pInput($i(pInput))="p=<-372,710,-1851>, v=<-47,-31,-61>, a=<5,0,11>"
 set pInput($i(pInput))="p=<-648,-2698,705>, v=<2,136,20>, a=<2,-2,-4>"
 set pInput($i(pInput))="p=<564,146,-2007>, v=<-36,-70,108>, a=<1,5,-2>"
 set pInput($i(pInput))="p=<2040,662,-6411>, v=<-85,-29,129>, a=<0,0,11>"
 set pInput($i(pInput))="p=<-5642,-1168,-495>, v=<101,-74,-40>, a=<7,8,4>"
 set pInput($i(pInput))="p=<-3724,-3058,-1279>, v=<-11,-21,-41>, a=<10,9,6>"
 set pInput($i(pInput))="p=<-1540,-5046,-2875>, v=<56,79,74>, a=<0,7,2>"
 set pInput($i(pInput))="p=<336,-3506,345>, v=<47,82,17>, a=<-4,3,-2>"
 set pInput($i(pInput))="p=<5432,3088,2375>, v=<39,-52,-99>, a=<-16,-4,1>"
 set pInput($i(pInput))="p=<1792,1716,-2749>, v=<-63,55,26>, a=<0,-8,5>"
 set pInput($i(pInput))="p=<-1274,316,723>, v=<148,76,-40>, a=<-7,-6,1>"
 set pInput($i(pInput))="p=<924,-104,4223>, v=<-32,4,-49>, a=<0,0,-7>"
 set pInput($i(pInput))="p=<1484,-832,107>, v=<-168,30,-18>, a=<8,0,1>"
 set pInput($i(pInput))="p=<-8594,3021,4906>, v=<21,28,4>, a=<14,-7,-9>"
 set pInput($i(pInput))="p=<10084,-1137,-5786>, v=<-86,35,90>, a=<-13,0,5>"
 set pInput($i(pInput))="p=<-5030,5628,-2420>, v=<-2,-170,73>, a=<9,0,0>"
 set pInput($i(pInput))="p=<-2324,-2952,220>, v=<1,124,44>, a=<4,-2,-3>"
 set pInput($i(pInput))="p=<2857,2757,55>, v=<-3,2,-36>, a=<-5,-5,2>"
 set pInput($i(pInput))="p=<3319,-2523,2497>, v=<-34,26,26>, a=<-4,3,-6>"
 set pInput($i(pInput))="p=<5256,903,-1020>, v=<76,11,65>, a=<-12,-2,-2>"
 set pInput($i(pInput))="p=<8028,5151,-1038>, v=<-1,-33,84>, a=<-12,-6,-3>"
 set pInput($i(pInput))="p=<3690,-4065,1266>, v=<-47,75,57>, a=<-3,2,-5>"
 set pInput($i(pInput))="p=<6606,5403,7026>, v=<-17,-40,-66>, a=<-9,-6,-7>"
 set pInput($i(pInput))="p=<-1638,1383,1338>, v=<11,-86,-51>, a=<14,-2,-6>"
 set pInput($i(pInput))="p=<896,1026,-622>, v=<-5,-98,-1>, a=<-8,3,6>"
 set pInput($i(pInput))="p=<763,1425,309>, v=<-78,-134,0>, a=<3,4,-3>"
 set pInput($i(pInput))="p=<1001,-619,113>, v=<55,72,44>, a=<-17,-4,-7>"
 set pInput($i(pInput))="p=<1191,109,1991>, v=<-116,-48,-8>, a=<5,3,-4>"
 set pInput($i(pInput))="p=<3453,-1718,-5230>, v=<136,60,46>, a=<-17,0,9>"
 set pInput($i(pInput))="p=<-2666,-2646,-4621>, v=<32,47,40>, a=<4,3,8>"
 set pInput($i(pInput))="p=<1436,-2829,1966>, v=<-51,-16,-45>, a=<-2,15,-5>"
 set pInput($i(pInput))="p=<696,2161,-2404>, v=<-35,-108,100>, a=<0,0,2>"
 set pInput($i(pInput))="p=<2486,2401,-1224>, v=<-9,48,20>, a=<-11,-16,4>"
 set pInput($i(pInput))="p=<3046,261,1116>, v=<-37,71,-139>, a=<-11,-8,8>"
 set pInput($i(pInput))="p=<-104,2751,2326>, v=<-121,-85,-42>, a=<12,-5,-7>"
 set pInput($i(pInput))="p=<-1044,-249,496>, v=<73,-19,-45>, a=<-2,3,2>"
 set pInput($i(pInput))="p=<556,-289,1826>, v=<-28,-59,67>, a=<0,7,-15>"
 set pInput($i(pInput))="p=<-274,1131,-44>, v=<-18,-46,45>, a=<3,-1,-4>"
 set pInput($i(pInput))="p=<2266,1141,-504>, v=<-19,-78,26>, a=<-9,2,0>"
 set pInput($i(pInput))="p=<-891,-129,1722>, v=<-121,92,-73>, a=<15,-8,-1>"
 set pInput($i(pInput))="p=<243,-2439,3276>, v=<23,70,-158>, a=<-3,4,0>"
 set pInput($i(pInput))="p=<-72,-339,399>, v=<-17,3,-10>, a=<2,1,-1>"
 set pInput($i(pInput))="p=<1461,-759,2205>, v=<-57,-109,-30>, a=<-1,13,-7>"
 set pInput($i(pInput))="p=<-597,-1536,882>, v=<30,-39,-33>, a=<0,10,-1>"
 set pInput($i(pInput))="p=<2469,-1683,1533>, v=<49,-10,-152>, a=<-15,8,7>"
 set pInput($i(pInput))="p=<957,3441,1428>, v=<-143,-1,106>, a=<9,-15,-16>"
 set pInput($i(pInput))="p=<-2487,-927,-5271>, v=<32,-35,194>, a=<8,7,5>"
 set pInput($i(pInput))="p=<915,585,1701>, v=<-97,-8,-83>, a=<5,-2,0>"
 set pInput($i(pInput))="p=<-1975,2665,-1727>, v=<138,-30,49>, a=<-4,-9,3>"
 set pInput($i(pInput))="p=<-2122,-23,-2945>, v=<24,76,74>, a=<7,-7,6>"
 set pInput($i(pInput))="p=<150,1353,672>, v=<36,-115,-12>, a=<-5,4,-3>"
 set pInput($i(pInput))="p=<2139,-1299,1437>, v=<-144,-4,-93>, a=<2,9,1>"
 set pInput($i(pInput))="p=<-955,3036,298>, v=<74,-79,-8>, a=<-2,-11,-1>"
 set pInput($i(pInput))="p=<2156,-1418,-1640>, v=<-46,84,34>, a=<-9,0,7>"
 set pInput($i(pInput))="p=<-938,-1418,808>, v=<82,66,25>, a=<-3,2,-8>"
 set pInput($i(pInput))="p=<-2179,-109,-382>, v=<146,25,-31>, a=<-2,-2,6>"
 set pInput($i(pInput))="p=<2139,1727,-280>, v=<-63,-74,-46>, a=<-7,-3,7>"
 set pInput($i(pInput))="p=<-1006,622,-59>, v=<77,-54,-5>, a=<-2,2,1>"
 set pInput($i(pInput))="p=<235,894,349>, v=<-113,-79,43>, a=<11,3,-7>"
 set pInput($i(pInput))="p=<2258,452,1624>, v=<-88,37,-32>, a=<-5,-7,-7>"
 set pInput($i(pInput))="p=<6485,8607,10076>, v=<-46,61,-99>, a=<-6,-14,-8>"
 set pInput($i(pInput))="p=<15533,4551,638>, v=<-78,-55,-57>, a=<-16,-3,2>"
 set pInput($i(pInput))="p=<128,6540,4148>, v=<-3,114,-67>, a=<0,-14,-2>"
 set pInput($i(pInput))="p=<11555,3186,2081>, v=<-116,0,-114>, a=<-9,-4,3>"
 set pInput($i(pInput))="p=<9371,-3015,-6031>, v=<20,79,54>, a=<-13,0,5>"
 set pInput($i(pInput))="p=<-12586,339,-7786>, v=<3,-7,59>, a=<16,0,7>"
 set pInput($i(pInput))="p=<-2056,-7383,-4705>, v=<-67,11,0>, a=<6,9,6>"
 set pInput($i(pInput))="p=<1025,2796,-13480>, v=<-126,-70,-15>, a=<5,0,18>"
 set pInput($i(pInput))="p=<-11416,-1962,-766>, v=<-47,12,39>, a=<17,2,-1>"
 set pInput($i(pInput))="p=<1103,-558,3212>, v=<-88,-24,-83>, a=<3,2,0>"
 set pInput($i(pInput))="p=<-56,-3584,3008>, v=<78,86,-151>, a=<-6,5,2>"
 set pInput($i(pInput))="p=<1072,-5108,-1720>, v=<-44,112,71>, a=<0,8,0>"
 set pInput($i(pInput))="p=<-1256,1936,-1384>, v=<28,-69,57>, a=<2,-1,0>"
 set pInput($i(pInput))="p=<1996,-992,1472>, v=<-120,-22,-12>, a=<3,5,-4>"
 set pInput($i(pInput))="p=<3376,1324,908>, v=<-140,-31,-101>, a=<0,-2,5>"
 set pInput($i(pInput))="p=<3604,412,6920>, v=<-62,-43,-189>, a=<-7,2,-8>"
 set pInput($i(pInput))="p=<-176,4384,2204>, v=<-17,-21,-80>, a=<2,-13,-1>"
 set pInput($i(pInput))="p=<-992,-1196,-3616>, v=<42,49,50>, a=<0,0,8>"
 set pInput($i(pInput))="p=<-353,-1549,-1122>, v=<-72,-82,26>, a=<6,10,1>"
 set pInput($i(pInput))="p=<727,-3169,-2337>, v=<0,6,-97>, a=<-2,8,13>"
 set pInput($i(pInput))="p=<-1973,-1387,-3282>, v=<44,-60,92>, a=<2,8,2>"
 set pInput($i(pInput))="p=<1159,-118,2712>, v=<96,75,-46>, a=<-10,-5,-4>"
 set pInput($i(pInput))="p=<-974,260,-2553>, v=<-105,-51,37>, a=<10,3,4>"
 set pInput($i(pInput))="p=<1645,2069,2388>, v=<50,22,-20>, a=<-8,-7,-5>"
 set pInput($i(pInput))="p=<1726,2420,-3930>, v=<-79,-19,46>, a=<1,-5,7>"
 set pInput($i(pInput))="p=<1564,4364,1740>, v=<53,-91,-38>, a=<-8,-5,-2>"
 set pInput($i(pInput))="p=<6496,8583,-2797>, v=<-129,-57,50>, a=<-4,-12,2>"
 set pInput($i(pInput))="p=<919,-6234,4727>, v=<74,188,9>, a=<-6,0,-9>"
 set pInput($i(pInput))="p=<2272,-2736,7796>, v=<-1,-3,-67>, a=<-4,5,-10>"
 set pInput($i(pInput))="p=<-9674,-558,9809>, v=<72,-52,-26>, a=<13,4,-16>"
 set pInput($i(pInput))="p=<8542,3765,-124>, v=<-55,89,20>, a=<-12,-12,-1>"
 set pInput($i(pInput))="p=<1909,3138,1790>, v=<-41,74,-21>, a=<-1,-10,-2>"
 set pInput($i(pInput))="p=<-1419,1399,-3011>, v=<42,-26,-27>, a=<0,-1,7>"
 set pInput($i(pInput))="p=<1716,-4244,5569>, v=<-53,-178,-32>, a=<0,18,-8>"
 set pInput($i(pInput))="p=<6270,211,-10931>, v=<-38,78,60>, a=<-9,-5,16>"
 set pInput($i(pInput))="p=<-5181,-3452,-338>, v=<71,36,62>, a=<5,4,-3>"
 set pInput($i(pInput))="p=<-6105,-8402,-5915>, v=<31,-1,27>, a=<9,15,9>"
 set pInput($i(pInput))="p=<-1848,310,-1097>, v=<4,92,17>, a=<3,-6,1>"
 set pInput($i(pInput))="p=<2803,-1755,-532>, v=<-71,13,2>, a=<-5,6,2>"
 set pInput($i(pInput))="p=<691,2348,-785>, v=<48,-24,71>, a=<-7,-7,-3>"
 set pInput($i(pInput))="p=<-233,4779,-994>, v=<-48,-31,0>, a=<5,-16,4>"
 set pInput($i(pInput))="p=<119,-4021,238>, v=<-41,93,-10>, a=<3,8,0>"
 set pInput($i(pInput))="p=<-1168,-3647,-3392>, v=<52,76,132>, a=<0,8,2>"
 set pInput($i(pInput))="p=<-1845,-443,-822>, v=<-24,-30,1>, a=<11,5,4>"
 set pInput($i(pInput))="p=<2315,1487,4428>, v=<-64,-53,-83>, a=<-5,-2,-13>"
 set pInput($i(pInput))="p=<3255,-2683,-772>, v=<-132,82,-12>, a=<-3,5,5>"
 set pInput($i(pInput))="p=<-1405,487,108>, v=<-25,-45,70>, a=<9,2,-7>"
 set pInput($i(pInput))="p=<-2315,1877,-1142>, v=<73,1,38>, a=<4,-9,2>"
 set pInput($i(pInput))="p=<-1975,-2143,-3372>, v=<-28,13,13>, a=<12,9,15>"
 set pInput($i(pInput))="p=<1945,3157,2138>, v=<28,-147,21>, a=<-12,-1,-12>"
 set pInput($i(pInput))="p=<-3555,977,708>, v=<114,-59,-2>, a=<6,1,-3>"
 set pInput($i(pInput))="p=<5865,5127,-4422>, v=<-105,-67,118>, a=<-18,-18,10>"
 set pInput($i(pInput))="p=<-3264,2343,-3273>, v=<79,-72,127>, a=<11,-6,6>"
 set pInput($i(pInput))="p=<3387,-2301,1992>, v=<-53,129,15>, a=<-14,0,-13>"
 set pInput($i(pInput))="p=<2295,5276,1762>, v=<-104,-67,-57>, a=<0,-15,-2>"
 set pInput($i(pInput))="p=<-2072,-774,1036>, v=<37,-22,68>, a=<5,5,-10>"
 set pInput($i(pInput))="p=<447,865,1300>, v=<-20,-39,-36>, a=<0,0,-2>"
 set pInput($i(pInput))="p=<-1467,-1852,2323>, v=<90,50,-117>, a=<-2,3,1>"
 set pInput($i(pInput))="p=<4473,-664,-1241>, v=<-157,-4,45>, a=<-4,3,1>"
 set pInput($i(pInput))="p=<1580,-1621,-2572>, v=<32,5,48>, a=<-9,6,6>"
 set pInput($i(pInput))="p=<9680,-3138,-4267>, v=<-41,22,-84>, a=<-14,4,12>"
 set pInput($i(pInput))="p=<-4107,4648,2023>, v=<32,3,-59>, a=<5,-8,0>"
 set pInput($i(pInput))="p=<-673,1860,7004>, v=<36,-55,-48>, a=<-1,0,-9>"
 set pInput($i(pInput))="p=<8337,7453,2516>, v=<-159,-132,84>, a=<-5,-5,-9>"
 set pInput($i(pInput))="p=<2276,-3123,-1445>, v=<-62,44,37>, a=<-6,12,4>"
 set pInput($i(pInput))="p=<-1885,-64,1576>, v=<27,33,-12>, a=<7,-3,-7>"
 set pInput($i(pInput))="p=<-7265,156,268>, v=<89,-23,-25>, a=<6,1,1>"
 set pInput($i(pInput))="p=<-9137,3036,826>, v=<104,8,-133>, a=<8,-5,6>"
 set pInput($i(pInput))="p=<-6167,-1770,-4592>, v=<77,86,73>, a=<5,-2,3>"
 set pInput($i(pInput))="p=<-1685,-2976,2824>, v=<45,27,-22>, a=<0,3,-3>"
 set pInput($i(pInput))="p=<5821,-870,5740>, v=<3,-13,-29>, a=<-9,2,-7>"
 set pInput($i(pInput))="p=<331,1596,232>, v=<-11,-100,-135>, a=<0,3,7>"
 set pInput($i(pInput))="p=<-1230,1100,-8455>, v=<87,-67,165>, a=<-3,2,6>"
 set pInput($i(pInput))="p=<-1470,5772,3641>, v=<-21,-81,18>, a=<4,-6,-8>"
 set pInput($i(pInput))="p=<7026,-2852,1913>, v=<-6,106,6>, a=<-13,-1,-4>"
 set pInput($i(pInput))="p=<-5422,5132,-5575>, v=<-13,-160,42>, a=<11,0,8>"
 set pInput($i(pInput))="p=<3792,1660,-43>, v=<-175,-121,15>, a=<-9,1,-2>"
 set pInput($i(pInput))="p=<42,-620,-778>, v=<3,39,24>, a=<0,0,3>"
 set pInput($i(pInput))="p=<-318,-1370,1697>, v=<11,137,-85>, a=<2,-6,-4>"
 set pInput($i(pInput))="p=<1842,130,-613>, v=<-69,-11,-19>, a=<-6,0,7>"
 set pInput($i(pInput))="p=<-963,3070,-2218>, v=<30,-151,144>, a=<5,-7,0>"
 set pInput($i(pInput))="p=<2847,-2795,1532>, v=<-112,80,-74>, a=<-9,13,-4>"
 set pInput($i(pInput))="p=<747,-875,197>, v=<12,56,-17>, a=<-7,0,0>"
 set pInput($i(pInput))="p=<627,-80,1022>, v=<-36,27,-128>, a=<0,-3,7>"
 set pInput($i(pInput))="p=<2667,655,1427>, v=<-108,-14,-91>, a=<-8,-4,-1>"
 set pInput($i(pInput))="p=<1002,-215,962>, v=<35,-28,-108>, a=<-12,5,5>"
 set pInput($i(pInput))="p=<-849,-4500,291>, v=<-67,65,22>, a=<6,5,-2>"
 set pInput($i(pInput))="p=<6405,4180,5499>, v=<-125,9,-18>, a=<-5,-9,-10>"
 set pInput($i(pInput))="p=<4576,-4128,1562>, v=<-66,53,-3>, a=<-5,5,-3>"
 set pInput($i(pInput))="p=<391,4738,-2189>, v=<37,-89,70>, a=<-3,-4,0>"
 set pInput($i(pInput))="p=<-1004,863,12>, v=<82,-108,15>, a=<-3,5,-1>"
 set pInput($i(pInput))="p=<1352,1514,-4390>, v=<-10,-49,13>, a=<-2,0,8>"
 set pInput($i(pInput))="p=<360,-4748,-81>, v=<-26,73,50>, a=<1,5,-3>"
 set pInput($i(pInput))="p=<-7297,2320,-6157>, v=<-3,-75,22>, a=<15,0,11>"
 set pInput($i(pInput))="p=<918,-780,229>, v=<68,-55,-8>, a=<-6,5,0>"
 set pInput($i(pInput))="p=<422,-7135,5871>, v=<-12,86,-62>, a=<0,9,-8>"
 set pInput($i(pInput))="p=<2921,-2245,1495>, v=<-93,55,-15>, a=<0,1,-2>"
 set pInput($i(pInput))="p=<1417,-4757,1367>, v=<-79,84,22>, a=<2,4,-4>"
 set pInput($i(pInput))="p=<2137,-4133,-5545>, v=<-118,-117,40>, a=<3,15,8>"
 set pInput($i(pInput))="p=<2761,-3685,-2329>, v=<-121,67,-44>, a=<2,3,7>"
 set pInput($i(pInput))="p=<3145,3851,3831>, v=<-199,-53,-22>, a=<6,-4,-6>"
 set pInput($i(pInput))="p=<-807,-1909,-8809>, v=<40,-71,10>, a=<-1,8,16>"
 set pInput($i(pInput))="p=<-3001,-1007,-4300>, v=<-11,2,69>, a=<11,3,9>"
 set pInput($i(pInput))="p=<2291,3961,-2416>, v=<-19,-30,28>, a=<-6,-11,6>"
 set pInput($i(pInput))="p=<1571,-3143,-2428>, v=<-14,66,41>, a=<-4,5,5>"
 set pInput($i(pInput))="p=<683,3001,6056>, v=<73,-90,-200>, a=<-8,-3,-4>"
 set pInput($i(pInput))="p=<-205,-759,517>, v=<108,44,50>, a=<-8,-1,-6>"
 set pInput($i(pInput))="p=<-642,1863,3622>, v=<31,-58,23>, a=<0,-2,-15>"
 set pInput($i(pInput))="p=<-1562,1449,-4405>, v=<83,8,-12>, a=<-1,-6,17>"
 set pInput($i(pInput))="p=<853,-1242,3668>, v=<14,-67,-51>, a=<-4,10,-9>"
 set pInput($i(pInput))="p=<-757,46,-6061>, v=<0,-15,156>, a=<3,1,9>"
 set pInput($i(pInput))="p=<-3287,-1403,-564>, v=<38,0,-35>, a=<9,5,5>"
 set pInput($i(pInput))="p=<-849,1840,3001>, v=<124,-33,-106>, a=<-7,-4,-2>"
 set pInput($i(pInput))="p=<1566,2806,-1162>, v=<43,-39,15>, a=<-9,-7,3>"
 set pInput($i(pInput))="p=<5706,3174,-5141>, v=<-77,-67,44>, a=<-14,-6,15>"
 set pInput($i(pInput))="p=<-1444,-4807,1648>, v=<-55,150,-100>, a=<6,0,3>"
 set pInput($i(pInput))="p=<-2596,2137,-7664>, v=<-19,-67,92>, a=<6,0,9>"
 set pInput($i(pInput))="p=<-4324,1577,-5456>, v=<35,0,23>, a=<6,-3,9>"
 set pInput($i(pInput))="p=<-1428,2121,1568>, v=<-39,82,-48>, a=<5,-9,0>"
 set pInput($i(pInput))="p=<-4884,-7063,-1168>, v=<36,-27,-12>, a=<7,15,3>"
 set pInput($i(pInput))="p=<-2612,-2871,2352>, v=<-35,-26,43>, a=<7,7,-7>"
 set pInput($i(pInput))="p=<2492,7737,4832>, v=<-13,22,-51>, a=<-4,-16,-6>"
 set pInput($i(pInput))="p=<3228,-2455,880>, v=<-102,-39,-10>, a=<0,7,-1>"
 set pInput($i(pInput))="p=<620,-4183,0>, v=<29,15,1>, a=<-3,7,0>"
 set pInput($i(pInput))="p=<1549,1698,2535>, v=<-94,-85,-179>, a=<-2,-5,0>"
 set pInput($i(pInput))="p=<-1643,1068,-202>, v=<29,-25,-66>, a=<12,-7,11>"
 set pInput($i(pInput))="p=<-229,697,-1756>, v=<48,-51,30>, a=<-4,0,13>"
 set pInput($i(pInput))="p=<1724,39,1219>, v=<-129,-49,-85>, a=<1,6,0>"
 set pInput($i(pInput))="p=<361,2678,211>, v=<21,-76,46>, a=<-6,-15,-8>"
 set pInput($i(pInput))="p=<291,410,3284>, v=<-19,-19,-166>, a=<0,-1,-9>"
 set pInput($i(pInput))="p=<-1711,-2642,-1098>, v=<79,109,72>, a=<6,11,1>"
 set pInput($i(pInput))="p=<-12485,-3505,-8183>, v=<17,14,59>, a=<16,4,8>"
 set pInput($i(pInput))="p=<2449,-351,-4877>, v=<92,9,-28>, a=<-8,0,8>"
 set pInput($i(pInput))="p=<-2377,1435,1241>, v=<63,40,-72>, a=<0,-4,2>"
 set pInput($i(pInput))="p=<397,7496,462>, v=<146,-22,46>, a=<-8,-9,-3>"
 set pInput($i(pInput))="p=<4672,-180,1621>, v=<-25,-15,-121>, a=<-5,1,4>"
 set pInput($i(pInput))="p=<-667,2442,1165>, v=<57,-45,-31>, a=<-2,-1,0>"
 set pInput($i(pInput))="p=<-97,-7210,6523>, v=<-75,53,-55>, a=<4,7,-6>"
 set pInput($i(pInput))="p=<-5911,-5329,-5941>, v=<0,62,39>, a=<8,4,6>"
 set pInput($i(pInput))="p=<-5132,4133,1583>, v=<38,-31,-42>, a=<5,-4,0>"
 set pInput($i(pInput))="p=<-797,-449,1945>, v=<68,51,-76>, a=<-2,-3,-7>"
 set pInput($i(pInput))="p=<2203,496,-620>, v=<-28,-20,55>, a=<-15,-2,-2>"
 set pInput($i(pInput))="p=<-512,286,-725>, v=<17,-14,46>, a=<2,-1,0>"
 set pInput($i(pInput))="p=<-317,2701,2845>, v=<92,-135,-88>, a=<-9,-6,-13>"
 set pInput($i(pInput))="p=<2488,-839,10>, v=<-95,13,-19>, a=<-9,5,2>"
 set pInput($i(pInput))="p=<-32,-584,-1805>, v=<1,68,54>, a=<0,-4,8>"
 set pInput($i(pInput))="p=<-1487,841,25>, v=<106,-59,12>, a=<-1,0,-2>"
 set pInput($i(pInput))="p=<9711,3803,1142>, v=<-7,36,3>, a=<-15,-8,-2>"
 set pInput($i(pInput))="p=<3306,-1797,722>, v=<-4,34,-183>, a=<-5,1,9>"
 set pInput($i(pInput))="p=<2050,-1523,1668>, v=<-33,42,148>, a=<-3,1,-15>"
 set pInput($i(pInput))="p=<2914,-227,-2544>, v=<-9,8,66>, a=<-7,0,2>"
 set pInput($i(pInput))="p=<4507,-227,-1977>, v=<-152,22,-25>, a=<-1,-1,7>"
 set pInput($i(pInput))="p=<5452,448,777>, v=<-75,-87,-43>, a=<-9,5,1>"
 set pInput($i(pInput))="p=<-1217,-3197,-2922>, v=<18,76,-102>, a=<2,3,15>"
 set pInput($i(pInput))="p=<-1703,-2738,-6>, v=<-6,-39,0>, a=<5,10,0>"
 set pInput($i(pInput))="p=<-29,-6410,453>, v=<16,83,-73>, a=<-1,11,4>"
 set pInput($i(pInput))="p=<1591,313,-5028>, v=<40,16,102>, a=<-7,-2,6>"
 set pInput($i(pInput))="p=<1753,-4823,2921>, v=<-46,-88,-58>, a=<0,11,-1>"
 set pInput($i(pInput))="p=<3672,-6932,2617>, v=<79,26,-89>, a=<-9,8,1>"
 set pInput($i(pInput))="p=<-1534,8477,2883>, v=<-135,30,21>, a=<9,-13,-5>"
 set pInput($i(pInput))="p=<-3187,5532,7994>, v=<45,-29,23>, a=<2,-6,-12>"
 set pInput($i(pInput))="p=<5249,-776,-2988>, v=<-21,59,-39>, a=<-6,-2,6>"
 set pInput($i(pInput))="p=<-774,-339,-7244>, v=<1,106,112>, a=<1,-5,4>"
 set pInput($i(pInput))="p=<-2104,-17268,1420>, v=<-3,64,118>, a=<3,20,-8>"
 set pInput($i(pInput))="p=<-1306,4335,-24>, v=<15,22,0>, a=<1,-7,0>"
 set pInput($i(pInput))="p=<-972,2893,110>, v=<-133,420,13>, a=<7,-27,1>"
 set pInput($i(pInput))="p=<1906,-490,2091>, v=<271,-62,298>, a=<-18,9,-21>"
 set pInput($i(pInput))="p=<-1422,-2788,323>, v=<-200,-398,44>, a=<14,27,-3>"
 set pInput($i(pInput))="p=<1079,-21,-2677>, v=<156,-2,-384>, a=<-9,-1,22>"
 set pInput($i(pInput))="p=<-513,1027,-2732>, v=<-71,147,-392>, a=<5,-13,29>"
 set pInput($i(pInput))="p=<472,-76,-2799>, v=<67,-14,-399>, a=<-6,5,28>"
 set pInput($i(pInput))="p=<-478,1841,2426>, v=<-69,269,351>, a=<5,-20,-26>"
 set pInput($i(pInput))="p=<2254,1465,-1528>, v=<324,211,-218>, a=<-19,-13,17>"
 set pInput($i(pInput))="p=<-277,1286,2981>, v=<-39,181,423>, a=<-1,-8,-24>"
 set pInput($i(pInput))="p=<71,2026,2683>, v=<5,285,383>, a=<-3,-20,-25>"
 set pInput($i(pInput))="p=<-581,-2942,-73>, v=<-79,-423,-11>, a=<4,33,-4>"
 set pInput($i(pInput))="p=<65,2932,137>, v=<7,418,19>, a=<-1,-29,-1>"
 set pInput($i(pInput))="p=<-401,582,-3050>, v=<-59,88,-434>, a=<1,-4,30>"
 set pInput($i(pInput))="p=<2976,-590,-108>, v=<421,-80,-12>, a=<-26,2,4>"
 set pInput($i(pInput))="p=<-2303,-645,-1751>, v=<-329,-91,-251>, a=<21,6,14>"
 set pInput($i(pInput))="p=<1140,-2857,662>, v=<164,-410,91>, a=<-11,27,-10>"
 set pInput($i(pInput))="p=<-2532,-643,1350>, v=<-363,-84,191>, a=<29,4,-20>"
 set pInput($i(pInput))="p=<1816,1234,-2316>, v=<261,177,-329>, a=<-18,-12,23>"
 set pInput($i(pInput))="p=<499,-2878,-236>, v=<71,-410,-38>, a=<-2,25,6>"
 set pInput($i(pInput))="p=<2553,-1482,-988>, v=<361,-214,-139>, a=<-24,14,9>"
 set pInput($i(pInput))="p=<-2086,-2102,-211>, v=<-300,-301,-31>, a=<12,23,-2>"
 set pInput($i(pInput))="p=<-256,-1962,-2187>, v=<-38,-280,-313>, a=<1,19,20>"
 set pInput($i(pInput))="p=<-1353,-1829,1849>, v=<-197,-264,260>, a=<15,19,-18>"
 set pInput($i(pInput))="p=<2427,-1169,1408>, v=<345,-170,206>, a=<-30,5,-17>"
 set pInput($i(pInput))="p=<-681,372,-3521>, v=<-98,58,-512>, a=<12,-3,39>"
 set pInput($i(pInput))="p=<-525,-322,-2723>, v=<-71,-46,-387>, a=<9,-2,33>"
 set pInput($i(pInput))="p=<-1485,2370,-939>, v=<-212,340,-138>, a=<19,-18,11>"
 set pInput($i(pInput))="p=<2629,23,1333>, v=<375,2,191>, a=<-24,-1,-13>"
 set pInput($i(pInput))="p=<-962,2687,-565>, v=<-140,383,-78>, a=<8,-20,5>"
 set pInput($i(pInput))="p=<990,3391,-1021>, v=<144,480,-152>, a=<-9,-32,8>"
 set pInput($i(pInput))="p=<-1608,2476,39>, v=<-229,351,3>, a=<17,-24,0>"
 set pInput($i(pInput))="p=<2455,44,-1459>, v=<350,3,-209>, a=<-26,0,19>"
 set pInput($i(pInput))="p=<3240,154,-210>, v=<457,20,-33>, a=<-31,1,6>"
 set pInput($i(pInput))="p=<-2171,-88,-1778>, v=<-309,-8,-254>, a=<19,0,15>"
 set pInput($i(pInput))="p=<-2277,-926,-1445>, v=<-325,-131,-207>, a=<24,5,11>"
 set pInput($i(pInput))="p=<-589,-1148,2928>, v=<-80,-170,418>, a=<9,12,-29>"
 set pInput($i(pInput))="p=<-2241,-1063,1406>, v=<-316,-152,197>, a=<24,16,-19>"
 set pInput($i(pInput))="p=<2092,-955,950>, v=<298,-136,132>, a=<-24,8,-7>"
 set pInput($i(pInput))="p=<-466,-2201,-1279>, v=<-62,-310,-180>, a=<-1,23,12>"
 set pInput($i(pInput))="p=<-468,-2983,-1861>, v=<-66,-425,-260>, a=<8,28,23>"
 set pInput($i(pInput))="p=<-1070,-2706,-272>, v=<-149,-388,-38>, a=<8,27,0>"
 set pInput($i(pInput))="p=<-2009,-1830,1787>, v=<-291,-264,248>, a=<20,22,-17>"
 set pInput($i(pInput))="p=<2822,-85,659>, v=<403,-14,89>, a=<-33,0,-10>"
 set pInput($i(pInput))="p=<-2363,-1805,-611>, v=<-337,-257,-89>, a=<24,16,12>"
 set pInput($i(pInput))="p=<-2598,2035,-674>, v=<-373,287,-95>, a=<28,-22,8>"
 set pInput($i(pInput))="p=<1173,2573,243>, v=<164,367,40>, a=<-14,-23,1>"
 set pInput($i(pInput))="p=<-836,3312,206>, v=<-118,475,29>, a=<8,-34,-2>"
 set pInput($i(pInput))="p=<1688,-381,2533>, v=<236,-57,357>, a=<-15,3,-25>"
 set pInput($i(pInput))="p=<143,1759,-2463>, v=<22,249,-355>, a=<0,-14,27>"
 set pInput($i(pInput))="p=<-2683,2007,980>, v=<-389,283,140>, a=<25,-23,-12>"
 set pInput($i(pInput))="p=<-670,-1250,-2411>, v=<-97,-178,-347>, a=<6,15,24>"
 set pInput($i(pInput))="p=<-1136,2357,985>, v=<-164,334,139>, a=<16,-27,-11>"
 set pInput($i(pInput))="p=<2096,-1737,638>, v=<298,-251,86>, a=<-20,22,-6>"
 set pInput($i(pInput))="p=<-2631,-271,1623>, v=<-375,-37,230>, a=<29,1,-18>"
 set pInput($i(pInput))="p=<2424,1243,1437>, v=<348,177,200>, a=<-26,-10,-19>"
 set pInput($i(pInput))="p=<2060,1385,938>, v=<294,197,134>, a=<-25,-14,-15>"
 set pInput($i(pInput))="p=<1331,2651,-818>, v=<193,381,-116>, a=<-13,-30,9>"
 set pInput($i(pInput))="p=<776,1916,1714>, v=<112,274,249>, a=<-5,-18,-17>"
 set pInput($i(pInput))="p=<-811,427,-2299>, v=<-117,63,-328>, a=<6,0,27>"
 set pInput($i(pInput))="p=<1354,2492,-186>, v=<191,355,-27>, a=<-16,-24,2>"
 set pInput($i(pInput))="p=<474,3023,-673>, v=<69,434,-92>, a=<-4,-25,10>"
 set pInput($i(pInput))="p=<1520,-2352,670>, v=<215,-334,94>, a=<-16,19,-7>"
 set pInput($i(pInput))="p=<-1149,-2556,-1447>, v=<-166,-360,-206>, a=<11,23,13>"
 set pInput($i(pInput))="p=<-37,2330,1867>, v=<-5,328,265>, a=<-2,-22,-14>"
 set pInput($i(pInput))="p=<-2861,-590,507>, v=<-413,-82,70>, a=<27,1,-2>"
 set pInput($i(pInput))="p=<3202,-250,647>, v=<462,-35,92>, a=<-24,2,-6>"
 set pInput($i(pInput))="p=<-2286,-833,-1219>, v=<-326,-122,-173>, a=<22,4,15>"
 set pInput($i(pInput))="p=<-2215,-1793,861>, v=<-321,-252,125>, a=<18,22,-4>"
 set pInput($i(pInput))="p=<-156,1321,2884>, v=<-21,191,413>, a=<1,-11,-30>"
 set pInput($i(pInput))="p=<-804,2418,-838>, v=<-114,340,-125>, a=<8,-26,6>"
 set pInput($i(pInput))="p=<-1121,-1781,-1869>, v=<-157,-256,-265>, a=<12,19,17>"
 set pInput($i(pInput))="p=<-1529,565,-2482>, v=<-217,86,-354>, a=<15,-5,29>"
 set pInput($i(pInput))="p=<87,1773,2467>, v=<17,253,356>, a=<0,-12,-24>"
 set pInput($i(pInput))="p=<-1370,2134,2591>, v=<-195,304,367>, a=<14,-20,-25>"
 set pInput($i(pInput))="p=<-14,2076,1747>, v=<-4,294,249>, a=<4,-12,-17>"
 set pInput($i(pInput))="p=<1935,-1618,1382>, v=<281,-226,197>, a=<-18,19,-13>"
 set pInput($i(pInput))="p=<-2297,1551,77>, v=<-331,223,10>, a=<16,-13,-2>"
 set pInput($i(pInput))="p=<-1952,-1430,82>, v=<-276,-199,12>, a=<14,13,0>"
 set pInput($i(pInput))="p=<-1987,-1518,-1457>, v=<-280,-216,-208>, a=<14,15,17>"
 set pInput($i(pInput))="p=<-1359,-1392,2060>, v=<-196,-199,295>, a=<12,15,-26>"
 set pInput($i(pInput))="p=<691,-2517,1578>, v=<98,-359,224>, a=<-9,26,-15>"
 set pInput($i(pInput))="p=<2671,965,580>, v=<381,131,81>, a=<-31,-14,-7>"
 set pInput($i(pInput))="p=<-243,614,2906>, v=<-31,84,421>, a=<3,-6,-30>"
 set pInput($i(pInput))="p=<-1052,646,3333>, v=<-149,95,476>, a=<12,-3,-37>"
 set pInput($i(pInput))="p=<510,1846,2487>, v=<72,264,351>, a=<-9,-20,-24>"
 set pInput($i(pInput))="p=<-1990,-1380,1739>, v=<-282,-193,248>, a=<18,9,-15>"
 set pInput($i(pInput))="p=<133,-2661,-1829>, v=<18,-382,-264>, a=<1,28,18>"
 set pInput($i(pInput))="p=<815,2490,1020>, v=<122,351,144>, a=<-8,-20,-4>"
 set pInput($i(pInput))="p=<2465,-1704,-1056>, v=<348,-243,-150>, a=<-24,16,12>"
 set pInput($i(pInput))="p=<-711,-1825,2020>, v=<-107,-263,293>, a=<3,18,-20>"
 set pInput($i(pInput))="p=<2090,1861,-455>, v=<295,266,-65>, a=<-16,-18,8>"
 set pInput($i(pInput))="p=<-76,2995,-1382>, v=<-11,422,-196>, a=<2,-32,12>"
 set pInput($i(pInput))="p=<2104,-1799,1488>, v=<298,-260,207>, a=<-24,19,-13>"
 set pInput($i(pInput))="p=<63,2542,2053>, v=<10,365,295>, a=<0,-26,-15>"
 set pInput($i(pInput))="p=<1575,1481,-1420>, v=<224,211,-200>, a=<-11,-18,14>"
 set pInput($i(pInput))="p=<-2166,-345,-1387>, v=<-306,-49,-201>, a=<17,-1,10>"
 set pInput($i(pInput))="p=<-945,2623,29>, v=<-132,371,3>, a=<12,-23,-1>"
 set pInput($i(pInput))="p=<2590,878,-717>, v=<370,129,-102>, a=<-22,-15,9>"
 set pInput($i(pInput))="p=<2515,-1076,-679>, v=<357,-154,-101>, a=<-23,6,6>"
 set pInput($i(pInput))="p=<-1338,-2273,-1604>, v=<-186,-328,-231>, a=<14,22,18>"
 set pInput($i(pInput))="p=<-353,-2665,-1229>, v=<-46,-379,-172>, a=<3,24,12>"
 set pInput($i(pInput))="p=<-83,2448,-822>, v=<-13,353,-116>, a=<4,-23,8>"
 set pInput($i(pInput))="p=<-523,2472,1345>, v=<-73,355,192>, a=<8,-26,-15>"
 set pInput($i(pInput))="p=<-2443,1609,-1552>, v=<-349,231,-216>, a=<27,-17,22>"
 set pInput($i(pInput))="p=<1999,-1105,2090>, v=<285,-162,296>, a=<-17,10,-20>"
 set pInput($i(pInput))="p=<1954,2345,1492>, v=<277,339,213>, a=<-19,-23,-14>"
 set pInput($i(pInput))="p=<2221,-1016,1120>, v=<316,-141,158>, a=<-24,12,-10>"
 set pInput($i(pInput))="p=<-3168,-1304,44>, v=<-455,-186,10>, a=<27,16,1>"
 set pInput($i(pInput))="p=<1622,-980,-2335>, v=<231,-145,-337>, a=<-15,13,21>"
 set pInput($i(pInput))="p=<2185,209,2262>, v=<311,34,326>, a=<-27,2,-22>"
 set pInput($i(pInput))="p=<-2551,-307,1547>, v=<-364,-42,223>, a=<22,2,-16>"
 set pInput($i(pInput))="p=<-908,-1546,2694>, v=<-129,-219,384>, a=<11,12,-29>"
 set pInput($i(pInput))="p=<3364,248,363>, v=<481,35,47>, a=<-30,-4,3>"
 set pInput($i(pInput))="p=<-417,2230,1781>, v=<-60,320,254>, a=<5,-24,-15>"
 set pInput($i(pInput))="p=<-1902,-30,-1618>, v=<-265,-1,-228>, a=<20,0,13>"
 set pInput($i(pInput))="p=<-693,3041,-63>, v=<-100,434,-9>, a=<1,-29,-2>"
 set pInput($i(pInput))="p=<-1400,565,-2175>, v=<-200,80,-310>, a=<15,-6,17>"
 set pInput($i(pInput))="p=<-1416,-2376,-1590>, v=<-205,-341,-226>, a=<17,23,12>"
 set pInput($i(pInput))="p=<1484,-2148,1957>, v=<212,-311,279>, a=<-18,22,-16>"
 set pInput($i(pInput))="p=<573,2306,-702>, v=<84,331,-100>, a=<-8,-20,4>"
 set pInput($i(pInput))="p=<2271,1826,646>, v=<317,255,92>, a=<-21,-19,-6>"
 set pInput($i(pInput))="p=<-1405,1090,2686>, v=<-200,154,380>, a=<16,-7,-25>"
 set pInput($i(pInput))="p=<1115,-2148,-2264>, v=<161,-308,-323>, a=<-15,18,22>"
 set pInput($i(pInput))="p=<1491,2294,-1052>, v=<215,330,-149>, a=<-14,-22,8>"
 set pInput($i(pInput))="p=<2596,1010,885>, v=<374,145,124>, a=<-24,-8,-10>"
 set pInput($i(pInput))="p=<-1795,1860,-1144>, v=<-257,267,-164>, a=<24,-20,9>"
 set pInput($i(pInput))="p=<1277,687,-2336>, v=<184,94,-333>, a=<-7,-6,28>"
 set pInput($i(pInput))="p=<-347,1880,2125>, v=<-49,269,301>, a=<0,-18,-22>"
 set pInput($i(pInput))="p=<-18,-2622,-1537>, v=<-2,-370,-219>, a=<-2,29,19>"
 set pInput($i(pInput))="p=<-1855,-2054,1009>, v=<-264,-297,140>, a=<21,17,-14>"
 set pInput($i(pInput))="p=<-326,-2183,2149>, v=<-40,-311,306>, a=<0,18,-17>"
 set pInput($i(pInput))="p=<-980,-864,-2259>, v=<-141,-118,-318>, a=<14,10,17>"
 set pInput($i(pInput))="p=<-1809,905,-2722>, v=<-258,133,-391>, a=<17,-12,26>"
 set pInput($i(pInput))="p=<592,1196,-2413>, v=<88,171,-351>, a=<-1,-7,26>"
 set pInput($i(pInput))="p=<2073,1542,2188>, v=<300,220,318>, a=<-19,-15,-18>"
 set pInput($i(pInput))="p=<-557,-2458,1007>, v=<-79,-350,142>, a=<11,22,-12>"
 set pInput($i(pInput))="p=<-2392,2150,1346>, v=<-342,309,192>, a=<24,-23,-12>"
 set pInput($i(pInput))="p=<994,-2356,833>, v=<142,-338,119>, a=<-9,31,-3>"
 set pInput($i(pInput))="p=<299,2668,-290>, v=<46,382,-41>, a=<-5,-25,2>"
 set pInput($i(pInput))="p=<1626,-692,-2134>, v=<238,-101,-303>, a=<-14,6,19>"
 set pInput($i(pInput))="p=<1605,-1643,-682>, v=<228,-238,-98>, a=<-16,19,6>"
 set pInput($i(pInput))="p=<2925,-496,-312>, v=<419,-74,-44>, a=<-28,3,5>"
 set pInput($i(pInput))="p=<1803,-1874,1905>, v=<259,-265,271>, a=<-11,18,-19>"
 set pInput($i(pInput))="p=<-2236,415,-1699>, v=<-319,57,-246>, a=<22,-6,16>"
 set pInput($i(pInput))="p=<1843,-488,1798>, v=<259,-69,257>, a=<-26,5,-20>"
 set pInput($i(pInput))="p=<-2754,1655,331>, v=<-392,240,47>, a=<26,-16,-8>"
 set pInput($i(pInput))="p=<-834,251,-2722>, v=<-116,33,-386>, a=<3,-5,21>"
 set pInput($i(pInput))="p=<1021,-1266,3203>, v=<146,-185,456>, a=<-8,12,-36>"
 set pInput($i(pInput))="p=<-3008,-317,1005>, v=<-426,-45,145>, a=<27,1,-11>"
 set pInput($i(pInput))="p=<-2940,246,-187>, v=<-420,35,-22>, a=<34,-1,-1>"
 set pInput($i(pInput))="p=<1801,-1599,-1446>, v=<256,-221,-208>, a=<-15,12,14>"
 set pInput($i(pInput))="p=<-682,-3221,-349>, v=<-93,-456,-50>, a=<10,31,6>"
 set pInput($i(pInput))="p=<1654,207,-2009>, v=<238,33,-287>, a=<-20,-10,26>"
 set pInput($i(pInput))="p=<361,131,3200>, v=<51,15,455>, a=<-4,-1,-32>"
 set pInput($i(pInput))="p=<-633,-781,-2968>, v=<-91,-114,-422>, a=<5,6,29>"
 set pInput($i(pInput))="p=<-2215,-1455,1996>, v=<-315,-209,290>, a=<21,17,-15>"
 set pInput($i(pInput))="p=<-1296,-1166,2232>, v=<-185,-166,322>, a=<10,8,-22>"
 set pInput($i(pInput))="p=<-506,1002,-2804>, v=<-67,140,-401>, a=<7,-10,31>"
 set pInput($i(pInput))="p=<886,713,3210>, v=<125,97,458>, a=<-11,-11,-31>"
 set pInput($i(pInput))="p=<473,1814,2234>, v=<67,258,320>, a=<-6,-21,-19>"
 set pInput($i(pInput))="p=<-1602,1619,2001>, v=<-225,230,285>, a=<21,-16,-20>"
 set pInput($i(pInput))="p=<-742,-2555,288>, v=<-107,-365,42>, a=<7,26,-2>"
 set pInput($i(pInput))="p=<-3147,-1191,643>, v=<-445,-169,93>, a=<36,11,-8>"
 set pInput($i(pInput))="p=<1263,214,2752>, v=<180,30,395>, a=<-9,-2,-29>"
 set pInput($i(pInput))="p=<-2143,2199,1241>, v=<-310,308,175>, a=<23,-24,-8>"
 set pInput($i(pInput))="p=<-2553,928,-1224>, v=<-364,125,-172>, a=<25,-7,9>"
 set pInput($i(pInput))="p=<-2136,-2245,-1378>, v=<-307,-323,-195>, a=<24,23,13>"
 set pInput($i(pInput))="p=<889,-1593,2244>, v=<129,-222,323>, a=<-8,17,-23>"
 set pInput($i(pInput))="p=<-1520,-1646,1398>, v=<-223,-235,199>, a=<21,13,-11>"
 set pInput($i(pInput))="p=<2628,1000,-86>, v=<374,139,-16>, a=<-27,-16,1>"
 set pInput($i(pInput))="p=<-2376,-283,-2193>, v=<-336,-38,-314>, a=<29,7,24>"
 set pInput($i(pInput))="p=<1742,2026,408>, v=<247,292,55>, a=<-17,-23,1>"
 set pInput($i(pInput))="p=<-2191,-1544,-527>, v=<-312,-215,-75>, a=<20,15,7>"
 set pInput($i(pInput))="p=<-1704,-1827,1891>, v=<-241,-263,273>, a=<19,22,-18>"
 set pInput($i(pInput))="p=<-1270,-49,3352>, v=<-181,-13,478>, a=<12,2,-32>"
 set pInput($i(pInput))="p=<-2569,901,331>, v=<-369,129,47>, a=<26,-4,-4>"
 set pInput($i(pInput))="p=<1141,2256,1587>, v=<163,320,220>, a=<-13,-22,-18>"
 set pInput($i(pInput))="p=<1137,-2605,-1860>, v=<159,-373,-265>, a=<-10,24,14>"
 set pInput($i(pInput))="p=<-34,-1139,-2680>, v=<-3,-162,-383>, a=<0,10,26>"
 set pInput($i(pInput))="p=<2205,-1859,-418>, v=<318,-263,-57>, a=<-23,19,9>"
 set pInput($i(pInput))="p=<2263,-885,731>, v=<323,-127,101>, a=<-19,10,-7>"
 set pInput($i(pInput))="p=<747,-1743,-2548>, v=<107,-251,-360>, a=<-8,19,28>"
 set pInput($i(pInput))="p=<-2858,-1478,-787>, v=<-404,-214,-111>, a=<31,16,10>"
 set pInput($i(pInput))="p=<-2627,342,956>, v=<-375,45,136>, a=<26,-6,-12>"
 set pInput($i(pInput))="p=<-2234,2105,357>, v=<-319,303,51>, a=<19,-20,-4>"
 set pInput($i(pInput))="p=<1027,-2032,1325>, v=<153,-292,186>, a=<-7,20,-9>"
 set pInput($i(pInput))="p=<1283,-1286,2609>, v=<185,-183,373>, a=<-10,7,-23>"
 set pInput($i(pInput))="p=<1360,1947,2379>, v=<197,277,339>, a=<-17,-15,-23>"
 set pInput($i(pInput))="p=<-860,-679,2987>, v=<-122,-97,427>, a=<3,9,-24>"
 set pInput($i(pInput))="p=<-1647,2787,-244>, v=<-232,401,-37>, a=<17,-30,1>"
 set pInput($i(pInput))="p=<837,3170,1198>, v=<119,454,170>, a=<-4,-24,-11>"
 set pInput($i(pInput))="p=<1266,-1460,2161>, v=<179,-200,308>, a=<-14,10,-21>"
 set pInput($i(pInput))="p=<1648,1562,-2437>, v=<235,226,-350>, a=<-14,-12,24>"
 set pInput($i(pInput))="p=<-570,2209,-1513>, v=<-85,316,-215>, a=<1,-21,20>"
 set pInput($i(pInput))="p=<330,-2321,-199>, v=<47,-329,-28>, a=<-3,24,4>"
 set pInput($i(pInput))="p=<-2067,1180,1813>, v=<-299,169,263>, a=<20,-8,-15>"
 set pInput($i(pInput))="p=<-78,-2126,2288>, v=<-5,-307,321>, a=<-2,21,-25>"
 set pInput($i(pInput))="p=<-1626,281,1926>, v=<-232,40,277>, a=<23,3,-20>"
 set pInput($i(pInput))="p=<-235,3009,-77>, v=<-32,428,-16>, a=<1,-26,1>"
 set pInput($i(pInput))="p=<-345,3015,279>, v=<-52,430,42>, a=<0,-21,-1>"
 set pInput($i(pInput))="p=<2896,-2028,-978>, v=<416,-288,-138>, a=<-32,20,9>"
 set pInput($i(pInput))="p=<-3125,-612,759>, v=<-449,-87,108>, a=<31,5,-12>"
 set pInput($i(pInput))="p=<2888,2,384>, v=<414,0,57>, a=<-32,1,-6>"
 set pInput($i(pInput))="p=<-731,1698,2115>, v=<-106,244,305>, a=<7,-13,-21>"
 set pInput($i(pInput))="p=<2036,-736,-1453>, v=<294,-107,-208>, a=<-20,6,11>"
 set pInput($i(pInput))="p=<1652,-2222,234>, v=<236,-319,33>, a=<-18,15,-3>"
 set pInput($i(pInput))="p=<-515,-3243,235>, v=<-72,-462,30>, a=<3,33,1>"
 set pInput($i(pInput))="p=<7,-2446,2313>, v=<-3,-346,330>, a=<4,28,-21>"
 set pInput($i(pInput))="p=<1566,2106,1297>, v=<223,298,187>, a=<-13,-21,-15>"
 set pInput($i(pInput))="p=<2773,-241,-1939>, v=<393,-34,-277>, a=<-23,3,19>"
 set pInput($i(pInput))="p=<-1981,-951,1585>, v=<-286,-137,221>, a=<20,8,-18>"
 set pInput($i(pInput))="p=<-14,2752,627>, v=<-2,392,88>, a=<2,-21,-6>"
 set pInput($i(pInput))="p=<-2752,-498,2256>, v=<-393,-70,317>, a=<27,1,-23>"
 set pInput($i(pInput))="p=<-2795,-853,-603>, v=<-406,-121,-86>, a=<25,5,2>"
 set pInput($i(pInput))="p=<631,-2038,-1425>, v=<90,-293,-206>, a=<-4,20,12>"
 set pInput($i(pInput))="p=<125,2224,1993>, v=<18,316,291>, a=<4,-21,-25>"
 set pInput($i(pInput))="p=<-2231,489,-1563>, v=<-322,70,-224>, a=<23,-3,15>"
 set pInput($i(pInput))="p=<-2139,746,-1996>, v=<-302,109,-279>, a=<21,-5,18>"
 set pInput($i(pInput))="p=<992,-1201,-2833>, v=<145,-172,-408>, a=<-8,15,24>"
 set pInput($i(pInput))="p=<-1702,-2598,-45>, v=<-247,-371,-5>, a=<17,28,-2>"
 set pInput($i(pInput))="p=<-2590,-960,482>, v=<-369,-137,68>, a=<28,7,2>"
 set pInput($i(pInput))="p=<3216,-233,416>, v=<461,-31,61>, a=<-34,6,-4>"
 set pInput($i(pInput))="p=<-1121,692,2728>, v=<-162,101,391>, a=<13,-8,-27>"
 set pInput($i(pInput))="p=<-2671,-146,2193>, v=<-383,-24,313>, a=<22,-3,-22>"
 set pInput($i(pInput))="p=<763,-241,-3416>, v=<107,-32,-482>, a=<-9,-2,33>"
 set pInput($i(pInput))="p=<-671,-3065,126>, v=<-94,-437,16>, a=<13,31,-4>"
 set pInput($i(pInput))="p=<564,-2454,1713>, v=<75,-350,244>, a=<-5,24,-17>"
 set pInput($i(pInput))="p=<-1735,-2340,-460>, v=<-247,-334,-62>, a=<14,23,4>"
 set pInput($i(pInput))="p=<6,-2515,1136>, v=<0,-359,163>, a=<0,26,-10>"
 set pInput($i(pInput))="p=<2952,-18,724>, v=<424,1,103>, a=<-33,2,-9>"
 set pInput($i(pInput))="p=<-1425,729,2352>, v=<-206,107,337>, a=<17,-7,-23>"
 set pInput($i(pInput))="p=<-2551,-193,-2026>, v=<-365,-31,-289>, a=<25,3,17>"
 set pInput($i(pInput))="p=<1329,-2258,-1434>, v=<189,-322,-206>, a=<-18,18,14>"
 set pInput($i(pInput))="p=<1211,2337,-829>, v=<173,332,-120>, a=<-15,-20,8>"
 set pInput($i(pInput))="p=<-1528,-2029,2196>, v=<-218,-290,315>, a=<18,18,-19>"
 set pInput($i(pInput))="p=<2764,2067,855>, v=<391,290,119>, a=<-23,-16,-7>"
 set pInput($i(pInput))="p=<50,-2547,1000>, v=<8,-363,140>, a=<-1,27,-10>"
 set pInput($i(pInput))="p=<-1843,-740,-2538>, v=<-258,-105,-364>, a=<20,8,24>"
 set pInput($i(pInput))="p=<2901,-143,-287>, v=<416,-19,-40>, a=<-32,-3,3>"
 set pInput($i(pInput))="p=<-745,3115,-349>, v=<-111,448,-51>, a=<7,-34,-3>"
 set pInput($i(pInput))="p=<1591,264,-2030>, v=<222,37,-288>, a=<-16,-6,19>"
 set pInput($i(pInput))="p=<166,-48,3636>, v=<23,-10,516>, a=<-1,2,-30>"
 set pInput($i(pInput))="p=<319,1678,-2277>, v=<46,237,-320>, a=<0,-18,23>"
 set pInput($i(pInput))="p=<-2171,614,-1695>, v=<-310,87,-242>, a=<21,-4,11>"
 set pInput($i(pInput))="p=<-1126,665,-2761>, v=<-157,93,-392>, a=<14,-6,29>"
 set pInput($i(pInput))="p=<1741,2247,1663>, v=<246,324,234>, a=<-17,-16,-20>"
 set pInput($i(pInput))="p=<1650,-1865,-1148>, v=<236,-268,-164>, a=<-17,14,11>"
 set pInput($i(pInput))="p=<319,-1899,-1553>, v=<45,-274,-219>, a=<0,18,12>"
 set pInput($i(pInput))="p=<-319,321,-3639>, v=<-42,45,-518>, a=<5,0,31>"
 set pInput($i(pInput))="p=<-863,-2811,20>, v=<-123,-397,4>, a=<9,31,-2>"
 set pInput($i(pInput))="p=<2645,-31,542>, v=<373,-5,73>, a=<-23,1,-4>"
 set pInput($i(pInput))="p=<-228,-1990,2353>, v=<-35,-287,336>, a=<5,22,-21>"
 set pInput($i(pInput))="p=<3382,828,-998>, v=<482,123,-143>, a=<-35,-9,7>"
 set pInput($i(pInput))="p=<-681,-2015,-1438>, v=<-89,-285,-208>, a=<6,19,12>"
 set pInput($i(pInput))="p=<-2127,-1613,-1494>, v=<-308,-234,-212>, a=<19,16,11>"
 set pInput($i(pInput))="p=<65,2762,-1780>, v=<9,395,-254>, a=<2,-26,17>"
 set pInput($i(pInput))="p=<-798,-2143,754>, v=<-112,-311,104>, a=<12,25,-10>"
 set pInput($i(pInput))="p=<1936,1826,927>, v=<277,263,131>, a=<-15,-20,-10>"
 set pInput($i(pInput))="p=<-720,-1926,-1387>, v=<-103,-275,-198>, a=<8,16,11>"
 set pInput($i(pInput))="p=<-2584,-1286,524>, v=<-371,-180,74>, a=<28,15,-9>"
 set pInput($i(pInput))="p=<286,-3580,426>, v=<39,-510,60>, a=<0,34,-7>"
 set pInput($i(pInput))="p=<-1940,-1873,-414>, v=<-277,-269,-56>, a=<19,14,6>"
 set pInput($i(pInput))="p=<2631,-809,-1547>, v=<376,-116,-229>, a=<-30,10,16>"
 set pInput($i(pInput))="p=<673,2160,-1825>, v=<102,308,-257>, a=<-4,-23,17>"
 set pInput($i(pInput))="p=<2169,-2413,-1194>, v=<307,-344,-170>, a=<-20,25,16>"
 set pInput($i(pInput))="p=<603,-3052,-393>, v=<89,-434,-53>, a=<-11,33,1>"
 set pInput($i(pInput))="p=<-1690,1909,1134>, v=<-241,272,169>, a=<15,-18,-15>"
 set pInput($i(pInput))="p=<-623,1217,1954>, v=<-93,172,275>, a=<10,-16,-15>"
 set pInput($i(pInput))="p=<-1697,-316,2170>, v=<-242,-45,310>, a=<20,-3,-19>"
 set pInput($i(pInput))="p=<-1516,2344,1308>, v=<-216,333,185>, a=<18,-20,-17>"
 set pInput($i(pInput))="p=<1853,-1625,701>, v=<261,-229,105>, a=<-20,19,-4>"
 set pInput($i(pInput))="p=<1542,-522,-2138>, v=<220,-70,-305>, a=<-20,8,20>"
 set pInput($i(pInput))="p=<-1835,-1148,-887>, v=<-257,-165,-126>, a=<22,13,5>"
 set pInput($i(pInput))="p=<3238,-2064,302>, v=<460,-292,47>, a=<-32,20,0>"
 set pInput($i(pInput))="p=<1003,-2638,-162>, v=<146,-372,-23>, a=<-10,26,5>"
 set pInput($i(pInput))="p=<-2709,1375,804>, v=<-385,196,120>, a=<24,-9,-9>"
 set pInput($i(pInput))="p=<-184,555,2572>, v=<-30,79,367>, a=<1,0,-29>"
 set pInput($i(pInput))="p=<-754,2751,-299>, v=<-110,393,-47>, a=<9,-28,2>"
 set pInput($i(pInput))="p=<2362,713,-1616>, v=<332,104,-227>, a=<-23,-7,15>"
 set pInput($i(pInput))="p=<254,732,-2598>, v=<38,104,-368>, a=<-8,-7,19>"
 set pInput($i(pInput))="p=<-2364,-799,1470>, v=<-344,-112,211>, a=<23,7,-16>"
 set pInput($i(pInput))="p=<2519,1937,-284>, v=<360,274,-40>, a=<-32,-22,3>"
 set pInput($i(pInput))="p=<2368,828,-1323>, v=<333,118,-182>, a=<-27,-5,12>"
 set pInput($i(pInput))="p=<-1443,-1799,2182>, v=<-204,-257,310>, a=<18,22,-23>"
 set pInput($i(pInput))="p=<-2230,320,1535>, v=<-319,47,219>, a=<21,-1,-15>"
 set pInput($i(pInput))="p=<-2176,1006,1711>, v=<-314,138,241>, a=<15,-10,-17>"
 set pInput($i(pInput))="p=<-2359,-1764,735>, v=<-341,-252,107>, a=<20,19,-6>"
 set pInput($i(pInput))="p=<-2255,2133,478>, v=<-318,303,67>, a=<21,-23,-4>"
 set pInput($i(pInput))="p=<1838,2021,-2030>, v=<262,293,-291>, a=<-22,-22,24>"
 set pInput($i(pInput))="p=<676,2730,-1581>, v=<98,391,-222>, a=<-7,-25,18>"
 set pInput($i(pInput))="p=<1654,1705,1873>, v=<233,240,270>, a=<-20,-22,-18>"
 set pInput($i(pInput))="p=<2899,-1228,-768>, v=<414,-171,-110>, a=<-29,10,12>"
 set pInput($i(pInput))="p=<-1106,-2603,-1038>, v=<-160,-376,-152>, a=<13,33,10>"
 set pInput($i(pInput))="p=<-2486,-1591,1417>, v=<-352,-223,202>, a=<23,14,-15>"
 set pInput($i(pInput))="p=<-224,-2723,405>, v=<-31,-392,57>, a=<-4,30,-2>"
 set pInput($i(pInput))="p=<-990,-385,2834>, v=<-141,-51,401>, a=<11,1,-30>"
 set pInput($i(pInput))="p=<2393,-1847,-12>, v=<343,-271,-1>, a=<-24,18,0>"
 set pInput($i(pInput))="p=<897,-1971,2676>, v=<126,-282,379>, a=<-11,19,-26>"
 set pInput($i(pInput))="p=<-1382,828,2465>, v=<-197,118,354>, a=<12,-11,-24>"
 set pInput($i(pInput))="p=<2715,-636,-95>, v=<383,-92,-10>, a=<-23,5,2>"
 set pInput($i(pInput))="p=<-1672,1496,1384>, v=<-238,215,196>, a=<13,-12,-8>"
 set pInput($i(pInput))="p=<-695,2864,430>, v=<-96,408,66>, a=<13,-28,-9>"
 set pInput($i(pInput))="p=<-890,2879,152>, v=<-128,419,18>, a=<11,-25,-1>"
 set pInput($i(pInput))="p=<1150,854,2388>, v=<160,127,344>, a=<-10,-10,-23>"
 set pInput($i(pInput))="p=<-1328,304,2387>, v=<-189,44,346>, a=<19,0,-20>"
 set pInput($i(pInput))="p=<1911,1030,2606>, v=<274,147,372>, a=<-21,-5,-22>"
 set pInput($i(pInput))="p=<-153,1935,1425>, v=<-17,277,204>, a=<-6,-18,-15>"
 set pInput($i(pInput))="p=<-563,-39,-3152>, v=<-85,-5,-449>, a=<4,0,31>"
 set pInput($i(pInput))="p=<1376,-434,2342>, v=<194,-58,337>, a=<-11,7,-24>"
 set pInput($i(pInput))="p=<1328,-3274,1577>, v=<188,-464,224>, a=<-13,32,-11>"
 set pInput($i(pInput))="p=<-1483,2780,842>, v=<-211,394,122>, a=<14,-27,-4>"
 set pInput($i(pInput))="p=<-2579,-50,157>, v=<-368,-5,18>, a=<22,0,-2>"
 set pInput($i(pInput))="p=<-2233,-1101,1703>, v=<-326,-156,244>, a=<23,11,-19>"
 set pInput($i(pInput))="p=<1576,-2527,660>, v=<225,-364,94>, a=<-14,29,-6>"
 set pInput($i(pInput))="p=<-920,-2797,-447>, v=<-128,-399,-63>, a=<7,22,4>"
 set pInput($i(pInput))="p=<-2430,2192,873>, v=<-347,313,128>, a=<25,-21,-11>"
 set pInput($i(pInput))="p=<616,2820,-591>, v=<84,402,-86>, a=<-5,-28,5>"
 set pInput($i(pInput))="p=<-544,-1235,2995>, v=<-78,-179,428>, a=<6,12,-29>"
 set pInput($i(pInput))="p=<-2103,152,1778>, v=<-297,15,262>, a=<21,2,-18>"
 set pInput($i(pInput))="p=<1499,276,3011>, v=<213,37,435>, a=<-14,-7,-31>"
 set pInput($i(pInput))="p=<-1913,2443,611>, v=<-270,345,87>, a=<15,-24,-4>"
 set pInput($i(pInput))="p=<-398,2956,72>, v=<-56,417,10>, a=<1,-31,5>"
 set pInput($i(pInput))="p=<-1863,1996,-1348>, v=<-266,285,-195>, a=<18,-15,14>"
 set pInput($i(pInput))="p=<-2302,-248,1303>, v=<-325,-38,181>, a=<17,1,-17>"
 set pInput($i(pInput))="p=<-591,-341,2548>, v=<-89,-52,364>, a=<4,5,-27>"
 set pInput($i(pInput))="p=<906,-1426,-2591>, v=<129,-206,-368>, a=<-7,14,19>"
 set pInput($i(pInput))="p=<-1733,-1479,1564>, v=<-251,-213,222>, a=<18,9,-13>"
 set pInput($i(pInput))="p=<2526,1103,78>, v=<357,157,11>, a=<-24,-9,-2>"
 set pInput($i(pInput))="p=<745,1626,2823>, v=<111,228,409>, a=<-6,-17,-23>"
 set pInput($i(pInput))="p=<-818,43,-2240>, v=<-118,11,-320>, a=<13,1,25>"
 set pInput($i(pInput))="p=<1837,993,1492>, v=<260,148,213>, a=<-17,-10,-16>"
 set pInput($i(pInput))="p=<-1099,1353,-2333>, v=<-162,193,-333>, a=<8,-9,22>"
 set pInput($i(pInput))="p=<467,2292,2372>, v=<66,332,340>, a=<-10,-18,-20>"
 set pInput($i(pInput))="p=<2035,1594,-773>, v=<290,227,-112>, a=<-18,-8,9>"
 set pInput($i(pInput))="p=<1663,-1377,1996>, v=<237,-196,283>, a=<-20,14,-16>"
 set pInput($i(pInput))="p=<-1151,1892,1053>, v=<-163,270,143>, a=<8,-21,-9>"
 set pInput($i(pInput))="p=<-1985,-1355,-1070>, v=<-283,-192,-151>, a=<22,10,9>"
 set pInput($i(pInput))="p=<880,-1024,-2847>, v=<121,-146,-401>, a=<-6,10,37>"
 set pInput($i(pInput))="p=<-2506,-941,-1276>, v=<-359,-141,-182>, a=<25,14,14>"
 set pInput($i(pInput))="p=<448,-3321,-1237>, v=<65,-469,-174>, a=<-4,31,10>"
 set pInput($i(pInput))="p=<1082,-384,2456>, v=<154,-55,343>, a=<-4,1,-21>"
 set pInput($i(pInput))="p=<583,-1175,2602>, v=<80,-167,370>, a=<-5,8,-26>"
 set pInput($i(pInput))="p=<-2143,1051,-2228>, v=<-306,150,-321>, a=<16,-11,26>"
 set pInput($i(pInput))="p=<-1351,1113,2530>, v=<-195,156,360>, a=<16,-11,-23>"
 set pInput($i(pInput))="p=<1289,2415,1068>, v=<186,345,157>, a=<-13,-31,-9>"
 set pInput($i(pInput))="p=<1829,-441,-2369>, v=<261,-59,-331>, a=<-20,4,25>"
 set pInput($i(pInput))="p=<-1181,2801,-1204>, v=<-168,406,-169>, a=<11,-25,15>"
 set pInput($i(pInput))="p=<1789,111,2716>, v=<253,16,391>, a=<-12,-1,-28>"
 set pInput($i(pInput))="p=<1188,-2396,-1168>, v=<173,-343,-166>, a=<-18,21,11>"
 set pInput($i(pInput))="p=<-624,-2348,1872>, v=<-87,-331,263>, a=<6,23,-17>"
 set pInput($i(pInput))="p=<974,2046,1600>, v=<141,293,228>, a=<-10,-20,-20>"
 set pInput($i(pInput))="p=<1087,-3,2753>, v=<157,4,393>, a=<-10,1,-31>"
 set pInput($i(pInput))="p=<-1696,2565,1439>, v=<-242,365,200>, a=<15,-21,-14>"
 set pInput($i(pInput))="p=<-2139,1264,1625>, v=<-308,186,239>, a=<21,-16,-17>"
 set pInput($i(pInput))="p=<-808,-2806,706>, v=<-116,-402,100>, a=<10,31,-7>"
 set pInput($i(pInput))="p=<-3344,-671,-1309>, v=<-477,-89,-186>, a=<31,4,12>"
 set pInput($i(pInput))="p=<-3120,-1016,-1164>, v=<-445,-145,-169>, a=<33,9,11>"
 set pInput($i(pInput))="p=<-392,1935,-1765>, v=<-54,277,-256>, a=<7,-20,20>"
 set pInput($i(pInput))="p=<-2772,50,-724>, v=<-398,7,-103>, a=<22,-2,1>"
 set pInput($i(pInput))="p=<-1135,909,-2293>, v=<-162,123,-325>, a=<11,-2,17>"
 set pInput($i(pInput))="p=<-2854,-66,-601>, v=<-402,-8,-82>, a=<29,-3,6>"
 set pInput($i(pInput))="p=<1651,760,1457>, v=<233,111,209>, a=<-16,-9,-14>"
 set pInput($i(pInput))="p=<-1771,-1151,-2641>, v=<-254,-160,-378>, a=<17,14,27>"
 set pInput($i(pInput))="p=<-1065,-2133,-2022>, v=<-152,-309,-293>, a=<12,24,14>"
 set pInput($i(pInput))="p=<1476,2335,-246>, v=<211,333,-32>, a=<-7,-22,0>"
 set pInput($i(pInput))="p=<-1903,461,2772>, v=<-268,58,396>, a=<21,-2,-25>"
 set pInput($i(pInput))="p=<765,-2802,769>, v=<112,-398,106>, a=<-3,33,-5>"
 set pInput($i(pInput))="p=<-3176,954,-234>, v=<-450,133,-36>, a=<29,-9,3>"
 set pInput($i(pInput))="p=<2177,-558,-2053>, v=<316,-78,-293>, a=<-21,5,19>"
 set pInput($i(pInput))="p=<394,1915,-2164>, v=<59,277,-313>, a=<-5,-20,21>"
 set pInput($i(pInput))="p=<1111,2949,1071>, v=<155,421,153>, a=<-10,-29,-12>"
 set pInput($i(pInput))="p=<-1787,102,2329>, v=<-254,13,332>, a=<14,-3,-20>"
 set pInput($i(pInput))="p=<-1253,-2502,-882>, v=<-176,-356,-124>, a=<15,24,7>"
 set pInput($i(pInput))="p=<1524,2539,-1037>, v=<216,362,-148>, a=<-15,-21,5>"
 set pInput($i(pInput))="p=<1881,745,2344>, v=<266,106,334>, a=<-14,-5,-24>"
 set pInput($i(pInput))="p=<-824,2492,1274>, v=<-117,355,187>, a=<2,-27,-11>"
 set pInput($i(pInput))="p=<-2672,-391,-718>, v=<-377,-60,-103>, a=<26,2,7>"
 set pInput($i(pInput))="p=<1706,-2502,613>, v=<248,-357,87>, a=<-19,23,-9>"
 set pInput($i(pInput))="p=<2838,442,349>, v=<400,63,52>, a=<-33,-4,-3>"
 set pInput($i(pInput))="p=<271,1719,-2620>, v=<42,245,-371>, a=<-5,-23,22>"
 set pInput($i(pInput))="p=<-1158,-1793,1596>, v=<-165,-258,225>, a=<6,10,-14>"
 set pInput($i(pInput))="p=<2491,-195,-2133>, v=<353,-23,-304>, a=<-22,-4,21>"
 set pInput($i(pInput))="p=<-119,2896,-1592>, v=<-14,413,-227>, a=<-2,-25,14>"
 set pInput($i(pInput))="p=<886,-685,2791>, v=<130,-97,398>, a=<-8,6,-26>"
 set pInput($i(pInput))="p=<1066,-2652,1270>, v=<152,-374,179>, a=<-10,28,-19>"
 set pInput($i(pInput))="p=<2080,1437,-1544>, v=<290,206,-216>, a=<-23,-15,15>"
 set pInput($i(pInput))="p=<1863,410,2408>, v=<270,56,345>, a=<-18,-4,-18>"
 set pInput($i(pInput))="p=<-524,3071,96>, v=<-74,436,11>, a=<7,-33,-4>"
 set pInput($i(pInput))="p=<580,-948,-2576>, v=<88,-133,-367>, a=<-12,11,22>"
 set pInput($i(pInput))="p=<-1103,1711,1858>, v=<-154,246,264>, a=<11,-15,-16>"
 set pInput($i(pInput))="p=<607,-2998,-745>, v=<79,-428,-101>, a=<-11,33,7>"
 set pInput($i(pInput))="p=<-1900,-1037,-1936>, v=<-269,-150,-275>, a=<16,12,15>"
 set pInput($i(pInput))="p=<-1155,-491,-2983>, v=<-164,-71,-431>, a=<11,-2,30>"
 set pInput($i(pInput))="p=<-2544,887,-742>, v=<-363,124,-109>, a=<23,-6,9>"
 set pInput($i(pInput))="p=<-731,2162,-1216>, v=<-102,311,-170>, a=<7,-19,16>"
 set pInput($i(pInput))="p=<-2202,-1939,1089>, v=<-320,-277,157>, a=<25,20,-10>"
 set pInput($i(pInput))="p=<-28,1561,2087>, v=<2,223,300>, a=<0,-16,-20>"
 set pInput($i(pInput))="p=<-1911,-1149,-1625>, v=<-271,-165,-230>, a=<15,10,12>"
 set pInput($i(pInput))="p=<-2869,-1090,310>, v=<-414,-155,49>, a=<26,15,-1>"
 set pInput($i(pInput))="p=<-695,-2254,-1859>, v=<-100,-321,-266>, a=<11,26,13>"
 set pInput($i(pInput))="p=<-2840,-674,1527>, v=<-405,-95,220>, a=<28,0,-17>"
 set pInput($i(pInput))="p=<-647,2949,1149>, v=<-91,421,164>, a=<8,-32,-11>"
 set pInput($i(pInput))="p=<2811,-1286,624>, v=<400,-179,89>, a=<-29,12,-3>"
 set pInput($i(pInput))="p=<1281,-380,-2752>, v=<182,-55,-391>, a=<-16,8,24>"
 set pInput($i(pInput))="p=<-2162,-1503,-1690>, v=<-306,-212,-240>, a=<21,15,14>"
 set pInput($i(pInput))="p=<2629,761,206>, v=<373,108,34>, a=<-27,-7,-7>"
 set pInput($i(pInput))="p=<-2021,620,2109>, v=<-288,90,301>, a=<20,-12,-22>"
 set pInput($i(pInput))="p=<-368,-2701,-164>, v=<-52,-380,-20>, a=<6,21,2>"
 set pInput($i(pInput))="p=<421,-3240,-681>, v=<60,-463,-96>, a=<-5,30,6>"
 set pInput($i(pInput))="p=<1919,-2148,-570>, v=<273,-304,-84>, a=<-24,24,5>"
 set pInput($i(pInput))="p=<1869,91,2715>, v=<264,13,389>, a=<-17,-5,-28>"
 set pInput($i(pInput))="p=<653,2752,1283>, v=<91,393,186>, a=<-3,-26,-15>"
 set pInput($i(pInput))="p=<-1085,-2377,-504>, v=<-155,-343,-71>, a=<10,23,4>"
 set pInput($i(pInput))="p=<2790,-724,-1756>, v=<400,-103,-250>, a=<-27,7,20>"
 set pInput($i(pInput))="p=<2362,670,1049>, v=<341,95,149>, a=<-22,-6,-10>"
 set pInput($i(pInput))="p=<-3223,261,-688>, v=<-459,42,-99>, a=<29,3,6>"
 set pInput($i(pInput))="p=<-968,2692,726>, v=<-135,386,100>, a=<9,-27,-6>"
 set pInput($i(pInput))="p=<763,-873,3032>, v=<108,-128,433>, a=<-7,11,-30>"
 set pInput($i(pInput))="p=<-397,-2950,-1235>, v=<-54,-417,-179>, a=<-1,30,13>"
 set pInput($i(pInput))="p=<2644,506,2319>, v=<370,68,328>, a=<-25,-5,-21>"
 set pInput($i(pInput))="p=<226,1558,2032>, v=<28,223,290>, a=<-2,-18,-18>"
 set pInput($i(pInput))="p=<-96,-2863,420>, v=<-8,-411,59>, a=<2,29,-1>"
 set pInput($i(pInput))="p=<2753,-521,644>, v=<389,-74,94>, a=<-25,4,-6>"
 set pInput($i(pInput))="p=<-2535,604,1696>, v=<-363,84,240>, a=<23,-5,-16>"
 set pInput($i(pInput))="p=<-1475,-1868,-1676>, v=<-211,-271,-235>, a=<13,20,20>"
 set pInput($i(pInput))="p=<2257,-411,1855>, v=<326,-61,264>, a=<-19,-2,-19>"
 set pInput($i(pInput))="p=<2632,1836,822>, v=<376,266,120>, a=<-30,-16,-8>"
 set pInput($i(pInput))="p=<-1695,1905,-1631>, v=<-243,272,-238>, a=<14,-27,18>"
 set pInput($i(pInput))="p=<-1726,1459,-2018>, v=<-246,211,-289>, a=<22,-17,23>"
 set pInput($i(pInput))="p=<2307,2175,489>, v=<328,312,67>, a=<-23,-20,-6>"
 set pInput($i(pInput))="p=<-1861,2174,-527>, v=<-269,313,-75>, a=<18,-24,5>"
 set pInput($i(pInput))="p=<-208,1185,2569>, v=<-28,169,371>, a=<-1,-10,-25>"
 set pInput($i(pInput))="p=<-1923,-300,2216>, v=<-271,-48,315>, a=<19,8,-22>"
 set pInput($i(pInput))="p=<-428,3024,-1181>, v=<-61,432,-171>, a=<3,-34,14>"
 set pInput($i(pInput))="p=<549,-2670,-461>, v=<73,-387,-65>, a=<-5,26,3>"
 set pInput($i(pInput))="p=<-1556,326,-2238>, v=<-221,43,-316>, a=<10,-3,27>"
 set pInput($i(pInput))="p=<-598,-3422,-454>, v=<-86,-488,-64>, a=<1,35,4>"
 set pInput($i(pInput))="p=<2143,-443,1333>, v=<302,-66,193>, a=<-20,8,-11>"
 set pInput($i(pInput))="p=<286,231,2772>, v=<40,35,396>, a=<-7,-1,-30>"
 set pInput($i(pInput))="p=<362,-2668,9>, v=<51,-379,1>, a=<-1,27,0>"
 set pInput($i(pInput))="p=<1015,-2626,-85>, v=<142,-376,-11>, a=<-13,33,-2>"
 set pInput($i(pInput))="p=<-709,904,2451>, v=<-103,130,350>, a=<5,-8,-27>"
 set pInput($i(pInput))="p=<2081,408,-1170>, v=<298,58,-166>, a=<-15,-7,11>"
 set pInput($i(pInput))="p=<-482,-2973,-1081>, v=<-69,-420,-151>, a=<2,31,9>"
 set pInput($i(pInput))="p=<-818,-74,-2792>, v=<-118,-10,-402>, a=<14,-3,32>"
 set pInput($i(pInput))="p=<2999,-87,-960>, v=<427,-14,-136>, a=<-31,3,6>"
 set pInput($i(pInput))="p=<2885,-1265,-374>, v=<409,-181,-53>, a=<-29,12,3>"
 set pInput($i(pInput))="p=<-1572,2938,16>, v=<-221,415,0>, a=<12,-30,0>"
 set pInput($i(pInput))="p=<-2424,-669,-1204>, v=<-342,-92,-175>, a=<21,8,17>"
 set pInput($i(pInput))="p=<-1215,1266,-2099>, v=<-173,176,-300>, a=<14,-7,21>"
 set pInput($i(pInput))="p=<-202,-3331,202>, v=<-33,-475,25>, a=<-1,36,1>"
 set pInput($i(pInput))="p=<935,2601,-482>, v=<133,370,-68>, a=<-12,-26,4>"
 set pInput($i(pInput))="p=<-1796,-2630,-1179>, v=<-260,-374,-168>, a=<20,24,10>"
 set pInput($i(pInput))="p=<-1532,-596,-1900>, v=<-220,-82,-274>, a=<18,5,23>"
 set pInput($i(pInput))="p=<-1577,-720,-2161>, v=<-228,-100,-303>, a=<17,8,25>"
 set pInput($i(pInput))="p=<-1215,1584,1974>, v=<-178,226,278>, a=<17,-15,-22>"
 set pInput($i(pInput))="p=<-3480,-170,1515>, v=<-499,-19,213>, a=<38,-1,-14>"
 set pInput($i(pInput))="p=<-2436,-111,-929>, v=<-353,-14,-128>, a=<25,0,14>"
 set pInput($i(pInput))="p=<2047,1023,-2117>, v=<292,149,-304>, a=<-21,-10,21>"
 set pInput($i(pInput))="p=<1510,-3054,336>, v=<224,-436,55>, a=<-12,35,-2>"
 set pInput($i(pInput))="p=<-2860,74,1242>, v=<-408,10,177>, a=<29,-2,-11>"
 set pInput($i(pInput))="p=<423,2218,-2064>, v=<56,316,-290>, a=<-1,-23,19>"
 set pInput($i(pInput))="p=<-1523,391,2820>, v=<-216,54,401>, a=<16,-3,-25>"
 set pInput($i(pInput))="p=<2150,822,-2210>, v=<305,114,-314>, a=<-21,-10,22>"
 set pInput($i(pInput))="p=<980,-2578,716>, v=<140,-368,106>, a=<-13,25,-13>"
 set pInput($i(pInput))="p=<-2221,-1430,671>, v=<-319,-202,91>, a=<29,20,-6>"
 set pInput($i(pInput))="p=<71,585,-2438>, v=<13,84,-348>, a=<0,1,24>"
 set pInput($i(pInput))="p=<-2243,-2418,-28>, v=<-320,-339,-10>, a=<22,23,0>"
 set pInput($i(pInput))="p=<-1990,1907,1046>, v=<-283,274,147>, a=<14,-22,-10>"
 set pInput($i(pInput))="p=<646,-563,-2987>, v=<96,-80,-426>, a=<-6,11,28>"
 set pInput($i(pInput))="p=<1124,-2386,-2399>, v=<166,-340,-342>, a=<-12,28,23>"
 set pInput($i(pInput))="p=<1269,-527,-2292>, v=<184,-75,-331>, a=<-12,2,24>"
 set pInput($i(pInput))="p=<-1031,2489,-962>, v=<-147,354,-138>, a=<13,-21,14>"
 set pInput($i(pInput))="p=<723,-2658,-127>, v=<105,-380,-14>, a=<-6,27,2>"
 set pInput($i(pInput))="p=<2,1922,2219>, v=<0,278,321>, a=<3,-18,-23>"
 set pInput($i(pInput))="p=<-2842,1751,-150>, v=<-408,256,-21>, a=<26,-17,-4>"
 set pInput($i(pInput))="p=<45,-2950,-602>, v=<9,-419,-87>, a=<3,29,6>"
 set pInput($i(pInput))="p=<-1231,-1203,-2120>, v=<-176,-172,-302>, a=<8,13,18>"
 set pInput($i(pInput))="p=<1637,-356,-1921>, v=<234,-56,-273>, a=<-14,1,18>"
 set pInput($i(pInput))="p=<-1712,-1611,-1495>, v=<-246,-229,-213>, a=<16,22,14>"
 set pInput($i(pInput))="p=<3521,152,-943>, v=<503,23,-134>, a=<-35,6,7>"
 set pInput($i(pInput))="p=<-2104,-2243,-337>, v=<-302,-320,-51>, a=<19,23,3>"
 set pInput($i(pInput))="p=<2358,-595,-1456>, v=<336,-91,-213>, a=<-22,8,14>"
 set pInput($i(pInput))="p=<-525,-1627,2776>, v=<-69,-232,399>, a=<0,14,-32>"
 set pInput($i(pInput))="p=<1648,963,-1620>, v=<238,134,-231>, a=<-12,-6,15>"
 set pInput($i(pInput))="p=<-2751,363,-551>, v=<-391,54,-79>, a=<24,-3,9>"
 set pInput($i(pInput))="p=<300,1792,2155>, v=<47,251,307>, a=<-6,-17,-16>"
 set pInput($i(pInput))="p=<1106,-214,-2291>, v=<156,-35,-325>, a=<-3,0,23>"
 set pInput($i(pInput))="p=<-1964,-795,-2331>, v=<-286,-111,-333>, a=<19,15,18>"
 set pInput($i(pInput))="p=<137,-3166,-572>, v=<21,-452,-82>, a=<0,30,3>"
 set pInput($i(pInput))="p=<-2691,705,-999>, v=<-388,98,-139>, a=<26,-9,10>"
 set pInput($i(pInput))="p=<1203,343,-3272>, v=<174,54,-469>, a=<-12,2,32>"
 set pInput($i(pInput))="p=<3115,-432,-66>, v=<447,-61,-3>, a=<-30,4,0>"
 set pInput($i(pInput))="p=<2562,-1744,862>, v=<367,-252,123>, a=<-23,17,-5>"
 set pInput($i(pInput))="p=<1380,-1281,1622>, v=<196,-177,230>, a=<-17,9,-14>"
 set pInput($i(pInput))="p=<-1200,-844,-2301>, v=<-173,-120,-328>, a=<15,15,20>"
 set pInput($i(pInput))="p=<-792,-1599,2552>, v=<-111,-231,367>, a=<7,17,-25>"
 set pInput($i(pInput))="p=<307,2585,-1745>, v=<46,361,-252>, a=<-2,-32,17>"
 set pInput($i(pInput))="p=<-199,-1278,-2273>, v=<-26,-186,-327>, a=<1,17,22>"
 set pInput($i(pInput))="p=<1870,-2159,-899>, v=<264,-314,-123>, a=<-18,22,6>"
 set pInput($i(pInput))="p=<434,1298,2381>, v=<63,185,337>, a=<-4,-11,-23>"
 set pInput($i(pInput))="p=<-2150,-2011,1077>, v=<-311,-289,157>, a=<15,22,-10>"
 set pInput($i(pInput))="p=<2355,-966,31>, v=<334,-136,2>, a=<-21,13,1>"
 set pInput($i(pInput))="p=<880,2467,1228>, v=<131,350,176>, a=<-10,-18,-9>"
 set pInput($i(pInput))="p=<2696,301,951>, v=<383,47,138>, a=<-29,-3,-10>"
 set pInput($i(pInput))="p=<50,1466,2481>, v=<4,210,354>, a=<0,-13,-21>"
 set pInput($i(pInput))="p=<-46,1414,2588>, v=<-3,203,369>, a=<2,-15,-22>"
 set pInput($i(pInput))="p=<-1343,790,2128>, v=<-191,114,306>, a=<17,-8,-19>"
 set pInput($i(pInput))="p=<-1893,-320,1958>, v=<-271,-46,278>, a=<18,1,-19>"
 set pInput($i(pInput))="p=<3013,80,1731>, v=<433,10,244>, a=<-30,0,-12>"
 set pInput($i(pInput))="p=<-1561,-2177,-1020>, v=<-227,-314,-145>, a=<16,26,16>"
 set pInput($i(pInput))="p=<-1230,2247,-501>, v=<-169,320,-71>, a=<14,-22,4>"
 set pInput($i(pInput))="p=<527,-2245,1744>, v=<67,-319,248>, a=<-6,21,-17>"
 set pInput($i(pInput))="p=<-1513,-166,-2981>, v=<-211,-28,-425>, a=<15,0,29>"
 set pInput($i(pInput))="p=<440,-823,2548>, v=<63,-116,364>, a=<-4,10,-24>"
 set pInput($i(pInput))="p=<-1545,-2022,350>, v=<-217,-285,51>, a=<19,18,-6>"
 set pInput($i(pInput))="p=<-1920,-2099,1374>, v=<-271,-304,197>, a=<18,21,-12>"
 set pInput($i(pInput))="p=<-1984,2245,966>, v=<-283,325,138>, a=<22,-22,-5>"
 set pInput($i(pInput))="p=<1286,1145,1885>, v=<186,163,271>, a=<-7,-11,-18>"
 set pInput($i(pInput))="p=<-2077,-1678,1117>, v=<-294,-243,156>, a=<24,17,-9>"
 set pInput($i(pInput))="p=<-65,3081,988>, v=<-9,440,141>, a=<-1,-33,-13>"
 set pInput($i(pInput))="p=<1372,-2516,92>, v=<198,-361,17>, a=<-13,23,0>"
 set pInput($i(pInput))="p=<574,-2894,-2168>, v=<82,-413,-309>, a=<-1,28,22>"
 set pInput($i(pInput))="p=<2843,-746,1072>, v=<408,-108,156>, a=<-26,5,-8>"
 set pInput($i(pInput))="p=<-2673,2015,-608>, v=<-380,287,-87>, a=<29,-14,5>"
 set pInput($i(pInput))="p=<-1103,-1722,-1992>, v=<-157,-247,-289>, a=<14,19,18>"
 set pInput($i(pInput))="p=<-619,528,-2863>, v=<-88,75,-410>, a=<5,-7,28>"
 set pInput($i(pInput))="p=<-1977,2190,1193>, v=<-282,311,167>, a=<17,-19,-13>"
 set pInput($i(pInput))="p=<860,-3029,253>, v=<123,-433,41>, a=<-8,33,-2>"
 set pInput($i(pInput))="p=<-1719,1295,-1775>, v=<-245,183,-250>, a=<13,-13,19>"
 set pInput($i(pInput))="p=<-2978,1898,-292>, v=<-428,271,-47>, a=<30,-18,2>"
 set pInput($i(pInput))="p=<565,1062,-2232>, v=<80,152,-315>, a=<-4,-10,28>"
 set pInput($i(pInput))="p=<-1305,1305,-2694>, v=<-183,186,-382>, a=<14,-14,26>"
 set pInput($i(pInput))="p=<-2484,-273,-1989>, v=<-359,-35,-283>, a=<23,4,18>"
 set pInput($i(pInput))="p=<1136,-1048,-2857>, v=<166,-150,-410>, a=<-9,9,30>"
 set pInput($i(pInput))="p=<-442,2206,2090>, v=<-64,315,301>, a=<4,-22,-14>"
 set pInput($i(pInput))="p=<-23,2898,224>, v=<-3,412,30>, a=<0,-26,1>"
 set pInput($i(pInput))="p=<2138,959,-1982>, v=<306,140,-283>, a=<-19,-9,17>"
 set pInput($i(pInput))="p=<-1618,1775,-1360>, v=<-231,253,-191>, a=<22,-18,12>"
 set pInput($i(pInput))="p=<692,1924,-2492>, v=<99,278,-361>, a=<-6,-17,28>"
 set pInput($i(pInput))="p=<-1023,2364,-1752>, v=<-142,340,-247>, a=<10,-19,19>"
 set pInput($i(pInput))="p=<-1750,-2698,1145>, v=<-246,-382,167>, a=<17,25,-11>"
 set pInput($i(pInput))="p=<3258,1100,-180>, v=<470,158,-26>, a=<-32,-13,0>"
 set pInput($i(pInput))="p=<-1915,-679,-2235>, v=<-273,-97,-323>, a=<21,9,24>"
 set pInput($i(pInput))="p=<-1104,-2081,-786>, v=<-155,-297,-113>, a=<11,22,10>"
 set pInput($i(pInput))="p=<-2858,-640,-706>, v=<-406,-90,-100>, a=<29,5,4>"
 set pInput($i(pInput))="p=<712,1716,-1986>, v=<102,248,-284>, a=<-7,-17,19>"
 set pInput($i(pInput))="p=<832,2700,-390>, v=<120,385,-55>, a=<-5,-26,3>"
 set pInput($i(pInput))="p=<1587,-619,2627>, v=<223,-84,375>, a=<-17,4,-28>"
 set pInput($i(pInput))="p=<2298,470,2118>, v=<325,62,302>, a=<-16,-8,-19>"
 set pInput($i(pInput))="p=<-2057,-1407,-2233>, v=<-288,-204,-317>, a=<25,14,26>"
 set pInput($i(pInput))="p=<-112,-62,2758>, v=<-13,-5,397>, a=<1,-2,-23>"
 set pInput($i(pInput))="p=<-211,-2054,2162>, v=<-32,-291,309>, a=<6,20,-24>"
 set pInput($i(pInput))="p=<2083,836,1594>, v=<299,118,228>, a=<-18,-8,-17>"
 set pInput($i(pInput))="p=<-530,2090,1973>, v=<-76,302,278>, a=<4,-26,-24>"
 set pInput($i(pInput))="p=<-1080,1942,-1900>, v=<-158,279,-272>, a=<6,-19,19>"
 set pInput($i(pInput))="p=<-2074,1278,1789>, v=<-301,186,250>, a=<14,-11,-18>"
 set pInput($i(pInput))="p=<-520,2504,414>, v=<-74,354,60>, a=<-2,-25,-7>"
 set pInput($i(pInput))="p=<-1176,-2282,-1591>, v=<-170,-326,-228>, a=<16,15,15>"
 set pInput($i(pInput))="p=<102,2968,990>, v=<12,427,146>, a=<-7,-32,-10>"
 set pInput($i(pInput))="p=<-2709,1659,-316>, v=<-389,241,-39>, a=<31,-9,1>"
 set pInput($i(pInput))="p=<-2290,1919,773>, v=<-329,275,105>, a=<22,-16,-12>"
 set pInput($i(pInput))="p=<615,482,3245>, v=<85,69,463>, a=<-10,0,-27>"
 set pInput($i(pInput))="p=<1234,2456,-1243>, v=<178,346,-177>, a=<-9,-21,9>"
 set pInput($i(pInput))="p=<1114,1679,1730>, v=<164,240,248>, a=<-12,-15,-17>"
 set pInput($i(pInput))="p=<-1422,1522,-1711>, v=<-208,209,-244>, a=<9,-15,21>"
 set pInput($i(pInput))="p=<2007,-1374,485>, v=<285,-201,69>, a=<-22,17,-4>"
 set pInput($i(pInput))="p=<-12,2520,544>, v=<-1,362,74>, a=<0,-26,-10>"
 set pInput($i(pInput))="p=<-474,-1923,2315>, v=<-67,-270,334>, a=<2,18,-21>"
 set pInput($i(pInput))="p=<1517,-2248,-418>, v=<216,-314,-59>, a=<-14,22,3>"
 set pInput($i(pInput))="p=<1118,2532,-1334>, v=<159,361,-189>, a=<-12,-25,13>"
 set pInput($i(pInput))="p=<-1489,-1372,-2353>, v=<-219,-200,-337>, a=<15,18,21>"
 set pInput($i(pInput))="p=<1056,25,-2775>, v=<149,1,-398>, a=<-17,0,27>"
 set pInput($i(pInput))="p=<-2726,1082,-1224>, v=<-389,153,-169>, a=<27,-7,12>"
 set pInput($i(pInput))="p=<751,608,-2592>, v=<102,88,-374>, a=<-6,-7,24>"
 set pInput($i(pInput))="p=<1945,2317,-136>, v=<276,331,-18>, a=<-23,-24,4>"
 set pInput($i(pInput))="p=<-3253,69,-228>, v=<-462,11,-36>, a=<36,0,-1>"
 set pInput($i(pInput))="p=<1255,-2938,-313>, v=<183,-419,-45>, a=<-8,26,7>"
 set pInput($i(pInput))="p=<-2646,2011,-797>, v=<-380,287,-109>, a=<25,-21,2>"
 set pInput($i(pInput))="p=<50,-1406,-2557>, v=<5,-198,-362>, a=<6,15,24>"
 set pInput($i(pInput))="p=<348,-1005,2940>, v=<51,-140,420>, a=<-2,7,-29>"
 set pInput($i(pInput))="p=<-672,2846,-1419>, v=<-97,402,-207>, a=<6,-28,11>"
 set pInput($i(pInput))="p=<2859,1440,-24>, v=<408,201,-9>, a=<-27,-21,2>"
 set pInput($i(pInput))="p=<2157,-1843,429>, v=<313,-263,61>, a=<-22,19,-4>"
 set pInput($i(pInput))="p=<45,-1064,2940>, v=<6,-158,419>, a=<1,12,-29>"
 set pInput($i(pInput))="p=<1730,987,-1830>, v=<247,143,-264>, a=<-19,-7,17>"
 set pInput($i(pInput))="p=<-1122,-1149,2253>, v=<-165,-161,322>, a=<12,11,-25>"
 set pInput($i(pInput))="p=<2676,-601,-785>, v=<380,-86,-115>, a=<-30,5,8>"
 set pInput($i(pInput))="p=<2435,-555,-1288>, v=<348,-80,-183>, a=<-24,6,12>"
 set pInput($i(pInput))="p=<1305,-81,2894>, v=<185,-10,413>, a=<-13,-4,-30>"
 set pInput($i(pInput))="p=<954,-2008,1396>, v=<140,-292,199>, a=<-9,25,-10>"
 set pInput($i(pInput))="p=<-133,2590,984>, v=<-19,374,140>, a=<0,-23,-10>"
 set pInput($i(pInput))="p=<1389,-2086,-2054>, v=<194,-296,-293>, a=<-16,18,19>"
 set pInput($i(pInput))="p=<-296,-2831,566>, v=<-37,-404,82>, a=<-2,24,1>"
 set pInput($i(pInput))="p=<-2569,-802,-1287>, v=<-369,-113,-183>, a=<28,10,10>"
 set pInput($i(pInput))="p=<-1886,1812,-2154>, v=<-266,255,-307>, a=<15,-17,26>"
 set pInput($i(pInput))="p=<-1719,-1231,1420>, v=<-244,-174,204>, a=<20,14,-18>"
 set pInput($i(pInput))="p=<-2888,-1394,1274>, v=<-412,-202,183>, a=<28,13,-14>"
 set pInput($i(pInput))="p=<1984,1660,1284>, v=<287,237,179>, a=<-19,-18,-16>"
 set pInput($i(pInput))="p=<-41,200,2573>, v=<-4,31,370>, a=<-1,-2,-25>"
 set pInput($i(pInput))="p=<-3016,34,-1363>, v=<-429,1,-190>, a=<31,-5,13>"
 set pInput($i(pInput))="p=<-1286,-763,2011>, v=<-183,-107,287>, a=<11,1,-21>"
 set pInput($i(pInput))="p=<-1848,1908,-618>, v=<-265,274,-87>, a=<19,-22,11>"
 set pInput($i(pInput))="p=<-688,2384,-207>, v=<-98,336,-29>, a=<7,-22,0>"
 set pInput($i(pInput))="p=<281,847,-2885>, v=<40,121,-412>, a=<-1,-11,25>"
 set pInput($i(pInput))="p=<192,-2453,-1601>, v=<31,-355,-222>, a=<-1,24,17>"
 set pInput($i(pInput))="p=<491,2203,2548>, v=<68,315,367>, a=<-5,-21,-28>"
 set pInput($i(pInput))="p=<-2321,-624,-555>, v=<-336,-90,-81>, a=<23,6,-1>"
 set pInput($i(pInput))="p=<-432,-3152,-213>, v=<-63,-450,-31>, a=<-2,31,1>"
 set pInput($i(pInput))="p=<-1867,1915,-782>, v=<-266,270,-110>, a=<22,-19,7>"
 set pInput($i(pInput))="p=<-892,-2127,-2359>, v=<-122,-311,-337>, a=<5,25,26>"
 set pInput($i(pInput))="p=<-941,2518,-1279>, v=<-140,360,-182>, a=<10,-25,11>"
 set pInput($i(pInput))="p=<1469,340,-3429>, v=<209,48,-490>, a=<-13,0,38>"
 set pInput($i(pInput))="p=<673,3163,673>, v=<101,451,95>, a=<-8,-34,-1>"
 set pInput($i(pInput))="p=<800,1337,2614>, v=<114,193,371>, a=<-2,-15,-24>"
 set pInput($i(pInput))="p=<1261,1722,-2285>, v=<179,249,-326>, a=<-14,-19,19>"
 set pInput($i(pInput))="p=<1473,-2386,-1740>, v=<210,-340,-248>, a=<-13,21,17>"
 set pInput($i(pInput))="p=<1905,2345,936>, v=<269,330,128>, a=<-21,-27,-8>"
 set pInput($i(pInput))="p=<-9,-2986,506>, v=<2,-426,74>, a=<0,29,-4>"
 set pInput($i(pInput))="p=<1104,2001,1666>, v=<158,286,238>, a=<-11,-20,-14>"
 set pInput($i(pInput))="p=<-497,-2214,2033>, v=<-66,-314,293>, a=<5,22,-13>"
 set pInput($i(pInput))="p=<209,-2513,-1928>, v=<29,-361,-273>, a=<-3,23,23>"
 set pInput($i(pInput))="p=<3148,-137,-45>, v=<452,-16,-6>, a=<-34,1,1>"
 set pInput($i(pInput))="p=<-738,-382,3098>, v=<-105,-51,440>, a=<8,2,-30>"
 set pInput($i(pInput))="p=<1401,2701,793>, v=<200,387,112>, a=<-11,-26,-11>"
 set pInput($i(pInput))="p=<-2116,-937,-1839>, v=<-303,-136,-266>, a=<19,9,20>"
 set pInput($i(pInput))="p=<686,-763,-3088>, v=<104,-117,-443>, a=<-6,10,27>"
 set pInput($i(pInput))="p=<-1078,-2695,1808>, v=<-150,-381,252>, a=<7,28,-22>"
 set pInput($i(pInput))="p=<-1664,-680,2702>, v=<-238,-102,384>, a=<19,8,-26>"
 set pInput($i(pInput))="p=<-2971,-700,1101>, v=<-431,-98,157>, a=<25,6,-11>"
 set pInput($i(pInput))="p=<-403,-2013,-1424>, v=<-57,-286,-197>, a=<-1,18,14>"
 set pInput($i(pInput))="p=<-248,-2160,-1597>, v=<-35,-308,-228>, a=<3,22,15>"
 set pInput($i(pInput))="p=<-1239,983,-1956>, v=<-175,136,-272>, a=<12,-11,20>"
 set pInput($i(pInput))="p=<1358,2352,2015>, v=<192,333,283>, a=<-8,-18,-14>"
 set pInput($i(pInput))="p=<-513,-2703,-1005>, v=<-72,-384,-140>, a=<3,26,14>"
 set pInput($i(pInput))="p=<1677,2614,-393>, v=<239,372,-55>, a=<-15,-26,2>"
 set pInput($i(pInput))="p=<568,-2323,1735>, v=<77,-333,241>, a=<-4,20,-10>"
 set pInput($i(pInput))="p=<2487,1279,-308>, v=<353,188,-42>, a=<-24,-12,9>"
 set pInput($i(pInput))="p=<1009,316,2729>, v=<136,46,389>, a=<-7,-7,-26>"
 set pInput($i(pInput))="p=<2442,-775,2407>, v=<345,-111,344>, a=<-25,7,-21>"
 set pInput($i(pInput))="p=<-936,2174,2023>, v=<-134,305,289>, a=<12,-18,-18>"
 set pInput($i(pInput))="p=<-731,-714,-2746>, v=<-104,-100,-390>, a=<0,5,30>"
 set pInput($i(pInput))="p=<422,-3337,-414>, v=<63,-477,-61>, a=<-4,31,4>"
 set pInput($i(pInput))="p=<1873,1735,-1252>, v=<270,244,-174>, a=<-22,-15,15>"
 set pInput($i(pInput))="p=<-2135,-1673,-1094>, v=<-306,-239,-155>, a=<21,18,13>"
 set pInput($i(pInput))="p=<-327,-2234,1998>, v=<-44,-322,283>, a=<1,22,-22>"
 set pInput($i(pInput))="p=<1599,722,1794>, v=<228,102,260>, a=<-16,-7,-17>"
 set pInput($i(pInput))="p=<749,-3446,-111>, v=<114,-490,-13>, a=<-9,35,1>"

	for i=1:1:pInput {
		set tTemp=pInput(i)
		set tArray(i,"p")=$p($p(tTemp,"p=<",2),">",1)
		set tArray(i,"p","x")=$p(tArray(i,"p"),",",1)
		set tArray(i,"p","y")=$p(tArray(i,"p"),",",2)
		set tArray(i,"p","z")=$p(tArray(i,"p"),",",3)
		set tArray(i,"v")=$p($p(tTemp,"v=<",2),">",1)
		set tArray(i,"v","x")=$p(tArray(i,"v"),",",1)
		set tArray(i,"v","y")=$p(tArray(i,"v"),",",2)
		set tArray(i,"v","z")=$p(tArray(i,"v"),",",3)
		set tArray(i,"a")=$p($p(tTemp,"a=<",2),">",1)
		set tArray(i,"a","x")=$p(tArray(i,"a"),",",1)
		set tArray(i,"a","y")=$p(tArray(i,"a"),",",2)
		set tArray(i,"a","z")=$p(tArray(i,"a"),",",3)
	}
	
	for i=1:1:50000 {
		w:i#10000=0 i,!
		for j=1:1:1000 {
			set tArray(j,"v","x")=tArray(j,"v","x")+tArray(j,"a","x")
			set tArray(j,"v","y")=tArray(j,"v","y")+tArray(j,"a","y")
			set tArray(j,"v","z")=tArray(j,"v","z")+tArray(j,"a","z")
			set tArray(j,"p","x")=tArray(j,"p","x")+tArray(j,"v","x")
			set tArray(j,"p","y")=tArray(j,"p","y")+tArray(j,"v","y")
			set tArray(j,"p","z")=tArray(j,"p","z")+tArray(j,"v","z")
		}
	}
	
	zw tArray
	
	set tMin=99999999999999999999999
	set tMinNum=0
	for i=1:1:1000 {
		set tTemp=$zabs(tArray(i,"p","x"))+$zabs(tArray(i,"p","y"))+$zabs(tArray(i,"p","z"))
		if tMin>tTemp {
			set tMin=tTemp
			set tMinNum=i-1
		}
	}
	quit tMinNum
}

ClassMethod Day20P2(pInput) As %String
{
	 set pInput($i(pInput))="p=<1199,-2918,1457>, v=<-13,115,-8>, a=<-7,8,-10>"
 set pInput($i(pInput))="p=<2551,2418,-1471>, v=<-106,-108,39>, a=<-6,-5,6>"
 set pInput($i(pInput))="p=<-73,1626,1321>, v=<58,-118,-8>, a=<-6,2,-9>"
 set pInput($i(pInput))="p=<-3297,-894,-551>, v=<183,31,-61>, a=<3,3,11>"
 set pInput($i(pInput))="p=<-1425,4298,617>, v=<32,-166,-32>, a=<7,-12,-1>"
 set pInput($i(pInput))="p=<-3718,877,1043>, v=<114,7,-20>, a=<10,-6,-4>"
 set pInput($i(pInput))="p=<-2089,-239,1142>, v=<52,12,3>, a=<7,0,-7>"
 set pInput($i(pInput))="p=<782,994,3311>, v=<16,-28,-32>, a=<-6,-3,-16>"
 set pInput($i(pInput))="p=<-937,2596,-109>, v=<-12,-117,-13>, a=<7,-3,2>"
 set pInput($i(pInput))="p=<-865,-2930,-1387>, v=<60,76,-56>, a=<-1,9,14>"
 set pInput($i(pInput))="p=<1196,-3308,2564>, v=<-26,59,0>, a=<-4,13,-15>"
 set pInput($i(pInput))="p=<-271,1957,-2944>, v=<8,-15,40>, a=<1,-10,13>"
 set pInput($i(pInput))="p=<-964,1228,1583>, v=<18,16,-12>, a=<4,-9,-8>"
 set pInput($i(pInput))="p=<-1639,1174,1970>, v=<84,-114,-138>, a=<1,5,3>"
 set pInput($i(pInput))="p=<-1840,1679,-1764>, v=<44,-20,91>, a=<8,-10,2>"
 set pInput($i(pInput))="p=<1104,-233,140>, v=<-21,-11,-28>, a=<-6,3,2>"
 set pInput($i(pInput))="p=<1136,-361,-3100>, v=<-40,14,98>, a=<-4,1,11>"
 set pInput($i(pInput))="p=<1480,-265,-1412>, v=<-36,42,18>, a=<-7,-3,8>"
 set pInput($i(pInput))="p=<144,-1217,-660>, v=<39,25,56>, a=<-6,6,-2>"
 set pInput($i(pInput))="p=<360,295,276>, v=<-51,-95,-11>, a=<3,9,-1>"
 set pInput($i(pInput))="p=<-2656,487,1228>, v=<78,12,-11>, a=<10,-5,-8>"
 set pInput($i(pInput))="p=<-1400,2295,-204>, v=<-9,-67,53>, a=<11,-9,-5>"
 set pInput($i(pInput))="p=<-1016,-769,-52>, v=<1,14,120>, a=<7,4,-14>"
 set pInput($i(pInput))="p=<1536,4167,-940>, v=<-99,-201,82>, a=<0,-7,-3>"
 set pInput($i(pInput))="p=<2398,3917,2412>, v=<-69,-51,-81>, a=<-3,-10,-2>"
 set pInput($i(pInput))="p=<-3283,536,733>, v=<46,72,-32>, a=<8,-8,0>"
 set pInput($i(pInput))="p=<-247,1180,-2901>, v=<46,-52,-18>, a=<-3,0,12>"
 set pInput($i(pInput))="p=<-2984,-499,-1475>, v=<-3,57,-8>, a=<11,-3,6>"
 set pInput($i(pInput))="p=<-431,2008,-3890>, v=<54,-40,49>, a=<-3,-4,10>"
 set pInput($i(pInput))="p=<2904,-775,-3614>, v=<5,-3,97>, a=<-11,3,5>"
 set pInput($i(pInput))="p=<2697,-1074,3401>, v=<38,70,-28>, a=<-13,-2,-10>"
 set pInput($i(pInput))="p=<-1259,1456,595>, v=<42,8,34>, a=<1,-6,-5>"
 set pInput($i(pInput))="p=<-1293,5020,-2110>, v=<-12,-199,93>, a=<7,-5,1>"
 set pInput($i(pInput))="p=<-1753,-1520,-320>, v=<-10,44,14>, a=<9,3,0>"
 set pInput($i(pInput))="p=<-2143,1040,-2220>, v=<83,-42,109>, a=<2,-1,0>"
 set pInput($i(pInput))="p=<-203,3210,-530>, v=<-56,-98,35>, a=<6,-6,-1>"
 set pInput($i(pInput))="p=<3017,-3820,290>, v=<-154,96,-6>, a=<0,9,-1>"
 set pInput($i(pInput))="p=<-1195,-180,-289>, v=<93,-30,-2>, a=<1,6,4>"
 set pInput($i(pInput))="p=<371,1368,953>, v=<-18,-16,-125>, a=<-2,-16,7>"
 set pInput($i(pInput))="p=<-1777,-426,-523>, v=<187,-16,24>, a=<-6,7,3>"
 set pInput($i(pInput))="p=<-2635,690,-1177>, v=<148,-83,59>, a=<11,3,6>"
 set pInput($i(pInput))="p=<431,-366,-1333>, v=<-62,18,124>, a=<4,1,-2>"
 set pInput($i(pInput))="p=<-2311,-750,143>, v=<147,11,-51>, a=<7,7,6>"
 set pInput($i(pInput))="p=<-151,354,-85>, v=<97,-29,-84>, a=<-13,-1,14>"
 set pInput($i(pInput))="p=<-325,-1602,779>, v=<-25,56,-13>, a=<8,11,-8>"
 set pInput($i(pInput))="p=<-385,-204,467>, v=<-7,37,0>, a=<6,-4,-6>"
 set pInput($i(pInput))="p=<665,-1272,-1195>, v=<-10,35,80>, a=<-7,10,3>"
 set pInput($i(pInput))="p=<-2525,7592,-6216>, v=<43,-14,0>, a=<1,-9,8>"
 set pInput($i(pInput))="p=<-68,4433,8721>, v=<-120,-113,-63>, a=<6,0,-8>"
 set pInput($i(pInput))="p=<-6971,-91,-561>, v=<-43,3,15>, a=<11,0,0>"
 set pInput($i(pInput))="p=<-2876,806,-8478>, v=<72,-60,58>, a=<0,2,8>"
 set pInput($i(pInput))="p=<-7907,4004,258>, v=<61,-42,-46>, a=<7,-3,2>"
 set pInput($i(pInput))="p=<-4358,6773,5523>, v=<50,-73,39>, a=<3,-5,-9>"
 set pInput($i(pInput))="p=<1941,1823,224>, v=<-102,-73,-54>, a=<1,-1,4>"
 set pInput($i(pInput))="p=<-1440,-1768,224>, v=<70,87,67>, a=<0,0,-7>"
 set pInput($i(pInput))="p=<-1776,3125,2870>, v=<20,-58,-4>, a=<6,-8,-12>"
 set pInput($i(pInput))="p=<1437,-697,-5635>, v=<-12,25,115>, a=<-5,1,14>"
 set pInput($i(pInput))="p=<-3603,-151,2366>, v=<30,-89,31>, a=<13,9,-13>"
 set pInput($i(pInput))="p=<-264,4805,3857>, v=<3,-105,-40>, a=<1,-11,-13>"
 set pInput($i(pInput))="p=<-831,-823,140>, v=<52,-35,5>, a=<-1,7,-1>"
 set pInput($i(pInput))="p=<2970,-634,1085>, v=<-52,110,-18>, a=<-8,-7,-3>"
 set pInput($i(pInput))="p=<1755,-4503,-1198>, v=<-18,102,8>, a=<-4,6,3>"
 set pInput($i(pInput))="p=<-4945,572,1727>, v=<42,-101,-5>, a=<12,6,-5>"
 set pInput($i(pInput))="p=<-70,5047,-2023>, v=<3,45,54>, a=<0,-19,2>"
 set pInput($i(pInput))="p=<-2845,4372,-2598>, v=<75,-110,116>, a=<3,-5,-1>"
 set pInput($i(pInput))="p=<-345,-228,-1898>, v=<-38,61,88>, a=<4,-4,-1>"
 set pInput($i(pInput))="p=<-2720,3622,1727>, v=<109,-2,-83>, a=<0,-11,1>"
 set pInput($i(pInput))="p=<-4045,-3228,-2448>, v=<-7,116,-7>, a=<13,1,8>"
 set pInput($i(pInput))="p=<580,3347,802>, v=<-10,48,19>, a=<-1,-14,-4>"
 set pInput($i(pInput))="p=<-1910,2875,1236>, v=<71,-54,88>, a=<-1,-1,-6>"
 set pInput($i(pInput))="p=<-2963,-6485,2406>, v=<-102,86,-42>, a=<9,4,-1>"
 set pInput($i(pInput))="p=<-18875,7633,-7890>, v=<86,-76,82>, a=<20,-6,6>"
 set pInput($i(pInput))="p=<391,9505,4980>, v=<-8,76,-108>, a=<0,-16,-1>"
 set pInput($i(pInput))="p=<-935,5800,-1533>, v=<-114,-129,59>, a=<7,-1,-1>"
 set pInput($i(pInput))="p=<-272,-7733,12858>, v=<69,18,10>, a=<-3,9,-17>"
 set pInput($i(pInput))="p=<-7292,613,12741>, v=<49,-116,-47>, a=<7,5,-14>"
 set pInput($i(pInput))="p=<3550,-518,-15339>, v=<51,33,73>, a=<-7,-1,16>"
 set pInput($i(pInput))="p=<4213,-8123,-2157>, v=<14,88,55>, a=<-6,6,0>"
 set pInput($i(pInput))="p=<-7721,418,-17250>, v=<80,69,2>, a=<6,-4,22>"
 set pInput($i(pInput))="p=<1738,-2831,-158>, v=<40,35,8>, a=<-12,10,0>"
 set pInput($i(pInput))="p=<2598,399,782>, v=<-66,10,45>, a=<-6,-3,-8>"
 set pInput($i(pInput))="p=<3068,129,-1558>, v=<-58,13,57>, a=<-9,-2,2>"
 set pInput($i(pInput))="p=<-1782,4139,-3628>, v=<-99,-93,171>, a=<18,-11,1>"
 set pInput($i(pInput))="p=<-1082,-3161,-498>, v=<55,83,67>, a=<0,7,-4>"
 set pInput($i(pInput))="p=<-5302,-1291,772>, v=<98,42,-70>, a=<16,2,3>"
 set pInput($i(pInput))="p=<808,979,232>, v=<-50,2,-1>, a=<1,-5,-1>"
 set pInput($i(pInput))="p=<-152,1479,-8>, v=<-86,61,11>, a=<9,-13,-1>"
 set pInput($i(pInput))="p=<1292,1700,-858>, v=<-72,-94,96>, a=<-4,-5,-4>"
 set pInput($i(pInput))="p=<304,-640,-455>, v=<53,-12,72>, a=<-11,9,-5>"
 set pInput($i(pInput))="p=<486,1063,-689>, v=<-52,-66,27>, a=<2,-2,4>"
 set pInput($i(pInput))="p=<993,-1823,182>, v=<-84,30,-47>, a=<1,16,5>"
 set pInput($i(pInput))="p=<-1230,-1615,-312>, v=<52,182,96>, a=<6,-8,-10>"
 set pInput($i(pInput))="p=<-268,1297,728>, v=<20,-105,-40>, a=<0,1,-2>"
 set pInput($i(pInput))="p=<1476,1697,875>, v=<5,-87,-71>, a=<-15,-5,1>"
 set pInput($i(pInput))="p=<1476,1193,-1813>, v=<-85,-51,46>, a=<-3,-5,11>"
 set pInput($i(pInput))="p=<932,-6376,-4019>, v=<-47,24,-82>, a=<1,12,14>"
 set pInput($i(pInput))="p=<-12763,29,8401>, v=<177,-19,-62>, a=<16,1,-14>"
 set pInput($i(pInput))="p=<5087,6059,1936>, v=<-139,-65,76>, a=<-2,-9,-9>"
 set pInput($i(pInput))="p=<-853,-721,-4889>, v=<28,6,40>, a=<0,1,8>"
 set pInput($i(pInput))="p=<-1288,329,-11219>, v=<58,33,96>, a=<-1,-3,18>"
 set pInput($i(pInput))="p=<1352,-286,4051>, v=<-61,38,-10>, a=<1,-2,-8>"
 set pInput($i(pInput))="p=<2477,-271,-4649>, v=<41,-40,32>, a=<-8,3,8>"
 set pInput($i(pInput))="p=<-1783,-376,-6944>, v=<59,41,155>, a=<0,-2,5>"
 set pInput($i(pInput))="p=<-8728,2204,-1514>, v=<27,48,-26>, a=<17,-8,5>"
 set pInput($i(pInput))="p=<2987,-7276,-1829>, v=<-100,54,-31>, a=<0,12,6>"
 set pInput($i(pInput))="p=<-86,2277,1643>, v=<48,-108,-103>, a=<-4,0,2>"
 set pInput($i(pInput))="p=<-1640,-726,3722>, v=<45,24,-48>, a=<3,1,-12>"
 set pInput($i(pInput))="p=<334,-4947,761>, v=<-82,71,-28>, a=<6,15,-1>"
 set pInput($i(pInput))="p=<2686,1290,572>, v=<-106,16,-41>, a=<-2,-7,1>"
 set pInput($i(pInput))="p=<1153,3663,152>, v=<-110,35,45>, a=<5,-19,-5>"
 set pInput($i(pInput))="p=<-3257,-957,-2620>, v=<45,35,-32>, a=<10,1,14>"
 set pInput($i(pInput))="p=<-4958,4524,-2179>, v=<16,-127,13>, a=<20,-8,8>"
 set pInput($i(pInput))="p=<-1913,2844,-898>, v=<47,-135,40>, a=<4,0,0>"
 set pInput($i(pInput))="p=<-3826,-5200,5502>, v=<-27,-24,31>, a=<8,10,-11>"
 set pInput($i(pInput))="p=<50,-7529,4380>, v=<34,27,-6>, a=<-2,11,-7>"
 set pInput($i(pInput))="p=<-362,3,273>, v=<20,20,-5>, a=<3,-4,-4>"
 set pInput($i(pInput))="p=<-927,-577,-887>, v=<82,89,56>, a=<2,-6,6>"
 set pInput($i(pInput))="p=<-942,-727,1133>, v=<78,-6,-102>, a=<3,14,-2>"
 set pInput($i(pInput))="p=<-92,-817,-222>, v=<-73,80,17>, a=<15,0,1>"
 set pInput($i(pInput))="p=<-1062,-87,-642>, v=<68,7,59>, a=<7,0,1>"
 set pInput($i(pInput))="p=<-532,-1332,-537>, v=<4,27,65>, a=<9,19,-2>"
 set pInput($i(pInput))="p=<8,888,968>, v=<-17,-19,-58>, a=<3,-13,-7>"
 set pInput($i(pInput))="p=<-1188,-1222,249>, v=<-13,12,39>, a=<5,3,-4>"
 set pInput($i(pInput))="p=<-672,-814,1713>, v=<28,45,3>, a=<0,-1,-6>"
 set pInput($i(pInput))="p=<612,-4354,3273>, v=<87,30,-87>, a=<-9,12,-4>"
 set pInput($i(pInput))="p=<3048,-2098,-3435>, v=<-27,86,80>, a=<-8,0,5>"
 set pInput($i(pInput))="p=<2556,3434,1137>, v=<31,-32,2>, a=<-11,-9,-4>"
 set pInput($i(pInput))="p=<-372,710,-1851>, v=<-47,-31,-61>, a=<5,0,11>"
 set pInput($i(pInput))="p=<-648,-2698,705>, v=<2,136,20>, a=<2,-2,-4>"
 set pInput($i(pInput))="p=<564,146,-2007>, v=<-36,-70,108>, a=<1,5,-2>"
 set pInput($i(pInput))="p=<2040,662,-6411>, v=<-85,-29,129>, a=<0,0,11>"
 set pInput($i(pInput))="p=<-5642,-1168,-495>, v=<101,-74,-40>, a=<7,8,4>"
 set pInput($i(pInput))="p=<-3724,-3058,-1279>, v=<-11,-21,-41>, a=<10,9,6>"
 set pInput($i(pInput))="p=<-1540,-5046,-2875>, v=<56,79,74>, a=<0,7,2>"
 set pInput($i(pInput))="p=<336,-3506,345>, v=<47,82,17>, a=<-4,3,-2>"
 set pInput($i(pInput))="p=<5432,3088,2375>, v=<39,-52,-99>, a=<-16,-4,1>"
 set pInput($i(pInput))="p=<1792,1716,-2749>, v=<-63,55,26>, a=<0,-8,5>"
 set pInput($i(pInput))="p=<-1274,316,723>, v=<148,76,-40>, a=<-7,-6,1>"
 set pInput($i(pInput))="p=<924,-104,4223>, v=<-32,4,-49>, a=<0,0,-7>"
 set pInput($i(pInput))="p=<1484,-832,107>, v=<-168,30,-18>, a=<8,0,1>"
 set pInput($i(pInput))="p=<-8594,3021,4906>, v=<21,28,4>, a=<14,-7,-9>"
 set pInput($i(pInput))="p=<10084,-1137,-5786>, v=<-86,35,90>, a=<-13,0,5>"
 set pInput($i(pInput))="p=<-5030,5628,-2420>, v=<-2,-170,73>, a=<9,0,0>"
 set pInput($i(pInput))="p=<-2324,-2952,220>, v=<1,124,44>, a=<4,-2,-3>"
 set pInput($i(pInput))="p=<2857,2757,55>, v=<-3,2,-36>, a=<-5,-5,2>"
 set pInput($i(pInput))="p=<3319,-2523,2497>, v=<-34,26,26>, a=<-4,3,-6>"
 set pInput($i(pInput))="p=<5256,903,-1020>, v=<76,11,65>, a=<-12,-2,-2>"
 set pInput($i(pInput))="p=<8028,5151,-1038>, v=<-1,-33,84>, a=<-12,-6,-3>"
 set pInput($i(pInput))="p=<3690,-4065,1266>, v=<-47,75,57>, a=<-3,2,-5>"
 set pInput($i(pInput))="p=<6606,5403,7026>, v=<-17,-40,-66>, a=<-9,-6,-7>"
 set pInput($i(pInput))="p=<-1638,1383,1338>, v=<11,-86,-51>, a=<14,-2,-6>"
 set pInput($i(pInput))="p=<896,1026,-622>, v=<-5,-98,-1>, a=<-8,3,6>"
 set pInput($i(pInput))="p=<763,1425,309>, v=<-78,-134,0>, a=<3,4,-3>"
 set pInput($i(pInput))="p=<1001,-619,113>, v=<55,72,44>, a=<-17,-4,-7>"
 set pInput($i(pInput))="p=<1191,109,1991>, v=<-116,-48,-8>, a=<5,3,-4>"
 set pInput($i(pInput))="p=<3453,-1718,-5230>, v=<136,60,46>, a=<-17,0,9>"
 set pInput($i(pInput))="p=<-2666,-2646,-4621>, v=<32,47,40>, a=<4,3,8>"
 set pInput($i(pInput))="p=<1436,-2829,1966>, v=<-51,-16,-45>, a=<-2,15,-5>"
 set pInput($i(pInput))="p=<696,2161,-2404>, v=<-35,-108,100>, a=<0,0,2>"
 set pInput($i(pInput))="p=<2486,2401,-1224>, v=<-9,48,20>, a=<-11,-16,4>"
 set pInput($i(pInput))="p=<3046,261,1116>, v=<-37,71,-139>, a=<-11,-8,8>"
 set pInput($i(pInput))="p=<-104,2751,2326>, v=<-121,-85,-42>, a=<12,-5,-7>"
 set pInput($i(pInput))="p=<-1044,-249,496>, v=<73,-19,-45>, a=<-2,3,2>"
 set pInput($i(pInput))="p=<556,-289,1826>, v=<-28,-59,67>, a=<0,7,-15>"
 set pInput($i(pInput))="p=<-274,1131,-44>, v=<-18,-46,45>, a=<3,-1,-4>"
 set pInput($i(pInput))="p=<2266,1141,-504>, v=<-19,-78,26>, a=<-9,2,0>"
 set pInput($i(pInput))="p=<-891,-129,1722>, v=<-121,92,-73>, a=<15,-8,-1>"
 set pInput($i(pInput))="p=<243,-2439,3276>, v=<23,70,-158>, a=<-3,4,0>"
 set pInput($i(pInput))="p=<-72,-339,399>, v=<-17,3,-10>, a=<2,1,-1>"
 set pInput($i(pInput))="p=<1461,-759,2205>, v=<-57,-109,-30>, a=<-1,13,-7>"
 set pInput($i(pInput))="p=<-597,-1536,882>, v=<30,-39,-33>, a=<0,10,-1>"
 set pInput($i(pInput))="p=<2469,-1683,1533>, v=<49,-10,-152>, a=<-15,8,7>"
 set pInput($i(pInput))="p=<957,3441,1428>, v=<-143,-1,106>, a=<9,-15,-16>"
 set pInput($i(pInput))="p=<-2487,-927,-5271>, v=<32,-35,194>, a=<8,7,5>"
 set pInput($i(pInput))="p=<915,585,1701>, v=<-97,-8,-83>, a=<5,-2,0>"
 set pInput($i(pInput))="p=<-1975,2665,-1727>, v=<138,-30,49>, a=<-4,-9,3>"
 set pInput($i(pInput))="p=<-2122,-23,-2945>, v=<24,76,74>, a=<7,-7,6>"
 set pInput($i(pInput))="p=<150,1353,672>, v=<36,-115,-12>, a=<-5,4,-3>"
 set pInput($i(pInput))="p=<2139,-1299,1437>, v=<-144,-4,-93>, a=<2,9,1>"
 set pInput($i(pInput))="p=<-955,3036,298>, v=<74,-79,-8>, a=<-2,-11,-1>"
 set pInput($i(pInput))="p=<2156,-1418,-1640>, v=<-46,84,34>, a=<-9,0,7>"
 set pInput($i(pInput))="p=<-938,-1418,808>, v=<82,66,25>, a=<-3,2,-8>"
 set pInput($i(pInput))="p=<-2179,-109,-382>, v=<146,25,-31>, a=<-2,-2,6>"
 set pInput($i(pInput))="p=<2139,1727,-280>, v=<-63,-74,-46>, a=<-7,-3,7>"
 set pInput($i(pInput))="p=<-1006,622,-59>, v=<77,-54,-5>, a=<-2,2,1>"
 set pInput($i(pInput))="p=<235,894,349>, v=<-113,-79,43>, a=<11,3,-7>"
 set pInput($i(pInput))="p=<2258,452,1624>, v=<-88,37,-32>, a=<-5,-7,-7>"
 set pInput($i(pInput))="p=<6485,8607,10076>, v=<-46,61,-99>, a=<-6,-14,-8>"
 set pInput($i(pInput))="p=<15533,4551,638>, v=<-78,-55,-57>, a=<-16,-3,2>"
 set pInput($i(pInput))="p=<128,6540,4148>, v=<-3,114,-67>, a=<0,-14,-2>"
 set pInput($i(pInput))="p=<11555,3186,2081>, v=<-116,0,-114>, a=<-9,-4,3>"
 set pInput($i(pInput))="p=<9371,-3015,-6031>, v=<20,79,54>, a=<-13,0,5>"
 set pInput($i(pInput))="p=<-12586,339,-7786>, v=<3,-7,59>, a=<16,0,7>"
 set pInput($i(pInput))="p=<-2056,-7383,-4705>, v=<-67,11,0>, a=<6,9,6>"
 set pInput($i(pInput))="p=<1025,2796,-13480>, v=<-126,-70,-15>, a=<5,0,18>"
 set pInput($i(pInput))="p=<-11416,-1962,-766>, v=<-47,12,39>, a=<17,2,-1>"
 set pInput($i(pInput))="p=<1103,-558,3212>, v=<-88,-24,-83>, a=<3,2,0>"
 set pInput($i(pInput))="p=<-56,-3584,3008>, v=<78,86,-151>, a=<-6,5,2>"
 set pInput($i(pInput))="p=<1072,-5108,-1720>, v=<-44,112,71>, a=<0,8,0>"
 set pInput($i(pInput))="p=<-1256,1936,-1384>, v=<28,-69,57>, a=<2,-1,0>"
 set pInput($i(pInput))="p=<1996,-992,1472>, v=<-120,-22,-12>, a=<3,5,-4>"
 set pInput($i(pInput))="p=<3376,1324,908>, v=<-140,-31,-101>, a=<0,-2,5>"
 set pInput($i(pInput))="p=<3604,412,6920>, v=<-62,-43,-189>, a=<-7,2,-8>"
 set pInput($i(pInput))="p=<-176,4384,2204>, v=<-17,-21,-80>, a=<2,-13,-1>"
 set pInput($i(pInput))="p=<-992,-1196,-3616>, v=<42,49,50>, a=<0,0,8>"
 set pInput($i(pInput))="p=<-353,-1549,-1122>, v=<-72,-82,26>, a=<6,10,1>"
 set pInput($i(pInput))="p=<727,-3169,-2337>, v=<0,6,-97>, a=<-2,8,13>"
 set pInput($i(pInput))="p=<-1973,-1387,-3282>, v=<44,-60,92>, a=<2,8,2>"
 set pInput($i(pInput))="p=<1159,-118,2712>, v=<96,75,-46>, a=<-10,-5,-4>"
 set pInput($i(pInput))="p=<-974,260,-2553>, v=<-105,-51,37>, a=<10,3,4>"
 set pInput($i(pInput))="p=<1645,2069,2388>, v=<50,22,-20>, a=<-8,-7,-5>"
 set pInput($i(pInput))="p=<1726,2420,-3930>, v=<-79,-19,46>, a=<1,-5,7>"
 set pInput($i(pInput))="p=<1564,4364,1740>, v=<53,-91,-38>, a=<-8,-5,-2>"
 set pInput($i(pInput))="p=<6496,8583,-2797>, v=<-129,-57,50>, a=<-4,-12,2>"
 set pInput($i(pInput))="p=<919,-6234,4727>, v=<74,188,9>, a=<-6,0,-9>"
 set pInput($i(pInput))="p=<2272,-2736,7796>, v=<-1,-3,-67>, a=<-4,5,-10>"
 set pInput($i(pInput))="p=<-9674,-558,9809>, v=<72,-52,-26>, a=<13,4,-16>"
 set pInput($i(pInput))="p=<8542,3765,-124>, v=<-55,89,20>, a=<-12,-12,-1>"
 set pInput($i(pInput))="p=<1909,3138,1790>, v=<-41,74,-21>, a=<-1,-10,-2>"
 set pInput($i(pInput))="p=<-1419,1399,-3011>, v=<42,-26,-27>, a=<0,-1,7>"
 set pInput($i(pInput))="p=<1716,-4244,5569>, v=<-53,-178,-32>, a=<0,18,-8>"
 set pInput($i(pInput))="p=<6270,211,-10931>, v=<-38,78,60>, a=<-9,-5,16>"
 set pInput($i(pInput))="p=<-5181,-3452,-338>, v=<71,36,62>, a=<5,4,-3>"
 set pInput($i(pInput))="p=<-6105,-8402,-5915>, v=<31,-1,27>, a=<9,15,9>"
 set pInput($i(pInput))="p=<-1848,310,-1097>, v=<4,92,17>, a=<3,-6,1>"
 set pInput($i(pInput))="p=<2803,-1755,-532>, v=<-71,13,2>, a=<-5,6,2>"
 set pInput($i(pInput))="p=<691,2348,-785>, v=<48,-24,71>, a=<-7,-7,-3>"
 set pInput($i(pInput))="p=<-233,4779,-994>, v=<-48,-31,0>, a=<5,-16,4>"
 set pInput($i(pInput))="p=<119,-4021,238>, v=<-41,93,-10>, a=<3,8,0>"
 set pInput($i(pInput))="p=<-1168,-3647,-3392>, v=<52,76,132>, a=<0,8,2>"
 set pInput($i(pInput))="p=<-1845,-443,-822>, v=<-24,-30,1>, a=<11,5,4>"
 set pInput($i(pInput))="p=<2315,1487,4428>, v=<-64,-53,-83>, a=<-5,-2,-13>"
 set pInput($i(pInput))="p=<3255,-2683,-772>, v=<-132,82,-12>, a=<-3,5,5>"
 set pInput($i(pInput))="p=<-1405,487,108>, v=<-25,-45,70>, a=<9,2,-7>"
 set pInput($i(pInput))="p=<-2315,1877,-1142>, v=<73,1,38>, a=<4,-9,2>"
 set pInput($i(pInput))="p=<-1975,-2143,-3372>, v=<-28,13,13>, a=<12,9,15>"
 set pInput($i(pInput))="p=<1945,3157,2138>, v=<28,-147,21>, a=<-12,-1,-12>"
 set pInput($i(pInput))="p=<-3555,977,708>, v=<114,-59,-2>, a=<6,1,-3>"
 set pInput($i(pInput))="p=<5865,5127,-4422>, v=<-105,-67,118>, a=<-18,-18,10>"
 set pInput($i(pInput))="p=<-3264,2343,-3273>, v=<79,-72,127>, a=<11,-6,6>"
 set pInput($i(pInput))="p=<3387,-2301,1992>, v=<-53,129,15>, a=<-14,0,-13>"
 set pInput($i(pInput))="p=<2295,5276,1762>, v=<-104,-67,-57>, a=<0,-15,-2>"
 set pInput($i(pInput))="p=<-2072,-774,1036>, v=<37,-22,68>, a=<5,5,-10>"
 set pInput($i(pInput))="p=<447,865,1300>, v=<-20,-39,-36>, a=<0,0,-2>"
 set pInput($i(pInput))="p=<-1467,-1852,2323>, v=<90,50,-117>, a=<-2,3,1>"
 set pInput($i(pInput))="p=<4473,-664,-1241>, v=<-157,-4,45>, a=<-4,3,1>"
 set pInput($i(pInput))="p=<1580,-1621,-2572>, v=<32,5,48>, a=<-9,6,6>"
 set pInput($i(pInput))="p=<9680,-3138,-4267>, v=<-41,22,-84>, a=<-14,4,12>"
 set pInput($i(pInput))="p=<-4107,4648,2023>, v=<32,3,-59>, a=<5,-8,0>"
 set pInput($i(pInput))="p=<-673,1860,7004>, v=<36,-55,-48>, a=<-1,0,-9>"
 set pInput($i(pInput))="p=<8337,7453,2516>, v=<-159,-132,84>, a=<-5,-5,-9>"
 set pInput($i(pInput))="p=<2276,-3123,-1445>, v=<-62,44,37>, a=<-6,12,4>"
 set pInput($i(pInput))="p=<-1885,-64,1576>, v=<27,33,-12>, a=<7,-3,-7>"
 set pInput($i(pInput))="p=<-7265,156,268>, v=<89,-23,-25>, a=<6,1,1>"
 set pInput($i(pInput))="p=<-9137,3036,826>, v=<104,8,-133>, a=<8,-5,6>"
 set pInput($i(pInput))="p=<-6167,-1770,-4592>, v=<77,86,73>, a=<5,-2,3>"
 set pInput($i(pInput))="p=<-1685,-2976,2824>, v=<45,27,-22>, a=<0,3,-3>"
 set pInput($i(pInput))="p=<5821,-870,5740>, v=<3,-13,-29>, a=<-9,2,-7>"
 set pInput($i(pInput))="p=<331,1596,232>, v=<-11,-100,-135>, a=<0,3,7>"
 set pInput($i(pInput))="p=<-1230,1100,-8455>, v=<87,-67,165>, a=<-3,2,6>"
 set pInput($i(pInput))="p=<-1470,5772,3641>, v=<-21,-81,18>, a=<4,-6,-8>"
 set pInput($i(pInput))="p=<7026,-2852,1913>, v=<-6,106,6>, a=<-13,-1,-4>"
 set pInput($i(pInput))="p=<-5422,5132,-5575>, v=<-13,-160,42>, a=<11,0,8>"
 set pInput($i(pInput))="p=<3792,1660,-43>, v=<-175,-121,15>, a=<-9,1,-2>"
 set pInput($i(pInput))="p=<42,-620,-778>, v=<3,39,24>, a=<0,0,3>"
 set pInput($i(pInput))="p=<-318,-1370,1697>, v=<11,137,-85>, a=<2,-6,-4>"
 set pInput($i(pInput))="p=<1842,130,-613>, v=<-69,-11,-19>, a=<-6,0,7>"
 set pInput($i(pInput))="p=<-963,3070,-2218>, v=<30,-151,144>, a=<5,-7,0>"
 set pInput($i(pInput))="p=<2847,-2795,1532>, v=<-112,80,-74>, a=<-9,13,-4>"
 set pInput($i(pInput))="p=<747,-875,197>, v=<12,56,-17>, a=<-7,0,0>"
 set pInput($i(pInput))="p=<627,-80,1022>, v=<-36,27,-128>, a=<0,-3,7>"
 set pInput($i(pInput))="p=<2667,655,1427>, v=<-108,-14,-91>, a=<-8,-4,-1>"
 set pInput($i(pInput))="p=<1002,-215,962>, v=<35,-28,-108>, a=<-12,5,5>"
 set pInput($i(pInput))="p=<-849,-4500,291>, v=<-67,65,22>, a=<6,5,-2>"
 set pInput($i(pInput))="p=<6405,4180,5499>, v=<-125,9,-18>, a=<-5,-9,-10>"
 set pInput($i(pInput))="p=<4576,-4128,1562>, v=<-66,53,-3>, a=<-5,5,-3>"
 set pInput($i(pInput))="p=<391,4738,-2189>, v=<37,-89,70>, a=<-3,-4,0>"
 set pInput($i(pInput))="p=<-1004,863,12>, v=<82,-108,15>, a=<-3,5,-1>"
 set pInput($i(pInput))="p=<1352,1514,-4390>, v=<-10,-49,13>, a=<-2,0,8>"
 set pInput($i(pInput))="p=<360,-4748,-81>, v=<-26,73,50>, a=<1,5,-3>"
 set pInput($i(pInput))="p=<-7297,2320,-6157>, v=<-3,-75,22>, a=<15,0,11>"
 set pInput($i(pInput))="p=<918,-780,229>, v=<68,-55,-8>, a=<-6,5,0>"
 set pInput($i(pInput))="p=<422,-7135,5871>, v=<-12,86,-62>, a=<0,9,-8>"
 set pInput($i(pInput))="p=<2921,-2245,1495>, v=<-93,55,-15>, a=<0,1,-2>"
 set pInput($i(pInput))="p=<1417,-4757,1367>, v=<-79,84,22>, a=<2,4,-4>"
 set pInput($i(pInput))="p=<2137,-4133,-5545>, v=<-118,-117,40>, a=<3,15,8>"
 set pInput($i(pInput))="p=<2761,-3685,-2329>, v=<-121,67,-44>, a=<2,3,7>"
 set pInput($i(pInput))="p=<3145,3851,3831>, v=<-199,-53,-22>, a=<6,-4,-6>"
 set pInput($i(pInput))="p=<-807,-1909,-8809>, v=<40,-71,10>, a=<-1,8,16>"
 set pInput($i(pInput))="p=<-3001,-1007,-4300>, v=<-11,2,69>, a=<11,3,9>"
 set pInput($i(pInput))="p=<2291,3961,-2416>, v=<-19,-30,28>, a=<-6,-11,6>"
 set pInput($i(pInput))="p=<1571,-3143,-2428>, v=<-14,66,41>, a=<-4,5,5>"
 set pInput($i(pInput))="p=<683,3001,6056>, v=<73,-90,-200>, a=<-8,-3,-4>"
 set pInput($i(pInput))="p=<-205,-759,517>, v=<108,44,50>, a=<-8,-1,-6>"
 set pInput($i(pInput))="p=<-642,1863,3622>, v=<31,-58,23>, a=<0,-2,-15>"
 set pInput($i(pInput))="p=<-1562,1449,-4405>, v=<83,8,-12>, a=<-1,-6,17>"
 set pInput($i(pInput))="p=<853,-1242,3668>, v=<14,-67,-51>, a=<-4,10,-9>"
 set pInput($i(pInput))="p=<-757,46,-6061>, v=<0,-15,156>, a=<3,1,9>"
 set pInput($i(pInput))="p=<-3287,-1403,-564>, v=<38,0,-35>, a=<9,5,5>"
 set pInput($i(pInput))="p=<-849,1840,3001>, v=<124,-33,-106>, a=<-7,-4,-2>"
 set pInput($i(pInput))="p=<1566,2806,-1162>, v=<43,-39,15>, a=<-9,-7,3>"
 set pInput($i(pInput))="p=<5706,3174,-5141>, v=<-77,-67,44>, a=<-14,-6,15>"
 set pInput($i(pInput))="p=<-1444,-4807,1648>, v=<-55,150,-100>, a=<6,0,3>"
 set pInput($i(pInput))="p=<-2596,2137,-7664>, v=<-19,-67,92>, a=<6,0,9>"
 set pInput($i(pInput))="p=<-4324,1577,-5456>, v=<35,0,23>, a=<6,-3,9>"
 set pInput($i(pInput))="p=<-1428,2121,1568>, v=<-39,82,-48>, a=<5,-9,0>"
 set pInput($i(pInput))="p=<-4884,-7063,-1168>, v=<36,-27,-12>, a=<7,15,3>"
 set pInput($i(pInput))="p=<-2612,-2871,2352>, v=<-35,-26,43>, a=<7,7,-7>"
 set pInput($i(pInput))="p=<2492,7737,4832>, v=<-13,22,-51>, a=<-4,-16,-6>"
 set pInput($i(pInput))="p=<3228,-2455,880>, v=<-102,-39,-10>, a=<0,7,-1>"
 set pInput($i(pInput))="p=<620,-4183,0>, v=<29,15,1>, a=<-3,7,0>"
 set pInput($i(pInput))="p=<1549,1698,2535>, v=<-94,-85,-179>, a=<-2,-5,0>"
 set pInput($i(pInput))="p=<-1643,1068,-202>, v=<29,-25,-66>, a=<12,-7,11>"
 set pInput($i(pInput))="p=<-229,697,-1756>, v=<48,-51,30>, a=<-4,0,13>"
 set pInput($i(pInput))="p=<1724,39,1219>, v=<-129,-49,-85>, a=<1,6,0>"
 set pInput($i(pInput))="p=<361,2678,211>, v=<21,-76,46>, a=<-6,-15,-8>"
 set pInput($i(pInput))="p=<291,410,3284>, v=<-19,-19,-166>, a=<0,-1,-9>"
 set pInput($i(pInput))="p=<-1711,-2642,-1098>, v=<79,109,72>, a=<6,11,1>"
 set pInput($i(pInput))="p=<-12485,-3505,-8183>, v=<17,14,59>, a=<16,4,8>"
 set pInput($i(pInput))="p=<2449,-351,-4877>, v=<92,9,-28>, a=<-8,0,8>"
 set pInput($i(pInput))="p=<-2377,1435,1241>, v=<63,40,-72>, a=<0,-4,2>"
 set pInput($i(pInput))="p=<397,7496,462>, v=<146,-22,46>, a=<-8,-9,-3>"
 set pInput($i(pInput))="p=<4672,-180,1621>, v=<-25,-15,-121>, a=<-5,1,4>"
 set pInput($i(pInput))="p=<-667,2442,1165>, v=<57,-45,-31>, a=<-2,-1,0>"
 set pInput($i(pInput))="p=<-97,-7210,6523>, v=<-75,53,-55>, a=<4,7,-6>"
 set pInput($i(pInput))="p=<-5911,-5329,-5941>, v=<0,62,39>, a=<8,4,6>"
 set pInput($i(pInput))="p=<-5132,4133,1583>, v=<38,-31,-42>, a=<5,-4,0>"
 set pInput($i(pInput))="p=<-797,-449,1945>, v=<68,51,-76>, a=<-2,-3,-7>"
 set pInput($i(pInput))="p=<2203,496,-620>, v=<-28,-20,55>, a=<-15,-2,-2>"
 set pInput($i(pInput))="p=<-512,286,-725>, v=<17,-14,46>, a=<2,-1,0>"
 set pInput($i(pInput))="p=<-317,2701,2845>, v=<92,-135,-88>, a=<-9,-6,-13>"
 set pInput($i(pInput))="p=<2488,-839,10>, v=<-95,13,-19>, a=<-9,5,2>"
 set pInput($i(pInput))="p=<-32,-584,-1805>, v=<1,68,54>, a=<0,-4,8>"
 set pInput($i(pInput))="p=<-1487,841,25>, v=<106,-59,12>, a=<-1,0,-2>"
 set pInput($i(pInput))="p=<9711,3803,1142>, v=<-7,36,3>, a=<-15,-8,-2>"
 set pInput($i(pInput))="p=<3306,-1797,722>, v=<-4,34,-183>, a=<-5,1,9>"
 set pInput($i(pInput))="p=<2050,-1523,1668>, v=<-33,42,148>, a=<-3,1,-15>"
 set pInput($i(pInput))="p=<2914,-227,-2544>, v=<-9,8,66>, a=<-7,0,2>"
 set pInput($i(pInput))="p=<4507,-227,-1977>, v=<-152,22,-25>, a=<-1,-1,7>"
 set pInput($i(pInput))="p=<5452,448,777>, v=<-75,-87,-43>, a=<-9,5,1>"
 set pInput($i(pInput))="p=<-1217,-3197,-2922>, v=<18,76,-102>, a=<2,3,15>"
 set pInput($i(pInput))="p=<-1703,-2738,-6>, v=<-6,-39,0>, a=<5,10,0>"
 set pInput($i(pInput))="p=<-29,-6410,453>, v=<16,83,-73>, a=<-1,11,4>"
 set pInput($i(pInput))="p=<1591,313,-5028>, v=<40,16,102>, a=<-7,-2,6>"
 set pInput($i(pInput))="p=<1753,-4823,2921>, v=<-46,-88,-58>, a=<0,11,-1>"
 set pInput($i(pInput))="p=<3672,-6932,2617>, v=<79,26,-89>, a=<-9,8,1>"
 set pInput($i(pInput))="p=<-1534,8477,2883>, v=<-135,30,21>, a=<9,-13,-5>"
 set pInput($i(pInput))="p=<-3187,5532,7994>, v=<45,-29,23>, a=<2,-6,-12>"
 set pInput($i(pInput))="p=<5249,-776,-2988>, v=<-21,59,-39>, a=<-6,-2,6>"
 set pInput($i(pInput))="p=<-774,-339,-7244>, v=<1,106,112>, a=<1,-5,4>"
 set pInput($i(pInput))="p=<-2104,-17268,1420>, v=<-3,64,118>, a=<3,20,-8>"
 set pInput($i(pInput))="p=<-1306,4335,-24>, v=<15,22,0>, a=<1,-7,0>"
 set pInput($i(pInput))="p=<-972,2893,110>, v=<-133,420,13>, a=<7,-27,1>"
 set pInput($i(pInput))="p=<1906,-490,2091>, v=<271,-62,298>, a=<-18,9,-21>"
 set pInput($i(pInput))="p=<-1422,-2788,323>, v=<-200,-398,44>, a=<14,27,-3>"
 set pInput($i(pInput))="p=<1079,-21,-2677>, v=<156,-2,-384>, a=<-9,-1,22>"
 set pInput($i(pInput))="p=<-513,1027,-2732>, v=<-71,147,-392>, a=<5,-13,29>"
 set pInput($i(pInput))="p=<472,-76,-2799>, v=<67,-14,-399>, a=<-6,5,28>"
 set pInput($i(pInput))="p=<-478,1841,2426>, v=<-69,269,351>, a=<5,-20,-26>"
 set pInput($i(pInput))="p=<2254,1465,-1528>, v=<324,211,-218>, a=<-19,-13,17>"
 set pInput($i(pInput))="p=<-277,1286,2981>, v=<-39,181,423>, a=<-1,-8,-24>"
 set pInput($i(pInput))="p=<71,2026,2683>, v=<5,285,383>, a=<-3,-20,-25>"
 set pInput($i(pInput))="p=<-581,-2942,-73>, v=<-79,-423,-11>, a=<4,33,-4>"
 set pInput($i(pInput))="p=<65,2932,137>, v=<7,418,19>, a=<-1,-29,-1>"
 set pInput($i(pInput))="p=<-401,582,-3050>, v=<-59,88,-434>, a=<1,-4,30>"
 set pInput($i(pInput))="p=<2976,-590,-108>, v=<421,-80,-12>, a=<-26,2,4>"
 set pInput($i(pInput))="p=<-2303,-645,-1751>, v=<-329,-91,-251>, a=<21,6,14>"
 set pInput($i(pInput))="p=<1140,-2857,662>, v=<164,-410,91>, a=<-11,27,-10>"
 set pInput($i(pInput))="p=<-2532,-643,1350>, v=<-363,-84,191>, a=<29,4,-20>"
 set pInput($i(pInput))="p=<1816,1234,-2316>, v=<261,177,-329>, a=<-18,-12,23>"
 set pInput($i(pInput))="p=<499,-2878,-236>, v=<71,-410,-38>, a=<-2,25,6>"
 set pInput($i(pInput))="p=<2553,-1482,-988>, v=<361,-214,-139>, a=<-24,14,9>"
 set pInput($i(pInput))="p=<-2086,-2102,-211>, v=<-300,-301,-31>, a=<12,23,-2>"
 set pInput($i(pInput))="p=<-256,-1962,-2187>, v=<-38,-280,-313>, a=<1,19,20>"
 set pInput($i(pInput))="p=<-1353,-1829,1849>, v=<-197,-264,260>, a=<15,19,-18>"
 set pInput($i(pInput))="p=<2427,-1169,1408>, v=<345,-170,206>, a=<-30,5,-17>"
 set pInput($i(pInput))="p=<-681,372,-3521>, v=<-98,58,-512>, a=<12,-3,39>"
 set pInput($i(pInput))="p=<-525,-322,-2723>, v=<-71,-46,-387>, a=<9,-2,33>"
 set pInput($i(pInput))="p=<-1485,2370,-939>, v=<-212,340,-138>, a=<19,-18,11>"
 set pInput($i(pInput))="p=<2629,23,1333>, v=<375,2,191>, a=<-24,-1,-13>"
 set pInput($i(pInput))="p=<-962,2687,-565>, v=<-140,383,-78>, a=<8,-20,5>"
 set pInput($i(pInput))="p=<990,3391,-1021>, v=<144,480,-152>, a=<-9,-32,8>"
 set pInput($i(pInput))="p=<-1608,2476,39>, v=<-229,351,3>, a=<17,-24,0>"
 set pInput($i(pInput))="p=<2455,44,-1459>, v=<350,3,-209>, a=<-26,0,19>"
 set pInput($i(pInput))="p=<3240,154,-210>, v=<457,20,-33>, a=<-31,1,6>"
 set pInput($i(pInput))="p=<-2171,-88,-1778>, v=<-309,-8,-254>, a=<19,0,15>"
 set pInput($i(pInput))="p=<-2277,-926,-1445>, v=<-325,-131,-207>, a=<24,5,11>"
 set pInput($i(pInput))="p=<-589,-1148,2928>, v=<-80,-170,418>, a=<9,12,-29>"
 set pInput($i(pInput))="p=<-2241,-1063,1406>, v=<-316,-152,197>, a=<24,16,-19>"
 set pInput($i(pInput))="p=<2092,-955,950>, v=<298,-136,132>, a=<-24,8,-7>"
 set pInput($i(pInput))="p=<-466,-2201,-1279>, v=<-62,-310,-180>, a=<-1,23,12>"
 set pInput($i(pInput))="p=<-468,-2983,-1861>, v=<-66,-425,-260>, a=<8,28,23>"
 set pInput($i(pInput))="p=<-1070,-2706,-272>, v=<-149,-388,-38>, a=<8,27,0>"
 set pInput($i(pInput))="p=<-2009,-1830,1787>, v=<-291,-264,248>, a=<20,22,-17>"
 set pInput($i(pInput))="p=<2822,-85,659>, v=<403,-14,89>, a=<-33,0,-10>"
 set pInput($i(pInput))="p=<-2363,-1805,-611>, v=<-337,-257,-89>, a=<24,16,12>"
 set pInput($i(pInput))="p=<-2598,2035,-674>, v=<-373,287,-95>, a=<28,-22,8>"
 set pInput($i(pInput))="p=<1173,2573,243>, v=<164,367,40>, a=<-14,-23,1>"
 set pInput($i(pInput))="p=<-836,3312,206>, v=<-118,475,29>, a=<8,-34,-2>"
 set pInput($i(pInput))="p=<1688,-381,2533>, v=<236,-57,357>, a=<-15,3,-25>"
 set pInput($i(pInput))="p=<143,1759,-2463>, v=<22,249,-355>, a=<0,-14,27>"
 set pInput($i(pInput))="p=<-2683,2007,980>, v=<-389,283,140>, a=<25,-23,-12>"
 set pInput($i(pInput))="p=<-670,-1250,-2411>, v=<-97,-178,-347>, a=<6,15,24>"
 set pInput($i(pInput))="p=<-1136,2357,985>, v=<-164,334,139>, a=<16,-27,-11>"
 set pInput($i(pInput))="p=<2096,-1737,638>, v=<298,-251,86>, a=<-20,22,-6>"
 set pInput($i(pInput))="p=<-2631,-271,1623>, v=<-375,-37,230>, a=<29,1,-18>"
 set pInput($i(pInput))="p=<2424,1243,1437>, v=<348,177,200>, a=<-26,-10,-19>"
 set pInput($i(pInput))="p=<2060,1385,938>, v=<294,197,134>, a=<-25,-14,-15>"
 set pInput($i(pInput))="p=<1331,2651,-818>, v=<193,381,-116>, a=<-13,-30,9>"
 set pInput($i(pInput))="p=<776,1916,1714>, v=<112,274,249>, a=<-5,-18,-17>"
 set pInput($i(pInput))="p=<-811,427,-2299>, v=<-117,63,-328>, a=<6,0,27>"
 set pInput($i(pInput))="p=<1354,2492,-186>, v=<191,355,-27>, a=<-16,-24,2>"
 set pInput($i(pInput))="p=<474,3023,-673>, v=<69,434,-92>, a=<-4,-25,10>"
 set pInput($i(pInput))="p=<1520,-2352,670>, v=<215,-334,94>, a=<-16,19,-7>"
 set pInput($i(pInput))="p=<-1149,-2556,-1447>, v=<-166,-360,-206>, a=<11,23,13>"
 set pInput($i(pInput))="p=<-37,2330,1867>, v=<-5,328,265>, a=<-2,-22,-14>"
 set pInput($i(pInput))="p=<-2861,-590,507>, v=<-413,-82,70>, a=<27,1,-2>"
 set pInput($i(pInput))="p=<3202,-250,647>, v=<462,-35,92>, a=<-24,2,-6>"
 set pInput($i(pInput))="p=<-2286,-833,-1219>, v=<-326,-122,-173>, a=<22,4,15>"
 set pInput($i(pInput))="p=<-2215,-1793,861>, v=<-321,-252,125>, a=<18,22,-4>"
 set pInput($i(pInput))="p=<-156,1321,2884>, v=<-21,191,413>, a=<1,-11,-30>"
 set pInput($i(pInput))="p=<-804,2418,-838>, v=<-114,340,-125>, a=<8,-26,6>"
 set pInput($i(pInput))="p=<-1121,-1781,-1869>, v=<-157,-256,-265>, a=<12,19,17>"
 set pInput($i(pInput))="p=<-1529,565,-2482>, v=<-217,86,-354>, a=<15,-5,29>"
 set pInput($i(pInput))="p=<87,1773,2467>, v=<17,253,356>, a=<0,-12,-24>"
 set pInput($i(pInput))="p=<-1370,2134,2591>, v=<-195,304,367>, a=<14,-20,-25>"
 set pInput($i(pInput))="p=<-14,2076,1747>, v=<-4,294,249>, a=<4,-12,-17>"
 set pInput($i(pInput))="p=<1935,-1618,1382>, v=<281,-226,197>, a=<-18,19,-13>"
 set pInput($i(pInput))="p=<-2297,1551,77>, v=<-331,223,10>, a=<16,-13,-2>"
 set pInput($i(pInput))="p=<-1952,-1430,82>, v=<-276,-199,12>, a=<14,13,0>"
 set pInput($i(pInput))="p=<-1987,-1518,-1457>, v=<-280,-216,-208>, a=<14,15,17>"
 set pInput($i(pInput))="p=<-1359,-1392,2060>, v=<-196,-199,295>, a=<12,15,-26>"
 set pInput($i(pInput))="p=<691,-2517,1578>, v=<98,-359,224>, a=<-9,26,-15>"
 set pInput($i(pInput))="p=<2671,965,580>, v=<381,131,81>, a=<-31,-14,-7>"
 set pInput($i(pInput))="p=<-243,614,2906>, v=<-31,84,421>, a=<3,-6,-30>"
 set pInput($i(pInput))="p=<-1052,646,3333>, v=<-149,95,476>, a=<12,-3,-37>"
 set pInput($i(pInput))="p=<510,1846,2487>, v=<72,264,351>, a=<-9,-20,-24>"
 set pInput($i(pInput))="p=<-1990,-1380,1739>, v=<-282,-193,248>, a=<18,9,-15>"
 set pInput($i(pInput))="p=<133,-2661,-1829>, v=<18,-382,-264>, a=<1,28,18>"
 set pInput($i(pInput))="p=<815,2490,1020>, v=<122,351,144>, a=<-8,-20,-4>"
 set pInput($i(pInput))="p=<2465,-1704,-1056>, v=<348,-243,-150>, a=<-24,16,12>"
 set pInput($i(pInput))="p=<-711,-1825,2020>, v=<-107,-263,293>, a=<3,18,-20>"
 set pInput($i(pInput))="p=<2090,1861,-455>, v=<295,266,-65>, a=<-16,-18,8>"
 set pInput($i(pInput))="p=<-76,2995,-1382>, v=<-11,422,-196>, a=<2,-32,12>"
 set pInput($i(pInput))="p=<2104,-1799,1488>, v=<298,-260,207>, a=<-24,19,-13>"
 set pInput($i(pInput))="p=<63,2542,2053>, v=<10,365,295>, a=<0,-26,-15>"
 set pInput($i(pInput))="p=<1575,1481,-1420>, v=<224,211,-200>, a=<-11,-18,14>"
 set pInput($i(pInput))="p=<-2166,-345,-1387>, v=<-306,-49,-201>, a=<17,-1,10>"
 set pInput($i(pInput))="p=<-945,2623,29>, v=<-132,371,3>, a=<12,-23,-1>"
 set pInput($i(pInput))="p=<2590,878,-717>, v=<370,129,-102>, a=<-22,-15,9>"
 set pInput($i(pInput))="p=<2515,-1076,-679>, v=<357,-154,-101>, a=<-23,6,6>"
 set pInput($i(pInput))="p=<-1338,-2273,-1604>, v=<-186,-328,-231>, a=<14,22,18>"
 set pInput($i(pInput))="p=<-353,-2665,-1229>, v=<-46,-379,-172>, a=<3,24,12>"
 set pInput($i(pInput))="p=<-83,2448,-822>, v=<-13,353,-116>, a=<4,-23,8>"
 set pInput($i(pInput))="p=<-523,2472,1345>, v=<-73,355,192>, a=<8,-26,-15>"
 set pInput($i(pInput))="p=<-2443,1609,-1552>, v=<-349,231,-216>, a=<27,-17,22>"
 set pInput($i(pInput))="p=<1999,-1105,2090>, v=<285,-162,296>, a=<-17,10,-20>"
 set pInput($i(pInput))="p=<1954,2345,1492>, v=<277,339,213>, a=<-19,-23,-14>"
 set pInput($i(pInput))="p=<2221,-1016,1120>, v=<316,-141,158>, a=<-24,12,-10>"
 set pInput($i(pInput))="p=<-3168,-1304,44>, v=<-455,-186,10>, a=<27,16,1>"
 set pInput($i(pInput))="p=<1622,-980,-2335>, v=<231,-145,-337>, a=<-15,13,21>"
 set pInput($i(pInput))="p=<2185,209,2262>, v=<311,34,326>, a=<-27,2,-22>"
 set pInput($i(pInput))="p=<-2551,-307,1547>, v=<-364,-42,223>, a=<22,2,-16>"
 set pInput($i(pInput))="p=<-908,-1546,2694>, v=<-129,-219,384>, a=<11,12,-29>"
 set pInput($i(pInput))="p=<3364,248,363>, v=<481,35,47>, a=<-30,-4,3>"
 set pInput($i(pInput))="p=<-417,2230,1781>, v=<-60,320,254>, a=<5,-24,-15>"
 set pInput($i(pInput))="p=<-1902,-30,-1618>, v=<-265,-1,-228>, a=<20,0,13>"
 set pInput($i(pInput))="p=<-693,3041,-63>, v=<-100,434,-9>, a=<1,-29,-2>"
 set pInput($i(pInput))="p=<-1400,565,-2175>, v=<-200,80,-310>, a=<15,-6,17>"
 set pInput($i(pInput))="p=<-1416,-2376,-1590>, v=<-205,-341,-226>, a=<17,23,12>"
 set pInput($i(pInput))="p=<1484,-2148,1957>, v=<212,-311,279>, a=<-18,22,-16>"
 set pInput($i(pInput))="p=<573,2306,-702>, v=<84,331,-100>, a=<-8,-20,4>"
 set pInput($i(pInput))="p=<2271,1826,646>, v=<317,255,92>, a=<-21,-19,-6>"
 set pInput($i(pInput))="p=<-1405,1090,2686>, v=<-200,154,380>, a=<16,-7,-25>"
 set pInput($i(pInput))="p=<1115,-2148,-2264>, v=<161,-308,-323>, a=<-15,18,22>"
 set pInput($i(pInput))="p=<1491,2294,-1052>, v=<215,330,-149>, a=<-14,-22,8>"
 set pInput($i(pInput))="p=<2596,1010,885>, v=<374,145,124>, a=<-24,-8,-10>"
 set pInput($i(pInput))="p=<-1795,1860,-1144>, v=<-257,267,-164>, a=<24,-20,9>"
 set pInput($i(pInput))="p=<1277,687,-2336>, v=<184,94,-333>, a=<-7,-6,28>"
 set pInput($i(pInput))="p=<-347,1880,2125>, v=<-49,269,301>, a=<0,-18,-22>"
 set pInput($i(pInput))="p=<-18,-2622,-1537>, v=<-2,-370,-219>, a=<-2,29,19>"
 set pInput($i(pInput))="p=<-1855,-2054,1009>, v=<-264,-297,140>, a=<21,17,-14>"
 set pInput($i(pInput))="p=<-326,-2183,2149>, v=<-40,-311,306>, a=<0,18,-17>"
 set pInput($i(pInput))="p=<-980,-864,-2259>, v=<-141,-118,-318>, a=<14,10,17>"
 set pInput($i(pInput))="p=<-1809,905,-2722>, v=<-258,133,-391>, a=<17,-12,26>"
 set pInput($i(pInput))="p=<592,1196,-2413>, v=<88,171,-351>, a=<-1,-7,26>"
 set pInput($i(pInput))="p=<2073,1542,2188>, v=<300,220,318>, a=<-19,-15,-18>"
 set pInput($i(pInput))="p=<-557,-2458,1007>, v=<-79,-350,142>, a=<11,22,-12>"
 set pInput($i(pInput))="p=<-2392,2150,1346>, v=<-342,309,192>, a=<24,-23,-12>"
 set pInput($i(pInput))="p=<994,-2356,833>, v=<142,-338,119>, a=<-9,31,-3>"
 set pInput($i(pInput))="p=<299,2668,-290>, v=<46,382,-41>, a=<-5,-25,2>"
 set pInput($i(pInput))="p=<1626,-692,-2134>, v=<238,-101,-303>, a=<-14,6,19>"
 set pInput($i(pInput))="p=<1605,-1643,-682>, v=<228,-238,-98>, a=<-16,19,6>"
 set pInput($i(pInput))="p=<2925,-496,-312>, v=<419,-74,-44>, a=<-28,3,5>"
 set pInput($i(pInput))="p=<1803,-1874,1905>, v=<259,-265,271>, a=<-11,18,-19>"
 set pInput($i(pInput))="p=<-2236,415,-1699>, v=<-319,57,-246>, a=<22,-6,16>"
 set pInput($i(pInput))="p=<1843,-488,1798>, v=<259,-69,257>, a=<-26,5,-20>"
 set pInput($i(pInput))="p=<-2754,1655,331>, v=<-392,240,47>, a=<26,-16,-8>"
 set pInput($i(pInput))="p=<-834,251,-2722>, v=<-116,33,-386>, a=<3,-5,21>"
 set pInput($i(pInput))="p=<1021,-1266,3203>, v=<146,-185,456>, a=<-8,12,-36>"
 set pInput($i(pInput))="p=<-3008,-317,1005>, v=<-426,-45,145>, a=<27,1,-11>"
 set pInput($i(pInput))="p=<-2940,246,-187>, v=<-420,35,-22>, a=<34,-1,-1>"
 set pInput($i(pInput))="p=<1801,-1599,-1446>, v=<256,-221,-208>, a=<-15,12,14>"
 set pInput($i(pInput))="p=<-682,-3221,-349>, v=<-93,-456,-50>, a=<10,31,6>"
 set pInput($i(pInput))="p=<1654,207,-2009>, v=<238,33,-287>, a=<-20,-10,26>"
 set pInput($i(pInput))="p=<361,131,3200>, v=<51,15,455>, a=<-4,-1,-32>"
 set pInput($i(pInput))="p=<-633,-781,-2968>, v=<-91,-114,-422>, a=<5,6,29>"
 set pInput($i(pInput))="p=<-2215,-1455,1996>, v=<-315,-209,290>, a=<21,17,-15>"
 set pInput($i(pInput))="p=<-1296,-1166,2232>, v=<-185,-166,322>, a=<10,8,-22>"
 set pInput($i(pInput))="p=<-506,1002,-2804>, v=<-67,140,-401>, a=<7,-10,31>"
 set pInput($i(pInput))="p=<886,713,3210>, v=<125,97,458>, a=<-11,-11,-31>"
 set pInput($i(pInput))="p=<473,1814,2234>, v=<67,258,320>, a=<-6,-21,-19>"
 set pInput($i(pInput))="p=<-1602,1619,2001>, v=<-225,230,285>, a=<21,-16,-20>"
 set pInput($i(pInput))="p=<-742,-2555,288>, v=<-107,-365,42>, a=<7,26,-2>"
 set pInput($i(pInput))="p=<-3147,-1191,643>, v=<-445,-169,93>, a=<36,11,-8>"
 set pInput($i(pInput))="p=<1263,214,2752>, v=<180,30,395>, a=<-9,-2,-29>"
 set pInput($i(pInput))="p=<-2143,2199,1241>, v=<-310,308,175>, a=<23,-24,-8>"
 set pInput($i(pInput))="p=<-2553,928,-1224>, v=<-364,125,-172>, a=<25,-7,9>"
 set pInput($i(pInput))="p=<-2136,-2245,-1378>, v=<-307,-323,-195>, a=<24,23,13>"
 set pInput($i(pInput))="p=<889,-1593,2244>, v=<129,-222,323>, a=<-8,17,-23>"
 set pInput($i(pInput))="p=<-1520,-1646,1398>, v=<-223,-235,199>, a=<21,13,-11>"
 set pInput($i(pInput))="p=<2628,1000,-86>, v=<374,139,-16>, a=<-27,-16,1>"
 set pInput($i(pInput))="p=<-2376,-283,-2193>, v=<-336,-38,-314>, a=<29,7,24>"
 set pInput($i(pInput))="p=<1742,2026,408>, v=<247,292,55>, a=<-17,-23,1>"
 set pInput($i(pInput))="p=<-2191,-1544,-527>, v=<-312,-215,-75>, a=<20,15,7>"
 set pInput($i(pInput))="p=<-1704,-1827,1891>, v=<-241,-263,273>, a=<19,22,-18>"
 set pInput($i(pInput))="p=<-1270,-49,3352>, v=<-181,-13,478>, a=<12,2,-32>"
 set pInput($i(pInput))="p=<-2569,901,331>, v=<-369,129,47>, a=<26,-4,-4>"
 set pInput($i(pInput))="p=<1141,2256,1587>, v=<163,320,220>, a=<-13,-22,-18>"
 set pInput($i(pInput))="p=<1137,-2605,-1860>, v=<159,-373,-265>, a=<-10,24,14>"
 set pInput($i(pInput))="p=<-34,-1139,-2680>, v=<-3,-162,-383>, a=<0,10,26>"
 set pInput($i(pInput))="p=<2205,-1859,-418>, v=<318,-263,-57>, a=<-23,19,9>"
 set pInput($i(pInput))="p=<2263,-885,731>, v=<323,-127,101>, a=<-19,10,-7>"
 set pInput($i(pInput))="p=<747,-1743,-2548>, v=<107,-251,-360>, a=<-8,19,28>"
 set pInput($i(pInput))="p=<-2858,-1478,-787>, v=<-404,-214,-111>, a=<31,16,10>"
 set pInput($i(pInput))="p=<-2627,342,956>, v=<-375,45,136>, a=<26,-6,-12>"
 set pInput($i(pInput))="p=<-2234,2105,357>, v=<-319,303,51>, a=<19,-20,-4>"
 set pInput($i(pInput))="p=<1027,-2032,1325>, v=<153,-292,186>, a=<-7,20,-9>"
 set pInput($i(pInput))="p=<1283,-1286,2609>, v=<185,-183,373>, a=<-10,7,-23>"
 set pInput($i(pInput))="p=<1360,1947,2379>, v=<197,277,339>, a=<-17,-15,-23>"
 set pInput($i(pInput))="p=<-860,-679,2987>, v=<-122,-97,427>, a=<3,9,-24>"
 set pInput($i(pInput))="p=<-1647,2787,-244>, v=<-232,401,-37>, a=<17,-30,1>"
 set pInput($i(pInput))="p=<837,3170,1198>, v=<119,454,170>, a=<-4,-24,-11>"
 set pInput($i(pInput))="p=<1266,-1460,2161>, v=<179,-200,308>, a=<-14,10,-21>"
 set pInput($i(pInput))="p=<1648,1562,-2437>, v=<235,226,-350>, a=<-14,-12,24>"
 set pInput($i(pInput))="p=<-570,2209,-1513>, v=<-85,316,-215>, a=<1,-21,20>"
 set pInput($i(pInput))="p=<330,-2321,-199>, v=<47,-329,-28>, a=<-3,24,4>"
 set pInput($i(pInput))="p=<-2067,1180,1813>, v=<-299,169,263>, a=<20,-8,-15>"
 set pInput($i(pInput))="p=<-78,-2126,2288>, v=<-5,-307,321>, a=<-2,21,-25>"
 set pInput($i(pInput))="p=<-1626,281,1926>, v=<-232,40,277>, a=<23,3,-20>"
 set pInput($i(pInput))="p=<-235,3009,-77>, v=<-32,428,-16>, a=<1,-26,1>"
 set pInput($i(pInput))="p=<-345,3015,279>, v=<-52,430,42>, a=<0,-21,-1>"
 set pInput($i(pInput))="p=<2896,-2028,-978>, v=<416,-288,-138>, a=<-32,20,9>"
 set pInput($i(pInput))="p=<-3125,-612,759>, v=<-449,-87,108>, a=<31,5,-12>"
 set pInput($i(pInput))="p=<2888,2,384>, v=<414,0,57>, a=<-32,1,-6>"
 set pInput($i(pInput))="p=<-731,1698,2115>, v=<-106,244,305>, a=<7,-13,-21>"
 set pInput($i(pInput))="p=<2036,-736,-1453>, v=<294,-107,-208>, a=<-20,6,11>"
 set pInput($i(pInput))="p=<1652,-2222,234>, v=<236,-319,33>, a=<-18,15,-3>"
 set pInput($i(pInput))="p=<-515,-3243,235>, v=<-72,-462,30>, a=<3,33,1>"
 set pInput($i(pInput))="p=<7,-2446,2313>, v=<-3,-346,330>, a=<4,28,-21>"
 set pInput($i(pInput))="p=<1566,2106,1297>, v=<223,298,187>, a=<-13,-21,-15>"
 set pInput($i(pInput))="p=<2773,-241,-1939>, v=<393,-34,-277>, a=<-23,3,19>"
 set pInput($i(pInput))="p=<-1981,-951,1585>, v=<-286,-137,221>, a=<20,8,-18>"
 set pInput($i(pInput))="p=<-14,2752,627>, v=<-2,392,88>, a=<2,-21,-6>"
 set pInput($i(pInput))="p=<-2752,-498,2256>, v=<-393,-70,317>, a=<27,1,-23>"
 set pInput($i(pInput))="p=<-2795,-853,-603>, v=<-406,-121,-86>, a=<25,5,2>"
 set pInput($i(pInput))="p=<631,-2038,-1425>, v=<90,-293,-206>, a=<-4,20,12>"
 set pInput($i(pInput))="p=<125,2224,1993>, v=<18,316,291>, a=<4,-21,-25>"
 set pInput($i(pInput))="p=<-2231,489,-1563>, v=<-322,70,-224>, a=<23,-3,15>"
 set pInput($i(pInput))="p=<-2139,746,-1996>, v=<-302,109,-279>, a=<21,-5,18>"
 set pInput($i(pInput))="p=<992,-1201,-2833>, v=<145,-172,-408>, a=<-8,15,24>"
 set pInput($i(pInput))="p=<-1702,-2598,-45>, v=<-247,-371,-5>, a=<17,28,-2>"
 set pInput($i(pInput))="p=<-2590,-960,482>, v=<-369,-137,68>, a=<28,7,2>"
 set pInput($i(pInput))="p=<3216,-233,416>, v=<461,-31,61>, a=<-34,6,-4>"
 set pInput($i(pInput))="p=<-1121,692,2728>, v=<-162,101,391>, a=<13,-8,-27>"
 set pInput($i(pInput))="p=<-2671,-146,2193>, v=<-383,-24,313>, a=<22,-3,-22>"
 set pInput($i(pInput))="p=<763,-241,-3416>, v=<107,-32,-482>, a=<-9,-2,33>"
 set pInput($i(pInput))="p=<-671,-3065,126>, v=<-94,-437,16>, a=<13,31,-4>"
 set pInput($i(pInput))="p=<564,-2454,1713>, v=<75,-350,244>, a=<-5,24,-17>"
 set pInput($i(pInput))="p=<-1735,-2340,-460>, v=<-247,-334,-62>, a=<14,23,4>"
 set pInput($i(pInput))="p=<6,-2515,1136>, v=<0,-359,163>, a=<0,26,-10>"
 set pInput($i(pInput))="p=<2952,-18,724>, v=<424,1,103>, a=<-33,2,-9>"
 set pInput($i(pInput))="p=<-1425,729,2352>, v=<-206,107,337>, a=<17,-7,-23>"
 set pInput($i(pInput))="p=<-2551,-193,-2026>, v=<-365,-31,-289>, a=<25,3,17>"
 set pInput($i(pInput))="p=<1329,-2258,-1434>, v=<189,-322,-206>, a=<-18,18,14>"
 set pInput($i(pInput))="p=<1211,2337,-829>, v=<173,332,-120>, a=<-15,-20,8>"
 set pInput($i(pInput))="p=<-1528,-2029,2196>, v=<-218,-290,315>, a=<18,18,-19>"
 set pInput($i(pInput))="p=<2764,2067,855>, v=<391,290,119>, a=<-23,-16,-7>"
 set pInput($i(pInput))="p=<50,-2547,1000>, v=<8,-363,140>, a=<-1,27,-10>"
 set pInput($i(pInput))="p=<-1843,-740,-2538>, v=<-258,-105,-364>, a=<20,8,24>"
 set pInput($i(pInput))="p=<2901,-143,-287>, v=<416,-19,-40>, a=<-32,-3,3>"
 set pInput($i(pInput))="p=<-745,3115,-349>, v=<-111,448,-51>, a=<7,-34,-3>"
 set pInput($i(pInput))="p=<1591,264,-2030>, v=<222,37,-288>, a=<-16,-6,19>"
 set pInput($i(pInput))="p=<166,-48,3636>, v=<23,-10,516>, a=<-1,2,-30>"
 set pInput($i(pInput))="p=<319,1678,-2277>, v=<46,237,-320>, a=<0,-18,23>"
 set pInput($i(pInput))="p=<-2171,614,-1695>, v=<-310,87,-242>, a=<21,-4,11>"
 set pInput($i(pInput))="p=<-1126,665,-2761>, v=<-157,93,-392>, a=<14,-6,29>"
 set pInput($i(pInput))="p=<1741,2247,1663>, v=<246,324,234>, a=<-17,-16,-20>"
 set pInput($i(pInput))="p=<1650,-1865,-1148>, v=<236,-268,-164>, a=<-17,14,11>"
 set pInput($i(pInput))="p=<319,-1899,-1553>, v=<45,-274,-219>, a=<0,18,12>"
 set pInput($i(pInput))="p=<-319,321,-3639>, v=<-42,45,-518>, a=<5,0,31>"
 set pInput($i(pInput))="p=<-863,-2811,20>, v=<-123,-397,4>, a=<9,31,-2>"
 set pInput($i(pInput))="p=<2645,-31,542>, v=<373,-5,73>, a=<-23,1,-4>"
 set pInput($i(pInput))="p=<-228,-1990,2353>, v=<-35,-287,336>, a=<5,22,-21>"
 set pInput($i(pInput))="p=<3382,828,-998>, v=<482,123,-143>, a=<-35,-9,7>"
 set pInput($i(pInput))="p=<-681,-2015,-1438>, v=<-89,-285,-208>, a=<6,19,12>"
 set pInput($i(pInput))="p=<-2127,-1613,-1494>, v=<-308,-234,-212>, a=<19,16,11>"
 set pInput($i(pInput))="p=<65,2762,-1780>, v=<9,395,-254>, a=<2,-26,17>"
 set pInput($i(pInput))="p=<-798,-2143,754>, v=<-112,-311,104>, a=<12,25,-10>"
 set pInput($i(pInput))="p=<1936,1826,927>, v=<277,263,131>, a=<-15,-20,-10>"
 set pInput($i(pInput))="p=<-720,-1926,-1387>, v=<-103,-275,-198>, a=<8,16,11>"
 set pInput($i(pInput))="p=<-2584,-1286,524>, v=<-371,-180,74>, a=<28,15,-9>"
 set pInput($i(pInput))="p=<286,-3580,426>, v=<39,-510,60>, a=<0,34,-7>"
 set pInput($i(pInput))="p=<-1940,-1873,-414>, v=<-277,-269,-56>, a=<19,14,6>"
 set pInput($i(pInput))="p=<2631,-809,-1547>, v=<376,-116,-229>, a=<-30,10,16>"
 set pInput($i(pInput))="p=<673,2160,-1825>, v=<102,308,-257>, a=<-4,-23,17>"
 set pInput($i(pInput))="p=<2169,-2413,-1194>, v=<307,-344,-170>, a=<-20,25,16>"
 set pInput($i(pInput))="p=<603,-3052,-393>, v=<89,-434,-53>, a=<-11,33,1>"
 set pInput($i(pInput))="p=<-1690,1909,1134>, v=<-241,272,169>, a=<15,-18,-15>"
 set pInput($i(pInput))="p=<-623,1217,1954>, v=<-93,172,275>, a=<10,-16,-15>"
 set pInput($i(pInput))="p=<-1697,-316,2170>, v=<-242,-45,310>, a=<20,-3,-19>"
 set pInput($i(pInput))="p=<-1516,2344,1308>, v=<-216,333,185>, a=<18,-20,-17>"
 set pInput($i(pInput))="p=<1853,-1625,701>, v=<261,-229,105>, a=<-20,19,-4>"
 set pInput($i(pInput))="p=<1542,-522,-2138>, v=<220,-70,-305>, a=<-20,8,20>"
 set pInput($i(pInput))="p=<-1835,-1148,-887>, v=<-257,-165,-126>, a=<22,13,5>"
 set pInput($i(pInput))="p=<3238,-2064,302>, v=<460,-292,47>, a=<-32,20,0>"
 set pInput($i(pInput))="p=<1003,-2638,-162>, v=<146,-372,-23>, a=<-10,26,5>"
 set pInput($i(pInput))="p=<-2709,1375,804>, v=<-385,196,120>, a=<24,-9,-9>"
 set pInput($i(pInput))="p=<-184,555,2572>, v=<-30,79,367>, a=<1,0,-29>"
 set pInput($i(pInput))="p=<-754,2751,-299>, v=<-110,393,-47>, a=<9,-28,2>"
 set pInput($i(pInput))="p=<2362,713,-1616>, v=<332,104,-227>, a=<-23,-7,15>"
 set pInput($i(pInput))="p=<254,732,-2598>, v=<38,104,-368>, a=<-8,-7,19>"
 set pInput($i(pInput))="p=<-2364,-799,1470>, v=<-344,-112,211>, a=<23,7,-16>"
 set pInput($i(pInput))="p=<2519,1937,-284>, v=<360,274,-40>, a=<-32,-22,3>"
 set pInput($i(pInput))="p=<2368,828,-1323>, v=<333,118,-182>, a=<-27,-5,12>"
 set pInput($i(pInput))="p=<-1443,-1799,2182>, v=<-204,-257,310>, a=<18,22,-23>"
 set pInput($i(pInput))="p=<-2230,320,1535>, v=<-319,47,219>, a=<21,-1,-15>"
 set pInput($i(pInput))="p=<-2176,1006,1711>, v=<-314,138,241>, a=<15,-10,-17>"
 set pInput($i(pInput))="p=<-2359,-1764,735>, v=<-341,-252,107>, a=<20,19,-6>"
 set pInput($i(pInput))="p=<-2255,2133,478>, v=<-318,303,67>, a=<21,-23,-4>"
 set pInput($i(pInput))="p=<1838,2021,-2030>, v=<262,293,-291>, a=<-22,-22,24>"
 set pInput($i(pInput))="p=<676,2730,-1581>, v=<98,391,-222>, a=<-7,-25,18>"
 set pInput($i(pInput))="p=<1654,1705,1873>, v=<233,240,270>, a=<-20,-22,-18>"
 set pInput($i(pInput))="p=<2899,-1228,-768>, v=<414,-171,-110>, a=<-29,10,12>"
 set pInput($i(pInput))="p=<-1106,-2603,-1038>, v=<-160,-376,-152>, a=<13,33,10>"
 set pInput($i(pInput))="p=<-2486,-1591,1417>, v=<-352,-223,202>, a=<23,14,-15>"
 set pInput($i(pInput))="p=<-224,-2723,405>, v=<-31,-392,57>, a=<-4,30,-2>"
 set pInput($i(pInput))="p=<-990,-385,2834>, v=<-141,-51,401>, a=<11,1,-30>"
 set pInput($i(pInput))="p=<2393,-1847,-12>, v=<343,-271,-1>, a=<-24,18,0>"
 set pInput($i(pInput))="p=<897,-1971,2676>, v=<126,-282,379>, a=<-11,19,-26>"
 set pInput($i(pInput))="p=<-1382,828,2465>, v=<-197,118,354>, a=<12,-11,-24>"
 set pInput($i(pInput))="p=<2715,-636,-95>, v=<383,-92,-10>, a=<-23,5,2>"
 set pInput($i(pInput))="p=<-1672,1496,1384>, v=<-238,215,196>, a=<13,-12,-8>"
 set pInput($i(pInput))="p=<-695,2864,430>, v=<-96,408,66>, a=<13,-28,-9>"
 set pInput($i(pInput))="p=<-890,2879,152>, v=<-128,419,18>, a=<11,-25,-1>"
 set pInput($i(pInput))="p=<1150,854,2388>, v=<160,127,344>, a=<-10,-10,-23>"
 set pInput($i(pInput))="p=<-1328,304,2387>, v=<-189,44,346>, a=<19,0,-20>"
 set pInput($i(pInput))="p=<1911,1030,2606>, v=<274,147,372>, a=<-21,-5,-22>"
 set pInput($i(pInput))="p=<-153,1935,1425>, v=<-17,277,204>, a=<-6,-18,-15>"
 set pInput($i(pInput))="p=<-563,-39,-3152>, v=<-85,-5,-449>, a=<4,0,31>"
 set pInput($i(pInput))="p=<1376,-434,2342>, v=<194,-58,337>, a=<-11,7,-24>"
 set pInput($i(pInput))="p=<1328,-3274,1577>, v=<188,-464,224>, a=<-13,32,-11>"
 set pInput($i(pInput))="p=<-1483,2780,842>, v=<-211,394,122>, a=<14,-27,-4>"
 set pInput($i(pInput))="p=<-2579,-50,157>, v=<-368,-5,18>, a=<22,0,-2>"
 set pInput($i(pInput))="p=<-2233,-1101,1703>, v=<-326,-156,244>, a=<23,11,-19>"
 set pInput($i(pInput))="p=<1576,-2527,660>, v=<225,-364,94>, a=<-14,29,-6>"
 set pInput($i(pInput))="p=<-920,-2797,-447>, v=<-128,-399,-63>, a=<7,22,4>"
 set pInput($i(pInput))="p=<-2430,2192,873>, v=<-347,313,128>, a=<25,-21,-11>"
 set pInput($i(pInput))="p=<616,2820,-591>, v=<84,402,-86>, a=<-5,-28,5>"
 set pInput($i(pInput))="p=<-544,-1235,2995>, v=<-78,-179,428>, a=<6,12,-29>"
 set pInput($i(pInput))="p=<-2103,152,1778>, v=<-297,15,262>, a=<21,2,-18>"
 set pInput($i(pInput))="p=<1499,276,3011>, v=<213,37,435>, a=<-14,-7,-31>"
 set pInput($i(pInput))="p=<-1913,2443,611>, v=<-270,345,87>, a=<15,-24,-4>"
 set pInput($i(pInput))="p=<-398,2956,72>, v=<-56,417,10>, a=<1,-31,5>"
 set pInput($i(pInput))="p=<-1863,1996,-1348>, v=<-266,285,-195>, a=<18,-15,14>"
 set pInput($i(pInput))="p=<-2302,-248,1303>, v=<-325,-38,181>, a=<17,1,-17>"
 set pInput($i(pInput))="p=<-591,-341,2548>, v=<-89,-52,364>, a=<4,5,-27>"
 set pInput($i(pInput))="p=<906,-1426,-2591>, v=<129,-206,-368>, a=<-7,14,19>"
 set pInput($i(pInput))="p=<-1733,-1479,1564>, v=<-251,-213,222>, a=<18,9,-13>"
 set pInput($i(pInput))="p=<2526,1103,78>, v=<357,157,11>, a=<-24,-9,-2>"
 set pInput($i(pInput))="p=<745,1626,2823>, v=<111,228,409>, a=<-6,-17,-23>"
 set pInput($i(pInput))="p=<-818,43,-2240>, v=<-118,11,-320>, a=<13,1,25>"
 set pInput($i(pInput))="p=<1837,993,1492>, v=<260,148,213>, a=<-17,-10,-16>"
 set pInput($i(pInput))="p=<-1099,1353,-2333>, v=<-162,193,-333>, a=<8,-9,22>"
 set pInput($i(pInput))="p=<467,2292,2372>, v=<66,332,340>, a=<-10,-18,-20>"
 set pInput($i(pInput))="p=<2035,1594,-773>, v=<290,227,-112>, a=<-18,-8,9>"
 set pInput($i(pInput))="p=<1663,-1377,1996>, v=<237,-196,283>, a=<-20,14,-16>"
 set pInput($i(pInput))="p=<-1151,1892,1053>, v=<-163,270,143>, a=<8,-21,-9>"
 set pInput($i(pInput))="p=<-1985,-1355,-1070>, v=<-283,-192,-151>, a=<22,10,9>"
 set pInput($i(pInput))="p=<880,-1024,-2847>, v=<121,-146,-401>, a=<-6,10,37>"
 set pInput($i(pInput))="p=<-2506,-941,-1276>, v=<-359,-141,-182>, a=<25,14,14>"
 set pInput($i(pInput))="p=<448,-3321,-1237>, v=<65,-469,-174>, a=<-4,31,10>"
 set pInput($i(pInput))="p=<1082,-384,2456>, v=<154,-55,343>, a=<-4,1,-21>"
 set pInput($i(pInput))="p=<583,-1175,2602>, v=<80,-167,370>, a=<-5,8,-26>"
 set pInput($i(pInput))="p=<-2143,1051,-2228>, v=<-306,150,-321>, a=<16,-11,26>"
 set pInput($i(pInput))="p=<-1351,1113,2530>, v=<-195,156,360>, a=<16,-11,-23>"
 set pInput($i(pInput))="p=<1289,2415,1068>, v=<186,345,157>, a=<-13,-31,-9>"
 set pInput($i(pInput))="p=<1829,-441,-2369>, v=<261,-59,-331>, a=<-20,4,25>"
 set pInput($i(pInput))="p=<-1181,2801,-1204>, v=<-168,406,-169>, a=<11,-25,15>"
 set pInput($i(pInput))="p=<1789,111,2716>, v=<253,16,391>, a=<-12,-1,-28>"
 set pInput($i(pInput))="p=<1188,-2396,-1168>, v=<173,-343,-166>, a=<-18,21,11>"
 set pInput($i(pInput))="p=<-624,-2348,1872>, v=<-87,-331,263>, a=<6,23,-17>"
 set pInput($i(pInput))="p=<974,2046,1600>, v=<141,293,228>, a=<-10,-20,-20>"
 set pInput($i(pInput))="p=<1087,-3,2753>, v=<157,4,393>, a=<-10,1,-31>"
 set pInput($i(pInput))="p=<-1696,2565,1439>, v=<-242,365,200>, a=<15,-21,-14>"
 set pInput($i(pInput))="p=<-2139,1264,1625>, v=<-308,186,239>, a=<21,-16,-17>"
 set pInput($i(pInput))="p=<-808,-2806,706>, v=<-116,-402,100>, a=<10,31,-7>"
 set pInput($i(pInput))="p=<-3344,-671,-1309>, v=<-477,-89,-186>, a=<31,4,12>"
 set pInput($i(pInput))="p=<-3120,-1016,-1164>, v=<-445,-145,-169>, a=<33,9,11>"
 set pInput($i(pInput))="p=<-392,1935,-1765>, v=<-54,277,-256>, a=<7,-20,20>"
 set pInput($i(pInput))="p=<-2772,50,-724>, v=<-398,7,-103>, a=<22,-2,1>"
 set pInput($i(pInput))="p=<-1135,909,-2293>, v=<-162,123,-325>, a=<11,-2,17>"
 set pInput($i(pInput))="p=<-2854,-66,-601>, v=<-402,-8,-82>, a=<29,-3,6>"
 set pInput($i(pInput))="p=<1651,760,1457>, v=<233,111,209>, a=<-16,-9,-14>"
 set pInput($i(pInput))="p=<-1771,-1151,-2641>, v=<-254,-160,-378>, a=<17,14,27>"
 set pInput($i(pInput))="p=<-1065,-2133,-2022>, v=<-152,-309,-293>, a=<12,24,14>"
 set pInput($i(pInput))="p=<1476,2335,-246>, v=<211,333,-32>, a=<-7,-22,0>"
 set pInput($i(pInput))="p=<-1903,461,2772>, v=<-268,58,396>, a=<21,-2,-25>"
 set pInput($i(pInput))="p=<765,-2802,769>, v=<112,-398,106>, a=<-3,33,-5>"
 set pInput($i(pInput))="p=<-3176,954,-234>, v=<-450,133,-36>, a=<29,-9,3>"
 set pInput($i(pInput))="p=<2177,-558,-2053>, v=<316,-78,-293>, a=<-21,5,19>"
 set pInput($i(pInput))="p=<394,1915,-2164>, v=<59,277,-313>, a=<-5,-20,21>"
 set pInput($i(pInput))="p=<1111,2949,1071>, v=<155,421,153>, a=<-10,-29,-12>"
 set pInput($i(pInput))="p=<-1787,102,2329>, v=<-254,13,332>, a=<14,-3,-20>"
 set pInput($i(pInput))="p=<-1253,-2502,-882>, v=<-176,-356,-124>, a=<15,24,7>"
 set pInput($i(pInput))="p=<1524,2539,-1037>, v=<216,362,-148>, a=<-15,-21,5>"
 set pInput($i(pInput))="p=<1881,745,2344>, v=<266,106,334>, a=<-14,-5,-24>"
 set pInput($i(pInput))="p=<-824,2492,1274>, v=<-117,355,187>, a=<2,-27,-11>"
 set pInput($i(pInput))="p=<-2672,-391,-718>, v=<-377,-60,-103>, a=<26,2,7>"
 set pInput($i(pInput))="p=<1706,-2502,613>, v=<248,-357,87>, a=<-19,23,-9>"
 set pInput($i(pInput))="p=<2838,442,349>, v=<400,63,52>, a=<-33,-4,-3>"
 set pInput($i(pInput))="p=<271,1719,-2620>, v=<42,245,-371>, a=<-5,-23,22>"
 set pInput($i(pInput))="p=<-1158,-1793,1596>, v=<-165,-258,225>, a=<6,10,-14>"
 set pInput($i(pInput))="p=<2491,-195,-2133>, v=<353,-23,-304>, a=<-22,-4,21>"
 set pInput($i(pInput))="p=<-119,2896,-1592>, v=<-14,413,-227>, a=<-2,-25,14>"
 set pInput($i(pInput))="p=<886,-685,2791>, v=<130,-97,398>, a=<-8,6,-26>"
 set pInput($i(pInput))="p=<1066,-2652,1270>, v=<152,-374,179>, a=<-10,28,-19>"
 set pInput($i(pInput))="p=<2080,1437,-1544>, v=<290,206,-216>, a=<-23,-15,15>"
 set pInput($i(pInput))="p=<1863,410,2408>, v=<270,56,345>, a=<-18,-4,-18>"
 set pInput($i(pInput))="p=<-524,3071,96>, v=<-74,436,11>, a=<7,-33,-4>"
 set pInput($i(pInput))="p=<580,-948,-2576>, v=<88,-133,-367>, a=<-12,11,22>"
 set pInput($i(pInput))="p=<-1103,1711,1858>, v=<-154,246,264>, a=<11,-15,-16>"
 set pInput($i(pInput))="p=<607,-2998,-745>, v=<79,-428,-101>, a=<-11,33,7>"
 set pInput($i(pInput))="p=<-1900,-1037,-1936>, v=<-269,-150,-275>, a=<16,12,15>"
 set pInput($i(pInput))="p=<-1155,-491,-2983>, v=<-164,-71,-431>, a=<11,-2,30>"
 set pInput($i(pInput))="p=<-2544,887,-742>, v=<-363,124,-109>, a=<23,-6,9>"
 set pInput($i(pInput))="p=<-731,2162,-1216>, v=<-102,311,-170>, a=<7,-19,16>"
 set pInput($i(pInput))="p=<-2202,-1939,1089>, v=<-320,-277,157>, a=<25,20,-10>"
 set pInput($i(pInput))="p=<-28,1561,2087>, v=<2,223,300>, a=<0,-16,-20>"
 set pInput($i(pInput))="p=<-1911,-1149,-1625>, v=<-271,-165,-230>, a=<15,10,12>"
 set pInput($i(pInput))="p=<-2869,-1090,310>, v=<-414,-155,49>, a=<26,15,-1>"
 set pInput($i(pInput))="p=<-695,-2254,-1859>, v=<-100,-321,-266>, a=<11,26,13>"
 set pInput($i(pInput))="p=<-2840,-674,1527>, v=<-405,-95,220>, a=<28,0,-17>"
 set pInput($i(pInput))="p=<-647,2949,1149>, v=<-91,421,164>, a=<8,-32,-11>"
 set pInput($i(pInput))="p=<2811,-1286,624>, v=<400,-179,89>, a=<-29,12,-3>"
 set pInput($i(pInput))="p=<1281,-380,-2752>, v=<182,-55,-391>, a=<-16,8,24>"
 set pInput($i(pInput))="p=<-2162,-1503,-1690>, v=<-306,-212,-240>, a=<21,15,14>"
 set pInput($i(pInput))="p=<2629,761,206>, v=<373,108,34>, a=<-27,-7,-7>"
 set pInput($i(pInput))="p=<-2021,620,2109>, v=<-288,90,301>, a=<20,-12,-22>"
 set pInput($i(pInput))="p=<-368,-2701,-164>, v=<-52,-380,-20>, a=<6,21,2>"
 set pInput($i(pInput))="p=<421,-3240,-681>, v=<60,-463,-96>, a=<-5,30,6>"
 set pInput($i(pInput))="p=<1919,-2148,-570>, v=<273,-304,-84>, a=<-24,24,5>"
 set pInput($i(pInput))="p=<1869,91,2715>, v=<264,13,389>, a=<-17,-5,-28>"
 set pInput($i(pInput))="p=<653,2752,1283>, v=<91,393,186>, a=<-3,-26,-15>"
 set pInput($i(pInput))="p=<-1085,-2377,-504>, v=<-155,-343,-71>, a=<10,23,4>"
 set pInput($i(pInput))="p=<2790,-724,-1756>, v=<400,-103,-250>, a=<-27,7,20>"
 set pInput($i(pInput))="p=<2362,670,1049>, v=<341,95,149>, a=<-22,-6,-10>"
 set pInput($i(pInput))="p=<-3223,261,-688>, v=<-459,42,-99>, a=<29,3,6>"
 set pInput($i(pInput))="p=<-968,2692,726>, v=<-135,386,100>, a=<9,-27,-6>"
 set pInput($i(pInput))="p=<763,-873,3032>, v=<108,-128,433>, a=<-7,11,-30>"
 set pInput($i(pInput))="p=<-397,-2950,-1235>, v=<-54,-417,-179>, a=<-1,30,13>"
 set pInput($i(pInput))="p=<2644,506,2319>, v=<370,68,328>, a=<-25,-5,-21>"
 set pInput($i(pInput))="p=<226,1558,2032>, v=<28,223,290>, a=<-2,-18,-18>"
 set pInput($i(pInput))="p=<-96,-2863,420>, v=<-8,-411,59>, a=<2,29,-1>"
 set pInput($i(pInput))="p=<2753,-521,644>, v=<389,-74,94>, a=<-25,4,-6>"
 set pInput($i(pInput))="p=<-2535,604,1696>, v=<-363,84,240>, a=<23,-5,-16>"
 set pInput($i(pInput))="p=<-1475,-1868,-1676>, v=<-211,-271,-235>, a=<13,20,20>"
 set pInput($i(pInput))="p=<2257,-411,1855>, v=<326,-61,264>, a=<-19,-2,-19>"
 set pInput($i(pInput))="p=<2632,1836,822>, v=<376,266,120>, a=<-30,-16,-8>"
 set pInput($i(pInput))="p=<-1695,1905,-1631>, v=<-243,272,-238>, a=<14,-27,18>"
 set pInput($i(pInput))="p=<-1726,1459,-2018>, v=<-246,211,-289>, a=<22,-17,23>"
 set pInput($i(pInput))="p=<2307,2175,489>, v=<328,312,67>, a=<-23,-20,-6>"
 set pInput($i(pInput))="p=<-1861,2174,-527>, v=<-269,313,-75>, a=<18,-24,5>"
 set pInput($i(pInput))="p=<-208,1185,2569>, v=<-28,169,371>, a=<-1,-10,-25>"
 set pInput($i(pInput))="p=<-1923,-300,2216>, v=<-271,-48,315>, a=<19,8,-22>"
 set pInput($i(pInput))="p=<-428,3024,-1181>, v=<-61,432,-171>, a=<3,-34,14>"
 set pInput($i(pInput))="p=<549,-2670,-461>, v=<73,-387,-65>, a=<-5,26,3>"
 set pInput($i(pInput))="p=<-1556,326,-2238>, v=<-221,43,-316>, a=<10,-3,27>"
 set pInput($i(pInput))="p=<-598,-3422,-454>, v=<-86,-488,-64>, a=<1,35,4>"
 set pInput($i(pInput))="p=<2143,-443,1333>, v=<302,-66,193>, a=<-20,8,-11>"
 set pInput($i(pInput))="p=<286,231,2772>, v=<40,35,396>, a=<-7,-1,-30>"
 set pInput($i(pInput))="p=<362,-2668,9>, v=<51,-379,1>, a=<-1,27,0>"
 set pInput($i(pInput))="p=<1015,-2626,-85>, v=<142,-376,-11>, a=<-13,33,-2>"
 set pInput($i(pInput))="p=<-709,904,2451>, v=<-103,130,350>, a=<5,-8,-27>"
 set pInput($i(pInput))="p=<2081,408,-1170>, v=<298,58,-166>, a=<-15,-7,11>"
 set pInput($i(pInput))="p=<-482,-2973,-1081>, v=<-69,-420,-151>, a=<2,31,9>"
 set pInput($i(pInput))="p=<-818,-74,-2792>, v=<-118,-10,-402>, a=<14,-3,32>"
 set pInput($i(pInput))="p=<2999,-87,-960>, v=<427,-14,-136>, a=<-31,3,6>"
 set pInput($i(pInput))="p=<2885,-1265,-374>, v=<409,-181,-53>, a=<-29,12,3>"
 set pInput($i(pInput))="p=<-1572,2938,16>, v=<-221,415,0>, a=<12,-30,0>"
 set pInput($i(pInput))="p=<-2424,-669,-1204>, v=<-342,-92,-175>, a=<21,8,17>"
 set pInput($i(pInput))="p=<-1215,1266,-2099>, v=<-173,176,-300>, a=<14,-7,21>"
 set pInput($i(pInput))="p=<-202,-3331,202>, v=<-33,-475,25>, a=<-1,36,1>"
 set pInput($i(pInput))="p=<935,2601,-482>, v=<133,370,-68>, a=<-12,-26,4>"
 set pInput($i(pInput))="p=<-1796,-2630,-1179>, v=<-260,-374,-168>, a=<20,24,10>"
 set pInput($i(pInput))="p=<-1532,-596,-1900>, v=<-220,-82,-274>, a=<18,5,23>"
 set pInput($i(pInput))="p=<-1577,-720,-2161>, v=<-228,-100,-303>, a=<17,8,25>"
 set pInput($i(pInput))="p=<-1215,1584,1974>, v=<-178,226,278>, a=<17,-15,-22>"
 set pInput($i(pInput))="p=<-3480,-170,1515>, v=<-499,-19,213>, a=<38,-1,-14>"
 set pInput($i(pInput))="p=<-2436,-111,-929>, v=<-353,-14,-128>, a=<25,0,14>"
 set pInput($i(pInput))="p=<2047,1023,-2117>, v=<292,149,-304>, a=<-21,-10,21>"
 set pInput($i(pInput))="p=<1510,-3054,336>, v=<224,-436,55>, a=<-12,35,-2>"
 set pInput($i(pInput))="p=<-2860,74,1242>, v=<-408,10,177>, a=<29,-2,-11>"
 set pInput($i(pInput))="p=<423,2218,-2064>, v=<56,316,-290>, a=<-1,-23,19>"
 set pInput($i(pInput))="p=<-1523,391,2820>, v=<-216,54,401>, a=<16,-3,-25>"
 set pInput($i(pInput))="p=<2150,822,-2210>, v=<305,114,-314>, a=<-21,-10,22>"
 set pInput($i(pInput))="p=<980,-2578,716>, v=<140,-368,106>, a=<-13,25,-13>"
 set pInput($i(pInput))="p=<-2221,-1430,671>, v=<-319,-202,91>, a=<29,20,-6>"
 set pInput($i(pInput))="p=<71,585,-2438>, v=<13,84,-348>, a=<0,1,24>"
 set pInput($i(pInput))="p=<-2243,-2418,-28>, v=<-320,-339,-10>, a=<22,23,0>"
 set pInput($i(pInput))="p=<-1990,1907,1046>, v=<-283,274,147>, a=<14,-22,-10>"
 set pInput($i(pInput))="p=<646,-563,-2987>, v=<96,-80,-426>, a=<-6,11,28>"
 set pInput($i(pInput))="p=<1124,-2386,-2399>, v=<166,-340,-342>, a=<-12,28,23>"
 set pInput($i(pInput))="p=<1269,-527,-2292>, v=<184,-75,-331>, a=<-12,2,24>"
 set pInput($i(pInput))="p=<-1031,2489,-962>, v=<-147,354,-138>, a=<13,-21,14>"
 set pInput($i(pInput))="p=<723,-2658,-127>, v=<105,-380,-14>, a=<-6,27,2>"
 set pInput($i(pInput))="p=<2,1922,2219>, v=<0,278,321>, a=<3,-18,-23>"
 set pInput($i(pInput))="p=<-2842,1751,-150>, v=<-408,256,-21>, a=<26,-17,-4>"
 set pInput($i(pInput))="p=<45,-2950,-602>, v=<9,-419,-87>, a=<3,29,6>"
 set pInput($i(pInput))="p=<-1231,-1203,-2120>, v=<-176,-172,-302>, a=<8,13,18>"
 set pInput($i(pInput))="p=<1637,-356,-1921>, v=<234,-56,-273>, a=<-14,1,18>"
 set pInput($i(pInput))="p=<-1712,-1611,-1495>, v=<-246,-229,-213>, a=<16,22,14>"
 set pInput($i(pInput))="p=<3521,152,-943>, v=<503,23,-134>, a=<-35,6,7>"
 set pInput($i(pInput))="p=<-2104,-2243,-337>, v=<-302,-320,-51>, a=<19,23,3>"
 set pInput($i(pInput))="p=<2358,-595,-1456>, v=<336,-91,-213>, a=<-22,8,14>"
 set pInput($i(pInput))="p=<-525,-1627,2776>, v=<-69,-232,399>, a=<0,14,-32>"
 set pInput($i(pInput))="p=<1648,963,-1620>, v=<238,134,-231>, a=<-12,-6,15>"
 set pInput($i(pInput))="p=<-2751,363,-551>, v=<-391,54,-79>, a=<24,-3,9>"
 set pInput($i(pInput))="p=<300,1792,2155>, v=<47,251,307>, a=<-6,-17,-16>"
 set pInput($i(pInput))="p=<1106,-214,-2291>, v=<156,-35,-325>, a=<-3,0,23>"
 set pInput($i(pInput))="p=<-1964,-795,-2331>, v=<-286,-111,-333>, a=<19,15,18>"
 set pInput($i(pInput))="p=<137,-3166,-572>, v=<21,-452,-82>, a=<0,30,3>"
 set pInput($i(pInput))="p=<-2691,705,-999>, v=<-388,98,-139>, a=<26,-9,10>"
 set pInput($i(pInput))="p=<1203,343,-3272>, v=<174,54,-469>, a=<-12,2,32>"
 set pInput($i(pInput))="p=<3115,-432,-66>, v=<447,-61,-3>, a=<-30,4,0>"
 set pInput($i(pInput))="p=<2562,-1744,862>, v=<367,-252,123>, a=<-23,17,-5>"
 set pInput($i(pInput))="p=<1380,-1281,1622>, v=<196,-177,230>, a=<-17,9,-14>"
 set pInput($i(pInput))="p=<-1200,-844,-2301>, v=<-173,-120,-328>, a=<15,15,20>"
 set pInput($i(pInput))="p=<-792,-1599,2552>, v=<-111,-231,367>, a=<7,17,-25>"
 set pInput($i(pInput))="p=<307,2585,-1745>, v=<46,361,-252>, a=<-2,-32,17>"
 set pInput($i(pInput))="p=<-199,-1278,-2273>, v=<-26,-186,-327>, a=<1,17,22>"
 set pInput($i(pInput))="p=<1870,-2159,-899>, v=<264,-314,-123>, a=<-18,22,6>"
 set pInput($i(pInput))="p=<434,1298,2381>, v=<63,185,337>, a=<-4,-11,-23>"
 set pInput($i(pInput))="p=<-2150,-2011,1077>, v=<-311,-289,157>, a=<15,22,-10>"
 set pInput($i(pInput))="p=<2355,-966,31>, v=<334,-136,2>, a=<-21,13,1>"
 set pInput($i(pInput))="p=<880,2467,1228>, v=<131,350,176>, a=<-10,-18,-9>"
 set pInput($i(pInput))="p=<2696,301,951>, v=<383,47,138>, a=<-29,-3,-10>"
 set pInput($i(pInput))="p=<50,1466,2481>, v=<4,210,354>, a=<0,-13,-21>"
 set pInput($i(pInput))="p=<-46,1414,2588>, v=<-3,203,369>, a=<2,-15,-22>"
 set pInput($i(pInput))="p=<-1343,790,2128>, v=<-191,114,306>, a=<17,-8,-19>"
 set pInput($i(pInput))="p=<-1893,-320,1958>, v=<-271,-46,278>, a=<18,1,-19>"
 set pInput($i(pInput))="p=<3013,80,1731>, v=<433,10,244>, a=<-30,0,-12>"
 set pInput($i(pInput))="p=<-1561,-2177,-1020>, v=<-227,-314,-145>, a=<16,26,16>"
 set pInput($i(pInput))="p=<-1230,2247,-501>, v=<-169,320,-71>, a=<14,-22,4>"
 set pInput($i(pInput))="p=<527,-2245,1744>, v=<67,-319,248>, a=<-6,21,-17>"
 set pInput($i(pInput))="p=<-1513,-166,-2981>, v=<-211,-28,-425>, a=<15,0,29>"
 set pInput($i(pInput))="p=<440,-823,2548>, v=<63,-116,364>, a=<-4,10,-24>"
 set pInput($i(pInput))="p=<-1545,-2022,350>, v=<-217,-285,51>, a=<19,18,-6>"
 set pInput($i(pInput))="p=<-1920,-2099,1374>, v=<-271,-304,197>, a=<18,21,-12>"
 set pInput($i(pInput))="p=<-1984,2245,966>, v=<-283,325,138>, a=<22,-22,-5>"
 set pInput($i(pInput))="p=<1286,1145,1885>, v=<186,163,271>, a=<-7,-11,-18>"
 set pInput($i(pInput))="p=<-2077,-1678,1117>, v=<-294,-243,156>, a=<24,17,-9>"
 set pInput($i(pInput))="p=<-65,3081,988>, v=<-9,440,141>, a=<-1,-33,-13>"
 set pInput($i(pInput))="p=<1372,-2516,92>, v=<198,-361,17>, a=<-13,23,0>"
 set pInput($i(pInput))="p=<574,-2894,-2168>, v=<82,-413,-309>, a=<-1,28,22>"
 set pInput($i(pInput))="p=<2843,-746,1072>, v=<408,-108,156>, a=<-26,5,-8>"
 set pInput($i(pInput))="p=<-2673,2015,-608>, v=<-380,287,-87>, a=<29,-14,5>"
 set pInput($i(pInput))="p=<-1103,-1722,-1992>, v=<-157,-247,-289>, a=<14,19,18>"
 set pInput($i(pInput))="p=<-619,528,-2863>, v=<-88,75,-410>, a=<5,-7,28>"
 set pInput($i(pInput))="p=<-1977,2190,1193>, v=<-282,311,167>, a=<17,-19,-13>"
 set pInput($i(pInput))="p=<860,-3029,253>, v=<123,-433,41>, a=<-8,33,-2>"
 set pInput($i(pInput))="p=<-1719,1295,-1775>, v=<-245,183,-250>, a=<13,-13,19>"
 set pInput($i(pInput))="p=<-2978,1898,-292>, v=<-428,271,-47>, a=<30,-18,2>"
 set pInput($i(pInput))="p=<565,1062,-2232>, v=<80,152,-315>, a=<-4,-10,28>"
 set pInput($i(pInput))="p=<-1305,1305,-2694>, v=<-183,186,-382>, a=<14,-14,26>"
 set pInput($i(pInput))="p=<-2484,-273,-1989>, v=<-359,-35,-283>, a=<23,4,18>"
 set pInput($i(pInput))="p=<1136,-1048,-2857>, v=<166,-150,-410>, a=<-9,9,30>"
 set pInput($i(pInput))="p=<-442,2206,2090>, v=<-64,315,301>, a=<4,-22,-14>"
 set pInput($i(pInput))="p=<-23,2898,224>, v=<-3,412,30>, a=<0,-26,1>"
 set pInput($i(pInput))="p=<2138,959,-1982>, v=<306,140,-283>, a=<-19,-9,17>"
 set pInput($i(pInput))="p=<-1618,1775,-1360>, v=<-231,253,-191>, a=<22,-18,12>"
 set pInput($i(pInput))="p=<692,1924,-2492>, v=<99,278,-361>, a=<-6,-17,28>"
 set pInput($i(pInput))="p=<-1023,2364,-1752>, v=<-142,340,-247>, a=<10,-19,19>"
 set pInput($i(pInput))="p=<-1750,-2698,1145>, v=<-246,-382,167>, a=<17,25,-11>"
 set pInput($i(pInput))="p=<3258,1100,-180>, v=<470,158,-26>, a=<-32,-13,0>"
 set pInput($i(pInput))="p=<-1915,-679,-2235>, v=<-273,-97,-323>, a=<21,9,24>"
 set pInput($i(pInput))="p=<-1104,-2081,-786>, v=<-155,-297,-113>, a=<11,22,10>"
 set pInput($i(pInput))="p=<-2858,-640,-706>, v=<-406,-90,-100>, a=<29,5,4>"
 set pInput($i(pInput))="p=<712,1716,-1986>, v=<102,248,-284>, a=<-7,-17,19>"
 set pInput($i(pInput))="p=<832,2700,-390>, v=<120,385,-55>, a=<-5,-26,3>"
 set pInput($i(pInput))="p=<1587,-619,2627>, v=<223,-84,375>, a=<-17,4,-28>"
 set pInput($i(pInput))="p=<2298,470,2118>, v=<325,62,302>, a=<-16,-8,-19>"
 set pInput($i(pInput))="p=<-2057,-1407,-2233>, v=<-288,-204,-317>, a=<25,14,26>"
 set pInput($i(pInput))="p=<-112,-62,2758>, v=<-13,-5,397>, a=<1,-2,-23>"
 set pInput($i(pInput))="p=<-211,-2054,2162>, v=<-32,-291,309>, a=<6,20,-24>"
 set pInput($i(pInput))="p=<2083,836,1594>, v=<299,118,228>, a=<-18,-8,-17>"
 set pInput($i(pInput))="p=<-530,2090,1973>, v=<-76,302,278>, a=<4,-26,-24>"
 set pInput($i(pInput))="p=<-1080,1942,-1900>, v=<-158,279,-272>, a=<6,-19,19>"
 set pInput($i(pInput))="p=<-2074,1278,1789>, v=<-301,186,250>, a=<14,-11,-18>"
 set pInput($i(pInput))="p=<-520,2504,414>, v=<-74,354,60>, a=<-2,-25,-7>"
 set pInput($i(pInput))="p=<-1176,-2282,-1591>, v=<-170,-326,-228>, a=<16,15,15>"
 set pInput($i(pInput))="p=<102,2968,990>, v=<12,427,146>, a=<-7,-32,-10>"
 set pInput($i(pInput))="p=<-2709,1659,-316>, v=<-389,241,-39>, a=<31,-9,1>"
 set pInput($i(pInput))="p=<-2290,1919,773>, v=<-329,275,105>, a=<22,-16,-12>"
 set pInput($i(pInput))="p=<615,482,3245>, v=<85,69,463>, a=<-10,0,-27>"
 set pInput($i(pInput))="p=<1234,2456,-1243>, v=<178,346,-177>, a=<-9,-21,9>"
 set pInput($i(pInput))="p=<1114,1679,1730>, v=<164,240,248>, a=<-12,-15,-17>"
 set pInput($i(pInput))="p=<-1422,1522,-1711>, v=<-208,209,-244>, a=<9,-15,21>"
 set pInput($i(pInput))="p=<2007,-1374,485>, v=<285,-201,69>, a=<-22,17,-4>"
 set pInput($i(pInput))="p=<-12,2520,544>, v=<-1,362,74>, a=<0,-26,-10>"
 set pInput($i(pInput))="p=<-474,-1923,2315>, v=<-67,-270,334>, a=<2,18,-21>"
 set pInput($i(pInput))="p=<1517,-2248,-418>, v=<216,-314,-59>, a=<-14,22,3>"
 set pInput($i(pInput))="p=<1118,2532,-1334>, v=<159,361,-189>, a=<-12,-25,13>"
 set pInput($i(pInput))="p=<-1489,-1372,-2353>, v=<-219,-200,-337>, a=<15,18,21>"
 set pInput($i(pInput))="p=<1056,25,-2775>, v=<149,1,-398>, a=<-17,0,27>"
 set pInput($i(pInput))="p=<-2726,1082,-1224>, v=<-389,153,-169>, a=<27,-7,12>"
 set pInput($i(pInput))="p=<751,608,-2592>, v=<102,88,-374>, a=<-6,-7,24>"
 set pInput($i(pInput))="p=<1945,2317,-136>, v=<276,331,-18>, a=<-23,-24,4>"
 set pInput($i(pInput))="p=<-3253,69,-228>, v=<-462,11,-36>, a=<36,0,-1>"
 set pInput($i(pInput))="p=<1255,-2938,-313>, v=<183,-419,-45>, a=<-8,26,7>"
 set pInput($i(pInput))="p=<-2646,2011,-797>, v=<-380,287,-109>, a=<25,-21,2>"
 set pInput($i(pInput))="p=<50,-1406,-2557>, v=<5,-198,-362>, a=<6,15,24>"
 set pInput($i(pInput))="p=<348,-1005,2940>, v=<51,-140,420>, a=<-2,7,-29>"
 set pInput($i(pInput))="p=<-672,2846,-1419>, v=<-97,402,-207>, a=<6,-28,11>"
 set pInput($i(pInput))="p=<2859,1440,-24>, v=<408,201,-9>, a=<-27,-21,2>"
 set pInput($i(pInput))="p=<2157,-1843,429>, v=<313,-263,61>, a=<-22,19,-4>"
 set pInput($i(pInput))="p=<45,-1064,2940>, v=<6,-158,419>, a=<1,12,-29>"
 set pInput($i(pInput))="p=<1730,987,-1830>, v=<247,143,-264>, a=<-19,-7,17>"
 set pInput($i(pInput))="p=<-1122,-1149,2253>, v=<-165,-161,322>, a=<12,11,-25>"
 set pInput($i(pInput))="p=<2676,-601,-785>, v=<380,-86,-115>, a=<-30,5,8>"
 set pInput($i(pInput))="p=<2435,-555,-1288>, v=<348,-80,-183>, a=<-24,6,12>"
 set pInput($i(pInput))="p=<1305,-81,2894>, v=<185,-10,413>, a=<-13,-4,-30>"
 set pInput($i(pInput))="p=<954,-2008,1396>, v=<140,-292,199>, a=<-9,25,-10>"
 set pInput($i(pInput))="p=<-133,2590,984>, v=<-19,374,140>, a=<0,-23,-10>"
 set pInput($i(pInput))="p=<1389,-2086,-2054>, v=<194,-296,-293>, a=<-16,18,19>"
 set pInput($i(pInput))="p=<-296,-2831,566>, v=<-37,-404,82>, a=<-2,24,1>"
 set pInput($i(pInput))="p=<-2569,-802,-1287>, v=<-369,-113,-183>, a=<28,10,10>"
 set pInput($i(pInput))="p=<-1886,1812,-2154>, v=<-266,255,-307>, a=<15,-17,26>"
 set pInput($i(pInput))="p=<-1719,-1231,1420>, v=<-244,-174,204>, a=<20,14,-18>"
 set pInput($i(pInput))="p=<-2888,-1394,1274>, v=<-412,-202,183>, a=<28,13,-14>"
 set pInput($i(pInput))="p=<1984,1660,1284>, v=<287,237,179>, a=<-19,-18,-16>"
 set pInput($i(pInput))="p=<-41,200,2573>, v=<-4,31,370>, a=<-1,-2,-25>"
 set pInput($i(pInput))="p=<-3016,34,-1363>, v=<-429,1,-190>, a=<31,-5,13>"
 set pInput($i(pInput))="p=<-1286,-763,2011>, v=<-183,-107,287>, a=<11,1,-21>"
 set pInput($i(pInput))="p=<-1848,1908,-618>, v=<-265,274,-87>, a=<19,-22,11>"
 set pInput($i(pInput))="p=<-688,2384,-207>, v=<-98,336,-29>, a=<7,-22,0>"
 set pInput($i(pInput))="p=<281,847,-2885>, v=<40,121,-412>, a=<-1,-11,25>"
 set pInput($i(pInput))="p=<192,-2453,-1601>, v=<31,-355,-222>, a=<-1,24,17>"
 set pInput($i(pInput))="p=<491,2203,2548>, v=<68,315,367>, a=<-5,-21,-28>"
 set pInput($i(pInput))="p=<-2321,-624,-555>, v=<-336,-90,-81>, a=<23,6,-1>"
 set pInput($i(pInput))="p=<-432,-3152,-213>, v=<-63,-450,-31>, a=<-2,31,1>"
 set pInput($i(pInput))="p=<-1867,1915,-782>, v=<-266,270,-110>, a=<22,-19,7>"
 set pInput($i(pInput))="p=<-892,-2127,-2359>, v=<-122,-311,-337>, a=<5,25,26>"
 set pInput($i(pInput))="p=<-941,2518,-1279>, v=<-140,360,-182>, a=<10,-25,11>"
 set pInput($i(pInput))="p=<1469,340,-3429>, v=<209,48,-490>, a=<-13,0,38>"
 set pInput($i(pInput))="p=<673,3163,673>, v=<101,451,95>, a=<-8,-34,-1>"
 set pInput($i(pInput))="p=<800,1337,2614>, v=<114,193,371>, a=<-2,-15,-24>"
 set pInput($i(pInput))="p=<1261,1722,-2285>, v=<179,249,-326>, a=<-14,-19,19>"
 set pInput($i(pInput))="p=<1473,-2386,-1740>, v=<210,-340,-248>, a=<-13,21,17>"
 set pInput($i(pInput))="p=<1905,2345,936>, v=<269,330,128>, a=<-21,-27,-8>"
 set pInput($i(pInput))="p=<-9,-2986,506>, v=<2,-426,74>, a=<0,29,-4>"
 set pInput($i(pInput))="p=<1104,2001,1666>, v=<158,286,238>, a=<-11,-20,-14>"
 set pInput($i(pInput))="p=<-497,-2214,2033>, v=<-66,-314,293>, a=<5,22,-13>"
 set pInput($i(pInput))="p=<209,-2513,-1928>, v=<29,-361,-273>, a=<-3,23,23>"
 set pInput($i(pInput))="p=<3148,-137,-45>, v=<452,-16,-6>, a=<-34,1,1>"
 set pInput($i(pInput))="p=<-738,-382,3098>, v=<-105,-51,440>, a=<8,2,-30>"
 set pInput($i(pInput))="p=<1401,2701,793>, v=<200,387,112>, a=<-11,-26,-11>"
 set pInput($i(pInput))="p=<-2116,-937,-1839>, v=<-303,-136,-266>, a=<19,9,20>"
 set pInput($i(pInput))="p=<686,-763,-3088>, v=<104,-117,-443>, a=<-6,10,27>"
 set pInput($i(pInput))="p=<-1078,-2695,1808>, v=<-150,-381,252>, a=<7,28,-22>"
 set pInput($i(pInput))="p=<-1664,-680,2702>, v=<-238,-102,384>, a=<19,8,-26>"
 set pInput($i(pInput))="p=<-2971,-700,1101>, v=<-431,-98,157>, a=<25,6,-11>"
 set pInput($i(pInput))="p=<-403,-2013,-1424>, v=<-57,-286,-197>, a=<-1,18,14>"
 set pInput($i(pInput))="p=<-248,-2160,-1597>, v=<-35,-308,-228>, a=<3,22,15>"
 set pInput($i(pInput))="p=<-1239,983,-1956>, v=<-175,136,-272>, a=<12,-11,20>"
 set pInput($i(pInput))="p=<1358,2352,2015>, v=<192,333,283>, a=<-8,-18,-14>"
 set pInput($i(pInput))="p=<-513,-2703,-1005>, v=<-72,-384,-140>, a=<3,26,14>"
 set pInput($i(pInput))="p=<1677,2614,-393>, v=<239,372,-55>, a=<-15,-26,2>"
 set pInput($i(pInput))="p=<568,-2323,1735>, v=<77,-333,241>, a=<-4,20,-10>"
 set pInput($i(pInput))="p=<2487,1279,-308>, v=<353,188,-42>, a=<-24,-12,9>"
 set pInput($i(pInput))="p=<1009,316,2729>, v=<136,46,389>, a=<-7,-7,-26>"
 set pInput($i(pInput))="p=<2442,-775,2407>, v=<345,-111,344>, a=<-25,7,-21>"
 set pInput($i(pInput))="p=<-936,2174,2023>, v=<-134,305,289>, a=<12,-18,-18>"
 set pInput($i(pInput))="p=<-731,-714,-2746>, v=<-104,-100,-390>, a=<0,5,30>"
 set pInput($i(pInput))="p=<422,-3337,-414>, v=<63,-477,-61>, a=<-4,31,4>"
 set pInput($i(pInput))="p=<1873,1735,-1252>, v=<270,244,-174>, a=<-22,-15,15>"
 set pInput($i(pInput))="p=<-2135,-1673,-1094>, v=<-306,-239,-155>, a=<21,18,13>"
 set pInput($i(pInput))="p=<-327,-2234,1998>, v=<-44,-322,283>, a=<1,22,-22>"
 set pInput($i(pInput))="p=<1599,722,1794>, v=<228,102,260>, a=<-16,-7,-17>"
 set pInput($i(pInput))="p=<749,-3446,-111>, v=<114,-490,-13>, a=<-9,35,1>"

	for i=1:1:pInput {
		set tTemp=pInput(i)
		set tArray(i,"p")=$p($p(tTemp,"p=<",2),">",1)
		set tArray(i,"p","x")=$p(tArray(i,"p"),",",1)
		set tArray(i,"p","y")=$p(tArray(i,"p"),",",2)
		set tArray(i,"p","z")=$p(tArray(i,"p"),",",3)
		set tArray(i,"v")=$p($p(tTemp,"v=<",2),">",1)
		set tArray(i,"v","x")=$p(tArray(i,"v"),",",1)
		set tArray(i,"v","y")=$p(tArray(i,"v"),",",2)
		set tArray(i,"v","z")=$p(tArray(i,"v"),",",3)
		set tArray(i,"a")=$p($p(tTemp,"a=<",2),">",1)
		set tArray(i,"a","x")=$p(tArray(i,"a"),",",1)
		set tArray(i,"a","y")=$p(tArray(i,"a"),",",2)
		set tArray(i,"a","z")=$p(tArray(i,"a"),",",3)
	}
	
	for i=1:1:1000 {
		w:i#100=0 i,!
		set j=$o(tArray(""))
		while j'="" {
			set tArray(j,"v","x")=tArray(j,"v","x")+tArray(j,"a","x")
			set tArray(j,"v","y")=tArray(j,"v","y")+tArray(j,"a","y")
			set tArray(j,"v","z")=tArray(j,"v","z")+tArray(j,"a","z")
			set tArray(j,"p","x")=tArray(j,"p","x")+tArray(j,"v","x")
			set tArray(j,"p","y")=tArray(j,"p","y")+tArray(j,"v","y")
			set tArray(j,"p","z")=tArray(j,"p","z")+tArray(j,"v","z")
			set j=$o(tArray(j))
		}
		set j=$o(tArray(""))
		while j'="" {
			set tRem=0
			set k=$o(tArray(j))
			while k'="" {
				if (tArray(j,"p","x")=tArray(k,"p","x"))&&(tArray(j,"p","y")=tArray(k,"p","y"))&&(tArray(j,"p","z")=tArray(k,"p","z")) {
					k tArray(k)
					set tRem=1
				}
				set k=$o(tArray(k))
			}
			if tRem {
				k tArray(j)
			}
			set j=$o(tArray(j))
		}
	}
	
	zw tArray
	
	set tCount=0
	
	set j=$o(tArray(""))
	while j'="" {
		set tCount=tCount+1
		set j=$o(tArray(j))
	}
	
	quit tCount
}

ClassMethod Day21P1() As %String
{
	set pInput="../..-.../.#./.#.@#./..-.../#../#..@##/..-#.#/.#./.#.@.#/#.-##./##./...@##/#.-.##/###/#..@##/##-.##/#../##.@.../.../...-.#.#/###./##.#/###.@#../.../...-#.#./..#./..../#.#.@.#./.../...-#.##/..#./.#.#/####@##./.../...-###./.#../####/##..@#.#/.../...-...#/####/#.##/...#@###/.../...-.#../..#./#..#/..#.@.#./#../...-###./.##./#.../..#.@##./#../...-#.#./...#/..../.###@..#/#../...-..../..../##../#..#@#.#/#../...-..#./#..#/.#../..##@.##/#../...-##../.#.#/.##./...#@###/#../...-..../#.../#..#/#..#@.../.#./...-##.#/#.#./#.../#..#@#../.#./...-..#./#.#./.##./....@.#./.#./...-..##/#.../..../###.@##./.#./...-.#../...#/.##./.#.#@#.#/.#./...-...#/#..#/.#../.###@###/.#./...-###./.###/##.#/#.##@.#./##./...-##.#/##../..##/..##@##./##./...-#.##/.###/.##./###.@..#/##./...-##.#/.##./..##/####@#.#/##./...-####/####/#.##/.#..@.##/##./...-####/.#../####/#..#@###/##./...-#.#./..#./###./..#.@.../#.#/...-#.../..../.#../#.##@#../#.#/...-..#./###./####/..#.@.#./#.#/...-#.##/.#../##.#/#.#.@##./#.#/...-###./.###/###./##..@#.#/#.#/...-...#/.##./.#.#/#.##@###/#.#/...-####/#.../###./###.@.../###/...-..##/#.##/.#../.#..@#../###/...-..../.###/.#.#/...#@.#./###/...-#.##/.#.#/.#.#/.##.@##./###/...-#..#/.#.#/#.##/#.#.@#.#/###/...-#.../##../#.##/##.#@###/###/...-.#../.#../.###/..#.@..#/.../#..-...#/.##./.##./####@#.#/.../#..-##.#/##../#.#./.#..@.##/.../#..-#..#/.##./####/.#..@###/.../#..-..../..../..##/..##@.##/#../#..-..##/.##./#..#/###.@###/#../#..-##.#/#..#/#.../#..#@..#/.#./#..-#..#/##.#/.##./#..#@#.#/.#./#..-.#../####/..##/#.##@.##/.#./#..-###./#..#/.##./###.@###/.#./#..-####/###./##../..##@.##/##./#..-#.../####/...#/####@###/##./#..-.#../#.##/.##./####@#../..#/#..-.#../####/#.../....@.#./..#/#..-.#.#/...#/.###/.#.#@##./..#/#..-..##/#..#/#..#/....@#.#/..#/#..-.###/.#.#/.##./#.#.@.##/..#/#..-...#/#.##/#.../..##@###/..#/#..-#.##/#.##/...#/#.##@#../#.#/#..-#..#/..##/.#../.###@.#./#.#/#..-#.##/..../.##./.#..@##./#.#/#..-#.#./..#./.#.#/.#..@..#/#.#/#..-...#/#..#/###./##..@#.#/#.#/#..-##.#/##.#/.#.#/.#..@.##/#.#/#..-#..#/#..#/##../.#..@###/#.#/#..-#.##/..##/##.#/....@#../.##/#..-##.#/.##./...#/.#.#@.#./.##/#..-.##./.###/###./.#.#@##./.##/#..-#.#./#.##/..##/.#..@#.#/.##/#..-..#./.##./..##/.#..@.##/.##/#..-##../..##/#..#/#...@###/.##/#..-###./#..#/##.#/..#.@#../###/#..-.###/#.../####/#.#.@.#./###/#..-#.#./.###/#..#/....@##./###/#..-..#./.#.#/#.../#...@..#/###/#..-...#/..#./##../#..#@#.#/###/#..-.#.#/###./.#../##..@.##/###/#..-.#../###./..#./##..@###/###/#..-.#../..##/#.../#...@.#./#.#/.#.-##.#/..../##../.#..@##./#.#/.#.-#.../#.##/.###/#.##@#.#/#.#/.#.-...#/..##/##.#/#.##@###/#.#/.#.-...#/.#.#/###./#..#@.#./###/.#.-...#/...#/##../#.##@##./###/.#.-###./###./.#.#/..##@#.#/###/.#.-..../#..#/..##/#..#@###/###/.#.-.#.#/.#.#/##../.###@#.#/..#/##.-.##./..#./##../....@###/..#/##.-####/...#/.#.#/#...@.##/#.#/##.-..#./...#/###./.#..@###/#.#/##.-..../.#../.#../#.#.@#.#/.##/##.-.##./..../#.../.#.#@###/.##/##.-..../#..#/...#/#...@.##/###/##.-#.##/##.#/#.../..#.@###/###/##.-.#../.###/###./##.#@#.#/.../#.#-.#.#/..../#..#/.#..@###/.../#.#-##../#.##/##.#/..#.@###/#../#.#-.#.#/..../.#.#/.###@#.#/.#./#.#-...#/..../##.#/#...@###/.#./#.#-####/.###/#.#./#.##@###/##./#.#-#..#/.###/...#/###.@#.#/#.#/#.#-#.##/...#/.###/.##.@###/#.#/#.#-#.../.#.#/.#.#/.###@#.#/###/#.#-##.#/##../###./#...@###/###/#.#-.##./.###/.#../..##@###/#.#/###-#.##/###./#..#/#..#@###/###/###-#.../..../#..#/#..."
	//set pInput="../.#-##./#../...@.#./..#/###-#..#/..../..../#..#"
	set tIters=18
	for i=1:1:$length(pInput,"@") {
		k tStr
		set tTemp=$piece(pInput,"@",i)
		set tSize=$length($p(tTemp,"-",1))
		for j=1:1:tSize {
			if $e(tTemp,j)'="/" {
				if $e(tTemp,j)="." {
					set tVal=0
				} else {
					set tVal=1
				}
				set tStr=$g(tStr,"")_$lb(tVal)
			}
		}
		
		set:tSize=5 tSize=2
		set:tSize=11 tSize=3
		set tInput(tSize,$i(tInput(tSize)))=tStr
		
		
		k tStr
		set tTemp=$p(tTemp,"-",2)
		set tSize=$length(tTemp)
		for j=1:1:tSize {
			if $e(tTemp,j)'="/" {
				if $e(tTemp,j)="." {
					set tVal=0
				} else {
					set tVal=1
				}
				set tStr=$g(tStr,"")_$lb(tVal)
			}
		}
		
		set:tSize=11 tSize=2
		set:tSize=19 tSize=3
		set tTrans(tSize,$i(tTrans(tSize)))=tStr
	}
	
	set tGrid=$lb(0,1,0,0,0,1,1,1,1)
	set tSize=3
	
	for i=1:1:tIters {
		zw i
		k tTemp
		set tX=1
		set tY=1
		set tSize=$zsqr($listlength(tGrid))
		if ((tSize/2)=(tSize\2)) {
			for tX=1:2:tSize {
				for tY=1:2:tSize {
					//w tX_","_tY,!
					for j=tX-1:1:tX {
						for k=tY:1:tY+1 {
							//w (j*tSize)+k,!
							set tTemp(tX,tY)=$g(tTemp(tX,tY),"")_$lb($lg(tGrid,(j*tSize)+k))
						}
					}
				}
			}
			set tResSize=(tSize/2)*3
		} else {
			for tX=1:3:tSize {
				for tY=1:3:tSize {
					//w tX_","_tY,!
					for j=tX-1:1:tX+1 {
						for k=tY:1:tY+2 {
							//w (j*tSize)+k,!
							set tTemp(tX,tY)=$g(tTemp(tX,tY),"")_$lb($lg(tGrid,(j*tSize)+k))
						}
					}
				}
			}
			set tResSize=(tSize/3)*4
		}
		
		//break
		k tGrid
		//Check each flip and rotate
		set tXCount=0
		set X=$o(tTemp(""))
		while X'="" {
			set tYCount=0
			set Y=$o(tTemp(X,""))
			while Y'="" {
				set tCur=tTemp(X,Y)
				/*
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"r")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"h")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"v")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"v")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"h")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"v")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"v")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"r")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"h")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"v")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"v")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"h")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"v")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"v")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"r")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"h")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"v")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"v")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"h")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"v")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"v")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"r")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"h")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"v")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"v")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"h")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"v")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"v")
				*/
				
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"r")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"r")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"r")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"r")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"h")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"r")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"r")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"r")
				d:##class(AOC.Y2017).Day21Check(tCur,.tInput)=0 ##class(AOC.Y2017).Day21Eval(.tCur,"r")
				set tTransNum=##class(AOC.Y2017).Day21Check(tCur,.tInput)
				//zw tTrans
				set tCurSize=$zsqr($listlength(tCur))
				set tNextSize=tCurSize+1
				//w X_","_Y,!
				set tCount=0
				for j=Y-1+tYCount:1:Y+tNextSize-2+tYCount {
					for k=X+tXCount:1:X+tNextSize-1+tXCount {
						set tCount=tCount+1
						//w (j*tResSize)+k,!
						set $list(tGrid,(j*tResSize)+k)=$lg(tTrans(tCurSize,tTransNum),tCount)
					}
				}
				set tYCount=tYCount+1
				set Y=$o(tTemp(X,Y))
			}
			set tXCount=tXCount+1
			set X=$o(tTemp(X))
		}
		//zw tTemp
		//zw tGrid
		//break
	}
	set tRes=0
	for i=1:1:$listlength(tGrid) {
		set:$lg(tGrid,i) tRes=tRes+1
	}
	
	//zw tGrid
	
	quit tRes
}

ClassMethod Day21Eval(ByRef pTemp, pDir)
{
	//w pDir,!
	//zw pTemp
	set tSize=$zsqr($listlength(pTemp))
	if pDir="r" {
		set tTemp=""
		for i=1:1:tSize {
			for j=tSize-1:-1:0 {
				set tTemp=tTemp_$lb($lg(pTemp,(j*tSize)+i))
			}
		}
		set pTemp=tTemp
	} elseif pDir="h" {
		set tTemp=""
		for i=1:tSize:$listlength(pTemp) {
			set tTemp=tTemp_$lb($lg(pTemp,i))
		}
		for i=1:tSize:$listlength(pTemp) {
			set $list(pTemp,i)=$lg(pTemp,i+tSize-1)
		}
		set tCount=0
		for i=tSize:tSize:$listlength(pTemp) {
			set tCount=tCount+1
			set $list(pTemp,i)=$lg(tTemp,tCount)
		}
	} elseif pDir="v" {
		set tTemp=""
		for i=1:1:tSize {
			set tTemp=tTemp_$lb($lg(pTemp,i))
		}
		for i=1:1:tSize {
			set $list(pTemp,i)=$lg(pTemp,$listlength(pTemp)-tSize+i)
		}
		for i=1:1:tSize {
			set $list(pTemp,$listlength(pTemp)-tSize+i)=$lg(tTemp,i)
		}
	}
	//zw pTemp
}

ClassMethod Day21Check(tCur, ByRef tTrans) As %Boolean
{
	set tCurSize=$zsqr($listlength(tCur))
	set tPos=$o(tTrans(tCurSize,""))
	while tPos'="" {
		if tCur=tTrans(tCurSize,tPos) {
			return tPos
		}
		set tPos=$o(tTrans(tCurSize,tPos))
	}
	
	quit 0
}

ClassMethod Day21P1Bit() As %String
{
	set pInput="../..-.../.#./.#.@#./..-.../#../#..@##/..-#.#/.#./.#.@.#/#.-##./##./...@##/#.-.##/###/#..@##/##-.##/#../##.@.../.../...-.#.#/###./##.#/###.@#../.../...-#.#./..#./..../#.#.@.#./.../...-#.##/..#./.#.#/####@##./.../...-###./.#../####/##..@#.#/.../...-...#/####/#.##/...#@###/.../...-.#../..#./#..#/..#.@.#./#../...-###./.##./#.../..#.@##./#../...-#.#./...#/..../.###@..#/#../...-..../..../##../#..#@#.#/#../...-..#./#..#/.#../..##@.##/#../...-##../.#.#/.##./...#@###/#../...-..../#.../#..#/#..#@.../.#./...-##.#/#.#./#.../#..#@#../.#./...-..#./#.#./.##./....@.#./.#./...-..##/#.../..../###.@##./.#./...-.#../...#/.##./.#.#@#.#/.#./...-...#/#..#/.#../.###@###/.#./...-###./.###/##.#/#.##@.#./##./...-##.#/##../..##/..##@##./##./...-#.##/.###/.##./###.@..#/##./...-##.#/.##./..##/####@#.#/##./...-####/####/#.##/.#..@.##/##./...-####/.#../####/#..#@###/##./...-#.#./..#./###./..#.@.../#.#/...-#.../..../.#../#.##@#../#.#/...-..#./###./####/..#.@.#./#.#/...-#.##/.#../##.#/#.#.@##./#.#/...-###./.###/###./##..@#.#/#.#/...-...#/.##./.#.#/#.##@###/#.#/...-####/#.../###./###.@.../###/...-..##/#.##/.#../.#..@#../###/...-..../.###/.#.#/...#@.#./###/...-#.##/.#.#/.#.#/.##.@##./###/...-#..#/.#.#/#.##/#.#.@#.#/###/...-#.../##../#.##/##.#@###/###/...-.#../.#../.###/..#.@..#/.../#..-...#/.##./.##./####@#.#/.../#..-##.#/##../#.#./.#..@.##/.../#..-#..#/.##./####/.#..@###/.../#..-..../..../..##/..##@.##/#../#..-..##/.##./#..#/###.@###/#../#..-##.#/#..#/#.../#..#@..#/.#./#..-#..#/##.#/.##./#..#@#.#/.#./#..-.#../####/..##/#.##@.##/.#./#..-###./#..#/.##./###.@###/.#./#..-####/###./##../..##@.##/##./#..-#.../####/...#/####@###/##./#..-.#../#.##/.##./####@#../..#/#..-.#../####/#.../....@.#./..#/#..-.#.#/...#/.###/.#.#@##./..#/#..-..##/#..#/#..#/....@#.#/..#/#..-.###/.#.#/.##./#.#.@.##/..#/#..-...#/#.##/#.../..##@###/..#/#..-#.##/#.##/...#/#.##@#../#.#/#..-#..#/..##/.#../.###@.#./#.#/#..-#.##/..../.##./.#..@##./#.#/#..-#.#./..#./.#.#/.#..@..#/#.#/#..-...#/#..#/###./##..@#.#/#.#/#..-##.#/##.#/.#.#/.#..@.##/#.#/#..-#..#/#..#/##../.#..@###/#.#/#..-#.##/..##/##.#/....@#../.##/#..-##.#/.##./...#/.#.#@.#./.##/#..-.##./.###/###./.#.#@##./.##/#..-#.#./#.##/..##/.#..@#.#/.##/#..-..#./.##./..##/.#..@.##/.##/#..-##../..##/#..#/#...@###/.##/#..-###./#..#/##.#/..#.@#../###/#..-.###/#.../####/#.#.@.#./###/#..-#.#./.###/#..#/....@##./###/#..-..#./.#.#/#.../#...@..#/###/#..-...#/..#./##../#..#@#.#/###/#..-.#.#/###./.#../##..@.##/###/#..-.#../###./..#./##..@###/###/#..-.#../..##/#.../#...@.#./#.#/.#.-##.#/..../##../.#..@##./#.#/.#.-#.../#.##/.###/#.##@#.#/#.#/.#.-...#/..##/##.#/#.##@###/#.#/.#.-...#/.#.#/###./#..#@.#./###/.#.-...#/...#/##../#.##@##./###/.#.-###./###./.#.#/..##@#.#/###/.#.-..../#..#/..##/#..#@###/###/.#.-.#.#/.#.#/##../.###@#.#/..#/##.-.##./..#./##../....@###/..#/##.-####/...#/.#.#/#...@.##/#.#/##.-..#./...#/###./.#..@###/#.#/##.-..../.#../.#../#.#.@#.#/.##/##.-.##./..../#.../.#.#@###/.##/##.-..../#..#/...#/#...@.##/###/##.-#.##/##.#/#.../..#.@###/###/##.-.#../.###/###./##.#@#.#/.../#.#-.#.#/..../#..#/.#..@###/.../#.#-##../#.##/##.#/..#.@###/#../#.#-.#.#/..../.#.#/.###@#.#/.#./#.#-...#/..../##.#/#...@###/.#./#.#-####/.###/#.#./#.##@###/##./#.#-#..#/.###/...#/###.@#.#/#.#/#.#-#.##/...#/.###/.##.@###/#.#/#.#-#.../.#.#/.#.#/.###@#.#/###/#.#-##.#/##../###./#...@###/###/#.#-.##./.###/.#../..##@###/#.#/###-#.##/###./#..#/#..#@###/###/###-#.../..../#..#/#..."
	//set pInput="../.#-##./#../...@.#./..#/###-#..#/..../..../#..#"
	set tIters=18
	for i=1:1:$length(pInput,"@") {
		k tStr
		set tTemp=$piece(pInput,"@",i)
		set tSize=$length($p(tTemp,"-",1))
		for j=1:1:tSize {
			if $e(tTemp,j)'="/" {
				if $e(tTemp,j)="." {
					set tVal=0
				} else {
					set tVal=1
				}
				set $bit(tStr,$bitcount(tStr)+1)=tVal
			}
		}
		
		set:tSize=5 tSize=2
		set:tSize=11 tSize=3
		set tInput(tSize,$i(tInput(tSize)))=tStr
		
		
		k tStr
		set tTemp=$p(tTemp,"-",2)
		set tSize=$length(tTemp)
		for j=1:1:tSize {
			if $e(tTemp,j)'="/" {
				if $e(tTemp,j)="." {
					set tVal=0
				} else {
					set tVal=1
				}
				set $bit(tStr,$bitcount(tStr)+1)=tVal
			}
		}
		
		set:tSize=11 tSize=2
		set:tSize=19 tSize=3
		set tTrans(tSize,$i(tTrans(tSize)))=tStr
	}
	
	set $bit(tGrid(0),1)=0
	set $bit(tGrid(0),2)=1
	set $bit(tGrid(0),3)=0
	set $bit(tGrid(0),4)=0
	set $bit(tGrid(0),5)=0
	set $bit(tGrid(0),6)=1
	set $bit(tGrid(0),7)=1
	set $bit(tGrid(0),8)=1
	set $bit(tGrid(0),9)=1
	set tSize=3
	
	for i=1:1:tIters {
		zw i
		k tTemp
		set tX=1
		set tY=1
		set tSize=0
		set n=$o(tGrid(""))
		while n'="" {
			set tSize=tSize+$bitcount(tGrid(n))
			set n=$o(tGrid(n))
		}
		set tSize=$zsqr(tSize)
		if ((tSize/2)=(tSize\2)) {
			for tX=1:2:tSize {
				for tY=1:2:tSize {
					//w tX_","_tY,!
					for j=tX-1:1:tX {
						for k=tY:1:tY+1 {
							//w (j*tSize)+k,!
							set n=(j*tSize)+k
							set $bit(tTemp(tX,tY),$bitcount(tTemp(tX,tY))+1)=$bit(tGrid(n\250000),n-((n\250000)*250000)+$select(n>=250000:1,1:0))
						}
					}
				}
			}
			set tResSize=(tSize/2)*3
		} else {
			for tX=1:3:tSize {
				for tY=1:3:tSize {
					//w tX_","_tY,!
					for j=tX-1:1:tX+1 {
						for k=tY:1:tY+2 {
							//w (j*tSize)+k,!
							set n=(j*tSize)+k
							set $bit(tTemp(tX,tY),$bitcount(tTemp(tX,tY))+1)=$bit(tGrid(n\250000),n-((n\250000)*250000)+$select(n>=250000:1,1:0))
						}
					}
				}
			}
			set tResSize=(tSize/3)*4
		}
		
		//break
		k tGrid
		//Check each flip and rotate
		set tXCount=0
		set X=$o(tTemp(""))
		while X'="" {
			set tYCount=0
			set Y=$o(tTemp(X,""))
			while Y'="" {
				set tCur=tTemp(X,Y)
				
				d:##class(AOC.Y2017).Day21CheckBit(tCur,.tInput)=0 ##class(AOC.Y2017).Day21EvalBit(.tCur,"r")
				d:##class(AOC.Y2017).Day21CheckBit(tCur,.tInput)=0 ##class(AOC.Y2017).Day21EvalBit(.tCur,"r")
				d:##class(AOC.Y2017).Day21CheckBit(tCur,.tInput)=0 ##class(AOC.Y2017).Day21EvalBit(.tCur,"r")
				d:##class(AOC.Y2017).Day21CheckBit(tCur,.tInput)=0 ##class(AOC.Y2017).Day21EvalBit(.tCur,"r")
				d:##class(AOC.Y2017).Day21CheckBit(tCur,.tInput)=0 ##class(AOC.Y2017).Day21EvalBit(.tCur,"h")
				d:##class(AOC.Y2017).Day21CheckBit(tCur,.tInput)=0 ##class(AOC.Y2017).Day21EvalBit(.tCur,"r")
				d:##class(AOC.Y2017).Day21CheckBit(tCur,.tInput)=0 ##class(AOC.Y2017).Day21EvalBit(.tCur,"r")
				d:##class(AOC.Y2017).Day21CheckBit(tCur,.tInput)=0 ##class(AOC.Y2017).Day21EvalBit(.tCur,"r")
				d:##class(AOC.Y2017).Day21CheckBit(tCur,.tInput)=0 ##class(AOC.Y2017).Day21EvalBit(.tCur,"r")
				
				set tCount=0
				set tTransNum=##class(AOC.Y2017).Day21CheckBit(tCur,.tInput)
				//zw tTrans
				set tCurSize=$zsqr($bitcount(tCur))
				set tNextSize=tCurSize+1
				//w X_","_Y,!
				for j=X-1+tXCount:1:X+tNextSize-2+tXCount {
					for k=Y+tYCount:1:Y+tNextSize-1+tYCount {
						set tCount=tCount+1
						//w (j*tResSize)+k,!
						set n=(j*tResSize)+k
						//w n,!
						//w:$bit(tTrans(tCurSize,tTransNum),tCount)=0 "."
						//w:$bit(tTrans(tCurSize,tTransNum),tCount)=1 "#"
						set $bit(tGrid(n\250000),n-((n\250000)*250000)+$select(n>=250000:1,1:0))=$bit(tTrans(tCurSize,tTransNum),tCount)
					}
				}
				//w !
				//break
				set tYCount=tYCount+1
				set Y=$o(tTemp(X,Y))
			}
			set tXCount=tXCount+1
			set X=$o(tTemp(X))
		}
		
		//break
		
		set tRes=0
		set n=$o(tGrid(""))
		while n'="" {
			w "n "_n_": "_$bitcount(tGrid(n),1),!
			w "n "_n_" total: "_$bitcount(tGrid(n)),!
			set tRes=tRes+$bitcount(tGrid(n),1)
			set n=$o(tGrid(n))
		}
		//zw tTemp
		//zw tGrid
		//break
	}
	set tRes=0
	set n=$o(tGrid(""))
	while n'="" {
		w "n "_n_": "_$bitcount(tGrid(n),1),!
		w "n "_n_" total: "_$bitcount(tGrid(n)),!
		set tRes=tRes+$bitcount(tGrid(n),1)
		set n=$o(tGrid(n))
	}
	quit tRes
}

ClassMethod Day21EvalBit(ByRef pTemp, pDir)
{
	//w pDir,!
	//zw pTemp
	set tSize=$zsqr($bitcount(pTemp))
	if pDir="r" {
		set tTemp=""
		for i=1:1:tSize {
			for j=tSize-1:-1:0 {
				set $bit(tTemp,$bitcount(tTemp)+1)=$bit(pTemp,(j*tSize)+i)
			}
		}
		set pTemp=tTemp
	} elseif pDir="h" {
		set tTemp=""
		for i=1:tSize:$bitcount(pTemp) {
			set $bit(tTemp,$bitcount(tTemp)+1)=$bit(pTemp,i)
		}
		for i=1:tSize:$bitcount(pTemp) {
			set $bit(pTemp,i)=$bit(pTemp,i+tSize-1)
		}
		set tCount=0
		for i=tSize:tSize:$bitcount(pTemp) {
			set tCount=tCount+1
			set $bit(pTemp,i)=$bit(tTemp,tCount)
		}
	} elseif pDir="v" {
		set tTemp=""
		for i=1:1:tSize {
			set $bit(tTemp,$bitcount(tTemp)+1)=$bit(pTemp,i)
		}
		for i=1:1:tSize {
			set $bit(pTemp,i)=$bit(pTemp,$bitcount(pTemp)-tSize+i+1)
		}
		for i=1:1:tSize {
			set $bit(pTemp,$bitcount(pTemp)-tSize+i+1)=$bit(tTemp,i)
		}
	}
	//zw pTemp
}

ClassMethod Day21CheckBit(tCur, ByRef tTrans) As %Boolean
{
	set tCurSize=$zsqr($bitcount(tCur))
	//zw tCurSize
	set tPos=$o(tTrans(tCurSize,""))
	while tPos'="" {
		//zw tCur
		//zw tTrans(tCurSize,tPos)
		if tCur=tTrans(tCurSize,tPos) {
			return tPos
		}
		set tPos=$o(tTrans(tCurSize,tPos))
	}
	
	quit 0
}

ClassMethod Day22P1() As %String
{
	set pInput="#.#...###.#.##.#....##.##@..####.#.######....#....#@###..###.#.###.##.##..#.#@...##.....##.###.##.###..@....#...##.##..#....###..@##.#..###.#.###......####@#.#.###...###..#.#.#.#.#.@###...##..##..#..##......@##.#.####.#..###....#.###@.....#..###....######..##@.##.#.###....#..#####..#.@########...##.##....##..#@.#.###.##.#..#..#.#..##..@.#.##.##....##....##.#.#.@..#.#.##.#..##..##.#..#.#@.####..#..#.###..#..#..#.@#.#.##......##..#.....###@...####...#.#.##.....####@#..##..##..#.####.#.#..#.@#...###.##..###..#..#....@#..#....##.##.....###..##@#..##...#...##...####..#.@#.###..#.#####.#..#..###.@###.#...#.##..#..#...##.#@.#...#..#.#.#.##.####...."
	//set pInput="..#@#..@..."
	set tLen=$length(pInput,"@")\2
	for i=-tLen:1:tLen {
		set tTemp=$p(pInput,"@",i+tLen+1)
		for j=-tLen:1:tLen {
			set tArray(i,j)=$e(tTemp,j+tLen+1)
		}
	}
	
	set tDir="u"
	set tPosX=0
	set tPosY=0
	set tCount=0
	
	for i=1:1:10000 {
		if $g(tArray(tPosY,tPosX),".")="#" {
			set tDir=$select(tDir="u":"r",tDir="r":"d",tDir="d":"l",1:"u")
		} else {
			set tDir=$select(tDir="u":"l",tDir="l":"d",tDir="d":"r",1:"u")
		}
		if $g(tArray(tPosY,tPosX),".")="#" {
			set tArray(tPosY,tPosX)="."
		} else {
			set tCount=tCount+1
			set tArray(tPosY,tPosX)="#"
		}
		if tDir="u" {
			set tPosY=tPosY-1
		} elseif tDir="r" {
			set tPosX=tPosX+1
		} elseif tDir="l" {
			set tPosX=tPosX-1
		} else {
			set tPosY=tPosY+1
		}
	}
	
	
	quit tCount
}

ClassMethod Day22P2() As %String
{
	set pInput="#.#...###.#.##.#....##.##@..####.#.######....#....#@###..###.#.###.##.##..#.#@...##.....##.###.##.###..@....#...##.##..#....###..@##.#..###.#.###......####@#.#.###...###..#.#.#.#.#.@###...##..##..#..##......@##.#.####.#..###....#.###@.....#..###....######..##@.##.#.###....#..#####..#.@########...##.##....##..#@.#.###.##.#..#..#.#..##..@.#.##.##....##....##.#.#.@..#.#.##.#..##..##.#..#.#@.####..#..#.###..#..#..#.@#.#.##......##..#.....###@...####...#.#.##.....####@#..##..##..#.####.#.#..#.@#...###.##..###..#..#....@#..#....##.##.....###..##@#..##...#...##...####..#.@#.###..#.#####.#..#..###.@###.#...#.##..#..#...##.#@.#...#..#.#.#.##.####...."
	//set pInput="..#@#..@..."
	set tLen=$length(pInput,"@")\2
	for i=-tLen:1:tLen {
		set tTemp=$p(pInput,"@",i+tLen+1)
		for j=-tLen:1:tLen {
			set tArray(i,j)=$e(tTemp,j+tLen+1)
		}
	}
	
	set tDir="u"
	set tPosX=0
	set tPosY=0
	set tCount=0
	
	for i=1:1:10000000 {
		if $g(tArray(tPosY,tPosX),".")="#" {
			set tDir=$select(tDir="u":"r",tDir="r":"d",tDir="d":"l",1:"u")
		} elseif $g(tArray(tPosY,tPosX),".")="." {
			set tDir=$select(tDir="u":"l",tDir="l":"d",tDir="d":"r",1:"u")
		} elseif $g(tArray(tPosY,tPosX),".")="F" {
			set tDir=$select(tDir="u":"d",tDir="l":"r",tDir="d":"u",1:"l")
		}
		
		if $g(tArray(tPosY,tPosX),".")="#" {
			set tArray(tPosY,tPosX)="F"
		} elseif $g(tArray(tPosY,tPosX),".")="." {
			set tArray(tPosY,tPosX)="W"
		} elseif $g(tArray(tPosY,tPosX),".")="W" {
			set tCount=tCount+1
			set tArray(tPosY,tPosX)="#"
		}  elseif $g(tArray(tPosY,tPosX),".")="F" {
			set tArray(tPosY,tPosX)="."
		}
		if tDir="u" {
			set tPosY=tPosY-1
		} elseif tDir="r" {
			set tPosX=tPosX+1
		} elseif tDir="l" {
			set tPosX=tPosX-1
		} else {
			set tPosY=tPosY+1
		}
	}
	
	
	quit tCount
}

ClassMethod Day23P1() As %Status
{
	set pInput = "set b 81@set c b@jnz a 2@jnz 1 5@mul b 100@sub b -100000@set c b@sub c -17000@set f 1@set d 2@set e 2@set g d@mul g e@sub g b@jnz g 2@set f 0@sub e -1@set g e@sub g b@jnz g -8@sub d -1@set g d@sub g b@jnz g -13@jnz f 2@sub h -1@set g b@sub g c@jnz g 2@jnz 1 3@sub b -17@jnz 1 -23"
	
	set tRes=0
	for i=1:1:$length(pInput,"@") {

		set tCmd=$p(pInput,"@",i)
		set tReg=$piece(tCmd," ",2)
		set tVal=$piece(tCmd," ",3)
		
		if (tVal'="") && (tVal'=(+tVal)) {
			set tVal=$g(tArray(tVal))
		}
		if $e(tCmd,1,3)="set" {
			set tArray(tReg)=tVal
		} elseif $e(tCmd,1,3)="sub" {
			set tArray(tReg)=$g(tArray(tReg))-tVal
		} elseif $e(tCmd,1,3)="mul" {
			set tRes=tRes+1
			set tArray(tReg)=$g(tArray(tReg))*tVal
		} elseif $e(tCmd,1,3)="jnz" {
			set tTemp=tReg
			if (tReg'="") && (tReg'=(+tReg)) {
				set tTemp=$g(tArray(tReg),0)
			}
			if tTemp'=0 {
				set i=i+tVal-1
			}
		}
	}
	quit tRes
}

ClassMethod Day24P1(pInput = "") As %Status
{
	set:pInput="" pInput = "42/37@28/28@29/25@45/8@35/23@49/20@44/4@15/33@14/19@31/44@39/14@25/17@34/34@38/42@8/42@15/28@0/7@49/12@18/36@45/45@28/7@30/43@23/41@0/35@18/9@3/31@20/31@10/40@0/22@1/23@20/47@38/36@15/8@34/32@30/30@30/44@19/28@46/15@34/50@40/20@27/39@3/14@43/45@50/42@1/33@6/39@46/44@22/35@15/20@43/31@23/23@19/27@47/15@43/43@25/36@26/38@1/10"
	
	set tMax=0
	for i=1:1:$length(pInput,"@") {
		set tPiece=$piece(pInput,"@",i)
		set tPieces(tPiece)=""
	}
	
	//zw tPieces
	
	set tPiece=$o(tPieces(""))
	while tPiece["0/" {
		set tNext=$p(tPiece,"/",2)
		merge tTemp=tPieces
		set tRes=##class(AOC.Y2017).Day24Recurse(.tTemp,tPiece,tNext)
		set:tMax<tRes tMax=tRes
		set tPiece=$o(tPieces(tPiece))	
	}
	quit tMax
}

ClassMethod Day24Recurse(ByRef pPieces, pCurrent, pNext) As %String
{
	k pPieces(pCurrent)
	set tMax=0
	set tPiece=$o(pPieces(""))
	while tPiece'="" {
		//zw pCurrent
		//zw pNext
		//zw tPiece
		if ($piece(tPiece,"/",2)=pNext) || ($piece(tPiece,"/",1)=pNext) {
			//w "match",!
			if $piece(tPiece,"/",2)=pNext {
				set tNext=$piece(tPiece,"/",1)
			} else {
				set tNext=$piece(tPiece,"/",2)
			}
			merge tTemp=pPieces
			set tRes=##class(AOC.Y2017).Day24Recurse(.tTemp,tPiece,tNext)
			if tMax<tRes {
				set tMax=tRes
				//w "new max",!
				//zw tMax
				//zw tPiece
			}
		}
		set tPiece=$o(pPieces(tPiece))
	}
	//w "quitting ",!
	//zw tMax
	//zw pCurrent
	quit tMax+$piece(pCurrent,"/",1)+$piece(pCurrent,"/",2)
}

ClassMethod Day24P2(pInput = "") As %Status
{
	set:pInput="" pInput = "42/37@28/28@29/25@45/8@35/23@49/20@44/4@15/33@14/19@31/44@39/14@25/17@34/34@38/42@8/42@15/28@0/7@49/12@18/36@45/45@28/7@30/43@23/41@0/35@18/9@3/31@20/31@10/40@0/22@1/23@20/47@38/36@15/8@34/32@30/30@30/44@19/28@46/15@34/50@40/20@27/39@3/14@43/45@50/42@1/33@6/39@46/44@22/35@15/20@43/31@23/23@19/27@47/15@43/43@25/36@26/38@1/10"
	
	set tMax=0
	for i=1:1:$length(pInput,"@") {
		set tPiece=$piece(pInput,"@",i)
		set tPieces(tPiece)=""
	}
	
	//zw tPieces
	
	set tMaxDepth=0
	set tPiece=$o(tPieces(""))
	set pDepth=1
	while $piece(tPiece,"/",1)=0 {
		set tNext=$p(tPiece,"/",2)
		merge tTemp=tPieces
		set tDepth=pDepth
		set tRes=##class(AOC.Y2017).Day24Recurse2(.tTemp,tPiece,tNext,.tDepth)
		if (tMaxDepth<tDepth) {
			set tMax=tRes
			set tMaxDepth=tDepth
		} elseif tMaxDepth=tDepth && (tMax<tRes) {
			set tMax=tRes
		}
		set tPiece=$o(tPieces(tPiece))	
	}
	quit tMax
}

ClassMethod Day24Recurse2(ByRef pPieces, pCurrent, pNext, ByRef pDepth) As %String
{
	k pPieces(pCurrent)
	set tMax=0
	set tMaxDepth=pDepth
	set tPiece=$o(pPieces(""))
	while tPiece'="" {
		set tDepth=pDepth+1
		//zw pCurrent
		//zw pNext
		//zw tPiece
		if ($piece(tPiece,"/",2)=pNext) || ($piece(tPiece,"/",1)=pNext) {
			//w "match",!
			if $piece(tPiece,"/",2)=pNext {
				set tNext=$piece(tPiece,"/",1)
			} else {
				set tNext=$piece(tPiece,"/",2)
			}
			merge tTemp=pPieces
			//zw tDepth
			//zw tTemp
			set tRes=##class(AOC.Y2017).Day24Recurse2(.tTemp,tPiece,tNext,.tDepth)
			//zw tRes
			//zw tDepth
			//zw tTemp
			if (tMaxDepth<tDepth) {
				set tMax=tRes
				set tMaxDepth=tDepth
				//w "new max",!
				//zw tMax
				//zw tPiece
			} elseif (tMaxDepth=tDepth) && (tMax<tRes) {
				set tMax=tRes
			}
		}
		set tPiece=$o(pPieces(tPiece))
	}
	//w "quitting ",!
	//zw tMax
	//zw pCurrent
	set pDepth=tMaxDepth
	quit tMax+$piece(pCurrent,"/",1)+$piece(pCurrent,"/",2)
}

ClassMethod Day25P1(pInput = "") As %String
{
	set $zs=268321696*2*1024
	set tState="A"
	set tPos=0
	for i=1:1:12794428 {
		if tState="A" {
			if $g(tArray(tPos),0)=0 {
				set tArray(tPos)=1
				set tPos=tPos+1
				set tState="B"
			} else {
				set tArray(tPos)=0
				set tPos=tPos-1
				set tState="F"
			}
		} elseif tState="B" {
			if $g(tArray(tPos),0)=0 {
				set tArray(tPos)=0
				set tPos=tPos+1
				set tState="C"
			} else {
				set tArray(tPos)=0
				set tPos=tPos+1
				set tState="D"
			}
		} elseif tState="C" {
			if $g(tArray(tPos),0)=0 {
				set tArray(tPos)=1
				set tPos=tPos-1
				set tState="D"
			} else {
				set tArray(tPos)=1
				set tPos=tPos+1
				set tState="E"
			}
		} elseif tState="D" {
			if $g(tArray(tPos),0)=0 {
				set tArray(tPos)=0
				set tPos=tPos-1
				set tState="E"
			} else {
				set tArray(tPos)=0
				set tPos=tPos-1
				set tState="D"
			}
		} elseif tState="E" {
			if $g(tArray(tPos),0)=0 {
				set tArray(tPos)=0
				set tPos=tPos+1
				set tState="A"
			} else {
				set tArray(tPos)=1
				set tPos=tPos+1
				set tState="C"
			}
		} elseif tState="F" {
			if $g(tArray(tPos),0)=0 {
				set tArray(tPos)=1
				set tPos=tPos-1
				set tState="A"
			} else {
				set tArray(tPos)=1
				set tPos=tPos+1
				set tState="A"
			}
		}
	}
	
	set tRes=0
	set tPos=$o(tArray(""))
	while tPos'="" {
		if $g(tArray(tPos),0)=1 {
			set tRes=tRes+1
		}
		set tPos=$o(tArray(tPos))
	}
	quit tRes
}

}
