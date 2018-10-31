function accuracy=seven_fold_cross_validation(y)

accuracy=0;

for n=1:7
    training_letters=[1:5*(n-1),5*n+1:35];
    test_letters=5*(n-1)+1:5*n;
    w=train_LDA(y,5,training_letters);
    accuracy=accuracy+offline_classify(y,5,w,test_letters);

%     [p300_features,non_p300_features]=extract_features(y,5,training_letters);
%     x=[p300_features; non_p300_features];
%     target_labels=[ones(size(p300_features,1),1) ; repmat([-1],size(non_p300_features,1),1)];
%     
%     b = bayeslda(1);
%     b = train(b,x',target_labels');
%     
%     accuracy=accuracy+offline_classify(y,5,b,test_letters);

end

accuracy=accuracy/7; % get mean 7-fold cross-validation accuracy

end