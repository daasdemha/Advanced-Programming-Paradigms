from z3 import *
import time

def valuesAddedToVariables(jobsPerWorker):

  """  

   Jobs 1,2,3,4,5,6,7,8,9,11,12,13 are dealt with here.
   The Function oneTruthAndTwoLies takes 1 parameter which is jobsPerWorker 
   12 jobs 1,2,3,4,5,6,7,8,9,11,12,13 and all three workers.

   It returns a Z3 Conditional Statement with each job with each worker as true or false.

  """
  new_list = [1,2,3,4,5,6,7,8,9,11,12,13]
  return [

        And(Or(
        Or(jobsPerWorker[0][i] == new_list[i]*2      ,    jobsPerWorker[0][i] == 0),
        Or(jobsPerWorker[1][i] == new_list[i]+5      ,    jobsPerWorker[1][i] == 0),
        Or(jobsPerWorker[2][i] == new_list[i]+20     ,    jobsPerWorker[2][i] == 0)),
        
        jobsPerWorker[0][i] >= 0, jobsPerWorker[1][i] >= 0, jobsPerWorker[2][i] >= 0,
        jobsPerWorker[0][i] != 1, jobsPerWorker[1][i] != 1, jobsPerWorker[2][i] != 1,
        jobsPerWorker[0][i] != 3, jobsPerWorker[1][i] != 3, jobsPerWorker[2][i] != 3,
        jobsPerWorker[0][i] != 5, jobsPerWorker[1][i] != 5, jobsPerWorker[2][i] != 5,

        jobsPerWorker[0][i] <= 35, jobsPerWorker[1][i] <= 35, jobsPerWorker[2][i] <= 35,
        )
        for i in range(12)

  ]

def removeSpecialJobs(jobsPerWorker):

  """  

   Jobs 1,2,3,4,5,6,7,8,9,11,12,13 are dealt with here.
   The Function removeSpecialJobs takes 1 parameter which is total number of jobs and workers.
   it returns jobs and workes with Jobs j10, j14, and j15 removed from the list.

  """
  
  return [[jobsPerWorker[j][i] for i in [0,1,2,3,4,5,6,7,8,10,11,12]] for j in [0,1,2]]


def ValidityCheck(jobsPerWorkerwithremovedelements):

  """  

   Jobs 1,2,3,4,5,6,7,8,9,11,12,13 are dealt with here.
   The Function ValidityCheck takes 1 parameter which is jobsPerWorkerwithremovedelements 
   12 jobs 1,2,3,4,5,6,7,8,9,11,12,13 and all three workers.

   It returns a Z3 Conditional Statement that only one worker can do one job.

"""
  #Or(jobsPerWorkerwithremovedelements[j][i] == 0, jobsPerWorkerwithremovedelements[j][i] == 1)
  return [

    If(jobsPerWorkerwithremovedelements[0][i] > 0,True,
    If(jobsPerWorkerwithremovedelements[1][i] > 0,True, 
    If(jobsPerWorkerwithremovedelements[2][i] > 0,True,
    False)))
  
    for i in range(12)
  
  ]

def Job101415(jobsPerWorker):

  """

   The function Job101415 takes one input jobsPerWorker
   the case that Jobs j10, j14, and j15 must all be undertaken by the same worker is dealt with here.

  """

  return [
    
    And(
    Or(And(jobsPerWorker[0][9] == 10 *2  ,jobsPerWorker[0][13]== 14 *2    , jobsPerWorker[0][14]== 15 *2), 
       And(jobsPerWorker[0][9] == 0      ,jobsPerWorker[0][13]== 0        , jobsPerWorker[0][14]== 0 )),

    Or(And(jobsPerWorker[1][9] == 10 +5  ,jobsPerWorker[1][13]== 14 +5   , jobsPerWorker[1][14]== 15 +5), 
       And(jobsPerWorker[1][9] == 0      ,jobsPerWorker[1][13]== 0       , jobsPerWorker[1][14]== 0)),

    Or(And(jobsPerWorker[2][9] == 10 +20 ,jobsPerWorker[2][13]== 14 +20  , jobsPerWorker[2][14]== 15 +20), 
       And(jobsPerWorker[2][9] == 0      ,jobsPerWorker[2][13]== 0       , jobsPerWorker[2][14]== 0)),

       jobsPerWorker[0][9] >= 0, jobsPerWorker[0][13] >= 0, jobsPerWorker[0][14] >= 0,
       jobsPerWorker[1][9] >= 0, jobsPerWorker[1][13] >= 0, jobsPerWorker[1][14] >= 0,
       jobsPerWorker[2][9] >= 0, jobsPerWorker[2][13] >= 0, jobsPerWorker[2][14] >= 0,

       jobsPerWorker[0][9] <= 35, jobsPerWorker[0][13] <= 35, jobsPerWorker[0][14] <= 35,
       jobsPerWorker[1][9] <= 35, jobsPerWorker[1][13] <= 35, jobsPerWorker[1][14] <= 35,
       jobsPerWorker[2][9] <= 35, jobsPerWorker[2][13] <= 35, jobsPerWorker[2][14] <= 35
       )
    ]

