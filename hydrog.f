C ---------------------------------------------------------- 
      SUBROUTINE hydrog(SS1,m,n,NDAT,Hydro,mn1,mn2) ! ARGU = (NUT,NDAT) (2.1.18)
C -----------------------------------------------------------------------
!This subrouting is to address with future DATA from hydroelectric Station
!bellow Sandillal Dam.
!This station just only works at nights, so maybe the DATA will be: StarTime
!StopTime and Discharge (I guess it will be constant)
C -----------------------------------------------------------------------
C   DECLARE VARIABLES
C -----------------------------------------------------------------------
      IMPLICIT DOUBLE PRECISION (a-h, o-z)
!      COMMON/BLK1/SS(600,10),SS1(600,10),Hydro(600,3)
      DIMENSION SS(600,10),SS1(600,10),Hydro(600,3)
      COMMON/BLK1/SS
      COMMON/BLK10/B(600)
      DIMENSION A(600) 
      ! EXPORT Hydrograph, Date (hours) StreamA(CMS)   
C -----------------------------------------------------------------------
      SS=SS1 ! (9.25.17)
      READ(NDAT,*)NA,FTIME,ETIME,DIS,DISANG !  (9.25.17)
      !DISANG=DIS/(0.3048**3) !Convertion to CFS 
C -----------------------------------------------------------------------
C   CONVERSION
C ----------------------------------------------------------------------- 
      DISANG=DIS/(0.3048**3) !Convertion to CFS !  (9.25.17)
      
      NNUMBER=0.0
      DO 50 I=1,600-1
      TIME=TIME+0.08333
      Hydro(I,1)=TIME
      IF (TIME.GT.FTIME.AND.TIME.LE.ETIME) THEN
      SS1(I,NA)=SS1(I,NA)+DISANG
      Hydro(I,2)=SS1(I,NA)*(0.3048**3) !Return hydrograph in CMS
      ELSE
      Hydro(I,2)=SS1(I,NA)*(0.3048**3)
      END IF
      IF (SS1(I,NA).GT.0) THEN
      NNUMBER=NNUMBER+1
      END IF
50    CONTINUE          

	SS1(600,NA)=NNUMBER
      END SUBROUTINE hydrog 
