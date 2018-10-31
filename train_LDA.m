function w = train_LDA(y,trials) % trials = number of trials used for stimulus presentation

[p300_features,non_p300_features]=extract_features(y,trials,1:35);
[A,B,w]=lda(p300_features,non_p300_features);