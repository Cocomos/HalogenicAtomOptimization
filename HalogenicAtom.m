% Author: Trevor Reutershan
% Main Code
% Version: 0.5.1


%% Initialization
clear all; format short e; tic;
dialog('intro'); % Access "intro" dialog
globalFit = 0; autoRead = 0; analyteConc = 0; ksulf = 0; fudge = 0;
options = optimset('MaxFunEvals',100000,'MaxIter',100000);



%% Data File
tmp = dialog('dataAsk'); % Access dialog to ask for data file
dataIn = input(tmp, 's');
flag = 0;
while flag == 0,
    if strcmpi(dataIn, 's'), % Interactive select
        dataIn = uigetfile;
    elseif strcmpi(dataIn, 'q') || strcmpi(dataIn, 'quit'), % Quit program
        dialog('quitter'); return;
    elseif strcmpi(dataIn, 'h') || strcmpi(dataIn, 'help'), % Help file
        dialog('nohelp'); % Access "no help file" dialog
        dialog('enterkey'); % Access "enter to continue" routine
        dataIn = input(tmp, 's');
    elseif exist(dataIn,'file'),
        [~,~,ext] = fileparts(dataIn);
        if strcmpi(ext, '.xls') || strcmpi(ext, '.xlsx'),
            flag = 1; % Flag to exit while
        else
            dialog('notsupported'); % Access "file not supported" dialog
            dialog('enterkey'); % Access "enter to continue" routine
            dataIn = input(tmp, 's');
        end
    else
        dialog('dataDNE'); % Access "data file doesn't exist" dialog
        dialog('enterkey'); % Access "enter to continue" routine
        dataIn = input(tmp, 's');
    end
end



%% Excel Sheet
tmp = sprintf('\n\nExcel file detected.\n\n'); disp(tmp); %Need to change
tmp = sprintf(['File chosen: ', dataIn]); disp(tmp);
tmp = dialog('xcelSheet');
[~,xcelSheet] = xlsfinfo(dataIn);
flag = 0;
while flag == 0,
    dataSheet = input(tmp, 's');
    if any(strcmpi(dataSheet, xcelSheet)),
        flag = 1;
    elseif strcmpi(dataSheet, 'q') || strcmpi(dataSheet, 'quit'),
        dialog('quitter'); return;
    else
        dialog('sheetFail');
        dialog('enterkey');
    end
end



%% Read File
tmp = dialog('xcelLoc');
choice = input(tmp, 's');
flag = 0;
while flag == 0,
    if strcmpi(choice, 'a'), % Automatic read routine
        time = xlsread(dataIn, dataSheet, 'A16:A174');
        data = xlsread(dataIn, dataSheet, 'B16:P174');
        analyteConc = xlsread(dataIn, dataSheet, 'B7:P7');
        analyteConc = analyteConc';
        flag = 1; autoRead = 1;
    elseif strcmpi(choice, 'q') || strcmpi(choice, 'quit'), % Quit program
        dialog('quitter'); return;
    elseif strcmpi(choice, 'h') || strcmpi(choice, 'help'), % Help file
        dialog('nohelp'); % Access "no help file" dialog
        dialog('enterkey'); % Access "enter to continue" routine
        choice = input(tmp, 's');
    elseif strcmpi(choice, 'mx') || strcmpi(choice, 'mi') || strcmpi(choice, 'md'),
        dialog('notsupportedf'); % Access "not supported function" dialog
        dialog('enterkey'); % Access "enter to continue" routine
        choice = input(tmp, 's');
    else
        dialog('unkcmd'); % Access "uknown command" dialog
        dialog('enterkey'); % Access "enter to continue" routine
        dataIn = input(tmp, 's');
    end
end %%%!!!! need to make other data reading routines



%% Order Select
tmp = dialog('order');
order = 0;
while order == 0,
    order = input(tmp, 's');
    if strcmp(order, '1') || strcmp(order, '2'),
        order = str2num(order);
        if order == 1,
            klng = 4;
        else
            klng = 5;
        end
    elseif strcmpi(order, 'q') || strcmpi(order, 'quit'), % Quit program
        dialog('quitter'); return;
    elseif strcmpi(order, 'h') || strcmpi(order, 'help'),
        dialog('nohelp'); % Access "no help file" dialog
        dialog('enterkey'); % Access "enter to continue" routine
    else
        order = 0;
        dialog('errorder');
    end
end



