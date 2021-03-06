C*************
      SUBROUTINE setmodel(iq)
      USE global
      INTEGER iq
      INCLUDE 'comopt.h'
      INCLUDE 'comforw.h'
      REAL fval              ! function for computation of real values
      INCLUDE './cprosim/Parms_com'
      INCLUDE 'gen_i_o_saga.h'
      INCLUDE './cprosim/sector_env_com'
      INTEGER i,ii
      REAL  xhelp
      DO i=1,nparm
        IF (par2phy(i).EQ.1) THEN
c***    this is the water depth
           R_h0(par3(i))=fval(model(i,iq),i)
        ELSEIF (par2phy(i).EQ.2) THEN
c***    this is the water velocity
c          WRITE(*,*)'fval', fval(model(i,iq),i)
           R_c0(par2lay(i),par3(i))=fval(model(i,iq),i)
        ELSEIF (par2phy(i).EQ.3) THEN
c***    this is the sediment velocity
           R_c1(par2lay(i),par3(i))=fval(model(i,iq),i)
        ELSEIF (par2phy(i).EQ.4) THEN
c***    this is the attenuation
           R_beta(par2lay(i),par3(i))=fval(model(i,iq),i)
cpln           WRITE(6,*)'#1: ',par2lay(i),par3(i),
cpln     .                R_beta(par2lay(i),par3(i))
        ELSEIF (par2phy(i).EQ.5) THEN
c***    this is the roughness
c           R_scatt(par2lay(i),par3(i))=fval(model(i,iq),i)
            WRITE(*,*) 'not available in prosim'
        ELSEIF (par2phy(i).EQ.6) THEN
c***    this is the sediment density
           R_r1(par3(i)) = fval(model(i,iq),i)
        ELSEIF (par2phy(i).EQ.8) THEN
c***    source depth
           zsrc(1)=fval(model(i,iq),i)
c***    receiver range...
        ELSEIF (par2phy(i).EQ.9) THEN
          xhelp=rkm(1)
          rkm(1)= fval(model(i,iq),i)
          xhelp=rkm(1)-xhelp
          DO ii=2,nx
             rkm(ii) = rkm(ii) + xhelp
          END DO
        ELSEIF (par2phy(i).EQ.11) THEN
c***    this is the EOF
           aeof(par2lay(i)) = fval(model(i,iq),i)
        ELSEIF (par2phy(i).EQ.12) THEN
c***    this is the bottom P-velocity
           R_c2(par3(i)) = fval(model(i,iq),i)
        ELSEIF (par2phy(i).EQ.13) THEN
c***    this is the bottom S-velocity
           R_c2s(par3(i)) = fval(model(i,iq),i)
        ELSEIF (par2phy(i).EQ.14) THEN
c***    this is the bottom density
           R_r2(par3(i)) = fval(model(i,iq),i)
        ELSEIF (par2phy(i).EQ.15) THEN
c***    this is the receiver depth
           xhelp=zrec(1)
           zrec(1) = fval(model(i,iq),i)
           xhelp=zrec(1)-xhelp
c THIS IS ONLY VALID FOR RI ENVIRONMENTS
           DO ii=2,ndep
              zrec(ii) = zrec(ii)+xhelp
           ENDDO
        ELSEIF (par2phy(i).EQ.16) THEN
c***    this is the velocity points in water
           R_z0(par2lay(i),par3(i)) = fval(model(i,iq),i)
           
        ELSEIF (par2phy(i).EQ.17) THEN
c***    this is the sediment depth
           R_h1(par3(i)) = fval(model(i,iq),i)
        ELSEIF (par2phy(i).EQ.18) THEN
c***    this is the velocity points in sediment
           R_z1(par2lay(i),par3(i)) = fval(model(i,iq),i)
        ELSEIF (par2phy(i).EQ.19) THEN
c***    this is tilt
           dtiltv = fval(model(i,iq),i)
c            WRITE(*,*) 'not available in prosim'
        ELSEIF (par2phy(i).EQ.20) THEN
