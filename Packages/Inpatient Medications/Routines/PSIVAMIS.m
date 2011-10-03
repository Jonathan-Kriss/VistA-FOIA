PSIVAMIS ;BIR/CCH,PR-AMIS REPORT ;03 NOV 94 / 4:38 PM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
ENQ K ^UTILITY($J) F IV=0:0 S IV=$O(^PS(50.8,IV)) Q:'IV  I $D(^PS(50.8,IV,2)) F DAT=I7-1:0 S DAT=$O(^PS(50.8,IV,2,DAT)) Q:'DAT!(DAT>I8)  D DRUG
PRTQUE G:'$D(I6) W S ZTIO=I6,ZTRTN="W^PSIVAMIS",ZTDTH=$H,ZTSAVE("^UTILITY($J,")="" F G="I7","I8" S ZTSAVE(G)=""
 S ZTDESC="IV AMIS REPORT (PRINT)",%ZIS="QN",IOP=I6 D ^%ZIS,^%ZTLOAD G K
 ;
W U IO S PGCNT=0 I '$D(^UTILITY($J)) D H W !,"No data." W:$E(IOST)'="C"&($Y) @IOF D ^%ZISC G K
 F IV=0:0 K TOT S IVTOT=0,IV=$O(^UTILITY($J,IV)) Q:'IV  D H W !!,"IV ROOM ",$P(^PS(59.5,IV,0),U) D IV W !!?56,"================",!?5,"*TOTAL FOR IV ROOM: ",$P(^PS(59.5,IV,0),U),?54,$J(IVTOT,18,4),! F TYP="P","A","H","S","C" S PR="" D PRTLN,CTOT
 ;
 D TM^PSIVDCR1
K S:$D(ZTQUEUED) ZTREQ="@" K CNT,CNTNDE,D,DAT,DISP,DRG,DRGCOST,DS,IV,IVTOT,JJ,LN,LO,PERRY,PGCNT,TOTNDE,TUC,TYP,WARD,WCOST,WDISP,WUNITS,ZZ,^UTILITY($J) D ENIVKV^PSGSETU
 Q
 ;
DRUG I $D(^PS(50.8,IV,2,DAT,1)) F WARD=0:0 S WARD=$O(^PS(50.8,IV,2,DAT,1,WARD)) Q:'WARD  D GETEM
 I $D(^PS(50.8,IV,2,DAT,2)) F DRG=0:0 S DRG=$O(^PS(50.8,IV,2,DAT,2,DRG)) Q:'DRG  I $D(^(DRG,0)) S DRGCOST=$P(^(0),U,5) D WARD
 Q
 ;
WARD I $D(^PS(50.8,IV,2,DAT,2,DRG,3)) F WD=0:0 S WD=$O(^PS(50.8,IV,2,DAT,2,DRG,3,WD)) Q:'WD  I $D(^(WD,1)) F TYP="P","A","H","S","C" D TYPE
 Q
 ;
TYPE S DA=$O(^PS(50.8,IV,2,DAT,2,DRG,3,WD,"B",TYP,0)) Q:DA'>0
 S COST=$P(^PS(50.8,IV,2,DAT,2,DRG,3,WD,1,DA,0),U,2)*DRGCOST
 S LO=$S($D(^UTILITY($J,IV,$S($D(^DIC(42,WD,0)):$P(^(0),U),1:"OUT-PT"),TYP)):^(TYP),1:"") S $P(LO,U)=$P(LO,U)+COST,$P(LO,U,2)=$P(LO,U,2)+$P(^PS(50.8,IV,2,DAT,2,DRG,3,WD,1,DA,0),U,2)
 S ^UTILITY($J,IV,$S($D(^DIC(42,WD,0)):$P(^(0),U),1:"OUT-PT"),TYP)=LO K COST Q
 ;
