DENTDNJ1 ;WASH ISC/TJK,JA,NCA-INSERT AND LOOK UP ;10/29/92  07:56 ;12/16/91  3:30 PM
 ;;1.2;DENTAL;**15,23**;Oct 08, 1992
 G T1:'$D(DJDN) S DJXX=X,D="" G:DJ4["P" P G:X["^" ER S (DJDIC,DIE)=DIC,DA=DJDN S DR=DJ3_"///"_$S(X["/"!(X[";"):"^S X=DJXX",1:X) X DJCP W ! D ^DIE S DIC=DJDIC D KILL S DENTFLG=1 I $D(Y) S DJY=Y G Q1
 I DJ4["D" S (DJXX,Y)=X X ^DD("DD") S X=Y
 I DJ4["S" K:DJ4'["*" DIC("S") S DJX=$P(DJ0,U,3),DJXX=X F DJK=1:1 I X=$P($P(DJX,";",DJK),":",1) S X=$P($P(DJX,";",DJK),":",2) Q
 I '$D(DJY) S V(V)=$E(X,1,+DJJ(V))
 I  D O S @$P(DJJ(V),U,2) X XY W DJHIN X XY W V(V),DJLIN S:DJ4["D"!(DJ4["S") X=DJXX X DJCP S YMLH=$O(^DENT(220.6,DJN,1,"A",V,0)) S:YMLH="" YMLH=-1 X:$D(^DENT(220.6,DJN,1,YMLH,1)) ^(1) G NXT^DENTDNJ
P I DJ4["P" D P^DENTDNQ S @$P(DJJ(V),U,2) X XY G NXT^DENTDNJ:$D(Y)=0,TK^DENTDNJ
 S V(V)=$S(X="@":"",1:X) D O X DJCP S YMLH=$O(^DENT(220.6,DJN,1,"A",V,0)) S:YMLH="" YMLH=-1 I $D(^DENT(220.6,DJN,1,YMLH,1)) X DJCP S:DJ4["D" X=DJXX X ^(1) S @$P(DJJ(V),U,2) X XY
 G:DJAT=.01&(V(V)="") Q^DENTDNJ G T4^DENTDNJ
Q1 S:'$D(X) X=DJXX D ^DENTDNQ G TK^DENTDNJ
T1 S YMLH=$O(^DENT(220.6,DJN,1,"A",V,0)) S:YMLH="" YMLH=-1 I $D(^DENT(220.6,DJN,1,YMLH,1)) X DJCP X ^(1) S @$P(DJJ(V),U,2) X XY
 G:DJAT=.01&($D(DJDN)=0) K1
 G:DJAT=.01&(DJP) K1
 I V(V)'="",X="" G NXT^DENTDNJ
 I V(V)'="" S @$P(DJJ(V),U,2) X XY W DJHIN X XY W V(V),DJLIN G NXT^DENTDNJ
 I V(V)="" S @$P(DJJ(V),U,2) X XY W DJLIN S $P(DJDB,".",DJJ(V))="." S $X=DX W DJDB K DJDB G NXT^DENTDNJ
 G LH^DENTDNJ
K1 G NXT^DENTDNJ:X=""&($D(DJDN)),LST^DENTDNJ:X=""&('$D(DJDN)) I $D(DJST),DJST=1 K ^TMP($J,"DJST"),DJST
 D DCS^DENTDNQ
 I X'=" " S DIC(0)="LMEQZ",DLAYGO=$S(DIC["(":+$P(DIC,"(",2),1:DIC)
 S:X=" " DIC(0)="Z" X DJCP W X S:$D(DJDICS) DIC("S")=DJDICS D ^DENTDC,N^DENTDNJ2 K DIC("S"),DIC("V") S DIC(0)="LMEQZ",DLAYGO=$S(DIC["(":+$P(DIC,"(",2),1:DIC)
 I $Y>22 R !,"Press <RETURN> to Continue",X:DTIME S DJSV=V,DJFF=0 D N^DENTDPL,FUNC^DENTDNQ2 S V=DJSV
 I Y<0 S @$P(DJJ(V),U,2),X="" X XY G TK^DENTDNJ
 S (X,V(V))=$P(Y(0),U,1),(DA,W(V))=+Y,DJDNM=V(V) S:'$D(DJST) DJST=1,D0=DA I DJST=1 G LOCK
C S:'DJP DJDN=+Y K Y,DJLK D ^DENTD1 X XY G NXT^DENTDNJ
ER K X W *7 G Q1
WP ;PRINT WORD PROCESSOR FIELD
 S DJDIC=DIC_DA_","_+$P(DJ0,"^",4)_"," S DJXX=X Q:'$D(@(DJDIC_"0)"))  S DJZ1=0,DJX=0,DIWL=1,DIWR=79,DIWF="" K ^UTILITY($J,"W")
 F DJK=1:1 S DJZ1=$O(@(DJDIC_DJZ1_")")) Q:DJZ1'?1N.N  S X=^(DJZ1,0) D ^DIWP X DJCP
 D ^DIWW
 S DJZ1=0 F DJK=1:1 S DJZ1=$O(^UTILITY($J,"W",DIWL,DJZ1)) Q:DJZ1=""  D:$Y>21 CONT Q:DJX[U  W !,^(DJZ1,0)
 D CONT K DJZ1,DJK,^UTILITY($J,"W",DIWL),DIWL,DIWR,DIWF S X=DJXX Q:DJX'[U
 Q
CONT W !,"Press <RETURN> to Continue, '^' to Quit: " R DJX:DTIME X DJCP W ! Q
R X DJCL W "Press <RETURN> to Continue" R DJX:DTIME Q
EN ;COMPUTE AND DISPLAY
 S @$P(DJJ(DJVV),U,2) X XY S $P(DJDB," ",+DJJ(DJVV))=" " W DJDB X XY W DJHIN X XY S DJDB(1)=$P($P(DJJ(DJVV),U,4),"J",2),DJDB(2)=$P(DJDB(1),",",2),DJDB(1)=+DJDB(1)
 I V(DJVV)'="" W V(DJVV) ;W $J(V(DJVV),DJDB(1),+DJDB(2)),DJLIN K DJDB
 W DJLIN K DJDB
 Q
LOCK ;LOCK GLOBAL THAN IS BEING ACCESSED BY ANOTHER USER
 L @(DIC_+Y_"):1") S DJLK=$T G:DJLK'=0 C I DJLK=0 X XY K DJLK X DJCL W "THIS ENTRY IS BEING EDITED BY ANOTHER USER. TRY LATER.",*7 G TK^DENTDNJ
KILL K DB,DC,DG,DH,DE,DI,DK,DL,DM,DP,DW,DR Q
EN2 X DJCP W !!,"THIS IS NOT THE FIRST SCREEN",*7 R !,"Press <RETURN> to Continue",X:DTIME S X="^" Q
O ;EX OUTPUT TRANSFROM
 I $D(^DD(DJDD,DJAT,2)) S Y=X X ^(2) S (V(V),X)=Y
 Q
EN3 ;ERROR ON DIE
 G:'$D(Y) E X DJCP W !,"You have a bad default variable, please check with your",!,"Data Base administrator",*7
 S @$P(DJJ(V),U,2),$P(DJDB,".",DJJ(V))="." X XY W DJHIN X XY S $X=DX W DJDB,DJLIN K DJDB X XY S V(V)="" Q
E S DJDB="" S:(DJJ(V)-$L(V(V))) $P(DJDB," ",DJJ(V)-$L(V(V)))=" " X XY W DJHIN X XY W V(V),DJDB,DJLIN K DJDB Q