%% Type of Data Fit
tmp = dialog('type');
[nodes,lngdata] = size(data);
flag = 0;
while flag == 0,
    type = input(tmp, 's');
    if strcmpi(type, 'q') || strcmpi(type, 'quit'), % Quit program
        dialog('quitter'); return;
    elseif strcmpi(type, 'h') || strcmpi(type, 'help'),
        dialog('nohelp'); % Access "no help file" dialog
        dialog('enterkey'); % Access "enter to continue" routine
    elseif strcmpi(type, 'all'),
        flag = 1; type = 1; globalFit = 1;
    elseif strcmpi(type, 'i'),
        flagg = 0;
        while flagg == 0,
            tmp0 = sprintf(['\n\tNumber of kinetic traces = ', num2str(lngdata)]);
            disp(tmp0);
            tmp = dialog('columns');
            type = input(tmp, 's'); type = str2num(type);
            if length(type) <= lngdata && norm(type, inf) <= 15 && any(type == 0) == 0,
                flag = 1; flagg = 1;
            elseif length(type) > lngdata
                tmp0 = dialog('datalength');
                disp(tmp0);
            elseif any(type == 0) == 1,
                tmp0 = dialog('nozero');
                disp(tmp0);
            else
                tmp0 = dialog('toobig');
                disp(tmp0);
            end
        end
    else
        dialog('unkcmd'); % Access "uknown command" dialog
        dialog('enterkey'); % Access "enter to continue" routine
    end
end



%% Sulfate radical fix
tmp = dialog('sulf');
sulf = input(tmp, 's');
if strcmpi(sulf, 'q') || strcmpi(sulf, 'quit'), % Quit program
    dialog('quitter'); return;
elseif strcmpi(sulf, 'y') || strcmpi(sulf, 'yes'),
    tmp = dialog('enterSulf');
    ksulf = input(tmp);
    sulf = 1;
    tmp = dialog('enterFudge');
    fudge = input(tmp);
    if autoRead == 0,
        %%%%%%%%%%%%%%%%%%%%%%%%% Need to ask for data %%%%%%%%%%%%%%%%%%%%
    end
else
    sulf = 0;
end



% Reutershan Guess Q
% tmp = dialog('rguessq');
% flag = 0;
% while flag == 0,
%     ki = input(tmp, 's');
%     if strcmpi(ki, 'q') || strcmpi(ki, 'quit'), % Quit program
%         disp('quitter'); return;
%     elseif strcmpi(ki, 'h') || strcmpi(ki, 'help'),
%         dialog('nohelp'); % Access "no help file" dialog
%         dialog('enterkey'); % Access "enter to continue" routine
%     else
%     end
% end



%% Output
if globalFit == 1,
    tmp = dialog('save');
    save = input(tmp, 's');
    if strcmpi(save,'q') || strcmpi(save,'*') || strcmpi(save,'quit'),
        dialog('quitter'); return;
    elseif strcmpi(save,'h') || strcmpi(save,'help'),
        dialog('nohelp'); dialog('enterkey');
    elseif strcmpi(save,'y') || strcmpi(save,'yes'),
        save = 0;
        tmp = dialog('xlsTxt');
        while save == 0,
            save = input(tmp,'s');
            if strcmpi(save,'q') || strcmpi(save,'*') || strcmpi(save,'quit'),
                dialog('quitter'); return;
            elseif strcmpi(save,'h') || strcmpi(save,'help'),
                dialog('nohelp'); dialog('enterkey');
            elseif strcmpi(save,'t') || strcmpi(save,'text'),
                save = 1;
            elseif strcmpi(save,'x') || strcmpi(save,'excel'),
                save = 2;
                tmp0 = dialog('saveExcel');
                saveLoc = input(tmp0,'s');
                if strcmpi(saveLoc,'q') || strcmpi(saveLoc,'*') || strcmpi(saveLoc,'quit'),
                    dialog('quitter'); return;
                elseif strcmpi(saveLoc,'h') || strcmpi(saveLoc,'help'),
                    dialog('nohelp'); dialog('enterkey');
                elseif strcmpi(saveLoc,'n') || strcmpi(saveLoc,'no'),
                    saveLoc = [];
                elseif strcmpi(saveLoc,'y') || strcmpi(saveLoc,'yes'),
                    saveLoc = {};
                    tmp0 = dialog('concLoc');
                    tmp1 = input(tmp0,'s');
                    saveLoc{1} = tmp1;
                    tmp0 = dialog('halLoc');
                    tmp1 = input(tmp0,'s');
                    saveLoc{2} = tmp1;
                    if sulf == 0,
                        tmp0 = dialog('sulfLoc');
                        tmp1 = input(tmp0,'s');
                        saveLoc{3} = tmp1;
                    end
                else
                    saveLoc = {'D8:D22';'E8:E22';'I8:I22'};
                end
            end
            if save ~= 0,
                tmp0 = dialog('saveName');
                saveFile = input(tmp0,'s');
                if isempty(saveFile) || strcmpi(saveFile,'d'),
                    saveFile = 'output';
                elseif strcmpi(saveFile,'s'),
                    saveFile = uigetfile;
                    saveFile = saveFile(1:end-5);
                end
            end
        end
    else
        save = 0;
    end
