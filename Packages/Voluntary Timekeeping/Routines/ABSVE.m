ABSVE ;VAMC ALTOONA/CTB&CLH - POST DAILY ENTRIES ;4/13/00  3:12 PM
V ;;4.0;VOLUNTARY TIMEKEEPING;**10,18**;JULY 6, 1994
 ;ENTER DATA INTO TIME FILE
 N %,%DT,%T,%W,%Y,ABSVX,DIR,DIRUT,DTOUT,DUOUT,DIROUT,C,COMB,DAY,DIC,DI,D0,DQ,DR,DUOUT,DIE,DATE,FIRST,ORG,DA,SER,VOL,I,N,X,Y,POP
 D ^ABSVSITE G OUT^ABSVE3:'%
 S FIRST=""
DATE S DIR(0)="D^::AEXP",DIR("A")="Select Posting DATE"
 D ^DIR
 I $D(DIRUT) K DIRUT,DTOUT,DUOUT,DIROUT G OUT^ABSVE3
 S DATE=Y
 S DIC("A")="Select Volunteer: "
TIME ;S DIC("S")="I $D(^ABS(503330,+Y,4,ABSV(""INST""),0)),$P(^(0),U,8)=""""",DIC=503330,DIC(0)="AEMZQ"
 S DIC("S")="I $D(^ABS(503330,+Y,4,ABSV(""INST""),0))",DIC=503330,DIC(0)="AEMZQ"
 D MDIV^ABSVSITE,^DIC K DIC
 I Y<0,$D(FIRST) G OUT^ABSVE3
 I Y<0 G DATE
 I '$$ACTIVE^ABSVU2(+Y,ABSV("INST")) G:$D(FIRST) OUT^ABSVE3 G TIME
 K FIRST
 S ABSVX("VOLDA")=+Y,ABSVX("NAME")=$P(Y,"^",2)
T1 K NEW
 S DA=ABSVX("VOLDA") D PC1^ABSVE2,SEL1^ABSVE2 I Y="" D NEXT G TIME
 S X=^ABS(503330,DA,1,$P(Y,"^",2),0)
 S COMB=$P(X,"^",5),ORG=$P(X,"^",2),SER=$P(X,"^",4)
 S Y=0 L +^ABS(503330,ABSVX("VOLDA")):10 I '$T S X="Someone else is accessing this record. Posting terminated." D MSG^ABSVQ,NEXT G TIME
 F  S Y=$O(^ABS(503331,"B",ABSVX("VOLDA"),Y)) Q:Y=""  S X=$G(^ABS(503331,Y,0)) I $P(X,"^",3)=DATE,$P(X,"^",6)=COMB Q
 I Y'>0 S X=ABSVX("VOLDA") S DIC="^ABS(503331,",DIC(0)="ML" D FILE^DICN,XREF S NEW=1
 S DA=+Y,DR=4,DIE=503331 D ^DIE
 L -^ABS(503330,ABSVX("VOLDA"))
 I '$D(Y) S X="<Daily Record Completed.>*" D MSG^ABSVQ G Q
 I $D(NEW) K NEW S X="This entry is incomplete and is being deleted.*" D MSG^ABSVQ S DIK=DIE D ^DIK K DIK G Q
 S ABSVXA="ARE YOU SURE YOU WANT TO DELETE THIS ENTRY",ABSVXB="",%=1 D ^ABSVYN
 I %'=1 S X="  <No action taken>*" D MSG^ABSVQ G Q
 S DIK=DIE D ^DIK K DIK S X="  <Record Deleted>*" D MSG^ABSVQ
Q D NEXT G TIME
NEXT W !!!,"For ",$$FULLDAT^ABSVU2(DATE),":" S DIC("A")="Select Next Volunteer: " QUIT
XREF S XX=$E(DATE,1,5)_"00^"_DATE_"^"_+ORG_"^^"_COMB_"^"_ABSV("SITE")_"^"_+SER,$P(^ABS(503331,+Y,0),"^",2,8)=XX K XX
 S ^ABS(503331,"AD",DATE,+Y)="",^ABS(503331,"AC",+ORG,+Y)="",^ABS(503331,"AE",+SER,+Y)="",^ABS(503331,"AF",$E(DATE,1,5)_"00",+Y)=""
 Q