function P300_Online() % w must be in workspace

% Row/Column P300 Speller Stimulus Presentation Paradigm used for offline data collection

ISI=0.075;
colour_vector=[0 0 0];
colflashtime=0.1;
rowflashtime=0.1;
prev_rand_vector=zeros(12,1);
letter=0;

user_input='';

set_param('P300_Speller/BCI/START SIGNAL','Value','0');
set_param('P300_Speller/BCI/TARGET','Value','0');
set_param('P300_Speller/BCI/FLASH','Value','0');
f = figure('Interruptible','on','HandleVisibility','callback','Menubar','none','Visible','off','Name','The University of the West Indies Brain-Computer Interface Group: P300 Speller Stimulus Presentation Paradigm','Units','Normalized','Position',[0,0,0.8,0.8],'Toolbar','none','NumberTitle','off');
set(f,'CloseRequestFcn',@close_function);

user_entry_label=uicontrol('Parent',f,'Units','Normalized','Style','text','String','Spelt word:','Position',[0.05,0.85,0.25,0.1],'FontName','Arial','ForegroundColor',[0 0 0],'BackgroundColor',[1 1 1],'FontSize',30,'HorizontalAlignment','right');
user_entry=uicontrol('Parent',f,'Units','Normalized','Style','text','String',user_input,'Position',[0.30,0.85,0.6,0.1],'FontName','Arial','ForegroundColor',[0 0 0],'BackgroundColor',[1 1 1],'FontSize',25);
hbutton = uicontrol('Parent',f,'Style','pushbutton','Units','Normalized','String','START','Position',[0.4,0.01,0.2,0.05],'callback',@hbutton_callback);

    function close_function(source,eventdata)
        set_param('P300_Speller/BCI/START SIGNAL','Value','1');
        set_param('P300_Speller','SimulationCommand','stop');
        %clear global % Clear global variables on closign the GUI window
        delete(f);
    end

    function hbutton_callback(source,eventdata)
        
        set(hbutton,'Visible','off'); % Disable START BUTTON during presentation
        set(hbutton,'String','CONTINUE');
        set_param('P300_Speller','SimulationCommand','continue');
        myWait(3);
        trials=5;
        
        for trial=1:trials
            
            rand_vector=randperm(12);
            
            if(rand_vector(1)==prev_rand_vector(12)) % Interchange last and first element of random order vector in case
                temp=rand_vector(1); % the first stimuli of the current trial is the same as the last stimuli of the previous trial
                rand_vector(1)=rand_vector(12);
                rand_vector(12)=temp;
            end
            
            for c=1:12
                stim=rand_vector(c);
                
                switch stim
                    case 1
                        highlightcol1();
                        set_param('P300_Speller/BCI/FLASH','Value','1');
                        myWait(colflashtime);
                        revert();
                        set_param('P300_Speller/BCI/FLASH','Value','0');
                        myWait(ISI);
                    case 2
                        highlightcol2();
                        set_param('P300_Speller/BCI/FLASH','Value','2');
                        myWait(colflashtime);
                        revert();
                        set_param('P300_Speller/BCI/FLASH','Value','0');
                        myWait(ISI);
                    case 3
                        highlightcol3();
                        set_param('P300_Speller/BCI/FLASH','Value','3');
                        myWait(colflashtime);
                        revert();
                        set_param('P300_Speller/BCI/FLASH','Value','0');
                        myWait(ISI);
                    case 4
                        highlightcol4();
                        set_param('P300_Speller/BCI/FLASH','Value','4');
                        myWait(colflashtime);
                        revert();
                        set_param('P300_Speller/BCI/FLASH','Value','0');
                        myWait(ISI);
                    case 5
                        highlightcol5();
                        set_param('P300_Speller/BCI/FLASH','Value','5');
                        myWait(colflashtime);
                        revert();
                        set_param('P300_Speller/BCI/FLASH','Value','0');
                        myWait(ISI);
                    case 6
                        highlightcol6();
                        set_param('P300_Speller/BCI/FLASH','Value','6');
                        myWait(colflashtime);
                        revert();
                        set_param('P300_Speller/BCI/FLASH','Value','0');
                        myWait(ISI);
                    case 7
                        highlightrow1();
                        set_param('P300_Speller/BCI/FLASH','Value','7');
                        myWait(rowflashtime);
                        revert();
                        set_param('P300_Speller/BCI/FLASH','Value','0');
                        myWait(ISI);
                    case 8
                        highlightrow2();
                        set_param('P300_Speller/BCI/FLASH','Value','8');
                        myWait(rowflashtime);
                        revert();
                        set_param('P300_Speller/BCI/FLASH','Value','0');
                        myWait(ISI);
                    case 9
                        highlightrow3();
                        set_param('P300_Speller/BCI/FLASH','Value','9');
                        myWait(rowflashtime);
                        revert();
                        set_param('P300_Speller/BCI/FLASH','Value','0');
                        myWait(ISI);
                    case 10
                        highlightrow4();
                        set_param('P300_Speller/BCI/FLASH','Value','10');
                        myWait(rowflashtime);
                        revert();
                        set_param('P300_Speller/BCI/FLASH','Value','0');
                        myWait(ISI);
                    case 11
                        highlightrow5();
                        set_param('P300_Speller/BCI/FLASH','Value','11');
                        myWait(rowflashtime);
                        revert();
                        set_param('P300_Speller/BCI/FLASH','Value','0');
                        myWait(ISI);
                    case 12
                        highlightrow6();
                        set_param('P300_Speller/BCI/FLASH','Value','12');
                        myWait(rowflashtime);
                        revert();
                        set_param('P300_Speller/BCI/FLASH','Value','0');
                        myWait(ISI);
                end
                
            end
            
            prev_rand_vector=rand_vector;
            set_param('P300_Speller/BCI/FLASH','Value','0');
            
        end
        
        letter=letter+1;
        
        myWait(1);
        set_param('P300_Speller','SimulationCommand','pause'); % stop simulink EEG capture so we can classify one letter
        % can pause and continue simulation instead
        %filename=get_param('P300_Speller/To File','Filename'); % Get filename under which recorded EEG data matrix was stored
        %evalin('base','clear y');  % clear base workspace variable y
        %evalin('base',['load ' filename]); % Load matrix in base (command line) workspace
        evalin('base','a=y'); % Copy y to a
        evalin('base','global a'); % Make matrix global and hence accessible to GUI
        evalin('base','global w'); % Make matrix global and hence accessible to GUI
        global a; % Import matrix to GUI workspace
        global w;
        
        classified_letter=online_classify(a,trials,w,letter); % classify letter after number of trials for one letter
        user_input=strcat(user_input,classified_letter);
        set(user_entry,'String',user_input); % add this letter at the top of the screen
        
        evalin('base',['delete ',filename]); % delete file so new file can be written
        evalin('base','clear a');  % clear base workspace variable y
        evalin('base','a=w');  % clear base workspace variable y
        clear global
        evalin('base','w=a, clear a');  % clear base workspace variable y
        clear a % clear GUI workspace variable a
        set(hbutton,'Visible','on'); % Make start button visible again
        
    end

    function highlightA()
        set(A,'ForegroundColor',colour_vector);
    end

    function highlightB()
        set(B,'ForegroundColor',colour_vector);
    end

    function highlightC()
        set(C,'ForegroundColor',colour_vector);
    end

    function highlightD()
        set(D,'ForegroundColor',colour_vector);
    end

    function highlightE()
        set(E,'ForegroundColor',colour_vector);
    end

    function highlightF()
        set(F,'ForegroundColor',colour_vector);
    end

    function highlightG()
        set(G,'ForegroundColor',colour_vector);
    end

    function highlightH()
        set(H,'ForegroundColor',colour_vector);
    end

    function highlightI()
        set(I,'ForegroundColor',colour_vector);
    end

    function highlightJ()
        set(J,'ForegroundColor',colour_vector);
    end

    function highlightK()
        set(K,'ForegroundColor',colour_vector);
    end

    function highlightL()
        set(L,'ForegroundColor',colour_vector);
    end

    function highlightM()
        set(M,'ForegroundColor',colour_vector);
    end

    function highlightN()
        set(N,'ForegroundColor',colour_vector);
    end

    function highlightO()
        set(O,'ForegroundColor',colour_vector);
    end

    function highlightP()
        set(P,'ForegroundColor',colour_vector);
    end

    function highlightQ()
        set(Q,'ForegroundColor',colour_vector);
    end

    function highlightR()
        set(R,'ForegroundColor',colour_vector);
    end

    function highlightS()
        set(S,'ForegroundColor',colour_vector);
    end

    function highlightT()
        set(T,'ForegroundColor',colour_vector);
    end

    function highlightU()
        set(U,'ForegroundColor',colour_vector);
    end

    function highlightV()
        set(V,'ForegroundColor',colour_vector);
    end

    function highlightW()
        set(W,'ForegroundColor',colour_vector);
    end

    function highlightX()
        set(X,'ForegroundColor',colour_vector);
    end

    function highlightY()
        set(Y,'ForegroundColor',colour_vector);
    end

    function highlightZ()
        set(Z,'ForegroundColor',colour_vector);
    end

    function highlight0()
        set(zero,'ForegroundColor',colour_vector);
    end

    function highlight1()
        set(one,'ForegroundColor',colour_vector);
    end

    function highlight2()
        set(two,'ForegroundColor',colour_vector);
    end

    function highlight3()
        set(three,'ForegroundColor',colour_vector);
    end

    function highlight4()
        set(four,'ForegroundColor',colour_vector);
    end

    function highlight5()
        set(five,'ForegroundColor',colour_vector);
    end

    function highlight6()
        set(six,'ForegroundColor',colour_vector);
    end

    function highlight7()
        set(seven,'ForegroundColor',colour_vector);
    end

    function highlight8()
        set(eight,'ForegroundColor',colour_vector);
    end

    function highlight9()
        set(nine,'ForegroundColor',colour_vector);
    end

    function highlightrow1(object,eventdata)
        set([A,B,C,D,E,F],'ForegroundColor',colour_vector);
    end

    function highlightrow2(object,eventdata)
        set([G,H,I,J,K,L],'ForegroundColor',colour_vector);
    end

    function highlightrow3(object,eventdata)
        set([M,N,O,P,Q,R],'ForegroundColor',colour_vector);
    end

    function highlightrow4(object,eventdata)
        set([S,T,U,V,W,X],'ForegroundColor',colour_vector);
    end

    function highlightrow5(object,eventdata)
        set([Y,Z,zero,one,two,three],'ForegroundColor',colour_vector);
    end

    function highlightrow6(object,eventdata)
        set([four,five,six,seven,eight,nine],'ForegroundColor',colour_vector);
    end

    function highlightcol1(object,eventdata)
        set([A,G,M,S,Y,four],'ForegroundColor',colour_vector);
    end

    function highlightcol2(object,eventdata)
        set([B,H,N,T,Z,five],'ForegroundColor',colour_vector);
    end

    function highlightcol3(object,eventdata)
        set([C,I,O,U,zero,six],'ForegroundColor',colour_vector);
    end

    function highlightcol4(object,eventdata)
        set([D,J,P,V,one,seven],'ForegroundColor',colour_vector);
    end

    function highlightcol5(object,eventdata)
        set([E,K,Q,W,two,eight],'ForegroundColor',colour_vector);
    end

    function highlightcol6(object,eventdata)
        set([F,L,R,X,three,nine],'ForegroundColor',colour_vector);
    end

    function revert(object,eventdata)
        set([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,zero,one,two,three,four,five,six,seven,eight,nine],'ForegroundColor',[0.75 0.75 0.75]);
    end

