FROM haskell:8

# install required packages
RUN cabal update \
    && cabal install --lib MissingH split lens

WORKDIR /home

COPY data/day8.txt data/
COPY src/day8.hs src/

CMD ["runghc", "src/day8.hs"]
