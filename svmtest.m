addpath('./SVM');
model = svmtrain(year1rotulos, year1conjunto, '-c 10000 -t 3 -g 0.07 -b 0 -h 0 -w0 1 -w1 2');
[predict_label, accuracy, prob_values] = svmpredict(year3rotulos, year3conjunto, model, '-b 0');