A = uicontrol('Parent',f,'Units','Normalized','Style','text','String','A','Position',[0.2,0.6,0.1,0.1]);
B = uicontrol('Parent',f,'Units','Normalized','Style','text','String','B','Position',[0.3,0.6,0.1,0.1]);
C = uicontrol('Parent',f,'Units','Normalized','Style','text','String','C','Position',[0.4,0.6,0.1,0.1]);
D = uicontrol('Parent',f,'Units','Normalized','Style','text','String','D','Position',[0.5,0.6,0.1,0.1]);
E = uicontrol('Parent',f,'Units','Normalized','Style','text','String','E','Position',[0.6,0.6,0.1,0.1]);
F = uicontrol('Parent',f,'Units','Normalized','Style','text','String','F','Position',[0.7,0.6,0.1,0.1]);
G = uicontrol('Parent',f,'Units','Normalized','Style','text','String','G','Position',[0.2,0.5,0.1,0.1]);
H = uicontrol('Parent',f,'Units','Normalized','Style','text','String','H','Position',[0.3,0.5,0.1,0.1]);
I = uicontrol('Parent',f,'Units','Normalized','Style','text','String','I','Position',[0.4,0.5,0.1,0.1]);
J = uicontrol('Parent',f,'Units','Normalized','Style','text','String','J','Position',[0.5,0.5,0.1,0.1]);
K = uicontrol('Parent',f,'Units','Normalized','Style','text','String','K','Position',[0.6,0.5,0.1,0.1]);
L = uicontrol('Parent',f,'Units','Normalized','Style','text','String','L','Position',[0.7,0.5,0.1,0.1]);
M = uicontrol('Parent',f,'Units','Normalized','Style','text','String','M','Position',[0.2,0.4,0.1,0.1]);
N = uicontrol('Parent',f,'Units','Normalized','Style','text','String','N','Position',[0.3,0.4,0.1,0.1]);
O = uicontrol('Parent',f,'Units','Normalized','Style','text','String','O','Position',[0.4,0.4,0.1,0.1]);
P = uicontrol('Parent',f,'Units','Normalized','Style','text','String','P','Position',[0.5,0.4,0.1,0.1]);
Q = uicontrol('Parent',f,'Units','Normalized','Style','text','String','Q','Position',[0.6,0.4,0.1,0.1]);
R = uicontrol('Parent',f,'Units','Normalized','Style','text','String','R','Position',[0.7,0.4,0.1,0.1]);
S = uicontrol('Parent',f,'Units','Normalized','Style','text','String','S','Position',[0.2,0.3,0.1,0.1]);
T = uicontrol('Parent',f,'Units','Normalized','Style','text','String','T','Position',[0.3,0.3,0.1,0.1]);
U = uicontrol('Parent',f,'Units','Normalized','Style','text','String','U','Position',[0.4,0.3,0.1,0.1]);
V = uicontrol('Parent',f,'Units','Normalized','Style','text','String','V','Position',[0.5,0.3,0.1,0.1]);
W = uicontrol('Parent',f,'Units','Normalized','Style','text','String','W','Position',[0.6,0.3,0.1,0.1]);
X = uicontrol('Parent',f,'Units','Normalized','Style','text','String','X','Position',[0.7,0.3,0.1,0.1]);
Y = uicontrol('Parent',f,'Units','Normalized','Style','text','String','Y','Position',[0.2,0.2,0.1,0.1]);
Z = uicontrol('Parent',f,'Units','Normalized','Style','text','String','Z','Position',[0.3,0.2,0.1,0.1]);
zero= uicontrol('Parent',f,'Units','Normalized','Style','text','String','0','Position',[0.4,0.2,0.1,0.1]);
one = uicontrol('Parent',f,'Units','Normalized','Style','text','String','1','Position',[0.5,0.2,0.1,0.1]);
two = uicontrol('Parent',f,'Units','Normalized','Style','text','String','2','Position',[0.6,0.2,0.1,0.1]);
three = uicontrol('Parent',f,'Units','Normalized','Style','text','String','3','Position',[0.7,0.2,0.1,0.1]);
four = uicontrol('Parent',f,'Units','Normalized','Style','text','String','4','Position',[0.2,0.1,0.1,0.1]);
five = uicontrol('Parent',f,'Units','Normalized','Style','text','String','5','Position',[0.3,0.1,0.1,0.1]);
six = uicontrol('Parent',f,'Units','Normalized','Style','text','String','6','Position',[0.4,0.1,0.1,0.1]);
seven = uicontrol('Parent',f,'Units','Normalized','Style','text','String','7','Position',[0.5,0.1,0.1,0.1]);
eight = uicontrol('Parent',f,'Units','Normalized','Style','text','String','8','Position',[0.6,0.1,0.1,0.1]);
nine = uicontrol('Parent',f,'Units','Normalized','Style','text','String','9','Position',[0.7,0.1,0.1,0.1]);

set([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,zero,one,two,three,four,five,six,seven,eight,nine],'FontName','Arial','ForegroundColor',[0.75 0.75 0.75],'BackgroundColor',[1 1 1],'FontSize',40);

movegui(f,'center');
set(f,'Visible','on');

end