PRSEED4 ;HISC/JH/MD-EDUCATION FILE POPULATION ;2/11/92
 ;;4.0;PAID;**5,18**;Sep 21, 1995
EN1 ;PRSEED-CLAS
 S X=$G(^PRSE(452.7,1,"OFF")) I X=""!X D MSG6^PRSEMSG G QQ
 S PRSEFIL="^PRSE(452.1)",DIE("NO^")="BACKOUTOK" G:$D(DOUT) QQ D EN2^PRSEUTL3($G(DUZ)) I PRSESER'>0,'(DUZ(0))["@"  D MSG3^PRSEMSG S DOUT=1 G QQ
 W ! D EN S DIC(0)="AEQMZ",(DIC,DIDEL)=452.1,DIC("A")="Select CLASS: ",DIC("S")="I $P(^(0),U,8)=PRSESER!(DUZ(0)[""@"")!$$EN4^PRSEUTL3(DUZ)"
 S DIC("W")="S XX=$P($G(^(0)),U,7),ZZ=+$P($G(^(0)),U,8) W ?($X+3),$P($G(^PRSP(454.1,ZZ,0)),U),?($X+3),$S(XX=""C"":""CONT. ED."",XX=""M"":""MANDATORY"",XX=""W"":""WARD/UNIT"",XX=""O"":""OTHER/MISC."",1:"""")"
 D ^DIC G:$D(DTOUT)!$D(DUOUT)!(U[X) QQ
 S (PRDA,DA)=+Y L +^PRSE(452.1,+Y,0):0 I '$T D MSG^PRSEMSG G Q
 I $G(^PRSE(452.1,+Y,0))]"" D
 .S PRSEDATA=$P(^PRSE(452.1,+Y,0),U)_U_$P(^(0),U,7)_U_$P(^(0),U,3)_U_$P(^(0),U,8),PRSENAM=$E($P(^(0),U),1,25),PRSETYP=$P(^(0),U,7),PRSESER=$P(^(0),U,8)
 .S DIE=DIC,DR=".01;8;2;3;S:'(PRSETYP=""M"") Y=""@1"";4;@1;5;6//"_PRSESER_";7//" D ^DIE
 .I $G(^PRSE(452.1,+PRDA,0))]"" S PRSEDATA(1)=$P($G(^(0)),U)_U_$P(^(0),U,7)_U_$P(^(0),U,3)_U_$P(^(0),U,8),PRSESER("TX")=$P($G(^PRSP(454.1,+$P(PRSEDATA(1),U,4),0)),U)
 I PRSEDATA=$G(PRSEDATA(1)) L -^PRSE(452.1,+PRDA,0) G EN1
 I '$D(^PRSE(452.1,+PRDA,0)) D
 .I $D(^PRSE(452.8,"B",+PRDA)) S DIK="^PRSE(452.8,",DA=$O(^PRSE(452.8,"B",+PRDA,0)) D ^DIK
 .S DIK="^PRSE(452.3,DA(1),1," F DA(1)=0:0 S DA(1)=$O(^PRSE(452.3,"C",DA(1))) Q:DA(1)'>0  F DA=0:0 S DA=$O(^PRSE(452.3,"C",DA(1),PRDA,DA)) Q:DA'>0  D ^DIK
 I $G(^PRSE(452.1,+PRDA,0))="" L -^PRSE(452.1,+PRDA,0) Q
 I $D(^PRSE(452.1,+PRDA,0)),$D(^PRSE(452.8,"B",+PRDA)) S DA=$O(^PRSE(452.8,"B",+PRDA,0)),DIE=452.8,XX=+$P($G(PRSEDATA(1)),U,3),DR="2.7///"_$P(PRSEDATA(1),U,4)_";4///"_$P(PRSEDATA(1),U,2)_";7.1///^S X=$J(+XX,1,0);15///^S X=+XX" D ^DIE
 S PRSEX=$P(^PRSE(452.1,+PRDA,0),U)
 L -^PRSE(452.1,+PRDA,0)
 Q
EN2 ;PRSE-SUP
 S PRSEFIL="^PRSE(452.2)" W ! D EN G:$D(DOUT) QQ S DLAYGO=452.3,DIC="^PRSE(452.2,",DIC("A")="Select PRESENTER/SUPPLIER: " D ^DIC G Q:$D(DTOUT)!$D(DUOUT)!(U[X)  S PRDA=+Y L +^PRSE(452.2,+PRDA,0):0 I '$T D MSG^PRSEMSG G QQ
 S DIE=DIC,DA=+Y,DR=".01:4" K DIC D ^DIE G Q:$D(DTOUT)!$D(Y) L -^PRSE(452.2,+PRDA,0) D QQ W ! G EN2
EN3 ;PRSE-MI
 S PRSEFIL="^PRSE(452.3)" W ! D EN G:$D(DOUT) QQ D EN2^PRSEUTL3($G(DUZ)) I PRSESER="",DUZ(0)'["@" S DOUT=1 D MSG3^PRSEMSG G Q
MI ;
 S DIC("S")="S PRSE=$O(^PRSP(454.1,""B"",""MISCELLANEOUS"",0)) I ($P(^PRSE(452.3,+Y,0),U,2)=PRSESER!($P($G(^(0)),U,2)=PRSE!(+$$EN4^PRSEUTL3($G(DUZ))!(DUZ(0)[""@""))))"
 S DIC("DR")=".02///^S X=PRSESER(""TX"")",DLAYGO=452.3,DIC=452.3,DIC(0)="AEQZL",DIC("A")="Select MANDATORY TRAINING GROUP NAME: "
 S DIC("W")="N XX,ZZ S XX=$P($G(^(0)),U,2) S ZZ=$S($P($G(^PRSP(454.1,+XX,0)),U)=""MISCELLANEOUS"":""HOSPITAL WIDE"",1:$P($G(^(0)),U)) W ?($X+5),ZZ Q"
 D ^DIC K DIC G Q:$D(DTOUT)!$D(DUOUT)!(U[X) S PRSESER(1)=$P($G(^PRSE(452.3,+Y,0)),U,2),(SAVEDA,DA)=+Y
 I DA>0 S DIE=452.3,DR=".01;S:'+$$EN4^PRSEUTL3($G(DUZ))&'(DUZ(0)[""@"") Y=""@1"";.02;@1;1" D ^DIE D:$D(DA)[0 EN4^PRSEUTL5(SAVEDA) D EN2^PRSEUTL5(SAVEDA)
 W ! G MI
EN4 ;PRSE-SOR
 S PRSEFIL="^PRSE(452.5)" W ! D EN G:$D(DOUT) QQ S DLAYGO=452.3,DIC="^PRSE(452.5,",DIC("A")="Select PRESENTATION MEDIA: " D ^DIC G Q:$D(DTOUT)!$D(DUOUT)!(U[X) S PRDA=+Y L +^PRSE(452.5,+PRDA,0):0 I '$T D MSG^PRSEMSG G QQ
 S DIE=DIC,DA=+Y,DR=".01;1" K DIC D ^DIE G Q:$D(DTOUT)!$D(Y) L -^PRSE(452.5,+PRDA,0) D QQ W ! G EN4
EN5 ;PRSE-ACC
 S PRSEFIL="^PRSE(452.9)" W ! D EN G:$D(DOUT) Q S DLAYGO=452.3,DIC="^PRSE(452.9,",DIC(0)="AELMQ",DIC("A")="Select ACCREDITING ORGANIZATION: " D ^DIC G Q:$D(DTOUT)!$D(DUOUT)!(U[X) S PRDA=+Y L +^PRSE(452.9,+PRDA,0):0 I '$T D MSG^PRSEMSG G QQ
 S DIE=DIC,DA=+Y,DR=".01:4" K DIC D ^DIE G Q:$D(DTOUT)!$D(Y) L -^PRSE(452.9,+PRDA,0) D QQ W ! G EN5
EN6 ;PRSED-SVC
 D EN2^PRSEUTL3($G(DUZ)) S PRSEFIL="^PRSE(452.6)" I PRSESER="",'(DUZ(0)["@") D MSG3^PRSEMSG S DOUT=1 G Q
 W ! D EN G:$D(DOUT) Q L +^PRSE(452.6):0 I '$T D MSG^PRSEMSG G QQ
 S DIC="^PRSE(452.6,",DLAYGO=452.6,DIC(0)="AELMQ",DIC("A")="Select SERVICE REASON: " D ^DIC G:$D(DTOUT)!$D(DUOUT)!(U[X) Q
 S (PDA,DA)=+Y L +^PRSE(452.6,PDA,0):0 S DIE=DIC,DR=".01//" D ^DIE L -^PRSE(452.6,PDA,0) D Q G EN6
EN7 ;PRSEFL-SITE
 S PRSEFIL="^PRSE(452.7)" W ! I '$D(^PRSE(452.7,1)) D ADD
 L +^PRSE(452.7):0 I '$T D MSG^PRSEMSG G Q
 S DA=1,DR=".01;4;S:'(DUZ(0)[""@"") Y=""@1"";1;3;5;@1",DIE="^PRSE(452.7," D ^DIE,Q Q
ADD ;ADD 452.7 ENTRY
 S $P(^PRSE(452.7,1,0),U)="ONE",^PRSE(452.7,1,"OFF")=0,DIK="^PRSE(452.7," D IXALL^DIK Q
Q L -@(PRSEFIL)
QQ D ^PRSEKILL
 Q
EN S X=$G(^PRSE(452.7,1,"OFF")) I X=""!X D MSG6^PRSEMSG S DOUT=1
 S DIC(0)="AELMQZ",DIE("NO^")="BACKOUTOK",PRSEGLO=$P($G(@($P(PRSEFIL,")")_",0)")),U) Q