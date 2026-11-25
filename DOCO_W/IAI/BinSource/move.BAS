'<ADbasic Header, Headerversion 001.001>
'Process_Number                   = 1
'Initial_Processdelay             = 1000
'Eventsource                      = Timer
'Control_long_Delays_for_Stop     = No
'Priority                         = High
'Version                          = 1
'ADbasic_Version                  = 5.0.2
'Optimize                         = Yes
'Optimize_Level                   = 1
'Info_Last_Save                   = PC PC\anonymous
'<Header End>

IMPORT C:\Users\buloup\Desktop\Docometre\plugins\Libraries_1.0.0.202611250858\includes\ADWinIncludeFiles\DOCOLIBGoldII.LIB
#INCLUDE ADwinGoldII.INC
#INCLUDE C:\Users\buloup\Desktop\Docometre\plugins\Libraries_1.0.0.202611250858\includes\ADWinIncludeFiles\CALLDIGOUTGoldII.INC
#INCLUDE C:\Users\buloup\Desktop\Docometre\plugins\Libraries_1.0.0.202611250858\includes\ADWinIncludeFiles\CALLDIGINGoldII.INC

#DEFINE PI 4*ARCTAN(1)
#DEFINE time FPAR_1
#DEFINE rtTime FPAR_1
DIM FEG AS LONG
DIM INDEX AS LONG
DIM TERMINATE_PROCESS AS SHORT

REM ******** FIFO de transfert unique : numero de transfert puis valeur de chaque echantillon des canaux auto-transferes
#DEFINE DOCO_TRANSFER_FIFO DATA_198
DIM DOCO_TRANSFER_FIFO[34002] AS FLOAT AS FIFO

REM Median filter declaration
DIM medianFilterValues_187406409[3] AS FLOAT
DIM orderedMedianFilterValues_187406409[3] AS FLOAT
DIM i_187406409 AS INTEGER
DIM firstTime_187406409 AS INTEGER
DIM history_187406409 AS INTEGER
DIM compute_187406409 AS INTEGER

REM ******** Sortie numerique: DIO_PP
DIM Generation_DIO_PP AS LONG
DIM DIO_PP AS LONG

REM ******** Variables pour transfert de: DIO_PP 'Utilisé par Transfert
DIM TRANSFERT_DIO_PP AS LONG 'Utilisé par Transfert

REM ******** Sortie numerique: DIO_NP
DIM Generation_DIO_NP AS LONG
DIM DIO_NP AS LONG

REM ******** Variables pour transfert de: DIO_NP 'Utilisé par Transfert
DIM TRANSFERT_DIO_NP AS LONG 'Utilisé par Transfert

REM ******** Sortie numerique: DIO_SON
DIM Generation_DIO_SON AS LONG
DIM DIO_SON AS LONG

REM ******** Variables pour transfert de: DIO_SON 'Utilisé par Transfert
DIM TRANSFERT_DIO_SON AS LONG 'Utilisé par Transfert

REM ******** Sortie numerique: DIO_RSTR
DIM Generation_DIO_RSTR AS LONG
DIM DIO_RSTR AS LONG

REM ******** Variables pour transfert de: DIO_RSTR 'Utilisé par Transfert
DIM TRANSFERT_DIO_RSTR AS LONG 'Utilisé par Transfert

REM ******** Sortie numerique: DIO_CSTP
DIM Generation_DIO_CSTP AS LONG
DIM DIO_CSTP AS LONG

REM ******** Variables pour transfert de: DIO_CSTP 'Utilisé par Transfert
DIM TRANSFERT_DIO_CSTP AS LONG 'Utilisé par Transfert

REM ******** Sortie numerique: DIO_HOME
DIM Generation_DIO_HOME AS LONG
DIM DIO_HOME AS LONG

REM ******** Variables pour transfert de: DIO_HOME 'Utilisé par Transfert
DIM TRANSFERT_DIO_HOME AS LONG 'Utilisé par Transfert

