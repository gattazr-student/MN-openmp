#-------------------------------------------------
# VARIABLES
#-------------------------------------------------
CC=gcc
CFLAGS=-Wall -pedantic -Iincludes/ -g -msse4.2 -fopenmp -O2
LDFLAGS=-Llib/
LIBRARIES_VECT=-lvect
LIBRARIES_MATR=-lmatr

#-----
# LIBS
#-----
SRCS_LIBVECT=src/vectb.c src/vects.c
OBJS_LIBVECT=$(subst src,obj,$(SRCS_LIBVECT:.c=.o))
LIBVECT=lib/libvect.a

SRCS_LIBMATR=src/matrb.c src/matrs.c
OBJS_LIBMATR=$(subst src,obj,$(SRCS_LIBMATR:.c=.o))
LIBMATR=lib/libmatr.a

LIBS= $(LIBVECT) $(LIBMATR)

#------
# PERFS
#------
# Vecteurs
SRCS_VPERF1=perfs/src/vectbd_add.c perfs/src/myTime.c
OBJS_VPERF1=$(subst src,obj,$(SRCS_VPERF1:.c=.o))
EXEC_VPERF1=perfs/bin/vectbd_add

SRCS_VPERF2=perfs/src/vectbd_addVect.c perfs/src/myTime.c
OBJS_VPERF2=$(subst src,obj,$(SRCS_VPERF2:.c=.o))
EXEC_VPERF2=perfs/bin/vectbd_addVect

SRCS_VPERF3=perfs/src/vectbd_mult.c perfs/src/myTime.c
OBJS_VPERF3=$(subst src,obj,$(SRCS_VPERF3:.c=.o))
EXEC_VPERF3=perfs/bin/vectbd_mult

SRCS_VPERF4=perfs/src/vectbd_scal.c perfs/src/myTime.c
OBJS_VPERF4=$(subst src,obj,$(SRCS_VPERF4:.c=.o))
EXEC_VPERF4=perfs/bin/vectbd_scal

SRCS_VPERF5=perfs/src/vectbd_scalVect.c perfs/src/myTime.c
OBJS_VPERF5=$(subst src,obj,$(SRCS_VPERF5:.c=.o))
EXEC_VPERF5=perfs/bin/vectbd_scalVect

SRCS_VPERF6=perfs/src/vectbf_add.c perfs/src/myTime.c
OBJS_VPERF6=$(subst src,obj,$(SRCS_VPERF6:.c=.o))
EXEC_VPERF6=perfs/bin/vectbf_add

SRCS_VPERF7=perfs/src/vectbf_addVect.c perfs/src/myTime.c
OBJS_VPERF7=$(subst src,obj,$(SRCS_VPERF7:.c=.o))
EXEC_VPERF7=perfs/bin/vectbf_addVect

SRCS_VPERF8=perfs/src/vectbf_mult.c perfs/src/myTime.c
OBJS_VPERF8=$(subst src,obj,$(SRCS_VPERF8:.c=.o))
EXEC_VPERF8=perfs/bin/vectbf_mult

SRCS_VPERF9=perfs/src/vectbf_scal.c perfs/src/myTime.c
OBJS_VPERF9=$(subst src,obj,$(SRCS_VPERF9:.c=.o))
EXEC_VPERF9=perfs/bin/vectbf_scal

SRCS_VPERF10=perfs/src/vectbf_scalVect.c perfs/src/myTime.c
OBJS_VPERF10=$(subst src,obj,$(SRCS_VPERF10:.c=.o))
EXEC_VPERF10=perfs/bin/vectbf_scalVect

SRCS_VPERF11=perfs/src/vectsd_add.c perfs/src/myTime.c
OBJS_VPERF11=$(subst src,obj,$(SRCS_VPERF11:.c=.o))
EXEC_VPERF11=perfs/bin/vectsd_add

SRCS_VPERF12=perfs/src/vectsd_addVect.c perfs/src/myTime.c
OBJS_VPERF12=$(subst src,obj,$(SRCS_VPERF12:.c=.o))
EXEC_VPERF12=perfs/bin/vectsd_addVect

SRCS_VPERF13=perfs/src/vectsd_mult.c perfs/src/myTime.c
OBJS_VPERF13=$(subst src,obj,$(SRCS_VPERF13:.c=.o))
EXEC_VPERF13=perfs/bin/vectsd_mult

SRCS_VPERF14=perfs/src/vectsd_scal.c perfs/src/myTime.c
OBJS_VPERF14=$(subst src,obj,$(SRCS_VPERF14:.c=.o))
EXEC_VPERF14=perfs/bin/vectsd_scal

