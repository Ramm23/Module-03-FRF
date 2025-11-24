function coherence = getMeanCoherenec(C, freqIndexes)
    mu = mean(C(freqIndexes));
    sigma = std(C(freqIndexes));
    coherence = [mu sigma];
end