REM ******** Sortie numerique: DIO_RES
DIM Generation_DIO_RES AS LONG
DIM DIO_RES AS LONG

REM ******** Variables pour transfert de: DIO_RES 'Utilisé par Transfert
DIM TRANSFERT_DIO_RES AS LONG 'Utilisé par Transfert

REM ******** Entree numerique: DIO_SV
DIM Acquisition_DIO_SV AS LONG
DIM DIO_SV AS LONG

REM ******** Variables pour transfert de: DIO_SV 'Utilisé par Transfert
DIM TRANSFERT_DIO_SV AS LONG 'Utilisé par Transfert

REM ******** Entree numerique: DIO_INP
DIM Acquisition_DIO_INP AS LONG
DIM DIO_INP AS LONG

REM ******** Variables pour transfert de: DIO_INP 'Utilisé par Transfert
DIM TRANSFERT_DIO_INP AS LONG 'Utilisé par Transfert

REM ******** Entree numerique: DIO_HEND
DIM Acquisition_DIO_HEND AS LONG
DIM DIO_HEND AS LONG

REM ******** Variables pour transfert de: DIO_HEND 'Utilisé par Transfert
DIM TRANSFERT_DIO_HEND AS LONG 'Utilisé par Transfert

REM ******** Entree numerique: DIO_ALM
DIM Acquisition_DIO_ALM AS LONG
DIM DIO_ALM AS LONG

REM ******** Variables pour transfert de: DIO_ALM 'Utilisé par Transfert
DIM TRANSFERT_DIO_ALM AS LONG 'Utilisé par Transfert

REM ******** Entree numerique: DIO_EMGS
DIM Acquisition_DIO_EMGS AS LONG
DIM DIO_EMGS AS LONG

REM ******** Variables pour transfert de: DIO_EMGS 'Utilisé par Transfert
DIM TRANSFERT_DIO_EMGS AS LONG 'Utilisé par Transfert

REM ******** Entree numerique: DIO_REND
DIM Acquisition_DIO_REND AS LONG
DIM DIO_REND AS LONG

REM ******** Variables pour transfert de: DIO_REND 'Utilisé par Transfert
DIM TRANSFERT_DIO_REND AS LONG 'Utilisé par Transfert

REM ******** Début déclarations des variables

REM ******** >>>> Variable medianDIO_HEND scalaire, flottant(s)
DIM medianDIO_HEND AS FLOAT

REM ******** Variables pour transfert de: medianDIO_HEND 'Utilisées par Transfert
DIM TRANSFERT_medianDIO_HEND AS LONG 'Utilisé par Transfert

REM ******** >>>> Variable medianDIO_INP scalaire, flottant(s)
DIM medianDIO_INP AS FLOAT

REM ******** Variables pour transfert de: medianDIO_INP 'Utilisées par Transfert
DIM TRANSFERT_medianDIO_INP AS LONG 'Utilisé par Transfert

REM ******** >>>> Variable time_HEND_isOne scalaire, flottant(s)
DIM time_HEND_isOne AS FLOAT

REM ******** Variables pour transfert de: time_HEND_isOne 'Utilisées par Transfert
DIM TRANSFERT_time_HEND_isOne AS LONG 'Utilisé par Transfert

REM ******** >>>> Variable time_INP_isOne scalaire, flottant(s)
DIM time_INP_isOne AS FLOAT

REM ******** Variables pour transfert de: time_INP_isOne 'Utilisées par Transfert
DIM TRANSFERT_time_INP_isOne AS LONG 'Utilisé par Transfert


REM ******** Fin déclarations des variables

LOWINIT:

FEG = 24000
GLOBALDELAY = 3*10^8/FEG
INDEX = 0
TERMINATE_PROCESS = 0
time = 0
FIFO_CLEAR(198) ' FIFO de transfert unique

REM Median filter initialization

firstTime_187406409 = 1
history_187406409 = 1
compute_187406409 = 24