SRCS_VPERF15=perfs/src/vectsd_scalVect.c perfs/src/myTime.c
OBJS_VPERF15=$(subst src,obj,$(SRCS_VPERF15:.c=.o))
EXEC_VPERF15=perfs/bin/vectsd_scalVect

SRCS_VPERF16=perfs/src/vectsf_add.c perfs/src/myTime.c
OBJS_VPERF16=$(subst src,obj,$(SRCS_VPERF16:.c=.o))
EXEC_VPERF16=perfs/bin/vectsf_add

SRCS_VPERF17=perfs/src/vectsf_addVect.c perfs/src/myTime.c
OBJS_VPERF17=$(subst src,obj,$(SRCS_VPERF17:.c=.o))
EXEC_VPERF17=perfs/bin/vectsf_addVect

SRCS_VPERF18=perfs/src/vectsf_mult.c perfs/src/myTime.c
OBJS_VPERF18=$(subst src,obj,$(SRCS_VPERF18:.c=.o))
EXEC_VPERF18=perfs/bin/vectsf_mult

SRCS_VPERF19=perfs/src/vectsf_scal.c perfs/src/myTime.c
OBJS_VPERF19=$(subst src,obj,$(SRCS_VPERF19:.c=.o))
EXEC_VPERF19=perfs/bin/vectsf_scal

SRCS_VPERF20=perfs/src/vectsf_scalVect.c perfs/src/myTime.c
OBJS_VPERF20=$(subst src,obj,$(SRCS_VPERF20:.c=.o))
EXEC_VPERF20=perfs/bin/vectsf_scalVect


# Matrices
SRCS_MPERF1=perfs/src/matrbd_add.c perfs/src/myTime.c
OBJS_MPERF1=$(subst src,obj,$(SRCS_MPERF1:.c=.o))
EXEC_MPERF1=perfs/bin/matrbd_add

SRCS_MPERF2=perfs/src/matrbd_addVect.c perfs/src/myTime.c
OBJS_MPERF2=$(subst src,obj,$(SRCS_MPERF2:.c=.o))
EXEC_MPERF2=perfs/bin/matrbd_addVect

SRCS_MPERF3=perfs/src/matrbd_factLU.c perfs/src/myTime.c
OBJS_MPERF3=$(subst src,obj,$(SRCS_MPERF3:.c=.o))
EXEC_MPERF3=perfs/bin/matrbd_factLU

SRCS_MPERF4=perfs/src/matrbd_gaxpy.c perfs/src/myTime.c
OBJS_MPERF4=$(subst src,obj,$(SRCS_MPERF4:.c=.o))
EXEC_MPERF4=perfs/bin/matrbd_gaxpy

SRCS_MPERF5=perfs/src/matrbd_mScalaire.c perfs/src/myTime.c
OBJS_MPERF5=$(subst src,obj,$(SRCS_MPERF5:.c=.o))
EXEC_MPERF5=perfs/bin/matrbd_mScalaire

SRCS_MPERF6=perfs/src/matrbd_mult.c perfs/src/myTime.c
OBJS_MPERF6=$(subst src,obj,$(SRCS_MPERF6:.c=.o))
EXEC_MPERF6=perfs/bin/matrbd_mult

SRCS_MPERF7=perfs/src/matrbd_multVect.c perfs/src/myTime.c
OBJS_MPERF7=$(subst src,obj,$(SRCS_MPERF7:.c=.o))
EXEC_MPERF7=perfs/bin/matrbd_multVect

SRCS_MPERF8=perfs/src/matrbd_transpo.c perfs/src/myTime.c
OBJS_MPERF8=$(subst src,obj,$(SRCS_MPERF8:.c=.o))
EXEC_MPERF8=perfs/bin/matrbd_transpo

SRCS_MPERF9=perfs/src/matrbf_add.c perfs/src/myTime.c
OBJS_MPERF9=$(subst src,obj,$(SRCS_MPERF9:.c=.o))
EXEC_MPERF9=perfs/bin/matrbf_add

SRCS_MPERF10=perfs/src/matrbf_addVect.c perfs/src/myTime.c
OBJS_MPERF10=$(subst src,obj,$(SRCS_MPERF10:.c=.o))
EXEC_MPERF10=perfs/bin/matrbf_addVect

SRCS_MPERF11=perfs/src/matrbf_factLU.c perfs/src/myTime.c
OBJS_MPERF11=$(subst src,obj,$(SRCS_MPERF11:.c=.o))
EXEC_MPERF11=perfs/bin/matrbf_factLU

