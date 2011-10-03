SPNPSR12 ;HIRMFO/DAD,WAA-HUNT: REGISTRATION STATUS ;8/7/95  15:30
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;
EN1(D0,SPNSTAT) ; *** Search entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ;  D0       = SCD (SPINAL CORD) REGISTRY file (#154) IEN
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"REGISTRATION STATUS") = Int ^ Ext
 ;     SPNSTAT = Patient Registration Status
 ; Output:
 ;  $S( D0_Meets_Search_Criteria : 1 , 1 : 0 )
 ;
 N MEETSRCH
 S MEETSRCH=0
 I SPNSTAT=$P($G(^SPNL(154,D0,0)),U,3) S MEETSRCH=1
 Q MEETSRCH
 ;
EN2(ACTION,SEQUENCE) ; *** Prompt entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ; Output:
 ;  SPNLEXIT = $S( User_Abort/Timeout : 1 , 1 : 0 )
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"REGISTRATION STATUS") = Int ^ Ext
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"REGISTRATION STATUS") = $$EN1^SPNPSR12(D0,SPNSTAT)
 ;
 N DIR,DIRUT,DTOUT,DUOUT,REGSTAT
 S SPNLEXIT=0
 K ^TMP($J,"SPNPRT",ACTION,SEQUENCE),DIR
 S DIR(0)="SOAM^0:NOT SCD;1:SCD - CURRENTLY SERVED;2:SCD - NOT CURRENTLY SERVED;"
 S DIR("A")="Registration status: "
 S DIR("?")="Enter the desired registration status 0-2"
 D ^DIR S REGSTAT=Y_U_$G(Y(0))
 S SPNLEXIT=$S($D(DTOUT):1,$D(DUOUT):1,1:0)
 I 'SPNLEXIT,Y'="" D
 . S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"REGISTRATION STATUS")=REGSTAT
 . S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0)="$$EN1^SPNPSR12(D0,"_$P(REGSTAT,U)_")"
 . Q
 Q