c***    this is time delay
           del_time = fval(model(i,iq),i)
        ELSEIF (par2phy(i).EQ.21) THEN
c***    this is tilt
           dtilth = fval(model(i,iq),i)
        ELSE
          WRITE(*,*) ' setmodel: option not defined for parameter',i
        ENDIF
c        WRITE(prtfil,*)' setmodel:, i,fval',i,fval(model(i,iq),i)
      ENDDO
c      WRITE(*,*)'parameters'
c      WRITE(*,'(8f10.3)')(v(par2lay(i),par2phy(i)),i=1,nparm)      
c      DO i=1,nlay
c        WRITE(*,'(6f12.3)')(v(i,j),j=1,6)
c      ENDDO
      END
c*************
      SUBROUTINE setmodelbest(modelb)
      USE global
      INTEGER i,modelb(*),ii
      REAL  xhelp
      INCLUDE 'comopt.h'
      INCLUDE 'comforw.h'
      REAL fval              ! function for computation of real values
      INCLUDE './cprosim/Parms_com'
      INCLUDE 'gen_i_o_saga.h'
      INCLUDE './cprosim/sector_env_com'

      DO i=1,nparm
        IF (par2phy(i).EQ.1) THEN
c***    this is the water depth
           R_h0(par3(i))=fval(modelb(i),i)
        ELSEIF (par2phy(i).EQ.2) THEN
c***    this is the water velocity
c          WRITE(*,*)'fval', fval(modelb(i),i)
           R_c0(par2lay(i),par3(i))=fval(modelb(i),i)
        ELSEIF (par2phy(i).EQ.3) THEN
c***    this is the sediment velocity
           R_c1(par2lay(i),par3(i))=fval(modelb(i),i)
        ELSEIF (par2phy(i).EQ.4) THEN
c***    this is the sediment attenuation
           R_beta(par2lay(i),par3(i))=fval(modelb(i),i)
cpln           WRITE(6,*)'#2: ',par2lay(i),par3(i),
cpln     .                R_beta(par2lay(i),par3(i))
        ELSEIF (par2phy(i).EQ.5) THEN
c***    this is the roughness
c           R_scatt(par2lay(i),par3(i))=fval(modelb(i),i)
            WRITE(*,*) 'not available in prosim'
        ELSEIF (par2phy(i).EQ.6) THEN
c***    this is the sediment density
           R_r1(par3(i)) = fval(modelb(i),i)
        ELSEIF (par2phy(i).EQ.8) THEN
c***    source depth
           zsrc(1)=fval(modelb(i),i)
        ELSEIF (par2phy(i).EQ.9) THEN
c***    receiver range...
          xhelp=rkm(1)
          rkm(1)= fval(modelb(i),i)
          xhelp=rkm(1)-xhelp
          DO ii=2,nx
             rkm(ii) = rkm(ii) + xhelp
          END DO
        ELSEIF (par2phy(i).EQ.11) THEN
c***    this is the EOF
           aeof(par2lay(i)) = fval(modelb(i),i)
        ELSEIF (par2phy(i).EQ.12) THEN
c***    this is the bottom P-velocity
           R_c2(par3(i)) = fval(modelb(i),i)
        ELSEIF (par2phy(i).EQ.13) THEN
c***    this is the bottom S-velocity
           R_c2s(par3(i)) = fval(modelb(i),i)
        ELSEIF (par2phy(i).EQ.14) THEN
c***    this is the bottom density
           R_r2(par3(i)) = fval(modelb(i),i)
        ELSEIF (par2phy(i).EQ.15) THEN
c***    this is the receiver depth
           xhelp=zrec(1)
           zrec(1) = fval(modelb(i),i)
           xhelp=zrec(1)-xhelp
           DO ii=2,ndep
              zrec(ii) = zrec(ii)+xhelp
           ENDDO
        ELSEIF (par2phy(i).EQ.16) THEN
c***    this is the velocity points in water
           R_z0(par2lay(i),par3(i)) = fval(modelb(i),i)
        ELSEIF (par2phy(i).EQ.17) THEN
