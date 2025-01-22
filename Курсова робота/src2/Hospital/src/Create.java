import java.util.List;

public class Create extends Element{
    public Create(String nameOfElement, List<Double> delays, List<String> distributions, int numberOfDevices) {
        super(nameOfElement, delays, distributions, numberOfDevices);
        for (Device device : super.getDevices()) {
            device.setTNext(0);
        }
    }

    @Override
    public void outAct( ) {
        super.outAct();
        Time time = new Time(super.getTcurr());
        double hours = time.getHours();
        double p1,p2,p3;
        if(hours >= 7 && hours <= 10 ){
            p1 = 0.9;
            p2 = 0.1;
            p3 = 0;
        } else {
            p1 = 0.5;
            p2 = 0.1;
            p3 = 0.4;
        }

        Patient newPatient = generatePatient(p1, p2, p3);
        newPatient.setArrival(super.getTcurr());
        double delay = 0;
        for (Device device : super.getDevices()) {
            device.setPatient(newPatient);
            delay = device.getDelayAverage(0);
        }
        Transfer transfer = super.getTransfer();
        String next = transfer.goNext(this, super.getTcurr(), newPatient);

        if((next == "blocked")){
            super.setTnext(super.getTcurr() + time.getNightDelay());
        } else {
            super.setTnext(super.getTcurr() + delay);
        }

    }

    public Patient generatePatient(double p1, double p2, double p3) {
        int type = 0;
        double rand = Math.random();

        if (rand < p1) {
            type = 1; 
        } else if (rand < p1 + p2) {
            type = 2; 
        } else {
            type = 3;
        }

        Patient newPatient = new Patient(type, super.getTcurr());

        return newPatient;
    }
}
