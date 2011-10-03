CRHD1 ; CAIRO/CLC - ADDED TO WORK WITH HAND OFF TEAM SECTION ;04-Mar-2008 16:00;CLC
 ;;1.0;CRHD;****;Jan 28, 2008;Build 19
 ;=================================================================
DELENTS(CRHDRTN,CRHDTM,CRHDTY,CRHDP) ;
 ;delete a Hand off patient, provider, or team
 N DA,DIK
 K CRHDRTN
 S CRHDRTN=0
 N CRHDPIEN,CRHDN
 S CRHDN=$S(CRHDTY="P":1,1:2)
 S CRHDPIEN=$O(^CRHD(183.3,+CRHDTM,+CRHDN,"B",+CRHDP,0))
 I CRHDPIEN S DIK="^CRHD(183.3,"_+CRHDTM_","_+CRHDN_",",DA(1)=+CRHDTM,DA=CRHDPIEN D ^DIK S CRHDRTN=1
 Q
HOTMMGR(CRHDRTN,DUZ) ;
 N CRHDKN,CRHDKEYS,CRHDOUT
 S CRHDRTN=0
 S CRHDKN=$$FIND1^DIC(19.1,"","X","CRHD HOT TEAM MGR","","","OUT")
 D GETS^DIQ(200,DUZ_",","51*","I","CRHDOUT")
 I CRHDKN>0 S CRHDRTN=$D(CRHDOUT(200.051,+CRHDKN_","_DUZ_","))
 Q
HOTMMEM(CRHDRTN,CRHDTM,CRHDFRM,CRHDDIR,CRHDPFG) ;
 ;Return a set of providers from the HOT Team list.
 ;CRHDPFG - only return providers who have patients assigned to them
 N CRHDPLST,CRHDN,CRHDMAX,CRHDORI,CRHDTL,CRHDPATS
 K CRHDRTN
 S CRHDRTN=""
 I '$G(CRHDDIR) S CRHDDIR=1
 S CRHDORI=0,CRHDMAX=44
 I $G(CRHDPFG) D PP G NX
 D HODLIST^CRHD9(.CRHDPLST,CRHDTM)
 I $D(CRHDPLST) D
 .S CRHDN=0
 .F  S CRHDN=$O(CRHDPLST(CRHDN)) Q:'CRHDN  D
 ..S CRHDTL($P(CRHDPLST(CRHDN),"^",2))=CRHDPLST(CRHDN)
NX I CRHDFRM'="",$D(CRHDTL(CRHDFRM)) S CRHDFRM=$E(CRHDFRM,1,$L(CRHDFRM)-1)
 S CRHDN=CRHDFRM
 F  Q:CRHDORI'<CRHDMAX  S CRHDN=$O(CRHDTL(CRHDN),CRHDDIR) Q:CRHDN=""  D
 .S CRHDORI=CRHDORI+1,CRHDRTN(CRHDORI)=CRHDTL(CRHDN)
 Q
PP ;
 N CRHDPATS,CRHDX
 K CRHDPATS D HOTPRVPT(.CRHDPATS,CRHDTM,"")
 I $D(CRHDPATS) D
 .S CRHDX=0
 .F  S CRHDX=$O(CRHDPATS(CRHDX)) Q:'CRHDX  D
 ..S:'$D(CRHDTL($P(CRHDPATS(CRHDX),"^",1))) CRHDTL($P(CRHDPATS(CRHDX),"^",1))=$P(CRHDPATS(CRHDX),"^",2)_"^"_$P(CRHDPATS(CRHDX),"^",1)
 Q
HOTMMEMS(CRHDRTN,CRHDTM,CRHDFRM,CRHDDIR,CRHDCLAS) ;
 ;Return a subset of HO Team list
 ;CRHDCLAS
 ;    ATTN:ATTENDING
 ;    RES:RESIDENT
 ;    INTERN:INTERN
 ;    FELLOW:FELLOW
 ;    STUD:MED STUDENT
 N CRHDPLST,CRHDN,CRHDMAX,CRHDORI,CRHDTL
 K CRHDRTN
 I '$G(CRHDDIR) S CRHDDIR=1
 S CRHDORI=0,CRHDMAX=44
 D HOTMMEM(.CRHDPLST,CRHDTM,CRHDFRM,CRHDDIR)
 I $D(CRHDPLST) D
 .S CRHDN=0
 .F  S CRHDN=$O(CRHDPLST(CRHDN)) Q:'CRHDN  D
 ..I $G(CRHDCLAS)'="" I $P(CRHDPLST(CRHDN),"^",3)=CRHDCLAS S CRHDTL($P(CRHDPLST(CRHDN),"^",2))=CRHDPLST(CRHDN)
 ..I $G(CRHDCLAS)="" S CRHDTL($P(CRHDPLST(CRHDN),"^",2))=CRHDPLST(CRHDN)
 F  Q:CRHDORI'<CRHDMAX  S CRHDN=$O(CRHDTL(CRHDN),CRHDDIR) Q:CRHDN=""  D
 .S CRHDORI=CRHDORI+1,CRHDRTN(CRHDORI)=CRHDTL(CRHDN)
 Q
HOTPRVPT(CRHDRTN,CRHDTM,CRHDPRV) ;
 ;return list of patients from the HO team list provider
 K CRHDRTN
 N CRHDPLST,CRHDORI,CRHDMAX,CRHDP,CRHDTMPL,CRHDCT,CRHDI,CRHDN,CRHDNN,CRHDNNN
 S CRHDORI=0,CRHDMAX=44
 D HOPLIST^CRHD9(.CRHDPLST,CRHDTM)
 I $D(CRHDPLST) D
 .S CRHDN=0,CRHDCT=0
 .F  S CRHDN=$O(CRHDPLST(CRHDN)) Q:'CRHDN  D
 ..S CRHDP=$P(CRHDPLST(CRHDN),"*",2)
 ..F CRHDI=2:1:$L(CRHDP,";") I +$P(CRHDP,";",CRHDI) D
 ...I +CRHDPRV I +CRHDPRV=+$P(CRHDP,";",CRHDI) S CRHDCT=CRHDCT+1,CRHDTMPL($P($P(CRHDP,";",CRHDI),"^",2),+$P(CRHDP,";",CRHDI),CRHDCT)=$P(CRHDPLST(CRHDN),"*",1) Q
 ...I 'CRHDPRV S CRHDCT=CRHDCT+1,CRHDTMPL($P($P(CRHDP,";",CRHDI),"^",2),+$P(CRHDP,";",CRHDI),CRHDCT)=$P(CRHDPLST(CRHDN),"*",1)
 I $D(CRHDTMPL) D
 .S CRHDN=""
 .F  Q:CRHDORI'<CRHDMAX  S CRHDN=$O(CRHDTMPL(CRHDN)) Q:CRHDN=""  D
 ..S CRHDNN=0
 ..F  S CRHDNN=$O(CRHDTMPL(CRHDN,CRHDNN)) Q:'CRHDNN  D
 ...S CRHDNNN=0
 ...F  S CRHDNNN=$O(CRHDTMPL(CRHDN,CRHDNN,CRHDNNN)) Q:'CRHDNNN  D
 ....S CRHDORI=CRHDORI+1,CRHDRTN(CRHDORI)=CRHDN_"^"_CRHDNN_"^"_CRHDTMPL(CRHDN,CRHDNN,CRHDNNN)
 Q