classdef LDECOMP < handle
    %LDECOMP class
    
    properties
        Scores;% - ������� (nObj x nComp) �� �������
        Loadings;% - ������� (nVar x nComp) � ����������
        Q;% - ������� (nObj x nComp) c Q residuals
        T2;% - ������� (nObj x nComp) c T2 residuals
        ExpVar;% - ������ (1 x nComp) c explained variance
        Eigenvalues%; - ������ (1 x nComp) c eigenvalues
    end
    
    methods
        
        function obj = LDECOMP(X)% - ���������� ������ �� ������� (scatter, bar, line)
            
        end
        
        function plotScores(self)% - ���������� ������ �� ������� (scatter, bar, line)
        end
        
        function plotExpvar(self)% - ���������� ������ �� explained variance (bar, line)
        end
        
        function plotCumExpvar(self)% - ���������� ������ �� cumulative explained variance (bar, line)
        end
        
        function plotResiduals(self)% - ���������� ������ c Q vs T2 residuals
        end
        
        function summary(self)% - ���������� ��������� ���������� �� �����������
        end
    end
    
end
