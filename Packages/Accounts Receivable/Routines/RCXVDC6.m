RCXVDC6 ;DAOU/ALA-AR Data Extraction Data Creation ;02-JUL-03
 ;;4.5;Accounts Receivable;**201,227,228**;Mar 20, 1995
 ;
 ; Accounts Recv. Trans. File (# 433) 
 Q
D433 ; 
 K ^TMP($J,RCXVBLN,"6-433A")
 N X,Y
 ; LOOP THRU(^PRCA(433,"C",RCXVBLN)
 ;
 ;  If the current fiscal year flag is set, must loop for
 ;  all the transactions since the beginning of the fiscal year
 I $G(RCXVCFLG)=1 S RCXVBDT=RCXVFFD
 NEW RCXVD,RCXVDA,RCXVDT,RCXVI,RCXVP1,RCXVP2,RCXVD0B,RCX
 S RCXVD0B=""
 F RCXVI=1:1 S RCXVD0B=$O(^PRCA(433,"C",RCXVBLN,RCXVD0B)) Q:RCXVD0B=""  D D433A
 Q
D433A ;
 S RCXVD=$G(^PRCA(433,RCXVD0B,1))
 S RCXVP1=$P($G(^PRCA(433,RCXVD0B,0)),U,2),RCXVP2=""
 I RCXVP1'="" S RCXVP2=$P($G(^PRCA(430,RCXVP1,0)),U,1)
 S RCXVDA=RCXVP2 ; BILL NUMBER (P) 
 S RCXVDA=RCXVDA_RCXVU_$P($G(^PRCA(433,RCXVD0B,0)),U,1) ; TRANS. #
 S RCXVDT=$P(RCXVD,U,9)
 I RCXVDT<RCXVBDT Q  ;QUIT IF DATE ENTERED IS OLDER THAN BATCH DATE
 S RCXVDT=$P(RCXVD,U)
 S RCXVDA=RCXVDA_RCXVU_$E($$HLDATE^HLFNC(RCXVDT),1,8) ; TRANS. DT
 S RCXVP1=$P(RCXVD,U,2),RCXVP2=""
 I RCXVP1'="",+$P($G(^PRCA(430.3,RCXVP1,0)),U,6)=0 Q
 I RCXVP1'="" S RCXVP2=$P($G(^PRCA(430.3,RCXVP1,0)),U,1)
 S RCXVDA=RCXVDA_RCXVU_RCXVP2 ; TRANS TYPE (P)
 S RCXVDT=$P(RCXVD,U,9)
 S RCXVDA=RCXVDA_RCXVU_$E($$HLDATE^HLFNC(RCXVDT),1,8) ; DT ENTRD
 S RCXVDA=RCXVDA_RCXVU_$P(RCXVD,U,5) ; TRANS AMT
 S RCXVDA=RCXVDA_RCXVU_$$GET1^DIQ(433,RCXVD0B_",",88,"E") ; CONT. ADJ.
 S RCXVDA=RCXVDA_RCXVU_$P(RCXVD,U,3) ;RECEIPT NUMBER
 S RCXVDT=$P(RCXVD,U,1)
 S RCXVDA=RCXVDA_RCXVU_$E($$HLDATE^HLFNC(RCXVDT),1,8) ; DT OF PAYMENT
 S RCX=0,RCXVDT=""
 F  S RCX=$O(^PRCA(433,RCXVD0B,7,RCX)) Q:'RCX  S X=$G(^(RCX,0)) Q:RCXVDT  D
 .  Q:X'["Check Date: "
 .  S X=$E(X,13,20) D ^%DT
 .  I Y S RCXVDT=Y
 .  Q
 S RCXVDA=RCXVDA_RCXVU_$E($$HLDATE^HLFNC(RCXVDT),1,8) ;CHECK DATE
 S ^TMP($J,RCXVBLN,"6-433A",RCXVI)=RCXVDA
 Q
 ;
D433B ;
 NEW RCXVDA,RCXVD0B,RCXVI,RQFL
 S RCXVD0B="",RQFL=0
 F RCXVI=1:1 S RCXVD0B=$O(^PRCA(433,"C",RCXVBLN,RCXVD0B)) Q:RCXVD0B=""  D  Q:RQFL
 . S RCXVDA=$$GET1^DIQ(433,RCXVD0B_",",88,"E") ; Contractual Adj
 . I RCXVDA'="" S $P(^TMP($J,RCXVBLN,"6-433A",1),U,7)=RCXVDA,RQFL=1
 Q