c***    this is the sediment depth
           R_h1(par3(i)) = fval(modelb(i),i)
        ELSEIF (par2phy(i).EQ.18) THEN
c***    this is the velocity points in sediment
           R_z1(par2lay(i),par3(i)) = fval(modelb(i),i)
        ELSEIF (par2phy(i).EQ.19) THEN
c***    this is tilt
c            WRITE(*,*) 'not available in prosim'
           dtiltv = fval(modelb(i),i)
        ELSEIF (par2phy(i).EQ.20) THEN
c***    this is time delay
           del_time = fval(modelb(i),i)
        ELSEIF (par2phy(i).EQ.21) THEN
c***    this is tilt
c            WRITE(*,*) 'not available in prosim'
           dtilth = fval(modelb(i),i)
        ELSE
          WRITE(*,*) ' prosiminter: option not defined'
        ENDIF
      ENDDO
      END

      SUBROUTINE setmodelreal(x)
      USE global
      INCLUDE 'comopt.h'
      INCLUDE 'comforw.h'
      INCLUDE './cprosim/Parms_com'
      INCLUDE 'gen_i_o_saga.h'
      INCLUDE './cprosim/sector_env_com'

      INTEGER i,ii
      REAL x(*),xhelp
      DO i=1,nparm
        IF (par2phy(i).EQ.1) THEN
c***    this is the water depth
           R_h0(par3(i))=x(i)
        ELSEIF (par2phy(i).EQ.2) THEN
c***    this is the water velocity
c          WRITE(*,*)'fval', fval(modelb(i),i)
           R_c0(par2lay(i),par3(i))=x(i)
        ELSEIF (par2phy(i).EQ.3) THEN
c***    this is the sediment velocity
           R_c1(par2lay(i),par3(i))=x(i)
        ELSEIF (par2phy(i).EQ.4) THEN
c***    this is the  attenuation
           R_beta(par2lay(i),par3(i))=x(i)
cpln           WRITE(6,*)'#3: ',par2lay(i),par3(i),
cpln     .                R_beta(par2lay(i),par3(i))
        ELSEIF (par2phy(i).EQ.5) THEN
c***    this is the roughness
c           R_scatt(par2lay(i),par3(i))=x(i)
            WRITE(*,*) 'not available in prosim'
        ELSEIF (par2phy(i).EQ.6) THEN
c***    this is the sediment density
           R_r1(par3(i)) = x(i)
        ELSEIF (par2phy(i).EQ.8) THEN
c***    source depth
           zsrc(1)=x(i)
        ELSEIF (par2phy(i).EQ.9) THEN
c***    receiver range...
          xhelp=rkm(1)
          rkm(1)= x(i)
          xhelp=rkm(1)-xhelp
          DO ii=2,nx
             rkm(ii) = rkm(ii) + xhelp
          END DO
        ELSEIF (par2phy(i).EQ.11) THEN
c***    this is the EOF
           aeof(par2lay(i)) = x(i)
        ELSEIF (par2phy(i).EQ.12) THEN
c***    this is the bottom P-velocity
           R_c2(par3(i)) = x(i)
        ELSEIF (par2phy(i).EQ.13) THEN
c***    this is the bottom S-velocity
           R_c2s(par3(i)) =x(i)
        ELSEIF (par2phy(i).EQ.14) THEN
c***    this is the bottom density
           R_r2(par3(i)) = x(i)
        ELSEIF (par2phy(i).EQ.15) THEN
c***    this is the receiver depth
           xhelp=zrec(1)
           zrec(1) = x(i)
           xhelp=zrec(1)-xhelp
           DO ii=2,ndep
              zrec(ii) = zrec(ii)+xhelp
           ENDDO
        ELSEIF (par2phy(i).EQ.16) THEN
c***    this is the velocity points in water
           R_z0(par2lay(i),par3(i)) = x(i)
        ELSEIF (par2phy(i).EQ.17) THEN