SRCS_MPERF12=perfs/src/matrbf_gaxpy.c perfs/src/myTime.c
OBJS_MPERF12=$(subst src,obj,$(SRCS_MPERF12:.c=.o))
EXEC_MPERF12=perfs/bin/matrbf_gaxpy

SRCS_MPERF13=perfs/src/matrbf_mScalaire.c perfs/src/myTime.c
OBJS_MPERF13=$(subst src,obj,$(SRCS_MPERF13:.c=.o))
EXEC_MPERF13=perfs/bin/matrbf_mScalaire

SRCS_MPERF14=perfs/src/matrbf_mult.c perfs/src/myTime.c
OBJS_MPERF14=$(subst src,obj,$(SRCS_MPERF14:.c=.o))
EXEC_MPERF14=perfs/bin/matrbf_mult

SRCS_MPERF15=perfs/src/matrbf_multVect.c perfs/src/myTime.c
OBJS_MPERF15=$(subst src,obj,$(SRCS_MPERF15:.c=.o))
EXEC_MPERF15=perfs/bin/matrbf_multVect

SRCS_MPERF16=perfs/src/matrbf_transpo.c perfs/src/myTime.c
OBJS_MPERF16=$(subst src,obj,$(SRCS_MPERF16:.c=.o))
EXEC_MPERF16=perfs/bin/matrbf_transpo

SRCS_MPERF17=perfs/src/matrsd_add.c perfs/src/myTime.c
OBJS_MPERF17=$(subst src,obj,$(SRCS_MPERF17:.c=.o))
EXEC_MPERF17=perfs/bin/matrsd_add

SRCS_MPERF18=perfs/src/matrsd_addVect.c perfs/src/myTime.c
OBJS_MPERF18=$(subst src,obj,$(SRCS_MPERF18:.c=.o))
EXEC_MPERF18=perfs/bin/matrsd_addVect

SRCS_MPERF19=perfs/src/matrsd_factLU.c perfs/src/myTime.c
OBJS_MPERF19=$(subst src,obj,$(SRCS_MPERF19:.c=.o))
EXEC_MPERF19=perfs/bin/matrsd_factLU

SRCS_MPERF20=perfs/src/matrsd_gaxpy.c perfs/src/myTime.c
OBJS_MPERF20=$(subst src,obj,$(SRCS_MPERF20:.c=.o))
EXEC_MPERF20=perfs/bin/matrsd_gaxpy

SRCS_MPERF21=perfs/src/matrsd_mScalaire.c perfs/src/myTime.c
OBJS_MPERF21=$(subst src,obj,$(SRCS_MPERF21:.c=.o))
EXEC_MPERF21=perfs/bin/matrsd_mScalaire

SRCS_MPERF22=perfs/src/matrsd_mult.c perfs/src/myTime.c
OBJS_MPERF22=$(subst src,obj,$(SRCS_MPERF22:.c=.o))
EXEC_MPERF22=perfs/bin/matrsd_mult

SRCS_MPERF23=perfs/src/matrsd_multVect.c perfs/src/myTime.c
OBJS_MPERF23=$(subst src,obj,$(SRCS_MPERF23:.c=.o))
EXEC_MPERF23=perfs/bin/matrsd_multVect

SRCS_MPERF24=perfs/src/matrsd_transpo.c perfs/src/myTime.c
OBJS_MPERF24=$(subst src,obj,$(SRCS_MPERF24:.c=.o))
EXEC_MPERF24=perfs/bin/matrsd_transpo

SRCS_MPERF25=perfs/src/matrsf_add.c perfs/src/myTime.c
OBJS_MPERF25=$(subst src,obj,$(SRCS_MPERF25:.c=.o))
EXEC_MPERF25=perfs/bin/matrsf_add

SRCS_MPERF26=perfs/src/matrsf_addVect.c perfs/src/myTime.c
OBJS_MPERF26=$(subst src,obj,$(SRCS_MPERF26:.c=.o))
EXEC_MPERF26=perfs/bin/matrsf_addVect

SRCS_MPERF27=perfs/src/matrsf_factLU.c perfs/src/myTime.c
OBJS_MPERF27=$(subst src,obj,$(SRCS_MPERF27:.c=.o))
EXEC_MPERF27=perfs/bin/matrsf_factLU

SRCS_MPERF28=perfs/src/matrsf_gaxpy.c perfs/src/myTime.c
OBJS_MPERF28=$(subst src,obj,$(SRCS_MPERF28:.c=.o))
EXEC_MPERF28=perfs/bin/matrsf_gaxpy

