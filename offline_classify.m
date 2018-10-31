function accuracy=offline_classify(y,trials,w,letters) % y is input matrix, w is lda projection vector

y=y'; % y is transposed

% to be used for offline classification
% EEG is sampled at 256Hz from 8 sites
% P300 Speller Matrix Paradigm is used

accuracy=0;

filterorder=3;
filtercutoff =[0.5/128 6/128];
[f_b, f_a] = butter(filterorder,filtercutoff);
n_channels=8;

for j = 1:n_channels
    y(j,:) = filtfilt(f_b,f_a,y(j,:));
end

for letter=letters
    
    p300_values=zeros(trials,12);
    
    for stimulus=1:12
        
        StimulusCode=y(9,:); % y(9,:) holds stimulus coding info
        StimulusCode=[0,diff(StimulusCode)];
        StimulusCode(StimulusCode<0)=0;
        indices=find(StimulusCode==stimulus);
        
        for trial=5*(letter-1)+1:5*(letter-1)+trials
            
            segment=y(1:8,indices(trial):indices(trial)+256);
           
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
            %p300_value=classify(w,feature_vector'); % used for BLDA classification
            p300_values(trial,stimulus)=p300_value;
        end
        
    end
    
    p300_values=sum(p300_values,1); % sum the LDA vector for all single-trials into one vector for each letter
    
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
    
    fprintf('%c',temp(col))
    actual='THEQUICKBROWNFOXJUMPSOVERTHELAZYDOG';
    
    if(actual(letter)==temp(col))
        accuracy=accuracy+1;
    end
    
end

fprintf('\n');
accuracy=100*accuracy/(length(letters));

end