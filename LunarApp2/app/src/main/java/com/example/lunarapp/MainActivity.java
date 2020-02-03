package com.example.lunarapp;

import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.StrictMode;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.Toast;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelExec;
import com.jcraft.jsch.ChannelShell;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PipedInputStream;
import java.io.PipedOutputStream;
import java.io.PrintStream;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

public class MainActivity extends AppCompatActivity {


    public Channel imu1Shell;
    public Channel imu2Shell;
    public Channel imu3Shell;
    public Channel imuMergerShell;
    public Channel lmsShell;
    public Channel pwmToPinShell;
    public Channel pwmRepeateShell;
    public Channel pwmReaderShell;

    public static PrintStream pwmPrinStream = null;
    //SSh envoirement, never Close
    public final JSch jsch = new JSch();


    //Dummy vairable so they can be later accessed
    private CheckBox cbTested = null;
    private CheckBox cbConnected = null;

    public TextView tTime = null;

    //Main Session Later
    Session session = null;

    Session sessionSudo = null;


    @Override
    protected void onCreate(Bundle savedInstanceState) {

        //standard android content view
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        tTime = findViewById(R.id.tTime);

        final CheckBox cbConnected = findViewById(R.id.cbConnected);
        final CheckBox cbTesed = findViewById(R.id.cbTested);
        this.cbConnected = cbConnected;
        this.cbTested = cbTesed;


        final Switch swIMU = findViewById(R.id.switchIMU);
        final Switch swIMUMerger = findViewById(R.id.switchImuMerger);
        final Switch swLMS = findViewById(R.id.switchLMS);
        final Switch swPWM = findViewById(R.id.switchPWM);


        final CheckBox cbIMU1 = findViewById(R.id.cBImu1);
        final CheckBox cbIMU2 = findViewById(R.id.cBImu2);
        final CheckBox cbIMU3 = findViewById(R.id.cBImu3);
        final CheckBox cbIMUMerger = findViewById(R.id.cBImuMerger);
        final CheckBox cbLMS = findViewById(R.id.cBLMS);
        final CheckBox cbPWM1 = findViewById(R.id.cBPWM1);
        final CheckBox cbPWM2 = findViewById(R.id.cBPWM2);
        final CheckBox cbPWM3 = findViewById(R.id.cBPWM3);


        //Only visible after pwm channels started
        final EditText ePWMToSend = findViewById(R.id.eTPWMToSend);
        final Button bSendPWM = findViewById(R.id.bSendPWM);

        final Button bOptionsPWM = findViewById(R.id.bOptionsPWM);
        bOptionsPWM.setActivated(false);

        final EditText eUser = findViewById(R.id.etUser);
        final EditText eHost = findViewById(R.id.etHost);
        final EditText ePassword = findViewById(R.id.eTpassword);

        final Button bStartSSH = findViewById(R.id.bOpenSession);
        final Button bTestSSH = findViewById(R.id.bTestSSH);
        final Button bStopSSH = findViewById(R.id.bCloseSession);
        final Button bKillAll = findViewById(R.id.bKillAll);
        final Button bShowNodes = findViewById(R.id.bShowNodes);


        //strict mode disable
        if (android.os.Build.VERSION.SDK_INT > 9) {
            StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
            StrictMode.setThreadPolicy(policy);
        }


        // Start session with the user Input
        bStartSSH.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                {
                    //test if User has given Input
                    if (eUser.getText().toString().equals("") || eHost.getText().toString().equals("") || ePassword.getText().toString().equals("")) {
                        toastIt("please enter User Host Password", false);
                        return;
                    }


                    String output = (eUser.getText().toString() + "@" + eHost.getText().toString() + "\n");

                    // Open Session with User Data
                    if (openSession(eUser.getText().toString(), eHost.getText().toString(), ePassword.getText().toString())) {

                        output += eUser.getText().toString() + " : success\n";
                    } else {

                        output += eUser.getText().toString() + " : failure";
                    }
                    output += "\n";

                    if (openSudoSession("root", eHost.getText().toString(), ePassword.getText().toString())) {

                        output += "root " + " : success\n";

                    } else {
                        output += "root" + " : failure";
                        sessionSudo = null;

                    }
                    toastIt(output, true);


                }
            }
        });


        //Test the SSh Connection when Button is clicked
        bTestSSH.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (testCommand()) {


                    cbTesed.setChecked(true);
                    toastIt("Test Successfull", false);

                } else {

                    cbTesed.setChecked(false);

                    // toast of failure will be send from method
                }
            }
        });

        //CLose ssh connection when button is clicked
        bStopSSH.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                cbConnected.setChecked(false);
                cbTesed.setChecked(false);

                closeSessionSudo();
                if (closeSession()) {


                    toastIt("Session closed sucessfully", false);
                } else {
                    toastIt("Session closing failed", false);


                }


            }
        });


        //start/stop imu shells when switch is activated
        swIMU.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                if (!isSessionReady()) {
                    return;
                }

                //activating the sessions
                if (swIMU.isChecked()) {

                    imu1Shell = sendSingleCommandAndGetChannel("cd catkin_ws/launch; roslaunch imu1.launch", session);
                    if (imu1Shell != null && imu1Shell.isConnected()) cbIMU1.setChecked(true);
                    imu2Shell = sendSingleCommandAndGetChannel("cd catkin_ws/launch; roslaunch imu2.launch", session);
                    if (imu2Shell != null && imu2Shell.isConnected()) cbIMU2.setChecked(true);
                    imu3Shell = sendSingleCommandAndGetChannel("cd catkin_ws/launch; roslaunch imu3.launch", session);
                    if (imu3Shell != null && imu3Shell.isConnected()) cbIMU3.setChecked(true);


                }
                //disconnecting channels
                else {

                    if (imu1Shell != null) imu1Shell.disconnect();
                    imu1Shell = null;
                    cbIMU1.setChecked(false);
                    if (imu2Shell != null) imu2Shell.disconnect();
                    imu2Shell = null;
                    cbIMU2.setChecked(false);
                    if (imu3Shell != null) imu3Shell.disconnect();
                    imu3Shell = null;
                    cbIMU3.setChecked(false);


                }


            }
        });


        //switch of imu merger
        swIMUMerger.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (!isSessionReady()) {
                    return;
                }
                if (swIMUMerger.isChecked()) {

                    imuMergerShell = sendSingleCommandAndGetChannel("cd catkin_ws;rosrun imu_listener imu_listener", session);

                    if (imuMergerShell != null && imuMergerShell.isConnected()) {
                        cbIMUMerger.setChecked(true);
                    }

                } else {

                    if (imuMergerShell != null) imuMergerShell.disconnect();
                    imuMergerShell = null;
                    cbIMUMerger.setChecked(false);
                }
            }
        });

        //switch of LMS
        swLMS.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (!isSessionReady()) {
                    return;
                }
                if (swLMS.isChecked()) {

                    lmsShell = sendSingleCommandAndGetChannel("cd catkin_ws/launch; roslaunch lmslaunch.launch", session);

                    if (lmsShell != null && lmsShell.isConnected()) {
                        cbLMS.setChecked(true);
                    }

                } else {

                    if (lmsShell != null) lmsShell.disconnect();
                    lmsShell = null;
                    cbLMS.setChecked(false);
                }
            }
        });


        //switch of pwm
        swPWM.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (!isSessionReady()) {
                    return;
                }
                if (swPWM.isChecked()) {

                    pwmRepeateShell = sendSingleCommandAndGetChannel("cd catkin_ws; rosrun pwm_commander pwm_const_publisher", session);


                    //pwm to pin topic has to be executed as sudo. therfore the command is executed on the sudo channel
                    pwmToPinShell = sendSingleCommandAndGetChannel("source /home/ubuntu/catkin_ws/devel/setup.bash;cd /home/ubuntu/catkin_ws; rosrun pwm_commander high_res_pwm_to_pin;", sessionSudo);

                    //set checkboxes if everything worked
                    if (pwmRepeateShell != null && pwmRepeateShell.isConnected()) {

                        cbPWM1.setChecked(true);
                    }

                    if (pwmToPinShell != null && pwmToPinShell.isConnected()) {

                        cbPWM2.setChecked(true);
                    }


                    pwmReaderShell = getNewShellChannel(session, true);

                    // initilaize the const_publiser if shell and printstream are ok
                    if (pwmReaderShell != null && pwmPrinStream != null && pwmReaderShell.isConnected()) {

                        pwmPrinStream.println("cd catkin_ws; rosrun pwm_commander pwm_reader");
                        ePWMToSend.setVisibility(View.VISIBLE);
                        bSendPWM.setActivated(true);
                        bSendPWM.setVisibility(View.VISIBLE);

                        cbPWM3.setChecked(true);

                        bOptionsPWM.setActivated(true);
                        bOptionsPWM.setVisibility(View.VISIBLE);


                    }


                }
                //if the switch has been deactivated
                else {

                    if (pwmToPinShell != null) pwmToPinShell.disconnect();
                    pwmToPinShell = null;

                    if (pwmRepeateShell != null) pwmRepeateShell.disconnect();
                    pwmRepeateShell = null;

                    if (pwmReaderShell != null) pwmReaderShell.disconnect();
                    pwmReaderShell = null;


                    if (pwmPrinStream != null) pwmPrinStream.close();
                    pwmPrinStream = null;

                    ePWMToSend.setVisibility(View.INVISIBLE);

                    bSendPWM.setVisibility(View.INVISIBLE);

                    bSendPWM.setActivated(false);


                    bOptionsPWM.setVisibility(View.INVISIBLE);

                    bOptionsPWM.setActivated(false);

                    cbPWM1.setChecked(false);
                    cbPWM2.setChecked(false);
                    cbPWM3.setChecked(false);


                }
            }
        });

        bOptionsPWM.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent i = new Intent(MainActivity.this, PWMActivity.class);
                startActivity(i);
            }
        });


        //kill all nodes
        bKillAll.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                if (session == null || !session.isConnected()) {

                    toastIt("No Active session, start it first!", false);
                }


                final Channel cTemp = sendSingleCommandAndGetChannelAndConfirmWithY("rosnode kill -a; rosnode cleanup\n", session);


                Handler handler2 = new Handler();
                handler2.postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        cTemp.disconnect();

                        cleanAllChannels();

                        toastIt("Rosnodes Killed", false);

                        cbIMU1.setChecked(false);
                        cbIMU2.setChecked(false);
                        cbIMU3.setChecked(false);
                        cbIMUMerger.setChecked(false);
                        cbPWM1.setChecked(false);
                        cbPWM2.setChecked(false);
                        cbPWM3.setChecked(false);
                        cbLMS.setChecked(false);

                    }
                }, 4000);
            }
        });


        bShowNodes.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (!isSessionReady()) return;

                getActivROSNodes(session);
            }
        });


        //send PWm signal (button only visible if channel is connected)
        bSendPWM.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                {
                    if (pwmPrinStream == null) {
                        toastIt("No Printstream avaliable", false);
                        return;
                    }

                    if (bSendPWM.getVisibility() == View.INVISIBLE) {
                        return;
                    }

                    int iTemp = 0;

                    try {
                        iTemp = Integer.valueOf(ePWMToSend.getText().toString());
                    } catch (NumberFormatException nfe) {

                        toastIt("Not a integer number", false);

                        return;
                    }

                    if (iTemp < -1) iTemp = 0;
                    if (iTemp > 40) iTemp = 0;


                    pwmPrinStream.println("s " + iTemp);
                }

            }
        });

    }

    //clean the known Channels. Does not kill all topics (so the one we did not start). The button "kill all" does exactly that
    public void cleanAllChannels() {

        if (imu1Shell != null) imu1Shell.disconnect();
        imu1Shell = null;

        if (imu2Shell != null) imu2Shell.disconnect();
        imu2Shell = null;

        if (imu3Shell != null) imu3Shell.disconnect();
        imu3Shell = null;


        if (imuMergerShell != null) imuMergerShell.disconnect();
        imuMergerShell = null;


        if (lmsShell != null) lmsShell.disconnect();
        lmsShell = null;


        if (pwmToPinShell != null) pwmToPinShell.disconnect();
        pwmToPinShell = null;

        if (pwmRepeateShell != null) pwmRepeateShell.disconnect();
        pwmRepeateShell = null;

        if (pwmReaderShell != null) pwmReaderShell.disconnect();
        pwmReaderShell = null;


        if (pwmPrinStream != null) pwmPrinStream.close();
        pwmPrinStream = null;

    }


    //open a session and save it to global variable "session"
    public boolean openSession(String username, String host, String password) {

        if (session != null && session.isConnected()) {

            cbConnected.setActivated(true);
            System.err.println("Already opended, first disconnect please");
            return false;

        }

        cbTested.setActivated(false);

        try {

            session = jsch.getSession(username, host, 22);
            session.setPassword(password);

        } catch (JSchException e) {
            System.err.println("can not get The session");
            return false;
        }


        try {

            //block rsa restriction
            java.util.Properties config = new java.util.Properties();
            config.put("StrictHostKeyChecking", "no");
            session.setConfig(config);

            //connect

            session.connect(30000);
            System.out.println("connected to " + username + " @ " + host);
            cbConnected.setChecked(true);

        } catch (JSchException e) {
            System.err.println("Can not Connect");

            return false;
        }

        return true;
    }

    //same as openSession, it is justr written to the  global variable "sessionSudo". Important: this does not
    //take care of the String username being "root" or so. You could possibaly just have a normal Session saved to sessionSudo
    public boolean openSudoSession(String username, String host, String password) {

        if (sessionSudo != null && sessionSudo.isConnected()) {


            return false;

        }


        try {

            sessionSudo = jsch.getSession(username, host, 22);
            sessionSudo.setPassword(password);

        } catch (JSchException e) {
            System.err.println("can not get The session");
            return false;
        }


        try {

            //block rsa restriction
            java.util.Properties config = new java.util.Properties();
            config.put("StrictHostKeyChecking", "no");
            sessionSudo.setConfig(config);

            //connect

            sessionSudo.connect(30000);
            System.out.println("connected to " + username + " @ " + host);

        } catch (JSchException e) {
            System.err.println("Can not Connect to " + username + " @ " + host);

            return false;
        }

        //set time
        Date currentTime = Calendar.getInstance().getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("dd MM yyyy HH:mm:ss", Locale.getDefault());


        String s = "date -s \'@" + Calendar.getInstance().getTimeInMillis() / 1000 + "\'";
        sendSingleCommandAndClose(s, sessionSudo);


        int i = 1;

        return true;
    }

    public boolean closeSession() {

        cbConnected.setChecked(false);

        if (sessionSudo != null) {
            if (sessionSudo.isConnected()) {
                sessionSudo.disconnect();
            }
            sessionSudo = null;
        }


        if (session == null) {
            cbConnected.setActivated(false);
            System.err.println("No Session (null)");

            return false;


        }

        if (!session.isConnected()) {

            System.err.println("Session already disconnected");

            return false;

        }

        session.disconnect();
        return true;

    }

    public boolean closeSessionSudo() {


        if (sessionSudo == null) {
            System.err.println("No Session (null)");

            return false;


        }

        if (!sessionSudo.isConnected()) {

            System.err.println("Session already disconnected");

            return false;

        }

        sessionSudo.disconnect();
        return true;

    }

    //checks if session is existent and connected
    public boolean isSessionReady() {

        return session != null && session.isConnected();
    }


    //just test the ssh connection
    public boolean testCommand() {

        String d = sendSingleCommandAndClose("date", sessionSudo);
        d = d.replace("UTC ", "");
        d = "System-Time:\n" + d.substring(0, 10) + "\n" + d.substring(10, d.length() - 1);
        tTime.setText(d);

        if (session == null || !session.isConnected()) return false;

        String tempAnswer = sendSingleCommandAndClose("echo 1+2+3", session);
        //delete the \n which occurs with reading the shell
        tempAnswer = tempAnswer.substring(0, 5);

        if (tempAnswer.equals("1+2+3")) {

            cbTested.setActivated(true);
            return true;
        }

        toastIt("Answer was: \"" + tempAnswer + "\" but should be: \"1+2+3", false);
        return false;

    }

    //returns an ne ShellChannel from Session, has to be closed manually
    public Channel getNewShellChannel(Session session, boolean setPwmPrinSTream) {

        if (session == null) {

            return null;
        }

        Channel channel = null;

        try {
            channel = session.openChannel("shell");


            OutputStream ops = channel.getOutputStream();
            if (setPwmPrinSTream) pwmPrinStream = new PrintStream(ops, true);

            channel.connect();


        } catch (JSchException ische) {
            System.err.println("Cannot connect channel");

        } catch (IOException ioe) {

            System.err.println("Problem with outpustream of ne ShellChannel");
        }

        return channel;
    }


    //Send one command to new channel, closes channel and returns answer of SSH-Server
    public String sendSingleCommandAndClose(String command, Session session) {

        if (session == null || command.equals("")) {

            return ("Failure");
        }
        StringBuilder outputBuffer = new StringBuilder();

        Channel channel = null;
        try {
            channel = session.openChannel("exec");
            ((ChannelExec) channel).setCommand(command);
            InputStream commandOutput = channel.getInputStream();
            channel.connect();
            int readByte = commandOutput.read();

            while (readByte != 0xffffffff) {
                outputBuffer.append((char) readByte);
                readByte = commandOutput.read();
            }

            channel.disconnect();
        } catch (IOException ioX) {

            System.err.println("IOException while testing");
            return null;
        } catch (JSchException jschX) {

            System.err.println("Isch exception while testing");

            return null;
        }


        channel.disconnect();


        System.out.println("Raw answer of ssh was: " + outputBuffer.toString());


        return outputBuffer.toString();
    }


    //list all active rosnodes. Sends "rosnode list" and than filters everything of the outpurstrem till the nodes come
    // therefore we have to read twice till "rosnode list". If you ask yourself why, just look at the output which is genrerated.
    // first the "welcome to ubuntu ...." message, followed by your own command "rosnode list" which is than repeated by shell. Theefore its two times in the outputstream
    public String getActivROSNodes(Session session) {

        String command = "rosnode list";
        final StringBuilder outputBuffer = new StringBuilder();


        try {
            final Channel channel = session.openChannel("shell");

            channel.connect();


            OutputStream ops = channel.getOutputStream();
            PrintStream ps = new PrintStream(ops, true);

            final InputStream commandOutput = channel.getInputStream();
            ps.println(command);
            ps.close();


            int readByte = commandOutput.read();


            outputBuffer.append((char) readByte);


            //read till word "rosnode"
            while (readByte != 0xffffffff) {


                readByte = commandOutput.read();

                if (readByte == ' ' || readByte == '\n') {

                    if (!outputBuffer.toString().equals("rosnode")) {
                        outputBuffer.delete(0, outputBuffer.length());
                    } else {
                        outputBuffer.delete(0, outputBuffer.length());
                        break;
                    }

                } else {
                    outputBuffer.append((char) readByte);
                }

            }

            outputBuffer.delete(0, outputBuffer.length());
            //read till  word "list"
            while (readByte != 0xffffffff) {

                readByte = commandOutput.read();
                if (readByte == ' ' || readByte == '\n') break;


            }


            //read again till rosnode
            while (readByte != 0xffffffff) {


                readByte = commandOutput.read();

                if (readByte == ' ' || readByte == '\n') {

                    if (!outputBuffer.toString().equals("rosnode")) {
                        outputBuffer.delete(0, outputBuffer.length());
                    } else {
                        outputBuffer.delete(0, outputBuffer.length());
                        break;
                    }

                } else {
                    outputBuffer.append((char) readByte);
                }

            }

            outputBuffer.delete(0, outputBuffer.length());


            //read  again till "list"
            while (readByte != 0xffffffff) {

                readByte = commandOutput.read();
                if (readByte == ' ' || readByte == '\n') break;


            }
            //read till new line does not start with /
            while (readByte != 0xffffffff) {
                readByte = commandOutput.read();


                if (readByte == '\n') {

                    outputBuffer.append((char) readByte);
                    readByte = commandOutput.read();

                    if (readByte != '/') {
                        outputBuffer.deleteCharAt(outputBuffer.length() - 1);

                        break;
                    }


                }

                outputBuffer.append((char) readByte);


            }

            channel.disconnect();

            toastIt(outputBuffer.toString(), true);


        } catch (IOException ioX) {

            System.err.println("IOException while asking for nodes");
            return null;
        } catch (JSchException jschX) {

            System.err.println("Ischwhile asking for nodes");

            return null;
        }


        System.out.println("Raw answer of ssh was: " + outputBuffer.toString());

        return outputBuffer.toString();

    }

    //send one command and get the channel back. Its not foreseen to send an other command, but the channel is activated
    //and has to be closed manually (if really neccesary you can open the outputstream of the channel again to send an other command
    //multiple commands can be send by semicolon (e.g: "cd catkin_ws; cd launcg; cd roslaunch launtest.launch")
    public Channel sendSingleCommandAndGetChannel(String command, Session session) {

        if (session == null || command.equals("")) {

            return (null);
        }
        StringBuilder outputBuffer = new StringBuilder();

        Channel channel = null;
        try {
            channel = session.openChannel("shell");

            OutputStream ops = channel.getOutputStream();
            PrintStream ps = new PrintStream(ops, true);

            channel.connect();
            ps.println(command);
            ps.close();


            //final InputStream commandOutput = channel.getInputStream();
            // int readByte = commandOutput.read();

            System.out.println("Starting listening");
            //response of the shell
           /*while (commandOutput.available() > -1&& command.equals("cd catkin_ws;rosrun imu_listener imu_listener")) {
                outputBuffer.append((char) readByte);
                readByte = commandOutput.read();


                System.out.println(outputBuffer.toString());
            }*/

            System.out.println(outputBuffer.toString());

        } catch (IOException ioX) {

            System.err.println("IO Exception occured!");
            ioX.printStackTrace();
            return null;
        } catch (JSchException jschX) {

            System.err.println("Jsch exception occured!");
            jschX.printStackTrace();
            return null;
        }


        System.out.println("Raw answer of ssh was: " + outputBuffer.toString());


        return channel;
    }

    //same as sendSingeCommandAndGetChannel but a "y" is sended after 2 seconds.
    // just sneding the command "cd here; doSomeThingWithConfimation; y;" wont work, because the y has to be typed after whatever you want to do has been computed
    public Channel sendSingleCommandAndGetChannelAndConfirmWithY(String command, Session session) {

        if (session == null || command.equals("")) {

            return (null);
        }
        final StringBuilder outputBuffer = new StringBuilder();

        Channel channel = null;
        try {
            channel = session.openChannel("shell");

            final OutputStream ops = channel.getOutputStream();
            final PrintStream ps = new PrintStream(ops, true);

            channel.connect();
            ps.println(command);


            final InputStream commandOutput = channel.getInputStream();
            int readByte = commandOutput.read();

            while (commandOutput.available() > 1) {
                outputBuffer.append((char) readByte);
                readByte = commandOutput.read();
                System.out.println(outputBuffer.toString());

            }

            System.out.println(outputBuffer.toString());


            Handler h = new Handler();
            h.postDelayed(new Runnable() {
                @Override
                public void run() {

                    ps.println("y");
                    ps.close();
                }
            }, 2000);


        } catch (IOException ioX) {

            System.err.println("IO Exception occured!");
            ioX.printStackTrace();
            return null;
        } catch (JSchException jschX) {

            System.err.println("Jsch exception occured!");
            jschX.printStackTrace();
            return null;
        }


        System.out.println("Raw answer of ssh was: " + outputBuffer.toString());


        return channel;
    }


    //make a toast (message shown on android device) with the message
    public void toastIt(String message, boolean longPeriod) {

        if (message == null) {
            return;
        }

        Toast t = Toast.makeText(MainActivity.this, message, (longPeriod ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT));

        t.show();
    }
}
