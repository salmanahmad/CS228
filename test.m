%git test

energies = zeros(8)

weight = 0.3

energies

for i=1:size(energies,1)
      for j=1:size(energies,2)
        if(i ~= j)
            energies(i,j) = weight;
        else
            energies = 0;
        end
      end
end
  
energies
