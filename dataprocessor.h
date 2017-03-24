#ifndef DATAPROCESSOR_H
#define DATAPROCESSOR_H

#include <QObject>
#include <QQuickItem>

class DataProcessor: public QQuickItem
{
    Q_OBJECT
    // coordinates
    Q_PROPERTY(double xCoord READ xCoord WRITE setxCoord)
    Q_PROPERTY(double yCoord READ yCoord WRITE setyCoord)
    Q_PROPERTY(double zCoord READ zCoord WRITE setzCoord)

    // times
    Q_PROPERTY(double xVel READ xVel WRITE setxVel)
    Q_PROPERTY(double yVel READ yVel WRITE setyVel)
    Q_PROPERTY(double zVel READ zVel WRITE setzVel)

    // velocities
    Q_PROPERTY(double t0 READ t0 WRITE sett0)
    Q_PROPERTY(double t1 READ t1 WRITE sett1)
    Q_PROPERTY(double t2 READ t2 WRITE sett2)

    Q_PROPERTY(double dt READ dt WRITE setdt)

    // control input values
    Q_PROPERTY(int xControl READ xControl WRITE setxControl)
    Q_PROPERTY(int yControl READ yControl WRITE setyControl)
    Q_PROPERTY(int zControl READ zControl WRITE setzControl)

    Q_PROPERTY(int point READ point WRITE setPoint)
    Q_PROPERTY(double cubeLength READ cubeLength WRITE setCubeLength)

public:
    DataProcessor(QQuickItem *parent = 0);

        // coordinates
        double xCoord();
        void setxCoord(double &xCoord);
        double yCoord();
        void setyCoord(double &yCoord);
        double zCoord();
        void setzCoord(double &zCoord);

        int point();
        void setPoint(int &point);
        double cubeLength();
        void setCubeLength(double &cubeLength);

        // velocities
        double xVel();
        void setxVel(double &xVel);
        double yVel();
        void setyVel(double &yVel);
        double zVel();
        void setzVel(double &zVel);

        //times
        double t0();
        void sett0(double&t0);
        double t1();
        void sett1(double&t1);
        double t2();
        void sett2(double&t2);
        double dt();
        void setdt(double&dt);

        // control input values
        int xControl();
        void setxControl(int &xControl);
        int yControl();
        void setyControl(int &yControl);
        int zControl();
        void setzControl(int &zControl);

        // changing x
        Q_INVOKABLE void updateX();
        Q_INVOKABLE void updateY();
        Q_INVOKABLE void updateZ();

        Q_INVOKABLE void updateCoords();
        Q_INVOKABLE void updateOthers(int p, double x, double y, double z);

private:

    // coordinates
    double m_xCoord;
    double m_yCoord;
    double m_zCoord;

    int m_point;
    double m_cubeLength;

    // velocities
    double m_xVel;
    double m_yVel;
    double m_zVel;

    // times
    double m_t0;
    double m_t1;
    double m_t2;

    double m_dt;

    // control input values
    int m_xControl;
    int m_yControl;
    int m_zControl;

};

#endif // DATAPROCESSOR_H
