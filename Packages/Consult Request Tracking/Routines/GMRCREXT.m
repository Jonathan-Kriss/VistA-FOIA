GMRCREXT ;SLC/DCM - clean-up all variables and ^TMP globals upon exit ;7/16/98  03:49
 ;;3.0;CONSULT/REQUEST TRACKING;**1,4,12**;DEC 27, 1997
 K ^TMP("GMRCR",$J),^TMP("GMRCS",$J),^TMP("GMRCSLIST",$J)
 K DFN,BLK,C,CDT,CNT,TAB,LNCT,CTRLCOL,D1,DATA,GMRCDT,GMRCND,GMRCNO,GMRCDT1,GMRCDT2,GMRCSEX,GMRCPNM,GMRCSSN,SEX,GMRCPTN,GMRCERR,GMRCWLI,GMRCPTR,GMRCSVCP,GMRCWRD,GMRCWT,GMRCDFN
 K GMRCRB,GMRCAGE,GMRCCT,GMRCSN,GMRCSSNM,GMRCDOB,GMRCDGT,GMRCDOB,GMRCGRP,GMRCWRD,GMRCNUL,GMRCQUIT,GMRCELIG,GMRCNUL,GMRCOER,GMRCSEL,GMRCOK,GMRCSSS
 K VAEL,VADM,VAERR
 K GMRCBM,GMRCTM,GMRCNUL,GMRCAD,GMRCXMF,GMRC,GMRCO,GMRCND
 Q