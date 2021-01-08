$ zztop	#=> --lines 41

$ zztop -i 345 -f 180
Uso: zztop [-l] [-g|-h] [-i número] [-f número] [lista]
$

$ zztop -12
Uso: zztop [-l] [-g|-h] [-i número] [-f número] [lista]
$

$ zztop -f 5 23
06/2004
001: Earth-Simulator (NEC)
 ├── Japan Agency for Marine-Earth Science and Technology (Japan)
 └── Cores: 5,120 | RMax: 35,860.0 | RPeak: 40,960.0 | Power: 3,200

002: Thunder - Intel Itanium2 Tiger4 1.4GHz - Quadrics (California Digital Corporation)
 ├── Lawrence Livermore National Laboratory (United States)
 └── Cores: 4,096 | RMax: 19,940.0 | RPeak: 22,938.0 | Power: -

003: ASCI Q - AlphaServer SC45, 1.25 GHz (HPE)
 ├── Los Alamos National Laboratory (United States)
 └── Cores: 8,192 | RMax: 13,880.0 | RPeak: 20,480.0 | Power: -

004: BlueGene/L DD1 Prototype (0.5GHz PowerPC 440 w/Custom) (IBM/ LLNL)
 ├── IBM Rochester (United States)
 └── Cores: 8,192 | RMax: 11,680.0 | RPeak: 16,384.0 | Power: -

005: Tungsten - PowerEdge 1750, P4 Xeon 3.06 GHz, Myrinet (Dell EMC)
 ├── NCSA (United States)
 └── Cores: 2,500 | RMax: 9,819.0 | RPeak: 15,300.0 | Power: -

$

$ zztop -i 125 -f 130 47 
06/2016
125: Zin - Xtreme-X GreenBlade GB512X, Xeon E5 (Sandy Bridge - EP) 8C 2.60GHz, Infiniband QDR (Cray/HPE)
 ├── Lawrence Livermore National Laboratory (United States)
 └── Cores: 46,208 | RMax: 773.7 | RPeak: 961.1 | Power: 924

126: Tianhe-1A Hunan Solution - NUDT YH MPP, Xeon X5670 6C 2.93 GHz, Proprietary, NVIDIA 2050 (NUDT)
 ├── National Super Computer Center in Hunan (China)
 └── Cores: 53,248 | RMax: 771.7 | RPeak: 1,342.8 | Power: 1,155

127: ForHLR II - Lenovo NeXtScale nx360M5, Xeon E5-2660v3 10C 2.6GHz, Infiniband EDR/FDR (Lenovo)
 ├── Karlsruher Institut für Technologie (KIT) (Germany)
 └── Cores: 22,960 | RMax: 768.3 | RPeak: 955.1 | Power: 435

128: Spruce B - SGI ICE X, Intel Xeon E5-2680v2 10C 2.8GHz, Infiniband FDR (HPE)
 ├── AWE (United Kingdom)
 └── Cores: 35,640 | RMax: 767.5 | RPeak: 798.3 | Power: 685

129: Endeavor - Intel Cluster, Intel Xeon E5-2697v2 12C 2.700GHz, Infiniband FDR, Intel Xeon Phi 7110 (Intel)
 ├── Intel (United States)
 └── Cores: 51,392 | RMax: 758.9 | RPeak: 933.5 | Power: 387

130: Lenovo ThinkServer RD650, Intel Xeon E5-2650v3 10C 2GHz, 10G Ethernet (Lenovo)
 ├── Internet Company A (China)
 └── Cores: 70,000 | RMax: 756.9 | RPeak: 2,240.0 | Power: 2,625

$

$ zztop 56
11/2020
001: Supercomputer Fugaku - Supercomputer Fugaku, A64FX 48C 2.2GHz, Tofu interconnect D (Fujitsu)
 ├── RIKEN Center for Computational Science (Japan)
 └── Cores: 7,630,848 | RMax: 442,010.0 | RPeak: 537,212.0 | Power: 29,899

002: Summit - IBM Power System AC922, IBM POWER9 22C 3.07GHz, NVIDIA Volta GV100, Dual-rail Mellanox EDR Infiniband (IBM)
 ├── DOE/SC/Oak Ridge National Laboratory (United States)
 └── Cores: 2,414,592 | RMax: 148,600.0 | RPeak: 200,794.9 | Power: 10,096

003: Sierra - IBM Power System AC922, IBM POWER9 22C 3.1GHz, NVIDIA Volta GV100, Dual-rail Mellanox EDR Infiniband (IBM / NVIDIA / Mellanox)
 ├── DOE/NNSA/LLNL (United States)
 └── Cores: 1,572,480 | RMax: 94,640.0 | RPeak: 125,712.0 | Power: 7,438

004: Sunway TaihuLight - Sunway MPP, Sunway SW26010 260C 1.45GHz, Sunway (NRCPC)
 ├── National Supercomputing Center in Wuxi (China)
 └── Cores: 10,649,600 | RMax: 93,014.6 | RPeak: 125,435.9 | Power: 15,371

005: Selene - NVIDIA DGX A100, AMD EPYC 7742 64C 2.25GHz, NVIDIA A100, Mellanox HDR Infiniband (Nvidia)
 ├── NVIDIA Corporation (United States)
 └── Cores: 555,520 | RMax: 63,460.0 | RPeak: 79,215.0 | Power: 2,646

006: Tianhe-2A - TH-IVB-FEP Cluster, Intel Xeon E5-2692v2 12C 2.2GHz, TH Express-2, Matrix-2000 (NUDT)
 ├── National Super Computer Center in Guangzhou (China)
 └── Cores: 4,981,760 | RMax: 61,444.5 | RPeak: 100,678.7 | Power: 18,482

