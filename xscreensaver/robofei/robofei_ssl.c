#include <stdlib.h>
#include <X11/Xlib.h> // apt install libx11-dev
#include <X11/xpm.h> // apt install libxpm-dev
#include <stdio.h>
#include <math.h>

#include "robofei.xpm"
#include "vroot.h"

#define NCOLORS 8
#define ORANGE  0
#define GREEN   1
#define BLUE    2
#define BLACK   3
#define PINK    4
#define YELLOW  5
#define WHITE   6
#define LIGHT_GREEN 7

#define OFFSET 100
#define CENTER_CIRCLE 200
#define TEAM_SIZE 6
#define ROBOT_RADIUS 60

Display *display;
Window window;
XWindowAttributes windowAtt;
Pixmap doubleBuffer;
GC graphics, gc;
XColor colors[NCOLORS];
const char *colorNames[NCOLORS]={"orange", "webgreen", "blue", "black", "fuchsia", "yellow", "white", "green"};

typedef struct
{
    int color0;
    int color1;
    int color2;
    int color3;
}ID;

#define ID_0  {.color0 = PINK,        .color1 = PINK,        .color2 = LIGHT_GREEN, .color3 = PINK}
#define ID_1  {.color0 = LIGHT_GREEN, .color1 = PINK,        .color2 = LIGHT_GREEN, .color3 = PINK}
#define ID_2  {.color0 = LIGHT_GREEN, .color1 = LIGHT_GREEN, .color2 = LIGHT_GREEN, .color3 = PINK}
#define ID_3  {.color0 = PINK,        .color1 = LIGHT_GREEN, .color2 = LIGHT_GREEN, .color3 = PINK}
#define ID_4  {.color0 = PINK,        .color1 = PINK,        .color2 = PINK,        .color3 = LIGHT_GREEN}
#define ID_5  {.color0 = LIGHT_GREEN, .color1 = PINK,        .color2 = PINK,        .color3 = LIGHT_GREEN}
// #define ID_6  {.color0 = LIGHT_GREEN, .color1 = LIGHT_GREEN, .color2 = PINK,        .color3 = LIGHT_GREEN}
// #define ID_7  {.color0 = PINK,        .color1 = LIGHT_GREEN, .color2 = PINK,        .color3 = LIGHT_GREEN}
// #define ID_8  {.color0 = LIGHT_GREEN, .color1 = LIGHT_GREEN, .color2 = LIGHT_GREEN, .color3 = LIGHT_GREEN}
// #define ID_9  {.color0 = PINK,        .color1 = PINK,        .color2 = PINK,        .color3 = PINK}
// #define ID_10 {.color0 = PINK,        .color1 = PINK,        .color2 = LIGHT_GREEN, .color3 = LIGHT_GREEN}

ID robotIDs[TEAM_SIZE] = { ID_0, ID_1, ID_2, ID_3, ID_4, ID_5 };
// ID robotIDs[TEAM_SIZE] = { ID_0, ID_1, ID_2, ID_3, ID_4, ID_5, ID_6, ID_7,
//                            ID_8, ID_9, ID_10 };

void setColor(int colorIndex)
{
    if(colorIndex >= 0 && colorIndex < NCOLORS)
    {
        XSetForeground(display, graphics, colors[colorIndex].pixel);
    }
}

typedef struct
{
    int x;
    int y;
    float dx;
    float dy;
    int radius;

}BALL;
BALL ball = {.x = OFFSET + 50, .y = OFFSET + 50, .dx = 2, .dy = 2, .radius = 21};

typedef struct
{
    int x;
    int y;
    float dx;
    float dy;
    int color;
    int id;
}ROBOT;
#define BLUE_ROBOT {.x = OFFSET, .y = OFFSET, .dx = 3,\
                    .dy = 3, .color = BLUE, .id = 0}

#define YELLOW_ROBOT {.x = OFFSET, .y = OFFSET, .dx = 3,\
                      .dy = 3, .color = YELLOW, .id = 0}

ROBOT teamBlue[TEAM_SIZE] = {
                             BLUE_ROBOT, BLUE_ROBOT, BLUE_ROBOT,
                             BLUE_ROBOT, BLUE_ROBOT, BLUE_ROBOT,
//                              BLUE_ROBOT, BLUE_ROBOT, BLUE_ROBOT,
//                              BLUE_ROBOT, BLUE_ROBOT
                            },
