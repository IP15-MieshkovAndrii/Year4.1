public class Patient {
    private int type;

    private double arrivalTime;
    private double exit;
    private double duration;

    private int isPassed;

    public Patient(int type, double time) {
        this.type = type;
        arrivalTime = time;
        duration = 0;
        exit = 0;
        isPassed = 0;
    }

    public void setType(int type) {
        this.type = type;
    }
    public int getType() {
        return type;
    }
    public double getDuration() {
        return duration;
    }
    public void setExit(double exit) {
        this.exit = exit;
        this.duration+= exit - this.arrivalTime;
    }
    public void setArrival(double arrivalTime) {
        this.arrivalTime = arrivalTime;
    }

    public String getPatient() {
        String patiet = "Type: " + type + ", arrived at:" + arrivalTime + ", exit at:" + exit + ", duration: " + duration;
        return patiet;
    }

    public int getFlag() {
        return isPassed;
    }
    public void setFlag(int isPassed) {
        this.isPassed = isPassed;
    }
}