H W:$Y @IOF S PGCNT=PGCNT+1 W !!!?31,"IV AMIS REPORT",?65,"Page No. ",PGCNT,!,?20,"FROM " S Y=I7 X ^DD("DD") W Y," THROUGH " S Y=I8 X ^DD("DD") W Y D NOW^%DTC S Y=X X ^DD("DD") W ?65,Y
 W !!,?36,"TOTAL",?63,"AVERAGE",!,?5,"TYPE",?34,"DISPENSED (BAGS)",?64,"COST"
 W !! F LN=1:1:80 W "="
 Q
 ;
WRT2 S TOTNDE=^UTILITY($J,IV,PERRY,0)
 F TYP="P","A","H","S","C" S ZZ(TYP)=$S($D(^UTILITY($J,IV,PERRY,TYP)):^(TYP),1:"") D COMPTE,PRTLN,PRTLN1
WDTOT W !,?30,"_____________",?57,"_______________"
 S DS=WDISP,TUC=$S(DS'>0:0,1:WCOST/(WDISP)),DISP=WDISP D:$Y+5>IOSL H W !,?5,"TOTAL FOR WARD" S IVTOT=IVTOT+TUC D PRTLN1 Q
COMPTE S DISP=$P(TOTNDE,U,$S(TYP="P":1,TYP="A":2,TYP="H":3,TYP="C":4,1:5)) I +$P(ZZ(TYP),U,1)'>0!(+$P(ZZ(TYP),U,2)'>0) S TUC=0 G HERE
 S:DISP'>0 TUC=0 G:DISP'>0 HERE S TUC=$P(ZZ(TYP),U,1)/DISP
HERE S WDISP=$S($D(WDISP):WDISP+DISP,1:DISP),WCOST=$S($D(WCOST):WCOST+$P(ZZ(TYP),U),1:$P(ZZ(TYP),U)),WUNITS=$S($D(WUNITS):WUNITS+$P(ZZ(TYP),U,2),1:$P(ZZ(TYP),U,2))
 S LO=$S($D(TOT(TYP)):TOT(TYP),1:"") F C=1:1:2 S $P(LO,U,C)=$P(LO,U,C)+$P(ZZ(TYP),U,C)
 S $P(LO,U,3)=$P(LO,U,3)+DISP S TOT(TYP)=LO Q
PRTLN W !?5 W:$D(PR) "*" W $S(TYP="P":"Piggyback",TYP="A":"Admixture",TYP="H":"Hyperal",TYP="C":"Chemotherapy",1:"Syringe") K PR Q
CTOT S TUC=$S('$D(TOT(TYP)):0,$P(TOT(TYP),U,3)<1:0,1:$P(TOT(TYP),U,1)/($P(TOT(TYP),U,3)-$P(TOT(TYP),U,4)))
 S DISP=$S($D(TOT(TYP)):$P(TOT(TYP),U,3),1:0)
PRTLN1 W ?35,$J(DISP,8,0),?60,$J(TUC,12,4) Q
IV S PERRY="" F JJ=0:0 S PERRY=$O(^UTILITY($J,IV,PERRY)) Q:PERRY=""  D:$Y+1>IOSL H W !!,PERRY K WDISP,WCOST,WUNITS D WRT2
 Q
GETEM I $D(^PS(50.8,IV,2,DAT,1,WARD,0)) S CNTNDE=^(0),X=0 D SETEM
 I $D(^PS(50.8,IV,2,DAT,1,WARD,"R")) S CNTNDE=^("R"),X="R" D SETEM
 Q
SETEM F ZZ=1:1:5 S CNT(ZZ)=$P(CNTNDE,U,ZZ+1)
 S LO=$S($D(^UTILITY($J,IV,$S($D(^DIC(42,WARD,0)):$P(^(0),U),1:"OUT-PT"),X)):^(X),1:"") F ZZ=1:1:5 S $P(LO,U,ZZ)=$P(LO,U,ZZ)+CNT(ZZ)
 S ^UTILITY($J,IV,$S($D(^DIC(42,WARD,0)):$P(^(0),U),1:"OUT-PT"),X)=LO Q