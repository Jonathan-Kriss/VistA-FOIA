PRSECAL ;HISC/MH-CALENDAR OF CLASSES BY SERVICE AND DATE ;9/17/1998
 ;;4.0;PAID;**44**;Sep 21, 1995
EN1 ;ENTRY POINT FOR PRSE-CAL
 S X=$G(^PRSE(452.7,1,"OFF")) I X=""!(X=1) D MSG6^PRSEMSG Q
 D EN2^PRSEUTL3($G(DUZ)) I PRSESER=""&'(DUZ(0)="@") D MSG3^PRSEMSG G Q
 S (PRSECAL,NQ,NQT,NSW1,NPC,NOUT,PSPC,PSP)=0,NSW2=1
 D DATSEL^PRSEUTL G Q:$G(POUT) D SRT^PRSEUTL1 G Q:$G(POUT)
 I $$EN4^PRSEUTL3($G(DUZ))!(DUZ(0)["@") D EN3^PRSEUTL1 G Q:$G(POUT)
 I $G(PSP)=0,$G(PSPC)=0 S PSPC=PRSESER("TX")
 W ! S ZTRTN="START^PRSECAL" D L,DEV^PRSEUTL G:POP!($D(ZTSK)) Q
START ;
 K ^TMP("PRSE",$J)
 S PRSE132=$S(IOM'<132:1,1:0)
 F DA=0:0 S DA=$O(^PRSE(452.8,DA)) Q:DA'>0  I $P($G(^PRSE(452.8,DA,0)),U,21)'=""!(DUZ(0)="@") D SORT
 S X=$O(^TMP("PRSE",$J,0)) I X="" D NHDR W !,"THERE IS NO DATA FOR THIS REPORT" G QUIT
 D NPRINT
QUIT ;
Q K ^TMP("PRSE",$J) D CLOSE^PRSEUTL,^PRSEKILL
 Q
NPRINT ;
NO S PRSESP1="" F I=0:0 S PRSESP1=$O(^TMP("PRSE",$J,"L",PRSESP1)) Q:PRSESP1=""  D NP Q:NQT
 Q
NP S PRSESP2="" F  S PRSESP2=$O(^TMP("PRSE",$J,"L",PRSESP1,PRSESP2)) Q:PRSESP2=""  S NSORT=$G(^TMP("PRSE",$J,"L",PRSESP1,PRSESP2)) D:NSORT NP1 Q:NQT
 Q
NP1 S PRSETYP="" F  S PRSETYP=$O(^TMP("PRSE",$J,"L1",NSORT,PRSETYP)) Q:PRSETYP=""  D NQ Q:NQT
 Q
NQ S PRSELNG=0 F  S PRSELNG=$O(^TMP("PRSE",$J,"L1",NSORT,PRSETYP,PRSELNG)) Q:PRSELNG'>0  D NR Q:NQT
 Q
NR S PRSELOC="" F  S PRSELOC=$O(^TMP("PRSE",$J,"L1",NSORT,PRSETYP,PRSELNG,PRSELOC)) Q:PRSELOC=""  D NS Q:NQT
 Q
NS S PRSESVC="" F  S PRSESVC=$O(^TMP("PRSE",$J,"L1",NSORT,PRSETYP,PRSELNG,PRSELOC,PRSESVC)) Q:PRSESVC=""  D NPPRINT Q:NQT
 Q
NPPRINT I ($Y>(IOSL-9)!('NSW1)) D NHDR Q:NQT
 S Y=$S(PRSESEL="D":PRSESP1,PRSESEL="C":PRSESP2,1:0)
 S Y=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)_$S((+$P(Y,".",2)>0):"@"_$P(Y,".",2),1:"") I +$P(Y,"@",2)>0 S $P(Y,"@",2)=$S($P(Y,"@",2)?2N:$P(Y,"@",2)_"00",$P(Y,"@",2)?1N:$P(Y,"@",2)_"0",$P(Y,"@",2)?3N:$P(Y,"@",2)_"0",1:$P(Y,"@",2))
 I PRSE132 D
 . I PRSESEL="D" W:Y'="" !,Y W:'(PRSESP2="  BLANK") ?19,$E(PRSESP2,1,36)
 . I PRSESEL="C" W:PRSESP2'="  BLANK" !,$E(PRSESP1,1,36) W:'(Y="") ?40,Y
 . W:PRSELNG'="  BLANK" ?58,PRSELNG
 . W:PRSETYP'="  BLANK" ?68,PRSETYP
 . W:PRSELOC'="  BLANK" ?73,$E(PRSELOC,1,25)
 . W:PRSESVC'="  BLANK" ?101,PRSESVC
 . Q
 E  D
 . I PRSESEL="D" W:Y'="" !,Y W:'(PRSESP2="  BLANK") ?14,$E(PRSESP2,1,19)
 . I PRSESEL="C" W:PRSESP2'="  BLANK" !,$E(PRSESP1,1,19) W:'(Y="") ?24,Y
 . W:PRSETYP'="" ?38,PRSETYP
 . W:PRSELNG'="  BLANK" ?42,PRSELNG
 . W:PRSELOC'="  BLANK" ?48,$E(PRSELOC,1,15)
 . W:PRSESVC'="  BLANK" ?64,$E(PRSESVC,1,15)
 . Q
 Q
NHDR I 'NOUT I 'NQ,NSW1,$E(IOST)="C" D ENDPG^PRSEUTL S NQT=+POUT Q:NQT
 S NPC=NPC+1,NSW1=1 W:$E(IOST)="C"!(NPC>1) @IOF S X="T" D ^%DT D:+Y D^DIQ
 I PRSE132 D
 . W Y,?52,"CLASS REGISTRATION CALENDAR",?120,"PAGE: ",NPC,!!
 . W:PRSESEL="D" "START DATE",?19,"CLASS TITLE"
 . W:PRSESEL="C" "CLASS TITLE",?40,"START DATE"
 . W ?58,"LENGTH",?66,"TYPE",?73,"LOCATION",?101,"SERVICE",!
 . Q
 E  D
 . W Y,?26,"CLASS REGISTRATION CALENDAR",?68,"PAGE: ",NPC,!!
 . W:PRSESEL="D" "START DATE",?14,"CLASS TITLE",?35,"TYPE"
 . W:PRSESEL="C" "CLASS TITLE",?22,"START DATE",?35,"TYPE"
 . W ?40,"LENGTH",?48,"LOCATION",?64,"SERVICE",!
 . Q
 S NI="",$P(NI,"-",$S(PRSE132:133,1:81))="" W NI,!
 Q
L F X="PRSECLS","PRSESEL","PRSESER","NSW2","NOUT","NQ","NQT","NSW1","PSPC","NPC","PSP" S ZTSAVE(X)=""
 Q
SORT ; SORT SERVICE DATA
 W:$E(IOST,1,2)="C-"&('$R(100)) "."
 S N0=$P($G(^PRSE(452.8,+DA,0)),U),DATA=$G(^PRSE(452.1,+N0,0))
 ;I $P(DATA,U,8)'=PRSESER&$P(DATA,U,9)!($G(DATA)="") Q
 I PRSESEL="C" S PRSESP1=$S($D(^PRSE(452.1,+N0,0)):$P($G(^(0)),U),1:"  BLANK")
 I PRSESEL="D" S PRSESP2=$S($D(^PRSE(452.1,+N0,0)):$P($G(^(0)),U),1:"  BLANK")
 S PRSELNG=$S('($P($G(^PRSE(452.8,DA,0)),U,18)=""):$P(^(0),U,18),1:"  BLANK"),PRSETYP=$S('($P($G(^(0)),U,5)=""):$P(^(0),U,5),1:"  BLANK")
 S N1=$P($G(^PRSE(452.8,DA,0)),U,21),PRSESVC=$S($D(^PRSP(454.1,+N1,0)):$P($G(^(0)),U),1:"  BLANK")
 I '$G(PSP),PRSESVC'=PSPC,$P($G(DATA),U,9) Q
 F D1=0:0 S D1=$O(^PRSE(452.8,DA,3,D1)) Q:D1'>0  D SET
 Q
SET ;
 S:TYP="S"!(YRST<DT) YRST=DT I +(^PRSE(452.8,DA,3,D1,0)<YRST)!(+^PRSE(452.8,DA,3,D1,0)>YREND) Q
 I $D(^PRSE(452.8,DA,3,D1,0)),PRSESEL="D" S PRSESP1=$S((+^(0)>0):+^(0),1:0)
 I $D(^PRSE(452.8,DA,3,D1,0)),PRSESEL="C" S PRSESP2=$S((+^(0)>0):+^(0),1:0)
 S PRSELOC=$S('($P(^PRSE(452.8,DA,3,D1,0),U,2)=""):$P(^(0),U,2),1:"  BLANK") D SAVE
 Q
SAVE S:PRSESP1="" PRSESP1=" " S:PRSESP2="" PRSESP2=" "
 S:$G(NSORT)="" NSORT=1
 N X S X=$G(^TMP("PRSE",$J,"L",PRSESP1,PRSESP2))
 I X="" S X=NSORT,NSORT=NSORT+1,^TMP("PRSE",$J,"L",PRSESP1,PRSESP2)=X
 S ^TMP("PRSE",$J,"L1",X,PRSETYP,PRSELNG,PRSELOC,PRSESVC)=""
 Q