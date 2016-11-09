function [tmp] = dialog(mainFlag)


% Intro dialog
if strcmp(mainFlag, 'intro'),
    
    tmp = sprintf(['\n\n\n'...
    '################################################################\n'...
    '#                                                              #\n'...
    '# Välkommen!                                                   #\n'...
    '#                                                              #\n'...
    '#     Title: Halogenic Atom System Optimization                #\n'...
    '#     Author: Trevor (Cocomos) Reutershan                      #\n'...
    '#     Institution: California State University, Long Beach     #\n'...
    '#                  Department of Chemistry and Biochemistry    #\n'...
    '#     Group: Rad-KEM Lab                                       #\n'...
    '#     Contact Info: treutershan@gmail.com                      #\n'...
    '#     First Release Date: 25th of December 2015                #\n'...
    '#     Version: 0.5.1                                           #\n'...
    '#     Version Release Date: 8th of November 2016               #\n'...
    '#                                                              #\n'...
    '#              Please see README for terms of use.             #\n'...
    '#                                                              #\n'...
    '################################################################\n'...
    '\n\n\n']);
    disp(tmp);    

    
% Quit dialog
elseif strcmp(mainFlag, 'quitter'),
    
    tmp = sprintf(['\n\nYou chose to quit the program prematurely.\n\n'...
        'Quitter...\n\n\n']);
    disp(tmp);
    
    
% Ask data dialog
elseif strcmp(mainFlag, 'dataAsk'),
    
    tmp = sprintf([
    'Please enter the file name that contains your data.\n'...
    'Current files supported: .xls, .xlsx\n'...
    '                         (.txt comming in a later version)\n\n'...
    '     s:  Select file interactively\n     h:  Help\n'...
    '     q:  Quit\n\n']);
    

% Press enter key routine
elseif strcmp(mainFlag, 'enterkey'),
    
    flag = 0; count = 0;
    while flag == 0,
        
        if count < 1,
            disp('Press enter to continue.');
        elseif count >= 1 && count <= 3,
            disp('Press the ''Enter'' key to continue.');
        elseif count == 4 || count == 5,
            disp('Hello, do you speak English? Press enter.');
        elseif count == 6 || count == 7,
            disp('That''s the same as the ''Return'' key, in case you didn''t know...');
        elseif count == 8,
            disp('PRESS!');
        elseif count == 9,
            disp('FUCKING!!');
        elseif count == 10,
            disp('ENTER!!!');
        elseif count == 11,
            disp('Oh my fucking god! Do you know how to follow directions?');
        elseif count == 12,
            tmp = sprintf('That''s it. I''m closing the program. You have to start all over now.\n\n\n');
            disp(tmp); pause(3);
            error('Program closed because you are too much of a prick to follow directions.');
        end
        tmp = getkey;
        if tmp == 13 && count < 4,
            flag = 1;
        elseif tmp == 13 && (count == 4 || count == 5),
            disp('Looks like you can speak English, or did you use an interpreter?');
            flag = 1;
        elseif tmp == 13 && (count == 6 || count == 7),
            disp('Hey! You finally found the right key!');
            flag = 1;
        elseif tmp == 13 && count > 7,
            disp('Thank you for finally following directions, jerk.');
            flag = 1;
        end
        count = count + 1;
        
    end % While End

    
% Data doesn't exist dialog
elseif strcmp(mainFlag, 'dataDNE'),
    
    tmp = sprintf(['!! Specified data file does not exist!!\n'...
        'It is recommended that you check the following things:\n\n'...
        '     - Check your spelling, silly!\n'...
        '     - Make sure there are no spaces in your file name.\n'...
        '     - Make sure the file you have chosen is in the Matlab file path.\n'...
        '       If you don''t know what that is, just make sure it is in the same folder as this code.\n'...
        '     - Extension must be given with file name (e.g. ''filename''.xlsx\n'...
        '       (Matlab is weird like that)\n\n']);
    disp(tmp);

    