end



%% Reutershan Guess
% Initialization
tmp = dialog('rguess');
rguess = 0;
while rguess == 0,
    rguess = input(tmp, 's');
    if strcmpi(rguess, 'q') || strcmpi(rguess, 'quit'),
        dialog('quitter'); return;
    elseif strcmpi(rguess, 'h') || strcmpi(rguess, 'help'),
        dialog('nohelp'); % Access "no help file" dialog
        dialog('enterkey'); % Access "enter to continue" routine
    elseif strcmpi(rguess, 'y') || strcmpi(rguess, 'yes'),
        rguess = 1;
    elseif strcmpi(rguess, 'n') || strcmpi(rguess, 'no'),
        rguess = 2;
    else
        dialog('unkcmd'); % Access "uknown command" dialog
        dialog('enterkey'); % Access "enter to continue" routine
    end
end

% Perform Guess
k0 = zeros(klng,length(type));
if rguess == 1,
    for k = 1:length(type),
        ype = type(k);
        tmp = sprintf(['\nPerforming Reutershan Guess for Kinetic Trace ',num2str(ype)]);
        disp(tmp);
        dt = time(2) - time(1);
        epsilon = 0.85;
        A = zeros(3);
        [dataMax,dataMaxIndex] = max(data(:,type(k)));
        A(:,1) = [epsilon-0.02; epsilon; epsilon+0.02];
        A(:,2) = [-data(dataMaxIndex-1,ype); -dataMax; -data(dataMaxIndex+1,ype)];
        A(:,3) = -A(:,2).*A(:,2);
        y_p = 0.5*[dataMax - data(dataMaxIndex-2,ype); 0; data(dataMaxIndex+2,ype) - dataMax]/dt;
        coeff = A\y_p;
        syms x y;
        for i = 1:nodes,
            [c,d] = vpasolve([(coeff(2)*data(i) + coeff(3)*data(i)*data(i))/coeff(1) == exp(-x*dt) - exp(-y*dt), (coeff(2)*dataMax + coeff(3)*dataMax*dataMax)/coeff(1) == exp(-x*time(dataMaxIndex)) - exp(-y*time(dataMaxIndex))], [x,y]);
            c = double(c); d = double(d);
            if size(c,1) == 0,
                c = 0; d = 0;
            end
            if (c > 0) && (d > 0),
                break;
            elseif i == nodes,
                disp('No solution exists');
            end
        end
        ki = zeros(klng,1);
        ki(1:2) = [c d];
    
        ki = ki(1:2);
        dy = zeros(nodes-1,1);
        for i = 1:nodes-1,
            dy(i) = (data(i+1) - data(i))/dt;
        end
        ksolve = fminsearch(@(k) MatrixObj(time(1:end-1),data(1:end-1,ype),k,dy),ki,options);
        if any(ksolve < 0) || any(ksolve > 1e8)
            disp('Second step of guess failed. Using results from 1st step.');
            ksolve = ki;
        end
        k0(1:2,k) = ksolve;
        if order == 1,
            k0(3:4,k) = coeff(1:2);
        else
            k0(3:5,k) = coeff;
        end
        stateData = A*coeff;
        if globalFit == 0,
            figure('name',['Reutershan Guess for Kinetic Trace ', num2str(ype)]);
            scatter(time(1:end-1),dy,'k','o'); hold on;
            plot(time(1:end-1),stateData);
        end
        tmp = sprintf(['\nApproximate 1st Order Rate Constants:\n'...
            '\tHalogenic Atom = ',num2str(ksolve(1))...
            '\n\tSulfate Radical = ',num2str(ksolve(2))]);
        disp(tmp);
    end