teamYellow[TEAM_SIZE] = {
                       YELLOW_ROBOT,YELLOW_ROBOT,YELLOW_ROBOT,
                       YELLOW_ROBOT, YELLOW_ROBOT, YELLOW_ROBOT,
//                        YELLOW_ROBOT,YELLOW_ROBOT,YELLOW_ROBOT,
//                        YELLOW_ROBOT, YELLOW_ROBOT
                       };

float distance(const ROBOT *_A, const ROBOT *_B)
{
    return sqrt(pow(_A->x - _B->x, 2) + pow(_A->y - _B->y, 2));
}

float ballDistance(const ROBOT *_A)
{
    return sqrt(pow(_A->x - ball.x, 2) + pow(_A->y - ball.y, 2));
}

void edgeCollision(int *_x, int *_y, float *_dx, float *_dy, int radius)
{
    if(*_x - radius/2 <= OFFSET || *_x < 0)
    {
        *_x = OFFSET + radius/2;
        *_dx *= -1;
    }
    else if(*_x + radius/2 >= windowAtt.width - OFFSET)
    {
        *_x = windowAtt.width - OFFSET - radius/2;
        *_dx *= -1;
    }

    if(*_y - radius/2 <= OFFSET || *_y < 0)
    {
        *_y = OFFSET + radius/2;
        *_dy *= -1;
    }
    else if(*_y + radius/2 >= windowAtt.height - OFFSET)
    {
        *_y = windowAtt.height - OFFSET - radius/2;
        *_dy *= -1;
    }
}

void drawField()
{
    setColor(GREEN);
    XFillRectangle(display, doubleBuffer, graphics,
            0, 0, windowAtt.width, windowAtt.height);

    setColor(WHITE);
    XDrawLine(display, doubleBuffer, graphics, OFFSET, OFFSET,
            windowAtt.width-OFFSET, OFFSET);
    XDrawLine(display, doubleBuffer, graphics, OFFSET, windowAtt.height-OFFSET,
            windowAtt.width-OFFSET, windowAtt.height-OFFSET);
    XDrawLine(display, doubleBuffer, graphics, OFFSET, OFFSET,
            OFFSET, windowAtt.height-OFFSET);
    XDrawLine(display, doubleBuffer, graphics, windowAtt.width-OFFSET, OFFSET,
            windowAtt.width-OFFSET, windowAtt.height-OFFSET);
    XDrawLine(display, doubleBuffer, graphics, windowAtt.width/2, OFFSET,
            windowAtt.width/2, windowAtt.height-OFFSET);

    XDrawArc(display, doubleBuffer, graphics,
             windowAtt.width/2-CENTER_CIRCLE/2,
             windowAtt.height/2-OFFSET,
             CENTER_CIRCLE, CENTER_CIRCLE, 0, 360*64);

    const int areaHeight = 300, areaWidth = 150;
    XDrawLine(display, doubleBuffer, graphics, OFFSET, windowAtt.height/2 - areaHeight/2,
            OFFSET+areaWidth, windowAtt.height/2 - areaHeight/2);

    XDrawLine(display, doubleBuffer, graphics, OFFSET, windowAtt.height/2 + areaHeight/2,
            OFFSET+areaWidth, windowAtt.height/2 + areaHeight/2);

    XDrawLine(display, doubleBuffer, graphics, OFFSET+areaWidth, windowAtt.height/2 + areaHeight/2,
            OFFSET+areaWidth, windowAtt.height/2 - areaHeight/2);

    XDrawLine(display, doubleBuffer, graphics, windowAtt.width - OFFSET, windowAtt.height/2 - areaHeight/2,
            windowAtt.width - OFFSET - areaWidth, windowAtt.height/2 - areaHeight/2);

    XDrawLine(display, doubleBuffer, graphics, windowAtt.width - OFFSET, windowAtt.height/2 + areaHeight/2,
            windowAtt.width - OFFSET - areaWidth, windowAtt.height/2 + areaHeight/2);

    XDrawLine(display, doubleBuffer, graphics, windowAtt.width - OFFSET - areaWidth, windowAtt.height/2 + areaHeight/2,
            windowAtt.width - OFFSET - areaWidth, windowAtt.height/2 - areaHeight/2);
}