REM ******** Configuration Entrees/Sorties numeriques
CONF_DIO(4)

Generation_DIO_PP = 1'******** init generation DIO_PP
TRANSFERT_DIO_PP = 1
PAR_5 = 0

Generation_DIO_NP = 1'******** init generation DIO_NP
TRANSFERT_DIO_NP = 1
PAR_6 = 0

Generation_DIO_SON = 24'******** init generation DIO_SON
TRANSFERT_DIO_SON = 24
PAR_7 = 0

Generation_DIO_RSTR = 24'******** init generation DIO_RSTR
TRANSFERT_DIO_RSTR = 24
PAR_8 = 0

Generation_DIO_CSTP = 24'******** init generation DIO_CSTP
TRANSFERT_DIO_CSTP = 24
PAR_9 = 0

Generation_DIO_HOME = 24'******** init generation DIO_HOME
TRANSFERT_DIO_HOME = 24
PAR_10 = 0

Generation_DIO_RES = 24'******** init generation DIO_RES
TRANSFERT_DIO_RES = 24
PAR_11 = 0

Acquisition_DIO_SV = 24 '******** init acquisition DIO_SV
TRANSFERT_DIO_SV = 24
PAR_12 = 0

Acquisition_DIO_INP = 24 '******** init acquisition DIO_INP
TRANSFERT_DIO_INP = 24
PAR_13 = 0

Acquisition_DIO_HEND = 24 '******** init acquisition DIO_HEND
TRANSFERT_DIO_HEND = 24
PAR_14 = 0

Acquisition_DIO_ALM = 24 '******** init acquisition DIO_ALM
TRANSFERT_DIO_ALM = 24
PAR_15 = 0

Acquisition_DIO_EMGS = 24 '******** init acquisition DIO_EMGS
TRANSFERT_DIO_EMGS = 24
PAR_16 = 0

Acquisition_DIO_REND = 24 '******** init acquisition DIO_REND
TRANSFERT_DIO_REND = 24
PAR_17 = 0

REM ******** Début initialisation des variables

TRANSFERT_medianDIO_HEND = 24
PAR_3 = 0
TRANSFERT_medianDIO_INP = 24
PAR_4 = 0
TRANSFERT_time_HEND_isOne = 24
PAR_1 = 0
TRANSFERT_time_INP_isOne = 24
PAR_2 = 0

REM ******** Fin initialisation des variables


REM ******** Début algorithme initialisation


REM Digital Output Function

DIO_SON = 1
Call_DigOut(19, DIO_SON) 'Channel name is channel value


REM Digital Output Function

DIO_NP = 0
Call_DigOut(18, DIO_NP) 'Channel name is channel value


REM Expression Function

DIO_RES = 0
DIO_HOME = 0
DIO_CSTP = 0
DIO_RSTR = 0
time_INP_isOne = 0
time_HEND_isOne = 0


REM Digital Wait Function

DO
	NOP
UNTIL (Call_DigIn(1) = 1)

REM ******** Fin algorithme initialisation

EVENT:

time = INDEX/FEG
INC(INDEX)

IF (Acquisition_DIO_SV = 24) THEN
	Acquisition_DIO_SV = 0
	DIO_SV = Call_DigIn(1)
ENDIF
INC(Acquisition_DIO_SV)

IF (Acquisition_DIO_INP = 24) THEN
	Acquisition_DIO_INP = 0
	DIO_INP = Call_DigIn(2)
ENDIF
INC(Acquisition_DIO_INP)

IF (Acquisition_DIO_HEND = 24) THEN
	Acquisition_DIO_HEND = 0
	DIO_HEND = Call_DigIn(3)
ENDIF
INC(Acquisition_DIO_HEND)

IF (Acquisition_DIO_ALM = 24) THEN
	Acquisition_DIO_ALM = 0
	DIO_ALM = Call_DigIn(4)
ENDIF
INC(Acquisition_DIO_ALM)

