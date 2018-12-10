my_default_email_address = 'nicolas.oyharcabal@gmail.com';%mail
my_username = 'nicolas.oyharcabal@gmail.com';% mail
my_password = 'Rsdfg35667';%mail password
%https://myaccount.google.com/lesssecureapps?pli=1
setpref('Internet','SMTP_Server','smtp.gmail.com');
setpref('Internet','E_mail',my_default_email_address);
setpref('Internet','SMTP_Username',my_default_email_address );
setpref('Internet','SMTP_Password',my_password);
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty( 'mail.smtp.starttls.enable', 'true' )
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');

%title of mail
titulo = 'Práctica';

%menssage of mail
a=('Soy alumno de último año de ingeniería Civil Mecánica de la Universidad de Chile y me gustaría hacer la practica en su empresa. Dejo el certificado de seguro escolar y mi curriculum vitae adjuntos.');

%documents adjunted
b=['CVySE.pdf'];

props.setProperty('mail.smtp.auth','true');

%read database to generate an array called 'txt'
[num,txt]=xlsread('bawe_datos_prac.xlsx','I2:I24')
%here you evidently put the name of your database (in .xlsx) where
% 'I2: I24' is the column where in each of its cells is
% the mail of someone
for i=1:length(txt)
    if length(cell2mat(strfind(txt(i),'@')))~=0
        sendmail(txt(i) , titulo, a ,b);
    end
end
    

   

