function [lik,lik2,lik3,sig,mu,stdev] = likelihood(Xtrain, mode)

[m,n] = size(Xtrain);

feature = mode_read(mode);

Xtest = zeros(1,5);


% getting column feature of Xtrain
feat = Xtrain(:,feature);

% maximum value for feature column in Xtrain
M = max(feat);

mu = zeros(M+1,1);
sig = zeros(M+1,1);
lik = zeros(M+1,1);
lik2 = zeros(M+1,1);
lik3 = zeros(M+1,1);
stdev = zeros(M+1,1);

% looping through the values in feature
for i = 0:M
    
    % gaussian distribution of noise
    Xtest(1,feature) = i;
    
    [avg,group] = average(Xtrain,Xtest,mode);
    
    [l,n] = size(group);
    
    mu(i+1,1) = avg;
    avg
    
    x = group(:,4);
    
    sig(i+1,1) = sum((x - mu(i+1,1)).^2)/l;
    
    stdev(i+1,1) = sqrt(sig(i+1,1));
    
    gauss = (1/sqrt(2*pi()*sig(i+1,1))) * exp(-1/(2*sig(i+1,1))*(x - mu(i+1,1)).^2);
    
    lik(i+1,1) = sum(log(gauss));
    
    % binomial distribution
    
    binomial = 1/(100^l);
    
    lik2(i+1,1) = -l*log(100);
    
    
    % truncated gaussian
    
    trunc = (.5*(erf((100-mu(i+1,1)+1)/sqrt(2*sig(i+1,1)))+1)-.5*(erf((0-mu(i+1,1)+1)/sqrt(2*sig(i+1,1)))+1));
    trunc_gauss = gauss/trunc;
    
    lik3(i+1,1) = sum(log(trunc_gauss));
    
    
end



figure(1)
plot(x,gauss,'b.')
hold on
plot(x,zeros(l,1),'r.')
hold off

figure(2)
plot(x,zeros(l,1),'.')

figure(3)
plot(x,trunc_gauss,'.')

end