c***    this is the sediment depth
           R_h1(par3(i)) = x(i)
        ELSEIF (par2phy(i).EQ.18) THEN
c***    this is the velocity points in sediment
           R_z1(par2lay(i),par3(i)) = x(i)
        ELSEIF (par2phy(i).EQ.19) THEN
c***    this is tilt
c            WRITE(*,*) 'not available in prosim'
           dtiltv = x(i)
        ELSEIF (par2phy(i).EQ.20) THEN
c***    this is time delay
           del_time = x(i)
        ELSEIF (par2phy(i).EQ.21) THEN
c***    this is tilt
c            WRITE(*,*) 'not available in prosim'
           dtilth = x(i)
        ELSE
          WRITE(*,*) ' prosiminter: option not defined'
        ENDIF
      ENDDO
      END
c********************
      SUBROUTINE getmodelreal(x)
      USE global
      INCLUDE 'comopt.h'
      INCLUDE 'comforw.h'
      INCLUDE './cprosim/Parms_com'
      INCLUDE 'gen_i_o_saga.h'
      INCLUDE './cprosim/sector_env_com'

      INTEGER i
      REAL x(*)
      DO i=1,nparm
        IF (par2phy(i).EQ.1) THEN
c***    this is the water depth
           x(i)=R_h0(par3(i))
        ELSEIF (par2phy(i).EQ.2) THEN
c***    this is the water velocity
          x(i)=R_c0(par2lay(i),par3(i))
        ELSEIF (par2phy(i).EQ.3) THEN
c***    this is the sediment velocity
           x(i)= R_c1(par2lay(i),par3(i))
        ELSEIF (par2phy(i).EQ.4) THEN
c***    this is the sediment attenuation
            x(i)=R_beta(par2lay(i),par3(i))
cpln           WRITE(6,*)'#4: ',par2lay(i),par3(i),
cpln     .                R_beta(par2lay(i),par3(i))
        ELSEIF (par2phy(i).EQ.5) THEN
c***    this is the roughness
c           x(i)=R_scatt(par2lay(i),par3(i))
            WRITE(*,*) 'not available in prosim'
        ELSEIF (par2phy(i).EQ.6) THEN
c***    this is the sediment density
            x(i)=R_r1(par3(i)) 
        ELSEIF (par2phy(i).EQ.8) THEN
c***    source depth
            x(i)=zsrc(1)
        ELSEIF (par2phy(i).EQ.9) THEN
c***    receiver range...
          x(i)= rkm(1)
        ELSEIF (par2phy(i).EQ.11) THEN
c***    this is the EOF
           x(i)=aeof(par2lay(i)) 
        ELSEIF (par2phy(i).EQ.12) THEN
c***    this is the bottom P-velocity
           x(i) = R_c2(par3(i)) 
        ELSEIF (par2phy(i).EQ.13) THEN
c***    this is the bottom S-velocity
           x(i) = R_c2s(par3(i)) 
        ELSEIF (par2phy(i).EQ.14) THEN
c***    this is the bottom density
           x(i) = R_r2(par3(i))
        ELSEIF (par2phy(i).EQ.15) THEN
c***    this is the receiver depth
           x(i) = zrec(1) 
c           fldrd(2) = fldrd(1)+fldrd(3)*(ndep-1)
        ELSEIF (par2phy(i).EQ.16) THEN
c***    this is the velocity points in water
            x(i)= R_z0(par2lay(i),par3(i))
        ELSEIF (par2phy(i).EQ.17) THEN
c***    this is the sediment depth
          x(i)=R_h1(par3(i))
        ELSEIF (par2phy(i).EQ.18) THEN
c***    this is the velocity points in sediment
            x(i)= R_z1(par2lay(i),par3(i))
        ELSEIF (par2phy(i).EQ.19) THEN
c***    this is tilt
c            WRITE(*,*) 'not available in prosim'
           x(i)=dtiltv
        ELSEIF (par2phy(i).EQ.20) THEN