% No help file dialog
elseif strcmp(mainFlag, 'nohelp'),
    
    tmp = sprintf(['\n\nHelp file coming soon...\n'...
            'Looks like you are on your own for this one!\n'...
            'Just ask Cocomos (AKA Trevor)...\n']);
    disp(tmp);
    
    
% Not yet supported
elseif strcmp(mainFlag, 'notsupported'),
    
    tmp = sprintf(['\n\nThat file type is not supported.\n'...
        'Please enter your data in an Excel file.\n'...
        'If you do not have an Excel file prepared, it is recommended that you exit now to make one.\n\n\n']);
    disp(tmp);
    
    
% Excel sheet dialog
elseif strcmp(mainFlag, 'xcelSheet'),
    
    tmp = sprintf(['Please enter the name of the sheet to read from in the Excel file.\n'...
        'Or type "q" to quit.\n\n']);
    
    
% Excel sheet fail
elseif strcmp(mainFlag, 'sheetFail'),
    
    tmp = sprintf(['\n\nDictated sheet is not found in specified Excel data file!\n'...
        'It is recommended you check your spelling, goofus.\n']);
    disp(tmp);
    
    
% Excel file dialog
elseif strcmp(mainFlag, 'xcelLoc'),
    
    tmp = sprintf(['\n\nHow would you like the file to be read?\n\n'...
        '     a:  Automatically (Make sure to use Cocomos'' template)\n'...
        '    mx:  Manually enter data read in Excel language\n'...
        '    mi:  Manually enter data read interactively with prompt\n'...
        '    md:  Manually enter each point of data interactively (Not recommended!)\n'...
        '     h:  Help\n     q:  Quit\n\n']);
    
    
% Function not supported
elseif strcmp(mainFlag, 'notsupportedf'),
    
    tmp = sprintf(['\n\nFunction is currently not supported...\n'...
        'Lo Siento! Use automatic read for now.']);
    disp(tmp);
    
    
% Unknown command
elseif strcmp(mainFlag, 'unkcmd'),
    
    tmp = sprintf('\n\nUnknown command! Check your spelling, Dorkus Preston!\n\n');
    disp(tmp);
    

% Ask for order for fitting
elseif strcmp(mainFlag, 'order'),
    
    tmp = sprintf(['\n\nPlease enter the order for the differential equation.\n\n'...
        '     1:  First order approximation (Most used)\n'...
        '     2:  Full 2nd order nonliear ordinary differential equation\n'...
        '     h:  Help\n'...
        '     q:  Quit\n\n']);
    
    
% Error entering order
elseif strcmp(mainFlag, 'errorder'),
    
    tmp = sprintf('\n\nThere are only two choices for the order, please enter 1 or 2.');
    disp(tmp);
    
    
% Select fitting type
elseif strcmp(mainFlag, 'type'),
    
    tmp = sprintf(['\n\nWould you like to fit datasets individually, or globally?\n'...
        '     i:  Enter individual datasets to fit\n'...
        '   all:  Fit all datasets globally to find chlorine atom rate constant.\n\n']);
        

elseif strcmp(mainFlag, 'columns'),
    
    tmp = sprintf(['\nEnter the columns of the dataset you would like to analyze.\n'...
        'Separate each entry with a space. Use only numbers.\n'...
        'You are limited by the number of kinetic traces in your dataset.\n\n']);
    
    
elseif strcmp(mainFlag, 'rguessq'),
    
    tmp = sprintf(['\n\nNow it is time for the initial guess.\n'...
        'You may enter a vector of numbers below (be sure to follow a specified order),\n'...
        'enter them interactively, or perform a Reutershan Guess (recommended).\n'...
        '     r:  Reutershan Guess\n'...
        '     i:  Enter values interactively with prompts\n'...
        '     h:  Help (What is a Reutershan Guess?)'...
        '     q:  Quit\n\n']);
    
    
elseif strcmp(mainFlag, 'rguesst'),
    tmp = sprintf('\n\nReutershan Guess completed. Would you like to keep results?\n');
    
    
