function [p300_features,non_p300_features]=extract_features(y,trials,letters) % y is input matrix

y=y';

% letters = 1:35 for offline
% letters = 1 for online (since we classify one letter at a time)
% EEG is sampled at 256Hz from 8 sites % P300 Speller Matrix Paradigm is used

filterorder=3;
filtercutoff =[0.5/128 6/128];
[f_b, f_a] = butter(filterorder,filtercutoff);
n_channels=8;

for j = 1:n_channels
    y(j,:) = filtfilt(f_b,f_a,y(j,:));
end

p300_features=[];
non_p300_features=[];

for stimulus=1:12
    
    StimulusCode=y(9,:); % y(9,:) holds stimulus coding info
    StimulusCode=[0,diff(StimulusCode)];
    StimulusCode(StimulusCode<0)=0;
    indices=find(StimulusCode==stimulus);
    
    for letter=letters
        
        for trial=trials*(letter-1)+1:trials*(letter-1)+trials
            segment=y(1:8,indices(trial):indices(trial)+256); % Extracts features from single-trials
            
            %             for c=1:8
            %                 channel=segment(c,:);
            %                 low=min(channel);
            %                 high=max(channel); % windsorise each channel at 10 and 90 percentile
            %                 ten_p=(10/100)*(high-low)+low;
            %                 ninety_p=(90/100)*(high-low)+low;
            %                 channel(channel<ten_p)=ten_p;
            %                 channel(channel>ninety_p)=ninety_p;
            %
            %                 high=max(channel);
            %                 low=min(channel);
            %                 scaling=2/(high-low); % Scale to range -1 to 1
            %                 channel=channel*scaling;
            %                 channel=channel-max(channel)+1;
            %
            %                 segment(c,:)=channel;
            %             end
            
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
                        
            if(y(10,indices(trial))==1) % y(10,:) holds target coding info
                p300_features=[p300_features; feature_vector];
            else
                non_p300_features=[non_p300_features; feature_vector];
            end
            
        end
        
    end
    
end

end