SRCS_MPERF29=perfs/src/matrsf_mScalaire.c perfs/src/myTime.c
OBJS_MPERF29=$(subst src,obj,$(SRCS_MPERF29:.c=.o))
EXEC_MPERF29=perfs/bin/matrsf_mScalaire

SRCS_MPERF30=perfs/src/matrsf_mult.c perfs/src/myTime.c
OBJS_MPERF30=$(subst src,obj,$(SRCS_MPERF30:.c=.o))
EXEC_MPERF30=perfs/bin/matrsf_mult

SRCS_MPERF31=perfs/src/matrsf_multVect.c perfs/src/myTime.c
OBJS_MPERF31=$(subst src,obj,$(SRCS_MPERF31:.c=.o))
EXEC_MPERF31=perfs/bin/matrsf_multVect

SRCS_MPERF32=perfs/src/matrsf_transpo.c perfs/src/myTime.c
OBJS_MPERF32=$(subst src,obj,$(SRCS_MPERF32:.c=.o))
EXEC_MPERF32=perfs/bin/matrsf_transpo

EXECS_PERF_VECT= $(EXEC_VPERF1) $(EXEC_VPERF2) $(EXEC_VPERF3) $(EXEC_VPERF4) $(EXEC_VPERF5) $(EXEC_VPERF6) $(EXEC_VPERF7) $(EXEC_VPERF8) $(EXEC_VPERF9) $(EXEC_VPERF10) $(EXEC_VPERF11) $(EXEC_VPERF12) $(EXEC_VPERF13) $(EXEC_VPERF14) $(EXEC_VPERF15) $(EXEC_VPERF16) $(EXEC_VPERF17) $(EXEC_VPERF18) $(EXEC_VPERF19) $(EXEC_VPERF20)

EXECS_PERF_MATR= $(EXEC_MPERF1) $(EXEC_MPERF2) $(EXEC_MPERF3) $(EXEC_MPERF4) $(EXEC_MPERF5) $(EXEC_MPERF6) $(EXEC_MPERF7) $(EXEC_MPERF8) $(EXEC_MPERF9) $(EXEC_MPERF10) $(EXEC_MPERF11) $(EXEC_MPERF12) $(EXEC_MPERF13) $(EXEC_MPERF14) $(EXEC_MPERF15) $(EXEC_MPERF16) $(EXEC_MPERF17) $(EXEC_MPERF18) $(EXEC_MPERF19) $(EXEC_MPERF20) $(EXEC_MPERF21) $(EXEC_MPERF22) $(EXEC_MPERF23) $(EXEC_MPERF24) $(EXEC_MPERF25) $(EXEC_MPERF26) $(EXEC_MPERF27) $(EXEC_MPERF28) $(EXEC_MPERF29) $(EXEC_MPERF30) $(EXEC_MPERF31) $(EXEC_MPERF32)

#------
# TESTS
#------

# Vecteurs
SRCS_VTEST1=tests/src/test_bdv.c
OBJS_VTEST1=$(subst src,obj,$(SRCS_VTEST1:.c=.o))
EXEC_VTEST1=tests/bin/test_bdv

SRCS_VTEST2=tests/src/test_bfv.c
OBJS_VTEST2=$(subst src,obj,$(SRCS_VTEST2:.c=.o))
EXEC_VTEST2=tests/bin/test_bfv

SRCS_VTEST3=tests/src/test_sdv.c
OBJS_VTEST3=$(subst src,obj,$(SRCS_VTEST3:.c=.o))
EXEC_VTEST3=tests/bin/test_sdv

SRCS_VTEST4=tests/src/test_sfv.c
OBJS_VTEST4=$(subst src,obj,$(SRCS_VTEST4:.c=.o))
EXEC_VTEST4=tests/bin/test_sfv

# Matrices
SRCS_MTEST1=tests/src/test_bdm.c
OBJS_MTEST1=$(subst src,obj,$(SRCS_MTEST1:.c=.o))
EXEC_MTEST1=tests/bin/test_bdm

SRCS_MTEST2=tests/src/test_bfm.c
OBJS_MTEST2=$(subst src,obj,$(SRCS_MTEST2:.c=.o))
EXEC_MTEST2=tests/bin/test_bfm

SRCS_MTEST3=tests/src/test_sdm.c
OBJS_MTEST3=$(subst src,obj,$(SRCS_MTEST3:.c=.o))
EXEC_MTEST3=tests/bin/test_sdm

SRCS_MTEST4=tests/src/test_sfm.c
OBJS_MTEST4=$(subst src,obj,$(SRCS_MTEST4:.c=.o))
EXEC_MTEST4=tests/bin/test_sfm