IF (Acquisition_DIO_EMGS = 24) THEN
	Acquisition_DIO_EMGS = 0
	DIO_EMGS = Call_DigIn(5)
ENDIF
INC(Acquisition_DIO_EMGS)

IF (Acquisition_DIO_REND = 24) THEN
	Acquisition_DIO_REND = 0
	DIO_REND = Call_DigIn(6)
ENDIF
INC(Acquisition_DIO_REND)

REM ******** Fin autotransfert données vers PC

REM ******** Début algorithme boucle


REM Median filter Function

IF (compute_187406409 = 24) THEN
	compute_187406409 = 0
	IF (firstTime_187406409 = 1) THEN
		FOR i_187406409 = 1 TO 3
			medianFilterValues_187406409[i_187406409] = DIO_INP
			orderedMedianFilterValues_187406409[i_187406409] = DIO_INP
		NEXT i_187406409
		firstTime_187406409 = 0
	ENDIF 
	FOR i_187406409 = 0 TO 3 - 2
		medianFilterValues_187406409[3 - i_187406409] = medianFilterValues_187406409[3 - i_187406409 - 1]
		orderedMedianFilterValues_187406409[3 - i_187406409] = medianFilterValues_187406409[3 - i_187406409]
	NEXT i_187406409
	medianFilterValues_187406409[1] = DIO_INP
	orderedMedianFilterValues_187406409[1] = DIO_INP
	medianDIO_INP = median(orderedMedianFilterValues_187406409, history_187406409)
	IF (history_187406409 < 3) THEN
		history_187406409 = history_187406409 + 1
	ENDIF
ENDIF
INC(compute_187406409)

IF (time >= 0.1) THEN
	IF (time <= 2.1) THEN
		
		REM Expression Function
		
		DIO_PP = mod(time*2*10000, 2)
		
	ELSE
	ENDIF
	IF (time > 0.2) THEN
		IF (medianDIO_INP = 1) THEN
			IF (time_INP_isOne = 0) THEN
				
				REM Expression Function
				
				time_INP_isOne = time
				
			ELSE
			ENDIF
		ELSE
		ENDIF
		IF (time_INP_isOne > 0) THEN
			
			REM Terminate Process Function
			
			IF ((time - time_INP_isOne)  >=  0.1) THEN
				TERMINATE_PROCESS = 1
			ENDIF
			
		ELSE
		ENDIF
	ELSE
	ENDIF
ELSE
ENDIF
REM ******** Fin algorithme boucle

REM ******** Debut autotransfert donnees vers PC

IF (TRANSFERT_DIO_PP = 1) THEN
	TRANSFERT_DIO_PP = 0
	IF (FIFO_EMPTY(198) < 2) THEN
		PAR_5 = PAR_5 + 1
	ELSE
		DOCO_TRANSFER_FIFO = 5
		DOCO_TRANSFER_FIFO = DIO_PP
	ENDIF
ENDIF
INC(TRANSFERT_DIO_PP)

IF (TRANSFERT_DIO_NP = 1) THEN
	TRANSFERT_DIO_NP = 0
	IF (FIFO_EMPTY(198) < 2) THEN
		PAR_6 = PAR_6 + 1
	ELSE
		DOCO_TRANSFER_FIFO = 6
		DOCO_TRANSFER_FIFO = DIO_NP
	ENDIF
ENDIF
INC(TRANSFERT_DIO_NP)

IF (TRANSFERT_DIO_SON = 24) THEN
	TRANSFERT_DIO_SON = 0
	IF (FIFO_EMPTY(198) < 2) THEN
		PAR_7 = PAR_7 + 1
	ELSE
		DOCO_TRANSFER_FIFO = 7
		DOCO_TRANSFER_FIFO = DIO_SON
	ENDIF
ENDIF
INC(TRANSFERT_DIO_SON)

IF (TRANSFERT_DIO_RSTR = 24) THEN
	TRANSFERT_DIO_RSTR = 0
	IF (FIFO_EMPTY(198) < 2) THEN
		PAR_8 = PAR_8 + 1
	ELSE
		DOCO_TRANSFER_FIFO = 8
		DOCO_TRANSFER_FIFO = DIO_RSTR
	ENDIF
