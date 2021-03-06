WVPROF1 ;HCIOFO/FT,JR IHS/ANMC/MWR - DISPLAY PATIENT PROFILE; ;7/30/98  11:39
 ;;1.0;WOMEN'S HEALTH;;Sep 30, 1998
 ;;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  SETUP AND EDIT CODE FOR DISPLAYING PATIENT PROFILE.
 ;;  CALLED BY WVPROF.
 ;
 D DISPLAY Q:WVPOP
 D ^WVPROF3
 Q
 ;
 ;
DISPLAY ;EP
 ;---> WVCONF=DISPLAY "CONFIDENTIAL PATIENT INFO" BANNER.
 ;---> WVTITLE=TITLE AT TOP OF DISPLAY HEADER.
 ;---> WVCHAGE=DISPLAY CHART AND AGE IN HEADER.
 ;---> WVSUBH=CODE TO EXECUTE FOR SUBHEADER (COLUMN TITLES).
 ;---> WVCODE=CODE TO EXECUTE AS 3RD PIECE OF DIR(0) (AFTER DIR READ).
 ;---> WVCRT=1 IF OUTPUT IS TO SCREEN (ALLOWS SELECTIONS TO EDIT).
 ;---> WVTAB=6 IF OUTPUT IS TO SCREEN, =3 IF OUTPUT IS TO PRINTER.
 ;---> WVPRMT(1,Q)=PROMPTS FOR DIR.
 ;
 U IO
 I '$D(WVDFN)!('$D(WVNAME))!('$D(WVCHRT)) D  Q
 .W !!,"INSUFFICIENT PATIENT INFORMATION.",!!
 .D DIRZ^WVUTL3 S WVPOP=1
 ;
 S WVCONF=1,WVCHAGE=1
 S WVTITLE="* * *  Patient Profile  * * *" D CENTERT^WVUTL5(.WVTITLE)
 S WVCODE="Q:'$D(^TMP(""WV"",$J,2,+X))  "
 S WVCODE=WVCODE_"D EDIT^WVPROF1 N X D SORT^WVPROF2,COPYGBL^WVPROF"
 ;---> IF PROFILE IS BEING ACCESSED BY A USER FROM OUTSIDE OF THE
 ;---> PACKAGE (NOT WOMEN'S HEALTH STAFF), THEN OFFER DISPLAY/PRINT
 ;---> OF PROCEDURE; DO NOT OFFER EDIT OF PROCEDURE.
 D:$G(WVPUSER)
 .S WVCODE="D PRINTPCD^WVPROF1"
 S (WVACCP,N,WVPOP,Z)=0
 D TOPHEAD^WVUTL7
 S WVTAB=$S(WVCRT:6,1:3)
 Q
 ;
 ;
EDIT ;EP
 ;---> FROM BROWSE, WVPOP IN TO EDIT A SINGLE PROCEDURE.
 ;---> NOTE: PIECE 10 OF EACH TMP NODE IS THE IEN FOR THAT ENTRY
 ;---> IN ITS RESPECTIVE FILE (PROCDURE FILE OR NOTIFICATION FILE).
 D SETVARS^WVUTL5
 S X=+X,DA=$P(^TMP("WV",$J,2,X),U,10)
 S WVNN=X N X D
 .I $P(^TMP("WV",$J,2,WVNN),U)=1 D  Q
 ..D EDIT2^WVPROC1(DA,.WVPOP) Q:WVPOP
 .I $P(^TMP("WV",$J,2,WVNN),U)=2 D EDIT2^WVNOTIF(DA) Q
 .W !!?3,*7,"This is neither a PROCEDURE nor a NOTIFICATION.  "
 .W "It cannot be edited here."
 .D DIRZ^WVUTL3 Q
 ;---> BACK UP 5 RECORDS AFTER EDIT.
 S N=$S(WVNN<6:1,1:WVNN-5),Z=0 K WVNN
 Q
 ;
 ;
PRINTPCD ;EP
 ;---> FROM BROWSE, PRINT THIS PROCEDURE.
 ;---> NOTE: PIECE 10 OF EACH TMP NODE IS THE IEN FOR THAT ENTRY
 ;---> IN ITS RESPECTIVE FILE (PROCDURE FILE OR NOTIFICATION FILE).
 D SETVARS^WVUTL5
 S X=+X,DA=$P(^TMP("WV",$J,2,X),U,10)
 S WVN=X N X D
 .I $P(^TMP("WV",$J,2,WVN),U)=1 D TOP^WVPRPCD(DA) Q
 .W !!?3,*7,"This is not a PROCEDURE.  "
 .D DIRZ^WVUTL3 Q
 ;---> BACK UP 5 RECORDS AFTER EDIT.
 S N=$S(WVN<6:1,1:WVN-5),Z=0 K WVN
 Q
 ;
 ;
SUBHEAD ;EP
 ;---> SUB HEADER FOR BRIEF DISPLAY OF PROCEDURES ONLY.
 W !?WVTAB,"DATE",?16,"PROCEDURE",?27,"RESULTS/DIAGNOSIS",?71,"STATUS",!
 W ?WVTAB,"--------",?16,"---------",?27,"----------------------------"
 W ?71,"------"
 Q
