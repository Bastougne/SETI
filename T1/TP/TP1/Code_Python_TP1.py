import sys
import subprocess
from mpl_toolkits import mplot3d
import numpy as np
import matplotlib.pyplot as plt
import re

#----------------- Q2.1 ------------------------
sizes = [8192, 16384, 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304]
associativity = [1, 2, 4, 8]
D = {f"{key}": {} for key in sizes}
tpsa = []
cs = []
ass = []
en = []
surface = []
#----------------- Q2.1 ------------------------

#----------------- Q2.2 ------------------------
tpsaQ2 = []
enQ2 = []
surfaceQ2 = []
#----------------- Q2.2 ------------------------

#----------------- Q2.3 ------------------------
tpsaQ3 = []
enQ3 = []
surfaceQ3 = []
#----------------- Q2.3 ------------------------


#----------------- Q2.4 ------------------------
#te = 0.02
tm = 0.13
tempsAccesFinal = []
surfaceFinal = []
energieFinal = []
myAssociativity = 1
compteurUneFois = 0
resultatTotal = 0
bestResult = 0
#L1Instruction = [8192, 16384, 32768, 65536]
#L1Data = [8192, 16384, 32768, 65536]
L1 = [8192, 16384, 32768, 65536]
L2 = [65536, 131072, 262144]
L3 = [262144, 524288, 1048576, 2097152, 4194304]
te = [0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09]
#----------------- Q2.4 ------------------------


def get_info():
	info = subprocess.check_output(["./cacti", "-infile", "cache.cfg"])
	info = (info.decode("utf-8")).split("\n")
	energy = 0

	for x in info:
		if "Access time" in x:
			ta = x.split(":")[-1].strip()
		elif "Activate Energy" in x:
			energy += float(x.split(":")[-1].strip())
		elif "Read Energy" in x:
			energy += float(x.split(":")[-1].strip())
		elif "Write Energy" in x:
			energy += float(x.split(":")[-1].strip())
		elif "Precharge Energy" in x:
			energy += float(x.split(":")[-1].strip())
		elif "Cache height x width" in x:
			cache_size = x.split(":")[-1].strip()
	
	return ta, cache_size, str(energy)
	

def write_cfgPort(readWrite, read, write):
	with open("cache.cfg", "r") as f:
		txt = f.readlines()
	f.close()
	with open("cache.cfg", "w") as f:
		for line in txt:
			if "-exclusive read port" in line:
				line = "-exclusive read port " + f"{read}\n"
			elif "-exclusive write port" in line:
				line = "-exclusive write port " + f"{write}\n"
			elif "-read-write port" in line:
				line = "-read-write port " + f"{readWrite}\n"	
			f.write(line)
	f.close()

			
def write_cfg(s, a):
	with open("cache.cfg", "r") as f:
		txt = f.readlines()
	f.close()
	with open("cache.cfg", "w") as f:
		for line in txt:
			if "-size (bytes)" in line:
				line = "-size (bytes) " + f"{s}\n"
			elif "-associativity" in line:
				line = "-associativity " + f"{a}\n"
			f.write(line)
	f.close()


def write_cfgMode(word):
	with open("cache.cfg", "r") as f:
		txt = f.readlines()
	f.close()
	with open("cache.cfg", "w") as f:
		for line in txt:
			if "-access mode (normal, sequential, fast)" in line:
				line = '-access mode (normal, sequential, fast) - "' + word + '"\n'
			f.write(line)
	f.close()



#------------------- Q2.1 ----------------------
for size in sizes:
	for asso in associativity:
		write_cfg(size, asso)
		ta, cache_size, energy = get_info()
		D[f"{size}"][f"{asso}"] = [ta, cache_size, energy]
		ass.append(asso)
		tpsa.append(float(ta))
		cs.append(size) 
		en.append(float(energy))
		x = re.findall("\d+\.\d+",cache_size)
		surface.append(float(float(x[0]) * float(x[1])))
		
		if asso == myAssociativity :
			tempsAccesFinal.append(float(ta))
			surfaceFinal.append(float(float(x[0]) * float(x[1])))
			energieFinal.append(float(energy))
						
 #------------------- Q2.1 partie 1 ----------------------	
plt.figure('Q2.1, premier graphe')
ax = plt.axes(projection='3d')
ax.set_ylim3d(0,5000000)
ax.scatter3D(tpsa, cs, ass, c = ass, cmap = 'viridis')
ax.set_xlabel('Temps dacces (ns)')
ax.set_ylabel('Taille du cache (bytes)')
ax.set_zlabel('Associativité')
ax.set_title('Figure montrant le temps daccès en fonction de la taille du cache et de lassociativité')

 #------------------- Q2.1 partie 2 ----------------------
plt.figure('Q2.1, deuxième graphe')
ax2 = plt.axes(projection='3d')
ax2.scatter3D(tpsa, surface, en, c = en, cmap = 'viridis')
ax2.set_xlabel('Temps dacces (ns)')
ax2.set_ylabel('Surface du cache (mm)')
ax2.set_zlabel('Consommation énergétique (nJ)')
ax2.set_title('Figure montrant le temps daccès en fonction de la surface du cache et de la consommation énergétique')
#plt.show()



#------------------- Q2.2 ----------------------

ports = [(1,0,0),(0,1,1),(3,0,0),(0,3,3),(5,0,0),(0,5,5),(10,0,0),(0,10,10)]