EXECS_TSTS_VECT= $(EXEC_VTEST1) $(EXEC_VTEST2) $(EXEC_VTEST3) $(EXEC_VTEST4)
EXECS_TSTS_MATR= $(EXEC_MTEST1) $(EXEC_MTEST2) $(EXEC_MTEST3) $(EXEC_MTEST4)


#-------------------------------------------------
# LINKINGS
#-------------------------------------------------
all: libs

#-----
# LIBS
#-----
libs: $(LIBS)

$(LIBVECT): $(OBJS_LIBVECT)
	ar -cq $@ $(OBJS_LIBVECT)

$(LIBMATR): $(OBJS_LIBMATR)
	ar -cq $@ $(OBJS_LIBMATR)

#------
# PERFS
#------
perfs: libs perfs_vect perfs_matr

perfs_vect: $(EXECS_PERF_VECT)

perfs_matr: $(EXECS_PERF_MATR)

# Vecteurs
$(EXEC_VPERF1): $(OBJS_VPERF1)
	$(CC) $(CFLAGS) -o $@ $(OBJS_VPERF1) $(LDFLAGS) $(LIBRARIES_VECT)
$(EXEC_VPERF2): $(OBJS_VPERF2)
	$(CC) $(CFLAGS) -o $@ $(OBJS_VPERF2) $(LDFLAGS) $(LIBRARIES_VECT)
$(EXEC_VPERF3): $(OBJS_VPERF3)
	$(CC) $(CFLAGS) -o $@ $(OBJS_VPERF3) $(LDFLAGS) $(LIBRARIES_VECT)
$(EXEC_VPERF4): $(OBJS_VPERF4)
	$(CC) $(CFLAGS) -o $@ $(OBJS_VPERF4) $(LDFLAGS) $(LIBRARIES_VECT)
$(EXEC_VPERF5): $(OBJS_VPERF5)
	$(CC) $(CFLAGS) -o $@ $(OBJS_VPERF5) $(LDFLAGS) $(LIBRARIES_VECT)
$(EXEC_VPERF6): $(OBJS_VPERF6)
	$(CC) $(CFLAGS) -o $@ $(OBJS_VPERF6) $(LDFLAGS) $(LIBRARIES_VECT)
$(EXEC_VPERF7): $(OBJS_VPERF7)
	$(CC) $(CFLAGS) -o $@ $(OBJS_VPERF7) $(LDFLAGS) $(LIBRARIES_VECT)
$(EXEC_VPERF8): $(OBJS_VPERF8)
	$(CC) $(CFLAGS) -o $@ $(OBJS_VPERF8) $(LDFLAGS) $(LIBRARIES_VECT)
$(EXEC_VPERF9): $(OBJS_VPERF9)
	$(CC) $(CFLAGS) -o $@ $(OBJS_VPERF9) $(LDFLAGS) $(LIBRARIES_VECT)
$(EXEC_VPERF10): $(OBJS_VPERF10)
	$(CC) $(CFLAGS) -o $@ $(OBJS_VPERF10) $(LDFLAGS) $(LIBRARIES_VECT)
$(EXEC_VPERF11): $(OBJS_VPERF11)
	$(CC) $(CFLAGS) -o $@ $(OBJS_VPERF11) $(LDFLAGS) $(LIBRARIES_VECT)
$(EXEC_VPERF12): $(OBJS_VPERF12)
	$(CC) $(CFLAGS) -o $@ $(OBJS_VPERF12) $(LDFLAGS) $(LIBRARIES_VECT)
$(EXEC_VPERF13): $(OBJS_VPERF13)
	$(CC) $(CFLAGS) -o $@ $(OBJS_VPERF13) $(LDFLAGS) $(LIBRARIES_VECT)
$(EXEC_VPERF14): $(OBJS_VPERF14)
	$(CC) $(CFLAGS) -o $@ $(OBJS_VPERF14) $(LDFLAGS) $(LIBRARIES_VECT)
$(EXEC_VPERF15): $(OBJS_VPERF15)
	$(CC) $(CFLAGS) -o $@ $(OBJS_VPERF15) $(LDFLAGS) $(LIBRARIES_VECT)
$(EXEC_VPERF16): $(OBJS_VPERF16)
	$(CC) $(CFLAGS) -o $@ $(OBJS_VPERF16) $(LDFLAGS) $(LIBRARIES_VECT)
$(EXEC_VPERF17): $(OBJS_VPERF17)
	$(CC) $(CFLAGS) -o $@ $(OBJS_VPERF17) $(LDFLAGS) $(LIBRARIES_VECT)
