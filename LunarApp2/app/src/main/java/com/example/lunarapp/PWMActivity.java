package com.example.lunarapp;

import android.content.Intent;
import android.os.Bundle;
import android.os.PersistableBundle;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.SeekBar;
import android.widget.Switch;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import java.io.PrintStream;

public class PWMActivity extends AppCompatActivity {

    PrintStream pwmPrintstream =null;


    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_pwm);


        Button bExit = findViewById(R.id.bExit2);

        Button bSendRaw = findViewById(R.id.bSendRaw2);
        final EditText eSendRaw = findViewById(R.id.eSendRaw2);

        Button bSet0 = findViewById(R.id.bSetZeo2);

        SeekBar seekBar = findViewById(R.id.seekBarPWM);

        final Switch cbVibCon = findViewById(R.id.sVibCon);



        pwmPrintstream = MainActivity.pwmPrinStream;





        bSendRaw.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String s = eSendRaw.getText().toString();
                pwmPrintstream.println(s);
            }
        });

        bSet0.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                pwmPrintstream.println("d 0");
            }
        });

        cbVibCon.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(cbVibCon.isChecked()){
                 pwmPrintstream.println("v 1");
                }else {
                    pwmPrintstream.println("v 0");
                }
            }
        });

        seekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                if(!fromUser)return;

                pwmPrintstream.println("d "+ (progress+10) );

            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {

            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {

            }
        });



        bExit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });


    }
}