for readWrite, read, write in ports:
	write_cfgPort(readWrite, read, write)
	taQ2, cache_sizeQ2, energyQ2 = get_info()
	tpsaQ2.append(float(taQ2))
	enQ2.append(float(energyQ2))
	xQ2 = re.findall("\d+\.\d+",cache_sizeQ2)
	surfaceQ2.append(float(float(xQ2[0]) * float(xQ2[1])))

 #------------------- Q2.2 ----------------------
plt.figure('Q2.2')
ax3 = plt.axes(projection='3d')
ax3.scatter3D(tpsaQ2, surfaceQ2, enQ2, c = enQ2, cmap = 'viridis')
for i, label in enumerate(ports):
	#ax3.text(tpsaQ2[i]-0.5,surfaceQ2[i]+1,enQ2[i],str(label))
	ax3.text(tpsaQ2[i],surfaceQ2[i],enQ2[i],str(label))
ax3.set_xlabel('Temps dacces (ns)')
ax3.set_ylabel('Surface du cache (mm)')
ax3.set_zlabel('Consommation énergétique (nJ)')
ax3.set_title('Figure montrant le temps daccès en fonction de la surface du cache et de la consommation énergétique')
#plt.show()



#------------------- Q2.3 ----------------------
modes = ["fast","normal", "sequential"]

for word in modes:
	write_cfgMode(word)
	taQ3, cache_sizeQ3, energyQ3 = get_info()
	tpsaQ3.append(float(taQ3))
	enQ3.append(float(energyQ3))
	xQ3 = re.findall("\d+\.\d+",cache_sizeQ3)
	surfaceQ3.append(float(float(xQ3[0]) * float(xQ3[1])))

#------------------- Q2.3 ----------------------
plt.figure('Q2.3')
ax4 = plt.axes(projection='3d')
ax4.scatter3D(tpsaQ3, surfaceQ3, enQ3, c = enQ3, cmap = 'viridis')
for i, label in enumerate(modes):
	ax4.text(tpsaQ3[i],surfaceQ3[i],enQ3[i],str(label))
ax4.set_xlabel('Temps dacces (ns)')
ax4.set_ylabel('Surface du cache (mm)')
ax4.set_zlabel('Consommation énergétique (nJ)')
ax4.set_title('Figure montrant le temps daccès en fonction de la surface du cache et de la consommation énergétique')
#plt.show()



#------------------- Q2.4 ----------------------
#for L1InstructionLoop in L1Instruction:
	#for L1DataLoop in L1Data:

#print(tempsAccesFinal)
#print(surfaceFinal)
#print(energieFinal)

write_cfgMode("normal")
write_cfgPort(1, 0, 0)
write_cfg(16384, myAssociativity)
"""
if myAssociativity == 8:
	te = 0.02
if myAssociativity == 4:
	te = 0.04
if myAssociativity == 2:
	te = 0.06
if myAssociativity == 1:
	te = 0.08
"""

for L1Loop in L1:
	for L2Loop in L2:
		for L3Loop in L3:
			i=0
			temponEnergie = 0
			temponSurface = 0
			for sizeLoop in sizes:
				if L3Loop == sizeLoop:
					temponL3 = tempsAccesFinal[i]
					temponEnergie += energieFinal[i]
					temponSurface += surfaceFinal[i]
					temponL3Loop = L3Loop
						
				if L2Loop == sizeLoop:
					temponL2 = tempsAccesFinal[i]	
					temponEnergie += energieFinal[i]
					temponSurface += surfaceFinal[i]
					temponL2Loop = L2Loop
					
				if L1Loop == sizeLoop:	
					temponL1 = tempsAccesFinal[i]
					temponEnergie += energieFinal[i]
					temponSurface += surfaceFinal[i]
					temponL1Loop = L1Loop
					
				i = i+1
					
				if i == 10:
					for teLoop in te:
						TAMM = temponL1 + teLoop*(temponL2 + teLoop*(temponL3 + teLoop*tm))	
				#print("temponL1 :", temponL1Loop, "temponL2 :", temponL2Loop, "temponL3 :", temponL3Loop)
						#print("TAMM : ", TAMM, "ns")
						#print("Energie : ", temponEnergie, "nJ")
						#print("Surface : ", temponSurface, "mm\n")
						resultatTotal = TAMM + temponEnergie + temponSurface
					
						#if compteurUneFois == 0:
						#bestResult = resultatTotal
						#compteurUneFois = 1
						print("Somme de tout : ", resultatTotal)
						print("temponL1 :", temponL1Loop, "temponL2 :", temponL2Loop, "temponL3 :", temponL3Loop, "taux échec :", teLoop)
						print("TAMM : ", TAMM, "ns")
						print("Energie : ", temponEnergie, "nJ")
						print("Surface : ", temponSurface, "mm\n")
						
						"""
						if(resultatTotal < bestResult):
							bestResult = resultatTotal
							print("Meilleur Résultat Final")
							print("Somme de tout : ", bestResult)
							print("temponL1 :", temponL1Loop, "temponL2 :", temponL2Loop, "temponL3 :", temponL3Loop, temponL3Loop, "taux échec :", teLoop)
							print("TAMM : ", TAMM, "ns")
							print("Energie : ", temponEnergie, "nJ")
							print("Surface : ", temponSurface, "mm\n")
						"""

plt.show()
					
					
						