ENDIF
INC(TRANSFERT_DIO_RSTR)

IF (TRANSFERT_DIO_CSTP = 24) THEN
	TRANSFERT_DIO_CSTP = 0
	IF (FIFO_EMPTY(198) < 2) THEN
		PAR_9 = PAR_9 + 1
	ELSE
		DOCO_TRANSFER_FIFO = 9
		DOCO_TRANSFER_FIFO = DIO_CSTP
	ENDIF
ENDIF
INC(TRANSFERT_DIO_CSTP)

IF (TRANSFERT_DIO_HOME = 24) THEN
	TRANSFERT_DIO_HOME = 0
	IF (FIFO_EMPTY(198) < 2) THEN
		PAR_10 = PAR_10 + 1
	ELSE
		DOCO_TRANSFER_FIFO = 10
		DOCO_TRANSFER_FIFO = DIO_HOME
	ENDIF
ENDIF
INC(TRANSFERT_DIO_HOME)

IF (TRANSFERT_DIO_RES = 24) THEN
	TRANSFERT_DIO_RES = 0
	IF (FIFO_EMPTY(198) < 2) THEN
		PAR_11 = PAR_11 + 1
	ELSE
		DOCO_TRANSFER_FIFO = 11
		DOCO_TRANSFER_FIFO = DIO_RES
	ENDIF
ENDIF
INC(TRANSFERT_DIO_RES)

IF (TRANSFERT_DIO_SV = 24) THEN
	TRANSFERT_DIO_SV = 0
	IF (FIFO_EMPTY(198) < 2) THEN
		PAR_12 = PAR_12 + 1
	ELSE
		DOCO_TRANSFER_FIFO = 12
		DOCO_TRANSFER_FIFO = DIO_SV
	ENDIF
ENDIF
INC(TRANSFERT_DIO_SV)

IF (TRANSFERT_DIO_INP = 24) THEN
	TRANSFERT_DIO_INP = 0
	IF (FIFO_EMPTY(198) < 2) THEN
		PAR_13 = PAR_13 + 1
	ELSE
		DOCO_TRANSFER_FIFO = 13
		DOCO_TRANSFER_FIFO = DIO_INP
	ENDIF
ENDIF
INC(TRANSFERT_DIO_INP)

IF (TRANSFERT_DIO_HEND = 24) THEN
	TRANSFERT_DIO_HEND = 0
	IF (FIFO_EMPTY(198) < 2) THEN
		PAR_14 = PAR_14 + 1
	ELSE
		DOCO_TRANSFER_FIFO = 14
		DOCO_TRANSFER_FIFO = DIO_HEND
	ENDIF
ENDIF
INC(TRANSFERT_DIO_HEND)

IF (TRANSFERT_DIO_ALM = 24) THEN
	TRANSFERT_DIO_ALM = 0
	IF (FIFO_EMPTY(198) < 2) THEN
		PAR_15 = PAR_15 + 1
	ELSE
		DOCO_TRANSFER_FIFO = 15
		DOCO_TRANSFER_FIFO = DIO_ALM
	ENDIF
ENDIF
INC(TRANSFERT_DIO_ALM)

IF (TRANSFERT_DIO_EMGS = 24) THEN
	TRANSFERT_DIO_EMGS = 0
	IF (FIFO_EMPTY(198) < 2) THEN
		PAR_16 = PAR_16 + 1
	ELSE
		DOCO_TRANSFER_FIFO = 16
		DOCO_TRANSFER_FIFO = DIO_EMGS
	ENDIF
ENDIF
INC(TRANSFERT_DIO_EMGS)

IF (TRANSFERT_DIO_REND = 24) THEN
	TRANSFERT_DIO_REND = 0
	IF (FIFO_EMPTY(198) < 2) THEN
		PAR_17 = PAR_17 + 1
	ELSE
		DOCO_TRANSFER_FIFO = 17
		DOCO_TRANSFER_FIFO = DIO_REND
	ENDIF
