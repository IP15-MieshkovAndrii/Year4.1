import java.util.ArrayList;
import java.util.List;

public class QueueP {
    private List<Patient> patients;
    private int currentLength;
    private String status = "empty";

    public QueueP() {
        currentLength=0;
        patients = new ArrayList<>();
    }

    public String getStatus() {
        currentLength = patients.size();
        if(currentLength == 0) {
            status = "empty";
        } else {
            status = "notEmpty";
        }

        return status;
    }

    public void add(Patient patient) {
        patients.add(patient);
        currentLength = patients.size();
    }

    public Patient remove() {
        return patients.remove(0);
    }
    public int length(){
        currentLength = patients.size();
        return currentLength;
    }
}
