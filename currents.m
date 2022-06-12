classdef currents < handle
    %Class containing calls for current functions
    properties
        fis
        x_ucz
        y_ucz
        params
    end

    methods
        function setcurrentfis(obj,val)
            obj.fis = val;
        end

        function res = getcurrentFis(obj)
            res = obj.fis;
        end

        function setcurrent_x_ucz(obj,val)
            obj.x_ucz = val;
        end

        function res = getcurrent_x_ucz(obj)
            res = obj.x_ucz;
        end

          function setcurrent_y_ucz(obj,val)
            obj.y_ucz = val;
        end

        function res = getcurrent_y_ucz(obj)
            res = obj.y_ucz;
        end

        function setcurrentParams(obj,val)
            obj.params = val;
        end

        function res = getcurrentParams(obj)
            res = obj.params;
        end

    end
end