ENDIF
INC(TRANSFERT_DIO_REND)

IF (TRANSFERT_medianDIO_HEND = 24) THEN
	TRANSFERT_medianDIO_HEND = 0
	IF (FIFO_EMPTY(198) < 2) THEN
		PAR_3 = PAR_3 + 1
	ELSE
		DOCO_TRANSFER_FIFO = 3
		DOCO_TRANSFER_FIFO = medianDIO_HEND
	ENDIF
ENDIF
INC(TRANSFERT_medianDIO_HEND)

IF (TRANSFERT_medianDIO_INP = 24) THEN
	TRANSFERT_medianDIO_INP = 0
	IF (FIFO_EMPTY(198) < 2) THEN
		PAR_4 = PAR_4 + 1
	ELSE
		DOCO_TRANSFER_FIFO = 4
		DOCO_TRANSFER_FIFO = medianDIO_INP
	ENDIF
ENDIF
INC(TRANSFERT_medianDIO_INP)

IF (TRANSFERT_time_HEND_isOne = 24) THEN
	TRANSFERT_time_HEND_isOne = 0
	IF (FIFO_EMPTY(198) < 2) THEN
		PAR_1 = PAR_1 + 1
	ELSE
		DOCO_TRANSFER_FIFO = 1
		DOCO_TRANSFER_FIFO = time_HEND_isOne
	ENDIF
ENDIF
INC(TRANSFERT_time_HEND_isOne)

IF (TRANSFERT_time_INP_isOne = 24) THEN
	TRANSFERT_time_INP_isOne = 0
	IF (FIFO_EMPTY(198) < 2) THEN
		PAR_2 = PAR_2 + 1
	ELSE
		DOCO_TRANSFER_FIFO = 2
		DOCO_TRANSFER_FIFO = time_INP_isOne
	ENDIF
ENDIF
INC(TRANSFERT_time_INP_isOne)
REM ******** Début génération des signaux

IF (Generation_DIO_PP = 1) THEN
	Generation_DIO_PP = 0
	Call_DigOut(17, DIO_PP)
ENDIF
INC(Generation_DIO_PP)

IF (Generation_DIO_NP = 1) THEN
	Generation_DIO_NP = 0
	Call_DigOut(18, DIO_NP)
ENDIF
INC(Generation_DIO_NP)

IF (Generation_DIO_SON = 24) THEN
	Generation_DIO_SON = 0
	Call_DigOut(19, DIO_SON)
ENDIF
INC(Generation_DIO_SON)

IF (Generation_DIO_RSTR = 24) THEN
	Generation_DIO_RSTR = 0
	Call_DigOut(23, DIO_RSTR)
ENDIF
INC(Generation_DIO_RSTR)

IF (Generation_DIO_CSTP = 24) THEN
	Generation_DIO_CSTP = 0
	Call_DigOut(22, DIO_CSTP)
ENDIF
INC(Generation_DIO_CSTP)

IF (Generation_DIO_HOME = 24) THEN
	Generation_DIO_HOME = 0
	Call_DigOut(21, DIO_HOME)
ENDIF
INC(Generation_DIO_HOME)

IF (Generation_DIO_RES = 24) THEN
	Generation_DIO_RES = 0
	Call_DigOut(20, DIO_RES)
ENDIF
INC(Generation_DIO_RES)

REM ******** Fin génération des signaux

IF (TERMINATE_PROCESS = 1) THEN
	END
ENDIF


FINISH:

REM ******** Début algorithme finalisation


REM Digital Output Function

DIO_SON = 0
Call_DigOut(19, DIO_SON) 'Channel name is channel value


REM Digital Output Function

DIO_NP = 0
Call_DigOut(18, DIO_NP) 'Channel name is channel value

REM ******** Fin algorithme finalisation
