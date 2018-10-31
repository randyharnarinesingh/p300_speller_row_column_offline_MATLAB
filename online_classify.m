function classified_letter=online_classify(y,trials,w,letter) % y is input matrix, w is the lda vector

y=y';

% to be used for online classification
% EEG is sampled at 256Hz from 8 sites
% P300 Speller Matrix Paradigm is used

filterorder=3;
filtercutoff =[1/256 12/256];
[f_b, f_a] = butter(filterorder,filtercutoff);
n_channels=8;

for j = (1+1):(n_channels+1)
    y(j,:) = filtfilt(f_b,f_a,y(j,:));
end

    p300_values=zeros(trials,12);
    
    for stimulus=1:12
        
        StimulusCode=y(10,:); % y(10,:) holds stimulus coding info
        StimulusCode=[0,diff(StimulusCode)];
        StimulusCode(StimulusCode<0)=0;
        indices=find(StimulusCode==stimulus);
        
        for trial=trials*(letter-1)+1:trials*letter
        
            segment=y(2:9,indices(trial):indices(trial)+140);
            
            range=1:8:128;
            
            f1=segment(1,range);
            f2=segment(2,range);
            f3=segment(3,range);
            f4=segment(4,range);
            f5=segment(5,range);
            f6=segment(6,range);
            f7=segment(7,range);
            f8=segment(8,range);
            
            feature_vector=[f1, f2, f3, f4, f5, f6, f7, f8];
            
            p300_value=dot(feature_vector,w);
            %p300_value=classify(w,feature_vector');
            p300_values(trial,stimulus)=p300_value;
        end
        
    end
    
    p300_values=sum(p300_values,1); % sum the LDA vector for all single-trials into one vector
    
    row_values=p300_values(7:12);
    column_values=p300_values(1:6);
    
    row=find(max(row_values)==row_values);
    row=row(1);
    col=find(max(column_values)==column_values);
    col=col(1);
    
    switch row
        case 1, temp='ABCDEF';
        case 2, temp='GHIJKL';
        case 3, temp='MNOPQR';
        case 4, temp='STUVWX';
        case 5, temp='YZ_123'; % Use the 0 as a space in this case
        case 6, temp='456789';
    end
        
classified_letter=temp(col);

end