$(EXEC_VPERF18): $(OBJS_VPERF18)
	$(CC) $(CFLAGS) -o $@ $(OBJS_VPERF18) $(LDFLAGS) $(LIBRARIES_VECT)
$(EXEC_VPERF19): $(OBJS_VPERF19)
	$(CC) $(CFLAGS) -o $@ $(OBJS_VPERF19) $(LDFLAGS) $(LIBRARIES_VECT)
$(EXEC_VPERF20): $(OBJS_VPERF20)
	$(CC) $(CFLAGS) -o $@ $(OBJS_VPERF20) $(LDFLAGS) $(LIBRARIES_VECT)


# Matrice
$(EXEC_MPERF1): $(OBJS_MPERF1)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF1) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF2): $(OBJS_MPERF2)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF2) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF3): $(OBJS_MPERF3)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF3) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF4): $(OBJS_MPERF4)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF4) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF5): $(OBJS_MPERF5)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF5) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF6): $(OBJS_MPERF6)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF6) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF7): $(OBJS_MPERF7)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF7) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF8): $(OBJS_MPERF8)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF8) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF9): $(OBJS_MPERF9)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF9) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF10): $(OBJS_MPERF10)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF10) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF11): $(OBJS_MPERF11)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF11) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF12): $(OBJS_MPERF12)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF12) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF13): $(OBJS_MPERF13)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF13) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF14): $(OBJS_MPERF14)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF14) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF15): $(OBJS_MPERF15)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF15) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF16): $(OBJS_MPERF16)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF16) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF17): $(OBJS_MPERF17)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF17) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF18): $(OBJS_MPERF18)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF18) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF19): $(OBJS_MPERF19)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF19) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF20): $(OBJS_MPERF20)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF20) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF21): $(OBJS_MPERF21)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF21) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF22): $(OBJS_MPERF22)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF22) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF23): $(OBJS_MPERF23)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF23) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF24): $(OBJS_MPERF24)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF24) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF25): $(OBJS_MPERF25)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF25) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF26): $(OBJS_MPERF26)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF26) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF27): $(OBJS_MPERF27)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF27) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF28): $(OBJS_MPERF28)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF28) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF29): $(OBJS_MPERF29)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF29) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF30): $(OBJS_MPERF30)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF30) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF31): $(OBJS_MPERF31)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF31) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MPERF32): $(OBJS_MPERF32)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MPERF32) $(LDFLAGS) $(LIBRARIES_MATR)


#------
# TESTS
#------
tests: libs tests_perf tests_matr

tests_perf: $(EXECS_TSTS_VECT)

tests_matr: $(EXECS_TSTS_MATR)

# Vecteur
$(EXEC_VTEST1): $(OBJS_VTEST1)
	$(CC) $(CFLAGS) -o $@ $(OBJS_VTEST1) $(LDFLAGS) $(LIBRARIES_VECT)
$(EXEC_VTEST2): $(OBJS_VTEST2)
	$(CC) $(CFLAGS) -o $@ $(OBJS_VTEST2) $(LDFLAGS) $(LIBRARIES_VECT)
$(EXEC_VTEST3): $(OBJS_VTEST3)
	$(CC) $(CFLAGS) -o $@ $(OBJS_VTEST3) $(LDFLAGS) $(LIBRARIES_VECT)
$(EXEC_VTEST4): $(OBJS_VTEST4)
	$(CC) $(CFLAGS) -o $@ $(OBJS_VTEST4) $(LDFLAGS) $(LIBRARIES_VECT)

# Matrice
$(EXEC_MTEST1): $(OBJS_MTEST1)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MTEST1) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MTEST2): $(OBJS_MTEST2)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MTEST2) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MTEST3): $(OBJS_MTEST3)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MTEST3) $(LDFLAGS) $(LIBRARIES_MATR)
$(EXEC_MTEST4): $(OBJS_MTEST4)
	$(CC) $(CFLAGS) -o $@ $(OBJS_MTEST4) $(LDFLAGS) $(LIBRARIES_MATR)




#-------------------------------------------------
# DEPENDENCIES
#-------------------------------------------------
obj/%.o: src/%.c
	$(CC) $(CFLAGS) -c -o $@ $<
perfs/obj/%.o: perfs/src/%.c
	$(CC) $(CFLAGS) -c -o $@ $<
tests/obj/%.o: tests/src/%.c
	$(CC) $(CFLAGS) -c -o $@ $<


#-----
# LIBS
#-----
obj/vectb.o: src/vectb.c includes/vectb.h includes/vecteur.h
obj/vects.o: src/vects.c includes/vects.h includes/vecteur.h
obj/matrb.o: src/matrb.c includes/vectb.h includes/vecteur.h
obj/matrs.o: src/matrs.c includes/matrs.h includes/vecteur.h