void updateBall(BALL *_ball)
{
    _ball->x += _ball->dx;
    _ball->y += _ball->dy;

    edgeCollision(&_ball->x, &_ball->y, &_ball->dx, &_ball->dy,
                  _ball->radius);

    unsigned char collision = 0;
    ROBOT collisionBot;
    for(int i = 0; i < TEAM_SIZE; ++i)
    {
        if(ballDistance(&teamBlue[i]) <= _ball->radius/2.0 + ROBOT_RADIUS/2.0)
        {
            collision = 1;
            collisionBot = teamBlue[i];
            break;
        }
        if(ballDistance(&teamYellow[i]) <= _ball->radius/2.0 + ROBOT_RADIUS/2.0)
        {
            collision = 1;
            collisionBot = teamYellow[i];
            break;
        }
    }

    if(collision)
    {
        int speed = random() % 6 + 1;
        _ball->dx = - speed * (float)(collisionBot.x - _ball->x) / fabs(collisionBot.x - _ball->x + 1e-10);
        _ball->dy = - speed * (float)(collisionBot.y - _ball->y) / fabs(collisionBot.x - _ball->x + 1e-10);
    }

    if(fabsf(_ball->dx) < 1 || fabsf(_ball->dx) > 6)
    {
        _ball->dx = 1 * _ball->dx/fabsf(_ball->dx);
    }
    if(fabsf(_ball->dy) < 1 || fabsf(_ball->dy) > 6)
    {
        _ball->dy = 1 * _ball->dy/fabsf(_ball->dy);
    }
}

void drawBall()
{
    setColor(ORANGE);
    XFillArc(display, doubleBuffer, graphics,
             ball.x - ball.radius/2, ball.y - ball.radius/2,
             ball.radius, ball.radius,
             0, 360*64);
    updateBall(&ball);
}

void updateRobot(ROBOT *_robot, int _id)
{
    _robot->x += _robot->dx;
    _robot->y += _robot->dy;

    edgeCollision(&_robot->x, &_robot->y, &_robot->dx, &_robot->dy,
                  ROBOT_RADIUS);

    ROBOT collisionBot;
    unsigned char collision = 0;
    for(int i = 0; i < TEAM_SIZE; ++i)
    {
        if(_robot->color == YELLOW)
        {
            if(distance(&teamYellow[_id], &teamBlue[i]) < ROBOT_RADIUS)
            {
                collisionBot = teamBlue[i];
                collision = 1;
            }

            if(i != _id && distance(&teamYellow[_id], &teamYellow[i]) < ROBOT_RADIUS)
            {
                collisionBot = teamYellow[i];
                collision = 1;
            }
        }
        else
        {
            if(distance(&teamYellow[i], &teamBlue[_id]) < ROBOT_RADIUS)
            {
                collisionBot = teamYellow[i];
                collision = 1;
            }
            if(i != _id && distance(&teamBlue[_id], &teamBlue[i]) < ROBOT_RADIUS)
            {
                collisionBot = teamBlue[i];
                collision = 1;
            }
        }
    }

    if(collision)
    {
        int speed = random() % 3 + 1;
        _robot->dx = - speed * (float)(collisionBot.x - _robot->x) / fabs(collisionBot.x - _robot->x + 1e-10);
        _robot->dy = - speed * (float)(collisionBot.y - _robot->y) / fabs(collisionBot.x - _robot->x + 1e-10);
    }

    if(fabsf(_robot->dx) < 1 || fabsf(_robot->dx) > 3)
    {
        _robot->dx = 1 * _robot->dx/fabsf(_robot->dx);
    }
    if(fabsf(_robot->dy) < 1 || fabsf(_robot->dy) > 3)
    {
        _robot->dy = 1 * _robot->dy/fabsf(_robot->dy);
    }
}


void initRobots()
{
    for(int i = 0; i < TEAM_SIZE; ++i)
    {
        teamBlue[i].x = random() % (windowAtt.width - 2*OFFSET) + OFFSET;
        teamBlue[i].y = random() % (windowAtt.height - 2*OFFSET) + OFFSET;
        teamBlue[i].id = i;
        teamYellow[i].x = random() % (windowAtt.width - 2*OFFSET) + OFFSET;
        teamYellow[i].y = random() % (windowAtt.height - 2*OFFSET) + OFFSET;
        teamYellow[i].id = i;
    }
}

