classdef  ModelTab < BasicTab
    
    properties
        Model;
        
        pnlDataSettings;
        pnlCrossValidationSettings;
        pnlModelSettings
        pnlPlotSettings;
        
        ddlModelType;
        tbNumPC;
        tbAlpha;
        tbGamma;
        
        chkFinalizeModel;
        
        ddlCalibrationSet;
        ddlValidationSet;
        
        chkCrossValidation;
        ddlCrossValidationType;
        
        ddlPlotVar1;
        ddlPlotVar2;
        chkPlotShowClasses;
        chkPlotShowObjectNames;
    end
    
    methods
        
        function ttab = ModelTab(tabgroup)
            
            ttab = ttab@BasicTab(tabgroup, 'Model');
            
            ttab.pnlDataSettings = uipanel('Parent', ttab.left_panel, 'Title', 'Data','Units', 'normalized', ...
                'Position', [0.05   0.85   0.9  0.14]);
            
            ttab.pnlCrossValidationSettings = uipanel('Parent', ttab.left_panel, 'Title', 'CrossValidation','Units', 'normalized', ...
                'Position', [0.05   0.71   0.9  0.14]);
            
            ttab.pnlModelSettings = uipanel('Parent', ttab.left_panel, 'Title', 'Model','Units', 'normalized', ...
                'Position', [0.05   0.29   0.9  0.42]);
            
            ttab.pnlPlotSettings = uipanel('Parent', ttab.left_panel, 'Title', 'Plot','Units', 'normalized', ...
                'Position', [0.05   0.01   0.9  0.28]);
            
            uicontrol('Parent', ttab.pnlDataSettings, 'Style', 'text', 'String', 'Calibration', ...
                'Units', 'normalized','Position', [0.05 0.65 0.35 0.2], 'HorizontalAlignment', 'left');
            ttab.ddlCalibrationSet = uicontrol('Parent', ttab.pnlDataSettings, 'Style', 'popupmenu', 'String', {'-'},...
                'Units', 'normalized','Value',1, 'Position', [0.4 0.67 0.55 0.2], 'BackgroundColor', 'white', 'callback', @ModelTab.SelectCalibratinSet);
            
            uicontrol('Parent', ttab.pnlDataSettings, 'Style', 'text', 'String', 'Validation', ...
                'Units', 'normalized','Position', [0.05 0.25 0.35 0.2], 'HorizontalAlignment', 'left');
            ttab.ddlValidationSet = uicontrol('Parent', ttab.pnlDataSettings, 'Style', 'popupmenu', 'String', {'-'},...
                'Units', 'normalized','Value',1, 'Position', [0.4 0.27 0.55 0.2], 'BackgroundColor', 'white', 'callback', @ModelTab.SelectValidationSet);
            
            
            
            %CrossValidation
            ttab.chkCrossValidation = uicontrol('Parent', ttab.pnlCrossValidationSettings, 'Style', 'checkbox', 'String', 'Use cross-validation',...
                'Units', 'normalized','Position', [0.05 0.7 0.85 0.2], 'callback', @ModelTab.Callback_UseCrossValidation);
            uicontrol('Parent', ttab.pnlCrossValidationSettings, 'Style', 'text', 'String', 'Cross-validation type', ...
                'Units', 'normalized','Position', [0.05 0.3 0.85 0.2], 'HorizontalAlignment', 'left');
            ttab.ddlCrossValidationType = uicontrol('Parent', ttab.pnlCrossValidationSettings, 'Style', 'popupmenu', 'String', {'Leave-one-Out', 'K-fold', 'Holdout', 'Monte Carlo'},...
                'Units', 'normalized','Value',2, 'Position', [0.47 0.325 0.45 0.2], 'BackgroundColor', 'white', 'callback', @ModelTab.Callback_CrossValidationType);
            
            %lblModelType
            uicontrol('Parent', ttab.pnlModelSettings, 'Style', 'text', 'String', 'Type of model', ...
                'Units', 'normalized','Position', [0.05 0.85 0.85 0.1], 'HorizontalAlignment', 'left');
            ttab.ddlModelType = uicontrol('Parent', ttab.pnlModelSettings, 'Style', 'popupmenu', 'String', {'hard pls-da','soft pls-da'},...
                'Units', 'normalized','Value',2, 'Position', [0.45 0.87 0.45 0.1], 'BackgroundColor', 'white', 'callback', @ModelTab.Input_ModelParameters);
            
            %model params
            %PLS PCs
            uicontrol('Parent', ttab.pnlModelSettings, 'Style', 'text', 'String', 'Number of PLS PCs', ...
                'Units', 'normalized','Position', [0.05 0.7 0.85 0.1], 'HorizontalAlignment', 'left');
            ttab.tbNumPC = uicontrol('Parent', ttab.pnlModelSettings, 'Style', 'edit', 'String', '12',...
                'Units', 'normalized','Value',1, 'Position', [0.65 0.7 0.25 0.1], 'BackgroundColor', 'white', 'callback', @ModelTab.Input_NumPC);
            
            %PCA PCs
            uicontrol('Parent', ttab.pnlModelSettings, 'Style', 'text', 'String', 'Number of PCA PCs', ...
                'Units', 'normalized','Position', [0.05 0.55 0.85 0.1], 'HorizontalAlignment', 'left');
            ttab.tbNumPC = uicontrol('Parent', ttab.pnlModelSettings, 'Style', 'edit', 'String', '2',...
                'Units', 'normalized','Value',1, 'Position', [0.65 0.55 0.25 0.1], 'BackgroundColor', 'white', 'callback', @ModelTab.Input_NumPC);
            
            %lblAlpha
            uicontrol('Parent', ttab.pnlModelSettings, 'Style', 'text', 'String', 'Type I error (alpha)', ...
                'Units', 'normalized','Position', [0.05 0.4 0.85 0.1], 'HorizontalAlignment', 'left');
            ttab.tbAlpha = uicontrol('Parent', ttab.pnlModelSettings, 'Style', 'edit', 'String', '0.01',...
                'Units', 'normalized','Value',1, 'Position', [0.65 0.4 0.25 0.1], 'BackgroundColor', 'white', 'callback', @ModelTab.Input_Alpha);
            
            %lblGamma
            uicontrol('Parent', ttab.pnlModelSettings, 'Style', 'text', 'String', 'Outlier significance (gamma)', ...
                'Units', 'normalized','Position', [0.05 0.25 0.6 0.1], 'HorizontalAlignment', 'left');
            ttab.tbGamma = uicontrol('Parent', ttab.pnlModelSettings, 'Style', 'edit', 'String', '0.01',...
                'Units', 'normalized','Value',1, 'Position', [0.65 0.25 0.25 0.1], 'BackgroundColor', 'white', 'callback', @ModelTab.Input_Gamma);
            
            ttab.chkFinalizeModel = uicontrol('Parent', ttab.pnlModelSettings, 'Style', 'checkbox', 'String', 'Finalized',...
                'Units', 'normalized','Position', [0.05 0.17 0.45 0.1], 'callback', @ModelTab.Finalize);
            
            uicontrol('Parent', ttab.pnlModelSettings, 'Style', 'pushbutton', 'String', 'Recalibrate',...
                'Units', 'Normalized', 'Position', [0.05 0.05 0.4 0.12], ...
                'callback', @ModelTab.Recalibrate);
            uicontrol('Parent', ttab.pnlModelSettings, 'Style', 'pushbutton', 'String', 'Save Model',...
                'Units', 'Normalized', 'Position', [0.51 0.05 0.4 0.12], ...
                'callback', @ModelTab.SaveModel);
            
            uicontrol('Parent', ttab.pnlPlotSettings, 'Style', 'pushbutton', 'String', 'Save',...
                'Units', 'Normalized', 'Position', [0.05 0.1 0.4 0.18], ...
                'callback', @ModelTab.SavePlot);
            uicontrol('Parent', ttab.pnlPlotSettings, 'Style', 'pushbutton', 'String', 'Copy to clipboard',...
                'Units', 'Normalized', 'Position', [0.51 0.1 0.4 0.18], ...
                'callback', @ModelTab.CopyPlotToClipboard);
            
            ttab.chkPlotShowClasses = uicontrol('Parent', ttab.pnlPlotSettings, 'Style', 'checkbox', 'String', 'Show classes',...
                'Units', 'normalized','Position', [0.05 0.85 0.85 0.1]);%, 'callback', @DataTab.Redraw);
            ttab.chkPlotShowObjectNames = uicontrol('Parent', ttab.pnlPlotSettings, 'Style', 'checkbox', 'String', 'Show object names',...
                'Units', 'normalized','Position', [0.05 0.75 0.85 0.1]);%, 'callback', @DataTab.Redraw);
            
            uicontrol('Parent', ttab.pnlPlotSettings, 'Style', 'text', 'String', 'PC 1', ...
                'Units', 'normalized','Position', [0.05 0.58 0.35 0.1], 'HorizontalAlignment', 'left');
            ttab.ddlPlotVar1 = uicontrol('Parent', ttab.pnlPlotSettings, 'Style', 'popupmenu', 'String', {'1'},...
                'Units', 'normalized','Value',1, 'Position', [0.45 0.6 0.35 0.1], 'BackgroundColor', 'white');%, 'callback', @DataTab.Redraw);
            
            uicontrol('Parent', ttab.pnlPlotSettings, 'Style', 'text', 'String', 'PC 2', ...
                'Units', 'normalized','Position', [0.05 0.38 0.35 0.1], 'HorizontalAlignment', 'left');
            ttab.ddlPlotVar2 = uicontrol('Parent', ttab.pnlPlotSettings, 'Style', 'popupmenu', 'String', {'2'},...
                'Units', 'normalized','Value',1, 'Position', [0.45 0.4 0.35 0.1], 'BackgroundColor', 'white');%, 'callback', @DataTab.Redraw);
            
            
            
            allvars = evalin('base','whos');

            idx = arrayfun(@(x)ModelTab.filter_training(x), allvars);
            vardisplay={};
            if sum(idx) > 0
                    l = allvars(idx);
                    vardisplay{1} = '-';
                    for i = 1:length(l)
                        vardisplay{i+1} = l(i).name;
                    end
                    set(ttab.ddlCalibrationSet, 'String', vardisplay);
                    if length(get(ttab.ddlCalibrationSet, 'String')) > 1
                        set(ttab.ddlCalibrationSet, 'Value', 2)
                    end
            end
            
            idx = arrayfun(@(x)ModelTab.filter_validation(x), allvars);
            vardisplay={};
            if sum(idx) > 0
                    l = allvars(idx);
                    vardisplay{1} = '-';
                    for i = 1:length(l)
                        vardisplay{i+1} = l(i).name;
                    end
                    set(ttab.ddlValidationSet, 'String', vardisplay);
                    if length(get(ttab.ddlValidationSet, 'String')) > 1
                        set(ttab.ddlValidationSet, 'Value', 2)
                        set(ttab.ddlValidationSet, 'enable', 'on');
                    else
                        set(ttab.ddlValidationSet, 'enable', 'off');
                    end
            end
                       
        end
        
    end
    
    methods (Static)
        
        function r = filter_training(x)
            d = evalin('base', x.name);
            if isequal(x.class,'DataSet') && d.Training
                r = true;
            else
                r = false;
            end
        end
        
        function r = filter_validation(x)
            d = evalin('base', x.name);
            if isequal(x.class,'DataSet') && d.Validation
                r = true;
            else
                r = false;
            end
        end
        
        function Recalibrate(src, ~)
            
        end
        
        function SaveModel(src, ~)
            
        end
        
        function SavePlot(src, ~)
            
        end
        
        function CopyPlotToClipboard(src, ~)
            
        end
        
        function Finalize(src, ~)
            
        end
        
        function Input_Gamma(src, ~)
            
        end
        
        function Callback_CrossValidationType(src, ~)
            
        end
        
        function Callback_UseCrossValidation(src, ~)
            
        end
        
        function SelectValidationSet(src, ~)
            
        end
        
        function SelectCalibratinSet(src, ~)
            
        end
        
        function Input_ModelParameters(src, ~)
            val = get(src,'Value');
            if ~isempty(val) && ~isnan(val)
                
            end
        end
        
        function CheckPC()
            
            %TBD
        end
        
        function Input_NumPC(src, ~)
            str=get(src,'String');
            %TBD
        end
        
        function Input_Alpha(src, ~)
            str=get(src,'String');
            val = str2double(str);
            if isempty(val) || isnan(val)
                set(src,'string','0.01');
                warndlg('Input must be numerical');
            else
                if val <= 0 || val >= 1
                    set(src,'string','0.01');
                    warndlg('Type I error (Alpha) should be greater than 0 and less than 1!');
                else
                    %TBD
                end
            end
        end
        
    end
    
end