c***    this is time delay
           x(i)=del_time 
        ELSEIF (par2phy(i).EQ.21) THEN
c***    this is tilt
c            WRITE(*,*) 'not available in prosim'
           x(i)=dtilth
        ELSE
          WRITE(*,*) ' prosiminter: option not defined'
        ENDIF
      ENDDO
      END
c*********************
      SUBROUTINE setmodelx(ixlay,ixpar,iz,theta1)
      USE global
      INCLUDE 'comopt.h'
      INCLUDE 'comforw.h'
      INCLUDE './cprosim/Parms_com'
      INCLUDE 'gen_i_o_saga.h'
      INCLUDE './cprosim/sector_env_com'

      INTEGER ixlay,ixpar,iz,ii
      REAL theta1,xhelp
         IF (ixpar.EQ.1) THEN
c***    this is the water depth
           R_h0(iz)=theta1
        ELSEIF (ixpar.EQ.2) THEN
c***    this is the water velocity
c          WRITE(*,*)'fval', theta
           R_c0(ixlay,iz)=theta1
        ELSEIF (ixpar.EQ.3) THEN
c***    this is the sediment velocity
           R_c1(ixlay,iz)=theta1
        ELSEIF (ixpar.EQ.4) THEN
c***    this is the attenuation
           R_beta(ixlay,iz)=theta1
cpln           WRITE(6,*)'#5: ',ixlay,iz,
cpln     .                R_beta(ixlay,iz)
        ELSEIF (ixpar.EQ.5) THEN
c***    this is the roughness
c           R_scatt(ixlay,iz)=theta
            WRITE(*,*) 'not available in prosim'
        ELSEIF (ixpar.EQ.6) THEN
c***    this is the sediment density
           R_r1(iz) = theta1
        ELSEIF (ixpar.EQ.8) THEN
c***    source depth
           zsrc(1)=theta1
        ELSEIF (ixpar.EQ.9) THEN
c***    receiver range...
          xhelp=rkm(1)
          rkm(1)= theta1
          xhelp=rkm(1)-xhelp
          DO ii=2,nx
             rkm(ii) = rkm(ii) + xhelp
          END DO
        ELSEIF (ixpar.EQ.11) THEN
c***    this is the EOF
           aeof(ixlay) = theta1
        ELSEIF (ixpar.EQ.12) THEN
c***    this is the bottom P-velocity
           R_c2(iz) = theta1
        ELSEIF (ixpar.EQ.13) THEN
c***    this is the bottom S-velocity
      	   R_c2s(iz) =theta1
        ELSEIF (ixpar.EQ.14) THEN
c***    this is the bottom density
           R_r2(iz) = theta1
        ELSEIF (ixpar.EQ.15) THEN
c***    this is the receiver depth
           xhelp=zrec(1)
           zrec(1) =  theta1
           xhelp=zrec(1)-xhelp
           DO ii=2,ndep
              zrec(ii) = zrec(ii)+xhelp
           ENDDO
        ELSEIF (ixpar.EQ.16) THEN
c***    this is the velocity points in water
            R_z0(ixlay,iz)= theta1
        ELSEIF (ixpar.EQ.17) THEN
c***    this is the sediment depth
          R_h1(iz)=theta1
        ELSEIF (ixpar.EQ.18) THEN
c***    this is the velocity points in sediment
            R_z1(ixlay,iz)= theta1
        ELSEIF (ixpar.EQ.19) THEN
c***    this is tilt
c            WRITE(*,*) 'not available in prosim'
           dtiltv = theta1
        ELSEIF (ixpar.EQ.20) THEN
c***    this is time delay
           del_time =theta1
        ELSEIF (ixpar.EQ.21) THEN
c***    this is tilt
c            WRITE(*,*) 'not available in prosim'
           dtilth = theta1
        ELSE
          WRITE(*,*) ' prosiminter: option not defined'
        ENDIF
    
      END

