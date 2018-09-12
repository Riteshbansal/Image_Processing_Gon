function stream_rc6=rc6_stream(init_vect,length)

% init_vect=[1 23 255 65 67 0 32 5 1 23 255 65 67 0 32 5];

% key_exp
L='de37a1fd8492d8efe714f1b7cc783aad'; %key
S=rc6_key_expansion(L);

% stream generation
init_vect1=init_vect;
stream=zeros(1,length);

for j=1:16:length
    init_block=init_vect1;
    output_encr=rc6_encr(init_block,S);  
    stream(1,j:j+15)=output_encr;
    init_vect1=output_encr;
end

stream_rc6=stream;