#------
# PERFS
#------
# Vecteur
perfs/obj/vectbd_add.o: perfs/src/vectbd_add.c includes/vectb.h perfs/src/myTime.h $(LIBVECT)
perfs/obj/vectbd_addVect.o: perfs/src/vectbd_addVect.c includes/vectb.h perfs/src/myTime.h $(LIBVECT)
perfs/obj/vectbd_mult.o: perfs/src/vectbd_mult.c includes/vectb.h perfs/src/myTime.h $(LIBVECT)
perfs/obj/vectbd_scal.o: perfs/src/vectbd_scal.c includes/vectb.h perfs/src/myTime.h $(LIBVECT)
perfs/obj/vectbd_scalVect.o: perfs/src/vectbd_scalVect.c includes/vectb.h perfs/src/myTime.h $(LIBVECT)
perfs/obj/vectbf_add.o: perfs/src/vectbf_add.c includes/vectb.h perfs/src/myTime.h $(LIBVECT)
perfs/obj/vectbf_addVect.o: perfs/src/vectbf_addVect.c includes/vectb.h perfs/src/myTime.h $(LIBVECT)
perfs/obj/vectbf_mult.o: perfs/src/vectbf_mult.c includes/vectb.h perfs/src/myTime.h $(LIBVECT)
perfs/obj/vectbf_scal.o: perfs/src/vectbf_scal.c includes/vectb.h perfs/src/myTime.h $(LIBVECT)
perfs/obj/vectbf_scalVect.o: perfs/src/vectbf_scalVect.c includes/vectb.h perfs/src/myTime.h $(LIBVECT)
perfs/obj/vectsd_add.o: perfs/src/vectsd_add.c includes/vects.h perfs/src/myTime.h $(LIBVECT)
perfs/obj/vectsd_addVect.o: perfs/src/vectsd_addVect.c includes/vects.h perfs/src/myTime.h $(LIBVECT)
perfs/obj/vectsd_mult.o: perfs/src/vectsd_mult.c includes/vects.h perfs/src/myTime.h $(LIBVECT)
perfs/obj/vectsd_scal.o: perfs/src/vectsd_scal.c includes/vects.h perfs/src/myTime.h $(LIBVECT)
perfs/obj/vectsd_scalVect.o: perfs/src/vectsd_scalVect.c includes/vects.h perfs/src/myTime.h $(LIBVECT)
perfs/obj/vectsf_add.o: perfs/src/vectsf_add.c includes/vects.h perfs/src/myTime.h $(LIBVECT)
perfs/obj/vectsf_addVect.o: perfs/src/vectsf_addVect.c includes/vects.h perfs/src/myTime.h $(LIBVECT)
perfs/obj/vectsf_mult.o: perfs/src/vectsf_mult.c includes/vects.h perfs/src/myTime.h $(LIBVECT)
perfs/obj/vectsf_scal.o: perfs/src/vectsf_scal.c includes/vects.h perfs/src/myTime.h $(LIBVECT)
perfs/obj/vectsf_scalVect.o: perfs/src/vectsf_scalVect.c includes/vects.h perfs/src/myTime.h $(LIBVECT)

