package com.example.flutter_conekta;

import android.app.Activity;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by Alfredo Quintero Tlacuilo on 27/10/15.
 */
public class Token {
    private String endPoint = "/tokens";
    private Activity activity;

    public interface CreateToken {
        public void onCreateTokenReady(JSONObject data);
    }

    private CreateToken listener;

    public Token() {
        this.listener = null;
    }

    public void onCreateTokenListener (CreateToken listener) {
        this.listener = listener;
    }

    public Token(Activity activity) {
        this.activity = activity;
    }

    public void create(Card card) {
        /* Remember add to index of nameValuePair if you add more rows */
        Map<String, String> body = new HashMap<>();

        body.put("number", card.getNumber());
        body.put("name", card.getName());
        body.put("cvc", card.getCvc());
        body.put("exp_month", card.getExpMonth());
        body.put("exp_year", card.getExpYear());
        body.put("device_fingerprint", Conekta.deviceFingerPrint(activity));

        Connection connection = new Connection();

        connection.onRequestListener(new Connection.ConnectionRequest() {
            @Override
            public void onRequestReady(JSONObject data) {
                listener.onCreateTokenReady(data);
            }
        });
        connection.request(activity.getApplicationContext(), body, this.endPoint);
    }
}