c*************
      SUBROUTINE setmodeleof(x)
      USE global
      INCLUDE 'comopt.h'
      INCLUDE 'comforw.h'
      INCLUDE './cprosim/Parms_com'
      INCLUDE 'gen_i_o_saga.h'
      INCLUDE './cprosim/sector_env_com'

      INTEGER i,ii
      REAL x(*),xhelp
      DO i=1,neofvar
        IF (par2phy_eof(i).EQ.1) THEN
c***    this is the water depth
           R_h0(par3_eof(i)) = x(i)
        ELSEIF (par2phy_eof(i).EQ.2) THEN
c***    this is the water velocity
c          WRITE(*,*)'fval', fval(modelb(i),i)
           R_c0(par2lay_eof(i),par3_eof(i))=x(i)
        ELSEIF (par2phy_eof(i).EQ.3) THEN
c***    this is the sediment velocity
           R_c1(par2lay_eof(i),par3_eof(i))=x(i)
        ELSEIF (par2phy_eof(i).EQ.4) THEN
c***    this is the sediment attenuation
           R_beta(par2lay_eof(i),par3_eof(i))=x(i)
cpln           WRITE(6,*)'#6: ',par2lay_eof(i),par3_eof(i),
cpln     .                R_beta(par2lay_eof(i),par3_eof(i))
        ELSEIF (par2phy_eof(i).EQ.5) THEN
c***    this is the roughness
c           R_scatt(par2lay_eof(i),par3_eof(i))=x(i)
            WRITE(*,*) 'not available in prosim'
        ELSEIF (par2phy_eof(i).EQ.6) THEN
c***    this is the sediment density
           R_r1(par3_eof(i)) = x(i)
        ELSEIF (par2phy_eof(i).EQ.8) THEN
c***    source depth
           zsrc(1)=x(i)
        ELSEIF (par2phy_eof(i).EQ.9) THEN
c***    receiver range...
          xhelp=rkm(1)
          rkm(1)= x(i)
          xhelp=rkm(1)-xhelp
          DO ii=2,nx
             rkm(ii) = rkm(ii) + xhelp
          END DO
        ELSEIF (par2phy_eof(i).EQ.12) THEN
c***    this is the bottom P-velocity
           R_c2(par3_eof(i)) = x(i)
        ELSEIF (par2phy_eof(i).EQ.13) THEN
c***    this is the bottom S-velocity
           R_c2s(par3_eof(i)) = x(i)
        ELSEIF (par2phy_eof(i).EQ.14) THEN
c***    this is the bottom density
           R_r2(par3_eof(i)) = x(i)
        ELSEIF (par2phy_eof(i).EQ.15) THEN
c***    this is the receiver depth
           xhelp=zrec(1)
           zrec(1) = x(i)
           xhelp=zrec(1)-xhelp
           DO ii=2,ndep
              zrec(ii) = zrec(ii)+xhelp
           ENDDO
        ELSEIF (par2phy_eof(i).EQ.16) THEN
c***    this is the velocity points in water
           R_z0(par2lay_eof(i),par3_eof(i)) = x(i)
        ELSEIF (par2phy_eof(i).EQ.17) THEN
c***    this is the sediment depth
           R_h1(par3_eof(i)) = x(i)
        ELSEIF (par2phy_eof(i).EQ.18) THEN
c***    this is the velocity points in sedimet
           R_z1(par2lay_eof(i),par3_eof(i)) = x(i)
        ELSEIF (par2phy_eof(i).EQ.19) THEN
c***    this is tilt
c            WRITE(*,*) 'not available in prosim'
           dtiltv = x(i)
        ELSEIF (par2phy_eof(i).EQ.20) THEN
c***    this is time delay
           del_time=x(i) 
        ELSEIF (par2phy_eof(i).EQ.21) THEN
c***    this is tilt
c            WRITE(*,*) 'not available in prosim'
           dtilth = x(i)
        ELSE
          WRITE(*,*) ' prosiminter: option not defined'
        ENDIF
c        WRITE(*,*)par2phy_eof(i),par2lay_eof(i),x(i)
      ENDDO
      END