elseif rguess == 2,
    tmp = dialog('initialguess');
    flag = 0;
    while flag == 0,
        ki = input(tmp, 's');
        if strcmpi(ki, 'q') || strcmpi(ki, 'quit'), % Quit program
            dialog('quitter'); return;
        elseif strcmpi(ki, 'h') || strcmpi(ki, 'help'),
            dialog('nohelp'); % Access "no help file" dialog
            dialog('enterkey'); % Access "enter to continue" routine
        else
            k0 = str2num(ki);
            if length(k0) == klng,
                flag = 1;
            else
                tmp0 = dialog('klength'); disp(tmp0);
                tmp0 = sprintf(['\tNumber of required constants: ', num2str(klng)]);
                disp(tmp0);
            end
        end
    end
end
k0 = abs(k0);



%% Wall Clock
walltime = toc;
tmp = sprintf(['\n\nTotal Wall Time = ' num2str(walltime) ' seconds']);
disp(tmp);
if walltime < 40,
    disp('Damn! You speedy, hun!');
elseif walltime > 100,
    disp('Hurry it up, slow poke!');
end



%% Perform Fit
tic;
sulfVec = ksulf*analyteConc + fudge;
if sulf == 1,
    k0(2,:) = [];
    klng = size(k0,1);
end
if globalFit == 0,
    for i = 1:length(type),
        ype = type(i);
        y0 = data(1,ype);
        tmp = sprintf(['\n\nMinimizing residuals for kinetic trace ', num2str(ype)]);
        disp(tmp);
        ksolve = fminsearch(@(k) HalogenicAtomObj(time,data(:,ype),k,y0,order,sulf,sulfVec(type(i))),k0(:,i),options);
        f = @(t,ex) HalogenicAtomODE(ksolve,t,ex,order,sulf,sulfVec(type(i)));
        [t,stateData] = ode23s(f,time,y0);
        flag = 1;
        if flag == 1,
            figure('name',['Fitting Result for Kinetic Trace ', num2str(ype)]);
            scatter(time,data(:,ype),'k','o'); hold on;
            plot(time,stateData,'r');
        end
    end
else
    tmp = sprintf('\n\nPerforming global data fit. Patience, young Padawan.');
    disp(tmp);
    ksolve = zeros(lngdata,klng);
    for i = 1:lngdata,
        if i == lngdata,
            disp('Final Interation!');
        else
            disp(['Iteration ' num2str(i) ' of ' num2str(lngdata)]);
        end
        y0 = data(1,i);
        ksolve(i,:) = fminsearch(@(k) HalogenicAtomObj(time,data(:,i),k,y0,order,sulf,sulfVec(i)),k0,options);
        k0 = ksolve(i,:);
    end
end



%% Do Least Squares Line
if globalFit == 1,
    if size(analyteConc,1) ~= 1,
        f = fittype({'x','1'});
        [atomFitResult,gofAtom,atomFitInfo] = fit(analyteConc,ksolve(:,1),f);
        figure('name','Least Squares Fit - Halogenic Atom');
        plot(atomFitResult,analyteConc,ksolve(:,1));
        tmp = sprintf('\n\n\nHalogenic Atom Fit Results:');
        disp(tmp); disp(atomFitResult); disp(gofAtom); disp(atomFitInfo);
        if sulf == 0,
            [sulfFitResult,gofSulf,sulfFitInfo] = fit(analyteConc,ksolve(:,2),f);
            figure('name','Least Squares Fit - Sulfate Radical'); plot(sulfFitResult,analyteConc,ksolve(:,2));
            tmp = sprintf('\n\nSulfate Radical Fit Results:');
            disp(tmp); disp(sulfFitResult); disp(gofAtom); disp(atomFitInfo);
        end
    %%%%%%%%%%%%%%%% Need to do else statement %%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    end
end



%% Save Data
if save ~= 0,
    [m,n] = size(ksolve);
    tmp = zeros(m,n+1);
    tmp(:,1) = analyteConc; tmp(:,2:end) = ksolve;
end
if save == 1,
    saveFile = [saveFile,'.dat'];
    dlmwrite(saveFile,tmp,'\t');
elseif save == 2,
    saveFile = [saveFile,'.xlsx'];
    if isempty(saveLoc),
        xlswrite(saveFile,tmp);
    else
        xlswrite(saveFile,analyteConc,dataSheet,saveLoc{1});
        xlswrite(saveFile,ksolve(:,1),dataSheet,saveLoc{2});
        if sulf == 0,
            xlswrite(saveFile,ksolve(:,2),dataSheet,saveLoc{3});
        end
    end
end



%% CPU Clock
cputime = toc;
tmp = sprintf(['\n\nTotal CPU Time = ' num2str(cputime) ' seconds\n\n']);
disp(tmp);