def ValidityCheck2(jobsPerWorker): 

  """

   The function Job101415 takes one input jobsPerWorker
   the case that Jobs j10, j14, and j15 must all be undertaken by the same worker is dealt with here.
   Only job10 has been validated with each worker as other jobs 10 14 and 15 are connected with each worker.
   the mentioned connection can be observed in the function Job101415

  """
  return [
    Or(

    If(jobsPerWorker[0][9] > 0,True,
    If(jobsPerWorker[1][9] > 0,True, 
    If(jobsPerWorker[2][9] > 0,True,
    False))),

    If(jobsPerWorker[0][13] > 0,True,
    If(jobsPerWorker[1][13] > 0,True, 
    If(jobsPerWorker[2][13] > 0,True,
    False))),

    If(jobsPerWorker[0][14] > 0,True,
    If(jobsPerWorker[1][14] > 0,True, 
    If(jobsPerWorker[2][14] > 0,True,
    False)))
    
    )
    ]

def sumOfWorkers(jobsPerWorker,Workers,index):
      return [Workers[index] == Sum([jobsPerWorker[index][j] for j in range(15)])]


def specifyingWhatEachWorkerAndJobIsNot(jobsPerWorker,cost,index):

  return [(jobsPerWorker[index][i] != j) for i in range(15) for j in cost[:i] + cost[i+1:] ] 

def specifyingWhatEachWorkerAndJobIsNotPart2(jobsPerWorker,cost,index):
  return [(jobsPerWorker[index][j] != i) for j in range(15) for i in cost]

def specifyingWhatEachWorkerAndJobIsNotPart3(jobsPerWorker):
  a = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30]
  b = [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
  c = [21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35]
  
  retrunme =  (specifyingWhatEachWorkerAndJobIsNot(jobsPerWorker,a,0) + 
  specifyingWhatEachWorkerAndJobIsNot(jobsPerWorker,b,1) + 
  specifyingWhatEachWorkerAndJobIsNot(jobsPerWorker,c,2) +
  specifyingWhatEachWorkerAndJobIsNotPart2(jobsPerWorker,[item for item in b+c if item not in a],0) +
  specifyingWhatEachWorkerAndJobIsNotPart2(jobsPerWorker,[item for item in a+c if item not in b],1) +
  specifyingWhatEachWorkerAndJobIsNotPart2(jobsPerWorker,[item for item in a+b if item not in c],2))
  return retrunme



def main():

  # Section 1
  jobsPerWorker = [ [ Int("w%sj%s" % (j, i+1)) for i in range(15) ] for j in "ABC"]
  jobsPerWorkerwithremovedelements = removeSpecialJobs(jobsPerWorker)
  c1                               = valuesAddedToVariables(jobsPerWorkerwithremovedelements)
  c2                               = ValidityCheck(jobsPerWorkerwithremovedelements)
  c3                               = Job101415(jobsPerWorker)
  c4                               = ValidityCheck2(jobsPerWorker)
  c5                               = specifyingWhatEachWorkerAndJobIsNotPart3(jobsPerWorker)
  
  # Section 2
  Workers = [ Int("w%s" % i) for i in "ABC" ]
  c6                               = sumOfWorkers(jobsPerWorker,Workers,0)
  c7                               = sumOfWorkers(jobsPerWorker,Workers,1)
  c8                               = sumOfWorkers(jobsPerWorker,Workers,2)

  
  
  # Section 3
  efficient_Working_conds = c1+c2+c3+c4+c5+c6+c7+c8

  s = Solver()
  s.push()
  s.add(efficient_Working_conds)
  print("Finding Solution")

  t1=time.perf_counter()
  i = 195
  while i != 0:
    foundSol = s.check()
    if foundSol==sat:
        s.push()
        s.add([Workers[0]<i]+[Workers[1]<i]+[Workers[2]<i])
        i = i - 1
    else:
        i = i + 2
        break
  t2=time.perf_counter()
  print("solution 1: ")
  print("Solver finished in: " + str(t2-t1))
  print("The Best Solution found was: ")
  

  solve(efficient_Working_conds + [Workers[0]<i] + [Workers[1]<i] +[Workers[2]<i])

main()