007: JUWELS Booster Module - Bull Sequana XH2000 , AMD EPYC 7402 24C 2.8GHz, NVIDIA A100, Mellanox HDR InfiniBand/ParTec ParaStation ClusterSuite (Atos)
 ├── Forschungszentrum Juelich (FZJ) (Germany)
 └── Cores: 449,280 | RMax: 44,120.0 | RPeak: 70,980.0 | Power: 1,764

008: HPC5 - PowerEdge C4140, Xeon Gold 6252 24C 2.1GHz, NVIDIA Tesla V100, Mellanox HDR Infiniband (Dell EMC)
 ├── Eni S.p.A. (Italy)
 └── Cores: 669,760 | RMax: 35,450.0 | RPeak: 51,720.8 | Power: 2,252

009: Frontera - Dell C6420, Xeon Platinum 8280 28C 2.7GHz, Mellanox InfiniBand HDR (Dell EMC)
 ├── Texas Advanced Computing Center/Univ. of Texas (United States)
 └── Cores: 448,448 | RMax: 23,516.4 | RPeak: 38,745.9 | Power: -

010: Dammam-7 - Cray CS-Storm, Xeon Gold 6248 20C 2.5GHz, NVIDIA Tesla V100 SXM2, InfiniBand HDR 100 (HPE)
 ├── Saudi Aramco (Saudi Arabia)
 └── Cores: 672,520 | RMax: 22,400.0 | RPeak: 55,423.6 | Power: -

$

$ zztop -g -i 188 -f 192 56
11/2020
188: LLNL/NNSA CTS-1 Jade - Tundra Extreme Scale, Xeon E5-2695v4 18C 2.1GHz, Intel Omni-Path (Penguin Computing, Inc.)
 ├── Lawrence Livermore National Laboratory (United States)
 ├── Cores: 95,472 | RMax: 2,632.5 | Power: 13,620 | Power Efficiency : 0.193
 └── TOP500 Rank:  134

189: LLNL CTS-1 Quartz - Tundra Extreme Scale, Xeon E5-2695v4 18C 2.1GHz, Intel Omni-Path (Penguin Computing, Inc.)
 ├── Lawrence Livermore National Laboratory (United States)
 ├── Cores: 95,472 | RMax: 2,632.5 | Power: 13,620 | Power Efficiency : 0.193
 └── TOP500 Rank:  135

190: Frontera - Dell C6420, Xeon Platinum 8280 28C 2.7GHz, Mellanox InfiniBand HDR (Dell EMC)
 ├── Texas Advanced Computing Center/Univ. of Texas (United States)
 ├── Cores: 448,448 | RMax: 23,516.4 | Power: - | Power Efficiency : 0.000
 └── TOP500 Rank:  9

191: Dammam-7 - Cray CS-Storm, Xeon Gold 6248 20C 2.5GHz, NVIDIA Tesla V100 SXM2, InfiniBand HDR 100 (HPE)
 ├── Saudi Aramco (Saudi Arabia)
 ├── Cores: 672,520 | RMax: 22,400.0 | Power: - | Power Efficiency : 0.000
 └── TOP500 Rank:  10

192: SuperMUC-NG - ThinkSystem SD650, Xeon Platinum 8174 24C 3.1GHz, Intel Omni-Path (Lenovo)
 ├── Leibniz Rechenzentrum (Germany)
 ├── Cores: 305,856 | RMax: 19,476.6 | Power: - | Power Efficiency : 0.000
 └── TOP500 Rank:  15

$

$ zztop -p -i 18 -f 23 55
06/2020
018: Circe - NVIDIA DGX-2H POD, Xeon Platinum 8174 24C 3.1GHz, Mellanox InfiniBand EDR, NVIDIA Tesla V100 SXM2 (Nvidia)
 ├── NVIDIA Corporation (United States)
 ├── Cores: 47,808 | RMax: 3,057.0 | HPCG: 199.20
 └── TOP500 Rank:  90

019: DGX SuperPOD - NVIDIA DGX-2H, Xeon Platinum 8174 24C 3.1GHz, NVIDIA Tesla V100, Mellanox InfiniBand EDR (Nvidia)
 ├── NVIDIA Corporation (United States)
 ├── Cores: 127,488 | RMax: 9,444.0 | HPCG: 199.20
 └── TOP500 Rank:  23

020: TSUBAME3.0 - SGI ICE XA, IP139-SXM2, Xeon E5-2680v4 14C 2.4GHz, Intel Omni-Path, NVIDIA Tesla P100 SXM2 (HPE)
 ├── GSIC Center, Tokyo Institute of Technology (Japan)
 ├── Cores: 135,828 | RMax: 8,125.0 | HPCG: 188.62
 └── TOP500 Rank:  27

021: Pleiades - SGI ICE X, Intel Xeon E5-2670/E5-2680v2/E5-2680v3/E5-2680v4 2.6/2.8/2.5/2.4 GHz, Infiniband FDR (HPE)
 ├── NASA/Ames Research Center/NAS (United States)
 ├── Cores: 241,108 | RMax: 5,951.6 | HPCG: 175.18
 └── TOP500 Rank:  39

022: Pangea - SGI ICE X, Xeon Xeon E5-2670/ E5-2680v3 12C 2.5GHz, Infiniband FDR (HPE)
 ├── Total Exploration Production (France)
 ├── Cores: 220,800 | RMax: 5,283.1 | HPCG: 162.69
 └── TOP500 Rank:  49

023: Hazel Hen - Cray XC40, Xeon E5-2680v3 12C 2.5GHz, Aries interconnect  (Cray/HPE)
 ├── HLRS - Höchstleistungsrechenzentrum Stuttgart (Germany)
 ├── Cores: 185,088 | RMax: 5,640.2 | HPCG: 138.00
 └── TOP500 Rank:  43

$
