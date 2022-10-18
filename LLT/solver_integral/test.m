for i = 0:0.1:5
solver_total(@model_2,[5 i 50],[0 0 300 280 0 0],[0 100],1, 0 , [0 90]);
end