# Matrice
perfs/obj/matrbd_add.o: perfs/src/matrbd_add.c includes/matrb.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrbd_addVect.o: perfs/src/matrbd_addVect.c includes/matrb.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrbd_factLU.o: perfs/src/matrbd_factLU.c includes/matrb.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrbd_gaxpy.o: perfs/src/matrbd_gaxpy.c includes/matrb.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrbd_mScalaire.o: perfs/src/matrbd_mScalaire.c includes/matrb.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrbd_mult.o: perfs/src/matrbd_mult.c includes/matrb.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrbd_multVect.o: perfs/src/matrbd_multVect.c includes/matrb.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrbd_transpo.o: perfs/src/matrbd_transpo.c includes/matrb.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrbf_add.o: perfs/src/matrbf_add.c includes/matrb.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrbf_addVect.o: perfs/src/matrbf_addVect.c includes/matrb.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrbf_factLU.o: perfs/src/matrbf_factLU.c includes/matrb.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrbf_gaxpy.o: perfs/src/matrbf_gaxpy.c includes/matrb.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrbf_mScalaire.o: perfs/src/matrbf_mScalaire.c includes/matrb.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrbf_mult.o: perfs/src/matrbf_mult.c includes/matrb.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrbf_multVect.o: perfs/src/matrbf_multVect.c includes/matrb.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrbf_transpo.o: perfs/src/matrbf_transpo.c includes/matrb.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrsd_add.o: perfs/src/matrsd_add.c includes/matrs.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrsd_addVect.o: perfs/src/matrsd_addVect.c includes/matrs.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrsd_factLU.o: perfs/src/matrsd_factLU.c includes/matrs.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrsd_gaxpy.o: perfs/src/matrsd_gaxpy.c includes/matrs.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrsd_mScalaire.o: perfs/src/matrsd_mScalaire.c includes/matrs.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrsd_mult.o: perfs/src/matrsd_mult.c includes/matrs.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrsd_multVect.o: perfs/src/matrsd_multVect.c includes/matrs.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrsd_transpo.o: perfs/src/matrsd_transpo.c includes/matrs.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrsf_add.o: perfs/src/matrsf_add.c includes/matrs.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrsf_addVect.o: perfs/src/matrsf_addVect.c includes/matrs.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrsf_factLU.o: perfs/src/matrsf_factLU.c includes/matrs.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrsf_gaxpy.o: perfs/src/matrsf_gaxpy.c includes/matrs.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrsf_mScalaire.o: perfs/src/matrsf_mScalaire.c includes/matrs.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrsf_mult.o: perfs/src/matrsf_mult.c includes/matrs.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrsf_multVect.o: perfs/src/matrsf_multVect.c includes/matrs.h perfs/src/myTime.h $(LIBMATR)
perfs/obj/matrsf_transpo.o: perfs/src/matrsf_transpo.c includes/matrs.h perfs/src/myTime.h $(LIBMATR)

perfs/obj/myTime.o: perfs/src/myTime.c perfs/src/myTime.h

#------
# TESTS
#------
tests/obj/test_bdv.o: tests/src/test_bdv.c includes/vectb.h $(LIBVECT)
tests/obj/test_bfv.o: tests/src/test_bfv.c includes/vectb.h $(LIBVECT)
tests/obj/test_sdv.o: tests/src/test_sdv.c includes/vects.h $(LIBVECT)
tests/obj/test_sfv.o: tests/src/test_sfv.c includes/vects.h $(LIBVECT)

tests/obj/test_bdm.o: tests/src/test_bdm.c includes/matrb.h $(LIBMATR)
tests/obj/test_bfm.o: tests/src/test_bfm.c includes/matrb.h $(LIBMATR)
tests/obj/test_sdm.o: tests/src/test_sdm.c includes/matrs.h $(LIBMATR)
tests/obj/test_sfm.o: tests/src/test_sfm.c includes/matrs.h $(LIBMATR)

#-------------------------------------------------
# CLEANING
#-------------------------------------------------
clean: clean_libs clean_perfs clean_tests

#-----
# LIBS
#-----
clean_libs: clean_libvect clean_libmatr

clean_libvect:
	@rm -vf $(OBJS_LIBVECT)

clean_libmatr:
	@rm -vf $(OBJS_LIBMATR)

#------
# PERFS
#------
clean_perfs: clean_perfs_vect clean_perfs_matr

clean_perfs_vect:
	@rm -vf perfs/obj/*

clean_perfs_matr:
	@rm -vf perfs/obj/*

#------
# TESTS
#------
clean_tests: clean_tests_vect clean_tests_matr

clean_tests_vect:
	@rm -vf tests/obj/*

clean_tests_matr:
	@rm -vf tests/obj/*



#-------------------------------------------------
# MRPROPING
#-------------------------------------------------

mrproper: mrproper_libs mrproper_perfs mrproper_tests

#-----
# LIBS
#-----
mrproper_libs: mrproper_libvect mrproper_libmatr

mrproper_libvect: clean_libvect
	@rm -vf $(LIBVECT)

mrproper_libmatr: clean_libmatr
	@rm -vf $(LIBMATR)

#------
# PERFS
#------
mrproper_perfs: mrproper_perfs_vect mrproper_perfs_matr

mrproper_perfs_vect: clean_perfs_vect
	@rm -vf $(EXECS_PERF_VECT)

mrproper_perfs_matr: clean_perfs_matr
	@rm -vf $(EXECS_PERF_MATR)

#------
# TESTS
#------
mrproper_tests: mrproper_tests_vect mrproper_tests_matr

mrproper_tests_vect: clean_tests_vect
	@rm -vf $(EXECS_TSTS_VECT)

mrproper_tests_matr: clean_tests_matr
	@rm -vf $(EXECS_TSTS_MATR)

#-------------------------------------------------
# Others
#-------------------------------------------------
.PHONY: mrproper clean