void drawRobot(ROBOT *_robot)
{
    const int blobSize = 15;

    setColor(BLACK);
    XFillArc(display, doubleBuffer, graphics,
            _robot->x - ROBOT_RADIUS/2, _robot->y - ROBOT_RADIUS/2,
            ROBOT_RADIUS, ROBOT_RADIUS,
            0, 360*64);
    setColor(_robot->color);
    XFillArc(display, doubleBuffer, graphics,
            _robot->x - blobSize/2, _robot->y - blobSize/2,
            blobSize, blobSize,
            0, 360*64);

    setColor(robotIDs[_robot->id].color0);
    XFillArc(display, doubleBuffer, graphics,
            _robot->x - blobSize/2 - blobSize, _robot->y - blobSize/2 - blobSize,
            blobSize, blobSize,
            0, 360*64);
    setColor(robotIDs[_robot->id].color1);
    XFillArc(display, doubleBuffer, graphics,
            _robot->x - blobSize/2 + blobSize, _robot->y - blobSize/2 - blobSize,
            blobSize, blobSize,
            0, 360*64);

    setColor(robotIDs[_robot->id].color2);
    XFillArc(display, doubleBuffer, graphics,
            _robot->x - blobSize/2.0 - blobSize*0.7, _robot->y - blobSize/2 + blobSize,
            blobSize, blobSize,
            0, 360*64);
    setColor(robotIDs[_robot->id].color3);
    XFillArc(display, doubleBuffer, graphics,
            _robot->x - blobSize/2.0 + blobSize*0.7, _robot->y - blobSize/2 + blobSize,
            blobSize, blobSize,
            0, 360*64);
}

void drawRobots()
{
    for(int i = 0; i < TEAM_SIZE; ++i)
    {

        drawRobot(&teamBlue[i]);
        updateRobot(&teamBlue[i], i);

        drawRobot(&teamYellow[i]);
        updateRobot(&teamYellow[i], i);
    }
}

int main ()
{
    // open the display (connect to the X server)
    display = XOpenDisplay(getenv("DISPLAY"));
    // get the root window
    window = DefaultRootWindow(display);
    // create a GC for drawing in the window
    graphics = XCreateGC(display, window, 0, NULL);
    XSetLineAttributes(display, graphics, 10, LineSolid, CapProjecting,
                       JoinRound);

    // set foreground color
    XSetForeground(display, graphics, WhitePixelOfScreen(DefaultScreenOfDisplay(display)));

    // get attributes of the root window
    XGetWindowAttributes(display, window, &windowAtt);
    doubleBuffer = XCreatePixmap(display, window, windowAtt.width,
                                 windowAtt.height, windowAtt.depth);

    // read the image
    XImage *robofeiImg, *clipMask;
    Pixmap pix;
    if(XpmCreateImageFromData(display, robofei, &robofeiImg, &clipMask, NULL))
    {
        printf("Error reading image\n");
        exit(1);
    }
    // copy the transparent image into the pixmap
    pix = XCreatePixmap(display, doubleBuffer, clipMask->width, clipMask->height, clipMask->depth);
    gc = XCreateGC (display, pix, 0, NULL);
    XPutImage(display, pix, gc, clipMask, 0, 0, 0, 0, clipMask->width, clipMask->height);

    // allocate colors
    for(int c = 0; c < NCOLORS; c++)
    {
        XColor xc, sc;
        XAllocNamedColor(display,
                DefaultColormapOfScreen(DefaultScreenOfDisplay(display)),
                colorNames[c], &sc, &xc);
        colors[c] = sc;
    }

    initRobots();

    // draw something
    while(1)
    {
        drawField();
        drawBall();
        drawRobots();

        XSetClipMask(display, graphics, pix);
        XSetClipOrigin(display, graphics, 0, 0);
        XPutImage(display, doubleBuffer, graphics, robofeiImg, 0, 0,
                0, 0, robofeiImg->width, robofeiImg->height);
        XSetClipMask(display, graphics, None);


        // flush changes and sleep
        XCopyArea(display, doubleBuffer, window, graphics, 0, 0,
                  windowAtt.width, windowAtt.height, 0, 0);
        XFlush(display);
        // 60 FPS
        usleep(1000000/60);
    }

    XCloseDisplay(display);
}