elseif strcmp(mainFlag, 'rguess'),
    
    tmp = sprintf(['\n\nWould you like to perform a Reutershan Guess?\n'...
        '     y:  Yes\n     n:  No\n'...
        '     h:  Help (What is a Reutershan Guess?)\n     q:  Quit\n\n']);
    
    
elseif strcmp(mainFlag, 'initialguess'),
    
    tmp = sprintf(['\n\nAs you do not wish to have the program magically'...
        ' perform the initial guess for you, you must enter the values yourself.'...
        '\nSeparate the initial values with a space.\n'...
        '     h:  Help (Formatting of constants)\n     q:  Quit\n\n']);
    
    
elseif strcmp(mainFlag, 'klength'),
    
    tmp = sprintf(['\n\nThe number of constants does not match the number'...
        ' required for your system.']);
    
    
elseif strcmp(mainFlag, 'datalength'),
    
    tmp = sprintf(['\n\nThe number of kinetic traces you wish to '...
        'analyze exceeds the length of your dataset.']);
    
    
elseif strcmp(mainFlag, 'toobig'),
    
    tmp = sprintf('\n\nYou specified a value that is larger than the length of your dataset.');
    
    
elseif strcmp(mainFlag, 'nozero'),
    
    tmp = sprintf('\n\nYou cannot have a zeroth column, dummy.');
    
    
elseif strcmp(mainFlag, 'sulf'),
    
    tmp = sprintf(['\n\nWould you like to fix the first order rate constant corresponding to the sulfate radical?\n'...
        '     y:  Yes\n     n:  No (Default)\n     h:  Help\n     q:  Quit\n\n']);
    
    
elseif strcmp(mainFlag, 'enterSulf'),
    
    tmp = sprintf('\n\nThen please enter your known second order rate constant.\n\n');
    
    
elseif strcmp(mainFlag, 'enterFudge'),
    
    tmp = sprintf(['\n\nEnter the offset for the sulfate radical.\n'...
        'Suggested fudge from experimental history: 2E7\n\n']);
    
    
elseif strcmp(mainFlag, 'save'),
    
    tmp = sprintf(['\n\nWould you like to save your data?\n'...
        '     y:  Yes\n     n:  No (Default)\n     h:  Help\n     q:  Quit\n\n']);
    
    
elseif strcmp(mainFlag, 'xlsTxt'),
    
    tmp = sprintf(['\n\nIndicate whether you want to save the data to an Excel file or a Text file.\n'...
        '     t:  Text (.dat)\n     x:  Excel(.xlsx)\n     h:  Help\n     q:  Quit\n\n']);
    
    
elseif strcmp(mainFlag, 'saveName'),
    
    tmp = sprintf(['\n\nEnter name of the output file. Or choose an option below.\n'...
        '     d:  Default Name - "output"\n'...
        '     s:  Select file interactively\n']);
    
    
elseif strcmp(mainFlag, 'saveExcel'),
    
    tmp = sprintf(['\n\nYou indicated that you want to save to an Excel file.\n'...
        'Would you like to specify the output locations?\n'...
        '     a:  Automatic (Default - Make sure to use Cocomos'' template)\n'...
        '     y:  Enter output locations using Excel language\n'...
        '     n:  Compact print to first cells in file\n'...
        '     h:  Help\n     q:  Quit\n\n']);
    
    
elseif strcmp(mainFlag, 'concLoc'),
    
    tmp = sprintf('\n\nEnter Excel vector for analyte concentrations.\n\n');
    
    
elseif strcmp(mainFlag, 'halLoc'),
    
    tmp = sprintf('\n\nOkay, now enter Excel vector for pseudo 1st order halogenic atom results.\n\n');
    
    
elseif strcmp(mainFlag, 'sulfLoc'),
    
    tmp = sprintf('\n\nFinally, enter Excel vector for pseudo 1st order sulfate radical results.\n\n');
    
    
end % Main End

